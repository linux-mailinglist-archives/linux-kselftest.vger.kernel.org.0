Return-Path: <linux-kselftest+bounces-39290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B81DB2BAEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 09:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AF5189A2B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 07:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D39630FF3C;
	Tue, 19 Aug 2025 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QkI5CVka"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B3B310621;
	Tue, 19 Aug 2025 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589191; cv=none; b=piyrJmTidMwOXP/5bpfBhhPs8KXVGMJjcyyzKhoDYC2HUGsDfumgfHqp6eJcvH3/H2gg7Fto0/28kDD2gbATWvk4gP/xaDwusIHmNpS1IVxyJPVh4hZRJh0Q+P3lzmZv0uWQP8uFW3RNTlkvlyDYlbT4Ms3WS7jCfMUal4MA9tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589191; c=relaxed/simple;
	bh=gJZ4+unPtHp45j2uU3LHJmSOTMwXJ0V/cp0y+r6Oq14=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GvFP1Q8Zzegq+5aZE/ilgygGXIrWoR4GvdHyfQrLW5IL1nQZU6xICyyeFWFSvTZu9onVFyvbOLrkVfYByl8NfjJ6g97ynvu3Wmmzpg+9+hXSkBcvWvti/03WnRgfgBUbTqL01J7P1CodfnvFYY2tzhgKER9Ok2TpOUUKqzMeEWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QkI5CVka; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J5D69Y012840;
	Tue, 19 Aug 2025 07:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2fMT89
	F0BR3wH3h7MhslCxoheegXP+7FD4CxweXIXOI=; b=QkI5CVkawkaIOpfz9UseLj
	uKF8kQqQqrK7w3N9SfZWaTUd5jzsZhG59yVSKUEMMfNLiNMops4pUUsfTCgY1dd2
	xSprP7vP1GCZJmMcdWHNoB57M/GyNnTUbVErN06+U1yAySTtECc5abs7PqMT/3be
	i8tbQ3MROhcly+ygLlyHzLjI3F/4Ww0rIkETBjZQs1KpkBekvb49JvEtvfTmaKBl
	8bF7rXbKmLViCgcHrs8ApD9+hlh8lstCeRKIgfykUn+FuNZAcL/VRdYXeTfJh5Lr
	RniNOMdrRegLaq4uskvz2aBzQ+C/C0FzFNQdxQ/hPyL49tM8RMFyeJAbsOWryfpA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhn3w48c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:39:35 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57J7dZtZ015939;
	Tue, 19 Aug 2025 07:39:35 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhn3w488-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:39:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57J6Vx4j002213;
	Tue, 19 Aug 2025 07:39:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k7130yx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 07:39:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57J7dWZD30540240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 07:39:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C0E020043;
	Tue, 19 Aug 2025 07:39:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89B1620040;
	Tue, 19 Aug 2025 07:39:22 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.150.10.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Aug 2025 07:39:22 +0000 (GMT)
Message-ID: <23fe7e2a5343090f387c15d70b95b13029f523e0.camel@linux.ibm.com>
Subject: Re: [Fixup PATCH] mm/selftests: Fix formattig in
 split_huge_page_test
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
        pfalcato@suse.de, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, richard.weiyang@gmail.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        donettom@linux.ibm.com, ritesh.list@gmail.com
Date: Tue, 19 Aug 2025 13:09:20 +0530
In-Reply-To: <38734ae6-012d-4630-8bf3-efefb65f0d23@redhat.com>
References: <20250816040113.760010-5-aboorvad@linux.ibm.com>
	 <20250819041239.167537-1-aboorvad@linux.ibm.com>
	 <8142d36d-2a0e-476c-8250-1a69c1f92913@redhat.com>
	 <38734ae6-012d-4630-8bf3-efefb65f0d23@redhat.com>
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
X-Proofpoint-ORIG-GUID: kldq267UTVqJ9C8Sml23beZipPKunToR
X-Authority-Analysis: v=2.4 cv=L6wdQ/T8 c=1 sm=1 tr=0 ts=68a42a37 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=Usu2G-oJ_OItclc4WmIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: azXWxStmn-7-WbVHLx7lZgRm3YkxeGHa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfXxboAV/ekxxSU
 TyKCUHpeqzG8mRxw4KAj8bza9YhUDdi6AjptGmFrS3BvCvk+l0D4THv3A0hoxc4jfJyr+mRDfw3
 fO4MKWsM6YBYhWXNBlciRIz3jipyGhciwO7aqWu30i6Od1QwdTZa46BlJQ1mwBRKxybO+Q7gS9K
 Ifu+Jgdae4+OR4IH+Te7snGp/ULKKgq2a0X3rd0jele9PVofbv6tcyiwYC2zgtIzhNG2KII6Q0T
 UBTwubX6Q0YLhAqjYr9NE7Xh/4YEa+omCNO/5vMZmi/jilN8BwS47q6MFw4pKwrFKMgipIA1YL0
 9XzvCmKBYgYnSDsFRv031z7kl7sztTrTWC+W7F3hJ/DpYqaxlAbPN5qVawyD9mCUYDdbYCTBvv2
 +d02dbNk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027

On Tue, 2025-08-19 at 09:28 +0200, David Hildenbrand wrote:
> On 19.08.25 09:25, David Hildenbrand wrote:
> > On 19.08.25 06:12, Aboorva Devarajan wrote:
> > > Removed an extra space in split_huge_page_test that was introduced
> > > by commit 4b76e221794b ("mm/selftests: fix split_huge_page_test
> > > failure on systems with 64KB page size").
> > >=20
> > > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > > ---
> > > =C2=A0=C2=A0 tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
> > > =C2=A0=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tool=
s/testing/selftests/mm/split_huge_page_test.c
> > > index 54e86f00aabc..faf7e1f88743 100644
> > > --- a/tools/testing/selftests/mm/split_huge_page_test.c
> > > +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> > > @@ -544,7 +544,7 @@ int main(int argc, char **argv)
> > > =C2=A0=C2=A0=C2=A0		ksft_exit_fail_msg("Reading PMD pagesize failed\n=
");
> > > =C2=A0=C2=A0=20
> > > =C2=A0=C2=A0=C2=A0	nr_pages =3D pmd_pagesize / pagesize;
> > > -	max_order =3D=C2=A0 sz2ord(pmd_pagesize, pagesize);
> > > +	max_order =3D sz2ord(pmd_pagesize, pagesize);
> > > =C2=A0=C2=A0=C2=A0	tests =3D 2 + (max_order - 1) + (2 * max_order) + =
(max_order - 1) * 4 + 2;
> > > =C2=A0=C2=A0=C2=A0	ksft_set_plan(tests);
> > > =C2=A0=C2=A0=20
> >=20
> > Please just comment next time one the respective patch as review commen=
t.
> >=20
>=20
> To clarify what I mean is something like this:
>=20
> https://lkml.kernel.org/r/3dca2de4-9a6a-4efe-a86c-83f9509831fc@gmail.com
>=20
> Gives more context when the subject directly highlights to which patch=
=20
> you are replying.

Hi David,

Thanks for pointing this out. I=E2=80=99ll make sure to follow this.

Regards,
Aboorva

