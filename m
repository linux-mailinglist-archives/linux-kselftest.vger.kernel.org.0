Return-Path: <linux-kselftest+bounces-13584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E1C92E884
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 14:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F1828411A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 12:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472A515B554;
	Thu, 11 Jul 2024 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YZroaWZi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05BC155C95;
	Thu, 11 Jul 2024 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702117; cv=none; b=KzEHkMY3w2suZUcRK/pyK7r/9+oZwFRf0/Ho2nb2YL++KU+90CJQMRmnsour29re6WXrndFcz5d5JJPgYhORtfYFTtb01Njff0vyA9I6ZikTjhbcwZDgpB5NcbAhN6tt2WQQbUiJrN2a2lldNwIp6qaOz3Q2d7UghrN5AA2Ytz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702117; c=relaxed/simple;
	bh=MjTItMDwPrjqToabxH1mZtK7U8+BJJQbv2qKE1U7nDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXL2fqXp5YfFsFLcxUeZft9JhIaUX0swbSO3GPjumLp+jBZdih7Jq8T98NTyScrJcybXcts+EneaSCYlEMwsLNoadwR0cGtbOBKKEvctCUTW5sEHC4WdosnJlPeg9VyoRjgnGQwY9A46yCDSgmWiqo64ZYUXGJz+NIqLU6Plt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YZroaWZi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BCTOpL001164;
	Thu, 11 Jul 2024 12:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	UKEeCMVTo5cUHJvo1oXxSFlsOYO0ytJCZT7EPHIaaY4=; b=YZroaWZivveVDbwo
	YUxkxzM2KgGBua6Yws++n83Us2IRQ7+oLpzNQ2feDeU5azU5AQEdBD9ygLo4rnNs
	3O6ZpFO3y0LLzGZASdxbT6Ap3sM3XHmEhq/ys7y8yUUYKDThBltBR7iRt3XsIltU
	/pHg3o+wBPjvkFCEcxVj2SP9lTO/3O2L1SdIXIPO4ImP4dQ0zImD+abf6/fgn+cH
	1UN7KD6VFQEbTvrcOwMBclfFrr8xsz3gLg3Iv9d17xWEIHPSGr/gcf2sqEj53EJJ
	LR+4A/miI6cODtZZalgDvJ5VwQY31o9wnFDfbBS474xTn4n5CZKAAx6ue+wFBFqd
	Q2+EQQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40afe5r1e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 12:48:30 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46BCmT3m031398;
	Thu, 11 Jul 2024 12:48:29 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40afe5r1dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 12:48:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46BA8gls014029;
	Thu, 11 Jul 2024 12:48:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jy3get2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 12:48:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46BCmN3E59769322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 12:48:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 815D62004D;
	Thu, 11 Jul 2024 12:48:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0717320043;
	Thu, 11 Jul 2024 12:48:23 +0000 (GMT)
Received: from darkmoore (unknown [9.171.19.34])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 11 Jul 2024 12:48:22 +0000 (GMT)
Date: Thu, 11 Jul 2024 14:48:20 +0200
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
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
Message-ID: <20240711144820.05a6d27a.schlameuss@linux.ibm.com>
In-Reply-To: <20240709190658.5cffc1ba@p-imbrenda.boeblingen.de.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
	<20240709125704.61312-9-schlameuss@linux.ibm.com>
	<20240709190658.5cffc1ba@p-imbrenda.boeblingen.de.ibm.com>
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
X-Proofpoint-GUID: 2l4C9OvP0CKoDVUXnOV_xDfXWYgBeoP6
X-Proofpoint-ORIG-GUID: H_QnUTLseI139sVhwb3TLR85lhGxzpiS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=635 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407110088

On Tue, 9 Jul 2024 19:06:58 +0200
Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:

> On Tue,  9 Jul 2024 14:57:03 +0200
> Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:
> 
> > Add a test case manipulating s390 storage keys from within the ucontrol
> > VM.
> > 
> > Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> > ---
> >  .../selftests/kvm/s390x/ucontrol_test.c       | 83 +++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> > 

[...]

> > +	/* set register content for test_skey_pgm to access not mapped memory*/  
> 
> missing space before */
> 

Fixing...

> > +	sync_regs->gprs[1] = skeyvalue;
> > +	sync_regs->gprs[5] = self->base_gpa;
> > +	sync_regs->gprs[6] = test_vaddr;
> > +	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> > +
> > +	run->kvm_dirty_regs |= KVM_SYNC_CRS;
> > +	TH_LOG("set CR0 to 0x%llx", sync_regs->crs[0]);
> > +
> > +	self->sie_block->ictl |= ICTL_OPEREXC | ICTL_PINT;
> > +	self->sie_block->cpuflags &= ~CPUSTAT_KSS;
> > +	run->psw_mask = 0x0400000180000000ULL;  /* DAT enabled + 64 bit mode */
> > +	run->psw_addr = self->code_gpa;
> > +	ASSERT_EQ(0, uc_run_once(self));
> > +	ASSERT_EQ(true, uc_handle_exit(self));
> > +	ASSERT_EQ(0, sync_regs->gprs[0]);
> > +	ASSERT_EQ(13, run->exit_reason);  
> 
> can you use macros here instead of magic values?
> 
> > +	ASSERT_EQ(40, sie_block->icptcode);  
> 
> same here
> 

Yes, I should have done that from the beginning.

[...]



