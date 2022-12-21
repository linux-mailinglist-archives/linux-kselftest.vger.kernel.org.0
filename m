Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB43B652DEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Dec 2022 09:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiLUIaU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Dec 2022 03:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiLUIaH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Dec 2022 03:30:07 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE62037C
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Dec 2022 00:30:05 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x66so10194754pfx.3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Dec 2022 00:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=frfzN6uzxKuFlIA4+uAAJAKmU4/TiLZEky6Q9V4EHls=;
        b=YxVCozZ/OiXZoKCffQ/7/VLyLPeNZWLabBVWhNG80D0/ifWtJnDxEUllcZdYpbGGTV
         2Rq+TRhgqKAIk4SLFuKWiy4AeNMzNvuK5UMlhnsRiwpQAHq0QSi0U58YRL7nOALoE4N1
         99N+TRzf18xN++6+BobNelw3oT9MFwGNbEptVe82CKx8kvt2Qib5JVt+oaY0bHgjy9i+
         AGSSvpQ8EfPvWxVq6x2Qds2I7diVoRPxV27cGK4GVSejTLDhQGDntlza4IKJpP0qrSzg
         6hwJdb1gWNpwM5WaGz4L7Yb/rXz17NwZSTgUgjoLlDboN3FaI3quHMT8kuLpFWmG1+bN
         XE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frfzN6uzxKuFlIA4+uAAJAKmU4/TiLZEky6Q9V4EHls=;
        b=Qcl7E2z8yFte1yBeuruLoA4InWqHyTf2x0C6FRPnu1ReDCHZRYkyqAg7bG1xtlvFdd
         37DqACK7SOsYMgyYzi8P4RIzoxakxVpPtjFCJ14GtQij4q8LTIg5354dKyyY1YC9BJPN
         +Qxk2yu5udh6QZQD5yicoqV36kdBnu83lBCvIPSe+Id29T/RDX1ucNNUQyD+VMhLWCsL
         0WBDDTGh7mabVJ1y1fH5JdYUxMBWN5rjE4ZqwU0NQOV64YTy8hNbfOVf4IbRMGaMvifr
         t0C2dKVKxr9nTM37Ec+UY/IaChGvoItfgLr6FsVn8r8p9tJvxW/YQQqoLVnUOEfHDsm7
         Tsgw==
X-Gm-Message-State: AFqh2kqz7m5PopahTPokmmhz/0Yqs5gnaLd08QKYI1saVpCumB8YN9XH
        3l5ZoncqO6EZ9p46Lt4NhMVfqQ==
X-Google-Smtp-Source: AMrXdXsJfv40/jw9500d7K5v2qz14fqmFwoEDRalvvmLS2G/yI5NN4VbyJ1RwMwDEhIgl0ymr8HOXQ==
X-Received: by 2002:a62:1c43:0:b0:577:c84d:cb81 with SMTP id c64-20020a621c43000000b00577c84dcb81mr1425117pfc.16.1671611405206;
        Wed, 21 Dec 2022 00:30:05 -0800 (PST)
Received: from [10.16.128.218] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id x27-20020aa7957b000000b00576670cc170sm10188259pfq.93.2022.12.21.00.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 00:30:04 -0800 (PST)
Message-ID: <7d982a83-a841-ca56-20cc-cb5373a4bcdc@igel.co.jp>
Date:   Wed, 21 Dec 2022 17:30:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Content-Language: en-US
To:     Aman Gupta <aman1.gupta@samsung.com>, shradha.t@samsung.com,
        pankaj.dubey@samsung.com, kishon@ti.com, lpieralisi@kernel.org,
        kw@linux.com, shuah@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
References: <CGME20221007053726epcas5p357c35abb79327fee6327bc6493e0178c@epcas5p3.samsung.com>
 <20221007053934.5188-1-aman1.gupta@samsung.com>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <20221007053934.5188-1-aman1.gupta@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Aman,

It is a nice work.

On 2022/10/07 14:39, Aman Gupta wrote:
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
This test is for a pci endpoint test driver. so I think it should be 
located on tools/testing/selftest/drivers/pci/endpoint. What do you think?
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


Best,

Shunsuke

