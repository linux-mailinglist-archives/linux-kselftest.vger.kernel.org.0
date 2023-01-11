Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4786661DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 18:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbjAKRar (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Jan 2023 12:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239794AbjAKR3E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Jan 2023 12:29:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C60B30559;
        Wed, 11 Jan 2023 09:26:40 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BGtgbn015883;
        Wed, 11 Jan 2023 17:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=I8VKl2k/r6WdcTXZze+bHqw6xvXdbTTZaCdi86m1BS0=;
 b=lBglwuW8f/Pt6dsu0UfggH2W0WVIjSoTgLAwRa2qRg1gO9dQWHRvnQCz+2ogSpGKZBcb
 +hHzeL395V4Dqu/GGYyNdIv6gnh2Fl594J3Z+c0Bi7nyIbBl3QaN6jyKan5PYcKl3enE
 9AwWZfYdF3iOlTR95UAg0hAXV0rtSQ//8QabehNs4LNRAxoGdbX9aeT3I8ogu/YQ/dqt
 hKIIEdOqTDy+aRlXg4yWtmALJd4VJq2fGM6D+GYwYggg4o3MLJ/7QMDC6KANmQPuULXI
 kItkeKSZ8VPaZ+mJcQsynnig0Cdw+HTnjEYOmp1RyeHaW5Uv45iVZ6JaURL0lHsrlfpb qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n212j8p38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 17:26:36 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30BGuE4H020442;
        Wed, 11 Jan 2023 17:26:36 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n212j8p2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 17:26:35 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30BH5BmP018505;
        Wed, 11 Jan 2023 17:26:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3n1km68w0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 17:26:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30BHQTvU52429194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 17:26:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94FAF20040;
        Wed, 11 Jan 2023 17:26:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E38E220043;
        Wed, 11 Jan 2023 17:26:28 +0000 (GMT)
Received: from [9.171.7.243] (unknown [9.171.7.243])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jan 2023 17:26:28 +0000 (GMT)
Message-ID: <4c5a7fd1-9996-a191-dd93-087554e93923@linux.ibm.com>
Date:   Wed, 11 Jan 2023 18:26:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
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
 <02b34aa1-d71a-99cc-77db-3613f881b1a8@linux.ibm.com>
 <bcc971f8acc670bb05e44451f027458dcea1f095.camel@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v5 01/10] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
In-Reply-To: <bcc971f8acc670bb05e44451f027458dcea1f095.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5vnoelC-FvIG_eBSNdtApcUxTmA9lCrh
X-Proofpoint-ORIG-GUID: isdVeAP3_NXqTKCWmsyaHpJI1mMtSmEk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_07,2023-01-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301110125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/11/23 16:19, Janis Schoetterl-Glausch wrote:
> On Wed, 2023-01-11 at 10:35 +0100, Janosch Frank wrote:
>> On 1/10/23 21:26, Janis Schoetterl-Glausch wrote:
>>> User space can use the MEM_OP ioctl to make storage key checked reads
>>> and writes to the guest, however, it has no way of performing atomic,
>>> key checked, accesses to the guest.
>>> Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
>>> mode. For now, support this mode for absolute accesses only.
>>>
>>> This mode can be use, for example, to set the device-state-change
>>> indicator and the adapter-local-summary indicator atomically.
>>>
>>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
>>> ---
>>>    include/uapi/linux/kvm.h |   7 +++
>>>    arch/s390/kvm/gaccess.h  |   3 ++
>>>    arch/s390/kvm/gaccess.c  | 102 +++++++++++++++++++++++++++++++++++++++
>>>    arch/s390/kvm/kvm-s390.c |  41 +++++++++++++++-
>>>    4 files changed, 151 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>> index 55155e262646..452f43c1cc34 100644
>>> --- a/include/uapi/linux/kvm.h
>>> +++ b/include/uapi/linux/kvm.h
>>> @@ -583,6 +583,8 @@ struct kvm_s390_mem_op {
>>>    		struct {
>>>    			__u8 ar;	/* the access register number */
>>>    			__u8 key;	/* access key, ignored if flag unset */
>>> +			__u8 pad1[6];	/* ignored */
>>> +			__u64 old_addr;	/* ignored if flag unset */

Which flag?
Maybe that would be clearer with a cmpxchg_ prefix.

>>>    		};
>>>    		__u32 sida_offset; /* offset into the sida */
>>>    		__u8 reserved[32]; /* ignored */
>>> @@ -599,6 +601,11 @@ struct kvm_s390_mem_op {
>>>    #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
>>>    #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
>>>    #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
>>> +#define KVM_S390_MEMOP_F_CMPXCHG		(1ULL << 3)
>>> +/* flags specifying extension support */

via KVM_CAP_S390_MEM_OP_EXTENSION

This is part of the CAP api but is nestled between the memop api.
I'm not entirely happy about that.

>>
>> Would that fit behind the bit shifts without getting into the "line too
>> long" territory?
> 
> Bit shifts or the next line?

Seems like I didn't see that this is grouped to the next line so forget 
about my comment.

>>
>> \n please
> 
> Not sure about all that, this is the way it looks right now:
> 
> /* types for kvm_s390_mem_op->op */
> #define KVM_S390_MEMOP_LOGICAL_READ     0
> #define KVM_S390_MEMOP_LOGICAL_WRITE    1
> #define KVM_S390_MEMOP_SIDA_READ        2
> #define KVM_S390_MEMOP_SIDA_WRITE       3
> #define KVM_S390_MEMOP_ABSOLUTE_READ    4
> #define KVM_S390_MEMOP_ABSOLUTE_WRITE   5

> /* flags for kvm_s390_mem_op->flags */
> #define KVM_S390_MEMOP_F_CHECK_ONLY             (1ULL << 0)
> #define KVM_S390_MEMOP_F_INJECT_EXCEPTION       (1ULL << 1)
> #define KVM_S390_MEMOP_F_SKEY_PROTECTION        (1ULL << 2)
> #define KVM_S390_MEMOP_F_CMPXCHG                (1ULL << 3)

> /* flags specifying extension support */

> #define KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG 0x2

#define KVM_S390_MEMOP_EXTENSION_CAP_ABSOLUTE 1 << 0
#define KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG 1 << 1

Or maybe BASE instead of ABSOLUTE


> /* Non program exception return codes (pgm codes are 16 bit) */
> #define KVM_S390_MEMOP_R_NO_XCHG                (1 << 16)
> 
> Seems consistent to me.

Consistent and hardly readable once you add two more "categories" of values.

>>
>>> +/* Non program exception return codes (pgm codes are 16 bit) */
>>> +#define KVM_S390_MEMOP_R_NO_XCHG		(1 << 16)
>>>    
>>>    /* for KVM_INTERRUPT */
>>>    struct kvm_interrupt {
>>> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
>>> index 9408d6cc8e2c..92a3b9fb31ec 100644
>>> --- a/arch/s390/kvm/gaccess.h
>>> +++ b/arch/s390/kvm/gaccess.h
>>> @@ -206,6 +206,9 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
>>>    int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
>>>    		      void *data, unsigned long len, enum gacc_mode mode);
>>>    
>>> +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
>>> +			       __uint128_t *old, __uint128_t new, u8 access_key);
>>> +
>>>    /**
>>>     * write_guest_with_key - copy data from kernel space to guest space
>>>     * @vcpu: virtual cpu
>>> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
>>> index 0243b6e38d36..6165e761a637 100644
>>> --- a/arch/s390/kvm/gaccess.c
>>> +++ b/arch/s390/kvm/gaccess.c
>>> @@ -1161,6 +1161,108 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
>>>    	return rc;
>>>    }
>>>    
>>> +/**
>>> + * cmpxchg_guest_abs_with_key() - Perform cmpxchg on guest absolute address.
>>> + * @kvm: Virtual machine instance.
>>> + * @gpa: Absolute guest address of the location to be changed.
>>> + * @len: Operand length of the cmpxchg, required: 1 <= len <= 16. Providing a
>>> + *       non power of two will result in failure.
>>> + * @old_addr: Pointer to old value. If the location at @gpa contains this value, the
>>> + *         exchange will succeed. After calling cmpxchg_guest_abs_with_key() *@old
>>> + *         contains the value at @gpa before the attempt to exchange the value.
>>> + * @new: The value to place at @gpa.
>>> + * @access_key: The access key to use for the guest access.
>>> + *
>>> + * Atomically exchange the value at @gpa by @new, if it contains *@old.
>>> + * Honors storage keys.
>>> + *
>>> + * Return: * 0: successful exchange
>>> + *         * 1: exchange unsuccessful
>>> + *         * a program interruption code indicating the reason cmpxchg could
>>> + *           not be attempted
>>
>>   > 1 Access related program interruption code indicating the reason
>> cmpxchg could not be attempted
>>
>> < 1 Kernel / input data error codes
> 
> I think I'll do it like I said in the email to Thomas, that way it's maximally
> explicit about the return values one might get.

This shows me that we're overloading the return value way too much.
Not just of this function but also of the memop with 
KVM_S390_MEMOP_R_NO_XCHG.

A return of < 0, 0, 1 and a passed int reference for the PGM codes 
that's updated if the rc is 1 would make this clearer.

Btw. could a user specify check + cmpxchange as the flags?
Are we checking that and I've missed to see such a check?


I don't like that we throw in yet another feature as a flag thereby 
blowing up kvm_s390_vm_mem_op() and adding new branches to it. I'll need 
to think about that some more.

>>
>>> + *         * -EINVAL: address misaligned or len not power of two
>>> + *         * -EAGAIN: transient failure (len 1 or 2)
>>> + *         * -EOPNOTSUPP: read-only memslot (should never occur)
>>
>> Would PGM_PROTECTED also make sense here instead of EOPNOTSUPP?
> 
> I don't think so, if you get EOPNOTSUPP there's a programming error somewhere
> that needs to be fixed.
> I wouldn't want to mix that with the totally fine case of a protection exception.
>>
> [...]
> 
>>> @@ -2772,12 +2779,19 @@ static bool access_key_invalid(u8 access_key)
>>>    static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>>>    {
>>>    	void __user *uaddr = (void __user *)mop->buf;
>>> +	void __user *old_addr = (void __user *)mop->old_addr;
>>> +	union {
>>> +		__uint128_t quad;
>>> +		char raw[sizeof(__uint128_t)];
>>> +	} old = { .quad = 0}, new = { .quad = 0 };
>>> +	unsigned int off_in_quad = sizeof(new) - mop->size;
>>>    	u64 supported_flags;
>>>    	void *tmpbuf = NULL;
>>>    	int r, srcu_idx;
>>>    
>>>    	supported_flags = KVM_S390_MEMOP_F_SKEY_PROTECTION
>>> -			  | KVM_S390_MEMOP_F_CHECK_ONLY;
>>> +			  | KVM_S390_MEMOP_F_CHECK_ONLY
>>> +			  | KVM_S390_MEMOP_F_CMPXCHG;
>>>    	if (mop->flags & ~supported_flags || !mop->size)
>>>    		return -EINVAL;
>>>    	if (mop->size > MEM_OP_MAX_SIZE)
>>> @@ -2799,6 +2813,21 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>>>    	} else {
>>>    		mop->key = 0;
>>>    	}
>>> +	if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
>>> +		/*
>>> +		 * This validates off_in_quad. Checking that size is a power
>>> +		 * of two is not necessary, as cmpxchg_guest_abs_with_key
>>> +		 * takes care of that
>>> +		 */
>>> +		if (mop->size > sizeof(new))
>>> +			return -EINVAL;
>>
>> !mop->size || mop->size > sizeof(new)
> 
> Not sure why that would be necessary, but I did write
> "Operand length of the cmpxchg, required: 1 <= len <= 16",
> so I'll trust my past self on that.

It's already being checked right after the flags are specified so we're 
golden anyway.

>>
>>
>>> +		if (mop->op != KVM_S390_MEMOP_ABSOLUTE_WRITE)
>>> +			return -EINVAL;
>>> +		if (copy_from_user(&new.raw[off_in_quad], uaddr, mop->size))
>>> +			return -EFAULT;
>>> +		if (copy_from_user(&old.raw[off_in_quad], old_addr, mop->size))
>>> +			return -EFAULT;
>>> +	}
>>>    	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
>>>    		tmpbuf = vmalloc(mop->size);
>>>    		if (!tmpbuf)
>>> @@ -2829,6 +2858,14 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>>>    	case KVM_S390_MEMOP_ABSOLUTE_WRITE: {
>>>    		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
>>>    			r = check_gpa_range(kvm, mop->gaddr, mop->size, GACC_STORE, mop->key);
>>> +		} else if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
>>> +			r = cmpxchg_guest_abs_with_key(kvm, mop->gaddr, mop->size,
>>> +						       &old.quad, new.quad, mop->key);
>>> +			if (r == 1) {
>>> +				r = KVM_S390_MEMOP_R_NO_XCHG;
>>
>> Why don't we return KVM_S390_MEMOP_R_NO_XCHG from
>> cmpxchg_guest_abs_with_key instead of aliasing 1 here?
> 
> I think it's a bit ugly, since cmpxchg_guest_abs_with_key is an internal function and not memop specific.
> I don't like returning a MEMOP API constant there.
> 
>>> +				if (copy_to_user(old_addr, &old.raw[off_in_quad], mop->size))
>>> +					r = -EFAULT;
>>> +			}
>>>    		} else {
>>>    			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
>>>    				r = -EFAULT;
>>
> 

