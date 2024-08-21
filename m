Return-Path: <linux-kselftest+bounces-15869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B256895A22C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E49B2845E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2801B250D;
	Wed, 21 Aug 2024 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RB20WyUJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CDB14E2D4
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255804; cv=none; b=AT5XZudpAKa7krCGW+3ko8zrnlSESufx3107uDOWRpXBMXy1htEbW6To41HDy3x0/daHMhAFSl2Raw/I1LJXGeTFtwOdr66zziEYjMJbRGURpPqJrGizXImRaxgmYj4Cm70Ytt2CqM/fTrhjNmY6nJNpnI18PHWhH7J/uZBGt5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255804; c=relaxed/simple;
	bh=xXqcbvTLnTkMm9IT388qxhkQek5JB4712AQnCSjCPOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLuLg4NoTcan4eVFhfB4UWhFPiuHMuDViSbVlAaQ8XWrWH0SOOSE96Zffjc/i7gC2dEZSxMmL9THOZ2zPlLJYcNDFlZ3nChgKHFHUr5/kVvI3l9UGQONkeJlzPdpq5ydCLCQioO2KUG1qXtWehTpnB3hb+D1M8MNh+wUkYdfLLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RB20WyUJ; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2709123e939so91634fac.2
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724255801; x=1724860601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4R0EpO3n6kf/aoNBWtHJ6eqC3Vmvm7kimMhDLs6BFo=;
        b=RB20WyUJsqOMFY+lI3X8y9jI103KCL1ta8pUfB2W97kQ+fvHob6a91brWublIisbK5
         pn4u2EwHLcdEVFpFqjbL8LKscBKG8xXpHEsjodR1e+/UIQvkTUkvY6Vih/husvkncd63
         zWVf1ijEZvWvjBrRFpxVHzWa0v8qYYtZEyAi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724255801; x=1724860601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4R0EpO3n6kf/aoNBWtHJ6eqC3Vmvm7kimMhDLs6BFo=;
        b=ZnUMDUAOmTxKyNHNg6SouCR1gng3d2SagmHaUj2iawHu0vojDgTbrL/aQMV5TmZvR9
         aW0fz813PBi8CIgEWc6J6DPAYTPxDJa2hTKphjNmW5saHo2Tp2x+cpvQXChDNXuF9hsk
         RWo3Br1l82muVGPtflXZ9NNYOlUJDYeSAxC63BmBaNKb5KJ8gGIAv5gi8Z8QJOl921zr
         Yozdr/aeAos1EKT8nJUkTvMq86QKnDioZmKMvN42Z2thZyF4WxtLPlOjBqVj8M4x+s3n
         j1EKHq+Kewa+GFo0iZ0dCdpZZd+Y33fgAHX2cxRQNN7y7T7SrBm4eeelh3cOB/ZGYb7C
         DI0w==
X-Forwarded-Encrypted: i=1; AJvYcCVzT80++r52pOBx1KmUEM4fG9F6kMU0DL2Ra9bt/vaJFoiDNP888TqI0wFv2/qbfyqlF3avkBserEhCvAC6iVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5oJQqi+z4I5XeZ+Rk18bv13CHPXrSGNlnXwR8my8Eq02XndT8
	k8Kshwd9gMxJsnV556z20pkKWUe8PCDMFOJfKyn/K0KtAMwHYuwprDRXNpg/nwjr97bpN9a5Nrx
	gOVYHGv6hggK+UqhS1pglF94z1/YNngsl5UCv
X-Google-Smtp-Source: AGHT+IHQrNsaqsPrV0SsczE2097vU/k5NSjxN5oNDCms/3WeUiXNWcDhOSFOSGYJUmNzaJQxram2qpwb0saZ4t1xuko=
X-Received: by 2002:a05:6870:5491:b0:260:e907:4646 with SMTP id
 586e51a60fabf-2737ef08cfamr1786607fac.4.1724255801237; Wed, 21 Aug 2024
 08:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com> <20240817-mseal-depessimize-v3-7-d8d2e037df30@gmail.com>
In-Reply-To: <20240817-mseal-depessimize-v3-7-d8d2e037df30@gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 21 Aug 2024 08:56:28 -0700
Message-ID: <CABi2SkWPiGJTv3FEPxD1OJYUAoePab8jG+CSd58UHqEsBeOYbA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] selftests/mm: add more mseal traversal tests
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro

On Fri, Aug 16, 2024 at 5:18=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> Add more mseal traversal tests across VMAs, where we could possibly
> screw up sealing checks. These test more across-vma traversal for
> mprotect, munmap and madvise. Particularly, we test for the case where a
> regular VMA is followed by a sealed VMA.
>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  tools/testing/selftests/mm/mseal_test.c | 111 ++++++++++++++++++++++++++=
+++++-
>  1 file changed, 110 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/self=
tests/mm/mseal_test.c
> index 259bef4945e9..0d4d40fb0f88 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -766,6 +766,42 @@ static void test_seal_mprotect_partial_mprotect(bool=
 seal)
>         REPORT_TEST_PASS();
>  }
>
> +static void test_seal_mprotect_partial_mprotect_tail(bool seal)
> +{
> +       void *ptr;
> +       unsigned long page_size =3D getpagesize();
> +       unsigned long size =3D 2 * page_size;
> +       int ret;
> +       int prot;
> +
> +       /*
> +        * Check if a partial mseal (that results in two vmas) works corr=
ectly.
> +        * It might mprotect the first, but it'll never touch the second =
(msealed) vma.
> +        */
> +
> +       setup_single_address(size, &ptr);
> +       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> +
> +       if (seal) {
> +               ret =3D sys_mseal(ptr + page_size, size);
you are allocating 2 pages , and I assume you are sealing the second
page, so the size should be page_size.
ret =3D sys_mseal(ptr + page_size, page_size);

> +               FAIL_TEST_IF_FALSE(!ret);
> +       }
> +
> +       ret =3D sys_mprotect(ptr, size, PROT_EXEC);
> +       if (seal)
> +               FAIL_TEST_IF_FALSE(ret < 0);
> +       else
> +               FAIL_TEST_IF_FALSE(!ret);
> +
> +       if (seal) {
> +               FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &prot) >=
 0);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
To test partial mprotect, the test needs to add the check for the
first page to be changed, Also to avoid the merge,  a PROT_NONE page
can to be added in front.

> +       }
> +
> +       REPORT_TEST_PASS();
> +}
> +
> +
>  static void test_seal_mprotect_two_vma_with_gap(bool seal)
>  {
>         void *ptr;
> @@ -983,6 +1019,41 @@ static void test_seal_munmap_vma_with_gap(bool seal=
)
>         REPORT_TEST_PASS();
>  }
>
> +static void test_seal_munmap_partial_across_vmas(bool seal)
> +{
> +       void *ptr;
> +       unsigned long page_size =3D getpagesize();
> +       unsigned long size =3D 2 * page_size;
> +       int ret;
> +       int prot;
> +
> +       /*
> +        * Check if a partial mseal (that results in two vmas) works corr=
ectly.
> +        * It might unmap the first, but it'll never unmap the second (ms=
ealed) vma.
> +        */
> +
> +       setup_single_address(size, &ptr);
> +       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> +
> +       if (seal) {
> +               ret =3D sys_mseal(ptr + page_size, size);
ret =3D sys_mseal(ptr + page_size, page_size);

> +               FAIL_TEST_IF_FALSE(!ret);
> +       }
> +
> +       ret =3D sys_munmap(ptr, size);
> +       if (seal)
> +               FAIL_TEST_IF_FALSE(ret < 0);
> +       else
> +               FAIL_TEST_IF_FALSE(!ret);
> +
> +       if (seal) {
> +               FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &prot) >=
 0);
> +               FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
To test partial unmap, the test needs to add the check for the first
page to be freed, Also to avoid the merge,  a PROT_NONE page needs to
be in front.

The test_seal_munmap_partial_across_vmas  shows the behavior
difference with in-loop approach and out-loop approach. Previously,
both VMAs will not be freed, now the first VMA will be freed, and the
second VMA (sealed) won't.

This brings to the line you previously mentioned: [1] and I quote:
"munmap is atomic and always has been. It's required by POSIX."

So this is no longer true for the current series.  Linux doesn't need
to be POSIX compliant, from previous conversation on this topic with
Linus [2], so I'm open to that. If this is accepted by Linus, it would
be better to add comments on munmap code or tests, for future readers
(in case they are curious about reasoning. )

[1] https://lore.kernel.org/linux-mm/CAKbZUD3_3KN4fAyQsD+=3Dp3PV8svAvVyS278=
umX40Ehsa+zkz3w@mail.gmail.com/
[2] https://lore.kernel.org/linux-mm/CAHk-=3DwgDv5vPx2xoxNQh+kbvLsskWubGGGK=
69cqF_i4FkM-GCw@mail.gmail.com/

> +       }
> +
> +       REPORT_TEST_PASS();
> +}
> +
>  static void test_munmap_start_freed(bool seal)
>  {
>         void *ptr;
> @@ -1735,6 +1806,37 @@ static void test_seal_discard_ro_anon(bool seal)
>         REPORT_TEST_PASS();
>  }
>
> +static void test_seal_discard_across_vmas(bool seal)
> +{
> +       void *ptr;
> +       unsigned long page_size =3D getpagesize();
> +       unsigned long size =3D 2 * page_size;
> +       int ret;
> +
> +       setup_single_address(size, &ptr);
> +       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> +
> +       if (seal) {
> +               ret =3D seal_single_address(ptr + page_size, page_size);
> +               FAIL_TEST_IF_FALSE(!ret);
> +       }
> +
> +       ret =3D sys_madvise(ptr, size, MADV_DONTNEED);
> +       if (seal)
> +               FAIL_TEST_IF_FALSE(ret < 0);
> +       else
> +               FAIL_TEST_IF_FALSE(!ret);
> +
> +       ret =3D sys_munmap(ptr, size);
> +       if (seal)
> +               FAIL_TEST_IF_FALSE(ret < 0);
> +       else
> +               FAIL_TEST_IF_FALSE(!ret);
> +
> +       REPORT_TEST_PASS();
> +}
> +
> +
>  static void test_seal_madvise_nodiscard(bool seal)
>  {
>         void *ptr;
> @@ -1779,7 +1881,7 @@ int main(int argc, char **argv)
>         if (!pkey_supported())
>                 ksft_print_msg("PKEY not supported\n");
>
> -       ksft_set_plan(82);
> +       ksft_set_plan(88);
>
>         test_seal_addseal();
>         test_seal_unmapped_start();
> @@ -1825,12 +1927,17 @@ int main(int argc, char **argv)
>         test_seal_mprotect_split(false);
>         test_seal_mprotect_split(true);
>
> +       test_seal_mprotect_partial_mprotect_tail(false);
> +       test_seal_mprotect_partial_mprotect_tail(true);
> +
>         test_seal_munmap(false);
>         test_seal_munmap(true);
>         test_seal_munmap_two_vma(false);
>         test_seal_munmap_two_vma(true);
>         test_seal_munmap_vma_with_gap(false);
>         test_seal_munmap_vma_with_gap(true);
> +       test_seal_munmap_partial_across_vmas(false);
> +       test_seal_munmap_partial_across_vmas(true);
>
>         test_munmap_start_freed(false);
>         test_munmap_start_freed(true);
> @@ -1862,6 +1969,8 @@ int main(int argc, char **argv)
>         test_seal_madvise_nodiscard(true);
>         test_seal_discard_ro_anon(false);
>         test_seal_discard_ro_anon(true);
> +       test_seal_discard_across_vmas(false);
> +       test_seal_discard_across_vmas(true);
>         test_seal_discard_ro_anon_on_rw(false);
>         test_seal_discard_ro_anon_on_rw(true);
>         test_seal_discard_ro_anon_on_shared(false);
>
> --
> 2.46.0
>
>

