Return-Path: <linux-kselftest+bounces-15825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC659595FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 09:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D46B2B2165C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 07:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF93192D97;
	Wed, 21 Aug 2024 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T/TF1dkn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECBC165F05;
	Wed, 21 Aug 2024 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224964; cv=none; b=rB9mYLuBPI88HfTSikE5rkjb0b2cG8cG8aAgXhdrSmFkMfQwD0MlZNQGMKI2WPs2+1Uhj/9zXqjn20b4IMZnQvYR/0zP5pH6Undj2gauA4ZaHdeyM0qfWsvK4t0YUnMvp3Wg8drcus6tt0frhPzr+fPd9H/9VGNZjui9uwKiNa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224964; c=relaxed/simple;
	bh=gaWd2Z4616ZFMhxGI4SPOkuP6dhKMEHLYmRmq4YrPj4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=qcWciwruRQnasg9VfuhSVWfndsG8OwcHhf8sZFbIDN7FIKSJtL8GxYvthMabDlqynaDRaG4wAU7jz32jXVfIyoUDVBz6nhV7hKcSipbdfaCsLTcqontrl4yi785FtqKS1ahEi+vf4pZOa7FoorsWgegDdpcl47Dz1wwBqLXczKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T/TF1dkn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L4IAKA011112;
	Wed, 21 Aug 2024 07:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:from:cc:to:subject:references:in-reply-to; s=pp1;
	 bh=8caWsDT0+YtPhXLZmbs1IBFhjeyBKurapMd5y2UFq+k=; b=T/TF1dknyk6Z
	ynXesGMmJwlfmwH8UedhxSI1z5wly0UvlOiHvzK6cUwKbPe5XBPIeUuAViCRMoR6
	jDi6K9gd8hebEMg40ISU44RWch4vf3n8Y5ug4cVkn9xSBni07zQ/3ZHndWW7FMXJ
	wGod063+QjdoAmNdoWOQLWZbY+rmoqGlICGh6dsKxm8YSotjPLM2WmBecBTVAG6U
	uNTSFmpeWNbz2J/ux/VzQow4zAjJDQPdObemMXW9FHLVOzol422FO5LDdJOjNwp4
	d7R39WUJvvtJiqLhpIztKvxAtu3j4kqhq7lymBvhZgnrri3SkwBFMrOyVqf3U2RQ
	g986vmeH1w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc4rx1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:22:39 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47L7IF0j032050;
	Wed, 21 Aug 2024 07:22:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc4rx1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:22:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47L4Vb6M019123;
	Wed, 21 Aug 2024 07:22:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41376pxmu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:22:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47L7MVTZ22675866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 07:22:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C237D2004E;
	Wed, 21 Aug 2024 07:22:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F2D120040;
	Wed, 21 Aug 2024 07:22:31 +0000 (GMT)
Received: from darkmoore (unknown [9.171.47.216])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Aug 2024 07:22:31 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Aug 2024 09:22:26 +0200
Message-Id: <D3LEQDBXFOF3.2G919SAB8NQ7C@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <shuah@kernel.org>,
        <frankja@linux.ibm.com>, <borntraeger@linux.ibm.com>,
        <imbrenda@linux.ibm.com>, <david@redhat.com>, <pbonzini@redhat.com>
To: "Hariharan Mari" <hari55@linux.ibm.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] KVM: s390: selftests: Add regression tests for
 KMCTR, KMF, KMO and PCC crypto subfunctions
X-Mailer: aerc 0.17.0
References: <20240820065623.1140399-1-hari55@linux.ibm.com>
 <20240820065623.1140399-4-hari55@linux.ibm.com>
In-Reply-To: <20240820065623.1140399-4-hari55@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q0dd8d5ffzCrW-nGdGLcJIvfu-OQ_fkI
X-Proofpoint-GUID: IlHYYYA-mBsGMdgEjo6ATn1OCmyQOdlK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=877 adultscore=0 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210050

On Tue Aug 20, 2024 at 8:48 AM CEST, Hariharan Mari wrote:
> Extend the existing regression test framework for s390x CPU subfunctions
> to include tests for the KMCTR (Cipher Message with Counter) KMO
> (Cipher Message with Output Feedback), KMF (Cipher Message with Cipher
> Feedback) and PCC (Perform Cryptographic Computation) crypto functions.
>
> The test procedure follows the established pattern.
>
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Hariharan Mari <hari55@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

LGTM

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  .../kvm/s390x/cpumodel_subfuncs_test.c        | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)

[...]

