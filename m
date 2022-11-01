Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F89A614C27
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiKAOCf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiKAOCe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:02:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D531D1A396;
        Tue,  1 Nov 2022 07:02:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7360E6159E;
        Tue,  1 Nov 2022 14:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CC7C433D6;
        Tue,  1 Nov 2022 14:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667311350;
        bh=aZCgu4m6YVaQfw9jrn1zqs+zdDtcp3UPLh7KlkmZxQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJ1qPRW93E+z3I8eURkfRPQtK0UxqL18X315Ovu3QGQjPZfvq7sq9J+uDNvfh7yaG
         8IXjbfDRsqH2c45QY5lJy0txsGGWN2RM39l/8X/8ma/f6jXCav4q2cEHr7enZjr2Ab
         KdgkQcsZNibkRdGnoG8TYTKnJNNKFycqySwuert7h6NPhpKCO2TsSYAcAZ/Dij8CSa
         +eYn/+aX3MfNBrrJJ0WOkUOiONs+aU9Tef1eDXx7gYS4KFLVea3uOnL5PAhxgU8Ueb
         B2AbJA0xAQ0wmuQ5jpwSuFe8gkiOYMrGWghP5KPlcB4o5xwbMSJuMhREwxWG7MhMCl
         o1jNiQjWWBZ3w==
Date:   Tue, 1 Nov 2022 19:32:16 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Aman Gupta <aman1.gupta@samsung.com>
Cc:     shradha.t@samsung.com, pankaj.dubey@samsung.com, kishon@ti.com,
        lpieralisi@kernel.org, kw@linux.com, shuah@kernel.org,
        linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Message-ID: <20221101140216.GO54667@thinkpad>
References: <CGME20221007053726epcas5p357c35abb79327fee6327bc6493e0178c@epcas5p3.samsung.com>
 <20221007053934.5188-1-aman1.gupta@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221007053934.5188-1-aman1.gupta@samsung.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 07, 2022 at 11:09:34AM +0530, Aman Gupta wrote:
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
>  tools/testing/selftests/Makefile           |   1 +
>  tools/testing/selftests/pci/.gitignore     |   1 +
>  tools/testing/selftests/pci/Makefile       |   7 +
>  tools/testing/selftests/pci/pci-selftest.c | 167 +++++++++++++++++++++
>  4 files changed, 176 insertions(+)
>  create mode 100644 tools/testing/selftests/pci/.gitignore
>  create mode 100644 tools/testing/selftests/pci/Makefile
>  create mode 100644 tools/testing/selftests/pci/pci-selftest.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index c2064a35688b..81584169a80f 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -49,6 +49,7 @@ TARGETS += net/forwarding
>  TARGETS += net/mptcp
>  TARGETS += netfilter
>  TARGETS += nsfs
> +TARGETS += pci
>  TARGETS += pidfd
>  TARGETS += pid_namespace
>  TARGETS += powerpc
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

endpoint-test.c

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

Align '}'

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

Ininitialization not required here and also in other functions.

> +	int final = 0;
> +
> +	for (int i = 0; i <= 5; i++) {
> +		ret = ioctl(self->fd, PCITEST_BAR, i);
> +
> +		EXPECT_EQ(1, ret) {

The return value of all these IOCTL's are going to change when [1] get's merged.

[1] https://lore.kernel.org/linux-pci/20220824123010.51763-1-manivannan.sadhasivam@linaro.org/

I'd suggest to resubmit this selftest after that.

Thanks,
Mani

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
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
