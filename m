Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D452A689E6B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 16:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjBCPh5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 10:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjBCPhz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 10:37:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EBB6EDCA;
        Fri,  3 Feb 2023 07:37:53 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313FOGq2007962;
        Fri, 3 Feb 2023 15:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wJPy5gnQQgp5DWijqh1cR/GZtnWuAVWAz/2QL+MNjPE=;
 b=VOZb5kX225l4AaPDHjqZuMPrpwTGxhw4Kzr1+f5z/4HUaxYf+aLXPTQkYVCNa9DVVGNH
 MfvAAptMZht5nPRqJ+7gPG+COvFfA8jTU2vKsIeamPnHk37KCtan/Uyw459Wbles/NvR
 3Diulm3pArzRGt+S7aOKgb3fO+MzNelogQQHu5Nc9kNWFnBpWEyESlpfvgQt+UWkv4r5
 0ekeygL1x60gAM4w1fD5ryBtyCXBzf7zZDNf4UXISQVO6QeZu9OtdEdxUwUK6UDKy+3X
 nqL+f+KzhyzwS7VuAQCMesX386rGWYLlL51hOfBK44wfsNWZ4UFgE9k/NMaub+LLC2Iu 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nh4vqgb4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:37:47 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 313FQv66019759;
        Fri, 3 Feb 2023 15:37:47 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nh4vqgb3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:37:47 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 313DpObg024026;
        Fri, 3 Feb 2023 15:32:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3ncvuqwe4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 15:32:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 313FWfAE50004278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Feb 2023 15:32:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A112C20043;
        Fri,  3 Feb 2023 15:32:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52FF12004B;
        Fri,  3 Feb 2023 15:32:41 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.195.237])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Feb 2023 15:32:41 +0000 (GMT)
Message-ID: <e96b3c20055105af9ba76f0abefeb5a236023f37.camel@linux.ibm.com>
Subject: Re: [PATCH v6 10/14] KVM: s390: Refactor absolute vm mem_op function
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
Date:   Fri, 03 Feb 2023 16:32:41 +0100
In-Reply-To: <f1b28707-c525-7cd1-64d5-6717bac5d711@linux.ibm.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
         <20230125212608.1860251-11-scgl@linux.ibm.com>
         <f1b28707-c525-7cd1-64d5-6717bac5d711@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 54Gn0kQUnlQTHXPWzLe1AGFCY_plwiBj
X-Proofpoint-ORIG-GUID: 1dQmxI_NRK3cY9hLoGNOL_62IpZVv4AJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_15,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxlogscore=920
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030139
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2023-02-03 at 15:48 +0100, Janosch Frank wrote:
> On 1/25/23 22:26, Janis Schoetterl-Glausch wrote:
> > Remove code duplication with regards to the CHECK_ONLY flag.
> > Decrease the number of indents.
> > No functional change indented.
> >=20
> > Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> > Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> > ---
> >=20
> >=20
> > Cosmetic only, can be dropped.
> >=20
> >=20
> >   arch/s390/kvm/kvm-s390.c | 43 ++++++++++++++++-----------------------=
-
> >   1 file changed, 17 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index 588cf70dc81e..cfd09cb43ef6 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -2794,6 +2794,7 @@ static void *mem_op_alloc_buf(struct kvm_s390_mem=
_op *mop)
> >   static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_me=
m_op *mop)
> >   {
> >   	void __user *uaddr =3D (void __user *)mop->buf;
> > +	enum gacc_mode acc_mode;
> >   	void *tmpbuf =3D NULL;
> >   	int r, srcu_idx;
> >  =20
> > @@ -2813,33 +2814,23 @@ static int kvm_s390_vm_mem_op_abs(struct kvm *k=
vm, struct kvm_s390_mem_op *mop)
> >   		goto out_unlock;
> >   	}
> >  =20
> > -	switch (mop->op) {
> > -	case KVM_S390_MEMOP_ABSOLUTE_READ: {
> > -		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
> > -			r =3D check_gpa_range(kvm, mop->gaddr, mop->size, GACC_FETCH, mop->=
key);
> > -		} else {
> > -			r =3D access_guest_abs_with_key(kvm, mop->gaddr, tmpbuf,
> > -						      mop->size, GACC_FETCH, mop->key);
> > -			if (r =3D=3D 0) {
> > -				if (copy_to_user(uaddr, tmpbuf, mop->size))
> > -					r =3D -EFAULT;
> > -			}
> > -		}
> > -		break;
> > -	}
> > -	case KVM_S390_MEMOP_ABSOLUTE_WRITE: {
> > -		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
> > -			r =3D check_gpa_range(kvm, mop->gaddr, mop->size, GACC_STORE, mop->=
key);
> > -		} else {
> > -			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
> > -				r =3D -EFAULT;
> > -				break;
> > -			}
> > -			r =3D access_guest_abs_with_key(kvm, mop->gaddr, tmpbuf,
> > -						      mop->size, GACC_STORE, mop->key);
> > +	acc_mode =3D mop->op =3D=3D KVM_S390_MEMOP_ABSOLUTE_READ ? GACC_FETCH=
 : GACC_STORE;
>=20
> Would the line be too long if that variable would be initialized where=
=20
> it's defined?

Just fits at 100 columns. Want me to move it?

>=20
> > +	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
> > +		r =3D check_gpa_range(kvm, mop->gaddr, mop->size, acc_mode, mop->key=
);
>=20
> We should early return i.e. goto out_unlock.
>=20
> IMHO else if, else patterns should either be switches (testing the same=
=20
> variable) or kept as short as possible / be avoided.
>=20
> > +	} else if (acc_mode =3D=3D GACC_FETCH) {
> > +		r =3D access_guest_abs_with_key(kvm, mop->gaddr, tmpbuf,
> > +					      mop->size, GACC_FETCH, mop->key);
>=20
> I'd guess it's personal taste whether you use GACC_FETCH or access_mode=
=20
> but if you don't use it here then we can remove the variable all=20
> together, no?

Yeah, I think I did replace it, but then undid it.
Probably just because it is a bit more explicit.
It's used in check_gpa_range, so no, unless you want to dump the expression
directly in there.
>=20
> > +		if (r)
> > +			goto out_unlock;
> > +		if (copy_to_user(uaddr, tmpbuf, mop->size))
> > +			r =3D -EFAULT;
> > +	} else {
> > +		if (copy_from_user(tmpbuf, uaddr, mop->size)) {
> > +			r =3D -EFAULT;
> > +			goto out_unlock;
> >   		}
> > -		break;
> > -	}
> > +		r =3D access_guest_abs_with_key(kvm, mop->gaddr, tmpbuf,
> > +					      mop->size, GACC_STORE, mop->key);
> >   	}
> >  =20
> >   out_unlock:
>=20

