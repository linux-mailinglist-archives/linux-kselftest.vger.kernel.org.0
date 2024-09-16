Return-Path: <linux-kselftest+bounces-18016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9997979B1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 08:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E659B22CC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 06:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2065B3B298;
	Mon, 16 Sep 2024 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MKQYjCSA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD82A1B2;
	Mon, 16 Sep 2024 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726467930; cv=none; b=t0f8kpaSjyNiZ/cJ+WbWDeTFtxa+H8SB2C2uVAMOjQBDS/TSBkZBqZEv5d+7tLTtuh/7QmQtmUMe/JPMxWuysjc/QOq5PDXMP2XxoB9Pba2ckysCbE9Ie91UK4yrWq9SW82cIHO3PSMWjzq5DVV4Wwr4O5JPAReJrRR1P/y8dB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726467930; c=relaxed/simple;
	bh=YTZjex9Qnkcyzmzrh8Ejka9ejOBEL/+lauPKDU8+Meo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=sCjASyH7/VHDd6kPs015oZhZ9OPkFd81dV91GZbW1yetcW+VN/qfVsw1MVD+zNZDLveW305JBRV2tsISKxjz2Ck0u0RTIfmtDd9eSidT40jEMVy4cH7j0jcLmd72y9UZPvB3yON2iafY6h6fggr1AxF/URraAHdj3eAKW3Pw9p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MKQYjCSA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48FKw65k008611;
	Mon, 16 Sep 2024 06:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:cc:to:subject:from:references:in-reply-to; s=pp1;
	 bh=1lhaETP3eSv6kgJaVmJjY+/leCWRQv0KEgpQ5KTz4ro=; b=MKQYjCSAQ2p0
	K8Yfb9dIdxf969C+PZxINI4k9kqR6taBlvUwYzUkLw0q6Qhov8iel/J/h7vb51XD
	tm0CFYWw03sJzAiEJk8zm+3l/iEbgOqOGiwR8ps5jCc0/ALAhg9gv9ygbMz3SsAW
	WicV72dFL9u1gH+IQ9UcKpQlaGiDXqn18PawBMFMkD6vVqJHpq2tjkbWmkTbmF5W
	5jr7eM4f9g4ng8TagkvOMlOqXCY1Sriaw52ELx7nVvNPjs89myFPYNCp1RWhyc9I
	nSY07nxDD6o3TFe2gsYq6y9G9KmV9VCzw2rIWUhZX36sWmwQnbTx+/hzCGc+EmlX
	ZwrKLE8wLQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vd81pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 06:25:22 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48G6O9FF023258;
	Mon, 16 Sep 2024 06:25:21 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vd81p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 06:25:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48G6MiDY024627;
	Mon, 16 Sep 2024 06:25:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nq1mn9h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 06:25:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48G6PG5326608358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 06:25:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F7ED2004D;
	Mon, 16 Sep 2024 06:25:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1551E20049;
	Mon, 16 Sep 2024 06:25:16 +0000 (GMT)
Received: from darkmoore (unknown [9.171.19.143])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Sep 2024 06:25:16 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Sep 2024 08:25:10 +0200
Message-Id: <D47HSOYSEVRV.2VQTKG7RCRAV6@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>, "Shuah Khan" <shuah@kernel.org>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>,
        "Janosch Frank" <frankja@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Nina Schoetterl-Glausch"
 <nsg@linux.ibm.com>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] selftests: kvm: s390: Add uc_map_unmap VM test
 case
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.18.2
References: <20240913115248.211071-1-schlameuss@linux.ibm.com>
 <20240913115248.211071-2-schlameuss@linux.ibm.com>
 <20240913184802.3365e253@p-imbrenda>
In-Reply-To: <20240913184802.3365e253@p-imbrenda>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rVfsPCijQkAO2cAW7xOhKjFtfl7coot2
X-Proofpoint-GUID: CaIZ3Ezy-sOZu_F4_A74UdLICNjVYEtX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_03,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=796 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160039

On Fri Sep 13, 2024 at 6:48 PM CEST, Claudio Imbrenda wrote:
> On Fri, 13 Sep 2024 13:52:46 +0200
> Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:
>
> > Add a test case verifying basic running and interaction of ucontrol VMs=
.
> > Fill the segment and page tables for allocated memory and map memory on
> > first access.
> >=20
> > * uc_map_unmap
> >   Store and load data to mapped and unmapped memory and use pic segment
> >   translation handling to map memory on access.
> >=20
> > Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> > ---
> >  .../selftests/kvm/s390x/ucontrol_test.c       | 145 +++++++++++++++++-
> >  1 file changed, 144 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/=
testing/selftests/kvm/s390x/ucontrol_test.c
> > index 030c59010fe1..084cea02c2fa 100644
> > --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> > +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
>
> [...]
>
> >base_gpa + self->code_gpa;
> > @@ -222,6 +244,60 @@ TEST(uc_cap_hpage)
> >  	close(kvm_fd);
> >  }
> > =20
> > +/* calculate host virtual addr from guest physical addr */
> > +static void *gpa2hva(FIXTURE_DATA(uc_kvm) * self, u64 gpa)
>
> why the space? I would have expected *self
>

That is how checkpatch.pl --strict prefers it.

Output from checkpatch without the space:

CHECK: spaces preferred around that '*' (ctx:WxV)
#19: FILE: tools/testing/selftests/kvm/s390x/ucontrol_test.c:278:
+static void *gpa2hva(FIXTURE_DATA(uc_kvm) *self, u64 gpa)
                                           ^

> > +{
> > +	return (void *)(self->base_hva - self->base_gpa + gpa);
> > +}
> > +
> > +/* map / make additional memory available */
>
> [...]


