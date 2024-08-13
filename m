Return-Path: <linux-kselftest+bounces-15208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70677950321
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 12:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF411F21CD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEB819AA63;
	Tue, 13 Aug 2024 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UA0we/aN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00419412F;
	Tue, 13 Aug 2024 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546750; cv=none; b=qcXMnpNYNakwCaeazEfFRnS8PTALC437mFATdFmJRzJ0BLyEHrGlFAXzjh0rWJmo10pHJ84l+hroZUdG3ueaZHb69euOWUgTvANEOeVVN+VyCMHV6jPgvS5uw9DDk4AQzdkeNEdv6oLMlRZtQMsM1YV/CeJvbgkOSKEAUEBY9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546750; c=relaxed/simple;
	bh=3Hg1d0q3PaFfnCAN8/nimKc+SRolk1WgNo4zb7AOCnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWLB7MtetFG1IMLwPwA+WpyZJurYHx5XKG+B6Avki2ACDwNxp1/kSZPhlJ31/QTmsX48LZkni6FPHUgt5VfBZuJZT0ZbkrI9uvRANYpzkx8cxkIaxM69S9/eHJdEkZmWgIJvIk7LmVEWOGt4WIqIlNbCR/fCTmb/5xx791+XwAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UA0we/aN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D17DCx023368;
	Tue, 13 Aug 2024 10:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=EMHSqVSaNDDVL+/5VuZ9DPquIo0
	UnfhZK5n6GmCJef8=; b=UA0we/aN7OZ9D0IVaQkNkCotjuE59KtuBH9+slJkss/
	vhtXL4UBuLpdGQIQE+uc+gS2tYu3Lh859OY3BxqWO6WIlv11C9cS/XuhV3E6eHWP
	PHvFWeDsYofdiuENZjyLQWSMF+7OtPzO3/Ec0UjmshRKICW34dN4F/nAFJdl+vho
	H5eRJk/2D8ZARsWNqWaiAf1HnF+82/4FnfM/wDhIm35ZpCmcw+GEsTXmrIw/MZLK
	cZHCDz04nmAV+Yy4W+LJFZDV2HfULpLQUW5rTi+Da1NAkV/k2osC08V01PlDDBZz
	oRZbY1aZ7TWX5tYKEQ18vG+pnALyTNtdXy4qGh3FdgQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyuxqatt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:59:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47DAwNsJ008760;
	Tue, 13 Aug 2024 10:59:04 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyuxqatr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:59:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47D7YRYL010068;
	Tue, 13 Aug 2024 10:59:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xjx0kaga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:59:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47DAwvin57737570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 10:58:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E1E420043;
	Tue, 13 Aug 2024 10:58:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92FB720040;
	Tue, 13 Aug 2024 10:58:56 +0000 (GMT)
Received: from darkmoore (unknown [9.171.80.42])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Aug 2024 10:58:56 +0000 (GMT)
Date: Tue, 13 Aug 2024 12:57:53 +0200
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v5 07/10] selftests: kvm: s390: Add uc_map_unmap VM test
 case
Message-ID: <20240813123526.256667.schlameuss@linux.ibm.com>
References: <20240807154512.316936-1-schlameuss@linux.ibm.com>
 <20240807154512.316936-8-schlameuss@linux.ibm.com>
 <c1af035e-2bc3-4d61-a318-11f2490cb0d5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1af035e-2bc3-4d61-a318-11f2490cb0d5@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XFG0IvWz7n4nirEgXfAwIrFEh2Wk8G6z
X-Proofpoint-ORIG-GUID: RpSJJQzcW7JmePmFh9JlzNNr4fPwZtUP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_02,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130075

On Tue, Aug 13, 2024 at 09:21:12AM +0200, Janosch Frank wrote:
> On 8/7/24 5:45 PM, Christoph Schlameuss wrote:
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
> >   .../selftests/kvm/s390x/ucontrol_test.c       | 167 +++++++++++++++++-
> >   1 file changed, 166 insertions(+), 1 deletion(-)
> > 
> 
> [...]
> 
> > +static void init_st_pt(FIXTURE_DATA(uc_kvm) * self)
> > +{
> > +	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
> > +	u64 first_pt_addr, ste, s_addr, pte;
> > +	struct kvm_run *run = self->run;
> > +	void *se_addr;
> > +	int si, pi;
> > +	u64 *phd;
> > +
> > +	/* set PASCE addr */
> > +	self->pgd = self->base_gpa + SZ_1M;
> > +	phd = gpa2hva(self, self->pgd);
> > +	memset(phd, 0xff, VM_MEM_TABLE_SIZE);
> > +
> > +	first_pt_addr = self->pgd + (VM_MEM_TABLE_SIZE * VM_MEM_MAX_M);
> > +	/* for each segment in the VM */
> > +	for (si = 0; si < VM_MEM_MAX_M; si++) {
> > +		/* build segment table entry (ste) */
> > +		ste = (first_pt_addr + (VM_MEM_TABLE_SIZE * si)) & ~0x7fful;
> > +		/* store ste in st */
> > +		phd[si] = ste;
> > +
> > +		se_addr = gpa2hva(self, phd[si]);
> > +		s_addr = self->base_gpa + (si * SZ_1M);
> > +		memset(se_addr, 0xff, VM_MEM_TABLE_SIZE);
> > +		/* for each page in the segment (VM) */
> > +		for (pi = 0; pi < (SZ_1M / PAGE_SIZE); pi++) {
> > +			/* build page table entry (pte) */
> > +			pte = (s_addr + (pi * PAGE_SIZE)) & ~0xffful;
> > +			/* store pte in pt */
> > +			((u64 *)se_addr)[pi] = pte;
> > +		}
> > +	}
> > +	pr_debug("segment table entry %p (0x%lx) --> %p\n",
> > +		 phd, phd[0], gpa2hva(self, (phd[0] & ~0x7fful)));
> > +	print_hex_bytes("st", (u64)phd, 64);
> > +	print_hex_bytes("pt", (u64)gpa2hva(self, phd[0]), 128);
> > +
> > +	/* PASCE TT=00 for segment table */
> > +	sync_regs->crs[1] = self->pgd | 0x3;
> > +	run->kvm_dirty_regs |= KVM_SYNC_CRS;
> > +}
> 
> Having a closer look at this I don't understand why we need to setup DAT in
> the guest. Also, the guest's memory easily fits in a couple of segment
> entries so you could set the table length TL in the ASCE to one page instead
> of 4.
> 

I did only create the tables to be able to switch the DAT on and with that use a
PSW that is a bit more normal.
Switching the DAT off will work fine for the tests here without loosing any
coverage in KVM. So I will remove it here and in the skey test.

