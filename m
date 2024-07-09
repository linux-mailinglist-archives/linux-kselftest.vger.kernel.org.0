Return-Path: <linux-kselftest+bounces-13385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BAE92C21A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D17429494A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C8318D4D6;
	Tue,  9 Jul 2024 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="STxGvSU1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1418D4A7;
	Tue,  9 Jul 2024 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544879; cv=none; b=bnkcBlRWKmQeUcrCgUQgVYSuA3eC9taXEYOui0+h1Ph0BTRHKotE5VbR/+SYg7fDN1a5TC0SG2c2l2zhaHqAEXUg7yn7a6X0zC99oNOsd1BERITihf4CTJlADaYNouoXA5YhdlvzCROgIX3oWu/xGZAZbQ34dvY5iRXzsTNl7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544879; c=relaxed/simple;
	bh=D1PAzJ30d51z8YYyUmPIWCn7aXus5Uw7VWiaB6oS7WA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j05NRWTdcHGa1qo0jNfmCJ3QT/WeLbu7xRi8JO5zpyrjNEgW2mrpKtUAFjaXEITy0IKPJfoMGY3LjR+mGQX8j8NrlgYAY8dhL93T7Bgy37B6bB3LQRVxjL9AXOSLHzWTp6vjAoAYh5XYjMnCFKb7B1lngenjFqCap2hryyelro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=STxGvSU1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469FxC7d024219;
	Tue, 9 Jul 2024 17:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	HR6voJurxzxO6sMBSkk9Y1/4XPHZjyVJJnzln51DFow=; b=STxGvSU15yFDqbIA
	rEwNvYb7FoSrKzdVYLof5VukHeM9mrvZMCtg2KbwWyZmgt6a11aIS+8UvXLfinUv
	ZROk0DjC7Yg778Zf0KVRqoYJew9mBCvrFFyDSloFcFyqO5ePxVirzHR6iTWnlFhW
	9DgI9qus9Ka8asjJpfaGM4wGwrl0cjvQ+Otdb3BbbN8ZKCe/I63NS2tlJ6nHp70X
	z9DN5rfbcnZ1K+1djmYDcVZYdTPUvV3pcgboKuI869OfcjVF5zSNCp7jfb8saIKn
	iiSiX0h7qUjkKaOfoaVdteLk5Ox1h/zB01hKMGxjhTPDS+veXAm4sX9DsfvSHVGx
	XAFbYw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4098aur80k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:45 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469H7jEg029982;
	Tue, 9 Jul 2024 17:07:45 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4098aur80h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 469GmKZB013998;
	Tue, 9 Jul 2024 17:07:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jy35beh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 17:07:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469H7c0C51773884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 17:07:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B93CB2004D;
	Tue,  9 Jul 2024 17:07:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 897032004B;
	Tue,  9 Jul 2024 17:07:38 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 17:07:38 +0000 (GMT)
Date: Tue, 9 Jul 2024 18:31:54 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah
 Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand
 <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v1 5/9] selftests: kvm: s390: Add debug print functions
Message-ID: <20240709183154.45770bdb@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <20240709125704.61312-6-schlameuss@linux.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
	<20240709125704.61312-6-schlameuss@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C2NXU-ObRDk9wRJjVMeBO2hn7Rl9-PlN
X-Proofpoint-ORIG-GUID: gGPi3iwiR6WyibLTKObT3604rAuKXtLN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090112

On Tue,  9 Jul 2024 14:57:00 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Add functions to simply print some basic state information in selftests.
> 
> The output can be enabled by setting:
> 
>     #define TH_LOG_ENABLED 1
>     #define DEBUG 1
> 
> * print_psw: current SIE state description and VM run state
> * print_hex_bytes: print memory with some counting markers
> * print_hex: PRINT_HEX with 512 bytes
> * print_run: use print_psw and print_hex to print contents of VM run
>   state and SIE state description
> * print_regs: print content of general and control registers
> 
> All prints use pr_debug for the output and can be configured using
> DEBUG.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>  .../selftests/kvm/include/s390x/debug_print.h | 78 +++++++++++++++++++
>  .../selftests/kvm/s390x/ucontrol_test.c       |  1 +
>  2 files changed, 79 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/include/s390x/debug_print.h
> 
> diff --git a/tools/testing/selftests/kvm/include/s390x/debug_print.h b/tools/testing/selftests/kvm/include/s390x/debug_print.h
> new file mode 100644
> index 000000000000..7cc21596398e
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/s390x/debug_print.h
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Definition for kernel virtual machines on s390x
> + *
> + * Copyright IBM Corp. 2024
> + *
> + * Authors:
> + *  Christoph Schlameuss <schlameuss@linux.ibm.com>
> + */
> +
> +#ifndef SELFTEST_KVM_DEBUG_PRINT_H
> +#define SELFTEST_KVM_DEBUG_PRINT_H
> +
> +#include "kvm_util.h"
> +#include "sie.h"
> +
> +static inline void print_hex_bytes(const char *name, u64 page, size_t len)

"page" is not an appropriate name, it's just an address, right? "addr"
seems a more appropriate name

> +{
> +	pr_debug("%s (%p)\t\t8-0x08  12-0x0c  16-0x10  20-0x14  24-0x18  28-0x1c",
> +		 name, (void *)page);
> +	for (u8 pp_row = 0; pp_row < (len / 32); pp_row++) {
> +		pr_debug("\n %3d 0x%.3x ", pp_row * 32, pp_row * 32);
> +		for (u8 pp_block = 0; pp_block < 8; pp_block++)
> +			pr_debug(" %8x", *(((u32 *)page) + 8 * pp_row + pp_block));

why not printing in blocks of 64 bits? 

> +	}
> +	pr_debug("\n");
> +}
> +
> +static inline void print_hex(const char *name, u64 page)

same here s/page/addr/

> +{
> +	print_hex_bytes(name, page, 512);
> +}
> +
> +static inline void print_psw(struct kvm_run *run, struct kvm_s390_sie_block *sie_block)
> +{
> +	pr_debug("flags:0x%x psw:0x%.16llx:0x%.16llx exit:%u %s\n",
> +		 run->flags,
> +		 run->psw_mask, run->psw_addr,
> +		 run->exit_reason, exit_reason_str(run->exit_reason));
> +	pr_debug("sie_block psw:0x%.16llx:0x%.16llx\n",
> +		 sie_block->psw_mask, sie_block->psw_addr);
> +}
> +
> +static inline void print_run(struct kvm_run *run, struct kvm_s390_sie_block *sie_block)
> +{
> +	print_hex("run", (u64)run);
> +	print_hex("sie_block", (u64)sie_block);
> +	print_psw(run, sie_block);
> +}
> +
> +static inline void print_regs(int vcpu_fd)
> +{
> +	struct kvm_sregs sregs = {};
> +	struct kvm_regs regs = {};
> +	int i;
> +
> +	if (ioctl(vcpu_fd, KVM_GET_REGS, &regs) != 0)
> +		TEST_FAIL("get regs failed, %s", strerror(errno));
> +	pr_debug("gprs:\n");

if you rewrite print_hex_bytes to print blocks of 8 bytes, you can
reuse it here:

> +	for (i = 0; i < 16; i += 4)
> +		pr_debug("0x%.16llx 0x%.16llx 0x%.16llx 0x%.16llx\n",
> +			 regs.gprs[i], regs.gprs[i + 1],
> +			 regs.gprs[i + 2], regs.gprs[i + 3]);
> +	if (ioctl(vcpu_fd, KVM_GET_SREGS, &sregs) != 0)
> +		TEST_FAIL("get sregs failed, %s", strerror(errno));
> +	pr_debug("acrs:\n");

acrs are 32 bits, you can print twice as many per row:

> +	for (i = 0; i < 16; i += 4)
> +		pr_debug("0x%.8x 0x%.8x 0x%.8x 0x%.8x\n",
> +			 sregs.acrs[i], sregs.acrs[i + 1],
> +			 sregs.acrs[i + 2], sregs.acrs[i + 3]);
> +	pr_debug("crs:\n");

and here you could reuse print_hex_bytes:

> +	for (i = 0; i < 16; i += 4)
> +		pr_debug("0x%.16llx 0x%.16llx 0x%.16llx 0x%.16llx\n",
> +			 sregs.crs[i], sregs.crs[i + 1],
> +			 sregs.crs[i + 2], sregs.crs[i + 3]);
> +}
> +
> +#endif /* SELFTEST_KVM_DEBUG_PRINT_H */
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index 44945af6d47d..5c009ee27fd2 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -7,6 +7,7 @@
>   * Authors:
>   *  Christoph Schlameuss <schlameuss@linux.ibm.com>
>   */
> +#include "debug_print.h"
>  #include "kselftest_harness.h"
>  #include "kvm_util.h"
>  #include "processor.h"


