Return-Path: <linux-kselftest+bounces-30826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA16FA89523
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 09:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D133B8C8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 07:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F315923AE84;
	Tue, 15 Apr 2025 07:30:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE572417C8
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702244; cv=none; b=hPd3hd5BaWxg8NVShz9vfe/GdPOYA23UkvYoSEJLhvIeOCmLGGaUisytkJYFohfFeK7JFYZHz/4U8oSqGOayc76WTPDy8CZ8YxX9v+WvAjCQue4UW3Wgc+ruRZDYE1otvAXlOpu7c9Gr7F12rig4YpTR9KWtPlJw80pKbqUxjC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702244; c=relaxed/simple;
	bh=wmrq0DJcRyuw9JSMH0lwtZ6+bEV4xojaDskXpix6iOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/IxTqktGHMdtyUHy/wAEtrVh/ZTTDr7qaGQE8ArNFZ4nsK0Jd4nYhDY7HkawjeD+dzsLYjXdD1ArTcgCcExPcOEKYdl+ztkTOSaKs3vEZU4w/fl7PT1yaHPuWuVHDCAzMypPENZffz7mnwn78kMBeves3CTvgEe45J5B1+EDew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 727B915A1;
	Tue, 15 Apr 2025 00:30:40 -0700 (PDT)
Received: from [10.163.73.130] (unknown [10.163.73.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B22E43F66E;
	Tue, 15 Apr 2025 00:30:38 -0700 (PDT)
Message-ID: <7aa6ff41-6ec4-4750-8a0f-f43fe2c1b549@arm.com>
Date: Tue, 15 Apr 2025 13:00:35 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Restore default nr_hugepages value during
 cleanup in hugetlb_reparenting_test.sh
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Donet Tom <donettom@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, longman@redhat.com,
 Li Wang <liwang@redhat.com>
References: <20250410100748.2310-1-donettom@linux.ibm.com>
 <098f5acc-f367-4188-acbd-2c91c52d57f4@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <098f5acc-f367-4188-acbd-2c91c52d57f4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/04/25 12:28 pm, Anshuman Khandual wrote:
> 
> 
> On 4/10/25 15:37, Donet Tom wrote:
>> During cleanup, the value of /proc/sys/vm/nr_hugepages is currently
>> being set to 0. At the end of the test, if all tests pass, the
>> original nr_hugepages value is restored. However, if any test fails,
>> it remains set to 0.
>>
>> With this patch, we ensure that the original nr_hugepages value is
>> restored during cleanup, regardless of whether the test passes or fails.
>>
>> Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation tests")
> Although this change makes sense as an improvement or a cleanup but
> not sure if this also deserves a Fixes: tag as well.

IMHO it deserves a Fixes tag, the tests should always cleanly exit 
without changing system state. It may or may not cause an actual 
problem, so let's be proactive : )

> 
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>   tools/testing/selftests/mm/hugetlb_reparenting_test.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
>> index 11f9bbe7dc22..114875a2b018 100755
>> --- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
>> +++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
>> @@ -56,7 +56,7 @@ function cleanup() {
>>     rmdir "$CGROUP_ROOT"/a/b 2>/dev/null
>>     rmdir "$CGROUP_ROOT"/a 2>/dev/null
>>     rmdir "$CGROUP_ROOT"/test1 2>/dev/null
>> -  echo 0 >/proc/sys/vm/nr_hugepages
>> +  echo $nr_hugepgs >/proc/sys/vm/nr_hugepages
>>     set -e
>>   }
>>   
> 


