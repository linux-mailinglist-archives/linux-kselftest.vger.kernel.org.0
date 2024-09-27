Return-Path: <linux-kselftest+bounces-18458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021B79882CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 12:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22BE1F22146
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 10:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566CE183092;
	Fri, 27 Sep 2024 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h7mw47rM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162645979;
	Fri, 27 Sep 2024 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727434324; cv=none; b=osDpIx/2CGQIcIv6o2cibErnkAze3FK6RNe9+s+QQvxSJeTPmXT/0imrsShZprNPaeqbjcPx5yztVEX1LHHqhFQ3F5eda/HSpFS2tIwmUIEA/ni0akLfk3vk4I3/zqoayEU/9nLW2Pd87YT0zKQ3VPrjx+sUcCLd3Vy/JruHOmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727434324; c=relaxed/simple;
	bh=A9ZnsHfPBDIpVcMRuR8dQ7+Vp5LGt1NQ8lPJ9atpEwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3gIQccgMaQyIqh2MfpSlC/x5/fo8OJK9C7sjhrJ6Iyq+65T1WEgr6k8bNUwM4haWAJB95qWH9ACPZYYR50n/Z4b9Dw5jzN6tFq0NG0+l6Vu9/0yR6GIcpHTphlBWKKcqu61PeExRiycHqUPqRDmFgq/NtnTH6MCMMUJQSxTG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h7mw47rM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R28f6C011293;
	Fri, 27 Sep 2024 10:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=f
	PuhzUy6xOp23Z1T42Ea5imkYUyKl/C4Lt0yHBenfCw=; b=h7mw47rMYLTFe3i8N
	M3Mfbme28zwLIGSlO/BuCfL/1nNx2o1o7935AkCrQs0Is6viPS9JBbwT35vuAb/Q
	uCzdZEdAAPrRcknO3bpKmpw4SNwYvygiip6IY9+g9oF4LOm8kIPerx6sDkw48LL8
	ajR3hxBbWnzCrAxxT9VAr4stPYnvWsZca8SeHmQIYyUPN41mQzOirtHkpQ7dTnZi
	L81npyHkpsmKdLDEjzxLPzVIcs1klDQn9ob1eo7LOppsAV824bUgnldbYVCi+YKx
	ewsR+rZuESnuTD9DJBQ3ZGoaRY/8QJ1T5gC/bYbPyaQ4LKiiuQChSnGZThaKMGir
	9mnfQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41wkmnj1e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 10:51:38 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48RApbWp007059;
	Fri, 27 Sep 2024 10:51:37 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41wkmnj1e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 10:51:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48R7UtNB005816;
	Fri, 27 Sep 2024 10:51:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tapmv4rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 10:51:36 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48RApaha12780244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 10:51:36 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E260E58064;
	Fri, 27 Sep 2024 10:51:35 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 622485803F;
	Fri, 27 Sep 2024 10:51:32 +0000 (GMT)
Received: from [9.109.245.146] (unknown [9.109.245.146])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Sep 2024 10:51:32 +0000 (GMT)
Message-ID: <831bb979-e27f-4af0-b933-5b05895aff8f@linux.ibm.com>
Date: Fri, 27 Sep 2024 16:21:30 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Fixed incorrect buffer->mirror size in hmm2
 double_map test
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20240927050752.51066-1-donettom@linux.ibm.com>
 <c62ee507-361b-4dc8-b80e-148c914052f1@collabora.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <c62ee507-361b-4dc8-b80e-148c914052f1@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i12dFmAq3Hevtz9IABOOu966WjoIDjEs
X-Proofpoint-ORIG-GUID: _u6yGHmU5kJTiODlSHDiyTLGkrpC4gGx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_04,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=891
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270071


On 9/27/24 12:48, Muhammad Usama Anjum wrote:
> On 9/27/24 10:07 AM, Donet Tom wrote:
>> The hmm2 double_map test was failing due to an incorrect
>> buffer->mirror size. The buffer->mirror size was 6, while buffer->ptr
>> size was 6 * PAGE_SIZE. The test failed because the kernel's
>> copy_to_user function was attempting to copy a 6 * PAGE_SIZE buffer
>> to buffer->mirror. Since the size of buffer->mirror was incorrect,
>> copy_to_user failed.
>>
>> This patch corrects the buffer->mirror size to 6 * PAGE_SIZE.
>>
>> Test Result without this patch
>> ==============================
>>   #  RUN           hmm2.hmm2_device_private.double_map ...
>>   # hmm-tests.c:1680:double_map:Expected ret (-14) == 0 (0)
>>   # double_map: Test terminated by assertion
>>   #          FAIL  hmm2.hmm2_device_private.double_map
>>   not ok 53 hmm2.hmm2_device_private.double_map
>>
>> Test Result with this patch
>> ===========================
>>   #  RUN           hmm2.hmm2_device_private.double_map ...
>>   #            OK  hmm2.hmm2_device_private.double_map
>>   ok 53 hmm2.hmm2_device_private.double_map
>>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Please add Fixes-by tag. Other than this, LGTM

Fixes-by : Donet Tom <donettom@linux.ibm.com>

I have added the Fixes-by tag here. Please let me know if you would prefer that I send a V2 with this tag.

>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Thank you
Donet

>
>> ---
>>   tools/testing/selftests/mm/hmm-tests.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
>> index d2cfc9b494a0..141bf63cbe05 100644
>> --- a/tools/testing/selftests/mm/hmm-tests.c
>> +++ b/tools/testing/selftests/mm/hmm-tests.c
>> @@ -1657,7 +1657,7 @@ TEST_F(hmm2, double_map)
>>   
>>   	buffer->fd = -1;
>>   	buffer->size = size;
>> -	buffer->mirror = malloc(npages);
>> +	buffer->mirror = malloc(size);
>>   	ASSERT_NE(buffer->mirror, NULL);
>>   
>>   	/* Reserve a range of addresses. */

