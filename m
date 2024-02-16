Return-Path: <linux-kselftest+bounces-4878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EDE8587DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 22:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F6C1C20E74
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 21:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52535145341;
	Fri, 16 Feb 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nb0U0lpA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6712BEA5;
	Fri, 16 Feb 2024 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118342; cv=none; b=kPuuaWN1H5winP05j4s6SfMSJTObcXcGm/VErI7PxWd7PHXTZ5pq8VoTbIO2+FQgVlFNLpyq7CNo+PBSBiTrNZWmI/1bCT3WP4LjybPGNwPTMSnUoiEggD0AYHjyUlHAOHx9fjqKplIi0To1nhEYFS5PnODoe9B9PW9nDBlTdJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118342; c=relaxed/simple;
	bh=n3BVK7XlP+3YIiQ+7K8fhYDCbI9fpKf68CAdJoDXIEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pUIygdCSw1RiE18TMvM6J1/km4A+FHNQK1Xl1BpUCLm/55m9gZPbi3JcN1Vdse3JIgPrW2pA/TuZJTq3YbFT7FqoEl1ZAXZKPoWs5H/pfPE1XIRFXnE6wF5jCXxELOsmlk032LribvBd4Wk4XV/tzu3BzXqJjLOQveof8P1ocng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nb0U0lpA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKl60c006913;
	Fri, 16 Feb 2024 21:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PPbZAy+vH4wUi7CLffmzmcdaoVVlb9lMcnd+reqgNAI=;
 b=nb0U0lpA9uWs+Q749sedi1z6O3QtwH9KIZPAtY0X/+/4CSk7NTuPYXsODGYhsHnRdFsQ
 /3MLEFlwbPtk944FTuabUaPrEhRH/kCzUxBBUqHYi0uMNI0Be/SIqxYND1bqOAuCeMef
 NuB5t/MeU1Iq4EqB8HxX4j9eJTf8+qS2kMjwKiiYCLib94/jqQI8TjQPHhUR2ZUyX5Uj
 cNmsmkxCH/MdDzbhDTMqzy6E5rxwTCW2TjAIl+VR0H42bMcooLS0WzlUKMdf4w+g7hDX
 w759yB7FOLwd6k04ea9sLWVZT9Dc/EjAXFgIqUiSdr0m2Z2usWmlJ7H56cNGUSDbJWNo cw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3waf1xgnxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:18:57 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GL5eGG026240;
	Fri, 16 Feb 2024 21:18:56 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3waf1xgnx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:18:56 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GK0FvE010050;
	Fri, 16 Feb 2024 21:18:55 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npmdfb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:18:55 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GLIqBk20054726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:18:54 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0166A5805D;
	Fri, 16 Feb 2024 21:18:52 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C21958059;
	Fri, 16 Feb 2024 21:18:50 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.34.148])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Feb 2024 21:18:50 +0000 (GMT)
Message-ID: <f219e1a8a174c51064b52bc9197a8b5869599ac2.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] KVM: s390: load guest access registers in MEM_OP
 ioctl
From: Eric Farman <farman@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David
 Hildenbrand <david@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
 <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Date: Fri, 16 Feb 2024 16:18:49 -0500
In-Reply-To: <e1364fe5a3e1ec09d343db29dbbdbafb35aef3f5.camel@linux.ibm.com>
References: <20240215205344.2562020-1-farman@linux.ibm.com>
	 <20240215205344.2562020-2-farman@linux.ibm.com>
	 <20240216094012.8060-A-hca@linux.ibm.com>
	 <e1364fe5a3e1ec09d343db29dbbdbafb35aef3f5.camel@linux.ibm.com>
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
X-Proofpoint-GUID: xd7SU3DUWN9Rr97CNDit2ryvQe0RfsbX
X-Proofpoint-ORIG-GUID: JTmK9nTslVG5RR1cIxyJX8JFHOkKmgN2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_20,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160167

On Fri, 2024-02-16 at 11:33 -0500, Eric Farman wrote:
> On Fri, 2024-02-16 at 10:40 +0100, Heiko Carstens wrote:
> > On Thu, Feb 15, 2024 at 09:53:43PM +0100, Eric Farman wrote:
> > > The routine ar_translation() can be reached by both the
> > > instruction
> > > intercept path (where the access registers had been loaded with
> > > the
> > > guest register contents), and the MEM_OP ioctls (which hadn't).
> > > This latter case means that any ALET the guest expects to be used
> > > would be ignored.
> > >=20
> > > Fix this by swapping the host/guest access registers around the
> > > MEM_OP ioctl, in the same way that the KVM_RUN ioctl does with
> > > sync_regs()/store_regs(). The full register swap isn't needed
> > > here,
> > > since only the access registers are used in this interface.
> > >=20
> > > Introduce a boolean in the kvm_vcpu_arch struct to indicate the
> > > guest ARs have been loaded into the registers. This permits a
> > > warning to be emitted if entering this path without a proper
> > > register setup.
> > >=20
> > > Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> > > Signed-off-by: Eric Farman <farman@linux.ibm.com>
> > > ---
> > > =C2=A0arch/s390/include/asm/kvm_host.h |=C2=A0 1 +
> > > =C2=A0arch/s390/kvm/gaccess.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > > =C2=A0arch/s390/kvm/kvm-s390.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 11 +++++++++++
> > > =C2=A03 files changed, 14 insertions(+)
> > ...
> > > diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> > > index 5bfcc50c1a68..33587bb4c9e8 100644
> > > --- a/arch/s390/kvm/gaccess.c
> > > +++ b/arch/s390/kvm/gaccess.c
> > > @@ -391,6 +391,8 @@ static int ar_translation(struct kvm_vcpu
> > > *vcpu, union asce *asce, u8 ar,
> > > =C2=A0	if (ar >=3D NUM_ACRS)
> > > =C2=A0		return -EINVAL;
> > > =C2=A0
> > > +	WARN_ON_ONCE(!vcpu->arch.acrs_loaded);
> > > +
> > > =C2=A0	save_access_regs(vcpu->run->s.regs.acrs);
> >=20
> > Why not simply:
> >=20
> > 	if (vcpu->arch.acrs_loaded)
> > 		save_access_regs(vcpu->run->s.regs.acrs);
> >=20
> > ?
> >=20
> > This will always work, and the WARN_ON_ONCE() would not be needed.
> > Besides
> > that: _if_ the WARN_ON_ONCE() would trigger, damage would have
> > happened
> > already: host registers would have been made visible to the guest.
> >=20
> > Or did I miss anything?
>=20
> You're right that the suggestion to skip the save_access_regs() call
> in
> this way would get the ALET out of the guest correctly, but the
> actual
> CPU AR hadn't yet been loaded with the guest contents. Thus, the data
> copy would be done with the host access register rather than the
> guest's, which is why I needed to add those two extra hunks to do an
> AR
> swap around the MEM_OP interface. Without that, the selftest in patch
> 2
> continues to fail.

Scratch that. I applied this onto some other in-progress code, so the
statement about a failing test isn't valid. You're not missing
anything, and the hunks around MEM_OP aren't needed. I'll send v3.

