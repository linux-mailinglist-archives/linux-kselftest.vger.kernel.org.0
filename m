Return-Path: <linux-kselftest+bounces-3248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 708FC832CDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 17:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E4A1C21A65
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 16:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE8D54BF0;
	Fri, 19 Jan 2024 16:09:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D7854659;
	Fri, 19 Jan 2024 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680591; cv=none; b=hknFLml6jATcJ3f7ksqKcyOzaEVU3nx/NzYxGr6WNFyqO/4v81T8Zv4jhHp9qUyaMzY2vEM4JXc3soxrQFvUEcAKFZ39W75jsLqAG4gLCX1OwXYJZBijpF5JeoyPdXQqLm/qZMLBAoZwT/PKStEudgaYAIMAWQfqiqMxLutsnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680591; c=relaxed/simple;
	bh=+qVwNgKWyvVHNlIWEZ5n9M6EFS+J7PQq+oE9zH58ZMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/H08cCNjyZCVuY4ukAhZ/4fMlKWeL+i6ohfTJxS2vYvTPe3FGjXuJTFeTYylXrQOCZMkqbWoi89u4hk6PNUmLOzdH889Yeylmr3wkLjF7nSQH58m9cI5y8E4XZ7FFZRM6c+YAf+CqF5hrLWJSX9EEvlLZXD4x5C7LeCQd251IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73B9D1042;
	Fri, 19 Jan 2024 08:10:25 -0800 (PST)
Received: from [10.57.77.97] (unknown [10.57.77.97])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04F803F73F;
	Fri, 19 Jan 2024 08:09:37 -0800 (PST)
Message-ID: <ffdba8c4-f1a2-4141-a3d4-0c85dfea6fef@arm.com>
Date: Fri, 19 Jan 2024 16:09:35 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: add missing tests
Content-Language: en-GB
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240116090641.3411660-1-usama.anjum@collabora.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240116090641.3411660-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Muhammad,

Afraid this patch is causing a regression on our CI system when it turned up in
linux-next today. Additionally, 2 of thetests you have added are failing because
the scripts are not exported correctly...

On 16/01/2024 09:06, Muhammad Usama Anjum wrote:
> Add missing tests to run_vmtests.sh. The mm kselftests are run through
> run_vmtests.sh. If a test isn't present in this script, it'll not run
> with run_tests or `make -C tools/testing/selftests/mm run_tests`.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 246d53a5d7f2..a5e6ba8d3579 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -248,6 +248,9 @@ CATEGORY="hugetlb" run_test ./map_hugetlb
>  CATEGORY="hugetlb" run_test ./hugepage-mremap
>  CATEGORY="hugetlb" run_test ./hugepage-vmemmap
>  CATEGORY="hugetlb" run_test ./hugetlb-madvise
> +CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh
> +CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh

These 2 tests are failing because the test scripts are not exported. You will
need to add them to the TEST_FILES variable in the Makefile.

> +CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison

The addition of this test causes 2 later tests to fail with ENOMEM. I suspect
its a side-effect of marking the hugetlbs as hwpoisoned? (just a guess based on
the test name!). Once a page is marked poisoned, is there a way to un-poison it?
If not, I suspect that's why it wasn't part of the standard test script in the
first place.

These are the tests that start failing:

# # ------------------------------------
# # running ./uffd-stress hugetlb 128 32
# # ------------------------------------
# # nr_pages: 64, nr_pages_per_cpu: 8
# # ERROR: context init failed (errno=12, @uffd-stress.c:254)
# # [FAIL]
# not ok 18 uffd-stress hugetlb 128 32 # exit=1
# # --------------------------------------------
# # running ./uffd-stress hugetlb-private 128 32
# # --------------------------------------------
# # nr_pages: 64, nr_pages_per_cpu: 8
# # bounces: 31, mode: rnd racing ver poll, ERROR: UFFDIO_COPY error: -12ERROR:
UFFDIO_COPY error: -12 (errno=12, @uffd-common.c:614)
# #  (errno=12, @uffd-common.c:614)
# # [FAIL]

Quickest way to repo is:

$ sudo ./run_vmtests.sh -t "userfaultfd hugetlb"

Thanks,
Ryan


>  
>  nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
>  # For this test, we need one and just one huge page


