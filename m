Return-Path: <linux-kselftest+bounces-17804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D997642A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 10:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63C81C20D3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 08:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19CB18E764;
	Thu, 12 Sep 2024 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WKxlfTZF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AB117BA1;
	Thu, 12 Sep 2024 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128997; cv=none; b=dwgkgifPzsmDsCQAMtDBoNGsiJgWYKzYxUv0wFD6Q8zVn8vaK5UD1loKg2rHj8abB2tfEHRQP6Ze6LrJ8kvAsK/rt2PVamd+aHBMFdq+EjyrsKAXQqI8j8Jk95F4xcBRB/6QtXijcmTfYUwDA/iABFJnloIoVJY4UxHlBA0sy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128997; c=relaxed/simple;
	bh=SBfSrAHKe9JwBnDq6qTmF1f5rdYhudlhMtTHjKAhbEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMEooerur8j/knirqAauGtpUvm1eae6Z2rip2s+NH49fmlE3Pq6Cw2YKIbnwZV8I06Zu7XNwrn3ksWo4k+3yrCEXm8T0eoKke+VfGNN+0Ux9S08trxm9OZ4kfUneZ93dRzii2Ml2vzNHGyH5WWOwEchpf1tPLOXoq8GiCk1e2E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WKxlfTZF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BKIjsn021192;
	Thu, 12 Sep 2024 08:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	uTeVi2xWw5uitBigQiGA3v/ZlRN8rtJ0JUynUhhPpgw=; b=WKxlfTZFmaH4Ef7q
	V2DQv7mDmSlTiSkT+p1GvcQcFUuzq15fCH7hh6E0Ew7e5C8DfNY9ClowFxO3x4Uq
	e/ifTQbo7yf4Omcxzw0h723pD8Y534pT/7hsVNSfHs75FKDacV1wvlAhZBeIaBJJ
	Ikaw8qT3kbnFCouDCE4A4jVPnorhd2nPdJPQxkNnuntNDjqvRyfXJrVzBU3kzejX
	1gVNGoHtFsY6NVh5mOTMM4LGUekw/P4hVW/sh23OBIOieCZ40db09ov1XlNFUeip
	2mDHD1Tb7ziBnPo7FGFUJn71izi47PA2b5QQ1I3f9rPNrG4Gjrh6hGqG9CfK1yt6
	Tr1peA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefyt2wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:16:30 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48C8GTck019667;
	Thu, 12 Sep 2024 08:16:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefyt2wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:16:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48C6xmD4032088;
	Thu, 12 Sep 2024 08:16:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nmxj7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 08:16:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48C8GPvh54985044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 08:16:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DA8520040;
	Thu, 12 Sep 2024 08:16:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5546B2004B;
	Thu, 12 Sep 2024 08:16:24 +0000 (GMT)
Received: from p-imbrenda (unknown [9.171.8.247])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 12 Sep 2024 08:16:24 +0000 (GMT)
Date: Thu, 12 Sep 2024 10:14:34 +0200
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
Subject: Re: [PATCH v2 1/3] selftests: kvm: s390: Add uc_map_unmap VM test
 case
Message-ID: <20240912101434.14aafd7a@p-imbrenda>
In-Reply-To: <20240902115002.199331-2-schlameuss@linux.ibm.com>
References: <20240902115002.199331-1-schlameuss@linux.ibm.com>
	<20240902115002.199331-2-schlameuss@linux.ibm.com>
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
X-Proofpoint-GUID: i9p_7-D9dCo3AIvNqlbeUPyrPyN1DfWt
X-Proofpoint-ORIG-GUID: 7G3b-K7AfpI6phlifM1-We5Db_NZYDaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=866 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120055

On Mon,  2 Sep 2024 13:50:00 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Add a test case verifying basic running and interaction of ucontrol VMs.
> Fill the segment and page tables for allocated memory and map memory on
> first access.
> 
> * uc_map_unmap
>   Store and load data to mapped and unmapped memory and use pic segment
>   translation handling to map memory on access.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>  .../selftests/kvm/s390x/ucontrol_test.c       | 121 +++++++++++++++++-
>  1 file changed, 120 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index 030c59010fe1..04a0d55af617 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -16,7 +16,11 @@
>  #include <linux/capability.h>
>  #include <linux/sizes.h>
>  
> +#define PGM_SEGMENT_TRANSLATION 0x10
> +
>  #define VM_MEM_SIZE (4 * SZ_1M)
> +#define VM_MEM_EXT_SIZE (2 * SZ_1M)
> +#define VM_MEM_MAX_M ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M)
>  
>  /* so directly declare capget to check caps without libcap */
>  int capget(cap_user_header_t header, cap_user_data_t data);
> @@ -58,6 +62,23 @@ asm("test_gprs_asm:\n"
>  	"	j	0b\n"
>  );
>  
> +/* Test program manipulating memory */
> +extern char test_mem_asm[];
> +asm("test_mem_asm:\n"
> +	"xgr	%r0, %r0\n"
> +
> +	"0:\n"
> +	"	ahi	%r0,1\n"
> +	"	st	%r1,0(%r5,%r6)\n"
> +
> +	"	xgr	%r1,%r1\n"
> +	"	l	%r1,0(%r5,%r6)\n"
> +	"	ahi	%r0,1\n"
> +	"	diag	0,0,0x44\n"
> +
> +	"	j	0b\n"
> +);
> +
>  FIXTURE(uc_kvm)
>  {
>  	struct kvm_s390_sie_block *sie_block;
> @@ -67,6 +88,7 @@ FIXTURE(uc_kvm)
>  	uintptr_t base_hva;
>  	uintptr_t code_hva;
>  	int kvm_run_size;
> +	vm_paddr_t pgd;
>  	void *vm_mem;
>  	int vcpu_fd;
>  	int kvm_fd;
> @@ -116,7 +138,7 @@ FIXTURE_SETUP(uc_kvm)
>  	self->base_gpa = 0;
>  	self->code_gpa = self->base_gpa + (3 * SZ_1M);
>  
> -	self->vm_mem = aligned_alloc(SZ_1M, VM_MEM_SIZE);
> +	self->vm_mem = aligned_alloc(SZ_1M, VM_MEM_MAX_M * SZ_1M);
>  	ASSERT_NE(NULL, self->vm_mem) TH_LOG("malloc failed %u", errno);
>  	self->base_hva = (uintptr_t)self->vm_mem;
>  	self->code_hva = self->base_hva - self->base_gpa + self->code_gpa;
> @@ -222,6 +244,36 @@ TEST(uc_cap_hpage)
>  	close(kvm_fd);
>  }
>  
> +/* calculate host virtual addr from guest physical addr */
> +static void *gpa2hva(FIXTURE_DATA(uc_kvm) * self, u64 gpa)
> +{
> +	return (void *)(self->base_hva - self->base_gpa + gpa);
> +}
> +
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

you could use the wrapper here too (see below)

> +		pr_info("ucas map %p %p 0x%llx\n",
> +			(void *)map2.user_addr, (void *)map2.vcpu_addr, map2.length);
> +		TEST_ASSERT_EQ(0, ioctl(self->vcpu_fd, KVM_S390_UCAS_MAP, &map2));
> +		break;

so this will always return true

> +	default:
> +		TEST_FAIL("UNEXPECTED PGM CODE %d", run->s390_ucontrol.pgm_code);
> +	}
> +}
> +
>  /* verify SIEIC exit
>   * * reset stop requests
>   * * fail on codes not expected in the test cases
> @@ -256,6 +308,12 @@ static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) * self)
>  	struct kvm_run *run = self->run;
>  
>  	switch (run->exit_reason) {
> +	case KVM_EXIT_S390_UCONTROL:
> +		/** check program interruption code
> +		 * handle page fault --> ucas map
> +		 */
> +		uc_handle_exit_ucontrol(self);
> +		break;
>  	case KVM_EXIT_S390_SIEIC:
>  		return uc_handle_sieic(self);
>  	default:
> @@ -287,6 +345,67 @@ static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
>  	TEST_ASSERT_EQ(0x440000, sie_block->ipb);
>  }
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
> +	/* run and expect to fail with ucontrol pic segment translation */
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
> +	       (void *)map2.user_addr, (void *)map2.vcpu_addr,
> map2.length);
> +	rc = ioctl(self->vcpu_fd, KVM_S390_UCAS_MAP, &map2);

maybe you can put the map/unmap IOCTLs in a wrapper, so that this
becomes more readable? 

rc = uc_map_ext(self->base_gpa + VM_MEM_SIZE, self->base_gpa +VM_MEM_SIZE);

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
> +		TH_LOG("ucas unmap result %d not expected, %s", rc, strerror(errno));
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(3, sync_regs->gprs[0]);
> +	ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
> +	ASSERT_EQ(PGM_SEGMENT_TRANSLATION, run->s390_ucontrol.pgm_code);
> +	ASSERT_EQ(true, uc_handle_exit(self));
> +}
> +
>  TEST_F(uc_kvm, uc_gprs)
>  {
>  	struct kvm_sync_regs *sync_regs = &self->run->s.regs;


