Return-Path: <linux-kselftest+bounces-18039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 602BA97A02A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 13:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E1EB211F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 11:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0727714F126;
	Mon, 16 Sep 2024 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qu+6GbXT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDEA1311A7;
	Mon, 16 Sep 2024 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726485668; cv=none; b=IenmHuJK6ewcwXRUD4Yx3z6GiOhttLE13QL/ANe8QVXaU5kALuGdrXo/nJzBlyGYnGdzOVqBOAwBbIbGY6rr2dEFFJIP1Out3PscwWHRWu92zuaovIpbpLjAYC2oVgDUsoNd2VT0vFJuKbrbnSy/95R+bJLBx9MZmLk3ympQEsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726485668; c=relaxed/simple;
	bh=Qfmpgo2OP0NmxW45pVmijbQKDnnSjIMv86KmHnzKUJk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=LjS2SpOmySRlGr1i3CsSqhQ+CKiQYUXSmjwqJPE4SA/t6yLf5KkRNgEe4myzMKO1o31Dyg1AnQO5N/80Ws+4Zsl/TXQgpKleBtz7HVP62KZubs6aqujDPj1tawO1pUcxN3RPojjSx2mG56c1Y8ipdDR/rbliHO2+rZXvs6S/j50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qu+6GbXT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48FKjgpi004013;
	Mon, 16 Sep 2024 11:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:from:cc:to:subject:references:in-reply-to; s=pp1;
	 bh=gByI+UdvfMcDTFNLynSpYsVsSCvyQm6PGnUAWipZCbY=; b=Qu+6GbXT2w+n
	0bNyLei6Bzz2dLq4Q7bRTfFeVm3d/54rM0E8MUmpJMJEeRIOc0X3aSgZfropNPMv
	cu3nVK9dZkXvitdAX3/Bf9Il25j2dh/ZnsDCX2igv1zth+R9WHURleAecQ7TAzej
	xt3Zk57FJTNuXkREm+sXUETvKEMGUu5COLTzj24aQsCCUCFwMpo/507rBBNqcrN1
	lrc6C3UtE79hDxe8ir7xHwYVMcbBUVTG57XIXsByIhSiq4lSlPXDs4VBpXM3jLYJ
	RB4OgD9Q7xhAOcncl2f0/tST3CWmsx5TZKr6JCOWMtoV+nkQRiNyFsfPxJu8+dnA
	4E6+Fus6zA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vnh8nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 11:20:59 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48GBKxMd004181;
	Mon, 16 Sep 2024 11:20:59 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vnh8nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 11:20:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48G99TFd030656;
	Mon, 16 Sep 2024 11:20:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41npamxvvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 11:20:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48GBKs2B35324424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 11:20:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 595872004D;
	Mon, 16 Sep 2024 11:20:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23C722004F;
	Mon, 16 Sep 2024 11:20:54 +0000 (GMT)
Received: from darkmoore (unknown [9.171.19.143])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Sep 2024 11:20:54 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Sep 2024 13:20:48 +0200
Message-Id: <D47O31ORSDVL.ALV1HGEPI2T4@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>, "Shuah Khan" <shuah@kernel.org>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Nina
 Schoetterl-Glausch" <nsg@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] selftests: kvm: s390: Add uc_map_unmap VM test
 case
X-Mailer: aerc 0.18.2
References: <20240913115248.211071-1-schlameuss@linux.ibm.com>
 <20240913115248.211071-2-schlameuss@linux.ibm.com>
 <20240913184802.3365e253@p-imbrenda>
 <D47HSOYSEVRV.2VQTKG7RCRAV6@linux.ibm.com>
 <21198da0-def7-40d4-9be6-8d9b8465e65c@linux.ibm.com>
In-Reply-To: <21198da0-def7-40d4-9be6-8d9b8465e65c@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zI1PC7gY-1nobaUVORNYj8t3jMu9M4lG
X-Proofpoint-GUID: mufETLik89xjCYYNpw7yH779_jS_71Md
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_07,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=878
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409160069

On Mon Sep 16, 2024 at 8:33 AM CEST, Janosch Frank wrote:
> On 9/16/24 8:25 AM, Christoph Schlameuss wrote:
> > On Fri Sep 13, 2024 at 6:48 PM CEST, Claudio Imbrenda wrote:
> >> On Fri, 13 Sep 2024 13:52:46 +0200
> >> Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:
> >>
> >>> Add a test case verifying basic running and interaction of ucontrol V=
Ms.
> >>> Fill the segment and page tables for allocated memory and map memory =
on
> >>> first access.
> >>>
> >>> * uc_map_unmap
> >>>    Store and load data to mapped and unmapped memory and use pic segm=
ent
> >>>    translation handling to map memory on access.
> >>>
> >>> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> >>> ---
> >>>   .../selftests/kvm/s390x/ucontrol_test.c       | 145 +++++++++++++++=
++-
> >>>   1 file changed, 144 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tool=
s/testing/selftests/kvm/s390x/ucontrol_test.c
> >>> index 030c59010fe1..084cea02c2fa 100644
> >>> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> >>> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> >>
> >> [...]
> >>
> >>> base_gpa + self->code_gpa;
> >>> @@ -222,6 +244,60 @@ TEST(uc_cap_hpage)
> >>>   	close(kvm_fd);
> >>>   }
> >>>  =20
> >>> +/* calculate host virtual addr from guest physical addr */
> >>> +static void *gpa2hva(FIXTURE_DATA(uc_kvm) * self, u64 gpa)
> >>
> >> why the space? I would have expected *self
> >>
> >=20
> > That is how checkpatch.pl --strict prefers it.
> >=20
> > Output from checkpatch without the space:
> >=20
> > CHECK: spaces preferred around that '*' (ctx:WxV)
> > #19: FILE: tools/testing/selftests/kvm/s390x/ucontrol_test.c:278:
> > +static void *gpa2hva(FIXTURE_DATA(uc_kvm) *self, u64 gpa)
>
> I'd guess checkpatch thinks this is a multiplication and that's why it=20
> complains here. It's checking against the wrong rule.

I see. I did experiment a bit. There is no obvious way to get rid of the CH=
ECK
notices from checkpatch.pl. But I will correct the whitespaces for the func=
tion
calls.

