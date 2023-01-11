Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E1D6657A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 10:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjAKJiA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Jan 2023 04:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbjAKJhQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Jan 2023 04:37:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684C95FB9;
        Wed, 11 Jan 2023 01:35:59 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B8ESKJ028778;
        Wed, 11 Jan 2023 09:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cMeLYwUHJaBzrxiVs1Yme3g+08qNmcBVEEaCE/QuFuE=;
 b=BPhgPtd8LSHcE4dDX1aEWS9D+0j0Djq2phhfyFH+7c9hDzbDxXm/x1S9dkZdiGieGZTl
 xxnMZGtsqpd/fIHAxvk7LUXf7csuUuABLiKzBVk/7vwsLTIDGEF1H5lGS1WDKeyByUZk
 l3AH9Elz0Nqki/kAGQhpuIHqHHsOe6xYrJt3Bjm1aKpjI83wXRxE4ksdkz+mQoFADaAy
 zmXZx3k1ALkx03MNkZJ8SQnugEhiTLrIR9h1qXplhuc4gSIR0O7yD9A/WmqdGghJ6XOS
 +Zpb6jM1ZmM/vSc3CRjJaWDOB8xsunzz3rC3yuxVSD4/SQo8UtQ+k3h07esy9z+AgPBi YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1se8spw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 09:35:55 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30B8lSZt027166;
        Wed, 11 Jan 2023 09:35:54 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1se8spvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 09:35:54 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30B1cr7K001499;
        Wed, 11 Jan 2023 09:35:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3n1kmrrdfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 09:35:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30B9ZmHm44564878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 09:35:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8172620049;
        Wed, 11 Jan 2023 09:35:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC36820040;
        Wed, 11 Jan 2023 09:35:47 +0000 (GMT)
Received: from [9.171.7.243] (unknown [9.171.7.243])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jan 2023 09:35:47 +0000 (GMT)
Message-ID: <02b34aa1-d71a-99cc-77db-3613f881b1a8@linux.ibm.com>
Date:   Wed, 11 Jan 2023 10:35:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20230110202632.2533978-1-scgl@linux.ibm.com>
 <20230110202632.2533978-2-scgl@linux.ibm.com>
Content-Language: en-US
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v5 01/10] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
In-Reply-To: <20230110202632.2533978-2-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R-wYDDAboRiZQoxtd8tpSPq3PipSCmYE
X-Proofpoint-ORIG-GUID: Nn_TKUpmqH_yDJdF5Ziso0mC49lII-sd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_04,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301110073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/10/23 21:26, Janis Schoetterl-Glausch wrote:
> User space can use the MEM_OP ioctl to make storage key checked reads
> and writes to the guest, however, it has no way of performing atomic,
> key checked, accesses to the guest.
> Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
> mode. For now, support this mode for absolute accesses only.
> 
> This mode can be use, for example, to set the device-state-change
> indicator and the adapter-local-summary indicator atomically.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   include/uapi/linux/kvm.h |   7 +++
>   arch/s390/kvm/gaccess.h  |   3 ++
>   arch/s390/kvm/gaccess.c  | 102 +++++++++++++++++++++++++++++++++++++++
>   arch/s390/kvm/kvm-s390.c |  41 +++++++++++++++-
>   4 files changed, 151 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 55155e262646..452f43c1cc34 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -583,6 +583,8 @@ struct kvm_s390_mem_op {
>   		struct {
>   			__u8 ar;	/* the access register number */
>   			__u8 key;	/* access key, ignored if flag unset */
> +			__u8 pad1[6];	/* ignored */
> +			__u64 old_addr;	/* ignored if flag unset */
>   		};
>   		__u32 sida_offset; /* offset into the sida */
>   		__u8 reserved[32]; /* ignored */
> @@ -599,6 +601,11 @@ struct kvm_s390_mem_op {
>   #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
>   #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
>   #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
> +#define KVM_S390_MEMOP_F_CMPXCHG		(1ULL << 3)
> +/* flags specifying extension support */

Would that fit behind the bit shifts without getting into the "line too 
long" territory?

> +#define KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG 0x2

\n please

> +/* Non program exception return codes (pgm codes are 16 bit) */
> +#define KVM_S390_MEMOP_R_NO_XCHG		(1 << 16)
>   
>   /* for KVM_INTERRUPT */
>   struct kvm_interrupt {
> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> index 9408d6cc8e2c..92a3b9fb31ec 100644
> --- a/arch/s390/kvm/gaccess.h
> +++ b/arch/s390/kvm/gaccess.h
> @@ -206,6 +206,9 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
>   int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
>   		      void *data, unsigned long len, enum gacc_mode mode);
>   
> +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
> +			       __uint128_t *old, __uint128_t new, u8 access_key);
> +
>   /**
>    * write_guest_with_key - copy data from kernel space to guest space
>    * @vcpu: virtual cpu
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 0243b6e38d36..6165e761a637 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -1161,6 +1161,108 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
>   	return rc;
>   }
>   
> +/**
> + * cmpxchg_guest_abs_with_key() - Perform cmpxchg on guest absolute address.
> + * @kvm: Virtual machine instance.
> + * @gpa: Absolute guest address of the location to be changed.
> + * @len: Operand length of the cmpxchg, required: 1 <= len <= 16. Providing a
> + *       non power of two will result in failure.
> + * @old_addr: Pointer to old value. If the location at @gpa contains this value, the
> + *         exchange will succeed. After calling cmpxchg_guest_abs_with_key() *@old
> + *         contains the value at @gpa before the attempt to exchange the value.
> + * @new: The value to place at @gpa.
> + * @access_key: The access key to use for the guest access.
> + *
> + * Atomically exchange the value at @gpa by @new, if it contains *@old.
> + * Honors storage keys.
> + *
> + * Return: * 0: successful exchange
> + *         * 1: exchange unsuccessful
> + *         * a program interruption code indicating the reason cmpxchg could
> + *           not be attempted

 > 1 Access related program interruption code indicating the reason 
cmpxchg could not be attempted

< 1 Kernel / input data error codes

> + *         * -EINVAL: address misaligned or len not power of two
> + *         * -EAGAIN: transient failure (len 1 or 2)
> + *         * -EOPNOTSUPP: read-only memslot (should never occur)

Would PGM_PROTECTED also make sense here instead of EOPNOTSUPP?

> + */
> +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
> +			       __uint128_t *old_addr, __uint128_t new,
> +			       u8 access_key)
> +{
> +	gfn_t gfn = gpa >> PAGE_SHIFT;
> +	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
> +	bool writable;
> +	hva_t hva;
> +	int ret;
> +
> +	if (!IS_ALIGNED(gpa, len))
> +		return -EINVAL;
> +
> +	hva = gfn_to_hva_memslot_prot(slot, gfn, &writable);
> +	if (kvm_is_error_hva(hva))
> +		return PGM_ADDRESSING;
> +	/*
> +	 * Check if it's a read-only memslot, even though that cannot occur
> +	 * since those are unsupported.
> +	 * Don't try to actually handle that case.
> +	 */
> +	if (!writable)
> +		return -EOPNOTSUPP;
> +
[...]
>   /**
>    * guest_translate_address_with_key - translate guest logical into guest absolute address
>    * @vcpu: virtual cpu
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e4890e04b210..56f4f6ddd5bb 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -584,7 +584,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_S390_VCPU_RESETS:
>   	case KVM_CAP_SET_GUEST_DEBUG:
>   	case KVM_CAP_S390_DIAG318:
> -	case KVM_CAP_S390_MEM_OP_EXTENSION:
>   		r = 1;
>   		break;
>   	case KVM_CAP_SET_GUEST_DEBUG2:
> @@ -598,6 +597,14 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_S390_MEM_OP:
>   		r = MEM_OP_MAX_SIZE;
>   		break;
> +	case KVM_CAP_S390_MEM_OP_EXTENSION:
> +		/*
> +		 * Flag bits indicating which extensions are supported.
> +		 * The first extension doesn't use a flag, but pretend it does,
> +		 * this way that can be changed in the future.
> +		 */
> +		r = KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG | 1;
> +		break;
>   	case KVM_CAP_NR_VCPUS:
>   	case KVM_CAP_MAX_VCPUS:
>   	case KVM_CAP_MAX_VCPU_ID:
> @@ -2772,12 +2779,19 @@ static bool access_key_invalid(u8 access_key)
>   static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   {
>   	void __user *uaddr = (void __user *)mop->buf;
> +	void __user *old_addr = (void __user *)mop->old_addr;
> +	union {
> +		__uint128_t quad;
> +		char raw[sizeof(__uint128_t)];
> +	} old = { .quad = 0}, new = { .quad = 0 };
> +	unsigned int off_in_quad = sizeof(new) - mop->size;
>   	u64 supported_flags;
>   	void *tmpbuf = NULL;
>   	int r, srcu_idx;
>   
>   	supported_flags = KVM_S390_MEMOP_F_SKEY_PROTECTION
> -			  | KVM_S390_MEMOP_F_CHECK_ONLY;
> +			  | KVM_S390_MEMOP_F_CHECK_ONLY
> +			  | KVM_S390_MEMOP_F_CMPXCHG;
>   	if (mop->flags & ~supported_flags || !mop->size)
>   		return -EINVAL;
>   	if (mop->size > MEM_OP_MAX_SIZE)
> @@ -2799,6 +2813,21 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   	} else {
>   		mop->key = 0;
>   	}
> +	if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
> +		/*
> +		 * This validates off_in_quad. Checking that size is a power
> +		 * of two is not necessary, as cmpxchg_guest_abs_with_key
> +		 * takes care of that
> +		 */
> +		if (mop->size > sizeof(new))
> +			return -EINVAL;

!mop->size || mop->size > sizeof(new)


> +		if (mop->op != KVM_S390_MEMOP_ABSOLUTE_WRITE)
> +			return -EINVAL;
> +		if (copy_from_user(&new.raw[off_in_quad], uaddr, mop->size))
> +			return -EFAULT;
> +		if (copy_from_user(&old.raw[off_in_quad], old_addr, mop->size))
> +			return -EFAULT;
> +	}
>   	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
>   		tmpbuf = vmalloc(mop->size);
>   		if (!tmpbuf)
> @@ -2829,6 +2858,14 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   	case KVM_S390_MEMOP_ABSOLUTE_WRITE: {
>   		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
>   			r = check_gpa_range(kvm, mop->gaddr, mop->size, GACC_STORE, mop->key);
> +		} else if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
> +			r = cmpxchg_guest_abs_with_key(kvm, mop->gaddr, mop->size,
> +						       &old.quad, new.quad, mop->key);
> +			if (r == 1) {
> +				r = KVM_S390_MEMOP_R_NO_XCHG;

Why don't we return KVM_S390_MEMOP_R_NO_XCHG from 
cmpxchg_guest_abs_with_key instead of aliasing 1 here?

> +				if (copy_to_user(old_addr, &old.raw[off_in_quad], mop->size))
> +					r = -EFAULT;
> +			}
>   		} else {
>   			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
>   				r = -EFAULT;

