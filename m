Return-Path: <linux-kselftest+bounces-15660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A17956F8D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 18:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E41B2607E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1166316193C;
	Mon, 19 Aug 2024 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ex/M0rHN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2C13B5AF;
	Mon, 19 Aug 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083271; cv=none; b=IHttvYh1IjjPlB6rsCd+H0HBk6LVPGfQ4ThygThs1krWfX6qAPrMUz3SrCxH4nzBAXBUxEbQEszPF1+SncWczTKZ1bxBxCBPpPrtIlSbUKyRMXIUlzVTEwGyk3Z7EwPZxgILDJvHPijth6WrNjYV7OdIWSs/Gn//5VmbhjebOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083271; c=relaxed/simple;
	bh=fXXAqt1YPwYtxTiWk8BTaJmPqegxmIyUqP9bAIbB6Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCz+h71xjNE5GAtnALAtsGTfgeJFYNuPQLhGfZgMTQ6S7FKtuJ2HiSpsaNApduV/ZYv0jcpEK+0VJYuuUBzq7zBbOLZYqmlw7yLExcG2tqPoGILtIFShWZImhfjweA2+xDvDIKXuol4uKkFbNoWYwVuqVZgDadRuneFoLjgS3vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ex/M0rHN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J7kpZY004580;
	Mon, 19 Aug 2024 16:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=T7G4nb8U1Bham5UYQBM+MSjBoFH
	onYEYM5RWeVextI8=; b=ex/M0rHN+kLj+WKuHkbY4runD4hLOKYCtOSVJjqcPAN
	vls5ClCpl4RYFoLeJnFuOoz125MI4uCrrO75iEMfzJLTIyUtr600x4S/dCQLb6s8
	LSldFFeFIHPOpw31JkIFaVsbV2pu464dDCryHvg2JYODKAf+6V5xmptMLAh9xF8r
	56IUJKXkm66di4njxFyhePHx5B16uJWgv9aR4piykUUwqnbRL6q8wcRUV4Q4y4wh
	SZ6CAMm+FCgmggPPec6xXUEvnjU+SIVT9MxsCvDdFcbQPifl7UkWYvTDpLrm6yJC
	dwqyhLhSKDIik7eyiN8DAzfgY48FVs3a5FTj11bNPFg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y1hykt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 16:01:01 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47JG11Gj011266;
	Mon, 19 Aug 2024 16:01:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y1hykd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 16:01:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47JEOQjf017651;
	Mon, 19 Aug 2024 16:01:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138w2xfub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 16:01:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47JG0sSu49938708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 16:00:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AFEB2004B;
	Mon, 19 Aug 2024 16:00:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 228462004D;
	Mon, 19 Aug 2024 16:00:54 +0000 (GMT)
Received: from darkmoore (unknown [9.171.95.91])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 19 Aug 2024 16:00:54 +0000 (GMT)
Date: Mon, 19 Aug 2024 18:00:48 +0200
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH 2/3] selftests: kvm: s390: Add uc_skey VM test case
Message-ID: <ZsNsMMc0Ir1w0BJy@darkmoore>
References: <20240815154529.628087-1-schlameuss@linux.ibm.com>
 <20240815154529.628087-3-schlameuss@linux.ibm.com>
 <7f930ac3-a7af-47c7-8455-8c96d11754b5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f930ac3-a7af-47c7-8455-8c96d11754b5@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7iKSOl4yQD_4xGidgXXJw_U6PZWRlOgh
X-Proofpoint-ORIG-GUID: 0UuD9JQmScQ1M95LwUawmHDgMemuz4Wn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190104

On Fri Aug 16, 2024 at 4:36 PM CEST, Janosch Frank wrote:
> On 8/15/24 5:45 PM, Christoph Schlameuss wrote:
> > Add a test case manipulating s390 storage keys from within the ucontrol
> > VM.
> > 
> > Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> > ---
> >   .../selftests/kvm/s390x/ucontrol_test.c       | 76 +++++++++++++++++++
> >   1 file changed, 76 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > index 41306bb52f29..5f8815a80544 100644
> > --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > @@ -79,6 +79,32 @@ asm("test_mem_asm:\n"
> >   	"	j	0b\n"
> >   );
> >   
> > +/* Test program manipulating storage keys */
> > +extern char test_skey_asm[];
> > +asm("test_skey_asm:\n"
> > +	"xgr	%r0, %r0\n"
> > +
> > +	"0:\n"
> > +	"	ahi	%r0,1\n"
> > +	"	st	%r1,0(%r5,%r6)\n"
> > +
> > +	"	iske	%r1,%r6\n"
> > +	"	ahi	%r0,1\n"
> > +	"	diag	0,0,0x44\n"
> > +
> > +	"	sske	%r1,%r6\n"
>
> Might want to add a xgr here so you're sure that you're not reading your 
> own values if iske fails.
>

Good point. Will change the r1 value here.

> > +	"	iske	%r1,%r6\n"
> > +	"	ahi	%r0,1\n"
> > +	"	diag	0,0,0x44\n"
> > +
> > +	"	rrbe	%r1,%r6\n"
> > +	"	iske	%r1,%r6\n"
> > +	"	ahi	%r0,1\n"
> > +	"	diag	0,0,0x44\n"
> > +
> > +	"	j	0b\n"
> > +);
> > +
> >   FIXTURE(uc_kvm)
> >   {
> >   	struct kvm_s390_sie_block *sie_block;
> > @@ -345,6 +371,56 @@ static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
> >   	TEST_ASSERT_EQ(0x440000, sie_block->ipb);
> >   }
> >   
> > +TEST_F(uc_kvm, uc_skey)
> > +{
> > +	u64 test_vaddr = self->base_gpa + VM_MEM_SIZE - (SZ_1M / 2);
> > +	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
> > +	struct kvm_run *run = self->run;
> > +	u8 skeyvalue = 0x34;
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
> > +	self->sie_block->ictl |= ICTL_OPEREXC | ICTL_PINT;
> > +	self->sie_block->cpuflags &= ~CPUSTAT_KSS;
>
> So you don't want KVM to initialize skeys?
> Or am I missing a ucontrol skey interaction?
>
> What about the ICTLs if KSS is not available on the machine?

This is explicitly disabling KSS, not enabling it.
Doing that explicitly might not strictly be necessary but I thought this does
provide some clarity about the state.

