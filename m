Return-Path: <linux-kselftest+bounces-4813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548B6856DDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 20:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50B81F229BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5364813A242;
	Thu, 15 Feb 2024 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZRbNisLR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7535DF16;
	Thu, 15 Feb 2024 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025990; cv=none; b=rLX9O9bITvI9pnj92IoIzCm67jwTSGoqoCC/USQ+uMNEdjNbWpWTqWZ1OQ26neTZBFWnYDV5utkvxCMiG+JEcbBm4eCDLaa8t5dkWgn5Z3fByOOm8ekgl+aSUxo/YG6rFtF98U1K7OQmJFA/MhLtP2F5e+gzyGTCpuOa6TpLis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025990; c=relaxed/simple;
	bh=b4qsm/vXrA5+rq9TQ8U1/ACAAqaoSOxrn80nHRGkv7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kHPfA/AXeg05yJo5T0IUuaBQBUnlevFAGr3xNpg5CNPXwwdoNCVNsp1tCZv/fyoF85eOokUJz3xZjfL90W7lDl/nBw854QPVMsiOWbTPVRjRb7pEizPGz7xu1dSOOkGCfzhqe9aaWXtC8xG2U0BNFZZVEF3TbDqlve7O/D0g1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZRbNisLR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FJUpJQ015076;
	Thu, 15 Feb 2024 19:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=DXx62xEDkMDtVYwwGpGO1K+w7sxZBu7HWpCPYxFwSME=;
 b=ZRbNisLRs5PgAS9akFbugwMk+p9Cv+kM0W32tY4ERnlpjGu/RTRtsifIa9LENIgyYGkl
 dd4ws0WbdFgFbV2JW99s4W87iphobojyv88g6PFJBkpVC6NFbg3njS7akTyeG8TcelIP
 RgJWiD3YX+vfugBWVMWSjeiF2VePyyqSw7tXpE3AC1ISgXWB4mV0d0EL06aqBR1J8Xz9
 qWmUbwK2u9atsJ+hVWB4w2C+h6J21u7l2laIUOiO+5xBImiwRhw51wBjRRsRfXO8R34Y
 kT+wY9RRjNVAlqbcQiTWHEZU/ymFluQVhS61nzmByC28awWjFmGm2gYGpbXYDVyUidKI mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9qfaj90q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 19:39:32 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FJXRkv026056;
	Thu, 15 Feb 2024 19:39:31 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9qfaj90h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 19:39:31 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FJAQnG032596;
	Thu, 15 Feb 2024 19:39:30 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6kfty4m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 19:39:30 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FJdRmP15073858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 19:39:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1CAE5805A;
	Thu, 15 Feb 2024 19:39:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0C615805D;
	Thu, 15 Feb 2024 19:39:27 +0000 (GMT)
Received: from localhost (unknown [9.41.178.242])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 19:39:27 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy
 <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: powerpc: Add header symlinks for building
 papr character device tests
In-Reply-To: <20240215192334.GT9696@kitsune.suse.cz>
References: <20240215165527.23684-1-msuchanek@suse.de>
 <87cysxilr5.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
 <20240215192334.GT9696@kitsune.suse.cz>
Date: Thu, 15 Feb 2024 13:39:27 -0600
Message-ID: <87a5o1ikk0.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dHZjoht_l3SplpnpVfgfYytwe__CGZEi
X-Proofpoint-ORIG-GUID: 7KiZXsiChIvbg2Gq05Gqu7fVP_3aUuIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_18,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=541 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150158

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> On Thu, Feb 15, 2024 at 01:13:34PM -0600, Nathan Lynch wrote:
>> Michal Suchanek <msuchanek@suse.de> writes:
>> >
>> > Without the headers the tests don't build.
>> >
>> > Fixes: 9118c5d32bdd ("powerpc/selftests: Add test for papr-vpd")
>> > Fixes: 76b2ec3faeaa ("powerpc/selftests: Add test for papr-sysparm")
>> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>> > ---
>> >  tools/testing/selftests/powerpc/include/asm/papr-miscdev.h | 1 +
>> >  tools/testing/selftests/powerpc/include/asm/papr-sysparm.h | 1 +
>> >  tools/testing/selftests/powerpc/include/asm/papr-vpd.h     | 1 +
>> >  3 files changed, 3 insertions(+)
>> >  create mode 120000 tools/testing/selftests/powerpc/include/asm/papr-m=
iscdev.h
>> >  create mode 120000 tools/testing/selftests/powerpc/include/asm/papr-s=
ysparm.h
>> >  create mode 120000
>> > tools/testing/selftests/powerpc/include/asm/papr-vpd.h
>>=20
>> I really hope making symlinks into the kernel source isn't necessary. I
>> haven't experienced build failures with these tests. How are you
>> building them?
>>=20
>> I usually do something like (on a x86 build host):
>>=20
>> $ make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc64le-linux- ppc64le_defconf=
ig
>> $ make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc64le-linux- headers
>> $ make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc64le-linux- -C tools/testin=
g/selftests/powerpc/
>>=20
>> without issue.
>
> I am not configuring the kernel, only building the tests, and certainly
> not installing headers on the system.

OK, but again: how do you provoke the build errors, exactly? Don't make
us guess please.

> Apparently this is what people aim to do, and report bugs when it does
> not work: build the kselftests as self-contained testsuite that relies
> only on standard libc, and whatever it brought in the sources.
>
> That said, the target to install headers is headers_install, not
> headers. The headers target is not documented, it's probably meant to be
> internal to the build system. Yet it is not enforced that it is built
> before building the selftests.

<shrug> the headers target is used in Documentation/dev-tools/kselftest.rst:

"""
To build the tests::

  $ make headers
  $ make -C tools/testing/selftests
"""

This is what I've been following.

