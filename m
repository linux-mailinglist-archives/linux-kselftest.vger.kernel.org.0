Return-Path: <linux-kselftest+bounces-14865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B81949388
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 16:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D795B29811
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702501BE875;
	Tue,  6 Aug 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m8qm6qvs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18DD17ADF7;
	Tue,  6 Aug 2024 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955462; cv=none; b=OLO8kRjZPOLoc0Gau1/aJn4oDTWeiGKXauSxzVXgXLXq2rPYmWOLTJ+7dW6E8AqsIU3ApIsD6WMA8LjxfWuf8hTItTS6IS/ZShwX47uiqOd1iSosPuu5qwaOK9UQHdYk+DtR2jayKXHcRC0BO/CZrVr3FeLIWp+C90e9jVVjKLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955462; c=relaxed/simple;
	bh=0yKZy8KoZZcnYBR+6nF1cpfUdBSnUxj0VCc/DXNQDCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JkrqDOQSBEq5eBzw/WdPxHjQ19yPPWacv+Dk5m+Z8EpbYFmK6Q2mqYxICLb+5xAoPke1yRAU1F/EPLkiZKYiO78N78ZB8HY2kAIVSKnLGpODBn4EQUJO9f6/+DLDqDTDmu9Tq00w11gFshW7Ir6me+mbxEwFJ4aYiHBD2NDq9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m8qm6qvs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476DLV4C031055;
	Tue, 6 Aug 2024 14:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	6xV33/hFMWCvVf9tGKXFLcIPz/RxD2YHpaN9hc4yW2c=; b=m8qm6qvsjBwOSxfm
	7FHneDRHu+BY8QoXu0ugBdNFaC/Q5/uDT0YfXPQxGo+5C3/1si83cW1ldk4A76V6
	MnTFF0X/vGuwgzu55vTzZCLFHL7h8akiqOhb0zooqaIP+TS7sDVchp0WNGJ/NbzD
	tvUI3G/UnPNtbSMoK9LOB+3NZyUUNDwFtoO6HNeWqrK9Esb+5B8UzqFerUevaIpy
	J7wuuw6q+sR4ubLrfk2fmxYXKrRCMnCbLM7Ysc1pPADrcDvNwr8BvTCrtLEW9b35
	zJzCq4y8IluTQqWQy3W9NUp8XYVx6U+V2Ex1FI2SHtAbuBcH8wjZtQ8VzhWZ3hpb
	4uP+Pw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uf1hrym7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 14:44:15 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 476EiEB7012516;
	Tue, 6 Aug 2024 14:44:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uf1hrym5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 14:44:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 476Bg3Fj024121;
	Tue, 6 Aug 2024 14:44:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40syvpc4rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 14:44:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 476Ei8fo31130144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Aug 2024 14:44:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CFB32004B;
	Tue,  6 Aug 2024 14:44:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 970EF20043;
	Tue,  6 Aug 2024 14:44:07 +0000 (GMT)
Received: from darkmoore (unknown [9.179.5.91])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue,  6 Aug 2024 14:44:07 +0000 (GMT)
Date: Tue, 6 Aug 2024 16:44:05 +0200
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
Subject: Re: [PATCH v4 07/10] selftests: kvm: s390: Add uc_map_unmap VM test
 case
Message-ID: <20240806164405.6edeb801.schlameuss@linux.ibm.com>
In-Reply-To: <dc515da5-6b22-4e15-acfe-d7d0849d16a6@linux.ibm.com>
References: <20240802155913.261891-1-schlameuss@linux.ibm.com>
	<20240802155913.261891-8-schlameuss@linux.ibm.com>
	<dc515da5-6b22-4e15-acfe-d7d0849d16a6@linux.ibm.com>
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
X-Proofpoint-GUID: FIXWTtPVKLftAlX1YjxE9Pato2mEff9t
X-Proofpoint-ORIG-GUID: Cu6KRZJDS84BWckvarhSnEQuEIOb9UYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_12,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1015 spamscore=0
 mlxlogscore=930 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408060100

On Tue, 6 Aug 2024 15:13:34 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 8/2/24 5:59 PM, Christoph Schlameuss wrote:
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
> > index 030c59010fe1..72ad30fbe4ac 100644
> > --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > @@ -16,7 +16,13 @@
> >   #include <linux/capability.h>
> >   #include <linux/sizes.h>  
> 
> [...]
> 
> > +#define VM_MEM_MAX (VM_MEM_SIZE + VM_MEM_EXT_SIZE)  
> 
> You defined this but never use it.
> Instead you're still adding up VM_MEM_SIZE and VM_MEM_EXT_SIZE.
> 

I will remove that.

> > +
> > +#define PAGES_PER_SEGMENT 4  
> 
> You mean pages per segment table?
> 

Yes, I did name this analog to the existing PAGES_PER_REGION from
"tools/testing/selftests/kvm/lib/s390x/processor.c".
If you think that would be useful in the future we could also pull both
constants into "processor.h".

> [...]
> 
> > +/* initialize segment and page tables for uc_kvm tests */
> > +static void init_st_pt(FIXTURE_DATA(uc_kvm) * self)
> > +{
> > +	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
> > +	struct kvm_run *run = self->run;
> > +	void *se_addr;
> > +	int si, pi;
> > +	u64 *phd;
> > +
> > +	/* set PASCE addr */
> > +	self->pgd = self->base_gpa + SZ_1M;
> > +	phd = gpa2hva(self, self->pgd);
> > +	memset(phd, 0xff, PAGES_PER_SEGMENT * PAGE_SIZE);
> > +
> > +	for (si = 0; si < ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M); si++) {
> > +		/* create ste */
> > +		phd[si] = (self->pgd
> > +			+ (PAGES_PER_SEGMENT * PAGE_SIZE
> > +				* ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M))
> > +			+ (PAGES_PER_SEGMENT * PAGE_SIZE * si)) & ~0x7fful;
> > +		se_addr = gpa2hva(self, phd[si]);
> > +		memset(se_addr, 0xff, PAGES_PER_SEGMENT * PAGE_SIZE);
> > +		for (pi = 0; pi < (SZ_1M / PAGE_SIZE); pi++) {
> > +			/* create pte */
> > +			((u64 *)se_addr)[pi] = (self->base_gpa
> > +				+ (si * SZ_1M) + (pi * PAGE_SIZE)) & ~0xffful;
> > +		}  
> 
> That's barely readable, can you split that into functions or make it 
> more readable in some other way?
> 

I will tinker a bit to make this readable.

> > +	}
> > +	pr_debug("segment table entry %p (0x%lx) --> %p\n",
> > +		 phd, phd[0], gpa2hva(self, (phd[0] & ~0x7fful)));
> > +	print_hex_bytes("st", (u64)phd, 64);
> > +	print_hex_bytes("pt", (u64)gpa2hva(self, phd[0]), 128);
> > +	print_hex_bytes("pt+", (u64)
> > +			gpa2hva(self, phd[0] + (PAGES_PER_SEGMENT * PAGE_SIZE
> > +			* ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M)) - 0x64), 128);
> > +
> > +	/* PASCE TT=00 for segment table */
> > +	sync_regs->crs[1] = self->pgd | 0x3;
> > +	run->kvm_dirty_regs |= KVM_SYNC_CRS;
> > +}
> > +  
> 


