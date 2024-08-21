Return-Path: <linux-kselftest+bounces-15827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDEC95960A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 09:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617091C202F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 07:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634FA1B81AD;
	Wed, 21 Aug 2024 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q191EeCf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A015C1B81A3;
	Wed, 21 Aug 2024 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225148; cv=none; b=TjK7dJHUkp8BK0RDuwcIbAttAwzFahYPqN4h1GV2BSYe7mfM7l5rX57s79raDqJVrjdQVTMVL0+HoBZO35cWN/UwsEn0tK5k2GvQtlOo/ZaMedN+Rt0Kbb0lVpuLDA7HdKi7pc2WYE9l+lD3FeRF/IyCl6a8XG6rgqTY1ZfA13A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225148; c=relaxed/simple;
	bh=W5xplFs9GxuHiXVgy6uaGpu0Zl7R3txiOH2QSTtLSDw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=pb0Fm6tgNs0huO3Lp+UDFRbC9s+WL4rFFWR9k1n0Rk06dr1jZj92RVnD+UW1Z96Du50m5gbAxkbRKKMRulvRMMQQTAzSGGs7nlOQiM+a9kvwOV3e5hAExX2oXU0Yc2UNN/Gyu6O27AVzO2d9XjQoSAGb0tPMfPhKfP0FnYIRIO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q191EeCf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L2fATV011138;
	Wed, 21 Aug 2024 07:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	mime-version:content-transfer-encoding:content-type:date
	:message-id:cc:to:subject:from:references:in-reply-to; s=pp1;
	 bh=jKAJPPCspbwmQne/HWzINc4qJISbMUjAY762EEt7r3w=; b=Q191EeCfcSkF
	DRv9Fx4vF730GejJu/QFrCjy/+mDopufHzeiv9D418P/EIlCg2Qd4UqgmhFxp705
	X0xGwsadoxlkX380c5xUS8Myi2phvUhUYrhffZPc56fpdCr+anTugn324uzBXVtE
	VlQgllu7sSk5FV0XHyFym6R0nulDVSwK1iCKFUCtMyw+Dn/b/KUCeD7hKFa9f8JN
	MwFklpojJfi30XoetzSLTJwx1T2ZWJ8o9q5LLWLjqnMdbMXEkSo1ku4cmV0m+2cQ
	iSAxkbj55VxO1Pqp6URHiRAb40RWXbIYPQ9ZYI4K+pMhaDBSHWRbktFSL780pAxc
	KrPlpY13Bw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc4rxaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:25:42 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47L7LWdu007869;
	Wed, 21 Aug 2024 07:25:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc4rxa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:25:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47L3DTKn013499;
	Wed, 21 Aug 2024 07:25:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41366u6vfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:25:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47L7PZKp22675726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 07:25:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D528420040;
	Wed, 21 Aug 2024 07:25:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4DD120049;
	Wed, 21 Aug 2024 07:25:35 +0000 (GMT)
Received: from darkmoore (unknown [9.171.47.216])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Aug 2024 07:25:35 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Aug 2024 09:25:30 +0200
Message-Id: <D3LESPV4T4VI.351GGFRASS1X7@linux.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <shuah@kernel.org>,
        <frankja@linux.ibm.com>, <borntraeger@linux.ibm.com>,
        <imbrenda@linux.ibm.com>, <david@redhat.com>, <pbonzini@redhat.com>
To: "Hariharan Mari" <hari55@linux.ibm.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] KVM: s390: selftests: Add regression tests for
 PLO subfunctions
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.17.0
References: <20240820065623.1140399-1-hari55@linux.ibm.com>
 <20240820065623.1140399-6-hari55@linux.ibm.com>
In-Reply-To: <20240820065623.1140399-6-hari55@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b9MLC2PqX3oQ89UVpNnxasdnXTW2PHp8
X-Proofpoint-GUID: DpIaYRh5NiLWWlhamsNjfMqUex9VhbpT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 adultscore=0 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210050

On Tue Aug 20, 2024 at 8:48 AM CEST, Hariharan Mari wrote:
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

LGTM (apart from the accidental whitespace)

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  .../kvm/s390x/cpumodel_subfuncs_test.c        | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b=
/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
> index c31f445c6f03..255984a52365 100644
> --- a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
> +++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
> @@ -20,6 +20,8 @@
> =20
>  #include "kvm_util.h"
> =20
> +#define U8_MAX  ((u8)~0U)
> +
>  /**
>   * Query available CPU subfunctions
>   */
> @@ -37,6 +39,33 @@ static void get_cpu_machine_subfuntions(struct kvm_vm =
*vm,
>  	TEST_ASSERT(!r, "Get cpu subfunctions failed r=3D%d errno=3D%d", r, err=
no);
>  }
> =20
> +static inline int plo_test_bit(unsigned char nr)
> +{
> +	unsigned long function =3D (unsigned long)nr | 0x100;
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
> +/*
> + * Testing Perform Locked Operation (PLO) CPU subfunction's ASM block
> + */
> +static void test_plo_asm_block(u8 (*query)[32])
> +{
> +	for (int i =3D 0; i <=3D U8_MAX; ++i) {
> +		if (plo_test_bit(i))
> +			(*query)[i >> 3] |=3D 0x80 >> (i & 7);
> +	}
> +}
> +
>  /*
>   * Testing Crypto Compute Message Authentication Code (KMAC) CPU subfunc=
tion's
>   * ASM block
> @@ -237,6 +266,11 @@ struct testdef {
>  	testfunc_t test;
>  	int facility_bit;
>  } testlist[] =3D {
> +	/*  PLO was introduced in the very first 64-bit machine generation.
> +	 *  Hence it is assumed PLO is always installed in Z Arch .
                                                                 ^
accidental whitespace

> +	 */
> +	{ "PLO", cpu_subfunc.plo, sizeof(cpu_subfunc.plo),
> +		test_plo_asm_block, 1 },
>  	/* MSA - Facility bit 17 */
>  	{ "KMAC", cpu_subfunc.kmac, sizeof(cpu_subfunc.kmac),
>  		test_kmac_asm_block, 17 },


