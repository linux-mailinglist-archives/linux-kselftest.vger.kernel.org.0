Return-Path: <linux-kselftest+bounces-5038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F1885C03F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 16:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C06284B8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 15:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFC676052;
	Tue, 20 Feb 2024 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eGUVpcGz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678EE76058;
	Tue, 20 Feb 2024 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443903; cv=none; b=KQQlLLvSbAnE9LZKsvVHkmLBadcr2npOXE7Cu1wkJv9LOrqNLIkFOXhocZFI/y6locqLS5OAHlHPgccctU2QTPme3vjYTNBSqLZoexRJFcGBgiPjR9+AfBuaKB9ev/BgCLzTFx+8q77kp5v1PjPh49EB0HqvivS5yM925ggd8Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443903; c=relaxed/simple;
	bh=yF6OpNfTH4WzCW2G0hJmEC84EsFmU634rbozVj14PR8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UGW8NMI0qh/Fp/xPZeQKT31VQEq34QmqJmYUqJsCkg5xzHGdITBkeK7GKgunTlL+bDf8j6Fgn8wFeSBuKzFz4ZUxdkNyM0oVwm39pR6+XY7X11vbLyEr5whCfrHjZZPa5xJUWU7QfrQOyi+AI3n20Kee1I8dyp2PFrlqI9/NhL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eGUVpcGz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KFeiPl021791;
	Tue, 20 Feb 2024 15:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/Vb9XBabRe0+OjCt1NYXNsEUffysOfODjWe3eEA+kiA=;
 b=eGUVpcGzvBSPAgGcXuCicq5YAxYNlAr2/qYrFbIaXHu+oRCfnCA7yKf2bgOTC7zIb1d0
 TDnMFPO5VG71ttpZionLDp2VG5Qw9VCsrSINyHT8VZEJCR4F63guF1jw10stkmWnI61C
 XdhjQ9Yoo3MN3p665mM/BHsWb3jwIeTx1Oavdo0yHCCWGT1Vr3et0WhFJHMlsAjvquia
 aUxHCCVxB/vsbVXzGJiq0Wyyv9SpWtCfBmwlMp6vLoszE0cUrbSNpjXVRIg16D2if0D8
 sXh1VsLjFCgvpgNOOeuNct29Vz0DNsgXgLo8+PUgcleBO+DyMDJKLK9tX0gHNmYFK208 gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcv3qw83e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 15:44:56 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41KFNmWX025106;
	Tue, 20 Feb 2024 15:44:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcv3qw82k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 15:44:56 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41KDjT7D013492;
	Tue, 20 Feb 2024 15:44:55 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h0994c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 15:44:55 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41KFip0L63504686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 15:44:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBA0758058;
	Tue, 20 Feb 2024 15:44:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AACC5805E;
	Tue, 20 Feb 2024 15:44:50 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.63.241])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Feb 2024 15:44:50 +0000 (GMT)
Message-ID: <2266da81e6f6355106a3718ad7de56e8b47e9555.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] KVM: s390: selftests: memop: add a simple AR test
From: Eric Farman <farman@linux.ibm.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio
 Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
 <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Date: Tue, 20 Feb 2024 10:44:49 -0500
In-Reply-To: <43ab557a097f2e64b0869861866569e6ac372972.camel@linux.ibm.com>
References: <20240215205344.2562020-1-farman@linux.ibm.com>
	 <20240215205344.2562020-3-farman@linux.ibm.com>
	 <43ab557a097f2e64b0869861866569e6ac372972.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eozT_2ET5_IWsPQ9_Kan4S8e-4VsuE5-
X-Proofpoint-GUID: mry1YQT_BwNE1RGeJqywVE7LCHez-ieL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200112

On Tue, 2024-02-20 at 14:34 +0100, Nina Schoetterl-Glausch wrote:
> On Thu, 2024-02-15 at 21:53 +0100, Eric Farman wrote:
> > There is a selftest that checks for an (expected) error when an
> > invalid AR is specified, but not one that exercises the AR path.
> >=20
> > Add a simple test that mirrors the vanilla write/read test while
> > providing an AR. An AR that contains zero will direct the CPU to
> > use the primary address space normally used anyway. AR[1] is
> > selected for this test because the host AR[1] is usually non-zero,
> > and KVM needs to correctly swap those values.
> >=20
> > Signed-off-by: Eric Farman <farman@linux.ibm.com>
>=20
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>=20
> > ---
> > =C2=A0tools/testing/selftests/kvm/s390x/memop.c | 28
> > +++++++++++++++++++++++
> > =C2=A01 file changed, 28 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/kvm/s390x/memop.c
> > b/tools/testing/selftests/kvm/s390x/memop.c
> > index bb3ca9a5d731..be20c26ee545 100644
> > --- a/tools/testing/selftests/kvm/s390x/memop.c
> > +++ b/tools/testing/selftests/kvm/s390x/memop.c
> > @@ -375,6 +375,29 @@ static void test_copy(void)
> > =C2=A0	kvm_vm_free(t.kvm_vm);
> > =C2=A0}
> >=20
> > +static void test_copy_access_register(void)
> > +{
> > +	struct test_default t =3D test_default_init(guest_copy);
> > +
> > +	HOST_SYNC(t.vcpu, STAGE_INITED);
> > +
> > +	prepare_mem12();
> > +	t.run->psw_mask &=3D ~(3UL << (63 - 17));
> > +	t.run->psw_mask |=3D 1UL << (63 - 17);=C2=A0 /* Enable AR mode */
> > +
>=20
> I feel like part of the commit message should be a comment here
>=20
> /*
> =C2=A0* Guest AR[1] should be zero, in which case the primary address
> space is used.
> =C2=A0* The host makes use of AR[1], its value must not be used for the
> memop.
> =C2=A0*/
> > +	CHECK_N_DO(MOP, t.vcpu, LOGICAL, WRITE, mem1, t.size,
> > +		=C2=A0=C2=A0 GADDR_V(mem1), AR(1));
> > +	HOST_SYNC(t.vcpu, STAGE_COPIED);
> > +
> > +	CHECK_N_DO(MOP, t.vcpu, LOGICAL, READ, mem2, t.size,
> > +		=C2=A0=C2=A0 GADDR_V(mem2), AR(1));
> > +	ASSERT_MEM_EQ(mem1, mem2, t.size);
> > +
> > +	t.run->psw_mask &=3D ~(3UL << (63 - 17));=C2=A0=C2=A0 /* Disable AR
> > mode */
>=20
> Any reason for this? It's not necessary since the vm is going to be
> destroyed.

Nah. I think I was just putting it back the way I was, in case I did
slap another test on there, but never did.

> > +
> > +	kvm_vm_free(t.kvm_vm);
> > +}
> > +
> > =C2=A0static void set_storage_key_range(void *addr, size_t len, uint8_t
> > key)
> > =C2=A0{
> > =C2=A0	uintptr_t _addr, abs, i;
> > @@ -1101,6 +1124,11 @@ int main(int argc, char *argv[])
> > =C2=A0			.test =3D test_copy_key_fetch_prot_override,
> > =C2=A0			.requirements_met =3D extension_cap > 0,
> > =C2=A0		},
> > +		{
> > +			.name =3D "copy with access register mode",
> > +			.test =3D test_copy_access_register,
> > +			.requirements_met =3D true,
> > +		},
> > =C2=A0		{
> > =C2=A0			.name =3D "error checks with key",
> > =C2=A0			.test =3D test_errors_key,
>=20


