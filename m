Return-Path: <linux-kselftest+bounces-48059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2AFCEE81C
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 13:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDBA3303ADF3
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D704030F545;
	Fri,  2 Jan 2026 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N/c87wbu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A330F931;
	Fri,  2 Jan 2026 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356453; cv=none; b=JoBNVDXmO1FDfVkjc+jGn2LZJexcjTYJ1PnkxALV14KSGvC8jZNIZirgzGI1VMb4K/jnFv/Mhr9ETXLGf57CPANTBvAgcTZ3zUA3WqVA79hXxwXGuBWd5AtGF5JhF+uanEXgZfkbCrc6Sfgd2nAjCqxHchuq3mwYCTHLV1Tj2/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356453; c=relaxed/simple;
	bh=2HnA4NQf63mqdoCRpSaED2UJTl1zBpXs4OSoQ9qTJSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K11L0sUonAdn7IKLjUP0itVVXWeVF0T9zcgIKTeyLaI4bgnz2NmqxftG6PphfPMhT/LhvCnN0n1giUYPvEm/zGPHKOwyIBeUZYVB9/JlE0B82jzyPoXXbSQwkmwk0WPAmq0i6tQvy1UfhnFn+3tykrxg+L9fcunFrPe5FARisAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N/c87wbu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 601Nsvtq013909;
	Fri, 2 Jan 2026 12:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TKK5Sw
	BrypXXv9T4so3tN8W+1qltUU+uy3Mi8alEDvE=; b=N/c87wbuCw9e7OZaVs287x
	U6/QbNs0KMa60aAtjtNK0YlS1yuEebcSx9n7qy+lxKdZAOT2K9r6MoaGZSdgaWKP
	52ZP/A8NY7NnMOFP7UFdoo36h9XPjRyHVo91LaTLf7hYQk3BNwf0/SdXi0Xc2353
	Z30Yex2Hhv/VN6SjSsA/iLRPilZgugRVnfZeA21Apgp3q592Ka0KROZBctRdI51n
	iB3YQrXGVwvQkG2VAbDY+pIiq8KqGQH13M2+1AhPQjwyZS6TGDwr+wYjeJAm000x
	kbt/qiW8shvJWvO5hkxpdFkhCcVFfxgOW+v3bubkkc2EJZtJ3SPIFc8B44HsEoNA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bb46xujm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 12:20:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 602BvSbP003059;
	Fri, 2 Jan 2026 12:20:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bavg265ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 12:20:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 602CKG8a52494652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Jan 2026 12:20:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD8C420040;
	Fri,  2 Jan 2026 12:20:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95F0C20043;
	Fri,  2 Jan 2026 12:20:15 +0000 (GMT)
Received: from osiris (unknown [9.111.41.241])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Jan 2026 12:20:15 +0000 (GMT)
Date: Fri, 2 Jan 2026 13:20:14 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] vdso: Remove struct getcpu_cache
Message-ID: <20260102122014.10318A55-hca@linux.ibm.com>
References: <20251230-getcpu_cache-v3-1-fb9c5f880ebe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251230-getcpu_cache-v3-1-fb9c5f880ebe@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDEwOCBTYWx0ZWRfX9vvRNnkd8Pfx
 iw1giuFwzqM2vrv6sGKjDUbgff0h0Y3jUCCV+buGKuhJKmIds+6tH5OCPgPJ2qLIM3h06dIiFaP
 1UYq0HSsD3FH7rEYyqTRKGtk6rSfb4j3xN+CP0hhZVFP/ejElo1I82+KGR5JFRuLRxaUXgqSt9W
 Zvsnv/2QMUpAgYrECXfeG0QvM1VSvnxqxLO+1+uyR9VK1+y/ETAGBSi3c/8MW6PBkQ7z1maYW/f
 xkjGvwoo1/AkQqTQUfB0qr3ZoKf5jVPVG/dOvw1dDtw7K2FTDJecoJYCRRJ47H74VimRcSraDZL
 Nnm2ews70dEM07L/U9IPmu8Qz252j9h0zu+hetSfHmoGZ3+2/VeXvKezWdQHDgiGnNH6huCdNc1
 nRLPlTKY9cSU5T/esXreLKw1L7W+/DXeX9pIOj85YApUXusXHF7ypYyxHhVEmQ2IUo3fF8N7RBh
 rfurbe/WqzaJ7fhU/Bg==
X-Proofpoint-ORIG-GUID: u-CeqcOxJgfmuySfQGUJRGwUwbFNnK6A
X-Authority-Analysis: v=2.4 cv=L7AQguT8 c=1 sm=1 tr=0 ts=6957b807 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=hd350nrAjBw2G0HVihMA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: u-CeqcOxJgfmuySfQGUJRGwUwbFNnK6A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601020108

On Tue, Dec 30, 2025 at 08:08:44AM +0100, Thomas Weiﬂschuh wrote:
> The cache parameter of getcpu() is useless nowadays for various reasons.
> * It is never passed by userspace for either the vDSO or syscalls.
> * It is never used by the kernel.
> * It could not be made to work on the current vDSO architecture.
> * The structure definition is not part of the UAPI headers.
> * vdso_getcpu() is superseded by restartable sequences in any case.
> 
> Remove the struct and its header.
> 
> As a side-effect we get rid of an unwanted inclusion of the linux/
> header namespace from vDSO code.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v3:
> - Rebase on v6.19-rc1
>   - Fix conflict with UML vdso_getcpu() removal
> - Flesh out commit message
> - Link to v2: https://lore.kernel.org/r/20251013-getcpu_cache-v2-1-880fbfa3b7cc@linutronix.de
> 
> Changes in v2:
> - Rebase on v6.18-rc1
> - Link to v1: https://lore.kernel.org/r/20250826-getcpu_cache-v1-1-8748318f6141@linutronix.de
> ---
> We could also completely remove the parameter, but I am not sure if
> that is a good idea for syscalls and vDSO entrypoints.
> ---
>  arch/loongarch/vdso/vgetcpu.c                   |  5 ++---
>  arch/s390/kernel/vdso/getcpu.c                  |  3 +--
>  arch/s390/kernel/vdso/vdso.h                    |  4 +---
>  arch/x86/entry/vdso/vgetcpu.c                   |  5 ++---
>  arch/x86/include/asm/vdso/processor.h           |  4 +---
>  include/linux/getcpu.h                          | 19 -------------------
>  include/linux/syscalls.h                        |  3 +--
>  kernel/sys.c                                    |  4 +---
>  tools/testing/selftests/vDSO/vdso_test_getcpu.c |  4 +---
>  9 files changed, 10 insertions(+), 41 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390

