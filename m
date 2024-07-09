Return-Path: <linux-kselftest+bounces-13391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337E792C228
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558ED1C20D29
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA8618EA64;
	Tue,  9 Jul 2024 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c+mQv0QI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B9118EA94;
	Tue,  9 Jul 2024 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544882; cv=none; b=Di4dL2AQc7FNda5jj4+90KjmewMGIY9oMjt5qQ+n+wmLpn11GbT3zgWbzQvq73Xxxabvyb0f6YnjTegV4JiyCJ5xi4JMnl2arw+4+lZZNCXXfCZfLAYXswqCRPQw66UaXVp8+rS4XNdbhLuyZWf23FdJYkPlPaDX6HYtptlHK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544882; c=relaxed/simple;
	bh=mVHS/6XvxZ61MfkteEqw4BZY27jcNj7bWLsiIN94eiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAhbiNiFtTCqUnci7l025jpa7YB9EE84jft2nbJUsAW4XIs9G/0cQh6ZRIj3MyiCC0uohyFRJYDJMnV6uUnN5uQjbCm7Hnn+DrhsygWWr1/nkz2rse9vD8/XUlyi8aUWuRqmzgUtHCXAiIW9V+J3lCGuvxLsG3bNaoe3G+DQpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c+mQv0QI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469EwdQu014417;
	Tue, 9 Jul 2024 17:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	RdsGP7UACiE9zTAk10DJzqD1XSghPWJsyDhucLEHexI=; b=c+mQv0QIgkZMeu6i
	8Jz+ot5cFIntuwwat3oDZ5/G/a7Kht1j5TlySpaeysM6eTS2ESu6s+riCdDisd+H
	GLmtlJh+sJ2/wnnkxntyGKIAcUL3kfPzhxUQASqGlIyljJyoMuQIR5JgVYmLiBB5
	w60jfXBp0LB5eRlW6+5mmAMeaDKRsN27u7H7BtEVcSxBvakQa4pOWi/Johz9NXYK
	nekhnxhbrPViuRoG3DRuMouwuyi1LZPRH6zRpba2TGwjQhyKckNCTi4DJKzeTMJ1
	Lpw1ZXRfulRR7zoQd4xdJvAMRBKl4KrBfhqsqj5DITg9NLXyxkmrs4rPt+TvvO2q
	fojGnA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4097efgbfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:51 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469H7pDw018161;
	Tue, 9 Jul 2024 17:07:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4097efgbf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 469ExWOg014043;
	Tue, 9 Jul 2024 17:07:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407gn0nv36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469H7ix728771048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 17:07:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C869120043;
	Tue,  9 Jul 2024 17:07:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B7F620040;
	Tue,  9 Jul 2024 17:07:44 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 17:07:44 +0000 (GMT)
Date: Tue, 9 Jul 2024 19:06:58 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah
 Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand
 <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v1 8/9] selftests: kvm: s390: Add uc_skey VM test case
Message-ID: <20240709190658.5cffc1ba@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240709125704.61312-9-schlameuss@linux.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
	<20240709125704.61312-9-schlameuss@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rtu21Bldng3Sz-OpeoS2N4C3efs6UlVI
X-Proofpoint-ORIG-GUID: VmW_xcZphCb_3pnr6ozloTl3ufvpi6qE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=966 lowpriorityscore=0
 malwarescore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090112

On Tue,  9 Jul 2024 14:57:03 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Add a test case manipulating s390 storage keys from within the ucontrol
> VM.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>  .../selftests/kvm/s390x/ucontrol_test.c       | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index 4438cfc8bf53..64ad31f667e3 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -81,6 +81,32 @@ asm("test_mem_pgm:\n"
>  	"	j	0b\n"
>  );
>  
> +/* Test program manipulating storage keys */
> +extern char test_skey_pgm[];
> +asm("test_skey_pgm:\n"
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
>  FIXTURE(uc_kvm)
>  {
>  	struct kvm_s390_sie_block *sie_block;
> @@ -389,6 +415,63 @@ static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
>  	TEST_ASSERT_EQ(0x440000, sie_block->ipb);
>  }
>  
> +TEST_F(uc_kvm, uc_skey)
> +{
> +	u64 test_vaddr = self->base_gpa + VM_MEM_SIZE - (SZ_1M / 2);
> +	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
> +	struct kvm_s390_sie_block *sie_block = self->sie_block;
> +	struct kvm_run *run = self->run;
> +	u8 skeyvalue = 0x34;
> +
> +	init_st_pt(self);
> +
> +	/* copy test_skey_pgm to code_hva / code_gpa */
> +	TH_LOG("copy code %p to vm mapped memory %p / %p",
> +	       &test_skey_pgm, (void *)self->code_hva, (void *)self->code_gpa);
> +	memcpy((void *)self->code_hva, &test_skey_pgm, PAGE_SIZE);
> +
> +	/* set register content for test_skey_pgm to access not mapped memory*/

missing space before */

> +	sync_regs->gprs[1] = skeyvalue;
> +	sync_regs->gprs[5] = self->base_gpa;
> +	sync_regs->gprs[6] = test_vaddr;
> +	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> +
> +	run->kvm_dirty_regs |= KVM_SYNC_CRS;
> +	TH_LOG("set CR0 to 0x%llx", sync_regs->crs[0]);
> +
> +	self->sie_block->ictl |= ICTL_OPEREXC | ICTL_PINT;
> +	self->sie_block->cpuflags &= ~CPUSTAT_KSS;
> +	run->psw_mask = 0x0400000180000000ULL;  /* DAT enabled + 64 bit mode */
> +	run->psw_addr = self->code_gpa;
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(true, uc_handle_exit(self));
> +	ASSERT_EQ(0, sync_regs->gprs[0]);
> +	ASSERT_EQ(13, run->exit_reason);

can you use macros here instead of magic values?

> +	ASSERT_EQ(40, sie_block->icptcode);

same here

> +
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(false, uc_handle_exit(self));
> +	ASSERT_EQ(2, sync_regs->gprs[0]);
> +	ASSERT_EQ(0x06, sync_regs->gprs[1]);
> +	uc_assert_diag44(self);
> +
> +	sync_regs->gprs[1] = skeyvalue;
> +	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(false, uc_handle_exit(self));
> +	ASSERT_EQ(3, sync_regs->gprs[0]);
> +	ASSERT_EQ(skeyvalue, sync_regs->gprs[1]);
> +	uc_assert_diag44(self);
> +
> +	sync_regs->gprs[1] = skeyvalue;
> +	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(false, uc_handle_exit(self));
> +	ASSERT_EQ(4, sync_regs->gprs[0]);
> +	ASSERT_EQ(skeyvalue & 0xfb, sync_regs->gprs[1]);
> +	uc_assert_diag44(self);
> +}
> +
>  TEST_F(uc_kvm, uc_map_unmap)
>  {
>  	struct kvm_sync_regs *sync_regs = &self->run->s.regs;


