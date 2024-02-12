Return-Path: <linux-kselftest+bounces-4506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA30D8510B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 11:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4162CB2369D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E4518032;
	Mon, 12 Feb 2024 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cc7Fe6py"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0B18021;
	Mon, 12 Feb 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733498; cv=none; b=orIZu7m1MXhRxkXowefvFwzktv93BUvae04wmBVCf5g6oVSqjqXHfYDb1rxDIZ5U0gBGVqXnvqaKCI/zhAyfL2gXJBMvYtxKBbXrhArxs3mXkC/A0zCvDWmtVp/CqIeSO4mW8N8wEwlXj4Fsa/FCH8aBDJmrGKFfmE7d8Q8kZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733498; c=relaxed/simple;
	bh=KekI+KwhbIHhubJOTo0Ildr87NIL/dhgK0T8Lz4W8xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlR7Ga3brSrG4YBwM3MIPCoruQc4a1HlFJYbXGV+6+fBCmNur5pzg/1s7naV58ITC8FjHRWtZB0CIONcelk5wNLqL9IQxgFhArV0V5nkwgJuhmCtRuuqMs+U4HcQRN1wJyDLfterT+7sfBvZqY7Bm0aJRsCbyaAUBauFIyYtQag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cc7Fe6py; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CAI6Q5030654;
	Mon, 12 Feb 2024 10:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=mfAlYz+L0iM5MqMdUyMXXYV8OjQg9weeyOJA047XLUY=;
 b=cc7Fe6pyZk0BSUq9fQdOX4AO5/vKfewgNY9QHZrbWH6rwKk0/Nvbo/a4U+DEKx3U+QWK
 vCffN1YgDR75Axty+31p4F5Y6wjZ18SrpRe/tGOmoOhKi3JvGb4UOggQTaC58bFzG3vf
 jvB4Le57SkPUdViooxyXXG8R86DPtrAV9tTqGzLwk4kjxS+sFR9txGLLfUaXNqZNhuIY
 Y7qJQuvkmRl45xfSzjY7HiX/ULuKa9UUkvlZJZ9dPOPQvO/GUfNnUobTObAcHVOL2aIK
 6qoC0+aFD8DsE2rO2rug45RjTBdY3B7+g3mszAv6XXd76/hfqRhytppTEQdfWJaD+KB0 ig== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7het03a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 10:24:46 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CAIHMe031774;
	Mon, 12 Feb 2024 10:24:45 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7het02gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 10:24:43 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41C8OgWZ010060;
	Mon, 12 Feb 2024 10:21:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npkfkb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 10:21:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CALWVY4915754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 10:21:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DD9E2004F;
	Mon, 12 Feb 2024 10:21:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B1B62004B;
	Mon, 12 Feb 2024 10:21:31 +0000 (GMT)
Received: from osiris (unknown [9.171.5.16])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Feb 2024 10:21:31 +0000 (GMT)
Date: Mon, 12 Feb 2024 11:21:30 +0100
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
Subject: Re: [PATCH v1 1/2] KVM: s390: load guest access registers in MEM_OP
 ioctl
Message-ID: <20240212102130.9156-A-hca@linux.ibm.com>
References: <20240209204539.4150550-1-farman@linux.ibm.com>
 <20240209204539.4150550-2-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209204539.4150550-2-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RrKGKrwwk1y3haKGz8HgLtikp3uM8SIe
X-Proofpoint-GUID: _d_wXRZHueDcCZqlAjpqAzJmBf5oqR2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_07,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=901
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120078

On Fri, Feb 09, 2024 at 09:45:38PM +0100, Eric Farman wrote:
> The routine ar_translation() is called by get_vcpu_asce(), which is
> called by both the instruction intercept path (where the access
> registers had been loaded with the guest's values), and the MEM_OP
> ioctl (which hadn't). This means that any ALET the guest expects to
> be used would be ignored.
> 
> Furthermore, the logic in ar_translation() will store the contents
> of the access registers back to the KVM_RUN struct. This unexpected
> change of AR values can lead to problems after invoking the MEM_OP,
> for example an ALET Specification Exception.
> 
> Fix this by swapping the host/guest access registers around the
> MEM_OP ioctl, in the same way that the KVM_RUN ioctl does with
> sync_regs()/store_regs(). The full register swap isn't needed here,
> since only the access registers are used in this interface.
> 
> Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index ea63ac769889..c2dfeea55dcf 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -5391,6 +5391,10 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
>  			return -ENOMEM;
>  	}
>  
> +	/* Swap host/guest access registers in the event of a MEM_OP with AR specified */
> +	save_access_regs(vcpu->arch.host_acrs);
> +	restore_access_regs(vcpu->run->s.regs.acrs);
> +
>  	acc_mode = mop->op == KVM_S390_MEMOP_LOGICAL_READ ? GACC_FETCH : GACC_STORE;
>  	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
>  		r = check_gva_range(vcpu, mop->gaddr, mop->ar, mop->size,
> @@ -5420,6 +5424,8 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
>  		kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
>  
>  out_free:
> +	save_access_regs(vcpu->run->s.regs.acrs);
> +	restore_access_regs(vcpu->arch.host_acrs);

I guess we will end up with more and more of such constructs until nobody
knows when which register contents are loaded. I would higly prefer a TIF flag
which indicates if the access registers contain the host or guest register
contents, and actual users grab the required content from the correct location
- or better: always take it from guest save area, and write to the guest save
area if the to be invented TIF flag indicates that access registers contain
guest registers...

Or maybe a TIF flag with different semantics: "guest save area does not
reflect current state - which is within registers".

