Return-Path: <linux-kselftest+bounces-44816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3369EC3671C
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 16:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F6A75053EF
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9A032F774;
	Wed,  5 Nov 2025 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kJJvQMKS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66332ED59;
	Wed,  5 Nov 2025 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356924; cv=none; b=KbbpuKd84dsh2rjhprRKKcc0IIFyAEFIjQShN5TI+GNyt5t07hdqIJt2Otwrt7M602Ko/Ir9fWhnqi4Gco0wC90YUfpIkRQIoEQWvPhweHfA2UashBlqEio1r9X6HcUDS3CpQXVA/QmmTOpXjzIXHbLnv/nUg7e54IkqTxCgrKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356924; c=relaxed/simple;
	bh=GAY674z3y8mSrBwlMlG7DIFjeFbna0LxeOPt6MO26Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQw4mIY1UufyptZHmnfMSA+EV5esRdMantG3Rx9WMkxeVMdxGjHNKj6C58lXDalc4JsaydT2XryfSMkwM278nbiX7vVtL1oUhCT7ExfgcbPpTI2Zny7aDS+ik8eE+b/DwD71LffBV5vNyohCd3Uf3yEuKnd6JSuErJUtrAwUH9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kJJvQMKS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A57hVAj007179;
	Wed, 5 Nov 2025 15:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mBCDjF
	CtIralqPbaobJr9w45EqrrTPgVKXorpBh75DA=; b=kJJvQMKSobCn/AX0FM8hiu
	lAg3CQC5+pPaGaYOYIf58zJOni1GZeBU5r+Ebpnwm1cT0Y2oN+LZHcCV1AQGy5ib
	qF0K8CkDnXRO3u+NJ6fCUcRwPNyXTzebzR/1kBMjNE2Du5ppzZk6r0ed08NSlok4
	BG42+N57/9Pz/7iG3qodXH/AVEVRn1lt7Wp+xfxzW8Mc8+KJtePmcayAgc/3sXkU
	bEde9/gBVgl3qsanMHgkoEtEGfkLfYWvSabDJoCV796DtA5RfDDhBuG1gLBp65Hj
	5kCUO4tHPdGz34RItxvzgRYx4bF2NhlaTB9c8EYikfmlyWRKpxX9/Grx/RPi1bBg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mr9vpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 15:34:36 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A5FQeET022630;
	Wed, 5 Nov 2025 15:34:35 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mr9vpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 15:34:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5ChDTP021482;
	Wed, 5 Nov 2025 15:34:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5xrjrkr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 15:34:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5FYURj53674336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 15:34:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A883920040;
	Wed,  5 Nov 2025 15:34:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13AF62004B;
	Wed,  5 Nov 2025 15:34:29 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  5 Nov 2025 15:34:28 +0000 (GMT)
Date: Wed, 5 Nov 2025 16:34:26 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Russell King <linux@armlinux.org.uk>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 24/35] vdso/datastore: Allocate data pages dynamically
Message-ID: <20251105153426.16228C13-hca@linux.ibm.com>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
 <20251014-vdso-sparc64-generic-2-v4-24-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-24-e0607bf49dea@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GGdzfD5G3hQ68-39VW7GakGxAH7MovxB
X-Authority-Analysis: v=2.4 cv=MKhtWcZl c=1 sm=1 tr=0 ts=690b6e8c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ebG-ZW-8AAAA:8 a=e1b3s80Sx_c-5AZqzBwA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=Bj2TwAA_C77lQ_X2_dkp:22 a=DXsff8QfwkrTrK3sU8N1:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=bWyr8ysk75zN3GCy5bjg:22
X-Proofpoint-ORIG-GUID: FA8Qn-I58re3Fj-7DCZVJVXwZ4DiaPYs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwMSBTYWx0ZWRfX79q+aRjocr8A
 WsJicIkrDzeZowDTKWdSRpdbbSTYSdnAKh3ClmRCNP0S8je+b6bwR4QAObGY+JaivfKMlj2hBVw
 KLzTBb1GVj2u/8kaK8wfeBTBcwczqZx2uJUW94XwBBfiT1PIHgcud1V1IaGBQ7/80r1+m5QVf5y
 2MAbdeeWJFA/uN5CkUVEPIEOGTIF7nMUT8yZgz8qLQcWjKcDN5xrV+ylstwr289JOHk8UDvW+If
 ZS0Vh+xa015UpwIHMHQi/pVyWTfCCQ7nEswkEgkvxtiBx1AXWt5u1z1b8gL7A+PMKBFcztnM0NI
 NBBPJSUKiH3NfGjyVbk1no9yQUjK4mCZusqZxNsqflVQ6b/X2GCXdlXaNPmhI6deTnzJKGTxcvZ
 8le1/uj5xZfo4KJOYkdyfW8kJi0g6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010001

On Tue, Oct 14, 2025 at 08:49:10AM +0200, Thomas Weiﬂschuh wrote:
> Allocating the datapages as part of the kernel image does not work on
> SPARC. It is also problematic with regards to dcache aliasing as there is
> no guarantee that the virtual addresses used by the kernel are compatible
> with those used by userspace.
> 
> Allocate the data pages through the page allocator instead.
> Unused pages in the vDSO VMA are still allocated to keep the virtual
> addresses aligned.
> 
> These pages are used by both the timekeeping, random pool and architecture
> initialization code. Introduce a new early initialization step, to make
> sure they are available when needed.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Tested-by: Andreas Larsson <andreas@gaisler.com>
> Reviewed-by: Andreas Larsson <andreas@gaisler.com>
> ---
>  include/linux/vdso_datastore.h |  6 ++++++
>  init/main.c                    |  2 ++
>  lib/vdso/datastore.c           | 44 ++++++++++++++++++++++--------------------
>  3 files changed, 31 insertions(+), 21 deletions(-)

...

> +void __init vdso_setup_data_pages(void)
> +{
> +	unsigned int order = get_order(VDSO_NR_PAGES * PAGE_SIZE);
> +	struct folio *folio = folio_alloc(GFP_KERNEL, order);

I'm seeing random hangs on s390 too with our CI, but unfortunately I cannot
reproduce it manually. But looking at one of the dumps it looks to me like the
vdso time page contains (more or less) random junk at the end. Or in other
words, shouldn't this be:

	struct folio *folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, order);

? At least that is a difference to before as far as I can tell.

