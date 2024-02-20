Return-Path: <linux-kselftest+bounces-5039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9844885C04E
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 16:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D591C22280
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924E3762DC;
	Tue, 20 Feb 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DHZ1HoQ9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5F76059;
	Tue, 20 Feb 2024 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444098; cv=none; b=ZkyMcUme2WlGTcgCJprP7p1sfcPKvkgXj2tGVJ4pXHRsiPTsbt5W56fXKU9hg+5I3+r6JGspfwa67l7LHYBLKhwJqKpHX3EDHLoZvwKjp0ydo0j0P6TbUtNvv8CYKliiwe3k1vMFL4RCOgJDt2gnkY7E+Uo0nbbfjr05+3K0edA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444098; c=relaxed/simple;
	bh=HP4NP4eq0ZPuLynmaASBI2C6x3KxBUppr5si9FrlRqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tqqR+3I2mrq32vB5OvnHWAOs8XhjW+gT1388MEvE0Pw46ATqGyhHTcJRH2z02fkgc1o9CAzffeREG7ZmFcYk+CVbg/XNhtMIW5JrpYrqjyUSsOGv8OoiIwS9fE28+sSb+0ZM7pawB2fTtanUjWOuqYTjKI2opi5le09BPlXAOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DHZ1HoQ9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KFNbff010219;
	Tue, 20 Feb 2024 15:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=HP4NP4eq0ZPuLynmaASBI2C6x3KxBUppr5si9FrlRqc=;
 b=DHZ1HoQ94mgi1Zg4E/UUxmtr7lXyuNC4uxgyBUVnV16BPGYL2KO3glK//qK2gpw/Hwkt
 kiyTlFr4Xjf49jHiEYsUxAp0VPSnvQyUSxzVbB3fNsMMzMZAsMpUV7S+hOo1/yQqk3dY
 3re2SLRoYmTKC+DhQwvVx0Qcp6vStV9p5h3iH+XVgGn1X9JrqI639BiA4A4hgPZ2Y2Op
 pafBZ4F36ePKUwpEFfZd84j1nVpETbtjLiaj6KPo5aArhuZTZvVlKSD9cfB4jvQnr7dS
 js0/U/Cv49Q07vk7A2E5q5pwrz61hLoCzyM+7sSEBcYYLOJiXOamUCfa7mgsP010wucB 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcw6suvde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 15:48:14 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41KDiI8j014800;
	Tue, 20 Feb 2024 15:48:14 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcw6suvch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 15:48:13 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41KDIW6R003611;
	Tue, 20 Feb 2024 15:48:13 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74thc42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 15:48:13 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41KFm9v933685780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 15:48:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EC8758067;
	Tue, 20 Feb 2024 15:48:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37EBD58072;
	Tue, 20 Feb 2024 15:48:08 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.63.241])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Feb 2024 15:48:08 +0000 (GMT)
Message-ID: <d441ff9b178cceb22cf4f4422a15a0f3cdd61bfa.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] KVM: s390: fix access register usage in ioctls
From: Eric Farman <farman@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger
	 <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand
	 <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
 <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Date: Tue, 20 Feb 2024 10:48:07 -0500
In-Reply-To: <c64a7f44-2407-472d-8197-995b38ae2214@linux.ibm.com>
References: <20240216213616.3819805-1-farman@linux.ibm.com>
	 <20240216213616.3819805-2-farman@linux.ibm.com>
	 <1d9fef3d-b793-43fc-a3f9-4ff087bc899f@linux.ibm.com>
	 <c64a7f44-2407-472d-8197-995b38ae2214@linux.ibm.com>
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
X-Proofpoint-GUID: DK4GoXQD3U3LLr0YRVAkEdTf1GGm6zRf
X-Proofpoint-ORIG-GUID: z0hJ-MnAOKi0BFYXuK0Dj26OCBHceL1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=829 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200113

On Tue, 2024-02-20 at 15:19 +0100, Janosch Frank wrote:
> On 2/20/24 15:15, Christian Borntraeger wrote:
> >=20
> >=20
> > Am 16.02.24 um 22:36 schrieb Eric Farman:
> > > The routine ar_translation() can be reached by both the
> > > instruction
> > > intercept path (where the access registers had been loaded with
> > > the
> > > guest register contents), and the MEM_OP ioctls (which hadn't).
> > > Since this routine saves the current registers to vcpu->run,
> > > this routine erroneously saves host registers into the guest
> > > space.
> > >=20
> > > Introduce a boolean in the kvm_vcpu_arch struct to indicate
> > > whether
> > > the registers contain guest contents. If they do (the instruction
> > > intercept path), the save can be performed and the AR translation
> > > is done just as it is today. If they don't (the MEM_OP path), the
> > > AR can be read from vcpu->run without stashing the current
> > > contents.
> > >=20
> > > Signed-off-by: Eric Farman <farman@linux.ibm.com>
> >=20
>=20
> Just spoke with Christian since that's a mixed signal.
>=20
> To move this over the s390 tree:
> > Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>=20
> For the Patch in general:
> > Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>=20

Shall I send a v4 with the tags, and comments Nina suggested, then?

