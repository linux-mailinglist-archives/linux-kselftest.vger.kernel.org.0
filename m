Return-Path: <linux-kselftest+bounces-24619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2D2A131B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 04:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC45165BEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 03:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C38E43AA9;
	Thu, 16 Jan 2025 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AWunwoS1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AE225D6;
	Thu, 16 Jan 2025 03:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736997698; cv=none; b=bF/1e7250bRWuQS3XsVDg7R5t6DVvVHiTJfkWBMlkZMle4WFYnSPkQyI2AKr33bf3VSFfeR3+VLgO2ehXU64cIBMhmWbyGX0qbhihAefqfWL9UG9zfT7nPFb9kJASp3FCW6cCjffmAZUG4IhgI2ebgg49l+uIjHKArzLHafg1X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736997698; c=relaxed/simple;
	bh=1dhaLNGZsYPpOHgAFrejfhegf4kOj3M5etDsdaA1W4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNvSnw9ZVUVv5zY5KWS0nFQg0v3STcJHX6zM735lSzDkVyM7pAKu7aso39iHq2wZrLFTakiVTG26jYjtmJ0pQZNeLUX1qTKZhSWcnkcYkNlBf/0HVKatFN2y6Sc/z/91dcvp4DXwrrt0q4pDVXikP9ydBeAo6OAM2HUojamJ3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AWunwoS1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FNwbZb028601;
	Thu, 16 Jan 2025 03:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2+/JXF
	F271n7zx/492hS24NZjkBavMO6mOxr6CQgAGw=; b=AWunwoS1RNu/nU+CGtjU4Z
	DpaJenJpEiWoGnJGxSBvgy36n6NhiHKNIbRdgAW3WIE1hmlpxSoulmrt6B2rgEHk
	8hNEgtEXS5aPc1tKDSEU5LPktnrGbgKJx618Sl+YMiYO/8YNBKHNJ57BsnTqrh7y
	6BiomPIUtpZyMRsgedatNx77l1c5pxZRJEi02A8nxDsOA2WiU27jpEeDfFwk89ad
	FeRGaChBnx9fkCEAgicun+JQDz9sOJQ/MEJOKcqXSeWMMsu9RiYrA0Oy4xQ1MAV2
	CNKdOYTsnstMKCN9vpLEOphj4Y4yD9WcShyp15oM53PSyvijHZHoEuOXG0oc/W2A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446q5hrn6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 03:21:16 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50G3HCt2023836;
	Thu, 16 Jan 2025 03:21:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446q5hrn6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 03:21:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50G1vNEI016994;
	Thu, 16 Jan 2025 03:21:14 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fkbp4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 03:21:14 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50G3LEmj64225776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 03:21:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F42A5805C;
	Thu, 16 Jan 2025 03:21:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FFA458051;
	Thu, 16 Jan 2025 03:21:07 +0000 (GMT)
Received: from [9.43.32.49] (unknown [9.43.32.49])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 03:21:07 +0000 (GMT)
Message-ID: <2808cfba-a7c8-420c-ba30-1bb8efca93e9@linux.ibm.com>
Date: Thu, 16 Jan 2025 08:51:04 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: livepatch: handle PRINTK_CALLER in
 check_result()
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, shuah@kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20250114143144.164250-1-maddy@linux.ibm.com>
 <Z4f6AbC7pQLIWuX+@redhat.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <Z4f6AbC7pQLIWuX+@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Epqa_ZMM6zL-u388jDocavZ2XPAu73Gj
X-Proofpoint-GUID: dWNJxTh6M1dmt1Y8E-tyrLr16GqbcnTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_11,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160018



On 1/15/25 11:40 PM, Joe Lawrence wrote:
> On Tue, Jan 14, 2025 at 08:01:44PM +0530, Madhavan Srinivasan wrote:
>> Some arch configs (like ppc64) enable CONFIG_PRINTK_CALLER, which
>> adds the caller id as part of the dmesg. Due to this, even though
>> the expected vs observed are same, end testcase results are failed.
>>
>>  -% insmod test_modules/test_klp_livepatch.ko
>>  -livepatch: enabling patch 'test_klp_livepatch'
>>  -livepatch: 'test_klp_livepatch': initializing patching transition
>>  -livepatch: 'test_klp_livepatch': starting patching transition
>>  -livepatch: 'test_klp_livepatch': completing patching transition
>>  -livepatch: 'test_klp_livepatch': patching complete
>>  -% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>>  -livepatch: 'test_klp_livepatch': initializing unpatching transition
>>  -livepatch: 'test_klp_livepatch': starting unpatching transition
>>  -livepatch: 'test_klp_livepatch': completing unpatching transition
>>  -livepatch: 'test_klp_livepatch': unpatching complete
>>  -% rmmod test_klp_livepatch
>>  +[   T3659] % insmod test_modules/test_klp_livepatch.ko
>>  +[   T3682] livepatch: enabling patch 'test_klp_livepatch'
>>  +[   T3682] livepatch: 'test_klp_livepatch': initializing patching transition
>>  +[   T3682] livepatch: 'test_klp_livepatch': starting patching transition
>>  +[    T826] livepatch: 'test_klp_livepatch': completing patching transition
>>  +[    T826] livepatch: 'test_klp_livepatch': patching complete
>>  +[   T3659] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>>  +[   T3659] livepatch: 'test_klp_livepatch': initializing unpatching transition
>>  +[   T3659] livepatch: 'test_klp_livepatch': starting unpatching transition
>>  +[    T789] livepatch: 'test_klp_livepatch': completing unpatching transition
>>  +[    T789] livepatch: 'test_klp_livepatch': unpatching complete
>>  +[   T3659] % rmmod test_klp_livepatch
>>
>>   ERROR: livepatch kselftest(s) failed
>>  not ok 1 selftests: livepatch: test-livepatch.sh # exit=1
>>
>> Currently the check_result() handles the "[time]" removal from
>> the dmesg. Enhance the check to handle removal of "[Tid]" also.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
>> ---
>>  tools/testing/selftests/livepatch/functions.sh | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
>> index e5d06fb40233..a1730c1864a4 100644
>> --- a/tools/testing/selftests/livepatch/functions.sh
>> +++ b/tools/testing/selftests/livepatch/functions.sh
>> @@ -306,7 +306,8 @@ function check_result {
>>  	result=$(dmesg | awk -v last_dmesg="$LAST_DMESG" 'p; $0 == last_dmesg { p=1 }' | \
>>  		 grep -e 'livepatch:' -e 'test_klp' | \
>>  		 grep -v '\(tainting\|taints\) kernel' | \
>> -		 sed 's/^\[[ 0-9.]*\] //')
>> +		 sed 's/^\[[ 0-9.]*\] //' | \
>> +		 sed 's/^\[[ ]*T[0-9]*\] //')
> 
> Thanks for adding this to the filter.
> 
> If I read the PRINTK_CALLER docs correctly, there is a potential CPU
> identifier as well.  Are there any instances where the livepatching code
> will use the "[C$processor_id]" (out of task context) prefix?  Or would
> it hurt to future proof with [CT][0-9]?

Thanks for the review.

yeah, saw that case, but in my current build and boot test, seen only the Thread-id added,
so sent out to fix that. I did not get to add a test to create "processor id" scenario,
so cant test it at this point.

Maddy

> 
> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
> 
> --
> Joe
> 
>>  
>>  	if [[ "$expect" == "$result" ]] ; then
>>  		echo "ok"
>> -- 
>> 2.47.0
>>
> 


