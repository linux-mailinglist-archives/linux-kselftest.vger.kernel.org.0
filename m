Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ECC665886
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 11:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjAKKEh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Jan 2023 05:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239284AbjAKKDl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Jan 2023 05:03:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA61BB5;
        Wed, 11 Jan 2023 02:00:37 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B9kQPb028874;
        Wed, 11 Jan 2023 10:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ebV2neORlgOnbXg6JlXw5mYLuipMR2R7YAmoj90e/b0=;
 b=tHNq7RzZgfgWpi7u2hueOqRQv9oleS2bfnvYv/Iw51uQLX9TTowwz7HiMsWEUXHu00eM
 PML9aRE8onZudj6PC/KafQ+ccBz/9qjW79OSwcXWQAXI0Mtz9o9RYQPU8GsVX2SC7GmV
 v+qAwxRH0szuzxJzZZgba3+8YTeKqQgMthx8uUQRrN2RKvgpUhboYEr0EhkjtWbBGOIU
 amLcTFoa7nouQ2cHSWNMbfXExT92n9jLoNJDEuuUWUiZ8qySicwCQzVAeTC5iquitIXT
 +Oh9EaIDpb9hlHmo6IcAC3nKVZSefPekRQfkC1Y8p3Qg3U1t5mExF5T6fmnBk0jXgLed Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1tsa09sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 10:00:34 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30B9l4Jn003432;
        Wed, 11 Jan 2023 10:00:33 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1tsa09r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 10:00:33 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30B1b75O004503;
        Wed, 11 Jan 2023 10:00:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n1kkyrks4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 10:00:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30BA0Rwj40305020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 10:00:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4216D2004B;
        Wed, 11 Jan 2023 10:00:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E110320043;
        Wed, 11 Jan 2023 10:00:26 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.147.253])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jan 2023 10:00:26 +0000 (GMT)
Message-ID: <205f71e7ea88e7fb2e7bf1e013855b3ed0639150.camel@linux.ibm.com>
Subject: Re: [PATCH v5 01/10] KVM: s390: Extend MEM_OP ioctl by storage key
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
Date:   Wed, 11 Jan 2023 11:00:26 +0100
In-Reply-To: <d124764c-f221-98d8-a286-79efe176515c@redhat.com>
References: <20230110202632.2533978-1-scgl@linux.ibm.com>
         <20230110202632.2533978-2-scgl@linux.ibm.com>
         <d124764c-f221-98d8-a286-79efe176515c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eWi_qdtQOddcgXDlLqz8bjVM0YJ55G-Z
X-Proofpoint-GUID: YtF7UBpW9yDc1Up4lEP0H1LdTpNzUYEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_04,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2023-01-11 at 08:59 +0100, Thomas Huth wrote:
> On 10/01/2023 21.26, Janis Schoetterl-Glausch wrote:
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
[...]

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
> PGM_OPERATION has also the value 1 ... can we be sure that it never happe=
ns=20
> here?

Currently yes, only program errors are those explicit in the code,
PGM_ADDRESSING and PGM_PROTECTION.

> ... maybe it would make sense to use KVM_S390_MEMOP_R_NO_XCHG for=20
> return value here instead of 1, too, just to be on the safe side?

I didn't like that idea because I consider KVM_S390_MEMOP_R_NO_XCHG to be
part of the KVM's api surface and cmpxchg_guest_abs_with_key is an internal
function that shouldn't concern itself with that.

But being unclear on PGM_OPERATION is indeed ugly.
Maybe I should just replace "a program interruption code ..." with the spec=
ific ones?
>=20
> Apart from that, patch looks fine to me.
>=20
>   Thomas
>=20
>=20
> > + *         * -EINVAL: address misaligned or len not power of two
> > + *         * -EAGAIN: transient failure (len 1 or 2)
> > + *         * -EOPNOTSUPP: read-only memslot (should never occur)
> > + */
> > +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
> > +			       __uint128_t *old_addr, __uint128_t new,
> > +			       u8 access_key)
> > +{
> > +	gfn_t gfn =3D gpa >> PAGE_SHIFT;
> > +	struct kvm_memory_slot *slot =3D gfn_to_memslot(kvm, gfn);
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
> > +
> > +	hva +=3D offset_in_page(gpa);
> > +	switch (len) {
> > +	case 1: {
> > +		u8 old;
> > +
> > +		ret =3D cmpxchg_user_key((u8 *)hva, &old, *old_addr, new, access_key=
);
> > +		ret =3D ret < 0 ? ret : old !=3D *old_addr;
> > +		*old_addr =3D old;
> > +		break;
> > +	}
> > +	case 2: {
> > +		u16 old;
> > +
> > +		ret =3D cmpxchg_user_key((u16 *)hva, &old, *old_addr, new, access_ke=
y);
> > +		ret =3D ret < 0 ? ret : old !=3D *old_addr;
> > +		*old_addr =3D old;
> > +		break;
> > +	}
> > +	case 4: {
> > +		u32 old;
> > +
> > +		ret =3D cmpxchg_user_key((u32 *)hva, &old, *old_addr, new, access_ke=
y);
> > +		ret =3D ret < 0 ? ret : old !=3D *old_addr;
> > +		*old_addr =3D old;
> > +		break;
> > +	}
> > +	case 8: {
> > +		u64 old;
> > +
> > +		ret =3D cmpxchg_user_key((u64 *)hva, &old, *old_addr, new, access_ke=
y);
> > +		ret =3D ret < 0 ? ret : old !=3D *old_addr;
> > +		*old_addr =3D old;
> > +		break;
> > +	}
> > +	case 16: {
> > +		__uint128_t old;
> > +
> > +		ret =3D cmpxchg_user_key((__uint128_t *)hva, &old, *old_addr, new, a=
ccess_key);
> > +		ret =3D ret < 0 ? ret : old !=3D *old_addr;
> > +		*old_addr =3D old;
> > +		break;
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
[...]
