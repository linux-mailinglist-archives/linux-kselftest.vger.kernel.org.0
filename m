Return-Path: <linux-kselftest+bounces-16316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA02E95F695
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E84D1F22785
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC41195803;
	Mon, 26 Aug 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lu3CRdRM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033EA194AF4;
	Mon, 26 Aug 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689881; cv=none; b=fdXRM2lKNZ8l/RKNQ4G2QwAavNkwxTqmBWGsD9g61VXIBr8QmXYZV2mDEHChyARER++7BlQZq2yxplQ8QH1OF3Km8yFMmF/fZk5z46lVlD/YRevsn2bFuxqBu6dK5kiSq+eT+kLmQW4lmzqtj4kwzTwGqMHHn83Zy9rLnIYrk+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689881; c=relaxed/simple;
	bh=sBWObpIURzE7rGgJalH63r9oA3dfudWljtwwz75DiP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H31dM83sbaXERP3ciAqOcDBsio6i5INGOwdn39T4BQrkImwuHxsD0gS7AIkDIug0XMFGmDi9XX3rZGgj6HbIEn4fLGtjdhbGqWLgpwl7M4nNIMdjhfV7F3hlOT3iwaEQidqkC1/0HIpHRgvpOnenksAem66PWryAEv5mUQz59A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lu3CRdRM; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37182eee02dso2418523f8f.1;
        Mon, 26 Aug 2024 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724689878; x=1725294678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgP1RaXOzzzTBKazcsHO9qES41aL077t+VcUN6dnDbs=;
        b=Lu3CRdRMbwG55kObbzPbMPpyFFdTCHcF6KDkRDIjMGrGN8X3fQss3NMEgD7aD0LaeQ
         /JhEcB+wy58mVyUPOBVX9ctLZhgN+aMY+cTcUbIkVabEi86sm2EfoeteyFCUYQ0uskqd
         tBEgP75Zes4A8nKvWRDwA7MhAMEqzPgl4RNHuAZV20zbm3orf9NWR/mzNwlmGpyUCVQY
         b8x8ixH0MJhMFO3v1dXU7ozo9xts25kmCf+LEdqiOFubCAgPRT9SJlm7/Dc8Sa5PCedz
         lD0yV9ssjGY8lIMkyGirgSik95t2XiG9CvL8sQ1h25QHG4ewiJGbNwhgMBUmaKClMzo7
         Hvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724689878; x=1725294678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgP1RaXOzzzTBKazcsHO9qES41aL077t+VcUN6dnDbs=;
        b=fkg57P3PBbnpg2hnRGciRIeRTC8Cpx1cLW/NDY7OMJ+g39YvzjAVJJdZG2Jj0VI70j
         VxHiv8X3Zdlat/4nwyDtSGTgBQp45DdqANXzcniB54uU+tedjx9LjIHSVXkHTM9DYyVG
         7ULCk3Sbmt65DL61VnTyJIR+tui5tLfaP/1EM/Ihrf5NjXsLRUST+ZHHbiqYCkotCeuN
         Tl3w7oyOzdB3Gc8sw04e2HBSPIs5ctDxYwRJGBGFcawh8nHYZuXXvi+j2qY19sWAWKfs
         pxP7DiuDHOJII/Jx1GM6zV8Bqsp7xKeWyyxwW3upO9BELG0XNY02epzD61AIjXUeWGqS
         JuWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVprONK1ITlRVOywcrSfHDAvUJt9wsjXc9ABJyEcXSnYTpjxR9CPV0opaB0UwCskl9zrNu8pj/KeKHdotFcBSBc@vger.kernel.org, AJvYcCXFs76uk97bxKNg6e9pI1AYxwYdO7/NrqubYuCS9hc870XTgCWOE3OIjnQ/5M/64ac0nZFKJaK1@vger.kernel.org, AJvYcCXvqc5skJPXC8oL14uaqN/1krs4vhTclJ+qrA50iXzSSkeb1r2ue0PQIBhI/msuaW1qlt5cLRW/ryh1y1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9oJPbBLMJvy1Kgiz3dTuuQlMNtuaNnIGTRkwegMemm7w8BWW
	a+t5BmPVOLqEN5Q7jGzzTBqvU3sF42XNvCPtQ0NGp8kULFDm1Ow/kAJ432yETrNaac+ZuUzIPe3
	rARBxJ7U6tzRr2uKtksUHzzTbMwc=
X-Google-Smtp-Source: AGHT+IGvlKM5jEkyZL5SDFHJ5vCf7ieoBS46eVPP0FWNvkfN0Ygt6SwSa79aV/SxBKbtgib3VrcY3K+UOy576RuKy1k=
X-Received: by 2002:adf:fc0d:0:b0:365:aec0:e191 with SMTP id
 ffacd0b85a97d-3748c88a349mr113978f8f.21.1724689877939; Mon, 26 Aug 2024
 09:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826124021.2635705-1-linyunsheng@huawei.com> <20240826124021.2635705-2-linyunsheng@huawei.com>
In-Reply-To: <20240826124021.2635705-2-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 26 Aug 2024 09:30:41 -0700
Message-ID: <CAKgT0Uf-ax6F12Uxex_vTiKB44QnZH=DA-jbtYj6_LsweAH-Ow@mail.gmail.com>
Subject: Re: [PATCH net-next v15 01/13] mm: page_frag: add a test module for page_frag
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 5:46=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> The testing is done by ensuring that the fragment allocated
> from a frag_frag_cache instance is pushed into a ptr_ring
> instance in a kthread binded to a specified cpu, and a kthread
> binded to a specified cpu will pop the fragment from the
> ptr_ring and free the fragment.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  tools/testing/selftests/mm/Makefile           |   2 +
>  tools/testing/selftests/mm/page_frag/Makefile |  18 ++
>  .../selftests/mm/page_frag/page_frag_test.c   | 170 ++++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh     |   9 +-
>  4 files changed, 198 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/mm/page_frag/Makefile
>  create mode 100644 tools/testing/selftests/mm/page_frag/page_frag_test.c
>

...

I am good with everything up to this point.

> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/se=
lftests/mm/run_vmtests.sh
> index 36045edb10de..9a788d5f3f28 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -75,6 +75,8 @@ separated by spaces:
>         read-only VMAs
>  - mdwe
>         test prctl(PR_SET_MDWE, ...)
> +- page_frag
> +       test handling of page fragment allocation and freeing
>
>  example: ./run_vmtests.sh -t "hmm mmap ksm"
>  EOF
> @@ -231,7 +233,8 @@ run_test() {
>                 ("$@" 2>&1) | tap_prefix
>                 local ret=3D${PIPESTATUS[0]}
>                 count_total=3D$(( count_total + 1 ))
> -               if [ $ret -eq 0 ]; then
> +               # page_frag_test.ko returns 11(EAGAIN) when insmod'ing to=
 avoid rmmod
> +               if [ $ret -eq 0 ] | [ $ret -eq 11 -a ${CATEGORY} =3D=3D "=
page_frag" ]; then
>                         count_pass=3D$(( count_pass + 1 ))
>                         echo "[PASS]" | tap_prefix
>                         echo "ok ${count_total} ${test}" | tap_output
> @@ -456,6 +459,10 @@ CATEGORY=3D"mkdirty" run_test ./mkdirty
>
>  CATEGORY=3D"mdwe" run_test ./mdwe_test
>
> +CATEGORY=3D"page_frag" run_test insmod ./page_frag/page_frag_test.ko
> +
> +CATEGORY=3D"page_frag" run_test insmod ./page_frag/page_frag_test.ko tes=
t_alloc_len=3D12 test_align=3D1
> +
>  echo "SUMMARY: PASS=3D${count_pass} SKIP=3D${count_skip} FAIL=3D${count_=
fail}" | tap_prefix
>  echo "1..${count_total}" | tap_output
>

I don't know if this piece is needed. My thought would be rather than
mess with the run_vmtest.sh directly which is more of a pass/fail test
it might be better to handle this more like test_vmalloc.sh and just
put together your own performance test that you can run to collect the
data, and then if you want to be a part of this test you could call
that script from here.

