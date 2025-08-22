Return-Path: <linux-kselftest+bounces-39770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1F4B32540
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 01:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73228B02F9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7C82C2ABF;
	Fri, 22 Aug 2025 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRXt+UUD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB732797AC;
	Fri, 22 Aug 2025 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755903606; cv=none; b=FjktOheJ4UiGJ3VIyDMn5SW+5FlC8z6CIZ4iVSu+7nwKyZMOpH4h2UK5dFxmxQMckH6jiNLYACe/L6mvn2hU9NuVkiofSghB/MgXy9M1SMhsRjymAvcyk7zkV5PmCzY6jQzU/QkA2/Tg+BE8bmzjOwxONVltyiIG3B/7Z4WvCoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755903606; c=relaxed/simple;
	bh=RQBTAWa7/zZaMjjOVogsk1LWK3BF/Y6qUKRtHaI40VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLnFHKStSqelOfSXxsFn/veAzrVDcLypVich8hNRLqm01Z0aB96/QgbzO1jrLEfSxVmIYxSCTPHH/pN3HVViIc2SoZxxZ7e6wFndtd++v5r0o7DN/LXlHxQd5fPrI46DbZFmFrMAwzKNVGc6voimyWNV0zG1IRVuz3ZheIHrg/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRXt+UUD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32326e09f58so3026009a91.2;
        Fri, 22 Aug 2025 16:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755903604; x=1756508404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRqBILFh71E6oZk7P8W+ymw5GiuNqA07nCiBpT2091M=;
        b=VRXt+UUDeVHIQAvxcf66b1rGB2O44cIn6vdMmIg6f2/B7vBT+ga03DWHeaEmd/sZWM
         Chp8AjDBQdtSmKHEQjupeWJRs78WntG+hbPHJFVmlT2IwUs6IxzZnQ4ap259C/zZ+QI6
         4cimKrjdo6ddL/PmU1yCRN2cL1XfFH6Jp9/caGtUGcGAHdb4Lq1T5bMHqSr23lrsDoFX
         YMLWNi+aeBsfOajYe5ZIGbo8BdlUiSArnkp5XcG/DfvJndl07/K1J6AZIC/6WuUnKw2p
         d5KJDV5bN7osCnMhOx+4Fc8WTUfuL/pgQqkQRYCM/42X1odtifQyb3blwpMltlcbl4RD
         Ab4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755903604; x=1756508404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRqBILFh71E6oZk7P8W+ymw5GiuNqA07nCiBpT2091M=;
        b=tXd+rebQC/8/RgSaR+Q65aXawe0bD60MpHh4gGlmY//77a+X305uNnF1eo+jmisEJn
         88MsoxB8IF8OSpofLFNxbqWt87W6X9krlmgUxbRmmTkz810itsmPXmBArQztVh29oaeK
         l6ZYZ0o1+8/k7pxGQY1ViMdnqVZfd2tfLmFZdsXJoFnnkTyZ1ADrgQe2XJSXTbUUicl0
         Js0/cNC/KrzXn/rhk0DuF0mNvASJYrX48bsOvpTAAyvC1oY7jjuWPYaKMLdavC9grZCh
         c3667iwy8HfwGyezx1bWGoBv4Ml0Zj20jJgheB5qrFZf+nU8xJxujZWnJiw0SFgLqkpU
         e92g==
X-Forwarded-Encrypted: i=1; AJvYcCUdQ9ibWUn7C/w28yvQzy0Pc4/oR3Zpa3AkNgtdSQ8QoR5QeeESye2oo9J4KRkVXW76WcE=@vger.kernel.org, AJvYcCVj+tBk7Gq0jNJrNUVvsePNYzwmHgt0DW2iXQgD2A6F3XQQYcvP0qOKY9JfrJyAXcM6tT7FMLYBHmKcZgrP@vger.kernel.org, AJvYcCWa1etsdPfqSRJLgT7egAtIo5ClQIEZ0+sE3aW2v2GPqJZVW14tNIIG049rOR5R2fnQLc+IRkmbMolE9Q+l4SsS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3X6sujxo9YBZEicYuMt23LaXZ2FRUmecGNx/vmDxcrQvXRH8m
	Y1G0K9utyDyfa3cBOUmTRTBikOQI/5r2OXIntB/6/sCXjnn/2Hk6lD2ydQ18XY28T5+ZYSCCFRn
	fRr0rl+bErZpM+nQkPtckWwm8tau0ze0=
X-Gm-Gg: ASbGnculShRdmH03htD7vzbDwcz0TjJqGpRkxBkN5f988b5LYH8MOameQfqasnauSpp
	uFGKwR7U0HKWErIQxhKpVluht7AdQZmWE4pVtEPV3wC4pqtJ5etAltfjb8yD/krtV2/VCe+w9K6
	ijnZHe0dnVICx0NswopswCwjM6O4W+EzZNe897wpvm8FYmXgx1yKLoQMvSv/qLgLx9bkyviRqLE
	iiNY5jxdhw7lZHbyTODZLCL0lBWK7cc0w==
X-Google-Smtp-Source: AGHT+IEF+kXC47NlAMlK1pq6XMLjE4SA8r/ZFICtp5MSHTu7pEKM+rrHug9J0RXy7qJ6gZvU7YCQJCkSJ8mEOtItIFE=
X-Received: by 2002:a17:90b:3948:b0:325:46f4:4f6e with SMTP id
 98e67ed59e1d1-32546f450b5mr2234589a91.32.1755903603906; Fri, 22 Aug 2025
 16:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822151611.1084244-1-phoenix500526@163.com> <20250822151611.1084244-3-phoenix500526@163.com>
In-Reply-To: <20250822151611.1084244-3-phoenix500526@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Aug 2025 15:59:49 -0700
X-Gm-Features: Ac12FXzQSS_BEQWkLsyqK8iVyXo8TDRMoInI6GshC7OmqgArfuJspIFfHAMvXkg
Message-ID: <CAEf4Bzbs3hV_Q47+d93tTX13WkrpkpOb4=U04mZCjHyZg4aVdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v13 2/2] selftests/bpf: Enrich subtest_basic_usdt
 case in selftests to cover SIB handling logic
To: Jiawei Zhao <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 8:16=E2=80=AFAM Jiawei Zhao <phoenix500526@163.com>=
 wrote:
>
> When using GCC on x86-64 to compile an usdt prog with -O1 or higher
> optimization, the compiler will generate SIB addressing mode for global
> array and PC-relative addressing mode for global variable,
> e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".
>
> In this patch:
> - enrich subtest_basic_usdt test case to cover SIB addressing usdt argume=
nt spec
>   handling logic
>
> Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 44 ++++++++++++++++++-
>  tools/testing/selftests/bpf/progs/test_usdt.c | 30 +++++++++++++
>  2 files changed, 72 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
> index 9057e983cc54..c04b416aa4a8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -25,6 +25,10 @@ unsigned short test_usdt0_semaphore SEC(".probes");
>  unsigned short test_usdt3_semaphore SEC(".probes");
>  unsigned short test_usdt12_semaphore SEC(".probes");
>
> +#if ((defined(__x86_64__) || defined(__i386__)) && defined(__GNUC__) && =
!defined(__clang__))

does clang define __GNUC__ as well? otherwise why !define(__clang__) ?

> +unsigned short test_usdt_sib_semaphore SEC(".probes");
> +#endif
> +
>  static void __always_inline trigger_func(int x) {
>         long y =3D 42;
>
> @@ -40,12 +44,29 @@ static void __always_inline trigger_func(int x) {
>         }
>  }
>
> +#if ((defined(__x86_64__) || defined(__i386__)) && defined(__GNUC__) && =
!defined(__clang__))
> +static __attribute__((optimize("O1"))) void trigger_sib_spec(void)

you use assembly directly, so optimize() should be irrelevant, no?

So we can make this non-GCC specific, right?

> +{
> +       /* Base address + offset + (index * scale) */
> +       /* Force SIB addressing with inline assembly */
> +       asm volatile(
> +               "# probe point with memory access\n"
> +               STAP_PROBE_ASM(test, usdt_sib, -2@(%%rdx,%%rax,2))

is it guaranteed that nums address will end up in rdx and a in rax?...

I'd feel more comfortable if you explicitly set up rdx and rax in
assembly, then add USDT with STAP_PROBE_ASM. That should be possible
with embedded assembly, no?

> +               "# end probe point"

why these unnecessary comments embedded in the assembly?...

> +               :
> +               : "d"(nums), "a"(0)
> +               : "memory"
> +       );
> +}

[...]

> +
> +int usdt_sib_called;
> +u64 usdt_sib_cookie;
> +int usdt_sib_arg_cnt;
> +int usdt_sib_arg_ret;
> +u64 usdt_sib_arg;
> +int usdt_sib_arg_size;
> +
> +// Note: usdt_sib is only tested on x86-related architectures, so it req=
uires
> +// manual attach since auto-attach will panic tests under other architec=
tures

don't use c++ style comments

> +SEC("usdt")
> +int usdt_sib(struct pt_regs *ctx)
> +{
> +       long tmp;
> +
> +       if (my_pid !=3D (bpf_get_current_pid_tgid() >> 32))
> +               return 0;
> +
> +       __sync_fetch_and_add(&usdt_sib_called, 1);
> +
> +       usdt_sib_cookie =3D bpf_usdt_cookie(ctx);
> +       usdt_sib_arg_cnt =3D bpf_usdt_arg_cnt(ctx);
> +
> +       usdt_sib_arg_ret =3D bpf_usdt_arg(ctx, 0, &tmp);
> +       usdt_sib_arg =3D (short)tmp;
> +       usdt_sib_arg_size =3D bpf_usdt_arg_size(ctx, 0);
> +
> +       return 0;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.43.0
>

