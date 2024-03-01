Return-Path: <linux-kselftest+bounces-5683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A7986DA71
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 04:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19A61C214B1
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 03:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577234776F;
	Fri,  1 Mar 2024 03:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FNJiCO4p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF9B2F53
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709265480; cv=none; b=TqZCOTrdgd+KtTHMhSBYEAsAkRC6cXCXBgWicIfygN3BMALOsyEAGhiw0TE7xlrshnFuuxf19GlzQJILbt2sDptII4FoNWrfgRM1GcxUfEcReKqHPbfnHLZA9DzbhsF57id6oMfGPiz0HQqFw+aen69GgW19dY1ATetvDy5D9Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709265480; c=relaxed/simple;
	bh=e/DBrDsXWecFqMqTAD13j5Tdl+K3Ok4mlwpzN77ZvFY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LYbY6ZfOnmA71G6tGMVMoraQ1LgMzlqyFgEzwXdRVnGLjyljM7LY2NTGsxtEqmcyUlXPwmXmubXNNZrlDJ9cIJy7vHGalIbwsymuy8kVb9As0yBkwCEBR7UQyEvfsMIezoZk+F+oDn8O+LCUDNtysxcuHCwPcFnrhNYTnfhWfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FNJiCO4p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4213JLam016311;
	Fri, 1 Mar 2024 03:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=p5+p52mB34XnsI5TxDlp1VJZFYxgxclYpeW9vdq4/hU=;
 b=FNJiCO4pKvy7IpOjLzFdwi/TN6ZBdafsy1SDiGPIXAEKJFlr0QAUQjGQI7WADMV1Idvu
 fpCI7uBqncIYdKIWPte2buZb231LSqstuN3vsML58D03fi/KFZMItZNqH6Xy9BbMnmXM
 mB6vcuXyEhVCYGOFQg60FqRDaTVZ09FctlkDFqOAK+m7gymNEzU+TX+BmnM+BVjMJOwM
 tFgqQR+aq2S73O5hrlMoBXg7wFUSnFxC51cNhPwN8+nHnlLN0CVis+vjW2QYNu4nGFsa
 mojgguhTL1rCANfzzz6V+gpnFsH6BNkrc6fWe0bj6Qn9HXI5X0FAJdu32K2UgUtQTCsW 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk70vgsh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 03:57:50 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4213nRhk008767;
	Fri, 1 Mar 2024 03:57:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wk70vgsh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 03:57:50 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42112fC7008154;
	Fri, 1 Mar 2024 03:57:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mstuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 03:57:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4213vjUi29295038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 03:57:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FC4620043;
	Fri,  1 Mar 2024 03:57:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1322320040;
	Fri,  1 Mar 2024 03:57:44 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.11.96])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 03:57:43 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [kselftests/powerpc] Primitives test build failure with
 linux-next
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <87o7bygbip.fsf@mail.lhotse>
Date: Fri, 1 Mar 2024 09:27:32 +0530
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kselftest@vger.kernel.org, tanzhasanwork@gmail.com,
        andy.shevchenko@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <74E707B6-E4DC-4977-967E-4D8A47E6C130@linux.ibm.com>
References: <C11ED986-3959-4C4D-8780-ABD97D5FB0D1@linux.ibm.com>
 <87o7bygbip.fsf@mail.lhotse>
To: Michael Ellerman <mpe@ellerman.id.au>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fjfZb8OZPjicHPbjrPgRDtiD8y7VjcaL
X-Proofpoint-ORIG-GUID: pFLnYm-uz4WMoz9DLuxKphPru-ftpdUV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010031



> On 01-Mar-2024, at 3:48=E2=80=AFAM, Michael Ellerman =
<mpe@ellerman.id.au> wrote:
>=20
> Sachin Sant <sachinp@linux.ibm.com> writes:
>> Powerpc specific selftests (specifically powerpc/primitives) included =
in linux-next
>> tree fails to build with following error
>>=20
>> gcc -std=3Dgnu99 -O2 -Wall -Werror =
-DGIT_VERSION=3D'"next-20240229-0-gf303a3e2bcfb-dirty"' =
-I/home/sachin/linux-next/tools/testing/selftests/powerpc/include  =
-I/home/sachin/linux-next/tools/testing/selftests/powerpc/primitives    =
load_unaligned_zeropad.c ../harness.c  -o =
/home/sachin/linux-next/tools/testing/selftests/powerpc/primitives/load_un=
aligned_zeropad
>> In file included from load_unaligned_zeropad.c:26:
>> word-at-a-time.h:7:10: fatal error: linux/bitops.h: No such file or =
directory
>>    7 | #include <linux/bitops.h>
>>      |          ^~~~~~~~~~~~~~~~
>> compilation terminated.
>>=20
>> The header file in question was last changed by following commit
>>=20
>> commit 66a5c40f60f5d88ad8d47ba6a4ba05892853fa1f
>>    kernel.h: removed REPEAT_BYTE from kernel.h
>=20
> Patch below should fix it, can you please confirm?
>=20
Thanks Michael. Yes, this fixes the reported problem.

Tested-by: Sachin Sant <sachinp@linux.ibm.com>


=E2=80=94 Sachin=

