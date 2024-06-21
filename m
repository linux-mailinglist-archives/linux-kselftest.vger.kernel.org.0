Return-Path: <linux-kselftest+bounces-12397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A41911A29
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 07:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CECA1F219F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 05:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7D212D1EB;
	Fri, 21 Jun 2024 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="411VLvKM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63F12C486;
	Fri, 21 Jun 2024 05:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946488; cv=none; b=i+1IaUe9yGa5EcDhhc8FZd5IpQwF5+IicsPlHdUzdptpga2rhPGhXSxnTFvsZJ6B+EBUwpE0j7UE4mIO0yNdLQ6FWy3x4cSNWaEdCfIIMm5Dy4i8Khr/X7Ej3oZeKb66VTO5iB9u6/z84o8k4xxsEhRuwFP2sjVRbGXFLYXKF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946488; c=relaxed/simple;
	bh=O+nHjv3muSzRtuvuuUzuGvB5XhfVur/SQhzT0Hwt4Wk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L/o2x/g3vllTKrTTFqQeq3TTRe/KV3WcHHZvdjpZd0INanpJ4drYIQOBtfl4lO6VS4+QaSGI6pQdjGBQ6FkFZciKq0iSb8JW5CNOP1NALua4nnUZvFiCQMls+mz+QhYk++o2wCX6yIyQeBQibgqDvazWPG9H38EIsLpp1cajtA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=411VLvKM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718946484;
	bh=O+nHjv3muSzRtuvuuUzuGvB5XhfVur/SQhzT0Hwt4Wk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=411VLvKM/4J+v8Ysik4EqTFiGpMaUs8Dck92Xw820XQUk+aijmN0EprLrX6bYFfdG
	 uxaJz7ZmncDu+5UU1vzfVBdnlYInTbvGKx4pOOSEXKTwQ0BZkE9Q9NbMtz26XWiBlV
	 zY4yZdoYGqwV4ZZR4hCLQW7NrB/frPTzbjDwR5wj3H8KWtqUTN4vYCBrwBF1FWTSi6
	 rWrtSrsDwGRhhlJpgZnkvD5XY4rBoT1d6Pl73PNeGDJk+IqKTTAwVO4jWus2NPksb2
	 39tafoIXFz9HHW0jAoom/GNHDKLxAiAq9OdqS9OT6vwOZRHpftp60zxdJjuTZPOElv
	 GVqZvLRsfc8kQ==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C3B063781144;
	Fri, 21 Jun 2024 05:08:00 +0000 (UTC)
Message-ID: <1591a354-d999-45b4-aff2-357fa7612634@collabora.com>
Date: Fri, 21 Jun 2024 10:08:38 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, muchun.song@linux.dev,
 akpm@linux-foundation.org, shuah@kernel.org, corbet@lwn.net,
 rientjes@google.com, duenwen@google.com, fvdl@google.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 3/4] selftest/mm: test enable_soft_offline behaviors
To: Jiaqi Yan <jiaqiyan@google.com>, nao.horiguchi@gmail.com,
 linmiaohe@huawei.com, jane.chu@oracle.com, osalvador@suse.de
References: <20240620184856.600717-1-jiaqiyan@google.com>
 <20240620184856.600717-4-jiaqiyan@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240620184856.600717-4-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/24 11:48 PM, Jiaqi Yan wrote:
> Add regression and new tests when hugepage has correctable memory
> errors, and how userspace wants to deal with it:
> * if enable_soft_offline=1, mapped hugepage is soft offlined
> * if enable_soft_offline=0, mapped hugepage is intact
> 
> Free hugepages case is not explicitly covered by the tests.
> 
> Hugepage having corrected memory errors is emulated with
> MADV_SOFT_OFFLINE.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  tools/testing/selftests/mm/.gitignore         |   1 +
>  tools/testing/selftests/mm/Makefile           |   1 +
>  .../selftests/mm/hugetlb-soft-offline.c       | 229 ++++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh     |   4 +
>  4 files changed, 235 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/hugetlb-soft-offline.c
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 0b9ab987601c..064e7b125643 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -6,6 +6,7 @@ hugepage-shm
>  hugepage-vmemmap
>  hugetlb-madvise
>  hugetlb-read-hwpoison
> +hugetlb-soft-offline
>  khugepaged
>  map_hugetlb
>  map_populate
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 3b49bc3d0a3b..d166067d75ef 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -42,6 +42,7 @@ TEST_GEN_FILES += gup_test
>  TEST_GEN_FILES += hmm-tests
>  TEST_GEN_FILES += hugetlb-madvise
>  TEST_GEN_FILES += hugetlb-read-hwpoison
> +TEST_GEN_FILES += hugetlb-soft-offline
>  TEST_GEN_FILES += hugepage-mmap
>  TEST_GEN_FILES += hugepage-mremap
>  TEST_GEN_FILES += hugepage-shm
> diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> new file mode 100644
> index 000000000000..5701eea4ee48
> --- /dev/null
> +++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test soft offline behavior for HugeTLB pages:
> + * - if enable_soft_offline = 0, hugepages should stay intact and soft
> + *   offlining failed with EINVAL.
> + * - if enable_soft_offline = 1, a hugepage should be dissolved and
> + *   nr_hugepages/free_hugepages should be reduced by 1.
> + *
> + * Before running, make sure more than 2 hugepages of default_hugepagesz
> + * are allocated. For example, if /proc/meminfo/Hugepagesize is 2048kB:
> + *   echo 8 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include <linux/magic.h>
> +#include <linux/memfd.h>
> +#include <sys/mman.h>
> +#include <sys/statfs.h>
> +#include <sys/types.h>
> +
> +#ifndef MADV_SOFT_OFFLINE
> +#define MADV_SOFT_OFFLINE 101
> +#endif
> +
> +#define PREFIX " ... "
> +#define EPREFIX " !!! "
> +
> +enum test_status {
> +	TEST_PASS = 0,
> +	TEST_FAILED = 1,
> +	// From ${ksft_skip} in run_vmtests.sh.
> +	TEST_SKIPPED = 4,
> +};
Include ../kselftest.h and use macros from there instead of redifining.
Also try to use helper functions from same header file to mark the test
pass/fail or exit the test entirely. You can look at soft-dirty.c how that
is written.

-- 
BR,
Muhammad Usama Anjum

