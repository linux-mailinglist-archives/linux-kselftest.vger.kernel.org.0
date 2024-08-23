Return-Path: <linux-kselftest+bounces-16154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D318395CE80
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 15:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0433F1C22A74
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FAE18859D;
	Fri, 23 Aug 2024 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lg+KsNiV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D68188593;
	Fri, 23 Aug 2024 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421481; cv=none; b=ktOe06xqt1h2OWQzq9jng8RFs1rzULZwTavI9WUzNORb5TvT9PlC/09ZLx90LFBhQCyUB+HdN+KxZiayLYM88CLIGR9FspZJdXwQF3XKNkHn0Hg+GdF+Rufs01L/fxRxvYG5FTzSFHxrvydexvj1yfBUGqzAuZAUVn2AHFQeWdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421481; c=relaxed/simple;
	bh=xQPnZ8W32sDl4wNzWjiG9LXxKgrpiFGgtEis6Xo2Lxs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:Cc:To:
	 References:In-Reply-To; b=ZwhFjH/G9D5vZeYgT7HRdB3cuSEN9kvoUbwkfrBONe89nhZOVJkb8RDk/HRkCYUR+BJfE/WV2wa48s9QOtNyxcHNAQBjmTvBiKzvYkB6DhnameXoSF2DN1poMGjMsne4Nf9h3+2vUgNMacOmYDxyoF6Uiv3r0uKOttFrZSaXiE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lg+KsNiV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N6edqM005285;
	Fri, 23 Aug 2024 13:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:subject:from:cc:to:references:in-reply-to; s=pp1;
	 bh=CL9e6c4NVt96VpMFW1BS0QLB3uYCWbXLJv5FCaiWfsQ=; b=lg+KsNiV3L8U
	RhyM67d8l0eBQih03wfT2oqgFkIfQxIGU/Mt87P8YEon9S9K1Ykxe7JpryT2J81F
	uqGg16XkcokQ9/+UHWAJT6Z0rA38cRHq2AMwSxSWqG9hhb9NAOMvFcY5GUouE4Hj
	H6k7GtMqk0FVdJdx6SCeEbwxm7WifdnMxkV94LdiCRT9ABB3dc+q/HGGd/MgouNW
	cG9D/gn1TWJiWWvJKToSAckJqUriAM8zk9bY1LrpqwkEuO3QsS0vhsM0DNEmE+AA
	eaoDRb8hks4P27v1gytSXejwPVzYqY3dC1kRWjagzGK9hS3Ojk7nwN/4Aqe8CuiT
	Ug0IExqFMw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb656ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:57:54 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47NDvsEg014434;
	Fri, 23 Aug 2024 13:57:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb656g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:57:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47NB0i9m019105;
	Fri, 23 Aug 2024 13:57:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41376qa5h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:57:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47NDvlPi14549434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 13:57:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23F4A2005A;
	Fri, 23 Aug 2024 13:57:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E49902004B;
	Fri, 23 Aug 2024 13:57:46 +0000 (GMT)
Received: from darkmoore (unknown [9.171.45.196])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Aug 2024 13:57:46 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Aug 2024 15:57:41 +0200
Message-Id: <D3NCE36F09WE.18YM4PED9CTGF@linux.ibm.com>
Subject: Re: [PATCH v3 5/5] KVM: s390: selftests: Add regression tests for
 PLO subfunctions
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <shuah@kernel.org>,
        <frankja@linux.ibm.com>, <borntraeger@linux.ibm.com>,
        <imbrenda@linux.ibm.com>, <david@redhat.com>, <pbonzini@redhat.com>
To: "Hariharan Mari" <hari55@linux.ibm.com>, <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240823130947.38323-1-hari55@linux.ibm.com>
 <20240823130947.38323-6-hari55@linux.ibm.com>
In-Reply-To: <20240823130947.38323-6-hari55@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nQQ-YW8oV9XxOs8HESfLtdVrKmfr56xy
X-Proofpoint-GUID: zEVmvc18RV8ju2HWZqcG8Q7OGykI1Dvu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408230099

On Fri Aug 23, 2024 at 3:05 PM CEST, Hariharan Mari wrote:
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

LGTM

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  .../kvm/s390x/cpumodel_subfuncs_test.c        | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b=
/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
> index fe45fb131583..222ba1cc3cac 100644
> --- a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
> +++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
> @@ -19,6 +19,8 @@
> =20
>  #include "kvm_util.h"
> =20
> +#define PLO_FUNCTION_MAX 256
> +
>  /* Query available CPU subfunctions */
>  struct kvm_s390_vm_cpu_subfunc cpu_subfunc;
> =20
> @@ -33,6 +35,31 @@ static void get_cpu_machine_subfuntions(struct kvm_vm =
*vm,
>  	TEST_ASSERT(!r, "Get cpu subfunctions failed r=3D%d errno=3D%d", r, err=
no);
>  }
> =20
> +static inline int plo_test_bit(unsigned char nr)
> +{
> +	unsigned long function =3D nr | 0x100;
> +	int cc;
> +
> +	asm volatile("	lgr	0,%[function]\n"
> +			/* Parameter registers are ignored for "test bit" */
> +			"	plo	0,0,0,0(0)\n"
> +			"	ipm	%0\n"
> +			"	srl	%0,28\n"
> +			: "=3Dd" (cc)
> +			: [function] "d" (function)
> +			: "cc", "0");
> +	return cc =3D=3D 0;
> +}
> +
> +/* Testing Perform Locked Operation (PLO) CPU subfunction's ASM block */
> +static void test_plo_asm_block(u8 (*query)[32])
> +{
> +	for (int i =3D 0; i < PLO_FUNCTION_MAX; ++i) {
> +		if (plo_test_bit(i))
> +			(*query)[i >> 3] |=3D 0x80 >> (i & 7);
> +	}
> +}
> +
>  /* Testing Crypto Compute Message Authentication Code (KMAC) CPU subfunc=
tion's ASM block */
>  static void test_kmac_asm_block(u8 (*query)[16])
>  {
> @@ -196,6 +223,11 @@ struct testdef {
>  	testfunc_t test;
>  	int facility_bit;
>  } testlist[] =3D {
> +	/*
> +	 * PLO was introduced in the very first 64-bit machine generation.
> +	 * Hence it is assumed PLO is always installed in Z Arch.
> +	 */
> +	{ "PLO", cpu_subfunc.plo, sizeof(cpu_subfunc.plo), test_plo_asm_block, =
1 },
>  	/* MSA - Facility bit 17 */
>  	{ "KMAC", cpu_subfunc.kmac, sizeof(cpu_subfunc.kmac), test_kmac_asm_blo=
ck, 17 },
>  	{ "KMC", cpu_subfunc.kmc, sizeof(cpu_subfunc.kmc), test_kmc_asm_block, =
17 },


