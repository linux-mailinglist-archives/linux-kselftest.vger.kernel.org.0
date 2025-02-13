Return-Path: <linux-kselftest+bounces-26544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8426A33F70
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 13:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1DF188CB2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F1A221571;
	Thu, 13 Feb 2025 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iSZiPgiH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7721935951;
	Thu, 13 Feb 2025 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450869; cv=none; b=Sd0SbCf9DKaaWgEIHXBWKw+o2VNpVzuIx/J40RP5ZaujWqARJ4cQ/1HN/QtEKA3ezpNVHVWbwi0mCmZRZZnYTqYANlate3gfxUbg/E2cwM6/40Ygl5MX3AZlih+3rLRtRdT3qut4hwmlPKJ3urO4pBIWq6JWPSeu+X1ttNtghmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450869; c=relaxed/simple;
	bh=UjqKuT7cBx0BC8IA1E06aYBT48DU6uO5RO8mYWBW0UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPEkBZ6/xbfrykgEF6pk4ZMcLQK5j4SdvIdMIDSQpEgzT9GLVqtLD+VWU9UN1XjVF+nDT8LMFpdFJHXkm3l9iaP3AFC7A3ZSnIlvfv1VbH4MyjOLsoUPfch1QJXHYwcn7jVIZgJZ+rOUjBqHQv3/Ujwt9NTdD+kMheQP50QfNWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iSZiPgiH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D7WvfK014686;
	Thu, 13 Feb 2025 12:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1eQPev
	v+zfRx7xSJsTOA/iarbbLg4H24SjJBcTfyK/Q=; b=iSZiPgiHAOWHpB37SjtNaX
	CtHomNChMfpYzkkb+dJljGWolAHFzQU4AyYYWvpxpE7FvJ92tpfi4Tp/okw+NcYw
	ao44uffaQhrSt9NZYLx6JzNwKtaP1hy2HvevnDRkolU7r4b6f5DvfVC1HoaciP+3
	mST2IU6hoiD61f51DTba93d77zbmPzTLBJcow8K3GXUoENjeHa7ibkpvryRfwKN4
	wH0a70qokvI7gcZaA231vce0dJbyaezD+BgGkxq1cy29GmVY+KksqfARg7mSotxi
	eWY1eAZYtwS9HWXQmnGXrVaBnkMmn7TPPqepVFUv0AXWUMruMqFJjE31hJuIQ+Cw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44sceq1hc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 12:47:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51DBBSrj028197;
	Thu, 13 Feb 2025 12:47:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyypcpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 12:47:28 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51DClQxF40436212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 12:47:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 726B420040;
	Thu, 13 Feb 2025 12:47:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 454FE2004B;
	Thu, 13 Feb 2025 12:47:26 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Feb 2025 12:47:26 +0000 (GMT)
Message-ID: <008b57f5-96d3-4aca-b304-19ced4fa1efd@linux.ibm.com>
Date: Thu, 13 Feb 2025 13:47:26 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/vDSO: fix GNU hash table entry size for s390x
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Shuah Khan <shuah@kernel.org>, Fangrui Song <i@maskray.me>,
        Xi Ruoyao <xry111@xry111.site>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
        Heiko Carstens
 <hca@linux.ibm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250213-selftests-vdso-s390-gnu-hash-v1-1-ace3bcc940a3@linutronix.de>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250213-selftests-vdso-s390-gnu-hash-v1-1-ace3bcc940a3@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rVzIw933K76OpH6HmtqRR14uAtMfb1Kp
X-Proofpoint-ORIG-GUID: rVzIw933K76OpH6HmtqRR14uAtMfb1Kp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130096

On 13.02.2025 10:41, Thomas Weißschuh wrote:
> Commit 14be4e6f3522 ("selftests: vDSO: fix ELF hash table entry size for s390x")
> changed the type of the ELF hash table entries to 64bit on s390x.
> However the *GNU* hash tables entries are always 32bit.
> The "bucket" pointer is shared between both hash algorithms.
> On s390x the GNU algorithm assigns and dereferences this 64bit pointer as a
> 32bit pointer, leading to compiler warnings and runtime crashes.

Nit: The compiler complains about assignments between incompatible pointer
types (e.g. "Elf64_Xword *" and "Elf64_Word *").  The size of the pointers
themselves is not different, as it is usually defined by the architecture
regardless of the type of data pointed at.  The real issue is that the
32-bit GNU hash entries are erroneously accessed as if they were 64-bit
entries via "bucket" on s390x.

> Introduce a new dedicated "gnu_bucket" pointer which is used by the GNU hash.
> 
> Fixes: e0746bde6f82 ("selftests/vDSO: support DT_GNU_HASH")
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   tools/testing/selftests/vDSO/parse_vdso.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Jens Remus <jremus@linux.ibm.com>

Thanks for taking care!

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


