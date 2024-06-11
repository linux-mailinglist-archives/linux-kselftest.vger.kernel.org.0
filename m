Return-Path: <linux-kselftest+bounces-11644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F72902F82
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 06:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4D51C21AF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC53516FF23;
	Tue, 11 Jun 2024 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mrFkt3PF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554AE12FF65
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 04:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718080031; cv=none; b=QtS57b09/Ptkp4zIC8ZWz12smct+8JKd1swbx8mylbGDvtF4ovTWk8wWt/aTTRS1hCntTf84+xBkoGowrIJJz0splgVAXXgBeOabh252W6Dna57KUTT14i9iqg2C3eFkbxWUiXUsXeqdz5gDJjD1um2huvKjSiOKE1VbTZ97kIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718080031; c=relaxed/simple;
	bh=TthFiFrpcOTwjcjWnFwvN7lj9pJIycfnZg7Q1vqVT9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MS9iook5b66vC1px9/4n6PO5s9udT1vl21tQ0OzuBIRc3Um3tj/H2uuNHZ+AQw+ILEA5URWYf+aOhlTs74X2wvyatOCSbZbdpFtNtdb7jzleeinRYQtpl5Yfbsoz/dobCOO6+/mEct7HMxvds4X9TRBeYLoha8GpkY5qpkD4GxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mrFkt3PF; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ba70a0ed75so330240eaf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 21:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718080029; x=1718684829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvZm3Ca28/2854H04bb2+N9aiZyWs2w67vdjUbOwxNg=;
        b=mrFkt3PFrQa2Vw3E8XzbL6nXfHRe3y7BopKFLOhtkdD4fR9WLojJN5IJhjwWJamYSJ
         1nOyBvGm5q5ooCGhVOkfqr6jy6PfhJTEMM00kBLrsEsmEWNGMV/d7aqCth2BxptXxHgR
         XKM8EhxvgbWY8lqktbGpR7k5l3yDmv/4yFnc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718080029; x=1718684829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvZm3Ca28/2854H04bb2+N9aiZyWs2w67vdjUbOwxNg=;
        b=PLVwQPFuRDEqCrRzCOSMRF77cZa8FO5mUFFdm0UYryeSCUgCaP9yblcanxLVfTbghj
         l06EfUzpYSqE/7yIoFMNp9JYAavWYGPMYKV8e0HgYo72dWlD2m4Yev1ko82tBNGcZlTS
         9f4vcq/SfYmp5oQ7bdmzYdHjdMyyo2SMhK5cLNovreNhTPEe99KGkSpc8+fLr4W7GU1A
         3t5aS7hlwcTmDhHDKZpo7U8s7JcdiKutyPR8dSKvbHaiCt9NbT7AZcojUH3kRW7ThIam
         iygNn41ZPiahOz+DiJ4dFIV6AVaBQBKyUdYjtlO1qcvsfLQfvrxHqEVAR/lZNJi5uKUy
         0i7A==
X-Forwarded-Encrypted: i=1; AJvYcCXFmSqlMn+nk2S2tlqymMh446WXb4kHhHkVioeARUdlG8GOKVjz3yrvwqS5ZHEkAmNrv73Ly/u2gynJMVtotiFPUsaRNfMKOFW6LVYtk6/h
X-Gm-Message-State: AOJu0YzttbAshUM3WgXmLH9kzK6ymwgrrPk0/zdIpIRrkpIoF1t3Xz/6
	QjsYZXriTgVGXBnvXW4Ggp6sRCEltHc2VvGXljiGt+Z6U+Fp2tYJhlqRQ1/QzSw3WAOTiEzksnF
	+u+MHgLgA3HoKsojv2uCXSrlPvhLhuG7hbOr0
X-Google-Smtp-Source: AGHT+IEHXlLIFhQYjN5bCYmUB+rGPsv3daP0+lHThmdjwO1K/ZWlgc24sesZAaA6Age9DcYanbP55mAWe64frc0LaRQ=
X-Received: by 2002:a05:6870:89a4:b0:254:b1b1:7ea5 with SMTP id
 586e51a60fabf-254b1b18dc3mr7909032fac.37.1718080029420; Mon, 10 Jun 2024
 21:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608021023.176027-1-jhubbard@nvidia.com> <20240608021023.176027-5-jhubbard@nvidia.com>
In-Reply-To: <20240608021023.176027-5-jhubbard@nvidia.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 10 Jun 2024 21:26:58 -0700
Message-ID: <CABi2SkXXrcZgrzsQ7=W1hHJiKKPY=ypW2g+PW1apVuWAAG1Mvg@mail.gmail.com>
Subject: Re: [PATCH 4/5] selftests/mm: mseal, self_elf: factor out test macros
 and other duplicated items
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Andrei Vagin <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Peter Xu <peterx@redhat.com>, 
	Rich Felker <dalias@libc.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 7:10=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> Clean up and move some copy-pasted items into mseal_helpers.h.
>
> 1. The test macros can be made safer and simpler, by observing that they
> are invariably called when about to return. This means that the macros
> do not need an intrusive label to goto; they can simply return.
>
> 2. PKEY* items. We cannot, unfortunately use pkey-helpers.h. The best we
> can do is to factor out these few items into mseal_helpers.h.
>
> 3. These tests still need their own definition of u64, so also move that
> to the header file.
>
> Cc: Jeff Xu <jeffxu@chromium.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Jeff Xu <jeffxu@chromium.org>
Tested-by: Jeff Xu <jeffxu@chromium.org>

> ---
>  tools/testing/selftests/mm/mseal_helpers.h | 40 ++++++++++++++++++
>  tools/testing/selftests/mm/mseal_test.c    | 48 ----------------------
>  tools/testing/selftests/mm/seal_elf.c      | 32 ---------------
>  3 files changed, 40 insertions(+), 80 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/mseal_helpers.h b/tools/testing/s=
elftests/mm/mseal_helpers.h
> index b922d453a014..8c3bf77dcf19 100644
> --- a/tools/testing/selftests/mm/mseal_helpers.h
> +++ b/tools/testing/selftests/mm/mseal_helpers.h
> @@ -3,3 +3,43 @@
>  #ifndef __NR_mseal
>  #define __NR_mseal 462
>  #endif
> +
> +#define FAIL_TEST_IF_FALSE(test_passed)                                 =
       \
> +       do {                                                            \
> +               if (!(test_passed)) {                                   \
> +                       ksft_test_result_fail("%s: line:%d\n",          \
> +                                               __func__, __LINE__);    \
> +                       return;                                         \
> +               }                                                       \
> +       } while (0)
> +
> +#define SKIP_TEST_IF_FALSE(test_passed)                                 =
       \
> +       do {                                                            \
> +               if (!(test_passed)) {                                   \
> +                       ksft_test_result_skip("%s: line:%d\n",          \
> +                                               __func__, __LINE__);    \
> +                       return;                                         \
> +               }                                                       \
> +       } while (0)
> +
> +#define TEST_END_CHECK() ksft_test_result_pass("%s\n", __func__)
> +
> +#ifndef PKEY_DISABLE_ACCESS
> +#define PKEY_DISABLE_ACCESS    0x1
> +#endif
> +
> +#ifndef PKEY_DISABLE_WRITE
> +#define PKEY_DISABLE_WRITE     0x2
> +#endif
> +
> +#ifndef PKEY_BITS_PER_PKEY
> +#define PKEY_BITS_PER_PKEY     2
> +#endif
> +
> +#ifndef PKEY_MASK
> +#define PKEY_MASK      (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
> +#endif
> +
> +#ifndef u64
> +#define u64 unsigned long long
> +#endif
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/self=
tests/mm/mseal_test.c
> index 20949617a036..a29935d82027 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -19,54 +19,6 @@
>  #include <sys/stat.h>
>  #include "mseal_helpers.h"
>
> -/*
> - * need those definition for manually build using gcc.
> - * gcc -I ../../../../usr/include   -DDEBUG -O3  -DDEBUG -O3 mseal_test.=
c -o mseal_test
> - */
> -#ifndef PKEY_DISABLE_ACCESS
> -# define PKEY_DISABLE_ACCESS    0x1
> -#endif
> -
> -#ifndef PKEY_DISABLE_WRITE
> -# define PKEY_DISABLE_WRITE     0x2
> -#endif
> -
> -#ifndef PKEY_BITS_PER_PKEY
> -#define PKEY_BITS_PER_PKEY      2
> -#endif
> -
> -#ifndef PKEY_MASK
> -#define PKEY_MASK       (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
> -#endif
> -
> -#define FAIL_TEST_IF_FALSE(c) do {\
> -               if (!(c)) {\
> -                       ksft_test_result_fail("%s, line:%d\n", __func__, =
__LINE__);\
> -                       goto test_end;\
> -               } \
> -       } \
> -       while (0)
> -
> -#define SKIP_TEST_IF_FALSE(c) do {\
> -               if (!(c)) {\
> -                       ksft_test_result_skip("%s, line:%d\n", __func__, =
__LINE__);\
> -                       goto test_end;\
> -               } \
> -       } \
> -       while (0)
> -
> -
> -#define TEST_END_CHECK() {\
> -               ksft_test_result_pass("%s\n", __func__);\
> -               return;\
> -test_end:\
> -               return;\
> -}
> -
> -#ifndef u64
> -#define u64 unsigned long long
> -#endif
> -
>  static unsigned long get_vma_size(void *addr, int *prot)
>  {
>         FILE *maps;
> diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selfte=
sts/mm/seal_elf.c
> index 4053951a535c..0fd129259647 100644
> --- a/tools/testing/selftests/mm/seal_elf.c
> +++ b/tools/testing/selftests/mm/seal_elf.c
> @@ -18,38 +18,6 @@
>  #include <sys/stat.h>
>  #include "mseal_helpers.h"
>
> -/*
> - * need those definition for manually build using gcc.
> - * gcc -I ../../../../usr/include   -DDEBUG -O3  -DDEBUG -O3 seal_elf.c =
-o seal_elf
> - */
> -#define FAIL_TEST_IF_FALSE(c) do {\
> -               if (!(c)) {\
> -                       ksft_test_result_fail("%s, line:%d\n", __func__, =
__LINE__);\
> -                       goto test_end;\
> -               } \
> -       } \
> -       while (0)
> -
> -#define SKIP_TEST_IF_FALSE(c) do {\
> -               if (!(c)) {\
> -                       ksft_test_result_skip("%s, line:%d\n", __func__, =
__LINE__);\
> -                       goto test_end;\
> -               } \
> -       } \
> -       while (0)
> -
> -
> -#define TEST_END_CHECK() {\
> -               ksft_test_result_pass("%s\n", __func__);\
> -               return;\
> -test_end:\
> -               return;\
> -}
> -
> -#ifndef u64
> -#define u64 unsigned long long
> -#endif
> -
>  /*
>   * define sys_xyx to call syscall directly.
>   */
> --
> 2.45.2
>

