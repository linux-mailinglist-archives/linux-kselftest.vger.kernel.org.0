Return-Path: <linux-kselftest+bounces-5034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA3685BE67
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 15:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E36F2B24798
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512726A35F;
	Tue, 20 Feb 2024 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dLzjOEoE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED696A359;
	Tue, 20 Feb 2024 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438561; cv=none; b=j8KWvRfHB4adutLX9we9Wk2Rhbd1jSa3qldHQdh0ZpaNSv3YFGOpE2HMWBd0g4fx2hkWvKv2ZagYtKFtAUSb84gV4/nPnplyNteWNXO8tbov4kkypv5UkgWqK86xjg0Q9UlFKCSKVv9e6SXRPSbbLNbt63SYhBLVKhN+/oqzwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438561; c=relaxed/simple;
	bh=HArwwHt1hGrCTLbZ4EXs9mayU7DHCs/ZHiAeJX8lVqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwvOujw/W4hi3g8tMY1CqmAAaiqOB6ekYP8R0rqnfdGkfNN1a7j8I3Ay1VPbUxSbz7i8M9Wf1HZJZR3F2oVXn0saa0vL0WHoYzoH34Ymn/HgnzRfnnfu/13SsDIX1Kr1ttPYxGJ16ixledVYXr1LLJqdNXivHPs3+DMkOROEjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dLzjOEoE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KDIurZ030093;
	Tue, 20 Feb 2024 14:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+FXltmwqBAJ8c6HHejlohDnfZv970OoqMm5SuRo1gdQ=;
 b=dLzjOEoEggM3ZSd2bXhGztD1uOuNWd46b1u0woEhFAg7Fv+9XIgQ517+2Fm3il/rpoBr
 t6EF+pDEq1CS7SSSVutk88GdMSJ/jvaM3whIUwHIDD/CHNzyI70d9NbcJeSohU8Pq1QJ
 rEJd5n4HafCbA1aa/i26gMmcs328SBeiqSppa971J+MUeeEV33LmRcaMcUaWM5Pv/XR4
 bG3z11DmzICQtBFyZ23F9XEX0nkje7JwFYqG30xba+WJbmG2qDZxGE2NT2s1rMibWnk6
 HdLQ0nxX1nqZlfKlDSQYS9FzGh6WY7nUKXOBUTHo86xEiCf7fCOvSj3A9MbLGZC9ytNb oA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcvuq9g9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 14:15:55 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41KDJBAL030469;
	Tue, 20 Feb 2024 14:15:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcvuq9g9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 14:15:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41KD2BEB031187;
	Tue, 20 Feb 2024 14:15:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bkr5yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 14:15:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41KEFmJZ40305012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 14:15:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCF432004E;
	Tue, 20 Feb 2024 14:15:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 887842006A;
	Tue, 20 Feb 2024 14:15:48 +0000 (GMT)
Received: from [9.152.224.41] (unknown [9.152.224.41])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Feb 2024 14:15:48 +0000 (GMT)
Message-ID: <1d9fef3d-b793-43fc-a3f9-4ff087bc899f@linux.ibm.com>
Date: Tue, 20 Feb 2024 15:15:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] KVM: s390: fix access register usage in ioctls
To: Eric Farman <farman@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20240216213616.3819805-1-farman@linux.ibm.com>
 <20240216213616.3819805-2-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240216213616.3819805-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FXHHK-5OvbhORVbEknDOPBn3A2lgbMKX
X-Proofpoint-GUID: q4PucP4oAXJqoAo-RlP8oYU6jd640KKT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1011 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402200102



Am 16.02.24 um 22:36 schrieb Eric Farman:
> The routine ar_translation() can be reached by both the instruction
> intercept path (where the access registers had been loaded with the
> guest register contents), and the MEM_OP ioctls (which hadn't).
> Since this routine saves the current registers to vcpu->run,
> this routine erroneously saves host registers into the guest space.
> 
> Introduce a boolean in the kvm_vcpu_arch struct to indicate whether
> the registers contain guest contents. If they do (the instruction
> intercept path), the save can be performed and the AR translation
> is done just as it is today. If they don't (the MEM_OP path), the
> AR can be read from vcpu->run without stashing the current contents.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h | 1 +
>   arch/s390/kvm/gaccess.c          | 3 ++-
>   arch/s390/kvm/kvm-s390.c         | 3 +++
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 52664105a473..c86215eb4ca7 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -765,6 +765,7 @@ struct kvm_vcpu_arch {
>   	__u64 cputm_start;
>   	bool gs_enabled;
>   	bool skey_enabled;
> +	bool acrs_loaded;
>   	struct kvm_s390_pv_vcpu pv;
>   	union diag318_info diag318_info;
>   };
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 5bfcc50c1a68..b4c805092021 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -391,7 +391,8 @@ static int ar_translation(struct kvm_vcpu *vcpu, union asce *asce, u8 ar,
>   	if (ar >= NUM_ACRS)
>   		return -EINVAL;
>   
> -	save_access_regs(vcpu->run->s.regs.acrs);
> +	if (vcpu->arch.acrs_loaded)
> +		save_access_regs(vcpu->run->s.regs.acrs);
>   	alet.val = vcpu->run->s.regs.acrs[ar];
>   
>   	if (ar == 0 || alet.val == 0) {
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index ea63ac769889..61092f0e0a66 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3951,6 +3951,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>   				    KVM_SYNC_ARCH0 |
>   				    KVM_SYNC_PFAULT |
>   				    KVM_SYNC_DIAG318;
> +	vcpu->arch.acrs_loaded = false;
>   	kvm_s390_set_prefix(vcpu, 0);
>   	if (test_kvm_facility(vcpu->kvm, 64))
>   		vcpu->run->kvm_valid_regs |= KVM_SYNC_RICCB;
> @@ -4951,6 +4952,7 @@ static void sync_regs(struct kvm_vcpu *vcpu)
>   	}
>   	save_access_regs(vcpu->arch.host_acrs);
>   	restore_access_regs(vcpu->run->s.regs.acrs);
> +	vcpu->arch.acrs_loaded = true;
>   	/* save host (userspace) fprs/vrs */
>   	save_fpu_regs();
>   	vcpu->arch.host_fpregs.fpc = current->thread.fpu.fpc;
> @@ -5021,6 +5023,7 @@ static void store_regs(struct kvm_vcpu *vcpu)
>   	kvm_run->s.regs.pfc = vcpu->arch.pfault_compare;
>   	save_access_regs(vcpu->run->s.regs.acrs);
>   	restore_access_regs(vcpu->arch.host_acrs);
> +	vcpu->arch.acrs_loaded = false;
>   	/* Save guest register state */
>   	save_fpu_regs();
>   	vcpu->run->s.regs.fpc = current->thread.fpu.fpc;

