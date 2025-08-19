Return-Path: <linux-kselftest+bounces-39295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A850B2BB3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 09:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2980C3BF02C
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 07:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707E131064B;
	Tue, 19 Aug 2025 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kq0pIQv9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAAA284884;
	Tue, 19 Aug 2025 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590274; cv=none; b=hJbTb4um8zPjgib8bEDTSn18o13AvaRrP1Zt8rVtw3NPSJd2n2U4wFjf+X22R25PbQ/K0nqRuLM6IDW+MFmFrXaGvD8kGySZ6kqym/C7htClrVrRBMdvRZV/8W+8pGwGtjKxRhOsVUZ86Lnzj8Lw6EHA35z2OowFF8LmUsrdyhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590274; c=relaxed/simple;
	bh=M6jdo7H/dDlfmeEEXkFt6CbaOEJImMtHK4dTIRTZLF0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R5K5BkoVsBY/wEGnWZjwgHXk1krEG7U7Aif8rA2ewmpsJcfLn1lJqqSVjjtIfkkrnG8w9/WNSDlfH6xxJMv9qnIQTZhpm3XKl/az2j7JkbQVZ8kMuqUYlM41C+ZFuoKlWLK1sSFmnuTYKoXgaoL1YOetEIgZwGTccOeP08rBKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kq0pIQv9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IKJOo4016893;
	Tue, 19 Aug 2025 07:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lkLhLr
	/fJDzFBos0ozmWujsjFAp3g6noJWKQ4OpXxSI=; b=Kq0pIQv94uxnDw/EVbFwpN
	A3j+9lPv3YZCA5NB9xANZXopiG55w4fnsNBMqrO42MWqBv6zdlOhQSB6D1m3QXLd
	j5+p2AcjRfxxOP62Lz6ulrxNhm4Lwv9cN2nGWY2xuVnI9Q4Mrhgo5JrMwjv5GOJ3
	j5nuYhUS5poK8ybU1frD+J0t49DIFBAj3NBmBVDrOercvoRHqBRCOSqZgwwGHrl6
	n8bFwppUifzrC9+Pk0/BYeDfN86VdeyO1XkCmidQBk7ENsK2wqNtnzSpR27imo2M
	zKDB/HVdvQniQrAD6pvsvvV/N2gD3Lg8BaHw2eex3pBSreRK3kxqlUW+ZIf7+9pw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48k60g2f5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:57:35 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57J7V2ad005076;
	Tue, 19 Aug 2025 07:57:34 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48k60g2f5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:57:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57J6WVmF002381;
	Tue, 19 Aug 2025 07:57:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k71311a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:57:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57J7vVNY51970316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 07:57:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA9AB20043;
	Tue, 19 Aug 2025 07:57:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E141420040;
	Tue, 19 Aug 2025 07:57:21 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.150.8.232])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Aug 2025 07:57:21 +0000 (GMT)
Message-ID: <588d7bc1af412052da01ada1e316dc3452e35435.camel@linux.ibm.com>
Subject: Re: [PATCH v4 4/7] mm/selftests: Fix split_huge_page_test failure
 on systems with 64KB page size
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
        pfalcato@suse.de, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, baohua@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        donettom@linux.ibm.com, ritesh.list@gmail.com
Date: Tue, 19 Aug 2025 13:27:19 +0530
In-Reply-To: <20250816143129.u2rdwpwvfhsdptvx@master>
References: <20250816040113.760010-1-aboorvad@linux.ibm.com>
	 <20250816040113.760010-5-aboorvad@linux.ibm.com>
	 <20250816143129.u2rdwpwvfhsdptvx@master>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Xxo-rqbc7cebc1fPmjZ5ElzwCajbrHcg
X-Authority-Analysis: v=2.4 cv=coObk04i c=1 sm=1 tr=0 ts=68a42e6f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=7CQSdrXTAAAA:8 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8 a=tHhU2u7-ekzRu8kCQfcA:9
 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: oTFYm-c-N6_cjxhC8XgowrRG4DRYlYYk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDAxNiBTYWx0ZWRfX67xGcB4BeSH8
 ulN8vqwFzYGzs6y1LNSMP/C7lfl3OLCfi//7f+YmKUot8z40fD4S8avAa0B8vmyJMIH8R0nDm2/
 6qG7Vx5lr9bEfoK1Iz9UyiAyGDIlKhFyaOyuUTTbq2zpE5YjvEflIW4VHK6gMYpiXVTcgTZKqtu
 LomJoBCnKMG1rPYDMaNG6hAAYbedGJ9WK2tfVkFdS3ID4tSaIOmWQtU8VAplxV8EpktvNBqTxgY
 4Z72ecj+PFZi4ZTJr7m5wly0c724RS2PMlpthVoUYyzKP06tywNEVG+mb5nmfVydNFy1XOWi0Nv
 PmeI2wnnut/LuotJYkau1yVhnUHAJGLlAVCqne+HOBtcmKfcmAas2dmuJI19jjm7dyVCETmrCVO
 dmEP5L6N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508170016

On Sat, 2025-08-16 at 14:31 +0000, Wei Yang wrote:
> On Sat, Aug 16, 2025 at 09:31:10AM +0530, Aboorva Devarajan wrote:
> > From: Donet Tom <donettom@linux.ibm.com>
> >=20
> > The split_huge_page_test fails on systems with a 64KB base page
> > size.
> > This is because the order of a 2MB huge page is different:
> >=20
> > On 64KB systems, the order is 5.
> >=20
> > On 4KB systems, it's 9.
> >=20
> > The test currently assumes a maximum huge page order of 9, which is
> > only
> > valid for 4KB base page systems. On systems with 64KB pages,
> > attempting
> > to split huge pages beyond their actual order (5) causes the test
> > to fail.
> >=20
> > In this patch, we calculate the huge page order based on the
> > system's base
> > page size. With this change, the tests now run successfully on both
> > 64KB
> > and 4KB page size systems.
> >=20
> > Fixes: fa6c02315f745 ("mm: huge_memory: a new debugfs interface for
> > splitting THP tests")
> > Co-developed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > Reviewed-by: Dev Jain <dev.jain@arm.com>
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>=20
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
>=20
> Nit below:
>=20
> > ---
> > tools/testing/selftests/mm/cow.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 -----
> > .../selftests/mm/split_huge_page_test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 22 ++++++++++++----
> > ---
> > tools/testing/selftests/mm/uffd-wp-mremap.c=C2=A0=C2=A0 |=C2=A0 5 -----
> > tools/testing/selftests/mm/vm_util.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++++
> > 4 files changed, 19 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/mm/cow.c
> > b/tools/testing/selftests/mm/cow.c
> > index 90ee5779662f..e742d9313798 100644
> > --- a/tools/testing/selftests/mm/cow.c
> > +++ b/tools/testing/selftests/mm/cow.c
> > @@ -41,11 +41,6 @@ static size_t hugetlbsizes[10];
> > static int gup_fd;
> > static bool has_huge_zeropage;
> >=20
> > -static int sz2ord(size_t size)
> > -{
> > -	return __builtin_ctzll(size / pagesize);
> > -}
> > -
> > static int detect_thp_sizes(size_t sizes[], int max)
> > {
> > 	int count =3D 0;
> > diff --git a/tools/testing/selftests/mm/split_huge_page_test.c
> > b/tools/testing/selftests/mm/split_huge_page_test.c
> > index eadbeb820d71..7cbeaebc9d71 100644
> > --- a/tools/testing/selftests/mm/split_huge_page_test.c
> > +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> > @@ -523,6 +523,9 @@ int main(int argc, char **argv)
> > 	const char *fs_loc;
> > 	bool created_tmp;
> > 	int offset;
> > +	unsigned int max_order;
> > +	unsigned int nr_pages;
> > +	unsigned int tests;
> >=20
> > 	ksft_print_header();
> >=20
> > @@ -534,35 +537,38 @@ int main(int argc, char **argv)
> > 	if (argc > 1)
> > 		optional_xfs_path =3D argv[1];
> >=20
> > -	ksft_set_plan(1+8+1+9+9+8*4+2);
> > -
> > 	pagesize =3D getpagesize();
> > 	pageshift =3D ffs(pagesize) - 1;
> > 	pmd_pagesize =3D read_pmd_pagesize();
> > 	if (!pmd_pagesize)
> > 		ksft_exit_fail_msg("Reading PMD pagesize
> > failed\n");
> >=20
> > +	nr_pages =3D pmd_pagesize / pagesize;
> > +	max_order =3D=C2=A0 sz2ord(pmd_pagesize);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> 		=C2=A0=C2=A0=C2=A0 extra space here

Hi Wei,

Thanks for the review. I=E2=80=99ve sent a fixup patch for this:
https://lore.kernel.org/all/20250819041239.167537-1-aboorvad@linux.ibm.com/

Andrew,=C2=A0

Could you please apply the above fixup patch?

Regards,
Aboorva

>=20
> > +	tests =3D 2 + (max_order - 1) + (2 * max_order) + (max_order
> > - 1) * 4 + 2;
> > +	ksft_set_plan(tests);
> > +
> > 	fd_size =3D 2 * pmd_pagesize;
> >=20
> > 	split_pmd_zero_pages();
> >=20

