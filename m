Return-Path: <linux-kselftest+bounces-4564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B38537F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 18:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C42B24362
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013D45F56B;
	Tue, 13 Feb 2024 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VewgRhhj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC61C5FF0A;
	Tue, 13 Feb 2024 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845493; cv=none; b=f1RjwNoR86VohxNMlBXvDRD3lRPps7O8lgF34rps3elkWGNoouyubOlM3wyo3dfU0FO9NIJoVEQdblKDyfycKN47h0HhkkNRyIPlXLRrkv47874fshT1qCJBUgEgxrPo5sKLIPEto8nlfLjsrD9rgTYFsMw0QE/KYp2bRl4wVoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845493; c=relaxed/simple;
	bh=zAX+ib+bIQWbtHML8WRbuLZ6jHHjHhUHi1WoY5RCqvU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D8lO4fDgUMqO63RaB6rlzUMZEiiLCrYa0LXuSiKYQ8JrUf3S6iIBCxwrTFNu51Aj+4inpazPt5RFiw43Bx+noZV3XtI3bZGryrsgVMeVl2PrU+GVbD+GAuggJeEF6N5wGtlg3TaTBycXMA+oZAq24X6CvDC197Tj1WWdAmbeP8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VewgRhhj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DGv1vu012209;
	Tue, 13 Feb 2024 17:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zAX+ib+bIQWbtHML8WRbuLZ6jHHjHhUHi1WoY5RCqvU=;
 b=VewgRhhjAYPvo1WDhPJWsnFGJY6qOSP1GuNEZnJ6rxddPwPHzzzX916T2HgyUH0MlIZA
 zWcJgXM5t+xEjTAo+jm7BLov5eJe/xMbOMhrs/l2HEyyMnEKeqpeK+qyvnNYvf0mftAP
 VNt0mzx4RhEK/Lkl9X22/xbdq93PoKc0d/tGO3NWLjXG595VzcDyyLdBKLDzWPim0lz4
 SnzuI7qCoPQDfFp0sKCDZQrrxM+g1ttCcNnc4KkHr/zQ6bop3EyuMx5elnSd+DC9kVnn
 Oo6jlit1mGl838aRr8Wqb6od2LsfuFmY2K+VXsj/qd2BmP8Fyy7IvMUeeUF+Bzm0VWsm Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8cd30vy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 17:31:29 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DHVOGG013453;
	Tue, 13 Feb 2024 17:31:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8cd30vt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 17:31:26 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41DGSRK3004247;
	Tue, 13 Feb 2024 17:31:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv08yym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 17:31:11 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DHV8M17996062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 17:31:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4360B58056;
	Tue, 13 Feb 2024 17:31:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D2E458068;
	Tue, 13 Feb 2024 17:31:05 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.106.172])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 17:31:05 +0000 (GMT)
Message-ID: <f416f4340c0f3dc7954f3b26e6ed5008a1deeae8.camel@linux.ibm.com>
Subject: Re: [PATCH v1 1/2] KVM: s390: load guest access registers in MEM_OP
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
Date: Tue, 13 Feb 2024 12:31:04 -0500
In-Reply-To: <20240212115205.9156-C-hca@linux.ibm.com>
References: <20240209204539.4150550-1-farman@linux.ibm.com>
	 <20240209204539.4150550-2-farman@linux.ibm.com>
	 <20240212102130.9156-A-hca@linux.ibm.com>
	 <20240212115205.9156-C-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: AW3p7d0vWTCnICg3ZKbHKdRnhBi0B_sI
X-Proofpoint-GUID: QsGDiqobCow0ihV0LHGgq9LPAunio-oB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=677 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130138

On Mon, 2024-02-12 at 12:52 +0100, Heiko Carstens wrote:
> > On Mon, Feb 12, 2024 at 11:21:30AM +0100, Heiko Carstens wrote:
> > > > Or maybe a TIF flag with different semantics: "guest save area
> > > > does
> > > > not
> > > > reflect current state - which is within registers".
> >=20
> > Something like the below; untested of course.

Ooops, yeah. Christian suggested something similar in his first
response to the RFC which I'd overlooked.

> > =C2=A0But I guess there must be
> > some arch specific vcpu flags, which can be used to achieve the
> > same?

Agreed. Putting something there probably makes sense to keep it in the
KVM sphere

> >=20
> > diff --git a/arch/s390/include/asm/thread_info.h
> > b/arch/s390/include/asm/thread_info.h
> > index a674c7d25da5..b9ff8b125fb8 100644
> > --- a/arch/s390/include/asm/thread_info.h
> > +++ b/arch/s390/include/asm/thread_info.h
> > @@ -69,6 +69,7 @@ void arch_setup_new_exec(void);
> > =C2=A0#define TIF_PATCH_PENDING 5 /* pending live patching update */
> > =C2=A0#define TIF_PGSTE 6 /* New mm's will use 4K page tables */
> > =C2=A0#define TIF_NOTIFY_SIGNAL 7 /* signal notifications exist */
> > +#define TIF_KVM_ACRS 8 /* access registers contain guest content
> > */
> > =C2=A0#define TIF_ISOLATE_BP_GUEST 9 /* Run KVM guests with isolated BP
> > */
> > =C2=A0#define TIF_PER_TRAP 10 /* Need to handle PER trap on exit to
> > usermode */
> > =C2=A0
> > diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> > index 5bfcc50c1a68..b0ef242d2371 100644
> > --- a/arch/s390/kvm/gaccess.c
> > +++ b/arch/s390/kvm/gaccess.c
> > @@ -391,7 +391,8 @@ static int ar_translation(struct kvm_vcpu
> > *vcpu,
> > union asce *asce, u8 ar,
> > =C2=A0 if (ar >=3D NUM_ACRS)
> > =C2=A0 return -EINVAL;
> > =C2=A0
> > - save_access_regs(vcpu->run->s.regs.acrs);
> > + if (test_thread_flag(TIF_KVM_ACRS))
> > + save_access_regs(vcpu->run->s.regs.acrs);

...or WARN if not set, so that we know of the missing path. Will send
this all as a v2. Thanks.

> > =C2=A0 alet.val =3D vcpu->run->s.regs.acrs[ar];
> > =C2=A0
> > =C2=A0 if (ar =3D=3D 0 || alet.val =3D=3D 0) {
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index ea63ac769889..3ee0913639d5 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -4951,6 +4951,7 @@ static void sync_regs(struct kvm_vcpu *vcpu)
> > =C2=A0 }
> > =C2=A0 save_access_regs(vcpu->arch.host_acrs);
> > =C2=A0 restore_access_regs(vcpu->run->s.regs.acrs);
> > + set_thread_flag(TIF_KVM_ACRS);
> > =C2=A0 /* save host (userspace) fprs/vrs */
> > =C2=A0 save_fpu_regs();
> > =C2=A0 vcpu->arch.host_fpregs.fpc =3D current->thread.fpu.fpc;
> > @@ -5020,6 +5021,7 @@ static void store_regs(struct kvm_vcpu *vcpu)
> > =C2=A0 kvm_run->s.regs.pfs =3D vcpu->arch.pfault_select;
> > =C2=A0 kvm_run->s.regs.pfc =3D vcpu->arch.pfault_compare;
> > =C2=A0 save_access_regs(vcpu->run->s.regs.acrs);
> > + clear_thread_flag(TIF_KVM_ACRS);
> > =C2=A0 restore_access_regs(vcpu->arch.host_acrs);
> > =C2=A0 /* Save guest register state */
> > =C2=A0 save_fpu_regs();


