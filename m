Return-Path: <linux-kselftest+bounces-23804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409149FF393
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Jan 2025 10:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6F13A2E5D
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Jan 2025 09:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA32C7DA67;
	Wed,  1 Jan 2025 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OcV/MApP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60F25771
	for <linux-kselftest@vger.kernel.org>; Wed,  1 Jan 2025 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735722541; cv=none; b=coeUbH72sXKI8L7hbSsN+lt8gPyeTBoUvYNMVFWqZTBevCtnZykIdgkBM1rZUX5x57/FKND6QEXf49R/ZKKSAblpQw5g+qvpzO3ECe5JCeh6XXpi3wQKpopHD2d8t5u9A5IsrR+kVhaa+tcjiywFgpDLST84YLr8geyuhDPeYSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735722541; c=relaxed/simple;
	bh=ZlVI8n/Ssm8sao/auvQOl4mL8VUySAukyc0dVbDiYxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Allo/LP7FR+hr7UBmDM9H17QTa4JhSoqzbQQunQ56CfpBKdcftuVztQEKFGvSpb05xF2wlxZsvnY/IcTx8G1mScOMW4HeQkMvMWrzieBJFEoCKimusd4xpCdg1rdwoCmKwIEdoSQknBNzbBK1xNO+tLEiSVCn94NFDN8cbuNmj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OcV/MApP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5014iCup024354;
	Wed, 1 Jan 2025 09:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oYoas6
	1OhAYOoieOqXCEGrdvSIwZzmKeua7845ofkRw=; b=OcV/MApP+X6A6aOUls2sAb
	ilvI3+YvvpcgjfwiM3Voehd7fOJdoxip8JN3H3x/wYTYNfDgHRJKWqnbsEWTMG7o
	sR2aZNoRCOwRBqfdDp0ODhZSbOOETpOdLcCTB/Req4TYcyHyWb2CPzU/i7jhyXQP
	N44rw4kb2lAVNohgTi9KdBUb+tNBrh5Fn/nAYt3gLRXN/EquhHjVUiuTwCwQadJ8
	d8S1xDnPr1MlSC4sFDFvF8N3kQ6QQB8WwFuxE8Y+mUpe4jD19JkWhyG7o0xP9nm9
	ce6iS515RG+J64iTra4lwYkRR/ki+e7LmUouDcwDj+NRyGcbnhFCRBuIkJOJnusQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43vx6hrrys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jan 2025 09:08:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50194sme030394;
	Wed, 1 Jan 2025 09:08:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43vx6hrryn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jan 2025 09:08:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5017EseG016711;
	Wed, 1 Jan 2025 09:08:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43tw5kdj1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jan 2025 09:08:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50198hc739518588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jan 2025 09:08:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2308E20043;
	Wed,  1 Jan 2025 09:08:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C86062004B;
	Wed,  1 Jan 2025 09:08:38 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.115.214])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jan 2025 09:08:38 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, shuah@kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 1/3] selftest/powerpc/ptrace/core-pkey: Remove duplicate macros
Date: Wed,  1 Jan 2025 14:38:36 +0530
Message-ID: <173572211261.1875638.17052629553644664859.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216160257.87252-1-maddy@linux.ibm.com>
References: <20241216160257.87252-1-maddy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: opcIxYR9v9nmOHoU2v1fY2vME-gYTL-f
X-Proofpoint-GUID: oJiLXkRhD9L1p11bwTdyMOfvRgitffjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=828 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501010077

On Mon, 16 Dec 2024 21:32:55 +0530, Madhavan Srinivasan wrote:
> ./powerpc/ptrace/Makefile includes flags.mk. In flags.mk,
> -I$(selfdir)/powerpc/include is always included as part of
> CFLAGS. So it will pick up the "pkeys.h" defined in
> powerpc/include.
> 
> core-pkey.c test has couple of macros defined which
> are part of "pkeys.h" header file. Remove those
> duplicates and include "pkeys.h"
> 
> [...]

Applied to powerpc/next.

[1/3] selftest/powerpc/ptrace/core-pkey: Remove duplicate macros
      https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=026ac4dda8f666f737b375731e30ef8f5698b215 
[2/3] selftest/powerpc/ptrace/ptrace-pkey: Remove duplicate macros
      https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=b0e1b95b1597ad3d87ff91d52f6b67cc9423c31e 
[3/3] selftest/powerpc/ptrace: Cleanup duplicate macro definitions
      https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=65f5038352e8f635fb827f7482f1d08fae4d16bf 

Thanks

