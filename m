Return-Path: <linux-kselftest+bounces-26818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14426A38FC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 00:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C095416D7ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 23:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C341AAA1F;
	Mon, 17 Feb 2025 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aNQRuiAr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76213AA5D;
	Mon, 17 Feb 2025 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739836382; cv=none; b=Sd+FV5MLTrH3J52zXbzmD5HwwlI5FIuljKOERg+T4GBqGcwEf3xinpaReImFx8B1tWrSPSOmq7D+kHk1IcXYfTZCpbSZ2QYs7e3fMHMKwJkx8nvIueZFTD91go1Tip8es5ZWLrbH6b9182geCKeVpTHO24qyjWwIhU2BRVyHt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739836382; c=relaxed/simple;
	bh=hFWQZbuaJCLbpJ75wJwLS1eWO/mwC/SJ9sPYNIG6Fjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PB5Eqsd7NZh0SVK/hte9k7/x6CMm/DAE6SJ09j1Fh+7WGQqOvb5Ld0nDTr1nYRyFLDM7Q675acpGB+be4s1IUJRAjGkig3GJ7pu/u/EN/fdFt+QloF+SqZ6uUCWecPgposepBFXRgDrn/eNHgAttk3nXXhyX5rd3VDHTP8HcrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aNQRuiAr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HEFdnr031269;
	Mon, 17 Feb 2025 23:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xcbpSi
	rApYFVqD02XWoqbeg0ui4KB0iW63GiGNd5ibY=; b=aNQRuiArjnDq+vK+ET0P72
	zaX/SsQS06tsW4Cjf82GwGHDLQYkjyMNYSmiMQGnZKi6qB0z4qNlt1GrA1GiSulS
	eOe4Tdw4qj7yC15Myt61yaJFuT1Vo3RkgRY/PRahZWSg+E7mwo0mhnT5gzmH8N10
	Wm+icAw4Pj2z0WBLQXrvGKvKx/cviGYQmdGprqT9w2Ngkf6ejBZzGXB7AfjkOMzU
	dWKobXeyjUjP0V2a8+6FxfDOCuLjfpSFK98+Zby0Q+nLn3DPBFQkyZMbnP5TEoh9
	zW8AvjbM14bQk9aM3QSzTUmxxWJb8UdZlJNVDocD+mmapXPz6yNJAMxBGFR2/tSg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uxx7vxbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 23:52:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51HK8Eei008141;
	Mon, 17 Feb 2025 23:52:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u58tgk48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 23:52:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51HNqWTU20578732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 23:52:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00A3820043;
	Mon, 17 Feb 2025 23:52:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 733BD20040;
	Mon, 17 Feb 2025 23:52:31 +0000 (GMT)
Received: from localhost (unknown [9.171.66.22])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 17 Feb 2025 23:52:31 +0000 (GMT)
Date: Tue, 18 Feb 2025 00:52:26 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Fangrui Song <i@maskray.me>, Xi Ruoyao <xry111@xry111.site>,
        Heiko Carstens <hca@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/vDSO: fix GNU hash table entry size for
 s390x
Message-ID: <your-ad-here.call-01739836346-ext-7522@work.hours>
References: <20250217-selftests-vdso-s390-gnu-hash-v2-1-f6c2532ffe2a@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217-selftests-vdso-s390-gnu-hash-v2-1-f6c2532ffe2a@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mEt67ZX6_nKBR3UKS2y_zNxBz83sFpVi
X-Proofpoint-ORIG-GUID: mEt67ZX6_nKBR3UKS2y_zNxBz83sFpVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1011 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170179

On Mon, Feb 17, 2025 at 02:04:18PM +0100, Thomas Weißschuh wrote:
> Commit 14be4e6f3522 ("selftests: vDSO: fix ELF hash table entry size for s390x")
> changed the type of the ELF hash table entries to 64bit on s390x.
> However the *GNU* hash tables entries are always 32bit.
> The "bucket" pointer is shared between both hash algorithms.
--
> On s390x the GNU algorithm assigns and dereferences this pointer to a
> 64bit value as a pointer to a 32bit value, leading to compiler warnings and
> runtime crashes.

I would rephrase it as follows:

On s390, this caused the GNU hash algorithm to access its 32-bit entries as if they
were 64-bit, triggering compiler warnings (assignment between "Elf64_Xword *" and
"Elf64_Word *") and runtime crashes.

And take it via s390 tree.

Shuah, if you don't mind, may I get your Acked-by?

Thank you!

> Introduce a new dedicated "gnu_bucket" pointer which is used by the GNU hash.
> 
> Fixes: e0746bde6f82 ("selftests/vDSO: support DT_GNU_HASH")
> Reviewed-by: Jens Remus <jremus@linux.ibm.com>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v2:
> - Fix wording around the width of pointers vs the pointed-to values
> - Link to v1: https://lore.kernel.org/r/20250213-selftests-vdso-s390-gnu-hash-v1-1-ace3bcc940a3@linutronix.de
> ---
>  tools/testing/selftests/vDSO/parse_vdso.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

