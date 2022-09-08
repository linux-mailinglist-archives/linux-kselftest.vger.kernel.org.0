Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D8E5B2056
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiIHORt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 10:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIHORq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 10:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22D7ABD72
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Sep 2022 07:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662646663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0Xf16e1tUEayoMjvlkSUOyIk9PvEr4hCjhhbqCpARE=;
        b=CsCmD7X8K+ROG7Q3e80CUd3awYeUbmqNtC+i0kBEfGbbQ2U6tTtDGhC3hG7SsYOttLrgHI
        SewCGEwjpiPsXY3kfQIcoWn5Ph/k6s75ZBhM5y87DhFpDdwFXF2BM/qWqb914/Ym+kTSjl
        Mj1y5n/DNS4MkYEkMUwALte2U3eZA8I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-_E6nKz5EO-G178cbr83ZCw-1; Thu, 08 Sep 2022 10:17:37 -0400
X-MC-Unique: _E6nKz5EO-G178cbr83ZCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D02228F6782;
        Thu,  8 Sep 2022 14:16:58 +0000 (UTC)
Received: from fedora (unknown [10.22.17.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C12462026D4C;
        Thu,  8 Sep 2022 14:16:53 +0000 (UTC)
Date:   Thu, 8 Sep 2022 11:16:52 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v12 2/3] selftests: tdx: Test TDX attestation GetReport
 support
Message-ID: <Yxn5VDzJMUxSKz0Z@fedora>
References: <20220908002723.923241-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220908002723.923241-3-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220908002723.923241-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 07, 2022 at 05:27:21PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Attestation is used to verify the trustworthiness of a TDX guest.
> During the guest bring-up, Intel TDX module measures and records
> the initial contents and configuration of the guest, and at runtime,
> guest software uses runtime measurement registers (RMTRs) to measure
> and record details related to kernel image, command line params, ACPI
> tables, initrd, etc. At TDX guest runtime, Intel SGX attestation
> infrastructure is re-used to attest to these measurement data.
> 
> First step in the TDX attestation process is to get the TDREPORT data.
> It is a fixed size data structure generated by the TDX module which
> includes the above mentioned measurements data, a MAC to protect the
> integerity of the TDREPORT, and a 64-Byte of user specified data passed
> during TDREPORT request which can uniquely identify the TDREPORT.
> 
> Intel's TDX guest driver exposes TDX_CMD_GET_REPORT IOCTL interface to
> get the TDREPORT from the user space.
> 
> Add a kernel selftest module to test this ABI and verify the validity
> of generated TDREPORT.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v11:
>  * Renamed devname with TDX_GUEST_DEVNAME.
> 
> Changes since v10:
>  * Replaced TD/TD Guest usage with guest or TDX guest.
>  * Reworded the subject line.
> 
> Changes since v9:
>  * Copied arch/x86/include/uapi/asm/tdx.h to tools/arch/x86/include to
>    decouple header dependency between kernel source and tools dir.
>  * Fixed Makefile to adapt to above change.
>  * Fixed commit log and comments.
>  * Added __packed to hardware structs.
> 
> Changes since v8:
>  * Please refer to https://lore.kernel.org/all/ \
>    20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com/
> 
>  tools/arch/x86/include/uapi/asm/tdx.h         |  54 ++++++
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/tdx/Makefile          |  11 ++
>  tools/testing/selftests/tdx/config            |   1 +
>  tools/testing/selftests/tdx/tdx_attest_test.c | 155 ++++++++++++++++++
>  5 files changed, 222 insertions(+)
>  create mode 100644 tools/arch/x86/include/uapi/asm/tdx.h
>  create mode 100644 tools/testing/selftests/tdx/Makefile
>  create mode 100644 tools/testing/selftests/tdx/config
>  create mode 100644 tools/testing/selftests/tdx/tdx_attest_test.c
> 
> diff --git a/tools/arch/x86/include/uapi/asm/tdx.h b/tools/arch/x86/include/uapi/asm/tdx.h
> new file mode 100644
> index 000000000000..29d8e38f226a
> --- /dev/null
> +++ b/tools/arch/x86/include/uapi/asm/tdx.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_ASM_X86_TDX_H
> +#define _UAPI_ASM_X86_TDX_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define TDX_GUEST_DEVICE		"tdx-guest"
> +
> +/* Length of the REPORTDATA used in TDG.MR.REPORT TDCALL */
> +#define TDX_REPORTDATA_LEN              64
> +
> +/* Length of TDREPORT used in TDG.MR.REPORT TDCALL */
> +#define TDX_REPORT_LEN                  1024
> +
> +/**
> + * struct tdx_report_req: Get TDREPORT using REPORTDATA as input.
> + *
> + * @reportdata     : User-defined REPORTDATA to be included into
> + *                   TDREPORT. Typically it can be some nonce
> + *                   provided by attestation service, so the
> + *                   generated TDREPORT can be uniquely verified.
> + * @tdreport       : TDREPORT output from TDCALL[TDG.MR.REPORT].
> + * @rpd_len        : Length of the REPORTDATA (fixed as 64 bytes by
> + *                   the TDX Module specification, but parameter is
> + *                   added to handle future extension).
> + * @tdr_len        : Length of the TDREPORT (fixed as 1024 bytes by
> + *                   the TDX Module specification, but a parameter
> + *                   is added to accommodate future extension).
> + * @subtype        : Subtype of TDREPORT (fixed as 0 by TDX Module
> + *                   specification, but added a parameter to handle
> + *                   future extension).
> + *
> + * Used in TDX_CMD_GET_REPORT IOCTL request.
> + */
> +struct tdx_report_req {
> +	__u64 reportdata;
> +	__u64 tdreport;
> +	__u32 rpd_len;
> +	__u32 tdr_len;
> +	__u8  subtype;
> +	__u8 reserved[7];
> +};
> +
> +/*
> + * TDX_CMD_GET_REPORT - Get TDREPORT using TDCALL[TDG.MR.REPORT]
> + *
> + * Return 0 on success, -EIO on TDCALL execution failure, and
> + * standard errno on other general error cases.
> + *
> + */
> +#define TDX_CMD_GET_REPORT		_IOWR('T', 0x01, __u64)
> +
> +#endif /* _UAPI_ASM_X86_TDX_H */
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 10b34bb03bc1..22bdb3d848f5 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -70,6 +70,7 @@ TARGETS += sync
>  TARGETS += syscall_user_dispatch
>  TARGETS += sysctl
>  TARGETS += tc-testing
> +TARGETS += tdx
>  TARGETS += timens
>  ifneq (1, $(quicktest))
>  TARGETS += timers
> diff --git a/tools/testing/selftests/tdx/Makefile b/tools/testing/selftests/tdx/Makefile
> new file mode 100644
> index 000000000000..014795420184
> --- /dev/null
> +++ b/tools/testing/selftests/tdx/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +top_srcdir = ../../../..
> +
> +LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/x86/include
> +
> +CFLAGS += -O3 -Wl,-no-as-needed -Wall -static -I$(LINUX_TOOL_ARCH_INCLUDE)
> +
> +TEST_GEN_PROGS := tdx_attest_test
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/tdx/config b/tools/testing/selftests/tdx/config
> new file mode 100644
> index 000000000000..1340073a4abf
> --- /dev/null
> +++ b/tools/testing/selftests/tdx/config
> @@ -0,0 +1 @@
> +CONFIG_INTEL_TDX_GUEST=y
> diff --git a/tools/testing/selftests/tdx/tdx_attest_test.c b/tools/testing/selftests/tdx/tdx_attest_test.c
> new file mode 100644
> index 000000000000..b7974050e3cf
> --- /dev/null
> +++ b/tools/testing/selftests/tdx/tdx_attest_test.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test TDX attestation
> + *
> + * Copyright (C) 2022 Intel Corporation. All rights reserved.
> + *
> + * Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> + */
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/ioctl.h>
> +#include <sys/types.h>
> +#include <uapi/asm/tdx.h>
> +
> +#include "../kselftest_harness.h"
> +
> +#define TDX_GUEST_DEVNAME "/dev/"TDX_GUEST_DEVICE
> +#define HEX_DUMP_SIZE	8
> +#define __packed       __attribute__((packed))
> +
> +/*
> + * Trusted Execution Environment (TEE) report (TDREPORT_STRUCT) type,
> + * sub type and version. More details can be found in TDX v1.0 Module
> + * specification, sec titled "REPORTTYPE".
> + */
> +struct tdreport_type {
> +	/* 0 - SGX, 81 -TDX, rest are reserved */
> +	__u8 type;
> +	/* Default value is 0 */
> +	__u8 sub_type;
> +	/* Default value is 0 */
> +	__u8 version;
> +	__u8 reserved;
> +}  __packed;
> +
> +/*
> + * struct reportmac - First field in the TRDREPORT_STRUCT. It is common
> + * to Intel’s TEE's e.g., SGX and TDX. It is MAC-protected and contains
> + * hashes of the remainder of the report structure which includes the
> + * TEE’s measurements, and where applicable, the measurements of additional
> + * TCB elements not reflected in CPUSVN – e.g., a SEAM’s measurements.
> + * More details can be found in TDX v1.0 Module specification, sec titled
> + * "REPORTMACSTRUCT"
> + */
> +struct reportmac {
> +	struct tdreport_type type;
> +	__u8 reserved1[12];
> +	/* CPU security version */
> +	__u8 cpu_svn[16];
> +	/* SHA384 hash of TEE TCB INFO */
> +	__u8 tee_tcb_info_hash[48];
> +	/* SHA384 hash of TDINFO_STRUCT */
> +	__u8 tee_td_info_hash[48];
> +	/* User defined unique data passed in TDG.MR.REPORT request */
> +	__u8 reportdata[64];
> +	__u8 reserved2[32];
> +	__u8 mac[32];
> +}  __packed;
> +
> +/*
> + * struct td_info - It contains the measurements and initial configuration
> + * of the TDX Guest that was locked at initialization and a set of measurement
> + * registers that are run-time extendable. These values are copied from
> + * the TDCS by the TDG.MR.REPORT function. More details can be found in
> + * TDX v1.0 Module specification, sec titled "TDINFO_STRUCT".
> + */
> +struct td_info {
> +	/* TDX Guest attributes (like debug, spet_disable, etc) */
> +	__u8 attr[8];
> +	__u64 xfam;
> +	/* Measurement registers */
> +	__u64 mrtd[6];
> +	__u64 mrconfigid[6];
> +	__u64 mrowner[6];
> +	__u64 mrownerconfig[6];
> +	/* Runtime measurement registers */
> +	__u64 rtmr[24];
> +	__u64 reserved[14];
> +} __packed;
> +
> +struct tdreport {
> +	/* Common to TDX/SGX of size 256 bytes */
> +	struct reportmac reportmac;
> +	__u8 tee_tcb_info[239];
> +	__u8 reserved[17];
> +	/* Measurements and configuration data of size 512 byes */
> +	struct td_info tdinfo;
> +}  __packed;
> +
> +#ifdef DEBUG
> +static void print_array_hex(const char *title, const char *prefix_str,
> +		const void *buf, int len)
> +{
> +	const __u8 *ptr = buf;
> +	int i, rowsize = HEX_DUMP_SIZE;
> +
> +	if (!len || !buf)
> +		return;
> +
> +	printf("\t\t%s", title);
> +
> +	for (i = 0; i < len; i++) {
> +		if (!(i % rowsize))
> +			printf("\n%s%.8x:", prefix_str, i);
> +		printf(" %.2x", ptr[i]);
> +	}
> +
> +	printf("\n");
> +}
> +#endif
> +
> +TEST(verify_report)
> +{
> +	__u8 reportdata[TDX_REPORTDATA_LEN];
> +	struct tdreport tdreport;
> +	struct tdx_report_req req;
> +	int devfd, i;
> +
> +	devfd = open(TDX_GUEST_DEVNAME, O_RDWR | O_SYNC);
> +
> +	ASSERT_LT(0, devfd);
> +
> +	/* Generate sample report data */
> +	for (i = 0; i < TDX_REPORTDATA_LEN; i++)
> +		reportdata[i] = i;
> +
> +	/* Initialize IOCTL request */
> +	req.subtype     = 0;
> +	req.reportdata  = (__u64)reportdata;
> +	req.rpd_len     = TDX_REPORTDATA_LEN;
> +	req.tdreport    = (__u64)&tdreport;
> +	req.tdr_len     = sizeof(tdreport);
> +
> +	/* Get TDREPORT */
> +	ASSERT_EQ(0, ioctl(devfd, TDX_CMD_GET_REPORT, &req));
> +
> +#ifdef DEBUG
> +	print_array_hex("\n\t\tTDX report data\n", "",
> +			reportdata, sizeof(reportdata));
> +
> +	print_array_hex("\n\t\tTDX tdreport data\n", "",
> +			&tdreport, sizeof(tdreport));
> +#endif

You can unconditionally define print_array_hex, and
use `if (DEBUG)` instead of #ifdef `DEBUG here`. The compiler
will get rid of the unused code when DEBUG is not defined
as expected, but you get the parser to validate it
independent of the definition of DEBUG.

> +
> +	/* Make sure TDREPORT data includes the REPORTDATA passed */
> +	ASSERT_EQ(0, memcmp(&tdreport.reportmac.reportdata[0],
> +			    reportdata, sizeof(reportdata)));
> +
> +	ASSERT_EQ(0, close(devfd));
> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 
> 

