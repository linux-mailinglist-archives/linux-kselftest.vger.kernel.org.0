Return-Path: <linux-kselftest+bounces-4845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A6857908
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 10:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B908A281ABB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87BD1BC43;
	Fri, 16 Feb 2024 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pCBAnhKi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7CE1BC2F;
	Fri, 16 Feb 2024 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076426; cv=none; b=QTRvBKyyVEkPBiZYtBMcIaGzlNROX5IZC6XtvnjCrqKWgYaVEYUkyw12r3PhRjGLtourc0HWknerlG4r9p8dNRPJbU0o9bx1B04zjuZQHdf/Vx9R6HPMQPpiO0mx/yszXpyNO+97GwJgt4rL/29vmuk3bhfnu28lK9ohyPB3Kjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076426; c=relaxed/simple;
	bh=+M0Bh5dPDC946tqsYFBb4OZufZG3vd4AaXIDY/lNsVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb1p/cAiEm+Y4usLBQLCvUyDXnWCCLqdIP0BtfsaY9NUsjxqAWx1wgxGjTRhlrrOf8GfWvAZN7MCZF0Ag51PY6t7cgSt8TlIh52wbVj129GE1SZTQ4LO2sUqBNzTsMZIPsnIEg4CE1tUgagUeqP2Cvwiq/E7t0eebyxibijV0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pCBAnhKi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41G9QA9G012536;
	Fri, 16 Feb 2024 09:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=zAsLtGFpP4IyOLvJE3BieRpoV7Loz6/31vxdx3CjAAQ=;
 b=pCBAnhKijy6NxDkQYGJWBv/Rza+9Ng2zqF0qzLevQsblY+fBh8YpZXSQpiOEKwwmWL3g
 yAT0ZldwGWPhQQlaa6WPLmPQVtwoEZupuwqPOjf8pY5+i2R/6mcLM6Nbekp7fpimYfgM
 RyQMWbdrV/y866tmop1G3rLp9/IN3THbEgyXwo3UgAE7PHTelxWxV+3kqfilekEOyvnz
 ywS1I4kjfrHpjsENdBJpIfFt49YWZl1VTgwkKgLOvsIuibmGSEYY0v3G5BV9ljpc1ArD
 mbyWFAkYClspPqQgTHEaqC2NLtkPN2tKiaRmOG1eWvYTZ6S3d3g4jtGxFJbNU4h7femg RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa3psj63d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 09:40:22 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41G9RAXk016214;
	Fri, 16 Feb 2024 09:40:21 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa3psj62j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 09:40:21 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41G8I538010063;
	Fri, 16 Feb 2024 09:40:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npma314-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 09:40:20 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41G9eF6J44434118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 09:40:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12AB920065;
	Fri, 16 Feb 2024 09:40:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E9E72006A;
	Fri, 16 Feb 2024 09:40:14 +0000 (GMT)
Received: from osiris (unknown [9.171.20.191])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 16 Feb 2024 09:40:14 +0000 (GMT)
Date: Fri, 16 Feb 2024 10:40:12 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: s390: load guest access registers in MEM_OP
 ioctl
Message-ID: <20240216094012.8060-A-hca@linux.ibm.com>
References: <20240215205344.2562020-1-farman@linux.ibm.com>
 <20240215205344.2562020-2-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215205344.2562020-2-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7mL4wp-HJVito2_avf529Zzhyb9JZwKt
X-Proofpoint-GUID: 0NudZyVlVGKn1sKqlABqljk_nBesHxs0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_08,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=856 bulkscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160077

On Thu, Feb 15, 2024 at 09:53:43PM +0100, Eric Farman wrote:
> The routine ar_translation() can be reached by both the instruction
> intercept path (where the access registers had been loaded with the
> guest register contents), and the MEM_OP ioctls (which hadn't).
> This latter case means that any ALET the guest expects to be used
> would be ignored.
> 
> Fix this by swapping the host/guest access registers around the
> MEM_OP ioctl, in the same way that the KVM_RUN ioctl does with
> sync_regs()/store_regs(). The full register swap isn't needed here,
> since only the access registers are used in this interface.
> 
> Introduce a boolean in the kvm_vcpu_arch struct to indicate the
> guest ARs have been loaded into the registers. This permits a
> warning to be emitted if entering this path without a proper
> register setup.
> 
> Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  1 +
>  arch/s390/kvm/gaccess.c          |  2 ++
>  arch/s390/kvm/kvm-s390.c         | 11 +++++++++++
>  3 files changed, 14 insertions(+)
...
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 5bfcc50c1a68..33587bb4c9e8 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -391,6 +391,8 @@ static int ar_translation(struct kvm_vcpu *vcpu, union asce *asce, u8 ar,
>  	if (ar >= NUM_ACRS)
>  		return -EINVAL;
>  
> +	WARN_ON_ONCE(!vcpu->arch.acrs_loaded);
> +
>  	save_access_regs(vcpu->run->s.regs.acrs);

Why not simply:

	if (vcpu->arch.acrs_loaded)
		save_access_regs(vcpu->run->s.regs.acrs);

?

This will always work, and the WARN_ON_ONCE() would not be needed. Besides
that: _if_ the WARN_ON_ONCE() would trigger, damage would have happened
already: host registers would have been made visible to the guest.

Or did I miss anything?

> +	/* Swap host/guest access registers */
> +	save_access_regs(vcpu->arch.host_acrs);
> +	restore_access_regs(vcpu->run->s.regs.acrs);
> +	vcpu->arch.acrs_loaded = true;
> +
>  	acc_mode = mop->op == KVM_S390_MEMOP_LOGICAL_READ ? GACC_FETCH : GACC_STORE;
>  	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
>  		r = check_gva_range(vcpu, mop->gaddr, mop->ar, mop->size,
> @@ -5420,6 +5428,9 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
>  		kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
>  
>  out_free:
> +	save_access_regs(vcpu->run->s.regs.acrs);
> +	restore_access_regs(vcpu->arch.host_acrs);
> +	vcpu->arch.acrs_loaded = false;

... these two hunks wouldn't be required if the code above would be changed
like I proposed.

