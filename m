Return-Path: <linux-kselftest+bounces-15662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947D3956FD8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 18:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54600B29727
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0323817AE00;
	Mon, 19 Aug 2024 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A6aWgw3C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16DA8287D;
	Mon, 19 Aug 2024 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083456; cv=none; b=Gfgcu3o0GxyPHxh+CowD+Dx8wziJjjoK2zPlhQvMW0LNJG4jddZtIdkvFnfzE9ls8aJ1PpO3AGJPYz9XWfs4KW+7jB007VdP5xNleUliUyOamjyH4T0d4xfXjR/oTA1hxiyOUkRIUF0RMlwsyqY7mkNabDrthVQOF5ps9CjGGBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083456; c=relaxed/simple;
	bh=vDXIl4RRqksl9TF+V8PT5XaM00nkF5KB2fS3seT/cLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bcf145GkrvHChYwAtcpSdzVmp8kuKfoDfHpn62izoh2dN6WxiY353IYb+kGIqlPkFLOVekqWk123XSjM5hOwzSsZZpX5Lx2USbIPBTkl//XQaEV0iUVNAlD/hNVp31+1esW0gRAsdlWa7G9lP9cAcv7AQGWKT4xOJ45fIzqO3ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A6aWgw3C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J7lU1x004974;
	Mon, 19 Aug 2024 16:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=54Be2dpmjo9mL0wr244ka69/wSU
	0fU9DoCogHKtHckM=; b=A6aWgw3CTImKMCmjrzxMk7vyRW2qUN1We4H6sk1OuGC
	k7f+EvyCkg05ekTgRQmYHr4eXxfQPgHqIZJHqufZRh4Xafwi/yx33QLoeT03W99R
	D9Yuaoi4IDmY360vxi/I2j7uJxDJDc92ocT8oqmWsq8RmXDeT0/UKxaFm2XwLwG6
	oiypsocQV4XUjhrnRdxBlupmHk3Sx0txLtxhQvNytxQeIAZaaq2Te0MrvigYd549
	p2d7uMTF6gMiat3OD7rbl5aOo25eH8c0kKxGUtYzqBFotJPV7OxK8zoHeS48mdVB
	cUokkhuUlYC3yoW3pbGiWLhse07Se5tLvhvPCgMrnzA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y1j07m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 16:04:11 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47JG2kE8015393;
	Mon, 19 Aug 2024 16:04:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y1j07f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 16:04:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47JCvgFe019123;
	Mon, 19 Aug 2024 16:04:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41376ppubh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 16:04:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47JG43EM19071386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 16:04:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0CB72004D;
	Mon, 19 Aug 2024 16:04:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52E2020043;
	Mon, 19 Aug 2024 16:04:03 +0000 (GMT)
Received: from darkmoore (unknown [9.171.95.91])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 19 Aug 2024 16:04:03 +0000 (GMT)
Date: Mon, 19 Aug 2024 18:04:01 +0200
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: Hariharan Mari <hari55@linux.ibm.com>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v1 5/5] KVM: s390: selftests: Add regression tests for
 PLO subfunctions
Message-ID: <ZsNs8aIXM71NCG4h@darkmoore>
References: <20240819140040.1087552-1-hari55@linux.ibm.com>
 <20240819140040.1087552-6-hari55@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819140040.1087552-6-hari55@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ubtjICqUtKbAucfSvVCBuALIUaOVAKLr
X-Proofpoint-ORIG-GUID: -IznyxETvVyQV2-kCoIuZjbFi1H_ausN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190107

On Mon Aug 19, 2024 at 3:54 PM CEST, Hariharan Mari wrote:
> Extend the existing regression test framework for s390x CPU subfunctions
> to include tests for the Perform Locked Operation (PLO) subfunction
> functions.
>
> PLO was introduced in the very first 64-bit machine generation.
> Hence it is assumed PLO is always installed in the Z Arch.
> The test procedure follows the established pattern.
>
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Hariharan Mari <hari55@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  .../kvm/s390x/cpumodel_subfuncs_test.c        | 36 ++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
> index 901c99fe79d9..255984a52365 100644
> --- a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
> +++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
> @@ -20,6 +20,8 @@
>  
>  #include "kvm_util.h"
>  
> +#define U8_MAX  ((u8)~0U)
> +
>  /**
>   * Query available CPU subfunctions
>   */
> @@ -37,6 +39,33 @@ static void get_cpu_machine_subfuntions(struct kvm_vm *vm,
>  	TEST_ASSERT(!r, "Get cpu subfunctions failed r=%d errno=%d", r, errno);
>  }
>  
> +static inline int plo_test_bit(unsigned char nr)
> +{
> +	unsigned long function = (unsigned long)nr | 0x100;
> +	int cc;
> +
> +	asm volatile("	lgr	0,%[function]\n"
> +			/* Parameter registers are ignored for "test bit" */
> +			"	plo	0,0,0,0(0)\n"
> +			"	ipm	%0\n"
> +			"	srl	%0,28\n"
> +			: "=d" (cc)
> +			: [function] "d" (function)
> +			: "cc", "0");
> +	return cc == 0;
> +}
> +
> +/*
> + * Testing Perform Locked Operation (PLO) CPU subfunction's ASM block
> + */
> +static void test_plo_asm_block(u8 (*query)[32])
> +{
> +	for (int i = 0; i <= U8_MAX; ++i) {
> +		if (plo_test_bit(i))
> +			(*query)[i >> 3] |= 0x80 >> (i & 7);
> +	}
> +}
> +
>  /*
>   * Testing Crypto Compute Message Authentication Code (KMAC) CPU subfunction's
>   * ASM block
> @@ -235,8 +264,13 @@ struct testdef {
>  	u8 *subfunc_array;
>  	size_t array_size;
>  	testfunc_t test;
> -	bool facility_bit;
> +	int facility_bit;

Why change that to int here?

>  } testlist[] = {
> +	/*  PLO was introduced in the very first 64-bit machine generation.
> +	 *  Hence it is assumed PLO is always installed in Z Arch .
> +	 */
> +	{ "PLO", cpu_subfunc.plo, sizeof(cpu_subfunc.plo),
> +		test_plo_asm_block, 1 },
>  	/* MSA - Facility bit 17 */
>  	{ "KMAC", cpu_subfunc.kmac, sizeof(cpu_subfunc.kmac),
>  		test_kmac_asm_block, 17 },


