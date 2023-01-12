Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014B366728D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 13:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjALMtK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 07:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjALMs3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 07:48:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3920D4A958;
        Thu, 12 Jan 2023 04:48:28 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CCVSN9032396;
        Thu, 12 Jan 2023 12:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=x/yd7iWJ6qTiANjCFcEAOKc6MU3jjvLtKOzoy6Qz3o0=;
 b=fWJUU8kcdEcjL9Q2APfi7Mt9xDRlNFQc77iQW0azKE9e36j3/5+puLIc6Tz4jJXLkV8b
 qvJsutNv70Rk2NFQ5AS44UkbNVF6Hyq5wzrfKTHRsBci0Gx/BBwcdAj3DYa/UkAFQzo9
 qBPa2Kz6CIp3tMnrQWPn6PnrBuzowMgGCadFBSZpNoVtJ4lY0Sc3OwdX40h+x4NaAFgB
 Ftf8MkBXFOBJJHsYVxT/aurHWof2WNnjhF5Ncx+RFspxrbHoYsjkGukos0Q/pk9MXaNM
 HszMZTaApqU9Qos29Qzbr9pVoM/D/PY6SDVVH1CgQToaPTsPQL9y2FGe5OG4mFb9knWm Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2j9q0b4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 12:48:24 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30CCWO0X007593;
        Thu, 12 Jan 2023 12:48:23 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2j9q0b3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 12:48:23 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30C3RLAk004503;
        Thu, 12 Jan 2023 12:48:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n1kkytfam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 12:48:20 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30CCmHYc22675792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 12:48:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6323F2004D;
        Thu, 12 Jan 2023 12:48:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F2BF2004B;
        Thu, 12 Jan 2023 12:48:17 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.152.120])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jan 2023 12:48:17 +0000 (GMT)
Message-ID: <0d890ba62e5117756445323def2096e5e39b2351.camel@linux.ibm.com>
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
Date:   Thu, 12 Jan 2023 13:48:16 +0100
In-Reply-To: <4c5a7fd1-9996-a191-dd93-087554e93923@linux.ibm.com>
References: <20230110202632.2533978-1-scgl@linux.ibm.com>
         <20230110202632.2533978-2-scgl@linux.ibm.com>
         <02b34aa1-d71a-99cc-77db-3613f881b1a8@linux.ibm.com>
         <bcc971f8acc670bb05e44451f027458dcea1f095.camel@linux.ibm.com>
         <4c5a7fd1-9996-a191-dd93-087554e93923@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hVWLBcPSQo0LCgx_RgCf_160ScAaEkiv
X-Proofpoint-ORIG-GUID: Zs2Md71SUDY57Nxr4qyuGrahlanRfpFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_07,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2023-01-11 at 18:26 +0100, Janosch Frank wrote:
> On 1/11/23 16:19, Janis Schoetterl-Glausch wrote:
> > On Wed, 2023-01-11 at 10:35 +0100, Janosch Frank wrote:
> > > On 1/10/23 21:26, Janis Schoetterl-Glausch wrote:
> > > > User space can use the MEM_OP ioctl to make storage key checked rea=
ds
> > > > and writes to the guest, however, it has no way of performing atomi=
c,
> > > > key checked, accesses to the guest.
> > > > Extend the MEM_OP ioctl in order to allow for this, by adding a cmp=
xchg
> > > > mode. For now, support this mode for absolute accesses only.
> > > >=20
> > > > This mode can be use, for example, to set the device-state-change
> > > > indicator and the adapter-local-summary indicator atomically.
> > > >=20
> > > > Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> > > > ---
> > > >    include/uapi/linux/kvm.h |   7 +++
> > > >    arch/s390/kvm/gaccess.h  |   3 ++
> > > >    arch/s390/kvm/gaccess.c  | 102 +++++++++++++++++++++++++++++++++=
++++++
> > > >    arch/s390/kvm/kvm-s390.c |  41 +++++++++++++++-
> > > >    4 files changed, 151 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > > > index 55155e262646..452f43c1cc34 100644
> > > > --- a/include/uapi/linux/kvm.h
> > > > +++ b/include/uapi/linux/kvm.h
> > > > @@ -583,6 +583,8 @@ struct kvm_s390_mem_op {
> > > >    		struct {
> > > >    			__u8 ar;	/* the access register number */
> > > >    			__u8 key;	/* access key, ignored if flag unset */
> > > > +			__u8 pad1[6];	/* ignored */
> > > > +			__u64 old_addr;	/* ignored if flag unset */
>=20
> Which flag?
> Maybe that would be clearer with a cmpxchg_ prefix.

Yes.
>=20
> > > >    		};
> > > >    		__u32 sida_offset; /* offset into the sida */
> > > >    		__u8 reserved[32]; /* ignored */
> > > > @@ -599,6 +601,11 @@ struct kvm_s390_mem_op {
> > > >    #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
> > > >    #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
> > > >    #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
> > > > +#define KVM_S390_MEMOP_F_CMPXCHG		(1ULL << 3)
> > > > +/* flags specifying extension support */
>=20
> via KVM_CAP_S390_MEM_OP_EXTENSION
>=20
> This is part of the CAP api but is nestled between the memop api.
> I'm not entirely happy about that.

Yes, I wasn't sure where to put it.
>=20
> > >=20
> > > Would that fit behind the bit shifts without getting into the "line t=
oo
> > > long" territory?
> >=20
> > Bit shifts or the next line?
>=20
> Seems like I didn't see that this is grouped to the next line so forget=
=20
> about my comment.
>=20
> > >=20
> > > \n please
> >=20
> > Not sure about all that, this is the way it looks right now:
> >=20
> > /* types for kvm_s390_mem_op->op */
> > #define KVM_S390_MEMOP_LOGICAL_READ     0
> > #define KVM_S390_MEMOP_LOGICAL_WRITE    1
> > #define KVM_S390_MEMOP_SIDA_READ        2
> > #define KVM_S390_MEMOP_SIDA_WRITE       3
> > #define KVM_S390_MEMOP_ABSOLUTE_READ    4
> > #define KVM_S390_MEMOP_ABSOLUTE_WRITE   5
>=20
> > /* flags for kvm_s390_mem_op->flags */
> > #define KVM_S390_MEMOP_F_CHECK_ONLY             (1ULL << 0)
> > #define KVM_S390_MEMOP_F_INJECT_EXCEPTION       (1ULL << 1)
> > #define KVM_S390_MEMOP_F_SKEY_PROTECTION        (1ULL << 2)
> > #define KVM_S390_MEMOP_F_CMPXCHG                (1ULL << 3)
>=20
> > /* flags specifying extension support */
>=20
> > #define KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG 0x2
>=20
> #define KVM_S390_MEMOP_EXTENSION_CAP_ABSOLUTE 1 << 0

Unfortunately, I designed this badly for the first memop extension,
the absolute memop is supported if extension_cap > 0.
But we can always also set bit 0 in that case.

> #define KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG 1 << 1
>=20
> Or maybe BASE instead of ABSOLUTE
>=20
>=20
> > /* Non program exception return codes (pgm codes are 16 bit) */
> > #define KVM_S390_MEMOP_R_NO_XCHG                (1 << 16)
> >=20
> > Seems consistent to me.
>=20
> Consistent and hardly readable once you add two more "categories" of valu=
es.

I'll add newlines then.
>=20
> > >=20
> > > > +/* Non program exception return codes (pgm codes are 16 bit) */
> > > > +#define KVM_S390_MEMOP_R_NO_XCHG		(1 << 16)
> > > >   =20
> > > >    /* for KVM_INTERRUPT */
> > > >    struct kvm_interrupt {
> > > > diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> > > > index 9408d6cc8e2c..92a3b9fb31ec 100644
> > > > --- a/arch/s390/kvm/gaccess.h
> > > > +++ b/arch/s390/kvm/gaccess.h
> > > > @@ -206,6 +206,9 @@ int access_guest_with_key(struct kvm_vcpu *vcpu=
, unsigned long ga, u8 ar,
> > > >    int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
> > > >    		      void *data, unsigned long len, enum gacc_mode mode);
> > > >   =20
> > > > +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len=
,
> > > > +			       __uint128_t *old, __uint128_t new, u8 access_key);
> > > > +
> > > >    /**
> > > >     * write_guest_with_key - copy data from kernel space to guest s=
pace
> > > >     * @vcpu: virtual cpu
> > > > diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> > > > index 0243b6e38d36..6165e761a637 100644
> > > > --- a/arch/s390/kvm/gaccess.c
> > > > +++ b/arch/s390/kvm/gaccess.c
> > > > @@ -1161,6 +1161,108 @@ int access_guest_real(struct kvm_vcpu *vcpu=
, unsigned long gra,
> > > >    	return rc;
> > > >    }
> > > >   =20
> > > > +/**
> > > > + * cmpxchg_guest_abs_with_key() - Perform cmpxchg on guest absolut=
e address.
> > > > + * @kvm: Virtual machine instance.
> > > > + * @gpa: Absolute guest address of the location to be changed.
> > > > + * @len: Operand length of the cmpxchg, required: 1 <=3D len <=3D =
16. Providing a
> > > > + *       non power of two will result in failure.
> > > > + * @old_addr: Pointer to old value. If the location at @gpa contai=
ns this value, the
> > > > + *         exchange will succeed. After calling cmpxchg_guest_abs_=
with_key() *@old
> > > > + *         contains the value at @gpa before the attempt to exchan=
ge the value.
> > > > + * @new: The value to place at @gpa.
> > > > + * @access_key: The access key to use for the guest access.
> > > > + *
> > > > + * Atomically exchange the value at @gpa by @new, if it contains *=
@old.
> > > > + * Honors storage keys.
> > > > + *
> > > > + * Return: * 0: successful exchange
> > > > + *         * 1: exchange unsuccessful
> > > > + *         * a program interruption code indicating the reason cmp=
xchg could
> > > > + *           not be attempted
> > >=20
> > >   > 1 Access related program interruption code indicating the reason
> > > cmpxchg could not be attempted
> > >=20
> > > < 1 Kernel / input data error codes
> >=20
> > I think I'll do it like I said in the email to Thomas, that way it's ma=
ximally
> > explicit about the return values one might get.
>=20
> This shows me that we're overloading the return value way too much.
> Not just of this function but also of the memop with=20
> KVM_S390_MEMOP_R_NO_XCHG.
>=20
> A return of < 0, 0, 1 and a passed int reference for the PGM codes=20
> that's updated if the rc is 1 would make this clearer.

The return code is complicated, using effectively two return codes does cle=
anly
separate the possible error types, but also means one has to check two retu=
rn codes.
I'm fine with that, but in that case it shouldn't be the PGM code that gets=
 separated,
but the success of the xchg. So <0 kernel error, >0 PGM code, like everywhe=
re else
and =3D=3D0 -> check *success.
>=20
> Btw. could a user specify check + cmpxchange as the flags?
> Are we checking that and I've missed to see such a check?

Yes, what that does is basically to check if the cmpxchg args are valid.
Then it checks if the target address is writable.
Not much code necessary for that other than not doing the cmpxchg if check_=
only
is set.
>=20
>=20
> I don't like that we throw in yet another feature as a flag thereby=20
> blowing up kvm_s390_vm_mem_op() and adding new branches to it. I'll need=
=20
> to think about that some more.
>=20
[...]

