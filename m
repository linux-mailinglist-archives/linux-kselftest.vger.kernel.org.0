Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFD6665EF1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 16:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjAKPTb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Jan 2023 10:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjAKPT0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Jan 2023 10:19:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D97FCE9;
        Wed, 11 Jan 2023 07:19:24 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BFG3LL009132;
        Wed, 11 Jan 2023 15:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OHDMQpv2dJpEZbt3U/eWON7xyHWAcKvE5imG6Zbu2sk=;
 b=Ivvg8j3xnfjATGyWHBE4wppo+nXs7ZKlw7xxYbUa5olN+btTurcqDOcuaXvFJbbd+oV+
 ig3BoceRn5NWYyy3QjmxfehQglprNEtLCw6QatCCO92MlPFMTEzpW/P5cjDI8qQit/un
 N7RwVGIOOckz6HXNpjBgYKGfQ6oXXQueVhXLW4TKR1eXmlXmY0UQLAp7UWLgATvD8I0b
 /D/W9K89mILBiNveG/W2HGT4eVBkJ4bPehPEPYtzprA+pB89TwWNU1PJHJQ+q9WI5f3L
 8HqtAQB9P5Yi/VOuLuKnkFFGQ0oaxnhNOfQ8reAGcI/tXDwmKJn0IQSTnjbgVwVvFd/D CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1ykv02tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 15:19:19 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30BFGZ7s010434;
        Wed, 11 Jan 2023 15:19:19 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1ykv02t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 15:19:19 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30B1dE6j003398;
        Wed, 11 Jan 2023 15:19:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n1kmtgscv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 15:19:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30BFJDlU39256320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 15:19:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DD7620049;
        Wed, 11 Jan 2023 15:19:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD9C820043;
        Wed, 11 Jan 2023 15:19:12 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.175.58])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jan 2023 15:19:12 +0000 (GMT)
Message-ID: <bcc971f8acc670bb05e44451f027458dcea1f095.camel@linux.ibm.com>
Subject: Re: [PATCH v5 01/10] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Janosch Frank <frankja@linux.ibm.com>,
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
Date:   Wed, 11 Jan 2023 16:19:12 +0100
In-Reply-To: <02b34aa1-d71a-99cc-77db-3613f881b1a8@linux.ibm.com>
References: <20230110202632.2533978-1-scgl@linux.ibm.com>
         <20230110202632.2533978-2-scgl@linux.ibm.com>
         <02b34aa1-d71a-99cc-77db-3613f881b1a8@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0hicx49KazwkwGbCXu7TchEQ7JKiaHKx
X-Proofpoint-GUID: DsRBmqnKfeqUgLeRT3nG2uYVvgG1fI1M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_07,2023-01-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301110109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2023-01-11 at 10:35 +0100, Janosch Frank wrote:
> On 1/10/23 21:26, Janis Schoetterl-Glausch wrote:
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
> >   include/uapi/linux/kvm.h |   7 +++
> >   arch/s390/kvm/gaccess.h  |   3 ++
> >   arch/s390/kvm/gaccess.c  | 102 ++++++++++++++++++++++++++++++++++++++=
+
> >   arch/s390/kvm/kvm-s390.c |  41 +++++++++++++++-
> >   4 files changed, 151 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 55155e262646..452f43c1cc34 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -583,6 +583,8 @@ struct kvm_s390_mem_op {
> >   		struct {
> >   			__u8 ar;	/* the access register number */
> >   			__u8 key;	/* access key, ignored if flag unset */
> > +			__u8 pad1[6];	/* ignored */
> > +			__u64 old_addr;	/* ignored if flag unset */
> >   		};
> >   		__u32 sida_offset; /* offset into the sida */
> >   		__u8 reserved[32]; /* ignored */
> > @@ -599,6 +601,11 @@ struct kvm_s390_mem_op {
> >   #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
> >   #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
> >   #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
> > +#define KVM_S390_MEMOP_F_CMPXCHG		(1ULL << 3)
> > +/* flags specifying extension support */
>=20
> Would that fit behind the bit shifts without getting into the "line too=
=20
> long" territory?

Bit shifts or the next line?
>=20
> > +#define KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG 0x2
>=20
> \n please

Not sure about all that, this is the way it looks right now:

/* types for kvm_s390_mem_op->op */
#define KVM_S390_MEMOP_LOGICAL_READ     0
#define KVM_S390_MEMOP_LOGICAL_WRITE    1
#define KVM_S390_MEMOP_SIDA_READ        2
#define KVM_S390_MEMOP_SIDA_WRITE       3
#define KVM_S390_MEMOP_ABSOLUTE_READ    4
#define KVM_S390_MEMOP_ABSOLUTE_WRITE   5
/* flags for kvm_s390_mem_op->flags */
#define KVM_S390_MEMOP_F_CHECK_ONLY             (1ULL << 0)
#define KVM_S390_MEMOP_F_INJECT_EXCEPTION       (1ULL << 1)
#define KVM_S390_MEMOP_F_SKEY_PROTECTION        (1ULL << 2)
#define KVM_S390_MEMOP_F_CMPXCHG                (1ULL << 3)
/* flags specifying extension support */
#define KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG 0x2
/* Non program exception return codes (pgm codes are 16 bit) */
#define KVM_S390_MEMOP_R_NO_XCHG                (1 << 16)

Seems consistent to me.
>=20
> > +/* Non program exception return codes (pgm codes are 16 bit) */
> > +#define KVM_S390_MEMOP_R_NO_XCHG		(1 << 16)
> >  =20
> >   /* for KVM_INTERRUPT */
> >   struct kvm_interrupt {
> > diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> > index 9408d6cc8e2c..92a3b9fb31ec 100644
> > --- a/arch/s390/kvm/gaccess.h
> > +++ b/arch/s390/kvm/gaccess.h
> > @@ -206,6 +206,9 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, un=
signed long ga, u8 ar,
> >   int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
> >   		      void *data, unsigned long len, enum gacc_mode mode);
> >  =20
> > +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
> > +			       __uint128_t *old, __uint128_t new, u8 access_key);
> > +
> >   /**
> >    * write_guest_with_key - copy data from kernel space to guest space
> >    * @vcpu: virtual cpu
> > diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> > index 0243b6e38d36..6165e761a637 100644
> > --- a/arch/s390/kvm/gaccess.c
> > +++ b/arch/s390/kvm/gaccess.c
> > @@ -1161,6 +1161,108 @@ int access_guest_real(struct kvm_vcpu *vcpu, un=
signed long gra,
> >   	return rc;
> >   }
> >  =20
> > +/**
> > + * cmpxchg_guest_abs_with_key() - Perform cmpxchg on guest absolute ad=
dress.
> > + * @kvm: Virtual machine instance.
> > + * @gpa: Absolute guest address of the location to be changed.
> > + * @len: Operand length of the cmpxchg, required: 1 <=3D len <=3D 16. =
Providing a
> > + *       non power of two will result in failure.
> > + * @old_addr: Pointer to old value. If the location at @gpa contains t=
his value, the
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
>=20
>  > 1 Access related program interruption code indicating the reason=20
> cmpxchg could not be attempted
>=20
> < 1 Kernel / input data error codes

I think I'll do it like I said in the email to Thomas, that way it's maxima=
lly
explicit about the return values one might get.
>=20
> > + *         * -EINVAL: address misaligned or len not power of two
> > + *         * -EAGAIN: transient failure (len 1 or 2)
> > + *         * -EOPNOTSUPP: read-only memslot (should never occur)
>=20
> Would PGM_PROTECTED also make sense here instead of EOPNOTSUPP?

I don't think so, if you get EOPNOTSUPP there's a programming error somewhe=
re
that needs to be fixed.
I wouldn't want to mix that with the totally fine case of a protection exce=
ption.
>=20
[...]

> > @@ -2772,12 +2779,19 @@ static bool access_key_invalid(u8 access_key)
> >   static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op=
 *mop)
> >   {
> >   	void __user *uaddr =3D (void __user *)mop->buf;
> > +	void __user *old_addr =3D (void __user *)mop->old_addr;
> > +	union {
> > +		__uint128_t quad;
> > +		char raw[sizeof(__uint128_t)];
> > +	} old =3D { .quad =3D 0}, new =3D { .quad =3D 0 };
> > +	unsigned int off_in_quad =3D sizeof(new) - mop->size;
> >   	u64 supported_flags;
> >   	void *tmpbuf =3D NULL;
> >   	int r, srcu_idx;
> >  =20
> >   	supported_flags =3D KVM_S390_MEMOP_F_SKEY_PROTECTION
> > -			  | KVM_S390_MEMOP_F_CHECK_ONLY;
> > +			  | KVM_S390_MEMOP_F_CHECK_ONLY
> > +			  | KVM_S390_MEMOP_F_CMPXCHG;
> >   	if (mop->flags & ~supported_flags || !mop->size)
> >   		return -EINVAL;
> >   	if (mop->size > MEM_OP_MAX_SIZE)
> > @@ -2799,6 +2813,21 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, s=
truct kvm_s390_mem_op *mop)
> >   	} else {
> >   		mop->key =3D 0;
> >   	}
> > +	if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
> > +		/*
> > +		 * This validates off_in_quad. Checking that size is a power
> > +		 * of two is not necessary, as cmpxchg_guest_abs_with_key
> > +		 * takes care of that
> > +		 */
> > +		if (mop->size > sizeof(new))
> > +			return -EINVAL;
>=20
> !mop->size || mop->size > sizeof(new)

Not sure why that would be necessary, but I did write
"Operand length of the cmpxchg, required: 1 <=3D len <=3D 16",
so I'll trust my past self on that.
>=20
>=20
> > +		if (mop->op !=3D KVM_S390_MEMOP_ABSOLUTE_WRITE)
> > +			return -EINVAL;
> > +		if (copy_from_user(&new.raw[off_in_quad], uaddr, mop->size))
> > +			return -EFAULT;
> > +		if (copy_from_user(&old.raw[off_in_quad], old_addr, mop->size))
> > +			return -EFAULT;
> > +	}
> >   	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
> >   		tmpbuf =3D vmalloc(mop->size);
> >   		if (!tmpbuf)
> > @@ -2829,6 +2858,14 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, s=
truct kvm_s390_mem_op *mop)
> >   	case KVM_S390_MEMOP_ABSOLUTE_WRITE: {
> >   		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
> >   			r =3D check_gpa_range(kvm, mop->gaddr, mop->size, GACC_STORE, mop-=
>key);
> > +		} else if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
> > +			r =3D cmpxchg_guest_abs_with_key(kvm, mop->gaddr, mop->size,
> > +						       &old.quad, new.quad, mop->key);
> > +			if (r =3D=3D 1) {
> > +				r =3D KVM_S390_MEMOP_R_NO_XCHG;
>=20
> Why don't we return KVM_S390_MEMOP_R_NO_XCHG from=20
> cmpxchg_guest_abs_with_key instead of aliasing 1 here?

I think it's a bit ugly, since cmpxchg_guest_abs_with_key is an internal fu=
nction and not memop specific.
I don't like returning a MEMOP API constant there.

> > +				if (copy_to_user(old_addr, &old.raw[off_in_quad], mop->size))
> > +					r =3D -EFAULT;
> > +			}
> >   		} else {
> >   			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
> >   				r =3D -EFAULT;
>=20

