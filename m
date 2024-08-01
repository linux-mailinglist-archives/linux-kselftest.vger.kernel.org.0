Return-Path: <linux-kselftest+bounces-14598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5AF944524
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 09:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FB01C21618
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 07:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28751374F1;
	Thu,  1 Aug 2024 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jaLDPIXV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2850157493;
	Thu,  1 Aug 2024 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495939; cv=none; b=c/kSs+eiKLIRMaB/CEMxR767pW29KdHrd78qcqa7I4HKd+4LKmVC5OYA2Fb60zDHJQsz7aZMjO0M3RvATKGWk3j6To/7EXWccz051Q0xVgg44GUb4hNRjoOtIBgafsoi2nJIIJrXtE3Y3RCGe6TRWWRXJQ7rOtlifzqONNFqDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495939; c=relaxed/simple;
	bh=XraUQjCtFf8ztpF2D3fU8kOVCXFn67HeKZIDZGXiLIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNiDYjtMiXvcZzwPxTlyqI0ATcJ4cjooEQO9I4R3iHNRmHqy7ELj7nd1RUuZ5uJE4Ut5TNhP+ZSNAUvkot5Odsx1bpF3BHonSCjKb1q+uZsqrC9d9jXqbI0L8FXsPBxZRagu/WF09V1hKRwI0Y5tMc97vz7fh3Z379z8LxaNVuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jaLDPIXV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47150EfY027967;
	Thu, 1 Aug 2024 07:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	OKGrkHEK7wXuO+ka2Pne/x8eBnaRNHWYgDurxw264VQ=; b=jaLDPIXVC16ZRKg5
	Xj/zlhoogDmwL+6AHs49xPrXW349DSh5+7Afd9ozr/fVJ0sezO8WbbGZvg3ZeH/b
	WlZ8Ib3aiHSBv3mqQdSq4eWFTp0eTvzslNT2Ce/TyWO8l9104qg2TMxxjLPSwnMX
	30KtMtu1wjyWbt192uwrJYDMkKVS39d3s7EWSJlbI8FSb7SWj3IrifebfAVifMXg
	SEi4iX52ZtfWpXwgayu0zY8TEmI0RePT1ccCEPZNM2gnFK6WOBSyRK7G9B9r0I7x
	t5Hdsb1W7RB3MkDUtCQzIt+M7jSEViZyw0XLtw3tuZfRIOY7xHib9vrbhGfmCM7G
	pAvK7w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qx3cs0y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 07:05:33 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47175XrW020494;
	Thu, 1 Aug 2024 07:05:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qx3cs0y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 07:05:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47146p28029118;
	Thu, 1 Aug 2024 07:05:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm10gxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 07:05:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47175Psk30671566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 07:05:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F39720040;
	Thu,  1 Aug 2024 07:05:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1844320043;
	Thu,  1 Aug 2024 07:05:25 +0000 (GMT)
Received: from darkmoore (unknown [9.179.23.97])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  1 Aug 2024 07:05:25 +0000 (GMT)
Date: Thu, 1 Aug 2024 09:05:22 +0200
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
Subject: Re: [PATCH v3 06/10] selftests: kvm: s390: Add VM run test case
Message-ID: <20240801090522.1e92849e.schlameuss@linux.ibm.com>
In-Reply-To: <59ab0ce7-9434-4f99-9fb5-dcf6bf90fb2f@linux.ibm.com>
References: <20240730072413.143556-1-schlameuss@linux.ibm.com>
	<20240730072413.143556-7-schlameuss@linux.ibm.com>
	<59ab0ce7-9434-4f99-9fb5-dcf6bf90fb2f@linux.ibm.com>
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
X-Proofpoint-GUID: WB_bdQYMj_kh5daxP94B1Izq_Nlci7am
X-Proofpoint-ORIG-GUID: psQ76GLVwQfEveDoxHT0awHRGskNwHkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_04,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408010038

On Wed, 31 Jul 2024 16:37:19 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 7/30/24 9:24 AM, Christoph Schlameuss wrote:
> > Add test case running code interacting with registers within a
> > ucontrol VM.
> > 
> > * Add uc_gprs test case
> > 
> > The test uses the same VM setup using the fixture and debug macros
> > introduced in earlier patches in this series.
> > 
> > Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> > ---
> >   .../selftests/kvm/s390x/ucontrol_test.c       | 126 ++++++++++++++++++
> >   1 file changed, 126 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > index 029233374465..817b1e08559c 100644
> > --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > @@ -41,6 +41,23 @@ void require_ucontrol_admin(void)
> >   	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_UCONTROL));
> >   }  
> [...]
> > +/* verify SIEIC exit
> > + * * reset stop requests
> > + * * fail on codes not expected in the test cases
> > + */
> > +static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
> > +{
> > +	struct kvm_s390_sie_block *sie_block = self->sie_block;
> > +	struct kvm_run *run = self->run;
> > +
> > +	/* check SIE interception code */
> > +	pr_info("sieic: 0x%2x 0x%4x 0x%4x\n",  
> 
> I don't think there should be a space before the 4:
> sieic: 0x 4 0x8300 0x440000
> 
> We can automatically add in the missing 0
> 0x%02x
> 

At some point I considered that easier to read without the leading
zeroes, but even that is not even true for me any more. I will change
that to "sieic: 0x%.2x 0x%.4x 0x%.4x\n".

> > +		run->s390_sieic.icptcode,
> > +		run->s390_sieic.ipa,
> > +		run->s390_sieic.ipb);
> > +	switch (run->s390_sieic.icptcode) {
> > +	case ICPT_STOP:
> > +		/* stopped via sie V P --> ignore */
> > +		/* reset stop request */
> > +		sie_block->cpuflags = sie_block->cpuflags & ~CPUSTAT_STOP_INT;
> > +		pr_info("sie V P - cleared %.4x\n", sie_block->cpuflags);
> > +		break;  
> 
> With the added code that removes the P bit this shouldn't be called 
> anymore, no?
> 

Yes, you are right this is no longer needed. And I will remove it.

> > +	case ICPT_INST:
> > +		/* end execution in caller on intercepted instruction */
> > +		return false;
> > +	default:
> > +		TEST_FAIL("UNEXPECTED SIEIC CODE %d", run->s390_sieic.icptcode);
> > +	}
> > +	return true;
> > +}  
> 


