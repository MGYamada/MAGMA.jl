for (syevd, elty, relty) in    ((:ssyevd, :Float32, :Float32),
                            (:dsyevd, :Float64, :Float64)),
                            interface in (:Matrix, :CuMatrix)
    @eval begin
        function magma_syevd!(jobz::AbstractChar, uplo::AbstractChar, A::$interface{$elty})
            A = Matrix{$elty}(A)

            n = checksquare(A)
            lda     = max(1, stride(A, 2))
            W = similar(A, $relty, n)
            work = Vector{$elty}(undef, 1)
            lwork = -1
            iwork = Vector{Int32}(undef, 1)
            liwork = -1
            info    = Ref{Int}()

            jobz_magma      = char_to_magmaInt(jobz)
            uplo_magma     = char_to_magmaIntUplo(uplo)

            for i in 1:2
                func = eval(@magmafunc($syevd))
                func(
                    jobz_magma,
                    uplo_magma,
                    n,
                    A,
                    lda,
                    W,
                    work,
                    lwork,
                    iwork,
                    liwork,
                    info
                )

                if i == 1
                    lwork = ceil(Int, nextfloat(real(work[1])))
                    resize!(work, lwork)
                    liwork = Int(iwork[1])
                    resize!(iwork, liwork)
                end
            end

            jobz == 'V' ? (W, A) : W
        end

        function magma_syevd_m!(ngpu::Int, jobz::AbstractChar, uplo::AbstractChar, A::$interface{$elty})
            A = Matrix{$elty}(A)

            n = checksquare(A)
            lda     = max(1, stride(A, 2))
            W = similar(A, $relty, n)
            work = Vector{$elty}(undef, 1)
            lwork = -1
            iwork = Vector{Int32}(undef, 1)
            liwork = -1
            info    = Ref{Int}()

            jobz_magma      = char_to_magmaInt(jobz)
            uplo_magma     = char_to_magmaIntUplo(uplo)

            for i in 1:2
                func = eval(@magmafunc_m($syevd))
                func(
                    ngpu,
                    jobz_magma,
                    uplo_magma,
                    n,
                    A,
                    lda,
                    W,
                    work,
                    lwork,
                    iwork,
                    liwork,
                    info
                )

                if i == 1
                    lwork = ceil(Int, nextfloat(real(work[1])))
                    resize!(work, lwork)
                    liwork = Int(iwork[1])
                    resize!(iwork, liwork)
                end
            end

            jobz == 'V' ? (W, A) : W
        end
    end
end

for (syevd, elty, relty) in    ((:cheevd, :ComplexF32, :Float32),
                            (:zheevd, :ComplexF64, :Float64)),
                            interface in (:Matrix, :CuMatrix)
    @eval begin
        function magma_syevd!(jobz::AbstractChar, uplo::AbstractChar, A::$interface{$elty})
            A = Matrix{$elty}(A)

            n = checksquare(A)
            lda     = max(1, stride(A, 2))
            W = similar(A, $relty, n)
            work = Vector{$elty}(undef, 1)
            lwork = -1
            rwork = Vector{$relty}(undef, 1)
            lrwork = -1
            iwork = Vector{Int32}(undef, 1)
            liwork = -1
            info    = Ref{Int}()

            jobz_magma      = char_to_magmaInt(jobz)
            uplo_magma     = char_to_magmaIntUplo(uplo)

            for i in 1:2
                func = eval(@magmafunc($syevd))
                func(
                    jobz_magma,
                    uplo_magma,
                    n,
                    A,
                    lda,
                    W,
                    work,
                    lwork,
                    rwork.
                    lrwork,
                    iwork,
                    liwork,
                    info
                )

                if i == 1
                    lwork = ceil(Int, nextfloat(real(work[1])))
                    resize!(work, lwork)
                    lrwork = ceil(Int, nextfloat(real(rwork[1])))
                    resize!(rwork, lrwork)
                    liwork = Int(iwork[1])
                    resize!(iwork, liwork)
                end
            end

            jobz == 'V' ? (W, A) : W
        end

        function magma_syevd_m!(ngpu::Int, jobz::AbstractChar, uplo::AbstractChar, A::$interface{$elty})
            A = Matrix{$elty}(A)

            n = checksquare(A)
            lda     = max(1, stride(A, 2))
            W = similar(A, $relty, n)
            work = Vector{$elty}(undef, 1)
            lwork = -1
            rwork = Vector{$relty}(undef, 1)
            lrwork = -1
            iwork = Vector{Int32}(undef, 1)
            liwork = -1
            info    = Ref{Int}()

            jobz_magma      = char_to_magmaInt(jobz)
            uplo_magma     = char_to_magmaIntUplo(uplo)

            for i in 1:2
                func = eval(@magmafunc_m($syevd))
                func(
                    ngpu,
                    jobz_magma,
                    uplo_magma,
                    n,
                    A,
                    lda,
                    W,
                    work,
                    lwork,
                    rwork,
                    lrwork,
                    iwork,
                    liwork,
                    info
                )

                if i == 1
                    lwork = ceil(Int, nextfloat(real(work[1])))
                    resize!(work, lwork)
                    lrwork = ceil(Int, nextfloat(real(rwork[1])))
                    resize!(rwork, lrwork)
                    liwork = Int(iwork[1])
                    resize!(iwork, liwork)
                end
            end

            jobz == 'V' ? (W, A) : W
        end
    end
end