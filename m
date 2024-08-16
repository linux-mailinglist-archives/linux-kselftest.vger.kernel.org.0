Return-Path: <linux-kselftest+bounces-15511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A336954C5C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 16:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52DE61C20F17
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 14:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846281BCA0A;
	Fri, 16 Aug 2024 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A5Bxb5A+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00781A3BC0;
	Fri, 16 Aug 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723818579; cv=none; b=ADisc803pKIQlo0c62EoJTcz37BeHoX59dI1ztVUEGSmp8zTiW+MgtzU5WkYHicxTQbcmgiV6c/L+AZJFZBMHD+v7Vu52sF2EWk26yc81NBEOerRbxmmo1Cz2gyEkxH8CV/PKe95PvqPuvwoXG9Hu/LEW5DPlAOaLwWjkApkGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723818579; c=relaxed/simple;
	bh=JhmXKWhjdrG84FRgxq2myvwpgTSU4uVmrcF1oKCERZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NB5x0ZBtNyVaK/lR5ISZpwgI9JLwkh7h7WTy9MM3k6vqnWXPknuee+I7zxY9/a13+3dxiH3M98UQzfVKl5WQ5Mz1yEmh8Ey+UMPG9ZOrvOwpz8XZwxq3MWP+O+2bMWFd83jvnxOn/cr6bvCVz8Ryur9GP9+4thLqvYIDhNB6Umg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A5Bxb5A+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47G2KT4u004516;
	Fri, 16 Aug 2024 14:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=4
	1hGsqTLvTIxU5BwIt+HASBMihq4OvuVWvFAGoo55no=; b=A5Bxb5A+pvpo4SnGr
	/lknI9sDyAsrvuUwjE5fKf877tpK5wvADhJ6e5oMiNxee/fHFIrnvvrf7K2HA4xH
	DEXVS+BljVJ5fIsa/0AN+n/BQ+fdZ+zMBUcPTi/ftalDe40fz0a6T/ynD4i7wiBq
	y2RnYLdEbpMbR9PBUxvarF7MjpNKb+PlnIdWle5XjQCvsIokZXjnX0B3aYUepbEy
	vhOI4VUxuoehSAuI3PwDsf6aC5LEFjCe2Ftf5lIMzVeAWd9VWukC0RoykrbxXhR1
	RK0eZgQYtEyNJJqZT1lLwGL6GurBO+dd6erkLFjjj29LldRu2eMWKrsZok1gPL8h
	G+F8A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6rt4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 14:29:31 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47GETUM7013825;
	Fri, 16 Aug 2024 14:29:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6rt4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 14:29:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47GAbOta016357;
	Fri, 16 Aug 2024 14:29:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xkhq41vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 14:29:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47GETOHu34865844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 14:29:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2017320043;
	Fri, 16 Aug 2024 14:29:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7437520040;
	Fri, 16 Aug 2024 14:29:23 +0000 (GMT)
Received: from [9.171.56.137] (unknown [9.171.56.137])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Aug 2024 14:29:23 +0000 (GMT)
Message-ID: <4c049b39-af28-488c-9e19-f22691b43585@linux.ibm.com>
Date: Fri, 16 Aug 2024 16:29:23 +0200
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
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20240815154529.628087-2-schlameuss@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v9ITlVF5l6TX4Ebd1GjeD4zifVV-SmOs
X-Proofpoint-GUID: fBwpW9bNRD-ZYOaybVo28IMOcNAbNlfp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_05,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxlogscore=737
 phishscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408160102

On 8/15/24 5:45 PM, Christoph Schlameuss wrote:
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
>   .../selftests/kvm/s390x/ucontrol_test.c       | 120 +++++++++++++++++-
>   1 file changed, 119 insertions(+), 1 deletion(-)
> 

> +static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) * self)
> +{
> +	struct kvm_run *run = self->run;
> +
> +	TEST_ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
> +	switch (run->s390_ucontrol.pgm_code) {
> +	case PGM_SEGMENT_TRANSLATION:
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

Why is this necessary if you fix up the mapping in the test?

[...]

>   
> +TEST_F(uc_kvm, uc_map_unmap)
> +{
> +	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
> +	struct kvm_run *run = self->run;
> +	int rc;
> +
> +	/* copy test_mem_asm to code_hva / code_gpa */
> +	TH_LOG("copy code %p to vm mapped memory %p / %p",
> +	       &test_mem_asm, (void *)self->code_hva, (void *)self->code_gpa);
> +	memcpy((void *)self->code_hva, &test_mem_asm, PAGE_SIZE);
> +
> +	/* DAT disabled + 64 bit mode */
> +	run->psw_mask = 0x0000000180000000ULL;
> +	run->psw_addr = self->code_gpa;
> +
> +	/* set register content for test_mem_asm to access not mapped memory*/
> +	sync_regs->gprs[1] = 0x55;
> +	sync_regs->gprs[5] = self->base_gpa;
> +	sync_regs->gprs[6] = VM_MEM_SIZE;
> +	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> +
> +	/* run and expect to fail witch ucontrol pic segment translation */

s/witch/with/

> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(1, sync_regs->gprs[0]);
> +	ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
> +
> +	ASSERT_EQ(PGM_SEGMENT_TRANSLATION, run->s390_ucontrol.pgm_code);
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

s/map/unmap/


> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(3, sync_regs->gprs[0]);
> +	ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
> +	ASSERT_EQ(true, uc_handle_exit(self));
> +}
> +
>   TEST_F(uc_kvm, uc_gprs)
>   {
>   	struct kvm_sync_regs *sync_regs = &self->run->s.regs;


