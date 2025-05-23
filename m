Return-Path: <linux-kselftest+bounces-33622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8DDAC1FD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 11:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F901BC7D2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 09:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0248F22540B;
	Fri, 23 May 2025 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R3CkCkzB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A620FA84;
	Fri, 23 May 2025 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747992989; cv=none; b=f4CCsju3GFgjBFSlZwlh0l5OSAw1GucPmyu6kA3H6vxs32stBE6nrZGiB7vZtddvUU7iuCdysmKhoYmeVJ+jGMgG+XXXsONy5NeSDM8f4xJooTIqlDA+Fdu/TXCA5XpgAJh9fXx1sTH/aXkMTtCpg9afUiPrX0V1ONT2Z3MVyXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747992989; c=relaxed/simple;
	bh=cPC4fHGWPka8bstxiXogJPlkvyOjtaWI2Dl+2o9kDZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRgpdkdD1venfbuW2XGsNcvDeNeLfpfKZlzYb4ZF0mVL9sTeIDzYAxy0C4wanSpscBbOvM17jJtt0leDgxbXXcYjQUxyRYTUa7e3d3hrFqg1yNJeI0EgIyy7U+MdC1oHiM6ZHOqhs8/FhLPwKk5CTBxtBxkszyjohP5H+B4cmhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R3CkCkzB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MNWFqO004792;
	Fri, 23 May 2025 09:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vMybJrVOxCi72E1Pt60pMqYpdyjf6S
	s0XPZB55xj29M=; b=R3CkCkzBXxxe/KYe1HZxSJvJw7yMOWqLIb1q9Fi1+dx9HB
	lzrW5uC2D+o8DDUmBu0XM/PAJmqmuHehdBrEVMHqfoUhcHLi6ToYHjCmmhOlgfpT
	TQwI7DqaMRONrgRWKiGKDFCg4cmfGAVkPkHI9lynHES6VI4ywZ1JOR5QZTqGu76w
	l7XrHGeY+Mdy+bNlQw3PXcMHZHCcVz5cFIIGqdwXcz8+J5jIoQ3qIK8Fq943SHuV
	uKIOU7g/2MkYBPKsPCpXWeosqUVJ5uPlb0FmkK8RcqZ/FUkJllqmSvNDLeiC6gz6
	jIMSQ2cId1paOBWJTP7lt+mEa75GUm/RTw1LZivA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t14jp33r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 09:35:57 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54N9Ub2D019284;
	Fri, 23 May 2025 09:35:56 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t14jp33p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 09:35:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54N65XYR020693;
	Fri, 23 May 2025 09:35:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwkq5x35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 09:35:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54N9ZqFH47186204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 09:35:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B10D2004D;
	Fri, 23 May 2025 09:35:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47DD220043;
	Fri, 23 May 2025 09:35:50 +0000 (GMT)
Received: from osiris (unknown [9.111.71.83])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 23 May 2025 09:35:50 +0000 (GMT)
Date: Fri, 23 May 2025 11:35:48 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>, linux-s390@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 07/14] s390: Handle KCOV __init vs inline mismatches
Message-ID: <20250523093548.9524A8b-hca@linux.ibm.com>
References: <20250523043251.it.550-kees@kernel.org>
 <20250523043935.2009972-7-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523043935.2009972-7-kees@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KqDaZI-N24qPBCncGoId1M5821jvyXiL
X-Authority-Analysis: v=2.4 cv=XOkwSRhE c=1 sm=1 tr=0 ts=6830417d cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=i0EeH86SAAAA:8 a=ZhbCrNo_nw5myWupG0oA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA4NCBTYWx0ZWRfX0w0P9E3aDLPl xKkdIDIhLiwjTmqVc2SrRDCWVWFZrVDCFjUtGWXwGKiqzPx3aH1H3kR3L9ztCvCTG2dYW5CKwL9 sICNUHibIsoUXe9IU/++4/n8wIvLqcN/lTpzb6AwUj21nwbHo2PrdccpN7uJ5neULr3iZ+x0IDO
 cp9vaJXECGONZX36cRDNAuI3GEBAklLQu6bmjDNQyoWpyWcL52i8nxzjSMmMG12/PXn7Ht4o/I9 rKz7HWr8sXVyui6OGhJ6oXDcKWfiiMUq3fRRvh9CBFKWIWsQnUS30/UPfY4kp/wqVcXw92l9rKW 3UN+JfNQzPqTmiL+lKipax/ZfWe+uKv2lFByzGPt8jex7JX31DFbbxTGQxDZdrqyBmdG3LASN+L
 ff1/Bps89M6t1nUW1d6VQ0r0f4R0IG0qDcI6J5H3ztJ8TgF0KLAewZp36812jwJ9B/V82K6H
X-Proofpoint-GUID: FAZQIEfWbNoED4pzflxHiaQq3RMT7Za1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 mlxlogscore=586 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230084

On Thu, May 22, 2025 at 09:39:17PM -0700, Kees Cook wrote:
> When KCOV is enabled all functions get instrumented, unless
> the __no_sanitize_coverage attribute is used. To prepare for
> __no_sanitize_coverage being applied to __init functions, we have to
> handle differences in how GCC's inline optimizations get resolved. For
> s390 this exposed a place where the __init annotation was missing but
> ended up being "accidentally correct". Fix this cases and force a couple
> functions to be inline with __always_inline.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Gaosheng Cui <cuigaosheng1@huawei.com>
> Cc: <linux-s390@vger.kernel.org>
> ---
>  arch/s390/hypfs/hypfs.h      | 2 +-
>  arch/s390/hypfs/hypfs_diag.h | 2 +-
>  arch/s390/mm/init.c          | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

