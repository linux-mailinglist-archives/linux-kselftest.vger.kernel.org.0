Return-Path: <linux-kselftest+bounces-14608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5836194477F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 11:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5FA2815BE
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 09:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B5716DC35;
	Thu,  1 Aug 2024 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TPSULcLL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EAB170A04;
	Thu,  1 Aug 2024 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503324; cv=none; b=OB0ut5zGpk5sL9hdI/shTSgoGVTTmB8UW84qLgjujcfA60qzOQld6cEYTTDc0kPE73+YsPwmo8ZHY2tJfnyDY9WZneJ4aH1Yfb5dIcOEMWrFp+mGicy/X4UIYg3BIuegLdeHB+iUwUM+KhJLXPlx/2lcmblSSij/D7A5n74eSrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503324; c=relaxed/simple;
	bh=4TyZcsH3ip6bpQUoaZO0mSxOqLnPd9JC8F0feYRhs20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NORONaj++9ykXT6NDZxAqnNNWavlS2Q6D1TuJXK8QCYu/uNMInkmrjTeP2IaCX1IAI49tp2KqV5JgZNjSRC04w7cFIGC/qvLLhm+zz8lcyEdyZN1orHO8qX5V54xUAdiMeI4OvnJyoIHaAjiit3fFAO3n2XttkI3NbJcZtLd4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TPSULcLL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4717cigJ022519;
	Thu, 1 Aug 2024 09:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=Z
	dLRS+tuwrZ768re0jWc0dDA6Hr1gYNwXugW2v6VVHg=; b=TPSULcLLbSM9ogSmH
	MUINEPAdxfjEbWDTFj1ZkjAZcjRiq+wZB78mAoqRlOEuMW9pAfdIpyeB+07jCXVn
	qSseW2+MAb9UC4bQH3plbdJuwpM0x4VChtfQN5rUUyUaQnTEeM/aEaWNtCWkUAv7
	eQ+qvtVMFJTg1Fj25mEF02KWWGxC5M7Zk+QuNbJe8PPU/BxkOxo+6XTOFz7X1695
	s7E+d22DF3mhuLJMkJpHTlwTi9ZZWvEgPslNFJHcUsQily0sIIoAfINLJUg8WfNt
	ZePlLmt2RSrsMV8xWjm5SHRZJAFc5WIbdrzXlP5wVcfbsG4XGld41EGZsam3AkOL
	6kR6w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qyums30d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 09:08:38 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47198Pgc013216;
	Thu, 1 Aug 2024 09:08:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qyums309-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 09:08:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47187SRP018811;
	Thu, 1 Aug 2024 09:08:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7q0uu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 09:08:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47198UgA53281040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 09:08:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF2DB2004B;
	Thu,  1 Aug 2024 09:08:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C64020043;
	Thu,  1 Aug 2024 09:08:30 +0000 (GMT)
Received: from [9.152.224.253] (unknown [9.152.224.253])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 09:08:30 +0000 (GMT)
Message-ID: <0b323867-a2f8-4bae-9f33-02ecf8362a13@linux.ibm.com>
Date: Thu, 1 Aug 2024 11:08:30 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] selftests: kvm: s390: Add uc_map_unmap VM test
 case
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20240730072413.143556-1-schlameuss@linux.ibm.com>
 <20240730072413.143556-8-schlameuss@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20240730072413.143556-8-schlameuss@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K1DY7TN9CjgcBSvj7SknX8ng-4noPyxf
X-Proofpoint-ORIG-GUID: nNX-dTe7teGYTde5rg_2w07eNGv6MhZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_06,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010053

On 7/30/24 9:24 AM, Christoph Schlameuss wrote:
> Add a test case verifying basic running and interaction of ucontrol VMs.
> Fill the segment and page tables for allocated memory and map memory on
> first access.
> 
> * uc_map_unmap
>    Store and load data to mapped and unmapped memory and use pic segment
>    translation handling to map memory on access.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   .../selftests/kvm/s390x/ucontrol_test.c       | 165 +++++++++++++++++-
>   1 file changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index 817b1e08559c..b7f760f980fd 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -16,7 +16,13 @@
>   #include <linux/capability.h>
>   #include <linux/sizes.h>
>   
> +#define UC_PIC_SEGMENT_TRANSLATION 0x10

That's a bit clearer and used by KVM:
#define PGM_SEGMENT_TRANSLATION		0x10

> +
>   #define VM_MEM_SIZE (4 * SZ_1M)
> +#define VM_MEM_EXT_SIZE (2 * SZ_1M)
> +#define VM_MEM_MAX (VM_MEM_SIZE + VM_MEM_EXT_SIZE)
> +

[...]

> +	self->pgd = self->base_gpa + SZ_1M; /* set PASCE addr */

Please put the comments on the line above

> +	phd = gpa2hva(self, self->pgd);
> +	memset(phd, 0xff, PAGES_PER_SEGMENT * PAGE_SIZE);
> +
> +	for (si = 0; si < ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M); si++) {
> +		/* create ste */
> +		phd[si] = (self->pgd
> +			+ (PAGES_PER_SEGMENT * PAGE_SIZE
> +				* ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M))
> +			+ (PAGES_PER_SEGMENT * PAGE_SIZE * si)) & ~0x7fful;
> +		se_addr = gpa2hva(self, phd[si]);
> +		memset(se_addr, 0xff, PAGES_PER_SEGMENT * PAGE_SIZE);
> +		for (pi = 0; pi < (SZ_1M / PAGE_SIZE); pi++) {
> +			/* create pte */
> +			((u64 *)se_addr)[pi] = (self->base_gpa
> +				+ (si * SZ_1M) + (pi * PAGE_SIZE)) & ~0xffful;
> +		}
> +	}
> +	pr_debug("segment table entry %p (0x%lx) --> %p\n",
> +		 phd, phd[0], gpa2hva(self, (phd[0] & ~0x7fful)));
> +	print_hex_bytes("st", (u64)phd, 64);
> +	print_hex_bytes("pt", (u64)gpa2hva(self, phd[0]), 128);
> +	print_hex_bytes("pt+", (u64)
> +			gpa2hva(self, phd[0] + (PAGES_PER_SEGMENT * PAGE_SIZE
> +			* ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M)) - 0x64), 128);
> +
> +	sync_regs->crs[1] = self->pgd | 0x3;	/* PASCE TT=00 for segment table */

Same here

> +	run->kvm_dirty_regs |= KVM_SYNC_CRS;
> +}
> +
> +static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) * self)
> +{
> +	struct kvm_run *run = self->run;
> +
> +	TEST_ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
> +	switch (run->s390_ucontrol.pgm_code) {
> +	case UC_PIC_SEGMENT_TRANSLATION:
> +		pr_info("ucontrol pic segment translation 0x%llx\n",
> +			run->s390_ucontrol.trans_exc_code);
> +		/* map / make additional memory available */
> +		struct kvm_s390_ucas_mapping map2 = {
> +			.user_addr = (u64)gpa2hva(self, run->s390_ucontrol.trans_exc_code),
> +			.vcpu_addr = run->s390_ucontrol.trans_exc_code,
> +			.length = VM_MEM_EXT_SIZE,
> +		};
> +		pr_info("ucas map %p %p 0x%llx\n",
> +			(void *)map2.user_addr, (void *)map2.vcpu_addr, map2.length);
> +		TEST_ASSERT_EQ(0, ioctl(self->vcpu_fd, KVM_S390_UCAS_MAP, &map2));
> +		break;
> +	default:
> +		TEST_FAIL("UNEXPECTED PGM CODE %d", run->s390_ucontrol.pgm_code);
> +	}
> +}
> +
>   /* verify SIEIC exit
>    * * reset stop requests
>    * * fail on codes not expected in the test cases
> @@ -245,7 +338,11 @@ static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
>   		break;
>   	case ICPT_INST:
>   		/* end execution in caller on intercepted instruction */
> +		pr_info("sie instruction interception\n");

That should have been part of an earlier patch?

>   		return false;
> +	case ICPT_OPEREXC:
> +		/* operation exception */
> +		TEST_FAIL("sie exception on %.4x%.8x", sie_block->ipa, sie_block->ipb);
>   	default:
>   		TEST_FAIL("UNEXPECTED SIEIC CODE %d", run->s390_sieic.icptcode);
>   	}
> @@ -258,6 +355,11 @@ static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) * self)
>   	struct kvm_run *run = self->run;
>   
>   	switch (run->exit_reason) {
> +	case KVM_EXIT_S390_UCONTROL:
> +		/* check program interruption code */
> +		/* handle page fault --> ucas map */

Multi-line comments do exist

> +		uc_handle_exit_ucontrol(self);
> +		break;
>   	case KVM_EXIT_S390_SIEIC:
>   		return uc_handle_sieic(self);
>   	default:
> @@ -289,6 +391,67 @@ static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
>   	TEST_ASSERT_EQ(0x440000, sie_block->ipb);
>   }
>   
> +TEST_F(uc_kvm, uc_map_unmap)
> +{
> +	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
> +	struct kvm_run *run = self->run;
> +	int rc;
> +
> +	init_st_pt(self);
> +
> +	/* copy test_mem_asm to code_hva / code_gpa */
> +	TH_LOG("copy code %p to vm mapped memory %p / %p",
> +	       &test_mem_asm, (void *)self->code_hva, (void *)self->code_gpa);
> +	memcpy((void *)self->code_hva, &test_mem_asm, PAGE_SIZE);
> +
> +	run->psw_mask = 0x0400000180000000ULL;  /* DAT enabled + 64 bit mode */
> +	run->psw_addr = self->code_gpa;


Please put the comments on the line above

> +
> +	/* set register content for test_mem_asm to access not mapped memory*/
> +	sync_regs->gprs[1] = 0x55;
> +	sync_regs->gprs[5] = self->base_gpa;
> +	sync_regs->gprs[6] = VM_MEM_SIZE;
> +	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> +
> +	/* run and expect to fail witch ucontrol pic segment translation */
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(1, sync_regs->gprs[0]);
> +	ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
> +
> +	ASSERT_EQ(UC_PIC_SEGMENT_TRANSLATION, run->s390_ucontrol.pgm_code);
> +	ASSERT_EQ(self->base_gpa + VM_MEM_SIZE, run->s390_ucontrol.trans_exc_code);
> +	/* map / make additional memory available */
> +	struct kvm_s390_ucas_mapping map2 = {
> +		.user_addr = (u64)gpa2hva(self, self->base_gpa + VM_MEM_SIZE),
> +		.vcpu_addr = self->base_gpa + VM_MEM_SIZE,
> +		.length = VM_MEM_EXT_SIZE,
> +	};
> +	TH_LOG("ucas map %p %p 0x%llx",
> +	       (void *)map2.user_addr, (void *)map2.vcpu_addr, map2.length);
> +	rc = ioctl(self->vcpu_fd, KVM_S390_UCAS_MAP, &map2);
> +	ASSERT_EQ(0, rc)
> +		TH_LOG("ucas map result %d not expected, %s", rc, strerror(errno));
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(false, uc_handle_exit(self));
> +	uc_assert_diag44(self);
> +
> +	/* assert registers and memory are in expected state */
> +	ASSERT_EQ(2, sync_regs->gprs[0]);
> +	ASSERT_EQ(0x55, sync_regs->gprs[1]);
> +	ASSERT_EQ(0x55, *(u32 *)gpa2hva(self, self->base_gpa + VM_MEM_SIZE));
> +
> +	/* unmap and run loop again */
> +	TH_LOG("ucas unmap %p %p 0x%llx",
> +	       (void *)map2.user_addr, (void *)map2.vcpu_addr, map2.length);
> +	rc = ioctl(self->vcpu_fd, KVM_S390_UCAS_UNMAP, &map2);
> +	ASSERT_EQ(0, rc)
> +		TH_LOG("ucas map result %d not expected, %s", rc, strerror(errno));
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(3, sync_regs->gprs[0]);
> +	ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
> +	ASSERT_EQ(true, uc_handle_exit(self));
> +}
> +
>   TEST_F(uc_kvm, uc_gprs)
>   {
>   	struct kvm_sync_regs *sync_regs = &self->run->s.regs;


