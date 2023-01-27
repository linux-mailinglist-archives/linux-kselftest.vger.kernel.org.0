Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F4E67ED96
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 19:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjA0SeZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 13:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjA0SeX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 13:34:23 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0996F21C;
        Fri, 27 Jan 2023 10:34:22 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RHhJr5003759;
        Fri, 27 Jan 2023 18:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=z4AA2ZK0KoCUrgCsScIkdFlax+AQ1xvYsqquTrj3a5k=;
 b=G9pUnuBbqRSCRdf+GsYx9Y7GLDNQsNXSdMqDVm4TYpQzKToLMJbNSrqH2mRHgGP35JBq
 tTLFq1hDM3Rp+BT67b9LYISni+BkgJpgI6ECun+omCs8zIiHLKx3bbocbZaxJHjjQYER
 3wYnjcyuFKX5Jp6EZx/YbOi4EpvFnVnWlzp+/szXrMECf+4L/6HqdIScFvWZGfkApzIE
 5wmmtPJ/U/lPZ3CJyl0jLKVRBb2OhH8l08ddTeixAjFZa4y7lyMgHdSf2lOWqgHgprcv
 XYdaMP0CrkjP6zdPIcgYEsulABQV2K+UL3iFPzwjqiplH+NdVrXM3kwansig+s1x0Yq5 CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nck8s0rsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 18:15:28 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RHujp9007987;
        Fri, 27 Jan 2023 18:15:28 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nck8s0rrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 18:15:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R6E8Fo014903;
        Fri, 27 Jan 2023 18:15:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87affwh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 18:15:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RIFMIn47579566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 18:15:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9857720049;
        Fri, 27 Jan 2023 18:15:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DDE920040;
        Fri, 27 Jan 2023 18:15:22 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.154.20])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 18:15:22 +0000 (GMT)
Message-ID: <f0f6c83f7d38a24234203849e116516ab7ac32f7.camel@linux.ibm.com>
Subject: Re: [PATCH v6 12/14] KVM: s390: Extend MEM_OP ioctl by storage key
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
Date:   Fri, 27 Jan 2023 19:15:22 +0100
In-Reply-To: <aa942cf0-6f50-05f5-75a9-278129f00bf6@linux.ibm.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
         <20230125212608.1860251-13-scgl@linux.ibm.com>
         <aa942cf0-6f50-05f5-75a9-278129f00bf6@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X4TYTTeX60ySKf2aPVbcn3mRdDhAB91y
X-Proofpoint-ORIG-GUID: fWJGBKK6oPYom01hnFAZGuDL5eIDQoTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_10,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270167
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2023-01-26 at 17:10 +0100, Janosch Frank wrote:
> On 1/25/23 22:26, Janis Schoetterl-Glausch wrote:
> > User space can use the MEM_OP ioctl to make storage key checked reads
> > and writes to the guest, however, it has no way of performing atomic,
> > key checked, accesses to the guest.
> > Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
> > op. For now, support this op for absolute accesses only.
> >=20
> > This op can be use, for example, to set the device-state-change
>=20
> s/use/used/
>=20
> > indicator and the adapter-local-summary indicator atomically.
> >=20
> > Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> > ---
> [...]
> > +/**
> > + * cmpxchg_guest_abs_with_key() - Perform cmpxchg on guest absolute ad=
dress.
> > + * @kvm: Virtual machine instance.
> > + * @gpa: Absolute guest address of the location to be changed.
> > + * @len: Operand length of the cmpxchg, required: 1 <=3D len <=3D 16. =
Providing a
> > + *       non power of two will result in failure.
> > + * @old_addr: Pointer to old value. If the location at @gpa contains t=
his value,
> > + *            the exchange will succeed. After calling cmpxchg_guest_a=
bs_with_key()
> > + *            *@old_addr contains the value at @gpa before the attempt=
 to
> > + *            exchange the value.
> > + * @new: The value to place at @gpa.
> > + * @access_key: The access key to use for the guest access.
> > + * @success: output value indicating if an exchange occurred.
> > + *
> > + * Atomically exchange the value at @gpa by @new, if it contains *@old=
.
> > + * Honors storage keys.
> > + *
> > + * Return: * 0: successful exchange
> > + *         * a program interruption code indicating the reason cmpxchg=
 could
> > + *           not be attempted
>=20
> Nit:
>  >0: a program interruption code...
>=20
>=20
> > + *         * -EINVAL: address misaligned or len not power of two
> > + *         * -EAGAIN: transient failure (len 1 or 2)
> > + *         * -EOPNOTSUPP: read-only memslot (should never occur)
> > + */
> > +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
> > +			       __uint128_t *old_addr, __uint128_t new,
> > +			       u8 access_key, bool *success)
> > +{
> > +	gfn_t gfn =3D gpa >> PAGE_SHIFT;
>=20
>   gpa_to_gfn()?

Yes.
>=20
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
>=20
> Hmm if we don't use a macro to generate these then I'd add an explanation=
:
>=20
> cmpxchg_user_key() is a macro that is dependent on the type of "old" so=
=20
> there's no deduplication possible without further macros.

Can do.
Btw. I could move the other two statements out of the switch by using a uni=
on of old values,
memcmp and memcpy, but I think that would be less readable.

>=20
> > +	switch (len) {
> > +	case 1: {
> > +		u8 old;
> > +
> > +		ret =3D cmpxchg_user_key((u8 *)hva, &old, *old_addr, new, access_key=
);
> > +		*success =3D !ret && old =3D=3D *old_addr;
> > +		*old_addr =3D old;
> > +		break;
> > +	}
> > +	case 2: {
> > +		u16 old;
> > +
> > +		ret =3D cmpxchg_user_key((u16 *)hva, &old, *old_addr, new, access_ke=
y);
> > +		*success =3D !ret && old =3D=3D *old_addr;
> > +		*old_addr =3D old;
> > +		break;
> > +	}
> > +	case 4: {
> > +		u32 old;
> > +
> > +		ret =3D cmpxchg_user_key((u32 *)hva, &old, *old_addr, new, access_ke=
y);
> > +		*success =3D !ret && old =3D=3D *old_addr;
> > +		*old_addr =3D old;
> > +		break;
> > +	}
> > +	case 8: {
> > +		u64 old;
> > +
> > +		ret =3D cmpxchg_user_key((u64 *)hva, &old, *old_addr, new, access_ke=
y);
> > +		*success =3D !ret && old =3D=3D *old_addr;
> > +		*old_addr =3D old;
> > +		break;
> > +	}
> > +	case 16: {
> > +		__uint128_t old;
> > +
> > +		ret =3D cmpxchg_user_key((__uint128_t *)hva, &old, *old_addr, new, a=
ccess_key);
> > +		*success =3D !ret && old =3D=3D *old_addr;
> > +		*old_addr =3D old;
> > +		break;
> > +	}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	mark_page_dirty_in_slot(kvm, slot, gfn);
>=20
> Is that needed if we failed the store?

Indeed it isn't.

[...]

