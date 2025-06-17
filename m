Return-Path: <linux-kselftest+bounces-35184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F21ADC3C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 09:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F9A172C07
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 07:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2EB28ECC9;
	Tue, 17 Jun 2025 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Anue3cqS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E4228C5CB;
	Tue, 17 Jun 2025 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750146859; cv=none; b=GbUHsRVhuJydbhW7MmWPquVe9LLhZZQbiwxNQnCaHNqze5yC0Er6GIwOBjbe18WHfWV1JjaTUdspoP9baBvEzDNIqaEfIHqK/d1Glxex1ZO+9u7wq7wf31B+3OfeRBxApJwzs1CEU65swbXHseikB5CIrEf2cRgLhEpdJz8Ct2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750146859; c=relaxed/simple;
	bh=2RMpQ8Uoy9Dh8UdmqqLhHRn/tNTO1TKmZc6YaOlT4yk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aazo5j0o57xmae+ErHDculmTd2B00iHMhIowqODIXzQ9I7uuDYXCCQXtSnJEhAZnhmexVF8giUI7LSCeP2hS/ucdcspB+225ON7IRmyJ/HC9ptCTUK4N6fAuk/ofCYqc1Y1rKdi/H6Kw3JsLkXQwqn+NbKjWwdmCIlu7/rZtBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Anue3cqS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H6qbig000480;
	Tue, 17 Jun 2025 07:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2RMpQ8
	Uoy9Dh8UdmqqLhHRn/tNTO1TKmZc6YaOlT4yk=; b=Anue3cqSxaHums6tzNB/9/
	1yxBX6R2wrEWTfWyAg1Yl66NKv+y3R2z8y7gmT6oOu1xt28+n2OjixlNjL5gNxny
	lqN52dia+0F7/595k3fIRdsVaRuGb2y+R95o1xfGBXMOYKno/PSGVa/1uws4xsf+
	toF6Qtq8GCjoWXvc2kAq4n67x4CX5ztb9S9hM6NSYkOCWFa+OAApvDwbctDYVPl2
	4P0dxapamDdL0544RRgcupQMegzuihtYunRCDCRdCX7cZwirm/CZnP7wBlV8fVna
	Lx1iFemmQ/X4qGyPpoH2VoIQ3ZwVhsAsBqVOmhWQ2MSdJGprR4BI1GhyVlvNRyJA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qp5r9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 07:53:54 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55H7rr3n007078;
	Tue, 17 Jun 2025 07:53:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qp5r9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 07:53:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55H5aEUT025755;
	Tue, 17 Jun 2025 07:53:52 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 479xy5revq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 07:53:52 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55H7rq3p23134482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 07:53:52 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B9C958064;
	Tue, 17 Jun 2025 07:53:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8E045805C;
	Tue, 17 Jun 2025 07:53:46 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com (unknown [9.109.215.55])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Jun 2025 07:53:46 +0000 (GMT)
Message-ID: <4f2761c83dbdb55e5fd7ee27d4a6f0c5e04b471d.camel@linux.ibm.com>
Subject: Re: [PATCH 0/6] selftests/mm: Fix false positives and skip
 unsupported tests
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, shuah@kernel.org,
        pfalcato@suse.de, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, baohua@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        donettom@linux.ibm.com, ritesh.list@gmail.com
Date: Tue, 17 Jun 2025 13:23:45 +0530
In-Reply-To: <55d74681-c5f0-48f0-848a-a062f37682de@lucifer.local>
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
	 <55d74681-c5f0-48f0-848a-a062f37682de@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E4CIeTr-_R6QFsLug-NHxHMvdWjbU2-8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA2MSBTYWx0ZWRfX6TK8QhMVhOXi rC69KHFu+IXO/Ssf3VFobj13TL5bL4Ox0DiD7UQ7/Ur+DNRRForzG9HpHbrmLapj+FuApDy7zNJ rZlVbWkSBintqjuqqJw6g+uTDAOL+O+hzjJIh3Cv9nmbpCEGIU3GFaQC6lMWpgfwj9JO5770fT3
 Sj0IthAofmTvveXGTbcS3FZbh5wH4TdNnXcsoL8HMO9WxrGBWy/QEF6qfOrph3Ua8NVfiGdy5TR 0OXgi8mWRf88kweMs2p1DEZWdrvCQ55D1y+/WeZxJD7fWMKCbrPbHIOFbiYNNmrVYM0HIY6Rmw1 xEtL/y2Quy8lD4cjdUQd+5ua7ndv7/VOEaWM82ViVoF4EoKh80Uwk1NRpJ4F9XyUdpzCPzi5BL9
 d0tB4VSo2tYSufXvcSlpWmp+zC/nHAtEdhyQ8/2p90eNGCZc2Sb5YXWlSyH9SsLsc5Stx4Jk
X-Authority-Analysis: v=2.4 cv=NYfm13D4 c=1 sm=1 tr=0 ts=68511f12 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=9gNBrQwhxQlxq7T7SgMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: l9aV_m1mxjpVbant-QXI_rUVjVUsnaAe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170061

On Mon, 2025-06-16 at 17:11 +0100, Lorenzo Stoakes wrote:
> Hi Aboorva,
>=20
> It's (highly!) forgivable as things have changed fairly recently, but the
> tippy tip of mm development is now done in the mm-new branch, against whi=
ch
> this series doesn't apply.
>=20
> I thought this might be the case, as there is a series I implemented ther=
e
> that changes the split huge page tests (possibly affecting more), hence m=
e
> checking!
>=20
> So you'll need to rebase against mm-new, unfortunately!
>=20
> Thanks, Lorenzo

Hi Lorenzo,

Thanks for pointing this out.

We'll rebase the patches against mm-new and repost them as v2.

Regards,
Aboorva
>=20
> On Mon, Jun 16, 2025 at 09:36:26PM +0530, Aboorva Devarajan wrote:
> > This patch series fixes some of the false positives in generic
> > mm selftests and skips tests that cannot run correctly due to
> > missing features or system limitations.
> >=20
> > Please let us know if you have any feedback.
> >=20
> > Thanks,
> > Aboorva
> >=20
> > Aboorva Devarajan (2):
> > =C2=A0 selftests/mm: Fix child process exit codes in KSM tests
> > =C2=A0 selftests/mm: Mark thuge-gen as skipped if shmmax is too small o=
r no
> > =C2=A0=C2=A0=C2=A0 1G pages
> >=20
> > Donet Tom (4):
> > =C2=A0 mm/selftests: Fix virtual_address_range test issues.
> > =C2=A0 selftest/mm: Fix ksm_funtional_test failures
> > =C2=A0 selftests/mm : fix test_prctl_fork_exec failure
> > =C2=A0 mm/selftests: Fix split_huge_page_test failure on systems with 6=
4KB
> > =C2=A0=C2=A0=C2=A0 page size
> >=20
> > =C2=A0.../selftests/mm/ksm_functional_tests.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 24 +++++++++++++------
> > =C2=A0.../selftests/mm/split_huge_page_test.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 23 ++++++++++++++----
> > =C2=A0tools/testing/selftests/mm/thuge-gen.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 11 +++++----
> > =C2=A0.../selftests/mm/virtual_address_range.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 14 +++--------
> > =C2=A04 files changed, 45 insertions(+), 27 deletions(-)
> >=20
> > --
> > 2.43.5
> >=20

