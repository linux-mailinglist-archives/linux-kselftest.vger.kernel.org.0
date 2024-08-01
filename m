Return-Path: <linux-kselftest+bounces-14658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5526B944EC0
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 17:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DA31F22B28
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4034C13B5B4;
	Thu,  1 Aug 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nk2dCEcq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24813B5A6;
	Thu,  1 Aug 2024 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524799; cv=none; b=B/fwyVbzuKQA4cff1MgtNitrhMA/kPVeaIABaT6vm+tB6zF96Zp//KmCvKCC7uB0SFjJDpQeAjRdFqXLo+xPjSoNS7bOKQ91xo0ZynjXhbSNOK2mC5iLw8pyN1ZnKkjX+PrVO2W16mrGQt8ZIgmuNY+w+eetcOkIvaNhPUaSByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524799; c=relaxed/simple;
	bh=f/PIjaNsyFEjsegwxwGwOoPM5O7TpgvYy9TNg4JeDr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4gmFDFtY3ukyf41fHTh1Zbn8AbSNdNeZ6HkFCL+lWrc4U5FsF2XH8GvPC5IvnYBxwSfTWPPQlPcf38XHSfWbetSr1GY3rX8CvkUjHC1hvutoWZCFZuYVay4wJi3sWyTVX4i+WzKolIDHQYzgEcmtf4VyQvHx+vwnQ5oCnO23lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nk2dCEcq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471BR1Ju012462;
	Thu, 1 Aug 2024 15:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	Wrpw/Oj0t4PU//9fSYE0T/rzsi45ifkJQqqCsVWX3W8=; b=Nk2dCEcq8iOsyCod
	sNX20V5QsqRKS9W7CFt/jrfELLPU6P5zJYHTO02nQ/Nk9I69qGIthaPyh1JPVpav
	HF2iTdMFQ4AdbLVQBTC0ahylfIj6zJ/F+DfZPGqbVo4M+Gg6aGUoML1epjfP+cx7
	OulMzlK1xp5Hu1PrXtjBBmJdrphb9lNsUG/WBru/x8pv6zblznPS+hHVB9g2tNun
	hswNSDnSbm8RMnI97tn50uDJMsSYJ85r08SFAj9LTMXLJjQTqU2h6r83BVpMvq5k
	L7AmuviqJ4DywL5jpmQ8JsevapuPk8GI9EteA2PEYGVFMwWKGZEZhIFKg5No74Yg
	U9gSTA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40r3tpsdwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 15:06:25 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 471F6PVG026778;
	Thu, 1 Aug 2024 15:06:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40r3tpsdwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 15:06:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 471Esheg029100;
	Thu, 1 Aug 2024 15:06:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm12k32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 15:06:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 471F6IV851446126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 15:06:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADA4A20043;
	Thu,  1 Aug 2024 15:06:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DB1320040;
	Thu,  1 Aug 2024 15:06:18 +0000 (GMT)
Received: from darkmoore (unknown [9.179.23.97])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  1 Aug 2024 15:06:17 +0000 (GMT)
Date: Thu, 1 Aug 2024 17:06:15 +0200
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
Subject: Re: [PATCH v3 07/10] selftests: kvm: s390: Add uc_map_unmap VM test
 case
Message-ID: <20240801170615.7ae660b8.schlameuss@linux.ibm.com>
In-Reply-To: <0b323867-a2f8-4bae-9f33-02ecf8362a13@linux.ibm.com>
References: <20240730072413.143556-1-schlameuss@linux.ibm.com>
	<20240730072413.143556-8-schlameuss@linux.ibm.com>
	<0b323867-a2f8-4bae-9f33-02ecf8362a13@linux.ibm.com>
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
X-Proofpoint-GUID: 4UWn2-wLIbYKO1YQVTE_eqAbT8JYvG5e
X-Proofpoint-ORIG-GUID: MZZ11_489Fa0UuigIPgxN5yo9ZEz9igN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_13,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=982 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408010097

On Thu, 1 Aug 2024 11:08:30 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 7/30/24 9:24 AM, Christoph Schlameuss wrote:
> > Add a test case verifying basic running and interaction of ucontrol VMs.
> > Fill the segment and page tables for allocated memory and map memory on
> > first access.
> > 
> > * uc_map_unmap
> >    Store and load data to mapped and unmapped memory and use pic segment
> >    translation handling to map memory on access.
> > 
> > Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> > ---
> >   .../selftests/kvm/s390x/ucontrol_test.c       | 165 +++++++++++++++++-
> >   1 file changed, 164 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > index 817b1e08559c..b7f760f980fd 100644
> > --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > @@ -16,7 +16,13 @@
> >   #include <linux/capability.h>
> >   #include <linux/sizes.h>
> >   
> > +#define UC_PIC_SEGMENT_TRANSLATION 0x10  
> 
> That's a bit clearer and used by KVM:
> #define PGM_SEGMENT_TRANSLATION		0x10
> 

I will rename the constant here. (The original constant is defined in
kvm_host.h which is not pulled into the userspace selftests.)
Also since this is only used here so far and does not really fit into
processor.h or sie.h, I would leave that here for now.

[...]

> > @@ -245,7 +338,11 @@ static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
> >   		break;
> >   	case ICPT_INST:
> >   		/* end execution in caller on intercepted instruction */
> > +		pr_info("sie instruction interception\n");  
> 
> That should have been part of an earlier patch?
> 

Yes, on closer observation this is actually already needed in patch 6:
"selftests: kvm: s390: Add VM run test case".

I will also make sure all patches do run on its own again before
sending the next version.

Good catch, thank you.

[...]

I will also fix up the comments as advised.

Christoph

