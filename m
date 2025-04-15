Return-Path: <linux-kselftest+bounces-30821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F158A8944B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 08:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDA417BCD1
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 06:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B2274FC7;
	Tue, 15 Apr 2025 06:58:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5859A21E0A8
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744700292; cv=none; b=Rz0amiDsoQZKxBTzD+UEIpXriDrWZV0tL4e72BGJ4TUv8eq58RTL/iBJvlHDbMQRpFOb1XPtGdyzI+NtMQ5u6xMrjOI1APPjkFfAB0tzVMmyN3LOj1ciwCIVXSugcNQac/vS+YwgaXNTbYfci/AB0jmlY2QzQLfDNW70npokY2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744700292; c=relaxed/simple;
	bh=Nv532wBnBiUnkujq5QrWRKLamPupcjWtUOrZzrJSbIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AemhJ4X/HmpOc1vswK2jhoc9ZQ2hL4B8nArjSpMVqUoTT4nw7uX3PCs64WnyPbnGS2b/Egb2ifHeaXqJ+YCvGqhiXPLZ84Z3QhLX2qXATXCTHraBomZkKSqWiW3/aqCkntzzvz2Gav7v58c9YilsuU0G7/Xl4kENI00mUhysnww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 085F215A1;
	Mon, 14 Apr 2025 23:58:08 -0700 (PDT)
Received: from [10.163.49.104] (unknown [10.163.49.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B5043F66E;
	Mon, 14 Apr 2025 23:58:06 -0700 (PDT)
Message-ID: <098f5acc-f367-4188-acbd-2c91c52d57f4@arm.com>
Date: Tue, 15 Apr 2025 12:28:03 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Restore default nr_hugepages value during
 cleanup in hugetlb_reparenting_test.sh
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, longman@redhat.com,
 Li Wang <liwang@redhat.com>
References: <20250410100748.2310-1-donettom@linux.ibm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250410100748.2310-1-donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/10/25 15:37, Donet Tom wrote:
> During cleanup, the value of /proc/sys/vm/nr_hugepages is currently
> being set to 0. At the end of the test, if all tests pass, the
> original nr_hugepages value is restored. However, if any test fails,
> it remains set to 0.
> 
> With this patch, we ensure that the original nr_hugepages value is
> restored during cleanup, regardless of whether the test passes or fails.
> 
> Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation tests")
Although this change makes sense as an improvement or a cleanup but
not sure if this also deserves a Fixes: tag as well.

> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>  tools/testing/selftests/mm/hugetlb_reparenting_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
> index 11f9bbe7dc22..114875a2b018 100755
> --- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
> +++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
> @@ -56,7 +56,7 @@ function cleanup() {
>    rmdir "$CGROUP_ROOT"/a/b 2>/dev/null
>    rmdir "$CGROUP_ROOT"/a 2>/dev/null
>    rmdir "$CGROUP_ROOT"/test1 2>/dev/null
> -  echo 0 >/proc/sys/vm/nr_hugepages
> +  echo $nr_hugepgs >/proc/sys/vm/nr_hugepages
>    set -e
>  }
>  

