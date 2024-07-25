Return-Path: <linux-kselftest+bounces-14235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 436E893C3B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 16:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A3628109D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2869919B3D7;
	Thu, 25 Jul 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="obWMSMoS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93A1103;
	Thu, 25 Jul 2024 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916439; cv=none; b=Ev0qD1m11fAZ0pgUe/bV49RTeI0tz0xJDuRh/jfZfhPNrMg89BV75XlU89wwtxyVs4uiFASJNaShUjy6ihRDf+mima1IfX1wuacnq8czANUtT9f7Y4Oj8S3Ti98W725mrIbj8NKwpf4c6LpuODjMyQ2IN4y6dmABRKuQ6BNixAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916439; c=relaxed/simple;
	bh=RrUV0rnY6L0RR7kMOYx7W25Z4hmAlntxRNkHgN+IvFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zwi2t5p1pOniU/pJFcc4WR/OXermL4emkM5fqu0pJcvLsuUXFXgukhYAGAK7D46KtLZe3Q8ETGHbUd8vREpMbidWwU2rw47DvR3ycja+foyoUib5tkFJWy4xED9j2F3vhTrvGk2K7FesdqRCooi3Ln48R6EqDSDxzZxXaaXLXyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=obWMSMoS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PA0CKJ017844;
	Thu, 25 Jul 2024 14:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	UjrPEkrro1wdlirrl/2L0PO16h/JF1/s+Kd8J9Umj5g=; b=obWMSMoSmqdmQZBq
	8Byf4OCgompK8sllYi/I8YVCKr2QyiPalgPglZOZhm8uAnu4TDNzEV7Ry53QKP7z
	sfGNlhxXBiCeJj8GTenytLVbr/As22aTjONtPLxhSu7xrvR+B5+K+uNOGuBJQjkX
	+Qm3UEvPiBOrOSJ0vVa5lnB9ZnZwrIrUK4o6UKKpmoH6UDn7Gk5qBtrm9FKMmfYY
	sqVQLfGbwx8UcsdlQVlHKG/wovvdAOJvUAv20i6OpKAvMcLXUyarj4WyfT95wnLh
	CiS9TBfj92NLtWK4MNAQ1/WKzSPbGZ8GeHjo5ezbeQOR1qU4kPDz4Ema82pD7aL6
	ez43XQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40kmj3rhs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 14:07:12 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46PE7Bul018898;
	Thu, 25 Jul 2024 14:07:11 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40kmj3rhs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 14:07:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46PDtBJX009111;
	Thu, 25 Jul 2024 14:07:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gt93pw77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 14:07:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46PE74FM55902502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 14:07:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9D6D2005A;
	Thu, 25 Jul 2024 14:07:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C09620040;
	Thu, 25 Jul 2024 14:07:04 +0000 (GMT)
Received: from darkmoore (unknown [9.179.29.251])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 25 Jul 2024 14:07:04 +0000 (GMT)
Date: Thu, 25 Jul 2024 16:07:01 +0200
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
Subject: Re: [PATCH v2 06/10] selftests: kvm: s390: Add VM run test case
Message-ID: <20240725160701.569e54c5.schlameuss@linux.ibm.com>
In-Reply-To: <755de81f-f6ca-48a4-84dc-ecdc93ccf049@linux.ibm.com>
References: <20240723093126.285319-1-schlameuss@linux.ibm.com>
	<20240723093126.285319-7-schlameuss@linux.ibm.com>
	<755de81f-f6ca-48a4-84dc-ecdc93ccf049@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: YGVN4Jhde_VQbqpwh-c6YBawPa-m7XH5
X-Proofpoint-GUID: dUiHWEbepmayXZLqOmvsr13Oq8v6Wpd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_12,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 adultscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250095

On Thu, 25 Jul 2024 14:03:12 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 7/23/24 11:31, Christoph Schlameuss wrote:
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
> >   .../selftests/kvm/s390x/ucontrol_test.c       | 132 ++++++++++++++++++
> >   1 file changed, 132 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > index 527c431a9758..c98d5a3a315b 100644
> > --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > @@ -43,6 +43,23 @@ void require_ucontrol_admin(void)
> >   	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_UCONTROL));
> >   }
> >   
> > +/* Test program setting some registers and looping */
> > +extern char test_gprs_pgm[];
> > +asm("test_gprs_pgm:\n"
> > +	"xgr	%r0, %r0\n"
> > +	"lgfi	%r1,1\n"  
> [...]
> 
> Naming something PGM for handling anything else than Program Exceptions 
> is not recommendable. PGM has been a stable name on s390 for code 
> related to PGM exceptions
> 
> When first reading this I expected to find some kind of exception code.
> 

Ok, I get it now. Previously I was thinking only "test_pgm" was the
hangup. But I do understand now.
I will rename these here and in the other patches to "test_xxx_asm" to
hopefully reduce the confusion.

Christoph

