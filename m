Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F9663F690
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 18:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiLARqR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 12:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiLARph (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 12:45:37 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50F4CA140;
        Thu,  1 Dec 2022 09:45:09 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1HKB6c008580;
        Thu, 1 Dec 2022 17:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OG36+xT9nLIJKPEpM3Xslx8Q4g2HUqjP98adH/1U+CE=;
 b=tb7kqahUewi0uSWNnIc508AZSfZJi8Z4vhE9a8+GYWgaBxG0KE4hpretnbBovEY6AqKr
 5hnjWfPnvfo7FyXQn76PwUD6sTE6Z3F1b8mjPYaCbDgwkbFSSoDofCo8zN1RCrz9/GUn
 XDAyqpNqDZTsrZGVgYqdBIyrv+aIdChdOpOVUdy6MGDM9wZEr17DOaO8irCc+QZphLp2
 CCUUXTAPvuMeWZTqVHnbpOJZ0rijHGDxmUusJ88etpcknkuKlz9n0l7ZHwu+QSYcEKs7
 rFCMMHi2aDuckJMo/phywBjhRUb9JiRooUhXr2LKsTtSoDfCC/UCDRMzFlkjsHFFgHqD Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m70jt0n0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 17:45:03 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B1HKPWm008879;
        Thu, 1 Dec 2022 17:45:02 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m70jt0n00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 17:45:02 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B1HZl0R005775;
        Thu, 1 Dec 2022 17:45:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3m3ae9fqnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 17:45:00 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B1Hive17012908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Dec 2022 17:44:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 588D052050;
        Thu,  1 Dec 2022 17:44:57 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.179.10.216])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9F26A5204E;
        Thu,  1 Dec 2022 17:44:56 +0000 (GMT)
Message-ID: <dc192fa099eb1b7d49d19b52c416d21589e22d87.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/9] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Date:   Thu, 01 Dec 2022 18:44:56 +0100
In-Reply-To: <20221201171528.13f17ec4@p-imbrenda>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
         <20221117221758.66326-2-scgl@linux.ibm.com>
         <20221201171528.13f17ec4@p-imbrenda>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fFdC9_T-X3ThT5g64L2ouot6FHYuvxtf
X-Proofpoint-GUID: W4FH8Ht5rNc4T5kQS4JEBTLs_0ji5DFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_12,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212010132
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2022-12-01 at 17:15 +0100, Claudio Imbrenda wrote:
> On Thu, 17 Nov 2022 23:17:50 +0100
> Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:
>=20
> > User space can use the MEM_OP ioctl to make storage key checked reads
> > and writes to the guest, however, it has no way of performing atomic,
> > key checked, accesses to the guest.
> > Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
> > mode. For now, support this mode for absolute accesses only.
> >=20
> > This mode can be use, for example, to set the device-state-change
> > indicator and the adapter-local-summary indicator atomically.
> >=20
> > Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> > ---
> >  include/uapi/linux/kvm.h |   5 ++
> >  arch/s390/kvm/gaccess.h  |   3 ++
> >  arch/s390/kvm/gaccess.c  | 101 +++++++++++++++++++++++++++++++++++++++
> >  arch/s390/kvm/kvm-s390.c |  35 +++++++++++++-
> >  4 files changed, 142 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 0d5d4419139a..1f36be5493e6 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -588,6 +588,8 @@ struct kvm_s390_mem_op {
> >  		struct {
> >  			__u8 ar;	/* the access register number */
> >  			__u8 key;	/* access key, ignored if flag unset */
> > +			__u8 pad1[6];	/* ignored */
> > +			__u64 old_p;	/* ignored if flag unset */
> >  		};
> >  		__u32 sida_offset; /* offset into the sida */
> >  		__u8 reserved[32]; /* ignored */
> > @@ -604,6 +606,9 @@ struct kvm_s390_mem_op {
> >  #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
> >  #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
> >  #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
> > +#define KVM_S390_MEMOP_F_CMPXCHG		(1ULL << 3)
> > +/* Non program exception return codes (pgm codes are 16 bit) */
> > +#define KVM_S390_MEMOP_R_NO_XCHG		((1 << 16) + 0)
>=20
> are you planning to have further *_R_* macros in the near future?
> if not, remove the + 0

No, we can indeed just add it back if there ever are additional ones.

> if yes, move the (1 << 16) to a macro, so it becomes something like
> (KVM_S390_MEMOP_R_BASE + 0)
>=20
> (maybe you can find a better/shorter name)
>=20
> > =20
> >  /* for KVM_INTERRUPT */
> >  struct kvm_interrupt {
> > diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> > index 9408d6cc8e2c..92a3b9fb31ec 100644
> > --- a/arch/s390/kvm/gaccess.h
> > +++ b/arch/s390/kvm/gaccess.h
> > @@ -206,6 +206,9 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, un=
signed long ga, u8 ar,
> >  int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
> >  		      void *data, unsigned long len, enum gacc_mode mode);
> > =20
> > +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
> > +			       __uint128_t *old, __uint128_t new, u8 access_key);
> > +
> >  /**
> >   * write_guest_with_key - copy data from kernel space to guest space
> >   * @vcpu: virtual cpu
> > diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> > index 0243b6e38d36..be042865d8a1 100644
> > --- a/arch/s390/kvm/gaccess.c
> > +++ b/arch/s390/kvm/gaccess.c
> > @@ -1161,6 +1161,107 @@ int access_guest_real(struct kvm_vcpu *vcpu, un=
signed long gra,
> >  	return rc;
> >  }
> > =20
> > +/**
> > + * cmpxchg_guest_abs_with_key() - Perform cmpxchg on guest absolute ad=
dress.
> > + * @kvm: Virtual machine instance.
> > + * @gpa: Absolute guest address of the location to be changed.
> > + * @len: Operand length of the cmpxchg, required: 1 <=3D len <=3D 16. =
Providing a
> > + *       non power of two will result in failure.
> > + * @old_p: Pointer to old value. If the location at @gpa contains this=
 value, the
> > + *         exchange will succeed. After calling cmpxchg_guest_abs_with=
_key() *@old
> > + *         contains the value at @gpa before the attempt to exchange t=
he value.
> > + * @new: The value to place at @gpa.
> > + * @access_key: The access key to use for the guest access.
> > + *
> > + * Atomically exchange the value at @gpa by @new, if it contains *@old=
.
> > + * Honors storage keys.
> > + *
> > + * Return: * 0: successful exchange
> > + *         * 1: exchange unsuccessful
> > + *         * a program interruption code indicating the reason cmpxchg=
 could
> > + *           not be attempted
> > + *         * -EINVAL: address misaligned or len not power of two
> > + *         * -EAGAIN: transient failure (len 1 or 2)
>=20
> please also document -EOPNOTSUPP

I'd add "* -EOPNOTSUPP: should never occur", then, that ok with you?
>=20
> > + */
> > +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
> > +			       __uint128_t *old_p, __uint128_t new,
> > +			       u8 access_key)
> > +{
> > +	gfn_t gfn =3D gpa >> PAGE_SHIFT;
> > +	struct kvm_memory_slot *slot =3D gfn_to_memslot(kvm, gfn);
>=20
> exchange the above two lines (reverse christmas tree)

Is this a hard requirement? Since there is a dependency.
If I do the initialization further down, the order wouldn't actually change=
.
>=20
> > +	bool writable;
> > +	hva_t hva;
> > +	int ret;
> > +
> > +	if (!IS_ALIGNED(gpa, len))
> > +		return -EINVAL;
> > +
> > +	hva =3D gfn_to_hva_memslot_prot(slot, gfn, &writable);
> > +	if (kvm_is_error_hva(hva))
> > +		return PGM_ADDRESSING;
> > +	/*
> > +	 * Check if it's a read-only memslot, even though that cannot occur
> > +	 * since those are unsupported.
> > +	 * Don't try to actually handle that case.
> > +	 */
> > +	if (!writable)
> > +		return -EOPNOTSUPP;
>=20
> either you document this, or you return something else (like -EINVAL)
>=20
> > +
> > +	hva +=3D offset_in_page(gpa);
> > +	switch (len) {
> > +	case 1: {
> > +		u8 old;
> > +
> > +		ret =3D cmpxchg_user_key((u8 *)hva, &old, *old_p, new, access_key);
> > +		ret =3D ret < 0 ? ret : old !=3D *old_p;
> > +		*old_p =3D old;
> > +		break;
> > +	}
> > +	case 2: {
> > +		u16 old;
> > +
> > +		ret =3D cmpxchg_user_key((u16 *)hva, &old, *old_p, new, access_key);
> > +		ret =3D ret < 0 ? ret : old !=3D *old_p;
> > +		*old_p =3D old;
> > +		break;
> > +	}
> > +	case 4: {
> > +		u32 old;
> > +
> > +		ret =3D cmpxchg_user_key((u32 *)hva, &old, *old_p, new, access_key);
> > +		ret =3D ret < 0 ? ret : old !=3D *old_p;
> > +		*old_p =3D old;
> > +		break;
> > +	}
> > +	case 8: {
> > +		u64 old;
> > +
> > +		ret =3D cmpxchg_user_key((u64 *)hva, &old, *old_p, new, access_key);
> > +		ret =3D ret < 0 ? ret : old !=3D *old_p;
> > +		*old_p =3D old;
> > +		break;
> > +	}
> > +	case 16: {
> > +		__uint128_t old;
> > +
> > +		ret =3D cmpxchg_user_key((__uint128_t *)hva, &old, *old_p, new, acce=
ss_key);
> > +		ret =3D ret < 0 ? ret : old !=3D *old_p;
> > +		*old_p =3D old;
> > +		break;
>=20
> I really dislike repeating the same code 5 times, but I guess there was
> no other way?

I could use the function called by cmpxchg_user_key directly, but Heiko won=
't agree to that.
A macro would work too, of course, not sure if I prefer that tho.
>=20
> > +	}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	mark_page_dirty_in_slot(kvm, slot, gfn);
> > +	/*
> > +	 * Assume that the fault is caused by protection, either key protecti=
on
> > +	 * or user page write protection.
> > +	 */
> > +	if (ret =3D=3D -EFAULT)
> > +		ret =3D PGM_PROTECTION;
> > +	return ret;
> > +}
> > +
> >  /**
> >   * guest_translate_address_with_key - translate guest logical into gue=
st absolute address
> >   * @vcpu: virtual cpu
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index 45d4b8182b07..2410b4044283 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -576,7 +576,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
> >  	case KVM_CAP_S390_VCPU_RESETS:
> >  	case KVM_CAP_SET_GUEST_DEBUG:
> >  	case KVM_CAP_S390_DIAG318:
> > -	case KVM_CAP_S390_MEM_OP_EXTENSION:
> >  		r =3D 1;
> >  		break;
> >  	case KVM_CAP_SET_GUEST_DEBUG2:
> > @@ -590,6 +589,14 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, =
long ext)
> >  	case KVM_CAP_S390_MEM_OP:
> >  		r =3D MEM_OP_MAX_SIZE;
> >  		break;
> > +	case KVM_CAP_S390_MEM_OP_EXTENSION:
> > +		/*
> > +		 * Flag bits indicating which extensions are supported.
> > +		 * The first extension doesn't use a flag, but pretend it does,
> > +		 * this way that can be changed in the future.
> > +		 */
> > +		r =3D 0x3;
> > +		break;
> >  	case KVM_CAP_NR_VCPUS:
> >  	case KVM_CAP_MAX_VCPUS:
> >  	case KVM_CAP_MAX_VCPU_ID:
> > @@ -2714,12 +2721,19 @@ static bool access_key_invalid(u8 access_key)
> >  static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op =
*mop)
> >  {
> >  	void __user *uaddr =3D (void __user *)mop->buf;
> > +	void __user *old_p =3D (void __user *)mop->old_p;
> > +	union {
> > +		__uint128_t quad;
> > +		char raw[sizeof(__uint128_t)];
> > +	} old =3D { .quad =3D 0}, new =3D { .quad =3D 0 };
> > +	unsigned int off_in_quad =3D sizeof(__uint128_t) - mop->size;
> >  	u64 supported_flags;
> >  	void *tmpbuf =3D NULL;
> >  	int r, srcu_idx;
> > =20
> >  	supported_flags =3D KVM_S390_MEMOP_F_SKEY_PROTECTION
> > -			  | KVM_S390_MEMOP_F_CHECK_ONLY;
> > +			  | KVM_S390_MEMOP_F_CHECK_ONLY
> > +			  | KVM_S390_MEMOP_F_CMPXCHG;
> >  	if (mop->flags & ~supported_flags || !mop->size)
> >  		return -EINVAL;
> >  	if (mop->size > MEM_OP_MAX_SIZE)
> > @@ -2741,6 +2755,15 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, s=
truct kvm_s390_mem_op *mop)
> >  	} else {
> >  		mop->key =3D 0;
> >  	}
> > +	if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
>=20
> add a quick comment here to explain that this check validates
> off_in_quad, and that it does not do a full validation of mop->size,
> which will happen in cmpxchg_guest_abs_with_key.

Will do.
>=20
> > +		if (mop->size > sizeof(new))
> > +			return -EINVAL;
> > +		/* off_in_quad has been validated */
> > +		if (copy_from_user(&new.raw[off_in_quad], uaddr, mop->size))
> > +			return -EFAULT;
> > +		if (copy_from_user(&old.raw[off_in_quad], old_p, mop->size))
> > +			return -EFAULT;
> > +	}
> >  	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
> >  		tmpbuf =3D vmalloc(mop->size);
> >  		if (!tmpbuf)
> > @@ -2771,6 +2794,14 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, s=
truct kvm_s390_mem_op *mop)
> >  	case KVM_S390_MEMOP_ABSOLUTE_WRITE: {
> >  		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
> >  			r =3D check_gpa_range(kvm, mop->gaddr, mop->size, GACC_STORE, mop->=
key);
> > +		} else if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
> > +			r =3D cmpxchg_guest_abs_with_key(kvm, mop->gaddr, mop->size,
> > +						       &old.quad, new.quad, mop->key);
> > +			if (r =3D=3D 1) {
> > +				r =3D KVM_S390_MEMOP_R_NO_XCHG;
>=20
> I wonder if you could not simplify things by returning directly
> KVM_S390_MEMOP_R_NO_XCHG instead of 1

To me it feels like KVM_S390_MEMOP_R_NO_XCHG is api surface and should be r=
eferenced here.
cmpxchg_guest_abs_with_key isn't mem op specific
(of course that's the only thing it is currently used for).
>=20
> > +				if (copy_to_user(old_p, &old.raw[off_in_quad], mop->size))
> > +					r =3D -EFAULT;
> > +			}
> >  		} else {
> >  			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
> >  				r =3D -EFAULT;
>=20

