Return-Path: <linux-kselftest+bounces-17805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A87897642D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 10:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5802839A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 08:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6503F1917D0;
	Thu, 12 Sep 2024 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gzcZx/0F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A487190057;
	Thu, 12 Sep 2024 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726129000; cv=none; b=Fwqbvk3PnwAetw6HGKbsC8knN0d0pOxXqF+8opN99kEH/av/Wl3W5wYH0/9XTSPQDNqJq0wT8DC0/iT1ft/GAN7gkjbVCdXLiEflE9qq5s5IdUgUdK3lDUAhAEo7NaSo649tbr/z+Ekd57ST5zB392kb0sBZ0VRkhfKnVVSg1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726129000; c=relaxed/simple;
	bh=5Veyys/4ckeRVIhbMmozTlGpZ7vrmVxPqMkbrIz3GEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ouao1JyY3IKsZ4OVfX0mqPYn/+JBMuq3py/C4vfOeZmTJ2OAzq0ZYvAxj2zky9uYfbunGU7wWgUfUFLH2FYGSeLeUdnNWEdAmDx8OsSyQJo981ewxlBrRoK3wrzr++sJTHWzfQG2lBII5whYEmiJcnxZbzsccgb4yhEX2qI/EFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gzcZx/0F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BL92Uc022575;
	Thu, 12 Sep 2024 08:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	f8Yl3jT4jXKeepHKR/Xjgwb+6gZSxAMPsVbIR3l60tI=; b=gzcZx/0FxIpfevsx
	Bfk92ulXBzA/12+NMVtOimI2cmbtA9SKpRO956DhRdPh0EniZe84YILTAVwyEG5m
	AOM1mSUv7PprpfIaUgUYMl6sRxPOp5RzChMihOKC9QEftT4rPC4i8vR1Q6I/YeMw
	KYxaMor5lRA6QHN4a5E/y+B4x1zBfCBtsa/Rq0wRt6qNwAOsrctuHu59N2nkNwB2
	PJitt4T0OfZk8cH0MDOjDXdiDhUztr5ZeHZ67cHdWY+mga822XCuiaPTq7aSTbNv
	dhSFH7miq3alVZdNa4e8n998g1W7WsPy4Uywn5E5K2zqoHWq4fddbZyVWzJutSw1
	itLJzQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegx2bw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:16:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48C8F0fc025661;
	Thu, 12 Sep 2024 08:16:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegx2bvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:16:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48C6rOUM032103;
	Thu, 12 Sep 2024 08:16:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nmxj75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:16:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48C8GMmX51511560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 08:16:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EAE820049;
	Thu, 12 Sep 2024 08:16:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55FEF2004B;
	Thu, 12 Sep 2024 08:16:21 +0000 (GMT)
Received: from p-imbrenda (unknown [9.171.8.247])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 12 Sep 2024 08:16:21 +0000 (GMT)
Date: Thu, 12 Sep 2024 10:15:23 +0200
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
Subject: Re: [PATCH v2 2/3] selftests: kvm: s390: Add uc_skey VM test case
Message-ID: <20240912101523.5ee9ca54@p-imbrenda>
In-Reply-To: <20240902115002.199331-3-schlameuss@linux.ibm.com>
References: <20240902115002.199331-1-schlameuss@linux.ibm.com>
	<20240902115002.199331-3-schlameuss@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YZA2YGkWqQmeWbdhMRLC_HSU2r-CylpM
X-Proofpoint-ORIG-GUID: bn1Cl1cbdJkAsU8o_cK10JJ7aVJg04AS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120052

On Mon,  2 Sep 2024 13:50:01 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Add a test case manipulating s390 storage keys from within the ucontrol
> VM.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>  .../selftests/kvm/s390x/ucontrol_test.c       | 89 ++++++++++++++++++-
>  1 file changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index 04a0d55af617..331a4109b953 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -79,6 +79,33 @@ asm("test_mem_asm:\n"
>  	"	j	0b\n"
>  );
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
> +	"	xgr	%r1,%r1\n"
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
> @@ -275,8 +302,9 @@ static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) * self)
>  }
>  
>  /* verify SIEIC exit
> - * * reset stop requests
> + * * handle expected interception codes
>   * * fail on codes not expected in the test cases
> + * Returns if interception is handled / execution can be continued
>   */
>  static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
>  {
> @@ -293,6 +321,10 @@ static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
>  		/* end execution in caller on intercepted instruction */
>  		pr_info("sie instruction interception\n");
>  		return false;
> +	case ICPT_KSS:
> +		/* disable KSS and continue; KVM would init the skeys here */
> +		sie_block->cpuflags &= ~CPUSTAT_KSS;
> +		return true;
>  	case ICPT_OPEREXC:
>  		/* operation exception */
>  		TEST_FAIL("sie exception on %.4x%.8x", sie_block->ipa, sie_block->ipb);
> @@ -449,4 +481,59 @@ TEST_F(uc_kvm, uc_gprs)
>  	ASSERT_EQ(1, sync_regs->gprs[0]);
>  }
>  
> +TEST_F(uc_kvm, uc_skey)
> +{
> +	u64 test_vaddr = VM_MEM_SIZE - (SZ_1M / 2);
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
> +	/* DAT disabled + 64 bit mode */
> +	run->psw_mask = 0x0000000180000000ULL;
> +	run->psw_addr = self->code_gpa;
> +
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(false, uc_handle_exit(self));

this should be true, since KSS will be triggered

> +	ASSERT_EQ(1, sync_regs->gprs[0]);
> +
> +	/* ISKE */
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(false, uc_handle_exit(self));
> +	ASSERT_EQ(2, sync_regs->gprs[0]);
> +	/* assert initial skey (ACC = 0, R & C = 1) */
> +	ASSERT_EQ(0x06, sync_regs->gprs[1]);
> +	uc_assert_diag44(self);
> +
> +	/* SSKE */
> +	sync_regs->gprs[1] = skeyvalue;
> +	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(false, uc_handle_exit(self));
> +	ASSERT_EQ(3, sync_regs->gprs[0]);
> +	ASSERT_EQ(skeyvalue, sync_regs->gprs[1]);
> +	uc_assert_diag44(self);
> +
> +	/* RRBE */
> +	sync_regs->gprs[1] = skeyvalue;
> +	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(false, uc_handle_exit(self));
> +	ASSERT_EQ(4, sync_regs->gprs[0]);
> +	/* assert R reset but rest of skey unchanged*/
> +	ASSERT_EQ(skeyvalue & 0xfa, sync_regs->gprs[1]);
> +	ASSERT_EQ(0x00, sync_regs->gprs[1] & 0x04);
> +	uc_assert_diag44(self);
> +}
> +
>  TEST_HARNESS_MAIN


