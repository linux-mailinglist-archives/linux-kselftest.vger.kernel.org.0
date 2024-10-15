Return-Path: <linux-kselftest+bounces-19734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8BE99EDB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 15:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1521B1F24684
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FBD1B21A3;
	Tue, 15 Oct 2024 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tYL40ZDe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C245F1AF0DF;
	Tue, 15 Oct 2024 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999202; cv=none; b=mIWcaKDjXutUsksSW3WCaXPP5S2usFMgPz36aOBLDKxSMtiTxQcj2wb1tKocq2L7Xhq4hbjpH/U1RPgXOzPWYE7WbSgszNEG6dfJ5cbvGe54SCYpSlXnbzB/+MzjUkyVQZ6ZdggFXvyqtI7UhHFHH/Sw74bv8kW1VVNok+rJVZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999202; c=relaxed/simple;
	bh=eKK3YJkzGUL7LoDYmFThBpuVhS3ay6wlYdhQIEW1sIo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=GskgxBPwplca8l2DBgaxIPRcE3GAYYL6WYTr8sNz1dl36d735Do+95JJrtVLZJ4UwnudRZ+U4etiNshVK9erpIkFoiLyM0oZ0S8pMdGgipl7BFVA0E3eFtliycU67XhVbhDFs6JEeM6rKwcKki/J08gXtqtpdt7a6+PE72PvFC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tYL40ZDe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FCnnUl007216;
	Tue, 15 Oct 2024 13:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t4uLAP
	lb3ElPca1lnSQXtBqmK2LFXQJJsi9UiaP00vs=; b=tYL40ZDeoKAgu6cmwb4YAy
	3K4VGic7qGGG5JSVCLHgL3HonN+mmYVemlPRV8lt0L5Fhax6udIaAasjhGVVOC7A
	rK35/VFYabvYIXCFrYaYhnHRb7xx+t6d94WQy2o85YQZOsE0YcJhICk782BxEh7f
	Sx2EQseZe7KOAiwvu90NXPgVFjafxhosAWToh5Ixx0Rf8xeB9v15HWfUoRifRxs7
	qhxr3eRb1w5Q6v+cxVdDz4NxW8baFPQqgj2hiOqIha8cCyD5aXf3GfEeIe2rO3V5
	SeYSegx2qFki6jVCpIW3iCoRO/tEdKHh27YVgPvLu6RbGNF321wNFeB51usn08fg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429rr7r7e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 13:33:15 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FDXF27028138;
	Tue, 15 Oct 2024 13:33:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429rr7r7e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 13:33:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FB7slr027464;
	Tue, 15 Oct 2024 13:33:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txm54j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 13:33:13 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FDXAUs26673538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 13:33:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5918420043;
	Tue, 15 Oct 2024 13:33:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 326AC20040;
	Tue, 15 Oct 2024 13:33:10 +0000 (GMT)
Received: from darkmoore (unknown [9.179.10.245])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 13:33:10 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Oct 2024 15:33:04 +0200
Message-Id: <D4WF2493HS7M.QHC37L73T9L5@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "Paolo
 Bonzini" <pbonzini@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
        "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>,
        "David Hildenbrand" <david@redhat.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v6 2/5] selftests: kvm: s390: Add uc_skey VM test case
X-Mailer: aerc 0.18.2
References: <20241015083744.761838-1-schlameuss@linux.ibm.com>
 <20241015083744.761838-3-schlameuss@linux.ibm.com>
 <b7246d28-612e-4f6d-81ba-53d9a28e325b@linux.ibm.com>
In-Reply-To: <b7246d28-612e-4f6d-81ba-53d9a28e325b@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P9p0DbDYRCMVEG5Jh83MR1mh9nnUGZXS
X-Proofpoint-ORIG-GUID: ckCItoD9snFp9915_xadorp9gBJWAbNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=859
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150092

On Tue Oct 15, 2024 at 3:22 PM CEST, Janosch Frank wrote:
> On 10/15/24 10:37 AM, Christoph Schlameuss wrote:
> > Add a test case manipulating s390 storage keys from within the ucontrol
> > VM.
> >=20
> > Storage key instruction (ISKE, SSKE and RRBE) intercepts and
> > Keyless-subset facility are disabled on first use, where the skeys are
> > setup by KVM in non ucontrol VMs.
> >=20
>
> [...]
>
> > -/* verify SIEIC exit
> > +/*
> > + * Disable skey intercepts and rewind last instruction
> > + * (KVM would init the skeys here)
> > + */
> > +static void uc_skey_enable(FIXTURE_DATA(uc_kvm) *self)
> > +{
> > +	struct kvm_s390_sie_block *sie_block =3D self->sie_block;
> > +	int ilen =3D insn_length(sie_block->ipa >> 8);
> > +	struct kvm_run *run =3D self->run;
> > +
> > +	/* disable KSS */
> > +	sie_block->cpuflags &=3D ~CPUSTAT_KSS;
> > +	/* disable skey inst interception */
> > +	sie_block->ictl &=3D ~(ICTL_ISKE | ICTL_SSKE | ICTL_RRBE);
> > +
> > +	/* rewind to reexecute intercepted instruction */
> > +	run->psw_addr =3D run->psw_addr - ilen;
>
> There's a very important detail between KSS and the SKEY ICTLs:
> KSS is (mostly) nullifying i.e. the PSW points to the instruction that=20
> caused the KSS exit.
> ICTL intercepts are suppressing which means the PSW points after the=20
> instruction and hence we need to rewind the PSW if we want to re-issue=20
> the instruction.
>
> Re-winding on a KSS intercept makes the guest cpu execute the=20
> instruction before the intercept producing instruction twice.

Oh, yes. You are right, I did mess that up in my cleanup. I will fix that.
Here it does now only work since the KSS is not intercepted on the second
invocation. But I am with you, it should only be executed once.

