Return-Path: <linux-kselftest+bounces-3931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A1E84570B
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 13:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 377E2B22049
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 12:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E75215D5C2;
	Thu,  1 Feb 2024 12:11:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4694C15DBC9;
	Thu,  1 Feb 2024 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789502; cv=none; b=hM6ULOAx8BSnNIAj0g4gZ2js6xa8GCEzXxrmPAdSxrXOvvmGcHhvE1pK26qcLIriK5l30kNSRREWdK66ZTrSU+5GHuNq6pmdUeeL1b2zgSV0tXLRN3obZ7DQmn9s4I9mH6HiMvqbma6x/yDqRVzgbBkupkvvLSfNoks3j2pZ1Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789502; c=relaxed/simple;
	bh=mZSf9y0CQF9TxVXy4FE06iWwVm1ShXHTG/eLd5Jidf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfuvOZfIuQ2V3fMLoW028+WasibBsFvbzcMHyaXP0UxSH8m2d6x2O9KYC5v09nMxz9ZoxDlIj3T73jxLYEF41Eg0LG7GGd7ZqVthbq8fCq7oslCyBSo70iMqiuy8wjLcM7lpn0ypL6K3qoxcpLbUq7pkkhkbeL8TaIZ9zkpbBAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26519DA7;
	Thu,  1 Feb 2024 04:12:17 -0800 (PST)
Received: from [10.57.79.60] (unknown [10.57.79.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 681EB3F762;
	Thu,  1 Feb 2024 04:11:33 -0800 (PST)
Message-ID: <ab7523db-f032-4f99-8090-785f126a3ae2@arm.com>
Date: Thu, 1 Feb 2024 12:11:32 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] selftests/mm: run_vmtests.sh: add missing tests
Content-Language: en-GB
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240125154608.720072-1-usama.anjum@collabora.com>
 <20240125154608.720072-6-usama.anjum@collabora.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240125154608.720072-6-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/01/2024 15:46, Muhammad Usama Anjum wrote:
> Add missing tests to run_vmtests.sh. The mm kselftests are run through
> run_vmtests.sh. If a test isn't present in this script, it'll not run
> with run_tests or `make -C tools/testing/selftests/mm run_tests`.
> 
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Copy the original scripts and their dependence script to install directory as well
> 
> Changes since v2:
> - Add a comment
> - Move tests down in the file
> - Add "-d" option which poisons the pages and aren't being useable after
>   the test
> ---
>  tools/testing/selftests/mm/Makefile       | 5 +++++
>  tools/testing/selftests/mm/run_vmtests.sh | 8 ++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 2453add65d12f..f3aec7be80730 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -114,6 +114,11 @@ TEST_PROGS := run_vmtests.sh
>  TEST_FILES := test_vmalloc.sh
>  TEST_FILES += test_hmm.sh
>  TEST_FILES += va_high_addr_switch.sh
> +TEST_FILES += charge_reserved_hugetlb.sh
> +TEST_FILES += hugetlb_reparenting_test.sh
> +
> +# required by charge_reserved_hugetlb.sh
> +TEST_FILES += write_hugetlb_memory.sh
>  
>  include ../lib.mk
>  
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index e373d592dbf5c..a0f37e4438937 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -19,6 +19,7 @@ usage: ${BASH_SOURCE[0]:-$0} [ options ]
>    -t: specify specific categories to tests to run
>    -h: display this message
>    -n: disable TAP output
> +  -d: run destructive tests

You probably want to clarify the behaviour for -a (all). I guess providing -a
should NOT run destructive tests unless -d is also explicitly provided.

>  
>  The default behavior is to run required tests only.  If -a is specified,
>  will run all tests.
> @@ -79,6 +80,7 @@ EOF
>  }
>  
>  RUN_ALL=false
> +RUN_DESTRUCTIVE_TEST=false

Either call this RUN_DESTRUCTIVE (my preference) or at least make it plural
(RUN_DESTRUCTIVE_TESTS).

>  TAP_PREFIX="# "
>  
>  while getopts "aht:n" OPT; do
> @@ -87,6 +89,7 @@ while getopts "aht:n" OPT; do
>  		"h") usage ;;
>  		"t") VM_SELFTEST_ITEMS=${OPTARG} ;;
>  		"n") TAP_PREFIX= ;;
> +		"a") RUN_DESTRUCTIVE_TEST=true ;;

The help you added says the option is -d, but this is looking for -a, and
conflicting with the existing -a=all option.

>  	esac
>  done
>  shift $((OPTIND -1))
> @@ -304,6 +307,11 @@ CATEGORY="process_mrelease" run_test ./mrelease_test
>  CATEGORY="mremap" run_test ./mremap_test
>  
>  CATEGORY="hugetlb" run_test ./thuge-gen
> +CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh -cgroup-v2
> +CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh -cgroup-v2
> +if $RUN_DESTRUCTIVE_TEST; then
> +CATEGORY="hugetlb" run_test ./hugetlb-read-hwpoison
> +fi
>  
>  if [ $VADDR64 -ne 0 ]; then
>  


