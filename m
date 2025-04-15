Return-Path: <linux-kselftest+bounces-30838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 946ECA899B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 12:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5789F7AB08F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 10:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B860127FD50;
	Tue, 15 Apr 2025 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fc/SvuTZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEEE27EC9A
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712307; cv=none; b=XsYoyfQ2TVoia0JHNpCw9XHQRRr5NmaGukUY6wqqiGoQs0c2ejuL5zxa/iVI8AGDlpN/+tYNiqjvwbP6TIic55smUJvr8dgK5R+dcKWfFg61Hnvwyjtv0c/9UzEcHo9vPiFmoDl5zAS+VFKr0GGl78W3/NPNO26lAVtH4x3Y0Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712307; c=relaxed/simple;
	bh=KL/tj8w4d9VtYfZGInFgJCEW6tHyExialKRDXsLUmuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p39mb/yzqVooyXg+QByJwzmKaXexS9jzl2EO5Z/s80t9QCqjb6rpYxNQbRRqrusGDvTs4+Or8AqvAVHcK3OdTPORzvLW1mphnUluGilSROMh44Xkg+gDrR4DXyGt+Gf6E3YuaS46hY84DrGXTJFdmoBMnOljqO3uFvzgrGSdkv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fc/SvuTZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F9EDPx013055;
	Tue, 15 Apr 2025 10:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3LVa0Z
	KJJaKrq0qfnKBbXJhH7QV71WBJP8iqEjBxH5w=; b=Fc/SvuTZe0LfQWItM5a4dU
	Dc/eSB+iE3hUjHVmqNYg3QmJBOto4j/Y2PzMchhBbHWvzTq7IXy07l4n3joUlaId
	otR6Se1HUcm4IP6N7Xn7IRI2UQnH7HSR/n3yOPs/2Z2qCxQdw0X9q1z45QLQ+KvO
	o/7VrdfJxY4oMPLErJznyfaGcjONJyhSUG2HhH1/Y2ku9kzO+bw02uvTTW8TkKjc
	k5+cHmeeU43JWX2aEru8zacnKhxQBpNz3oKBeWIdSeLXkJDf/Gn0Z5/C8glDbXCo
	3MpxX2zwyj1E9efNR+UVAdtBRecqcLLSVN49ggAv52f4Z/PLEmewU8w5uSi4H1Ug
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4610tpdn0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 10:18:16 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53FA5ws1028759;
	Tue, 15 Apr 2025 10:18:15 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4610tpdn0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 10:18:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53F7qP67010438;
	Tue, 15 Apr 2025 10:18:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qk2c6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 10:18:14 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FAIEOG11010586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 10:18:14 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 811A858056;
	Tue, 15 Apr 2025 10:18:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61AE55803F;
	Tue, 15 Apr 2025 10:18:11 +0000 (GMT)
Received: from [9.124.211.75] (unknown [9.124.211.75])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 10:18:11 +0000 (GMT)
Message-ID: <9b1c3acc-6d7e-46a2-9d47-b41933bd40ac@linux.ibm.com>
Date: Tue, 15 Apr 2025 15:48:09 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Restore default nr_hugepages value during
 cleanup in hugetlb_reparenting_test.sh
To: Dev Jain <dev.jain@arm.com>,
        Anshuman Khandual
 <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, longman@redhat.com,
        Li Wang <liwang@redhat.com>
References: <20250410100748.2310-1-donettom@linux.ibm.com>
 <098f5acc-f367-4188-acbd-2c91c52d57f4@arm.com>
 <7aa6ff41-6ec4-4750-8a0f-f43fe2c1b549@arm.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <7aa6ff41-6ec4-4750-8a0f-f43fe2c1b549@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dnJ19TPjEKJwIfsmbJk6c5-J9-NCLlq2
X-Proofpoint-ORIG-GUID: BkXQ_8l_ohRoPOTSZ9tmNvE3a4pqUq-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 mlxlogscore=823 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150070


On 4/15/25 1:00 PM, Dev Jain wrote:
>
>
> On 15/04/25 12:28 pm, Anshuman Khandual wrote:
>>
>>
>> On 4/10/25 15:37, Donet Tom wrote:
>>> During cleanup, the value of /proc/sys/vm/nr_hugepages is currently
>>> being set to 0. At the end of the test, if all tests pass, the
>>> original nr_hugepages value is restored. However, if any test fails,
>>> it remains set to 0.
>>>
>>> With this patch, we ensure that the original nr_hugepages value is
>>> restored during cleanup, regardless of whether the test passes or 
>>> fails.
>>>
>>> Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation 
>>> tests")
>> Although this change makes sense as an improvement or a cleanup but
>> not sure if this also deserves a Fixes: tag as well.
>
> IMHO it deserves a Fixes tag, the tests should always cleanly exit 
> without changing system state. It may or may not cause an actual 
> problem, so let's be proactive : )
>
Yes, I was thinking the same.

>
>>
>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>> ---
>>>   tools/testing/selftests/mm/hugetlb_reparenting_test.sh | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh 
>>> b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
>>> index 11f9bbe7dc22..114875a2b018 100755
>>> --- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
>>> +++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
>>> @@ -56,7 +56,7 @@ function cleanup() {
>>>     rmdir "$CGROUP_ROOT"/a/b 2>/dev/null
>>>     rmdir "$CGROUP_ROOT"/a 2>/dev/null
>>>     rmdir "$CGROUP_ROOT"/test1 2>/dev/null
>>> -  echo 0 >/proc/sys/vm/nr_hugepages
>>> +  echo $nr_hugepgs >/proc/sys/vm/nr_hugepages
>>>     set -e
>>>   }
>>
>
>

