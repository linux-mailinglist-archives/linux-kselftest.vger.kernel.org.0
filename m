Return-Path: <linux-kselftest+bounces-46925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFE6C9D7DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 02:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 114984E504F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 01:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5FD221F39;
	Wed,  3 Dec 2025 01:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIIbAjoT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB3B2066F7
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724934; cv=none; b=eR8WAB1LqchObrAKjaUZDNAi++E9LljiBPH8caRY0y/LHQ3Ed2If20LFwHxc+D8VHnaSeUm9i6FTcBMfGJgasSjgiOvdQND0xL9wIzyUuYAiE94b2q8T/JmLs7zopJtGEdtmlyatX5herX5dyX01yQdVMa4b/wbgZ8E/zaGzku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724934; c=relaxed/simple;
	bh=/pMD5bWmHdRBvf4yKFtgHYmIt4rs553By1J0fnkw5HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3L+s/YHbmDi5AYne30Rn4xN43KZSEiPbe+F0kYz6hgqsG7lhsCfXVUrh8t880kwWT1mup4//VDY+H9LLp7/hy7Mn3JfC56PUqezxZd+3Kifgrx9ADDpHcdIS+zrpJwynNMztOvX/YO5bBML4WQ9Xz5r3fgAP+FT9x4ffhcg29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIIbAjoT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779a637712so38614285e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 17:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764724931; x=1765329731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+WY3aZ77NdSSZ7bHvGKcvVuNvrlczHOotCJwifC8BM=;
        b=jIIbAjoTnNabPceowEdVu+Qhgc4aryQp/owrk2DJLqSoQ4vl2FWuCRBdr/I+VIfUqZ
         4paBhBQWfEGJCPId+V5z/AP/UMS9IS/8SE2aRHljfs2IrIA/oTjuhMXktxX9BEYwoZbb
         2txtpBxaBEfX/6ROw5iAVVg2WfKMl88o7YmulAmeWC9yIPf2eK1cKbt3ouVlYS8YXkSH
         8GeISNAfMhA/qLIqAfnIsm6PLSR+5yjIISZj29FyXmFF3Qj+gQ1t2Ba6OaZXcGImRdLA
         U9Z6rOCma9eHdnKp+V+8GUeVqoDz90xs0Zorn1rJHLihlVKzFRcmCX13v5+3A1XZ58f/
         N5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764724931; x=1765329731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+WY3aZ77NdSSZ7bHvGKcvVuNvrlczHOotCJwifC8BM=;
        b=WHCulK6YCG7BuuGkRVrz1QhL9MHnucwJfxFBlkG4w6av08KcdrAY+urmIqrqaYAsQo
         zZLyoD9jlQK86TMnbhmRdogmrCm5YeM6qEHCfsVL5zBWxKlzLHCQ1xEB4M7tvmoo39F1
         7gZ1Bo7fRusgEMhAwDfWmnWbiWnBDsfT8HzE1aJ1V9YOagVlh/HELHbuPzO7XJ12rSKy
         MBt0GtUGAJfHmYpM6dnykxzUj5DS2TrdZRXrbVmzJZ1+2KGHZeEdf3fyq09h2V2/Uzi/
         UI+3KgcIhXlNEMlSKGlbF8kIv6zimstgGNpbJBNbOWgLYWs1fAStwVstUH9HmecaA+jI
         si/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDtYBtnImGN/eG2RBY2xVfnSsZMDBUK9kyA6ZnYBxS7YumDh4tI9E2vUNweqtgRwihiib/ffiqlT/TM+54usQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjigSt/PMRhyD2tbxAb7INgIE+75V2JNvjjnNKEN5kLifrQWSg
	1e+G8DDICozO07nmyDSEWsZQYvnqHhViCjOdECkSUsSC4WgtadYq2QiJWoJM2Yx64nvkzAE08F2
	gfJxcxJx53WKY/wXWUwbUf6YKCupWmjc=
X-Gm-Gg: ASbGncvZf5gRowqOrYtGzf6zZTuFH5DUdw1+O9uI3wYTBNPTKUe993qKr8Q51kbIR5q
	Qb2u390LcoSnyZseStXaR+Qs/mMod9ksnSOesS7RWebw6R3SdmtFHabU7q7Mu5KNIwFTHiQBNZ8
	AY1xvMf2M1SM1Vxs4ZeL0anzadlL59O0R2cxA1pOPOZjaz8mGPFtadWCA4eghVE5pNCxgquauw3
	qnpm4ooJFRJcs8YRnYlHHeXjoOhbREtBlNHiNSYKOhILuxh5y7lOy0myYYAPDpGkTL6ptRUDpfs
	p4ydKpJ3YtaBLemIgkbPM0nPkkUlN30uQPLhphg=
X-Google-Smtp-Source: AGHT+IEZPiDn6ShqkuIdilgas/r1CN9HX9hxB+EUwqJ2DZ9iEFPTR7ckrt5KLi2omsstyuSuQGr9BaixCvlkHpaFUos=
X-Received: by 2002:a5d:64c9:0:b0:429:d0b8:3850 with SMTP id
 ffacd0b85a97d-42f731f6a09mr291406f8f.48.1764724930681; Tue, 02 Dec 2025
 17:22:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202141944.2209-1-electronlsr@gmail.com> <20251202141944.2209-3-electronlsr@gmail.com>
In-Reply-To: <20251202141944.2209-3-electronlsr@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Dec 2025 17:21:59 -0800
X-Gm-Features: AWmQ_bmjDp76AGtK2oDFg7O2PT4muz01SgzrZrE4BlXdnWYrNXYeaoIKfF7ZsQk
Message-ID: <CAADnVQJQj=mdFbPf7nmc0+qZVC4RCK5AbJvNQv2W--tvGyzzVA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: fix and consolidate d_path LSM
 regression test
To: Shuran Liu <electronlsr@gmail.com>
Cc: Song Liu <song@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
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
>
> To avoid nondeterminism, the LSM program now filters based on the
> expected PID, which is populated from userspace before the test binary is
> executed. This prevents unrelated processes that also trigger the
> bprm_check_security LSM hook from overwriting test results. Parent and
> child processes are synchronized through a pipe to ensure the PID is set
> before the child execs the test binary.
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

No forks please. They often make selftest to be flaky.
Use simples possible way to test it.
Without forks and pipes.

pw-bot: cr

