Return-Path: <linux-kselftest+bounces-2142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64534816DCE
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 13:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF1DDB20548
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 12:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC09E4B5B3;
	Mon, 18 Dec 2023 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IShpKzBB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB94B13F;
	Mon, 18 Dec 2023 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIBmwMh020725;
	Mon, 18 Dec 2023 12:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2WN8VsOyG4EmTcHfp1n8B+knpWBd+9sbz9hkU8Songg=;
 b=IShpKzBBjboojYcbmGVfsGZ/nvLmzbDJwWB7fqkQRxVYAt6Y3r5jFFFpmxOXccOWFaN1
 6xd66B56YBW/XKpb3b9pTXKtjD34UVj2Myu2yG1qHjIQIPuP2qnL2NIr6ZGi7/kfzMpi
 QpFudwrZIuhyl+hGL4zXsvFmd/7HKKLcfx6KbEMzmgIAacSBinghYTJ5QVe2JMCJG0DR
 LKnmJuDk60mPvE53agO/l66v3RHE6yHB+DeLcS/Hue9/i7Rks0efxLkpphRIkjVWuNFJ
 t2E/zOuf20E9ssR/0GrHFuQwgpfPcbGA/SAL8GXelWSyDIB2nkAjuZ2YIJBydE0P/YoL Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2nhdgtdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 12:18:22 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBo92e023329;
	Mon, 18 Dec 2023 12:18:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2nhdgtdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 12:18:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI9jcSs010954;
	Mon, 18 Dec 2023 12:18:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7n8kya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 12:18:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BICIF8U40305196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 12:18:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EFF02004D;
	Mon, 18 Dec 2023 12:18:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8EAA20043;
	Mon, 18 Dec 2023 12:18:14 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown [9.171.53.250])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Dec 2023 12:18:14 +0000 (GMT)
Message-ID: <59621e88c5c29bdff8bc06f68b02b2c7a420a09a.camel@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: selftest: memop: Fix undefined behavior
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Date: Mon, 18 Dec 2023 13:18:14 +0100
In-Reply-To: <20231215180206.740df738@p-imbrenda>
References: <20231215161125.943551-1-nsg@linux.ibm.com>
	 <20231215180206.740df738@p-imbrenda>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bVERkLdM2YHjxVe6DsvclQc668euBIDF
X-Proofpoint-ORIG-GUID: baXPKi0wmsIYc3Yx3-gM48kfdRQYxMwB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_07,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312180089

On Fri, 2023-12-15 at 18:02 +0100, Claudio Imbrenda wrote:
> On Fri, 15 Dec 2023 17:11:25 +0100
> Nina Schoetterl-Glausch <nsg@linux.ibm.com> wrote:
>=20
> > If an integer's type has x bits, shifting the integer left by x or more
> > is undefined behavior.
> > This can happen in the rotate function when attempting to do a rotation
> > of the whole value by 0.
>=20
> is 0 the only problematic value? because in that case...=20
>=20
> >=20
> > Fixes: 0dd714bfd200 ("KVM: s390: selftest: memop: Add cmpxchg tests")
> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > ---
> >  tools/testing/selftests/kvm/s390x/memop.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/=
selftests/kvm/s390x/memop.c
> > index bb3ca9a5d731..2eba9575828e 100644
> > --- a/tools/testing/selftests/kvm/s390x/memop.c
> > +++ b/tools/testing/selftests/kvm/s390x/memop.c
> > @@ -485,11 +485,13 @@ static bool popcount_eq(__uint128_t a, __uint128_=
t b)
> > =20
> >  static __uint128_t rotate(int size, __uint128_t val, int amount)
> >  {
> > -	unsigned int bits =3D size * 8;
> > +	unsigned int left, right, bits =3D size * 8;
> > =20
>=20
> ...why not just:
>=20
> if (!amount)
> 	return val;
>=20
> ?

That works if you move it one statement down (128 would also trigger UB).
% 128 does the trick, is branchless and there is a bit of a symmetry going
on between right and left.
But I can use an early return if you want.

>=20
> > -	amount =3D (amount + bits) % bits;
> > +	right =3D (amount + bits) % bits;
> > +	/* % 128 prevents left shift UB if size =3D=3D 16 && right =3D=3D 0 *=
/
> > +	left =3D (bits - right) % 128;
> >  	val =3D cut_to_size(size, val);
> > -	return (val << (bits - amount)) | (val >> amount);
> > +	return (val << left) | (val >> right);
> >  }
> > =20
> >  const unsigned int max_block =3D 16;
> >=20
> > base-commit: 305230142ae0637213bf6e04f6d9f10bbcb74af8
>=20


