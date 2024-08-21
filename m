Return-Path: <linux-kselftest+bounces-15866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7B295A1F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DCE1F21731
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B8214D428;
	Wed, 21 Aug 2024 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MamTlXXC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A802F52F6F;
	Wed, 21 Aug 2024 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255146; cv=none; b=WdUfTqX8siaHuKQPa8XZ/8ZPy3h0Ng/dTadA4xlPS3Tr+mN2MEaB5RSJf4rpFoH6uNWYyW9zm/jPXM5UcoyW+hZ/JekyaHEZ82WYVICLwL631V3wWsJlfUPLJowNfT7+e8cA02OzfxIt2AX2CqmrfYBeweFPnrKEZSvbsh57ZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255146; c=relaxed/simple;
	bh=5pVTdt78exiXheAi74dBDOfaaT6Rv96V6HoGPqVUhTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdMtpLj+wIr9QGOcOl4rhHro0l07nM7g5OAsKKgKxpxiViI9fATM+0BKyCa9O1Us3dK6aGuwaB/pC3uFxxqVPgzFVzKnV9pYUcsfWJOGXFMNIKyFgP6+m/8/FmSDmeIOu2Tzf0WCG3IkcOFkHB/zQpjsCjzj5sjli93Q5Xnfjg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MamTlXXC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L4saRR016931;
	Wed, 21 Aug 2024 15:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	cxpZaPV0gz0fieRNPwjQwRiJ+Zf1toAzeI43GjDXf/k=; b=MamTlXXCjYHHoEG3
	1BYBNNH3vwKkvhFcUBo/kn6su3ImfeJvkjbw/c81ZxS9Ov+C+JlvfBh4UxSxacRJ
	IUrk0QiusZ6l866hW4uZ6uOHd9nIsLwC0CNEWEEO6nKSL3qKlZe8YIguc0BtxvTH
	oba5fsCjszuVw0tOxj7ed7Nea8G6+zAGKSZUIIKW6AeicLJpZW1VRo2rMFLce46z
	9sqPYVT88eQhgghepIhMICTXshHwAK2WvGfhNkCPMX3A7fErTxj9DCxxdDPgZGvU
	fZ6sNYR50mTOy+3XTvmvE/mm/aSIKY+y8PXkbY1zkQyHHDmj7owr8qgfy7nkxljK
	STyjRQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma0bjyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 15:45:39 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47LFjcrL007502;
	Wed, 21 Aug 2024 15:45:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma0bjym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 15:45:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47LClB2I002256;
	Wed, 21 Aug 2024 15:45:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4136k0rk8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 15:45:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47LFjVEI55181814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 15:45:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9708120063;
	Wed, 21 Aug 2024 15:45:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 630A320040;
	Wed, 21 Aug 2024 15:45:31 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Aug 2024 15:45:31 +0000 (GMT)
Date: Wed, 21 Aug 2024 17:44:34 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Hariharan Mari <hari55@linux.ibm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, shuah@kernel.org, frankja@linux.ibm.com,
        borntraeger@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
        schlameuss@linux.ibm.com
Subject: Re: [PATCH v2 1/5] KVM: s390: selftests: Add regression tests for
 SORTL and DFLTCC CPU subfunctions
Message-ID: <20240821174434.2317a378@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240820065623.1140399-2-hari55@linux.ibm.com>
References: <20240820065623.1140399-1-hari55@linux.ibm.com>
 <20240820065623.1140399-2-hari55@linux.ibm.com>
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
X-Proofpoint-GUID: P99IBziMYinjniV-reOae3FxINKEcnCn
X-Proofpoint-ORIG-GUID: OhzMChJde3kgwZjxjulBWv6QGbfdEmPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210113

On Tue, 20 Aug 2024 08:48:33 +0200
Hariharan Mari <hari55@linux.ibm.com> wrote:

> Introduce new regression tests to verify the ASM inline block in the SORTL
> and DFLTCC CPU subfunctions for the s390x architecture. These tests ensure
> that future changes to the ASM code are properly validated.
> 
> The test procedure:
> 
> 1. Create a VM and request the KVM_S390_VM_CPU_MACHINE_SUBFUNC attribute
>    from the KVM_S390_VM_CPU_MODEL group for this VM. This SUBFUNC attribute
>    contains the results of all CPU subfunction instructions.
> 2. For each tested subfunction (SORTL and DFLTCC), execute the
>    corresponding ASM instruction and capture the result array.
> 3. Perform a memory comparison between the results stored in the SUBFUNC
>    attribute (obtained in step 1) and the ASM instruction results (obtained
>    in step 2) for each tested subfunction.
> 
> This process ensures that the KVM implementation accurately reflects the
> behavior of the actual CPU instructions for the tested subfunctions.
> 
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Hariharan Mari <hari55@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/include/s390x/facility.h    |  50 ++++++++
>  .../kvm/s390x/cpumodel_subfuncs_test.c        | 115 ++++++++++++++++++
>  3 files changed, 166 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/include/s390x/facility.h
>  create mode 100644 tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index ac280dcba996..9f418c594b55 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -183,6 +183,7 @@ TEST_GEN_PROGS_s390x += s390x/sync_regs_test
>  TEST_GEN_PROGS_s390x += s390x/tprot
>  TEST_GEN_PROGS_s390x += s390x/cmma_test
>  TEST_GEN_PROGS_s390x += s390x/debug_test
> +TEST_GEN_PROGS_s390x += s390x/cpumodel_subfuncs_test
>  TEST_GEN_PROGS_s390x += s390x/shared_zeropage_test
>  TEST_GEN_PROGS_s390x += demand_paging_test
>  TEST_GEN_PROGS_s390x += dirty_log_test
> diff --git a/tools/testing/selftests/kvm/include/s390x/facility.h b/tools/testing/selftests/kvm/include/s390x/facility.h
> new file mode 100644
> index 000000000000..65eef9a722ba
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/s390x/facility.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright IBM Corp. 2024
> + *
> + * Authors:
> + *  Hariharan Mari <hari55@linux.ibm.com>
> + *
> + *  Get the facility bits with the STFLE instruction
> + */
> +
> +#ifndef SELFTEST_KVM_FACILITY_H
> +#define SELFTEST_KVM_FACILITY_H
> +
> +#include <linux/bitops.h>
> +
> +#define NB_STFL_DOUBLEWORDS 32 /* alt_stfle_fac_list[16] + stfle_fac_list[16] */

in general it would be better if the comment is before the variable or
define

> +
> +uint64_t stfl_doublewords[NB_STFL_DOUBLEWORDS];
> +bool stfle_flag;

I'm not very happy of global variables defined in headers; as we
discussed offline, there are several possible solutions:

* just make them static
* put them in a separate .c in lib/s390x/
* do not use them at all, and simply call stfle every time

and probably there are also more solutions I did not think of

> +
> +static inline bool test_bit_inv(unsigned long nr,
> +				const unsigned long *ptr)

if I'm not mistaken, the column limit is 100 also for the selftests;
please fix that throughout the series, it will be more readable

> +{
> +	return test_bit(nr ^ (BITS_PER_LONG - 1), ptr);
> +}
> +
> +static inline void stfle(uint64_t *fac, unsigned int nb_doublewords)
> +{
> +	register unsigned long r0 asm("0") = nb_doublewords - 1;
> +
> +	asm volatile("	.insn	s,0xb2b00000,0(%1)\n"
> +			: "+d" (r0)
> +			: "a" (fac)
> +			: "memory", "cc");
> +}
> +
> +static inline void setup_facilities(void)
> +{
> +	stfle(stfl_doublewords, NB_STFL_DOUBLEWORDS);
> +	stfle_flag = true;
> +}
> +
> +static inline bool test_facility(int nr)
> +{
> +	if (!stfle_flag)
> +		setup_facilities();
> +	return test_bit_inv(nr, stfl_doublewords);
> +}
> +
> +#endif
> diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
> new file mode 100644
> index 000000000000..ea03ce2010bb
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright IBM Corp. 2024
> + *
> + * Authors:
> + *  Hariharan Mari <hari55@linux.ibm.com>
> + *
> + * The tests compare the result of the KVM ioctl for obtaining CPU subfunction
> + * data with those from an ASM block performing the same CPU subfunction.
> + * Currently KVM doesn't mask instruction query data reported via the CPU Model,
> + * allowing us to directly compare it with the data acquired through executing
> + * the queries in the test.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include "facility.h"
> +
> +#include "kvm_util.h"
> +
> +/**
> + * Query available CPU subfunctions
> + */
> +struct kvm_s390_vm_cpu_subfunc cpu_subfunc;
> +
> +static void get_cpu_machine_subfuntions(struct kvm_vm *vm,
> +					struct kvm_s390_vm_cpu_subfunc
> +					*cpu_subfunc)

here in particular you can see how ugly it looks with 80 columns :)

> +{
> +	int r;
> +
> +	r = __kvm_device_attr_get(vm->fd, KVM_S390_VM_CPU_MODEL,
> +				  KVM_S390_VM_CPU_MACHINE_SUBFUNC, cpu_subfunc);
> +
> +	TEST_ASSERT(!r, "Get cpu subfunctions failed r=%d errno=%d", r, errno);
> +}
> +
> +/*
> + * Testing Sort Lists (SORTL) CPU subfunction's ASM block
> + */
> +static void test_sortl_asm_block(u8 (*query)[32])
> +{
> +	asm volatile("	lghi	0,0\n"
> +			"	la	1,%[query]\n"
> +			"	.insn	rre,0xb9380000,2,4\n"
> +			: [query] "=R" (*query)
> +			:
> +			: "cc", "0", "1");
> +}
> +
> +/*
> + * Testing Deflate Conversion Call (DFLTCC) CPU subfunction's ASM block
> + */

there is no need to use multiline comments for a single line, unless
you want to use proper kdoc tags (which is definitely overkill for a
selftest)

> +static void test_dfltcc_asm_block(u8 (*query)[32])
> +{
> +	asm volatile("	lghi	0,0\n"
> +			"	la	1,%[query]\n"
> +			"	.insn	rrf,0xb9390000,2,4,6,0\n"
> +			: [query] "=R" (*query)
> +			:
> +			: "cc", "0", "1");
> +}
> +
> +typedef void (*testfunc_t)(u8 (*array)[]);
> +
> +struct testdef {
> +	const char *subfunc_name;
> +	u8 *subfunc_array;
> +	size_t array_size;
> +	testfunc_t test;
> +	int facility_bit;
> +} testlist[] = {
> +	/* SORTL - Facility bit 150 */
> +	{ "SORTL", cpu_subfunc.sortl, sizeof(cpu_subfunc.sortl),
> +		test_sortl_asm_block, 150 },

here as well, I think it fits in one line

> +	/* DFLTCC - Facility bit 151 */
> +	{ "DFLTCC", cpu_subfunc.dfltcc, sizeof(cpu_subfunc.dfltcc),
> +		test_dfltcc_asm_block, 151 },
> +};
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vm *vm;
> +	int idx;
> +
> +	ksft_print_header();
> +
> +	vm = vm_create(1);
> +
> +	memset(&cpu_subfunc, 0, sizeof(cpu_subfunc));
> +	get_cpu_machine_subfuntions(vm, &cpu_subfunc);
> +
> +	ksft_set_plan(ARRAY_SIZE(testlist));
> +	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
> +		if (test_facility(testlist[idx].facility_bit)) {
> +			u8 *array = malloc(testlist[idx].array_size);
> +
> +			testlist[idx].test((u8 (*)[testlist[idx].array_size])array);
> +
> +			TEST_ASSERT_EQ(memcmp(testlist[idx].subfunc_array,
> +					      array, testlist[idx].array_size), 0);
> +
> +			ksft_test_result_pass("%s\n", testlist[idx].subfunc_name);
> +			free(array);
> +		} else {
> +			ksft_test_result_skip("%s feature is not avaialable\n",
> +					      testlist[idx].subfunc_name);
> +		}
> +	}
> +
> +	kvm_vm_free(vm);
> +	ksft_finished();
> +}


