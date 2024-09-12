Return-Path: <linux-kselftest+bounces-17845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60192976C18
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 16:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927C01C237A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA9E1AE845;
	Thu, 12 Sep 2024 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NGriG+uP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9AD1A4E7C;
	Thu, 12 Sep 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151381; cv=none; b=r7aO+K3N0uqptZGb06E6+m+0fdpH7CAHzX3Asatgw/A19Q64Xwjupicbpc4Z4Q1bGE+cc2ISNj3xs79mp1PLySN3ocOJzHqjWZfU/gNPz7vh60jqAeVoWa1mRARHoy9eQ8IN2Ug59Fh2oMpts7ankMDFDMX9M7aA3UDj2sr/Ad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151381; c=relaxed/simple;
	bh=WqWblWK9j9pBmIDPL8+cidY79AOM7Ury3RJgfIB58HY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=N1FFszQ8WmvDaRQkgDC3eYG3Z/2EDVEdVNv3u2nzMfKPSBhZJa/sIeim3c5l/Imnw57E9XwQZymwO9VeGT1aD7GK8IjzaHaSbogKdYKuEYkd9LBbX7rI2AdPUEjprK35QDL+gCqUrO8xj8kp9ilCgCmiXdLINObBfYJOOf+aRKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NGriG+uP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CBXhiN020293;
	Thu, 12 Sep 2024 14:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:from:cc:to:subject:references:in-reply-to; s=pp1;
	 bh=V8JhCKvZz3EJEDtODbSJXFM409kvD1wRr+l0IYPGJis=; b=NGriG+uPuMt/
	EdX6uyBPOqL+0tSDe3n/KaYeZtChhDyC7PXPDHuVPrvg4Ac9Es7mHzTJGCgT38Yl
	m3WDipIUgK/a7+1hOPYy9xy9vDntE4DpJsnqV9yTOejTn+OnjPaney6d4rIyDbZs
	ztCi1Ny/1nVyn3mRdsBRnrJ4rAfeQwyl4WUtDNd3gUVDkkxv7xS8MlMS7++X9utn
	rW3BzXHyLy/4szJXEZz4ydt4YGhfChgc0wkAQ18dkJzBOEwUCnx1rrfcc1376a5I
	cAjIpHwl2U3aVebIWiWOZv+nYJD2PpVfP1nH0wUReDP+Ujg2fVuir8pA9gwiTqsn
	p8ynGZSKPQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebam7jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 14:29:35 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48CETZvr017287;
	Thu, 12 Sep 2024 14:29:35 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebam7j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 14:29:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48CCaxVq013471;
	Thu, 12 Sep 2024 14:29:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3cmg8qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 14:29:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48CETUlY52232584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 14:29:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8720F20043;
	Thu, 12 Sep 2024 14:29:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5569020040;
	Thu, 12 Sep 2024 14:29:30 +0000 (GMT)
Received: from darkmoore (unknown [9.179.25.216])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Sep 2024 14:29:30 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Sep 2024 16:29:25 +0200
Message-Id: <D44DL9UL4Q2T.3JHP2BM3APY6A@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
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
Subject: Re: [PATCH v2 2/3] selftests: kvm: s390: Add uc_skey VM test case
X-Mailer: aerc 0.18.2
References: <20240902115002.199331-1-schlameuss@linux.ibm.com>
 <20240902115002.199331-3-schlameuss@linux.ibm.com>
 <20240912101523.5ee9ca54@p-imbrenda>
In-Reply-To: <20240912101523.5ee9ca54@p-imbrenda>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5V3cu_pd0_FiapShwabz62x6YUSCC06o
X-Proofpoint-GUID: axDXDaVUYWZMAW1fgR1Ls2ke40B6Udrq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_03,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=627 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409120102

On Thu Sep 12, 2024 at 10:15 AM CEST, Claudio Imbrenda wrote:
> On Mon,  2 Sep 2024 13:50:01 +0200
> Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:
>
> > Add a test case manipulating s390 storage keys from within the ucontrol
> > VM.
> >=20
> > Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> > ---
> >  .../selftests/kvm/s390x/ucontrol_test.c       | 89 ++++++++++++++++++-
> >  1 file changed, 88 insertions(+), 1 deletion(-)

[...]

> > +TEST_F(uc_kvm, uc_skey)
> > +{
> > +	u64 test_vaddr =3D VM_MEM_SIZE - (SZ_1M / 2);
> > +	struct kvm_sync_regs *sync_regs =3D &self->run->s.regs;
> > +	struct kvm_run *run =3D self->run;
> > +	u8 skeyvalue =3D 0x34;
> > +
> > +	/* copy test_skey_asm to code_hva / code_gpa */
> > +	TH_LOG("copy code %p to vm mapped memory %p / %p",
> > +	       &test_skey_asm, (void *)self->code_hva, (void *)self->code_gpa=
);
> > +	memcpy((void *)self->code_hva, &test_skey_asm, PAGE_SIZE);
> > +
> > +	/* set register content for test_skey_asm to access not mapped memory=
 */
> > +	sync_regs->gprs[1] =3D skeyvalue;
> > +	sync_regs->gprs[5] =3D self->base_gpa;
> > +	sync_regs->gprs[6] =3D test_vaddr;
> > +	run->kvm_dirty_regs |=3D KVM_SYNC_GPRS;
> > +
> > +	/* DAT disabled + 64 bit mode */
> > +	run->psw_mask =3D 0x0000000180000000ULL;
> > +	run->psw_addr =3D self->code_gpa;
> > +
> > +	ASSERT_EQ(0, uc_run_once(self));
> > +	ASSERT_EQ(false, uc_handle_exit(self));
>
> this should be true, since KSS will be triggered
>

Good find.
Yes, as this is the assertion does actually fail here.
Will fix that in the next version.

> > +	ASSERT_EQ(1, sync_regs->gprs[0]);
> > +
> > +	/* ISKE */
> > +	ASSERT_EQ(0, uc_run_once(self));
> > +	ASSERT_EQ(false, uc_handle_exit(self));
> > +	ASSERT_EQ(2, sync_regs->gprs[0]);
> > +	/* assert initial skey (ACC =3D 0, R & C =3D 1) */
> > +	ASSERT_EQ(0x06, sync_regs->gprs[1]);
> > +	uc_assert_diag44(self);

[...]


