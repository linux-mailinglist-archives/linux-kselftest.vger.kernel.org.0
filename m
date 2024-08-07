Return-Path: <linux-kselftest+bounces-14919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B021994A688
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 13:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7531F22BC8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 11:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FDB1D174B;
	Wed,  7 Aug 2024 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rtgQWOCZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818911B9B43;
	Wed,  7 Aug 2024 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028563; cv=none; b=RNR8+cXI7Ougc3qLFtMcD467U0okZ0k8vqHnPPcNSlOgIk7BicOaiJULGCy8pF9eT7vZ86nKaff4fn3AVA8jMrj/n7J/0QbLgqrE2xwehrBrXSvugJt6a6w18ZQna9wtU+Y/UsnPfNMojz+QHhIT0HbaHPdk3zqMomitqbzt+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028563; c=relaxed/simple;
	bh=6jIjO/YzCC0JAUWX6XQ3qSYdTAbSolktYYq1hpL6PiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tfx8+O3G3J97s2fvSlgQt2gDv8+lfUGtbnQDlNoaA65h5/LFSQ5Hy4XifW1ZoHZdgCmiFXDtaWKMrc69Z6ADMtNDod4Jrj2AeGj8al2YeN8OaKM35bEa4uTMrf/MkOMocENqSDT/h/0VwB/AiXUgpbP8nfdDoaeuZxGKdRSRG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rtgQWOCZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4772Mb22012366;
	Wed, 7 Aug 2024 11:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	K8SJ5DfZZqNnSsupVRItmzj3t1W0RVs7ge3xrM7xGX4=; b=rtgQWOCZEnq1xWnx
	sm8Cn97Sb0+tZrJNJxFsPBBOY7ReRM2D18BNqYUJNzHKkXLrVrf0Ysv5rLeqjzrL
	2yBPhar3VSOwr80L6hkSIexKcIdkgs+IPwYrLfq8fNUCFZdH2E9ovLVxrZU3tvRV
	E81XGuYZQZeAiky4Yoc4bN0IjH03RQg3kyd0CQFyCJkY/wmopkAOsCDvdVWnJV2p
	WmUJsMa3Yy1t4DKzwTbjhl2nfTcnZwQNwX/twyX0p+MrusW+5tlhLFMzvq7YoHzL
	XlHy3KVwU09ko20cWJL8oylA2pFSABjN/URFA96zte84RgeEq1HXpmUT2XSm4dbW
	OPiDRQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40u5t3vaxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 11:02:36 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 477AwR2p017334;
	Wed, 7 Aug 2024 11:02:36 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40u5t3vax9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 11:02:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4779KKZb030487;
	Wed, 7 Aug 2024 11:02:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t1k38ac2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 11:02:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 477B2Tmq57803250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 11:02:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8F2320040;
	Wed,  7 Aug 2024 11:02:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A97702004D;
	Wed,  7 Aug 2024 11:02:28 +0000 (GMT)
Received: from darkmoore.boeblingen.de.ibm.com (unknown [9.155.210.150])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 11:02:28 +0000 (GMT)
Date: Wed, 7 Aug 2024 13:02:26 +0200
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah
 Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand
 <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v4 08/10] selftests: kvm: s390: Add uc_skey VM test case
Message-ID: <20240807130226.00b9d1ca.schlameuss@linux.ibm.com>
In-Reply-To: <4b4f9459-4b4a-48b8-8935-25e51ffa51c8@linux.ibm.com>
References: <20240802155913.261891-1-schlameuss@linux.ibm.com>
	<20240802155913.261891-9-schlameuss@linux.ibm.com>
	<4b4f9459-4b4a-48b8-8935-25e51ffa51c8@linux.ibm.com>
Organization: IBM
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6iefWQHKb383ipd2xCz1eM-VTEfsxb5Z
X-Proofpoint-ORIG-GUID: R0iBQ2xWlJfZLAlHp1u8dFjfreNTG5KN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_08,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=884
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070076

On Tue, 6 Aug 2024 15:39:44 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 8/2/24 5:59 PM, Christoph Schlameuss wrote:
> > Add a test case manipulating s390 storage keys from within the ucontrol
> > VM.
> > 
> > Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> > ---
> >   .../selftests/kvm/s390x/ucontrol_test.c       | 78 +++++++++++++++++++
> >   1 file changed, 78 insertions(+)
> >   
> 
> [...]
> 
> > +TEST_F(uc_kvm, uc_skey)
> > +{
> > +	u64 test_vaddr = self->base_gpa + VM_MEM_SIZE - (SZ_1M / 2);
> > +	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
> > +	struct kvm_run *run = self->run;
> > +	u8 skeyvalue = 0x34;
> > +
> > +	init_st_pt(self);
> > +
> > +	/* copy test_skey_asm to code_hva / code_gpa */
> > +	TH_LOG("copy code %p to vm mapped memory %p / %p",
> > +	       &test_skey_asm, (void *)self->code_hva, (void *)self->code_gpa);
> > +	memcpy((void *)self->code_hva, &test_skey_asm, PAGE_SIZE);
> > +
> > +	/* set register content for test_skey_asm to access not mapped memory */
> > +	sync_regs->gprs[1] = skeyvalue;
> > +	sync_regs->gprs[5] = self->base_gpa;
> > +	sync_regs->gprs[6] = test_vaddr;
> > +	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> > +
> > +	run->kvm_dirty_regs |= KVM_SYNC_CRS;
> > +	TH_LOG("set CR0 to 0x%llx", sync_regs->crs[0]);  
> 
> You haven't touched any CRs here or am I missing something?
> 

No I am not. Removing that.

> > +
> > +	self->sie_block->ictl |= ICTL_OPEREXC | ICTL_PINT;
> > +	self->sie_block->cpuflags &= ~CPUSTAT_KSS;
> > +	/* DAT enabled + 64 bit mode */
> > +	run->psw_mask = 0x0400000180000000ULL;
> > +	run->psw_addr = self->code_gpa;
> > +
> > +	ASSERT_EQ(0, uc_run_once(self));
> > +	ASSERT_EQ(false, uc_handle_exit(self));
> > +	ASSERT_EQ(2, sync_regs->gprs[0]);
> > +	ASSERT_EQ(0x06, sync_regs->gprs[1]);  
> 
> /* ACC = 0, F & R = 1 */
> 

I will sprinkle in some comments here to make it more clear what is
tested in the different blocks.

> > +	uc_assert_diag44(self);
> > +
> > +	sync_regs->gprs[1] = skeyvalue;
> > +	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> > +	ASSERT_EQ(0, uc_run_once(self));
> > +	ASSERT_EQ(false, uc_handle_exit(self));
> > +	ASSERT_EQ(3, sync_regs->gprs[0]);
> > +	ASSERT_EQ(skeyvalue, sync_regs->gprs[1]);
> > +	uc_assert_diag44(self);  
> 
> Rest LGTM
> 


