Return-Path: <linux-kselftest+bounces-4870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E005585829C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 17:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09FBB20D2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 16:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509CD12FB0F;
	Fri, 16 Feb 2024 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ow00rFF+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C96E219ED;
	Fri, 16 Feb 2024 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101219; cv=none; b=V9JCxYvOTOb6vPsxq6VnX2Ya6DUKtB2ut+vqRTVS5K5WymqGakhA9lnsDg5BX8C5V5LGYGPfrcPEj6W6ZU1ZKbalLGAsYt1snF+gNyqisiYgKbqbSuUdANq4i5xpxAeQUeXy9eQmAf0nyFu/sgonFoe9W788KvquNjE/paHzXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101219; c=relaxed/simple;
	bh=08O4BtOm/c/lk0WJ8UE2M87B74vE2KvoWp59wRYMA14=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KxrzkKTN3FnaBdqFZyFa6140ZDN5UeKT4GCxLLbJM11wi2oW2+xn5o9MrJNLV8Xe7KllZwg4z+7EYpf+sKNJ2Yc+uGnLgkxbfXwmi7sz8UUfKLEAtXfO99UVTSiMvqbbp0E4k1NonUeVwYEW4rUf9OSLLMED35EQ2lzesX/vM3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ow00rFF+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GGVNML010695;
	Fri, 16 Feb 2024 16:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=nsDqoaA0uxmTN3/1MudUVyi5KmjfJMAEwxra8oJHAtc=;
 b=ow00rFF+vtDsgIwmgMnGYsu3MNUPlGnwtycrmSYFywgxzoDgiYC1IvHeyi70YGil6/zG
 cOIcP4eBlNYLyL38OWuC9/T6GumbFaSE3ch9Vu5+3VKnKbypJTyAb28WGsVbxX2H5m/Y
 btw6YobSsv4qkJ2r/hRieFSA5N1n8Ett19qFzDq2PSPVQuD4N8yTjInFjCxBPfPWJKqk
 iRXMIXxBSWD1xYlFC1zR6V+pqVnDw+TUMeM79+VTVdD1INYh6sTygTxOs0EpdgwH3vEx
 fSRaUkDhZAvb+SaEZk5W0tk7Hww8kCXE8FyNaSpcxSj1XPXNXJWjCwNQLG62AFUbGHK5 LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa9wu203q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 16:33:34 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GGWoqh015692;
	Fri, 16 Feb 2024 16:33:33 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa9wu2036-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 16:33:33 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GFSoNu024908;
	Fri, 16 Feb 2024 16:33:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfpvdf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 16:33:32 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GGXTV541681434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 16:33:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F04358052;
	Fri, 16 Feb 2024 16:33:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E56D58056;
	Fri, 16 Feb 2024 16:33:27 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.34.148])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Feb 2024 16:33:27 +0000 (GMT)
Message-ID: <e1364fe5a3e1ec09d343db29dbbdbafb35aef3f5.camel@linux.ibm.com>
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
Date: Fri, 16 Feb 2024 11:33:27 -0500
In-Reply-To: <20240216094012.8060-A-hca@linux.ibm.com>
References: <20240215205344.2562020-1-farman@linux.ibm.com>
	 <20240215205344.2562020-2-farman@linux.ibm.com>
	 <20240216094012.8060-A-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: -thmYTw3y7ZcH3RKZVd1mkrDgjPE6ZfH
X-Proofpoint-GUID: RL74pB2MxeeSysUrcnJEYhRN0jNJyhsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_16,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160132

On Fri, 2024-02-16 at 10:40 +0100, Heiko Carstens wrote:
> On Thu, Feb 15, 2024 at 09:53:43PM +0100, Eric Farman wrote:
> > The routine ar_translation() can be reached by both the instruction
> > intercept path (where the access registers had been loaded with the
> > guest register contents), and the MEM_OP ioctls (which hadn't).
> > This latter case means that any ALET the guest expects to be used
> > would be ignored.
> >=20
> > Fix this by swapping the host/guest access registers around the
> > MEM_OP ioctl, in the same way that the KVM_RUN ioctl does with
> > sync_regs()/store_regs(). The full register swap isn't needed here,
> > since only the access registers are used in this interface.
> >=20
> > Introduce a boolean in the kvm_vcpu_arch struct to indicate the
> > guest ARs have been loaded into the registers. This permits a
> > warning to be emitted if entering this path without a proper
> > register setup.
> >=20
> > Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Signed-off-by: Eric Farman <farman@linux.ibm.com>
> > ---
> > =C2=A0arch/s390/include/asm/kvm_host.h |=C2=A0 1 +
> > =C2=A0arch/s390/kvm/gaccess.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 ++
> > =C2=A0arch/s390/kvm/kvm-s390.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 11 +++++++++++
> > =C2=A03 files changed, 14 insertions(+)
> ...
> > diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> > index 5bfcc50c1a68..33587bb4c9e8 100644
> > --- a/arch/s390/kvm/gaccess.c
> > +++ b/arch/s390/kvm/gaccess.c
> > @@ -391,6 +391,8 @@ static int ar_translation(struct kvm_vcpu
> > *vcpu, union asce *asce, u8 ar,
> > =C2=A0	if (ar >=3D NUM_ACRS)
> > =C2=A0		return -EINVAL;
> > =C2=A0
> > +	WARN_ON_ONCE(!vcpu->arch.acrs_loaded);
> > +
> > =C2=A0	save_access_regs(vcpu->run->s.regs.acrs);
>=20
> Why not simply:
>=20
> 	if (vcpu->arch.acrs_loaded)
> 		save_access_regs(vcpu->run->s.regs.acrs);
>=20
> ?
>=20
> This will always work, and the WARN_ON_ONCE() would not be needed.
> Besides
> that: _if_ the WARN_ON_ONCE() would trigger, damage would have
> happened
> already: host registers would have been made visible to the guest.
>=20
> Or did I miss anything?

You're right that the suggestion to skip the save_access_regs() call in
this way would get the ALET out of the guest correctly, but the actual
CPU AR hadn't yet been loaded with the guest contents. Thus, the data
copy would be done with the host access register rather than the
guest's, which is why I needed to add those two extra hunks to do an AR
swap around the MEM_OP interface. Without that, the selftest in patch 2
continues to fail.

If the WARN triggers, damage will be done if the ARs get copied back to
the vcpu->run space (I don't believe any damage has occurred at the
time of the WARN). That's what's happening today and I'd like to
address, but there's no indication of what's happened. Perhaps I need
to combine the two ideas? Do the WARN, but remove the
save_access_regs() call since it gets done again once the registers are
swapped back. Or keep it, and dig out the RFC code that stores the
current ARs into a temporary variable instead?

Thanks,
Eric

