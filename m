Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8FD64CACF
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Dec 2022 14:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbiLNNNc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 08:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238559AbiLNNNF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 08:13:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579481DDF4;
        Wed, 14 Dec 2022 05:13:03 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BED9o6K016302;
        Wed, 14 Dec 2022 13:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+X8vBTXhuJayZi+n5xcerhZSBoMD6FPhYzBBkxSWiBY=;
 b=qJAtllIL9P+/nSSguVKGi8/bzPD1syOKwH+gMHLqRZJSHhkXKyoiFbfRcpekm3XN0gTc
 JYc7SL/XJrttJF/hD5QYmlOyNh5kf78oL2AG4BnMezz+Era8yqcwciwX5m8fue/g42IT
 B1/yzQmQgt3tJycw3+hxk5rhnY8r0Za5fsEJNSWYNuoJTQ+MFOG9D+Vox6raJNM2HfWT
 XHsQMsCzWFay5nu334pxyynSfDYIZZ1AURV0gRcEibLKCPLSlFAcLaXvDzh4PHBRUb+f
 INfqspsvcVEHaCA+gf+BE908N0m2SoF8VAOfHzge8yfDIO28FaVCULRJku3w6SiMNkXz gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mff4cg32k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 13:12:59 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BEDAQAC020179;
        Wed, 14 Dec 2022 13:12:59 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mff4cg31r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 13:12:59 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEA7NSh001252;
        Wed, 14 Dec 2022 13:12:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3meyyeha0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 13:12:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BEDCrdT22348110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 13:12:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9389C2004D;
        Wed, 14 Dec 2022 13:12:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DAF320049;
        Wed, 14 Dec 2022 13:12:53 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.152.224.238])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 14 Dec 2022 13:12:53 +0000 (GMT)
Message-ID: <ef18716114c13a932aad195441bb0b79007bdc7b.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/9] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
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
Date:   Wed, 14 Dec 2022 14:12:53 +0100
In-Reply-To: <44816a09-8567-b2be-84ef-ada621d1beb4@redhat.com>
References: <20221213165405.2953539-1-scgl@linux.ibm.com>
         <20221213165405.2953539-2-scgl@linux.ibm.com>
         <44816a09-8567-b2be-84ef-ada621d1beb4@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: osTXaTYPV9eohzN8cZlshfkjKvsoiaGx
X-Proofpoint-ORIG-GUID: p-7tYJ10CsiWo2h-0h_xUHH5B28Rh3VQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_06,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-12-14 at 10:19 +0100, Thomas Huth wrote:
> On 13/12/2022 17.53, Janis Schoetterl-Glausch wrote:
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
> >   arch/s390/kvm/kvm-s390.c |  39 ++++++++++++++-
> >   4 files changed, 149 insertions(+), 2 deletions(-)
> >=20
[...]
> >=20
> > @@ -2714,12 +2721,19 @@ static bool access_key_invalid(u8 access_key)
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
> > @@ -2741,6 +2755,19 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, s=
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
> I'd maybe add a check for mop->op =3D=3D KVM_S390_MEMOP_ABSOLUTE_WRITE he=
re,=20
> since calling the _READ function with the F_CMPXCHG flag set does not mak=
e=20
> too much sense.

Good point.
>=20
> Anyway, patch looks good to me, so with or without that additional check:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!
>=20
> > +		if (copy_from_user(&new.raw[off_in_quad], uaddr, mop->size))
> > +			return -EFAULT;
> > +		if (copy_from_user(&old.raw[off_in_quad], old_addr, mop->size))
> > +			return -EFAULT;
> > +	}
> >   	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
> >   		tmpbuf =3D vmalloc(mop->size);
> >   		if (!tmpbuf)
> > @@ -2771,6 +2798,14 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, s=
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
> > +				if (copy_to_user(old_addr, &old.raw[off_in_quad], mop->size))
> > +					r =3D -EFAULT;
> > +			}
> >   		} else {
> >   			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
> >   				r =3D -EFAULT;
>=20

