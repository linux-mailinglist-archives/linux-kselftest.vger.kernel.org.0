Return-Path: <linux-kselftest+bounces-16815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F50966619
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 17:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40511F23DE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8A41B5EC9;
	Fri, 30 Aug 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aAFLbdxo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF27EEC3;
	Fri, 30 Aug 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033124; cv=none; b=VX6+XNdHfc3ZY8KBu0HBOXVqOTZsldtC3SHNsjRzA7qUBtrSnzErmVVmJGA966bx1kbgqKbP69M2xOGcpTPVd9j4L0mLuofueiDFJQMFVSjHPJRaaDQ5dgNiPECW1WDZVl2wUFoz9dU21di+sb15lId+eL9h4PnZk/diJMcvUzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033124; c=relaxed/simple;
	bh=ReyUDy0UExuAmKpsZawmKA4PQFAvLTwLno13/GEMHCg=;
	h=Content-Type:Date:Message-Id:From:Cc:To:Subject:Mime-Version:
	 References:In-Reply-To; b=IdifzVpOQ3YvlqCn92ljFg113h0bA3aaAQC1hlW1hEXXAb0n3qJVxLfLGkwdHZZ7l3epVhbpuh7Puw8nvebxp0iCYvDP16IgbVSfwz0NnNA7RCNhs0nboxVU5ulM2P6YQUWevpHCGLr6zgfR82jC2CblkeM5JkMbYDBXiilgLJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aAFLbdxo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UBukFF010386;
	Fri, 30 Aug 2024 15:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:message-id:from:cc:to:subject
	:content-transfer-encoding:mime-version:references:in-reply-to;
	 s=pp1; bh=F+jOrq8XIZDEz6WWNTmszAjMAskiHFkpqfOqJ/Hfu4Q=; b=aAFLb
	dxoM0Tg5ne3jcEMlj+bak2S6jOKOG8l31fNbLvqvzxMgnY4iJtWz9nMaoMEArSA4
	zt5/+ggXxmbw52V2JybnJaJyJ9yrDjJY5/LJ7inh8CwNhUrDofIiWDM8MVtXteCL
	i5DMD//dz9Qvr1h08gRzgCOuZvtfmR+tCqM29LVkR7KzbdBIN8AJh2pItQuZwHKQ
	lHlvzRtZqKkXhfqZFFShUFouxieXWlLCKWPBsn6+YHTsy1Ms1hxdUk7aEO6jR92x
	rgfCHy1mgUGd7Tl/tX84+JUdtKSsA0zqB7irAnjHc+IaHjEtdsBvD2ShrlbkHLqs
	uqoY4RB/I+yMjc55w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8ug4cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 15:51:50 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47UFpoK3005932;
	Fri, 30 Aug 2024 15:51:50 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8ug4cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 15:51:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47UCk9NA021757;
	Fri, 30 Aug 2024 15:51:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 417suuvyab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 15:51:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47UFpkNL37880226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 15:51:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB1D620049;
	Fri, 30 Aug 2024 15:51:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1B6120040;
	Fri, 30 Aug 2024 15:51:45 +0000 (GMT)
Received: from darkmoore (unknown [9.171.37.17])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Aug 2024 15:51:45 +0000 (GMT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Aug 2024 17:51:40 +0200
Message-Id: <D3TD767Z7WT7.2BGNEOOWVEP5@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "Paolo
 Bonzini" <pbonzini@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
        "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Nina
 Schoetterl-Glausch" <nsg@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/3] selftests: kvm: s390: Add uc_skey VM test case
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.17.0
References: <20240815154529.628087-1-schlameuss@linux.ibm.com>
 <20240815154529.628087-3-schlameuss@linux.ibm.com>
 <7f930ac3-a7af-47c7-8455-8c96d11754b5@linux.ibm.com>
 <ZsNsMMc0Ir1w0BJy@darkmoore>
 <69e416b1-17c7-45cc-b5d3-ab6de0f8e039@linux.ibm.com>
In-Reply-To: <69e416b1-17c7-45cc-b5d3-ab6de0f8e039@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ifvhml7qTmX423AtTRzJZWZn-VeybA8R
X-Proofpoint-ORIG-GUID: TuqH2RJ7Ov6D18hlpGANLfFDScdb3hrS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=373 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300119

On Fri Aug 23, 2024 at 9:59 AM CEST, Janosch Frank wrote:
> On 8/19/24 6:00 PM, Christoph Schlameuss wrote:
> > On Fri Aug 16, 2024 at 4:36 PM CEST, Janosch Frank wrote:
> >> On 8/15/24 5:45 PM, Christoph Schlameuss wrote:
> [...]
> >>> +TEST_F(uc_kvm, uc_skey)
> >>> +{
> >>> +	u64 test_vaddr =3D self->base_gpa + VM_MEM_SIZE - (SZ_1M / 2);
> >>> +	struct kvm_sync_regs *sync_regs =3D &self->run->s.regs;
> >>> +	struct kvm_run *run =3D self->run;
> >>> +	u8 skeyvalue =3D 0x34;
> >>> +
> >>> +	/* copy test_skey_asm to code_hva / code_gpa */
> >>> +	TH_LOG("copy code %p to vm mapped memory %p / %p",
> >>> +	       &test_skey_asm, (void *)self->code_hva, (void *)self->code_g=
pa);
> >>> +	memcpy((void *)self->code_hva, &test_skey_asm, PAGE_SIZE);
> >>> +
> >>> +	/* set register content for test_skey_asm to access not mapped memo=
ry */
> >>> +	sync_regs->gprs[1] =3D skeyvalue;
> >>> +	sync_regs->gprs[5] =3D self->base_gpa;
> >>> +	sync_regs->gprs[6] =3D test_vaddr;
> >>> +	run->kvm_dirty_regs |=3D KVM_SYNC_GPRS;
> >>> +
> >>> +	self->sie_block->ictl |=3D ICTL_OPEREXC | ICTL_PINT;
> >>> +	self->sie_block->cpuflags &=3D ~CPUSTAT_KSS;
> >>
> >> So you don't want KVM to initialize skeys?
> >> Or am I missing a ucontrol skey interaction?
> >>
> >> What about the ICTLs if KSS is not available on the machine?
> >=20
> > This is explicitly disabling KSS, not enabling it.
> > Doing that explicitly might not strictly be necessary but I thought thi=
s does
> > provide some clarity about the state.
> >=20
>
> The 3 skey ICTLs and KSS are used by KVM to get an intercept on the=20
> first skey instruction that the guest issues. KVM uses that intercept to=
=20
> initialize the keys and setup skey handling since it's an edge case=20
> because Linux doesn't use skeys.
>
> If KSS is available KVM will not set the skey ICTLs but KSS is a=20
> "recent" addition (my guess would be ~z13). So if you want to disable=20
> skey intercepts regardless of the machine you need to clear all 4 bits.
>
> Are you sure that disabling KSS makes sense and does what you think it do=
es?

I did revisit the normal skey initialization. It is as you say triggered by=
 the
first KSS intercept. But this is where it actually differs in uncontrol VMs=
.=20
kvm_handle_sie_intercept() would normally call kvm_s390_skey_check_enable()=
. But
in the ucontrol case it exists early and sets KVM_EXIT_S390_SIEIC with the =
KSS
intercept code.

So I think the best coverage we can produce here is to mimic that within th=
e
tests userspace code. I will restore the KSS interception and handle it in =
the
next patch version.

