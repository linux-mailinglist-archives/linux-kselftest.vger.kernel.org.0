Return-Path: <linux-kselftest+bounces-17327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708E096E44D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 22:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30071F253F8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 20:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FD71A3BB9;
	Thu,  5 Sep 2024 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI3IgQSQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203D8F54;
	Thu,  5 Sep 2024 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569051; cv=none; b=mkTU0jAqTdK0b2ez1i5gTt/wktPqpXfWmC50IjrkzC/roOJZv0hzQNiHkk7k3B7IR2W0Ki9wXgoujwgreGsEAkaTTlODRabDEpahtg55/SEUaI5HVoVwL934bmFxK75p/UCWkHeu82mWY+5seDIiCnPJjHz6WMrezDcVL8MrL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569051; c=relaxed/simple;
	bh=3rJNT9yg+z+QcOdLEJTgKV0TcguCAZp6aTixoFx78AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYvVOomvMAl6s9wyjuZyYM0ApEuKggNfaXeOEp/5KP5YleD4ZOaw52kcyFB+QToIIs3rRB7TIWMYvanl6qrJPJsRViI9HlB16fSMvE+J8YZvkHAddHZFOXEC6CihhSCX8CPTZPICASjnvcxwy5rvST2mC9mPwJJeZbHSBSWma24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI3IgQSQ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d5f5d8cc01so911695a91.0;
        Thu, 05 Sep 2024 13:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725569048; x=1726173848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPKe08+V1FP3IHc2YDb98I0r8elkRWzKft8u6NdvGYk=;
        b=iI3IgQSQUGMIHE3Bcm6vK2qFG+RispMir6G5eoxsKQQ29OL6YpjX38rIumgE7rYoN7
         4rKKqSZHRDF2NRNdW/tcYjLPwJtulYQ/x9dRUNZhllCHLVTgWbqRt1EwPhdYDDroDeqI
         d+7PBYq6U3IlfKyqRqvSbojOVMa3B5A/2GEkSEySF9kz7mP+fpfInKuO1DBaqfuNyoLB
         sZyhWcBzV/n58R9ERkE0b+ydGEIdL/1AEI0Jb3NKzXJHxL2xE3KnnKhVhrrlyPTHv+m3
         zfVTgMlUAn/Ke3mFlGQ+ytqgur22ris2YqWjFEum9xnrZMMsEHFCZ5AVyciztFJH+IhE
         7GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725569048; x=1726173848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPKe08+V1FP3IHc2YDb98I0r8elkRWzKft8u6NdvGYk=;
        b=b619s1xCorsKLS1fB/JOvnkdFKkgadbCJKMCsSM4RQTtsQ5CRHIvWkD1AhCSCMN+sT
         XD+7v4kV+ZdhC/yejTosfKwk0Tx8k2XP1LGofFc7+2Il4yzvXTqvYKxdxzdZBRbRkTPl
         KsQnpVR4D9X14njkOAO9Y5Q9CI3oYcspUamGEGs7gqB38SD6Mn5XMWZjYU/TsdX54yqe
         f1uWykEcq4455DlL6Y3QzuuGmN2Zq5j693LldkQL9IlGwUXJwOe9Rb00sZAHDK8y7flN
         6LgIrZeZ5WkwCYgLYK/tviMmp0CZFknkcPTzHLFH9a3fTeW7GErttAxkAR1Cii4cLpYf
         bpPw==
X-Forwarded-Encrypted: i=1; AJvYcCXHfdRB75juyaI54/DPfpS6rgmRQ4NQcuFmm799gpVcK91/f3T/adDTIGn13FiFZ3Xtuh9kZZ+yRjmNtrAFNJf7@vger.kernel.org, AJvYcCXLRSnkLCVG8G+VcPgxiWzGOj7O4yATiujgyJLf1XHC3ZswrfqtZoLFESpgg0mMHKnIWvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysi/FrbXj0dA17ubR1rY954BIEUNeL1qc9GOkTby1/aF9lW/5M
	3twwdA9MM/Tggy8vvAIEemoFv6Et1mbi4omw0gMkVuyqmx+7OX8jmE3eWJlSK7L1h2kpPVsHBiP
	1uzINunxRrAtBHkq9zWnrOK7Yk6s=
X-Google-Smtp-Source: AGHT+IH+peWAUrkc2n37mtFghO6oFgGFdJUiCLaC3PJT3IG/WBnLvU/VL2SgfuH12WVB8IRaTzw427fHqIJpjDLg3lE=
X-Received: by 2002:a17:90a:6f85:b0:2d8:e6d8:14c8 with SMTP id
 98e67ed59e1d1-2dad511c4demr799596a91.15.1725569048481; Thu, 05 Sep 2024
 13:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904115510.67480-1-chenyuan_fl@163.com>
In-Reply-To: <20240904115510.67480-1-chenyuan_fl@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Sep 2024 13:43:56 -0700
Message-ID: <CAEf4Bzbjt5xbxLXbY9UkbuCwN3Gzu8v-QuREoa6Uj8FrxvRAQQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Add valid flag to bpf_cookie selftest's res
To: Yuan Chen <chenyuan_fl@163.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 9:10=E2=80=AFPM Yuan Chen <chenyuan_fl@163.com> wrot=
e:
>
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> This patch identifies whether a test item is valid by adding a valid flag=
 to res.
>
> When we test the bpf_cookies/perf_event sub-test item of test_progs, ther=
e is a
> probability failure of the test item. In fact, this is not a problem, bec=
ause
> the corresponding perf event is not collected. This should not output the=
 test
> failure, and it is more reasonable to output SKIP. Therefore, add a valid
> identifier to res to distinguish whether the test item is valid, and skip=
 the
> test item if it is invalid.
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  .../testing/selftests/bpf/prog_tests/bpf_cookie.c | 15 +++++++++++++++
>  .../testing/selftests/bpf/progs/test_bpf_cookie.c |  2 ++
>  2 files changed, 17 insertions(+)
>

I'm not following the proposal. We expect BPF program to fire, and if
it fires, then we should get a valid BPF cookie value. If perf event
didn't fire, then it's flakiness in the test setup, but adding this
SKIP behavior for such a case is just papering over the real issue,
no?

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_cookie.c
> index 070c52c312e5..e5bf4b385501 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -456,6 +456,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>         if (!ASSERT_GE(pfd, 0, "perf_fd"))
>                 goto cleanup;
>
> +       skel->bss->res_valid =3D false;
>         opts.bpf_cookie =3D 0x100000;
>         link =3D bpf_program__attach_perf_event_opts(skel->progs.handle_p=
e, pfd, &opts);
>         if (!ASSERT_OK_PTR(link, "link1"))
> @@ -463,6 +464,12 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>
>         burn_cpu(); /* trigger BPF prog */
>
> +       if (!skel->bss->res_valid) {
> +               printf("%s:SKIP:the corresponding perf event was not samp=
led.\n",
> +                       __func__);
> +               test__skip();
> +               goto cleanup;
> +       }
>         ASSERT_EQ(skel->bss->pe_res, 0x100000, "pe_res1");
>
>         /* prevent bpf_link__destroy() closing pfd itself */
> @@ -474,6 +481,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>         link =3D NULL;
>         kern_sync_rcu();
>         skel->bss->pe_res =3D 0;
> +       skel->bss->res_valid =3D false;
>
>         opts.bpf_cookie =3D 0x200000;
>         link =3D bpf_program__attach_perf_event_opts(skel->progs.handle_p=
e, pfd, &opts);
> @@ -482,6 +490,13 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>
>         burn_cpu(); /* trigger BPF prog */
>
> +       if (!skel->bss->res_valid) {
> +               printf("%s:SKIP:the corresponding perf event was not samp=
led.\n",
> +                       __func__);
> +               test__skip();
> +               goto cleanup;
> +       }
> +
>         ASSERT_EQ(skel->bss->pe_res, 0x200000, "pe_res2");
>
>  cleanup:
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c b/tools/=
testing/selftests/bpf/progs/test_bpf_cookie.c
> index c83142b55f47..28d0ae6810d9 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
> @@ -7,6 +7,7 @@
>  #include <errno.h>
>
>  int my_tid;
> +bool res_valid;
>
>  __u64 kprobe_res;
>  __u64 kprobe_multi_res;
> @@ -27,6 +28,7 @@ static void update(void *ctx, __u64 *res)
>         if (my_tid !=3D (u32)bpf_get_current_pid_tgid())
>                 return;
>
> +       res_valid =3D true;
>         *res |=3D bpf_get_attach_cookie(ctx);
>  }
>
> --
> 2.46.0
>

