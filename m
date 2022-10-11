Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB575FB0D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Oct 2022 12:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJKK7H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Oct 2022 06:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiJKK7G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Oct 2022 06:59:06 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CAC5282B;
        Tue, 11 Oct 2022 03:59:04 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29BAwqu7086784;
        Tue, 11 Oct 2022 05:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665485932;
        bh=0bcuz/1aO/u8pUu1ZydeV1qQ9w3qPRAKX9BMcN7JkMQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eb8iW6Yio4d87g6PiV27ZY2fERgF99CRTCSFCEpc+a2nEd2Ne2MlO7G2M3g1aN2q0
         M3c73WR8wlyNi7ZmxqL8z8VA9qtA6KeGzo7UbsZlQJpvlFeLIc5TFmPzEsdRNbKGZE
         +PGFSqaE7AHrzF8ansRgN0XczOG43oErkwwXpxa4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29BAwqwF104321
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Oct 2022 05:58:52 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 11
 Oct 2022 05:58:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 11 Oct 2022 05:58:52 -0500
Received: from [172.24.147.145] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29BAwnro051923;
        Tue, 11 Oct 2022 05:58:49 -0500
Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
To:     Aman Gupta <aman1.gupta@samsung.com>, <shradha.t@samsung.com>,
        <pankaj.dubey@samsung.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <shuah@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <CGME20221007053726epcas5p357c35abb79327fee6327bc6493e0178c@epcas5p3.samsung.com>
 <20221007053934.5188-1-aman1.gupta@samsung.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <fe40a005-b6a2-2938-576d-acf5432636b9@ti.com>
Date:   Tue, 11 Oct 2022 16:28:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20221007053934.5188-1-aman1.gupta@samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Mani

On 07/10/22 11:09 am, Aman Gupta wrote:
> This patch enables the support to perform selftest on PCIe endpoint
> driver present in the system. The following tests are currently
> performed by the selftest utility
> 
> 1. BAR Tests (BAR0 to BAR5)
> 2. MSI Interrupt Tests (MSI1 to MSI32)
> 3. Read Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> 4. Write Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> 5. Copy Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> 
> Signed-off-by: Aman Gupta <aman1.gupta@samsung.com>
> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> ---
>   tools/testing/selftests/Makefile           |   1 +
>   tools/testing/selftests/pci/.gitignore     |   1 +
>   tools/testing/selftests/pci/Makefile       |   7 +
>   tools/testing/selftests/pci/pci-selftest.c | 167 +++++++++++++++++++++
>   4 files changed, 176 insertions(+)
>   create mode 100644 tools/testing/selftests/pci/.gitignore
>   create mode 100644 tools/testing/selftests/pci/Makefile
>   create mode 100644 tools/testing/selftests/pci/pci-selftest.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index c2064a35688b..81584169a80f 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -49,6 +49,7 @@ TARGETS += net/forwarding
>   TARGETS += net/mptcp
>   TARGETS += netfilter
>   TARGETS += nsfs
> +TARGETS += pci
>   TARGETS += pidfd
>   TARGETS += pid_namespace
>   TARGETS += powerpc
> diff --git a/tools/testing/selftests/pci/.gitignore b/tools/testing/selftests/pci/.gitignore
> new file mode 100644
> index 000000000000..db01411b8200
> --- /dev/null
> +++ b/tools/testing/selftests/pci/.gitignore
> @@ -0,0 +1 @@
> +pci-selftest
> diff --git a/tools/testing/selftests/pci/Makefile b/tools/testing/selftests/pci/Makefile
> new file mode 100644
> index 000000000000..76b7725a45ae
> --- /dev/null
> +++ b/tools/testing/selftests/pci/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS += -O2 -Wl,-no-as-needed -Wall
> +LDFLAGS += -lrt -lpthread -lm
> +
> +TEST_GEN_PROGS = pci-selftest
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/pci/pci-selftest.c b/tools/testing/selftests/pci/pci-selftest.c
> new file mode 100644
> index 000000000000..73e8f3eb1982
> --- /dev/null
> +++ b/tools/testing/selftests/pci/pci-selftest.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI Endpoint Driver Test Program
> + *
> + * Copyright (c) 2022 Samsung Electronics Co., Ltd.
> + *             https://www.samsung.com
> + * Author: Aman Gupta <aman1.gupta@samsung.com>
> + */
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/ioctl.h>
> +#include <unistd.h>
> +
> +#include "../kselftest_harness.h"
> +
> +#define PCITEST_BAR		_IO('P', 0x1)
> +#define PCITEST_LEGACY_IRQ	_IO('P', 0x2)
> +#define PCITEST_MSI		_IOW('P', 0x3, int)
> +#define PCITEST_WRITE		_IOW('P', 0x4, unsigned long)
> +#define PCITEST_READ		_IOW('P', 0x5, unsigned long)
> +#define PCITEST_COPY		_IOW('P', 0x6, unsigned long)
> +#define PCITEST_MSIX		_IOW('P', 0x7, int)
> +#define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
> +#define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
> +#define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> +
> +static char *test_device = "/dev/pci-endpoint-test.0";
> +
> +struct xfer_param {
> +	unsigned long size;
> +	unsigned char flag;
> +	};
> +
> +FIXTURE(device)
> +{
> +	int fd;
> +};
> +
> +FIXTURE_SETUP(device)
> +{
> +
> +	self->fd = open(test_device, O_RDWR);
> +
> +	ASSERT_NE(-1, self->fd) {
> +		TH_LOG("Can't open PCI Endpoint Test device\n");
> +	}
> +}
> +
> +FIXTURE_TEARDOWN(device)
> +{
> +	close(self->fd);
> +}
> +
> +TEST_F(device, BAR_TEST)
> +{
> +	int ret = -EINVAL;
> +	int final = 0;
> +
> +	for (int i = 0; i <= 5; i++) {
> +		ret = ioctl(self->fd, PCITEST_BAR, i);
> +
> +		EXPECT_EQ(1, ret) {
> +			TH_LOG("TEST FAILED FOR BAR %d\n", i);
> +			final++;
> +		}
> +	}
> +
> +	ASSERT_EQ(0, final);
> +}
> +
> +TEST_F(device, MSI_TEST)
> +{
> +	int ret = -EINVAL;
> +	int final = 0;
> +
> +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> +	ASSERT_EQ(1, ret);
> +
> +	for (int i = 1; i <= 32; i++) {
> +		ret = ioctl(self->fd, PCITEST_MSI, i);
> +		EXPECT_EQ(1, ret) {
> +			TH_LOG("TEST FAILED FOR MSI%d\n", i);
> +			final++;
> +		}
> +	}
> +
> +	ASSERT_EQ(0, final);
> +}
> +
> +TEST_F(device, READ_TEST)
> +{
> +	int final = 0;
> +	int ret = -EINVAL;
> +	unsigned long SIZE[5] = {1, 1024, 1025, 1024000, 1024001};
> +
> +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> +	ASSERT_EQ(1, ret);
> +
> +	struct xfer_param param;
> +
> +	param.flag = 0;
> +	for (int i = 0; i < 5; i++) {
> +		param.size = SIZE[i];
> +		ret = ioctl(self->fd, PCITEST_READ, &param);
> +		EXPECT_EQ(1, ret) {
> +			TH_LOG("TEST FAILED FOR size =%ld.\n", SIZE[i]);
> +			final++;
> +		}
> +	}
> +
> +	ASSERT_EQ(0, final);
> +}
> +
> +TEST_F(device, WRITE_TEST)
> +{
> +	int final = 0;
> +	int ret = -EINVAL;
> +	unsigned long SIZE[5] = {1, 1024, 1025, 1024000, 1024001};
> +
> +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> +	ASSERT_EQ(1, ret);
> +
> +	struct xfer_param param;
> +
> +	param.flag = 0;
> +
> +	for (int i = 0; i < 5; i++) {
> +		param.size = SIZE[i];
> +		ret = ioctl(self->fd, PCITEST_WRITE, &param);
> +		EXPECT_EQ(1, ret) {
> +			TH_LOG("TEST FAILED FOR size =%ld.\n", SIZE[i]);
> +			final++;
> +		}
> +	}
> +
> +	ASSERT_EQ(0, final);
> +}
> +
> +TEST_F(device, COPY_TEST)
> +{
> +	int final = 0;
> +	int ret = -EINVAL;
> +	unsigned long SIZE[5] = {1, 1024, 1025, 1024000, 1024001};
> +
> +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> +	ASSERT_EQ(1, ret);
> +
> +	struct xfer_param param;
> +
> +	param.flag = 0;
> +
> +	for (int i = 0; i < 5; i++) {
> +		param.size = SIZE[i];
> +		ret = ioctl(self->fd, PCITEST_COPY, &param);
> +		EXPECT_EQ(1, ret) {
> +			TH_LOG("TEST FAILED FOR size =%ld.\n", SIZE[i]);
> +			final++;
> +		}
> +	}
> +
> +	ASSERT_EQ(0, final);
> +}
> +TEST_HARNESS_MAIN
> 
