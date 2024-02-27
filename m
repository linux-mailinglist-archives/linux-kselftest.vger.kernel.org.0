Return-Path: <linux-kselftest+bounces-5481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA678690BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 13:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4C01F26428
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 12:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9638135A61;
	Tue, 27 Feb 2024 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UV74+i2Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A35FBB8
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037545; cv=none; b=RXUlqcDfbtBK/pvdGEeRBabY75b7ouKlkNfRwG6Bgz6353CKo2ZRGyZfglULZcWuhVmGyssg7mhcdMk2Oi2sFfOn0G8VD6TRWj6aU3hQl0nCtX/O356SP2gyu9FAIADW0Bsj0hkll98ly0KFz/fO557HHUKOCUQpSY6+xYreKuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037545; c=relaxed/simple;
	bh=Q4v2Q6q71dVtqykI+u+egT6HgOd3I31Kis38xbgwCEk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tIUsLQcFm7ie1ZHU8YrXq3nxR6H+s0G8yPrvzv2TZ6SaMup6M3+J5mAn7bI6U9A6MTEstgL+ogTrFrfoVq91ZM5x34YGrR23XfCzPxkjQRaF5hQE0LKkK9JzXOb08btwEQAwtpC+6mg1SeaVPqGaCCWUYR3FYlvyA13HKmLHo4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UV74+i2Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41RCHViA006252;
	Tue, 27 Feb 2024 12:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=b928xqbPLuWZeWemVeMhSuZ04GMXi6apGDQECkQ6APY=;
 b=UV74+i2QSvzidOPysLPByYq1ckc9ZtShO0BjGbkCyzfP76IBoinx3etFv1wqHQQt1baH
 j4RAZCzLPl30R2xV4aV39dU8FwT31Zbarso8+sLO6arxxkBB7Q5awYyUe23bak8lg19F
 W3rPV5HOiJ1KQsPDoTQHVHlJP6k5/61qZug2CuOOnRr0kixkbkkNZ3V9r7QfPgvadUrt
 BCtCxRhGpdeEg1qtl4hdGOjpPbi1Cg3ev/L/4Wx3P1YaZBTeqx+P4wt6spWkW6PNTONO
 p7iag6w3GtaLX5LqoImC6JF31YgPI/h+p+1ht9uEGfRmGXaYcHQNr4Uz4DK0aHqhqNtr uA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whfkw8gy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 12:38:47 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41RCUScs010671;
	Tue, 27 Feb 2024 12:38:46 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whfkw8gxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 12:38:46 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41RCPGrK021792;
	Tue, 27 Feb 2024 12:38:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfu5yys5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 12:38:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41RCcdsd21496464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 12:38:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F05320043;
	Tue, 27 Feb 2024 12:38:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92C8920040;
	Tue, 27 Feb 2024 12:38:36 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.0.228])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Feb 2024 12:38:36 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [RFC PATCH] selftest/powerpc: Add rule file to address sub-folder
 test fail
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <20240225163926.264286-1-maddy@linux.ibm.com>
Date: Tue, 27 Feb 2024 18:08:24 +0530
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, shuah@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <955703B5-578C-4189-A6D4-34AC56DC264C@linux.ibm.com>
References: <20240225163926.264286-1-maddy@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gPWmQ56CeLUPpoGOTsta0n8WYXz_El07
X-Proofpoint-ORIG-GUID: 3e3wpgc3H3UBFcYpgkt5FasdULpCACFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270098



> On 25-Feb-2024, at 10:09=E2=80=AFPM, Madhavan Srinivasan =
<maddy@linux.ibm.com> wrote:
>=20
> When running `make -C powerpc/pmu run_tests` from top level selftests
> directory, currently this error is being reported
>=20
> make: Entering directory =
'/home/maddy/linux/tools/testing/selftests/powerpc/pmu'
> Makefile:40: warning: overriding recipe for target 'emit_tests'
> ../../lib.mk:111: warning: ignoring old recipe for target 'emit_tests'
> gcc -m64    count_instructions.c ../harness.c event.c lib.c ../utils.c =
loop.S  -o /home/maddy/selftest_output//count_instructions
> In file included from count_instructions.c:13:
> event.h:12:10: fatal error: utils.h: No such file or directory
>   12 | #include "utils.h"
>      |          ^~~~~~~~~
> compilation terminated.
>=20
> This is due to missing of include path in CFLAGS. That is, CFLAGS and
> GIT_VERSION macros are defined in the powerpc/ folder Makefile which
> in this case not involved.
>=20
> To address the failure incase of executing specific sub-folder test =
directly,
> a new rule file has been addded by the patch called "include.mk" under
> selftest/powerpc/ folder and is linked to all Makefile of powerpc/pmu
> sub-folders.
>=20
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---

Thanks for the fix Maddy. The patch fixes the reported problem
for me.

=E2=80=94 Sachin


