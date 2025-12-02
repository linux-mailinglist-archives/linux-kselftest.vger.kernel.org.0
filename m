Return-Path: <linux-kselftest+bounces-46903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7BAC9CAA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 19:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1401D3A175C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 18:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12072C326B;
	Tue,  2 Dec 2025 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR6zjH4I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1082C0F7E
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764700759; cv=none; b=W+H3eufi+Xw0xndcANEo0G5PykepTma8NsDTEw13bs4goUWBIIWvs4kmxi89ASd3IVkDZHhZ4bXlS1Rws3+F9mDGBeAjYgqlAB9JDQjCkjTRUvcZIDxhxOc90HpzHD4Uf2Z2crNiXzk0GgcpsNBjTCGZjIF8AtUzmYsZlviaD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764700759; c=relaxed/simple;
	bh=NarFwfdOUx1r8tMxSWM3oCoFBOaud6nyVOUYyHiIAk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFiy2wI5sno8Bwy+v2mHI8PaeLaDnozNNlBaQFi+wp88kTgF3bhExB1t1UPpJ0n9MKAL40th8bfvneQbJze3weiOEGmhKnke4ZxEKFtFfV1pCUeBSZvJ+UTpGn2oDXV49LYwSLxY3Dxi3NDYBq5z4Wbr6vB2WevTGZo5uJoeRlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR6zjH4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6B1C2BCAF
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764700759;
	bh=NarFwfdOUx1r8tMxSWM3oCoFBOaud6nyVOUYyHiIAk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IR6zjH4IBjKx94hKooRWAa16+08CpmljD2+TOiBcrtZMjhF3LYj65z9IZWNzGPjYT
	 huMuW/s3Il/VbkRS0HeewDb32zYeL1+tQllq8s/cSEAcEt5aH40KsFZBCTwsNwa6yK
	 pjugVrural2UcCOKXncuvvrLoEJAxIoRIJsL21UgVWy8VGFkUH+oCy4SEu81HpuxIF
	 qm7BNBh/sYpya5+55pd0HMcJVZT/TSWsOYdCJqa90DlHo4Fh/RcbLxdHol5MmektgD
	 KM58nMivZ2YQoE9hsIFxtZbZ97BHJCs/FQl2iw9oNBooConFxBAget8Y8fKyIlg5fV
	 IYUoJRmPSKumA==
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed9c19248bso49299511cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 10:39:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGKmjGKi8F3GWitMm0rRX3jPXfUvl5xpDOkAFnEQ5w5+syVsxlllJ25TtainlbesMCAGAPPAZSSpuBlaO1uyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRcWbqu2WDoYXjvMxusSKokTD42l60KIGYk9XFVQP2VrNxf/lx
	Igb9ESg7Y2zngs/iTABf0gKpLXC3XGarC2P6bUwR20IjglBn/s5C/uIZHvf3WQAUkJ6ekJouMqK
	bfmAEsKDuy2YxhoBBp5+QK7jNTqBdvzk=
X-Google-Smtp-Source: AGHT+IHhbCn+TTOAJLh9WzTfONoJ1GBmAu7YoMOxTXbUzIFPofSjaLBl/gPoHpmvPol7KmCE+Idv2oLSPyU99bnuq1k=
X-Received: by 2002:a05:622a:1108:b0:4ee:18e7:c4de with SMTP id
 d75a77b69052e-4ee589423camr660571871cf.78.1764700758338; Tue, 02 Dec 2025
 10:39:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202141944.2209-1-electronlsr@gmail.com> <20251202141944.2209-3-electronlsr@gmail.com>
In-Reply-To: <20251202141944.2209-3-electronlsr@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 2 Dec 2025 10:39:06 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6hmKjJF5gYvp=9Jue2N6oW8-Mj-LdFbGnQVwW1bTB=qg@mail.gmail.com>
X-Gm-Features: AWmQ_bmhtewh3Kki7Aq1wOtsV8Cr2mT_pAmwWnBYRYrtsqgtHIZ3VYu3xo1z0z8
Message-ID: <CAPhsuW6hmKjJF5gYvp=9Jue2N6oW8-Mj-LdFbGnQVwW1bTB=qg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: fix and consolidate d_path LSM
 regression test
To: Shuran Liu <electronlsr@gmail.com>
Cc: mattbobrowski@google.com, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	dxu@dxuuu.xyz, linux-kselftest@vger.kernel.org, shuah@kernel.org, 
	Zesen Liu <ftyg@live.com>, Peili Gao <gplhust955@gmail.com>, Haoran Ni <haoran.ni.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 6:20=E2=80=AFAM Shuran Liu <electronlsr@gmail.com> w=
rote:
>
> Add a regression test for bpf_d_path() when invoked from an LSM program.
> The test attaches to the bprm_check_security hook, calls bpf_d_path() on
> the binary being executed, and verifies that a simple prefix comparison o=
n
> the returned pathname behaves correctly after the fix in patch 1.

I don't get why we add this selftest here. It doesn't appear to be related =
to
patch 1/2.

>
> To avoid nondeterminism, the LSM program now filters based on the
> expected PID, which is populated from userspace before the test binary is
> executed. This prevents unrelated processes that also trigger the
> bprm_check_security LSM hook from overwriting test results. Parent and
> child processes are synchronized through a pipe to ensure the PID is set
> before the child execs the test binary.

The paragraph above is not really necessary. Just curious, did some AI
write it?

>
> Per review feedback, the new LSM coverage is merged into the existing
> d_path selftest rather than adding new prog_tests/ or progs/ files. The
> loop that checks the pathname prefix now uses bpf_for(), which is a
> verifier-friendly way to express a small, fixed-iteration loop, and the
> temporary /tmp/bpf_d_path_test binary is removed in the test cleanup
> path.
>
> Co-developed-by: Zesen Liu <ftyg@live.com>
> Signed-off-by: Zesen Liu <ftyg@live.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>
> Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  .../testing/selftests/bpf/prog_tests/d_path.c | 65 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/test_d_path.c | 33 ++++++++++
>  2 files changed, 98 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/test=
ing/selftests/bpf/prog_tests/d_path.c
> index ccc768592e66..202b44e6f482 100644
> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> @@ -195,6 +195,68 @@ static void test_d_path_check_types(void)
>         test_d_path_check_types__destroy(skel);
>  }
>
> +static void test_d_path_lsm(void)
> +{
> +       struct test_d_path *skel;
> +       int err;
> +       int pipefd[2];
> +       pid_t pid;
> +
> +       skel =3D test_d_path__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "d_path skeleton failed"))
> +               return;
> +
> +       err =3D test_d_path__attach(skel);
> +       if (!ASSERT_OK(err, "attach failed"))
> +               goto cleanup;
> +
> +       /* Prepare the test binary */
> +       system("cp /bin/true /tmp/bpf_d_path_test 2>/dev/null || :");
> +
> +       if (!ASSERT_OK(pipe(pipefd), "pipe failed"))
> +               goto cleanup;
> +
> +       pid =3D fork();
> +       if (!ASSERT_GE(pid, 0, "fork failed")) {
> +               close(pipefd[0]);
> +               close(pipefd[1]);
> +               goto cleanup;
> +       }
> +
> +       if (pid =3D=3D 0) {
> +               /* Child */
> +               char buf;
> +
> +               close(pipefd[1]);
> +               /* Wait for parent to set PID in BPF map */
> +               if (read(pipefd[0], &buf, 1) !=3D 1)
> +                       exit(1);
> +               close(pipefd[0]);
> +               execl("/tmp/bpf_d_path_test", "/tmp/bpf_d_path_test", NUL=
L);
> +               exit(1);
> +       }
> +
> +       /* Parent */
> +       close(pipefd[0]);
> +
> +       /* Update BPF map with child PID */
> +       skel->bss->my_pid =3D pid;
> +
> +       /* Signal child to proceed */
> +       write(pipefd[1], "G", 1);
> +       close(pipefd[1]);
> +
> +       /* Wait for child */
> +       waitpid(pid, NULL, 0);
> +
> +       ASSERT_EQ(skel->bss->called_lsm, 1, "lsm hook called");
> +       ASSERT_EQ(skel->bss->lsm_match, 1, "lsm match");
> +
> +cleanup:
> +       unlink("/tmp/bpf_d_path_test");
> +       test_d_path__destroy(skel);
> +}
> +
>  void test_d_path(void)
>  {
>         if (test__start_subtest("basic"))
> @@ -205,4 +267,7 @@ void test_d_path(void)
>
>         if (test__start_subtest("check_alloc_mem"))
>                 test_d_path_check_types();
> +
> +       if (test__start_subtest("lsm"))
> +               test_d_path_lsm();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/test=
ing/selftests/bpf/progs/test_d_path.c
> index 84e1f883f97b..9ae36eabcd07 100644
> --- a/tools/testing/selftests/bpf/progs/test_d_path.c
> +++ b/tools/testing/selftests/bpf/progs/test_d_path.c
> @@ -17,6 +17,8 @@ int rets_close[MAX_FILES] =3D {};
>
>  int called_stat =3D 0;
>  int called_close =3D 0;
> +int called_lsm =3D 0;
> +int lsm_match =3D 0;
>
>  SEC("fentry/security_inode_getattr")
>  int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
> @@ -62,4 +64,35 @@ int BPF_PROG(prog_close, struct file *file, void *id)
>         return 0;
>  }
>
> +SEC("lsm/bprm_check_security")
> +int BPF_PROG(prog_lsm, struct linux_binprm *bprm)
> +{
> +       pid_t pid =3D bpf_get_current_pid_tgid() >> 32;
> +       char path[MAX_PATH_LEN] =3D {};
> +       int ret;
> +
> +       if (pid !=3D my_pid)
> +               return 0;
> +
> +       called_lsm =3D 1;
> +       ret =3D bpf_d_path(&bprm->file->f_path, path, MAX_PATH_LEN);
> +       if (ret < 0)
> +               return 0;
> +
> +       {

This {} block is not necessary.

> +               static const char target_dir[] =3D "/tmp/";
> +               int i;
> +
> +               bpf_for(i, 0, sizeof(target_dir) - 1) {
> +                       if (path[i] !=3D target_dir[i]) {
> +                               lsm_match =3D -1; /* mismatch */
> +                               return 0;
> +                       }
> +               }
> +       }
> +
> +       lsm_match =3D 1; /* prefix match */
> +       return 0;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.52.0
>

