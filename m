Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C505F67D253
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 18:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjAZRCC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 12:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjAZRB6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 12:01:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05262B637;
        Thu, 26 Jan 2023 09:01:56 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QFEb5G004200;
        Thu, 26 Jan 2023 17:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=EW1e2pHs1ZylTZ4zBzttNdgHOt4qKXHJLEm8sUJj7YI=;
 b=I5j3VM0wMwuX5+ULamfNKPNyO8DAifGSlpcJy60QxYKz0k2Ty3woejTjCjyw0OJ/EDqI
 ZbrbYlqbwIzFbOjN8N3ksYoGai/X/kSgNdDTXwkiW6cjSe3+FzCkHT8DVTAxfHvT7I92
 5KRixTYspnHqicPXfvC+2+F6YCphvBMu3/yu+OYWtCsfQCFIPi2C4rmqaTBpqN4fM+M/
 eOWkwBsdYLbhmTIYHS0CXnoqYS577W3mt2aYxaurTl9JW4Z14aWHz2ffk8vTgzwNB3yc
 Hdy9uigZimohBIs2yY06U1HN9gYvavtBrMoZ4VulSsFslQMaMejNV/O9d0FdeRzHWu+s bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbv06jmyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 17:01:53 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30QG2Yc4025782;
        Thu, 26 Jan 2023 17:01:52 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbv06jmxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 17:01:52 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QA3C0H027572;
        Thu, 26 Jan 2023 17:01:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6en1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 17:01:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QH1kTi40763682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 17:01:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2938420040;
        Thu, 26 Jan 2023 17:01:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7D702004B;
        Thu, 26 Jan 2023 17:01:44 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.157.249])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 17:01:44 +0000 (GMT)
Message-ID: <c0a33fb0dc8062ad639bb164f06a09f5635490f2.camel@linux.ibm.com>
Subject: Re: [PATCH v6 08/14] KVM: s390: Move common code of mem_op
 functions into functions
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
Date:   Thu, 26 Jan 2023 18:01:42 +0100
In-Reply-To: <a1141cf5-8c44-5e9e-688c-c9dab3ebe8d4@redhat.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
         <20230125212608.1860251-9-scgl@linux.ibm.com>
         <a1141cf5-8c44-5e9e-688c-c9dab3ebe8d4@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 065wPo4c_-re2ayNNcWMACOd9iYx0Rxw
X-Proofpoint-ORIG-GUID: rZ7_W7UXr0_Z3JHqgAJ7Dh2wt99ubVQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_07,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2023-01-26 at 07:48 +0100, Thomas Huth wrote:
> On 25/01/2023 22.26, Janis Schoetterl-Glausch wrote:
> > The vcpu and vm mem_op ioctl implementations share some functionality.
> > Move argument checking and buffer allocation into functions and call
> > them from both implementations.
> > This allows code reuse in case of additional future mem_op operations.
> >=20
> > Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> > Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> > ---
> >   arch/s390/kvm/kvm-s390.c | 80 +++++++++++++++++++++------------------=
-
> >   1 file changed, 42 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index e4890e04b210..e0dfaa195949 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -2764,24 +2764,44 @@ static int kvm_s390_handle_pv(struct kvm *kvm, =
struct kvm_pv_cmd *cmd)
> >   	return r;
> >   }
> >  =20
> > -static bool access_key_invalid(u8 access_key)
> > +static int mem_op_validate_common(struct kvm_s390_mem_op *mop, u64 sup=
ported_flags)
> >   {
> > -	return access_key > 0xf;
> > +	if (mop->flags & ~supported_flags || !mop->size)
> > +		return -EINVAL;
> > +	if (mop->size > MEM_OP_MAX_SIZE)
> > +		return -E2BIG;
> > +	if (mop->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION) {
> > +		if (mop->key > 0xf)
> > +			return -EINVAL;
> > +	} else {
> > +		mop->key =3D 0;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static void *mem_op_alloc_buf(struct kvm_s390_mem_op *mop)
> > +{
> > +	void *buf;
> > +
> > +	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)
> > +		return NULL;
> > +	buf =3D vmalloc(mop->size);
> > +	if (!buf)
> > +		return ERR_PTR(-ENOMEM);
> > +	return buf;
> >   }
> >  =20
> >   static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op=
 *mop)
> >   {
> >   	void __user *uaddr =3D (void __user *)mop->buf;
> > -	u64 supported_flags;
> >   	void *tmpbuf =3D NULL;
>=20
> You likely can now remove the "=3D NULL" here, I guess?

Yeah, I thought about it, but wasn't sure if I like moving the line down be=
cause of
some people's insistence on reverse christmas tree.
It's entirely arbitrary in a different way, but I like the return value bei=
ng the last
thing declared.
In the end I forgot to make a decision on it.

>=20
> >   	int r, srcu_idx;
> >  =20
> > -	supported_flags =3D KVM_S390_MEMOP_F_SKEY_PROTECTION
> > -			  | KVM_S390_MEMOP_F_CHECK_ONLY;
> > -	if (mop->flags & ~supported_flags || !mop->size)
> > -		return -EINVAL;
> > -	if (mop->size > MEM_OP_MAX_SIZE)
> > -		return -E2BIG;
> > +	r =3D mem_op_validate_common(mop, KVM_S390_MEMOP_F_SKEY_PROTECTION |
> > +					KVM_S390_MEMOP_F_CHECK_ONLY);
> > +	if (r)
> > +		return r;
> > +
> >   	/*
> >   	 * This is technically a heuristic only, if the kvm->lock is not
> >   	 * taken, it is not guaranteed that the vm is/remains non-protected.
> > @@ -2793,17 +2813,9 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, s=
truct kvm_s390_mem_op *mop)
> >   	 */
> >   	if (kvm_s390_pv_get_handle(kvm))
> >   		return -EINVAL;
> > -	if (mop->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION) {
> > -		if (access_key_invalid(mop->key))
> > -			return -EINVAL;
> > -	} else {
> > -		mop->key =3D 0;
> > -	}
> > -	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
> > -		tmpbuf =3D vmalloc(mop->size);
> > -		if (!tmpbuf)
> > -			return -ENOMEM;
> > -	}
> > +	tmpbuf =3D mem_op_alloc_buf(mop);
> > +	if (IS_ERR(tmpbuf))
> > +		return PTR_ERR(tmpbuf);
> >  =20
> >   	srcu_idx =3D srcu_read_lock(&kvm->srcu);
> >  =20
> > @@ -5250,28 +5262,20 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcp=
u *vcpu,
> >   {
> >   	void __user *uaddr =3D (void __user *)mop->buf;
> >   	void *tmpbuf =3D NULL;
>=20
> ... and here, too.
>=20
> But I have to admit that I'm also not sure whether I like the=20
> mem_op_alloc_buf() part or not (the mem_op_validate_common() part looks f=
ine=20
> to me) : mem_op_alloc_buf() is a new function with 11 lines of code, and =
the=20
> old spots that allocate memory were only 5 lines of code each, so you now=
=20
> increased the LoC count and additionally have to fiddly with IS_ERR and=
=20
> PTR_ERR which is always a little bit ugly in my eyes ... IMHO I'd rather=
=20
> keep the old code here. But that's just my 0.02 =E2=82=AC, if you think i=
t's nicer=20
> with mem_op_alloc_buf(), I won't insist on keeping the old code.

Yeah, that's fair.

>=20
>   Thomas
>=20
>=20
> > -	int r =3D 0;
> > -	const u64 supported_flags =3D KVM_S390_MEMOP_F_INJECT_EXCEPTION
> > -				    | KVM_S390_MEMOP_F_CHECK_ONLY
> > -				    | KVM_S390_MEMOP_F_SKEY_PROTECTION;
> > +	int r;
> >  =20
> > -	if (mop->flags & ~supported_flags || mop->ar >=3D NUM_ACRS || !mop->s=
ize)
> > +	r =3D mem_op_validate_common(mop, KVM_S390_MEMOP_F_INJECT_EXCEPTION |
> > +					KVM_S390_MEMOP_F_CHECK_ONLY |
> > +					KVM_S390_MEMOP_F_SKEY_PROTECTION);
> > +	if (r)
> > +		return r;
> > +	if (mop->ar >=3D NUM_ACRS)
> >   		return -EINVAL;
> > -	if (mop->size > MEM_OP_MAX_SIZE)
> > -		return -E2BIG;
> >   	if (kvm_s390_pv_cpu_is_protected(vcpu))
> >   		return -EINVAL;
> > -	if (mop->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION) {
> > -		if (access_key_invalid(mop->key))
> > -			return -EINVAL;
> > -	} else {
> > -		mop->key =3D 0;
> > -	}
> > -	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
> > -		tmpbuf =3D vmalloc(mop->size);
> > -		if (!tmpbuf)
> > -			return -ENOMEM;
> > -	}
> > +	tmpbuf =3D mem_op_alloc_buf(mop);
> > +	if (IS_ERR(tmpbuf))
> > +		return PTR_ERR(tmpbuf);
> >  =20
> >   	switch (mop->op) {
> >   	case KVM_S390_MEMOP_LOGICAL_READ:
>=20

