Return-Path: <linux-kselftest+bounces-3398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23424838A64
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 10:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D521C23BA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 09:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B06159B7F;
	Tue, 23 Jan 2024 09:33:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8595559B62;
	Tue, 23 Jan 2024 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002425; cv=none; b=QxcK8wUVYWa+BJqqeI/IIDJDTJ92Bef1S8sUrXjFFuHRYXMcWBJtF0V7SolvkD6pebp3zDxZHsyJ1UjGhpSNi1TZr9rEuIx73v6TaX5seSxd/wC7Ubrx5ao3BcU7NgFuoQTbOm+84mqO5RW75jrkyYWo8CushfhhJlAakm2TCkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002425; c=relaxed/simple;
	bh=jtfVkdL6JvKuPixP2eull7hNXa+QZLAVSJb4hUeRoZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkMaN1busJYiGZSbVUdNbz9JHspw2CYKPNpWyQy8uCssaOgZvMKdEr+vu89a86fSdBXs7K63Wm1Gl9BvqVuGS8IDd8qh3zaaVRBoJAhnpzyqzDVpRXOj8T4hFFGbGbk2SUK3rBDEhmE2NVBpIOW8DAH30p5ndP0TChqjnYQwEts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F0D91FB;
	Tue, 23 Jan 2024 01:34:26 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF2463F5A1;
	Tue, 23 Jan 2024 01:33:39 -0800 (PST)
Message-ID: <e92f7c49-5268-421e-a017-af268c845b1b@arm.com>
Date: Tue, 23 Jan 2024 09:33:38 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/mm: run_vmtests.sh: add missing tests
Content-Language: en-GB
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240123073615.920324-1-usama.anjum@collabora.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240123073615.920324-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2024 07:36, Muhammad Usama Anjum wrote:
> Add missing tests to run_vmtests.sh. The mm kselftests are run through
> run_vmtests.sh. If a test isn't present in this script, it'll not run
> with run_tests or `make -C tools/testing/selftests/mm run_tests`.
> 
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Copy the original scripts and their dependence script to install directory as well
> ---
>  tools/testing/selftests/mm/Makefile       | 3 +++
>  tools/testing/selftests/mm/run_vmtests.sh | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 2453add65d12f..c9c8112a7262e 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -114,6 +114,9 @@ TEST_PROGS := run_vmtests.sh
>  TEST_FILES := test_vmalloc.sh
>  TEST_FILES += test_hmm.sh
>  TEST_FILES += va_high_addr_switch.sh
> +TEST_FILES += charge_reserved_hugetlb.sh
> +TEST_FILES += write_hugetlb_memory.sh
> +TEST_FILES += hugetlb_reparenting_test.sh

I see you are exporting 3 scripts, but only invoking 2 of them from
run_vmtests.sh below. Is one a helper that gets called indirectly?

>  
>  include ../lib.mk
>  
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 246d53a5d7f28..12754af00b39c 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -248,6 +248,9 @@ CATEGORY="hugetlb" run_test ./map_hugetlb
>  CATEGORY="hugetlb" run_test ./hugepage-mremap
>  CATEGORY="hugetlb" run_test ./hugepage-vmemmap
>  CATEGORY="hugetlb" run_test ./hugetlb-madvise
> +CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh -cgroup-v2
> +CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh -cgroup-v2
> +CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison

I'm not really a fan of adding this last test here; its destructive because it
poisons 8 hugepages. So at a minimum, I think you need to modify the code in
run_vmtests.sh to ensure those extra pages are allocated (there is already a
section in the script that allocates hugepages).

However, given this test is destructive, I'd prefer that it wasn't run as part
of the main test set. Because the first time you run it, it will presumably
pass, but now some of the hugepages are poisoned so next time you run it, there
won't be enough unpoisoned hugepages and a test will fail. So you have very
confusing behaviour for a developer who might be running these tests multiple
times per boot (e.g. me).

Perhaps we can add a -d (destructive) option to the script, and this test will
only be run if that option is passed?

Thanks,
Ryan


>  
>  nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
>  # For this test, we need one and just one huge page


