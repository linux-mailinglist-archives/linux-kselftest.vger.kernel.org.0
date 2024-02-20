Return-Path: <linux-kselftest+bounces-5029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3350985BD4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 14:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D451C22479
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 13:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836876A33A;
	Tue, 20 Feb 2024 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rZQBB1S0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C2F6A335;
	Tue, 20 Feb 2024 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436253; cv=none; b=mwXymtKDx/+9pxbVCKx24OW4yUD6QiyZ4fS9f6zu0yr/nm54RfNPU6ApB+tmra6xj0z97hz1q43fWfB+E7DLFVqXqrTHwcOYZra55vFNRi+uHkh8EmqbEsibokQYi7E/952ODOzzLpTrGy2mxS/mdg5U4rW1KMob4CmtvVIkrf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436253; c=relaxed/simple;
	bh=smIPqtG20UMCd/zXPcU2zt6z+XyycqU9Y03epv6a7ZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ou0rm5jh4UcFqcVPoiE2nRMoC2IlX+H2oc4nj6vuZ6gAso6DXI5KubfKqdNaqMSN8NPcH+W6NL88Rr+ea3AEsrutKg+rKozPw611tfkPK4htTXXfvslRs1adQmGLn7M61fdZwWtVh0qFjQ6m9L9j3wwkqAfdiVjotGJkhvWu1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rZQBB1S0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KDUfOQ016907;
	Tue, 20 Feb 2024 13:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2ZLbRiDGUwBJ70GdCzIY25odvEPvGmovSt4o+8xvzrc=;
 b=rZQBB1S020oBPldIlL7vHb0vrX2Ie2jGkF+xS4wwy8fSBmyjdJF1XZ0GuVV90pPiErPv
 OR/tndpuYDYghIR2qCNy5jrVfBVSOfHv4K/+HJPxBDdxgWBTLpb+H76cP749jRejxKaO
 sZH1u0a+dQ49JliaBKj3hS2fc+FHgsdrXICWPBg/EmGL2Ii9qKiAeDZdWUMVkJKZ8Wsu
 jOIuHThvETHGJMsCV2rQ/i9tf4da1XsEztLqtVPQHjKiBGlP1qIJmE/BH7sYMijN4lwf
 eXVCPlwCwcJeTPwA6w74iTNYl3z+cb6VpkW0VAfXxyphzZm7hnJDoVuPttpYdv23rtz7 pA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcvwh88pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 13:37:23 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41KDZIXu003512;
	Tue, 20 Feb 2024 13:37:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcvwh88p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 13:37:22 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41KBtut7017307;
	Tue, 20 Feb 2024 13:37:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mm87fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 13:37:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41KDbFpv41353490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 13:37:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 876E02004D;
	Tue, 20 Feb 2024 13:37:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA84920040;
	Tue, 20 Feb 2024 13:37:14 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown [9.171.28.134])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Feb 2024 13:37:14 +0000 (GMT)
Message-ID: <0dfca89958c532d1a76232fceca9856d80d42d10.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] KVM: s390: fix access register usage in ioctls
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio
 Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
 <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Date: Tue, 20 Feb 2024 14:37:14 +0100
In-Reply-To: <20240216213616.3819805-2-farman@linux.ibm.com>
References: <20240216213616.3819805-1-farman@linux.ibm.com>
	 <20240216213616.3819805-2-farman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g5WTvC2pAo2-QTnFwCzx1017JTzrdz-J
X-Proofpoint-GUID: H5hTo1b9QMbb0xuEr5qDSXT-e--ZdQpx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200098

On Fri, 2024-02-16 at 22:36 +0100, Eric Farman wrote:
> The routine ar_translation() can be reached by both the instruction
> intercept path (where the access registers had been loaded with the
> guest register contents), and the MEM_OP ioctls (which hadn't).
> Since this routine saves the current registers to vcpu->run,
> this routine erroneously saves host registers into the guest space.
>=20
> Introduce a boolean in the kvm_vcpu_arch struct to indicate whether
> the registers contain guest contents. If they do (the instruction
> intercept path), the save can be performed and the AR translation
> is done just as it is today. If they don't (the MEM_OP path), the
> AR can be read from vcpu->run without stashing the current contents.
>=20
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

> ---
>  arch/s390/include/asm/kvm_host.h | 1 +
>  arch/s390/kvm/gaccess.c          | 3 ++-
>  arch/s390/kvm/kvm-s390.c         | 3 +++
>  3 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm=
_host.h
> index 52664105a473..c86215eb4ca7 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -765,6 +765,7 @@ struct kvm_vcpu_arch {
>  	__u64 cputm_start;
>  	bool gs_enabled;
>  	bool skey_enabled;
> +	bool acrs_loaded;

Not sure how descriptive that name is.
Maybe add a comment.

>  	struct kvm_s390_pv_vcpu pv;
>  	union diag318_info diag318_info;
>  };

[...]


