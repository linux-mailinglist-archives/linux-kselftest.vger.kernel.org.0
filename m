Return-Path: <linux-kselftest+bounces-15867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4524695A1F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F165528E993
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8C71B5EC3;
	Wed, 21 Aug 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jYTBmT7B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB1C52F6F;
	Wed, 21 Aug 2024 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255158; cv=none; b=ahj/Ysgkxd8+Hu1iVjlV8t2bD19ZzqkAEYOernqd2W+G3IsnhGGACIDJdbX242XXDMm+X/P1xgplNWyMN+cnMqGVJ38tacna0UH3oojSnLhcb04H5Mw/yrXgsvw/30iZWObOp/Hd/DVVsIVB84vlk4Z6blxXOk+8CoU2rBBp1vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255158; c=relaxed/simple;
	bh=6xj/zioSJEpftwgsyPSVSuFpldC5b11lex7vr0onqm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVvWzilgM56PfRAyvF5AcLbS0zhRZX4zQAypTxPYtuCVr0/2PaUAPSOLIN9zTVVwOr8lw3NEklNh8YWVsSEsdGYN8NzEUETxTAjysiEaZ5w6j0g/jqMAS9SmEutmA7+kPRPPEe6x0IUfuwiczKv/Qy53HCWefeYFMc1LpWTxu0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jYTBmT7B; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LFT46h011379;
	Wed, 21 Aug 2024 15:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	H+21QL3gx86UBIxyLiP7A7YvG3rJ+T8UqdwWDM4MofA=; b=jYTBmT7BTUrZuseW
	mI/VeyiDrcUdpOxVjvNcO1xNIGVA3agOyee3o6IdXAgibTEOQ2eAGJxBhiznUWHY
	Zm0p3rC/zSA7ktvZcx1Y/I6qaN+wgRTX9zaKJdiL86TabY8Lg7yRgCk7sNfR+P2T
	CAWGut0a9iIWWueV0XE2Q7mBMhrbN54FwVrzSHS8mNzV142RZgxKUYZkhnQJir7q
	VhE85+w5nc0Ls+oTReMktIgks2vQhY2BkvRvCksyw1Pour2qBLoR19Ma6Bam27ox
	L9vMpTh14qKQ7TrwLmN1epxHia/v45bNVZkusrXHU339I6U0DYL5cHISkQBWUFtg
	gq2euQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc4twcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 15:45:39 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47LFjdEu025484;
	Wed, 21 Aug 2024 15:45:39 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc4twcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 15:45:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47LEPXV2017706;
	Wed, 21 Aug 2024 15:45:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138w383r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 15:45:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47LFjX0p16253428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 15:45:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2152320071;
	Wed, 21 Aug 2024 15:45:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4F7E2006C;
	Wed, 21 Aug 2024 15:45:32 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Aug 2024 15:45:32 +0000 (GMT)
Date: Wed, 21 Aug 2024 17:40:22 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Hariharan Mari <hari55@linux.ibm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, shuah@kernel.org, frankja@linux.ibm.com,
        borntraeger@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
        schlameuss@linux.ibm.com
Subject: Re: [PATCH v2 5/5] KVM: s390: selftests: Add regression tests for
 PLO subfunctions
Message-ID: <20240821174022.63ca2c6a@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240820065623.1140399-6-hari55@linux.ibm.com>
References: <20240820065623.1140399-1-hari55@linux.ibm.com>
	<20240820065623.1140399-6-hari55@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G3IgFnvVhSkhTvRxPDEeD5VqQ5VC8wOT
X-Proofpoint-GUID: 5VRrrnsmmnPpRU8furV9cDh03dL-fpcN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 adultscore=0 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210113

On Tue, 20 Aug 2024 08:48:37 +0200
Hariharan Mari <hari55@linux.ibm.com> wrote:

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
>  .../kvm/s390x/cpumodel_subfuncs_test.c        | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
> index c31f445c6f03..255984a52365 100644
> --- a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
> +++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
> @@ -20,6 +20,8 @@
>  
>  #include "kvm_util.h"
>  
> +#define U8_MAX  ((u8)~0U)

a more descriptive macro name would be better, maybe something like:

#define PLO_MAX_PARAMETER 255

the current macro is not much better than having just a magic number :)

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

I think the (unsigned long) cast is not needed

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
> @@ -237,6 +266,11 @@ struct testdef {
>  	testfunc_t test;
>  	int facility_bit;
>  } testlist[] = {
> +	/*  PLO was introduced in the very first 64-bit machine generation.

multi-line comments should not have text in the opening line 

> +	 *  Hence it is assumed PLO is always installed in Z Arch .
> +	 */
> +	{ "PLO", cpu_subfunc.plo, sizeof(cpu_subfunc.plo),
> +		test_plo_asm_block, 1 },
>  	/* MSA - Facility bit 17 */
>  	{ "KMAC", cpu_subfunc.kmac, sizeof(cpu_subfunc.kmac),
>  		test_kmac_asm_block, 17 },


