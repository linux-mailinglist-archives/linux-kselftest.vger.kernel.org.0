Return-Path: <linux-kselftest+bounces-16151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0E295CDA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528DC28271C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 13:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6162B185922;
	Fri, 23 Aug 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FPDZEO4z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC20185945;
	Fri, 23 Aug 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419245; cv=none; b=MudPU/cMR0N2bC+bQYEtCcmHjv8E4h2vo6CJiXkj/dqGPLLXoqFesYWvHWUGuRuqWe5sIK6VdtkYa0eaWCZ/nbMDpP/BtHauk4/I35XJ0xmT0mezrCh+LXeK+QKmJcO+AT3nF8X97FLJ6Q63kr72LRVh0574pBWDiLKM4C5Zfk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419245; c=relaxed/simple;
	bh=3VauhDsh4XHQhJBiAkgeROTT9W588QEqgHYy8WvWYlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LET37ITPalzglArHJm8Py1Ru88wzQYcYce9oU9WOwdzUnWm1ogyIbpJjzN1HXWO7GvB2PXNLycT0jsVViJjmQ+DlkyorsNG4C6vnHzECSw/S+PAU+gvhs/KHIOmt0Wa9kOLvm5bsmpoKrTU12Hm6JmhQLSDfEoW6mNrshrs+Z/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FPDZEO4z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N6eO1C005418;
	Fri, 23 Aug 2024 13:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=U
	CLsM/o/d6jmGjZ/QsB8h3P8oiP1jBioMzrtO6vOG0w=; b=FPDZEO4zBwhivRG4R
	5BXm4sOkwPboztgSwN4g1dB2VcfZd/JRw7v9Ob8yGp2DKxySuV5O/oUxUUPc+iTW
	Ok0bqkLU+ccZ4Odpj3PaiPopkN/YgLbTKi6Gkr53R0/ZtgpLF4H4S7ufdzrvUKwA
	tNor4JiMi9LpRXNLDXwsg6fpcuSTqrp452jbB5AfcXzXyFIwgcMHxhV5oTFxStWl
	7YniVhljLSc2xn5NNzFXFCDEzAsT9HAjgvr73sD9C6baYyCg4yghkOj8amdbvl1W
	2YIqBjVXAK8f9izibVkw91ue8RMY1zCUndzalJZurvKpnBmM1wvNqEoKFaDj5B8Y
	y/x5A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb651s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:20:40 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47NDKdo4006183;
	Fri, 23 Aug 2024 13:20:39 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb651rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:20:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47ND4oj4017649;
	Fri, 23 Aug 2024 13:20:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138w3hn5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:20:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47NDKXFf21037428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 13:20:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BC4120043;
	Fri, 23 Aug 2024 13:20:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D07CD20040;
	Fri, 23 Aug 2024 13:20:32 +0000 (GMT)
Received: from [9.179.27.211] (unknown [9.179.27.211])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Aug 2024 13:20:32 +0000 (GMT)
Message-ID: <b9528312-4c0d-4a40-940f-82e9af4cca48@linux.ibm.com>
Date: Fri, 23 Aug 2024 15:20:32 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests: kvm: s390: Add uc_map_unmap VM test case
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20240815154529.628087-1-schlameuss@linux.ibm.com>
 <20240815154529.628087-2-schlameuss@linux.ibm.com>
 <4c049b39-af28-488c-9e19-f22691b43585@linux.ibm.com>
 <ZsNs0sN7rWqaviZE@darkmoore>
 <884367dd-fba0-4acd-a614-f657768b662a@linux.ibm.com>
 <D3NB8GXIKS75.2AR1GNELFUIBE@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <D3NB8GXIKS75.2AR1GNELFUIBE@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qxRicSOkm5F4FoV1Y70QOlnJSFGshPlZ
X-Proofpoint-GUID: fW7BP9w46iw7GQ0BFyPKNypPFJQ8TjvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=920 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408230095

On 8/23/24 3:03 PM, Christoph Schlameuss wrote:
> On Fri Aug 23, 2024 at 10:02 AM CEST, Janosch Frank wrote:
>> On 8/19/24 6:03 PM, Christoph Schlameuss wrote:
>>> On Fri Aug 16, 2024 at 4:29 PM CEST, Janosch Frank wrote:
>>>> On 8/15/24 5:45 PM, Christoph Schlameuss wrote:
>>>>> Add a test case verifying basic running and interaction of ucontrol VMs.
>>>>> Fill the segment and page tables for allocated memory and map memory on
>>>>> first access.
>>>>>
>>>>> * uc_map_unmap
>>>>>      Store and load data to mapped and unmapped memory and use pic segment
>>>>>      translation handling to map memory on access.
>>>>>
>>>>> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
>>>>> ---
>>>>>     .../selftests/kvm/s390x/ucontrol_test.c       | 120 +++++++++++++++++-
>>>>>     1 file changed, 119 insertions(+), 1 deletion(-)
>>>>>
>>>>
>>>>> +static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) * self)
>>>>> +{
>>>>> +	struct kvm_run *run = self->run;
>>>>> +
>>>>> +	TEST_ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
>>>>> +	switch (run->s390_ucontrol.pgm_code) {
>>>>> +	case PGM_SEGMENT_TRANSLATION:
>>>>> +		pr_info("ucontrol pic segment translation 0x%llx\n",
>>>>> +			run->s390_ucontrol.trans_exc_code);
>>>>> +		/* map / make additional memory available */
>>>>> +		struct kvm_s390_ucas_mapping map2 = {
>>>>> +			.user_addr = (u64)gpa2hva(self, run->s390_ucontrol.trans_exc_code),
>>>>> +			.vcpu_addr = run->s390_ucontrol.trans_exc_code,
>>>>> +			.length = VM_MEM_EXT_SIZE,
>>>>> +		};
>>>>> +		pr_info("ucas map %p %p 0x%llx\n",
>>>>> +			(void *)map2.user_addr, (void *)map2.vcpu_addr, map2.length);
>>>>> +		TEST_ASSERT_EQ(0, ioctl(self->vcpu_fd, KVM_S390_UCAS_MAP, &map2));
>>>>> +		break;
>>>>
>>>> Why is this necessary if you fix up the mapping in the test?
>>>>
>>>
>>> This is also used within the uc_skey test to make sure the remap does
>>> work after the unmap.
>>
>> Maybe I'm blind because I'm still recovering but where exactly?
> 
> It is literally used in the last line of the test case. Calling uc_handle_exit()
> again re-maps previously unmapped memory.
> 
> I can try to make that a little bit more obvious.
> 
> +	/* unmap and run loop again */
> +	TH_LOG("ucas unmap %p %p 0x%llx",
> +	       (void *)map2.user_addr, (void *)map2.vcpu_addr, map2.length);
> +	rc = ioctl(self->vcpu_fd, KVM_S390_UCAS_UNMAP, &map2);
> +	ASSERT_EQ(0, rc)
> +		TH_LOG("ucas map result %d not expected, %s", rc, strerror(errno));
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(3, sync_regs->gprs[0]);
> +	ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
> +	ASSERT_EQ(true, uc_handle_exit(self));  // <--- HERE
> +}
> 
> 
Seems like I'm blind then :)

