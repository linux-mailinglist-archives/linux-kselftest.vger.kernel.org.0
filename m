Return-Path: <linux-kselftest+bounces-15512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F67B954C71
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 16:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B202846BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7071BD001;
	Fri, 16 Aug 2024 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G2P6p96W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63101BC9E8;
	Fri, 16 Aug 2024 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819017; cv=none; b=E5a4bh743wmKMS9QeEhMFJ/BPpQOWx0nr8Rn5BUDQUp5QM51zOWoYDbc9ejLagcDtPucjjFawO/QPmFZdZXvayV5C/ayMn+4YZIYO4sFjT2bC7L9diNCxDvsDXFumtYthdONCKSpMhNeA0Zbr5+BQ4KJJLkTk+DhoEU4eKH7Vyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819017; c=relaxed/simple;
	bh=3F8zxPAUsjjErUXMfvSu48CtN04NxOKKrZjNmjSAwFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aY5+mwU7urAdd4O4whgx2AREoVjwOCMXiymlGvyNy4tk8iVF3uGi2FldXRzGpruxr5vvX7tMBoOJ/Tb/0IbFsSj5QQZI8tv78/B4VPycmzB3LhpNpcGBPfadXhBDY3OX5b8LjuVAJamsQIkrfKBLK9ICTir85EfVknIhKi/eMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G2P6p96W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47G2KT5a004516;
	Fri, 16 Aug 2024 14:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=q
	9dfOttQu1POiySJSMNVFbqeUEZDFywNMflRrsX6WdI=; b=G2P6p96WrXd2ZwiaH
	4bs98lsdZ1dx3/hkhBds/+qUuVQfqeymZgtMXUR8elyLmgghR22VloNaakmJihqO
	teSqmWJai4nC3rR5nzHSL924uVYGXP/bY8KrXncwzlKL+W0gNHDITvr4PmZD2Wd5
	6ITvCngwn75xC7uANyJ9kBsnjS5TgF+sgCJumqaUSIJS36B8OjZzHTh89wy5bjE1
	p1yqjMPM4graHnNJv+EqEYmEgVZnPWl+n3ZQy4j3nkR3kxuQWVYRF2MBMjPbVur1
	fBvZ24qL+r0yPEFxvpl4JLKJY2i1WlxPwi2ICVgd/L64oYYiuo87cLflUN1E/Wuz
	nfxaA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6ru53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 14:36:50 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47GEaokh028515;
	Fri, 16 Aug 2024 14:36:50 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6ru51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 14:36:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47GEPWek011541;
	Fri, 16 Aug 2024 14:36:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xjhum8pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 14:36:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47GEahrq43057492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 14:36:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D218E2004B;
	Fri, 16 Aug 2024 14:36:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59CC420040;
	Fri, 16 Aug 2024 14:36:43 +0000 (GMT)
Received: from [9.171.56.137] (unknown [9.171.56.137])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Aug 2024 14:36:43 +0000 (GMT)
Message-ID: <7f930ac3-a7af-47c7-8455-8c96d11754b5@linux.ibm.com>
Date: Fri, 16 Aug 2024 16:36:43 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] selftests: kvm: s390: Add uc_skey VM test case
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20240815154529.628087-1-schlameuss@linux.ibm.com>
 <20240815154529.628087-3-schlameuss@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20240815154529.628087-3-schlameuss@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TRSeQMKpOOsNMjxKyXPtxkDCL5zP_ksc
X-Proofpoint-GUID: jMo53Lennb24zf5zLPpvE_EwTT4EENmA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_08,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408160106

On 8/15/24 5:45 PM, Christoph Schlameuss wrote:
> Add a test case manipulating s390 storage keys from within the ucontrol
> VM.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   .../selftests/kvm/s390x/ucontrol_test.c       | 76 +++++++++++++++++++
>   1 file changed, 76 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index 41306bb52f29..5f8815a80544 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -79,6 +79,32 @@ asm("test_mem_asm:\n"
>   	"	j	0b\n"
>   );
>   
> +/* Test program manipulating storage keys */
> +extern char test_skey_asm[];
> +asm("test_skey_asm:\n"
> +	"xgr	%r0, %r0\n"
> +
> +	"0:\n"
> +	"	ahi	%r0,1\n"
> +	"	st	%r1,0(%r5,%r6)\n"
> +
> +	"	iske	%r1,%r6\n"
> +	"	ahi	%r0,1\n"
> +	"	diag	0,0,0x44\n"
> +
> +	"	sske	%r1,%r6\n"

Might want to add a xgr here so you're sure that you're not reading your 
own values if iske fails.

> +	"	iske	%r1,%r6\n"
> +	"	ahi	%r0,1\n"
> +	"	diag	0,0,0x44\n"
> +
> +	"	rrbe	%r1,%r6\n"
> +	"	iske	%r1,%r6\n"
> +	"	ahi	%r0,1\n"
> +	"	diag	0,0,0x44\n"
> +
> +	"	j	0b\n"
> +);
> +
>   FIXTURE(uc_kvm)
>   {
>   	struct kvm_s390_sie_block *sie_block;
> @@ -345,6 +371,56 @@ static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
>   	TEST_ASSERT_EQ(0x440000, sie_block->ipb);
>   }
>   
> +TEST_F(uc_kvm, uc_skey)
> +{
> +	u64 test_vaddr = self->base_gpa + VM_MEM_SIZE - (SZ_1M / 2);
> +	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
> +	struct kvm_run *run = self->run;
> +	u8 skeyvalue = 0x34;
> +
> +	/* copy test_skey_asm to code_hva / code_gpa */
> +	TH_LOG("copy code %p to vm mapped memory %p / %p",
> +	       &test_skey_asm, (void *)self->code_hva, (void *)self->code_gpa);
> +	memcpy((void *)self->code_hva, &test_skey_asm, PAGE_SIZE);
> +
> +	/* set register content for test_skey_asm to access not mapped memory */
> +	sync_regs->gprs[1] = skeyvalue;
> +	sync_regs->gprs[5] = self->base_gpa;
> +	sync_regs->gprs[6] = test_vaddr;
> +	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> +
> +	self->sie_block->ictl |= ICTL_OPEREXC | ICTL_PINT;
> +	self->sie_block->cpuflags &= ~CPUSTAT_KSS;

So you don't want KVM to initialize skeys?
Or am I missing a ucontrol skey interaction?

What about the ICTLs if KSS is not available on the machine?




