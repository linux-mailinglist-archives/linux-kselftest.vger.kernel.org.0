Return-Path: <linux-kselftest+bounces-13326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C577792A953
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 20:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463491F223E8
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 18:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9954E14BF8A;
	Mon,  8 Jul 2024 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKRN0+rE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3714A4F0;
	Mon,  8 Jul 2024 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464881; cv=none; b=E8mfdTzv+XYGAQ3sKFtQe/iW/N6iEd+MDD4ISttu49wdAhZ42fcq4vBJiuMvUeBpnD4zqsrbfAypBmjI0Ncm8hRC7ILlNpNoXEE7pxK4t4huu0VMt+SMDRfbmymO4R03CWqZ/UrLcDA62ti0NrneyZ7uYdEynYZ0JDCk3ZxdfxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464881; c=relaxed/simple;
	bh=Xx51mPWZcvEBBTllJzV009BtwFSB9kOfHDyQY9GFL3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tj1Lr0IY7JHRkBN3t2EhYxi6pmZ9CnoIpKbkaaqzw3NQFodmBeMYuuKGNKIGi8nSZKJuiNttJsPKIxB3lLSGIMBISgJZgLlYhOzRo5Y77fk13OV/UG7PCA0mMWskwJfHWdp9R3xuL390EMEL0l531FVnaPxcrehHIYhCCtcqQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKRN0+rE; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25d6dd59170so1949805fac.0;
        Mon, 08 Jul 2024 11:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720464879; x=1721069679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrwrSZNvMGAoriYueRi/WdIWR5G3OphAy9AZ4DSwL1g=;
        b=OKRN0+rEzuVPKREAU++/jgm7YhfX1WzkwX9X0VGJ+A2CW+Qy+98cumf7wOoTufYAfy
         m8zCG+f0QuHe0Q+BM1uNRaljWYiU4s1qX6WvAIO9EFGgMVbzt469gFz1B2UNku0S7Tef
         7zbUzSam7icDPqH9Bd92h+nfao46jWmcGoRChqP0QLLNvRMuYt6cGdvIf01BbTB7/8bF
         Ao2gpLIM4q0cSeCb/RH62wN9Td/GOLNYBsXjUKlOjtTUSr+3yZtE7/32XdTChGPaCQVo
         r/wzNCB/NLBqzbSFYcvb3cDFFsHby03Kdlz87PzpkrF5QNHcxam8LW6ZvcpKHH1YATt6
         F4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720464879; x=1721069679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrwrSZNvMGAoriYueRi/WdIWR5G3OphAy9AZ4DSwL1g=;
        b=EPrxJuBHOzM7HH6I3MgaVjTQEe7EwReCEAAUk6x4orYZWEl8rxVS6sNKPHGDA9AZFJ
         P51y1zCoM0HM1+wTV/6VvD4EWQKF5oWMnbLNCZDjWt+4R5PYNCqnfV+EPK0whOs2dOLd
         ynEDG7lt0DTOuUQPQ70ejS0NIS8kgoPKF4ksXR46FwnL/U/BBXRtHjhlVNa8bzDdyyLB
         AH6CW9pCJHxAkQmo6yY6D1QbyIEAfAZU3Nz1BETvlOCiXtWM0TJaqrusbpTm2Fdj9LRL
         weIjAHSGaLwTEqGkOmhB1F9dHt1Uo0OgHPwQwCwFCdfAUJPaJMm9aJwnnta0lhv+Cplt
         slNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmDAuqL/WO+3EjblXWhzloCxEwFgT0dk3YQOdZ6Tv4qN0cZAOcddneO2NZNqYdm3FmD4GQqs5rXvgpoefQFDLBzS/fu3usjVdrA5MIUlB8DdD0Asd6k/e/D3rcxiRJiZl3r0k7
X-Gm-Message-State: AOJu0YwqZdNfSMwBAU/7AKPnl4itkKEqzdcFjJeyI5t/N6TU312sBs8l
	rNsibO8rKtXu9QvujI55hdLGHSXQmL8ML8O0fM54Yj3X195jDTQpBIrQkdClCz9C5lbXFziSuuz
	5KWllWjzLuTnBwK2OVyFqOHlKf4g=
X-Google-Smtp-Source: AGHT+IEgL46EF2dn+FdA01ybKVdNaS0i4+uzOs1JMWI/WcEC03yLfOeL6S3+rwEfWqBfebzSi6vfvhZ6pMRwViqGcEo=
X-Received: by 2002:a05:6871:294:b0:254:94a4:35e2 with SMTP id
 586e51a60fabf-25eaec980d0mr175364fac.59.1720464878633; Mon, 08 Jul 2024
 11:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720146231.git.tanggeliang@kylinos.cn> <f6773559686a553269d84870eb23142e2dc1dc8c.1720146231.git.tanggeliang@kylinos.cn>
In-Reply-To: <f6773559686a553269d84870eb23142e2dc1dc8c.1720146231.git.tanggeliang@kylinos.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 11:54:26 -0700
Message-ID: <CAEf4BzZ=df1LZrNh90UXURm0DOm1D12MkWKF+D6uTsiQG4rsDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] selftests/bpf: Skip ENOTSUPP in ASSERT_OK
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 7:38=E2=80=AFPM Geliang Tang <geliang@kernel.org> wr=
ote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Just like handling ENOTSUPP in test_lsm_cgroup_functional(), this patch
> adds a new helper test_progs_get_error() to check whether the input error
> is ENOTSUPP (524) or ENOTSUP (95). If it is, invoke test__skip() to skip
> the test instead of using test__fail().
>
> Use this helper in ASSERT_OK() before invoking CHECK() macro.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../selftests/bpf/prog_tests/lsm_cgroup.c     |  6 +----
>  tools/testing/selftests/bpf/test_progs.h      | 23 +++++++++++++++++--
>  2 files changed, 22 insertions(+), 7 deletions(-)
>

I haven't followed these patch sets, but no, let's not add magical
special error codes handling into ASSERT_xxx() macros.

> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/=
testing/selftests/bpf/prog_tests/lsm_cgroup.c
> index 6df25de8f080..6511f5f4a00f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> @@ -102,12 +102,8 @@ static void test_lsm_cgroup_functional(void)
>         ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"),=
 0, "prog count");
>         ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 0, "total prog count")=
;
>         err =3D bpf_prog_attach(alloc_prog_fd, cgroup_fd, BPF_LSM_CGROUP,=
 0);
> -       if (err =3D=3D -ENOTSUPP) {
> -               test__skip();
> -               goto close_cgroup;
> -       }
>         if (!ASSERT_OK(err, "attach alloc_prog_fd"))
> -               goto detach_cgroup;
> +               goto close_cgroup;
>         ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"),=
 1, "prog count");
>         ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 1, "total prog count")=
;
>
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
> index 930a4181dbd9..d1d77785b165 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -176,6 +176,23 @@ void test__skip(void);
>  void test__fail(void);
>  int test__join_cgroup(const char *path);
>
> +static inline bool test_progs_check_errno(int error, int check)
> +{
> +       return error =3D=3D -check ||
> +              (error && errno =3D=3D check);
> +}
> +
> +static inline int test_progs_get_error(int error)
> +{
> +       if (test_progs_check_errno(error, ENOTSUP) ||
> +           test_progs_check_errno(error, ENOTSUPP)) {
> +               test__skip();
> +               return 0;
> +       } else {
> +               return error;
> +       }
> +}
> +
>  #define PRINT_FAIL(format...)                                           =
       \
>         ({                                                               =
      \
>                 test__fail();                                            =
      \
> @@ -338,8 +355,10 @@ int test__join_cgroup(const char *path);
>         static int duration =3D 0;                                       =
 \
>         long long ___res =3D (res);                                      =
 \
>         bool ___ok =3D ___res =3D=3D 0;                                  =
     \
> -       CHECK(!___ok, (name), "unexpected error: %lld (errno %d)\n",    \
> -             ___res, errno);                                           \
> +       if (test_progs_get_error(___res))                               \
> +               CHECK(!___ok, (name),                                   \
> +                     "unexpected error: %lld (errno %d)\n",            \
> +                     ___res, errno);                                   \
>         ___ok;                                                          \
>  })
>
> --
> 2.43.0
>

