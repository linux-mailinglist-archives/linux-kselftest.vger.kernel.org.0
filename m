Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7593460718B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 10:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJUIAY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 04:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJUIAX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 04:00:23 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64BE15CB09
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Oct 2022 01:00:20 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g129so257836pgc.7
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Oct 2022 01:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Af64HsW8Hb3IJa0+V6qoz6cLtuntZ5l3rMcrmMxUOek=;
        b=ZFQOQ+i0+gxqjtqEyGfjrYUT1cFe7ehfq6Aqb1a109g6ZvyEW487gDPEwXJap00wgT
         r9DQqgK43+ngqcsqL5DZPEKR1QAn9pBIFHRoMNGWm8EJ2nKKJu5spz/s0FGP76pRq3Oi
         1l4caFXtTm4xGRSoe22tKlgJeV6fYUOFGQRtJvlrCORSJY9VM7rPy1v1pSuAqstv1PEU
         ami7MC/c0J66v1Z6kf4tFMd/eKxjxBjrVLA/A+5FGb77Q6R5ec8sukzfmGymXlOBbdwa
         H6IBvnli/6+1aD2Uha35Ate16rLhFlG3WYRzocWiZ9dZWk7c5cw1UgbMQmKRCVHhm4dN
         7McQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Af64HsW8Hb3IJa0+V6qoz6cLtuntZ5l3rMcrmMxUOek=;
        b=uJ4wQS+TZq83haysZW2rqvcfhPwifmD00VB4FXasbVPOJx+6nHE08Sw/X9JmjVQRuj
         vslPyj9TJ3bT/L+t2PU/9+b+KTeFSdGe+RQdm2y1JKnfMzfh0qagkRDAi6U6XuXx2wRv
         Jng69Yc17eVshmSby4/ln1n8cjj33mlhhYQyNCo39PqrCtYKFFLXXFe6PJ2JSnjLCEma
         dXSVxofVjsVP9AWGNBZ/ZxgqyJ7Vtrrpmuafw77P0/It/kmoIOScDeZ4UUViCi1+zTAw
         +wAGWdkUks4goQHirvzPIzO249WSqHFMkWSnxuXD82YD2/GRRJeVuEFqUJW5VlPPcYqb
         fN4w==
X-Gm-Message-State: ACrzQf2QOI5e/ScP0clYnylPdw+TKJt1qikM8nZRMD0RE1SEwSX3jX84
        39Slr9tgcbcpHWM1k/bWBLrp
X-Google-Smtp-Source: AMsMyM5rRdNsJM9l2Vo+GcMg4s4PscaCRWLG2VkppCZoNdKcVcTDzkw6HBLtS8j2Rhydy1V59AC8qA==
X-Received: by 2002:a62:e70f:0:b0:562:d556:8cf2 with SMTP id s15-20020a62e70f000000b00562d5568cf2mr18129850pfh.78.1666339220235;
        Fri, 21 Oct 2022 01:00:20 -0700 (PDT)
Received: from thinkpad ([117.193.215.105])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b001782398648dsm14436010plh.8.2022.10.21.01.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:00:19 -0700 (PDT)
Date:   Fri, 21 Oct 2022 13:30:12 +0530
From:   'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
To:     Aman Gupta <aman1.gupta@samsung.com>
Cc:     'Kishon Vijay Abraham I' <kishon@ti.com>, shradha.t@samsung.com,
        pankaj.dubey@samsung.com, lpieralisi@kernel.org, kw@linux.com,
        shuah@kernel.org, linux-pci@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        'Padmanabhan Rajanbabu' <p.rajanbabu@samsung.com>
Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Message-ID: <20221021080012.GA93287@thinkpad>
References: <CGME20221007053726epcas5p357c35abb79327fee6327bc6493e0178c@epcas5p3.samsung.com>
 <20221007053934.5188-1-aman1.gupta@samsung.com>
 <fe40a005-b6a2-2938-576d-acf5432636b9@ti.com>
 <007c01d8e51a$4b2e3720$e18aa560$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <007c01d8e51a$4b2e3720$e18aa560$@samsung.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 21, 2022 at 12:26:38PM +0530, Aman Gupta wrote:
> 
> 
> > -----Original Message-----
> > From: Kishon Vijay Abraham I [mailto:kishon@ti.com]
> > Sent: Tuesday, October 11, 2022 4:29 PM
> > To: Aman Gupta <aman1.gupta@samsung.com>; shradha.t@samsung.com;
> > pankaj.dubey@samsung.com; lpieralisi@kernel.org; kw@linux.com;
> > shuah@kernel.org
> > Cc: linux-pci@vger.kernel.org; linux-kselftest@vger.kernel.org;
> > Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>; Manivannan
> > Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI endpoint
> > driver test
> > 
> > +Mani
> Gentle reminder for review of this patch.
> 

Sorry for the delay. I'm on leave for the past few weeks. Will get to the patch
next week.

Thanks,
Mani

> Thanks and Regards
> Aman Gupta
> > 
> > On 07/10/22 11:09 am, Aman Gupta wrote:
> > > This patch enables the support to perform selftest on PCIe endpoint
> > > driver present in the system. The following tests are currently
> > > performed by the selftest utility
> > >
> > > 1. BAR Tests (BAR0 to BAR5)
> > > 2. MSI Interrupt Tests (MSI1 to MSI32) 3. Read Tests (For 1, 1024,
> > > 1025, 1024000, 1024001 Bytes) 4. Write Tests (For 1, 1024, 1025,
> > > 1024000, 1024001 Bytes) 5. Copy Tests (For 1, 1024, 1025, 1024000,
> > > 1024001 Bytes)
> > >
> > > Signed-off-by: Aman Gupta <aman1.gupta@samsung.com>
> > > Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> > > ---
> > >   tools/testing/selftests/Makefile           |   1 +
> > >   tools/testing/selftests/pci/.gitignore     |   1 +
> > >   tools/testing/selftests/pci/Makefile       |   7 +
> > >   tools/testing/selftests/pci/pci-selftest.c | 167 +++++++++++++++++++++
> > >   4 files changed, 176 insertions(+)
> > >   create mode 100644 tools/testing/selftests/pci/.gitignore
> > >   create mode 100644 tools/testing/selftests/pci/Makefile
> > >   create mode 100644 tools/testing/selftests/pci/pci-selftest.c
> > >
> > > diff --git a/tools/testing/selftests/Makefile
> > > b/tools/testing/selftests/Makefile
> > > index c2064a35688b..81584169a80f 100644
> > > --- a/tools/testing/selftests/Makefile
> > > +++ b/tools/testing/selftests/Makefile
> > > @@ -49,6 +49,7 @@ TARGETS += net/forwarding
> > >   TARGETS += net/mptcp
> > >   TARGETS += netfilter
> > >   TARGETS += nsfs
> > > +TARGETS += pci
> > >   TARGETS += pidfd
> > >   TARGETS += pid_namespace
> > >   TARGETS += powerpc
> > > diff --git a/tools/testing/selftests/pci/.gitignore
> > > b/tools/testing/selftests/pci/.gitignore
> > > new file mode 100644
> > > index 000000000000..db01411b8200
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/pci/.gitignore
> > > @@ -0,0 +1 @@
> > > +pci-selftest
> > > diff --git a/tools/testing/selftests/pci/Makefile
> > > b/tools/testing/selftests/pci/Makefile
> > > new file mode 100644
> > > index 000000000000..76b7725a45ae
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/pci/Makefile
> > > @@ -0,0 +1,7 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +CFLAGS += -O2 -Wl,-no-as-needed -Wall LDFLAGS += -lrt -lpthread -lm
> > > +
> > > +TEST_GEN_PROGS = pci-selftest
> > > +
> > > +include ../lib.mk
> > > diff --git a/tools/testing/selftests/pci/pci-selftest.c
> > > b/tools/testing/selftests/pci/pci-selftest.c
> > > new file mode 100644
> > > index 000000000000..73e8f3eb1982
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/pci/pci-selftest.c
> > > @@ -0,0 +1,167 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * PCI Endpoint Driver Test Program
> > > + *
> > > + * Copyright (c) 2022 Samsung Electronics Co., Ltd.
> > > + *             https://www.samsung.com
> > > + * Author: Aman Gupta <aman1.gupta@samsung.com>  */
> > > +
> > > +#include <errno.h>
> > > +#include <fcntl.h>
> > > +#include <stdbool.h>
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <sys/ioctl.h>
> > > +#include <unistd.h>
> > > +
> > > +#include "../kselftest_harness.h"
> > > +
> > > +#define PCITEST_BAR		_IO('P', 0x1)
> > > +#define PCITEST_LEGACY_IRQ	_IO('P', 0x2)
> > > +#define PCITEST_MSI		_IOW('P', 0x3, int)
> > > +#define PCITEST_WRITE		_IOW('P', 0x4, unsigned long)
> > > +#define PCITEST_READ		_IOW('P', 0x5, unsigned long)
> > > +#define PCITEST_COPY		_IOW('P', 0x6, unsigned long)
> > > +#define PCITEST_MSIX		_IOW('P', 0x7, int)
> > > +#define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
> > > +#define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
> > > +#define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> > > +
> > > +static char *test_device = "/dev/pci-endpoint-test.0";
> > > +
> > > +struct xfer_param {
> > > +	unsigned long size;
> > > +	unsigned char flag;
> > > +	};
> > > +
> > > +FIXTURE(device)
> > > +{
> > > +	int fd;
> > > +};
> > > +
> > > +FIXTURE_SETUP(device)
> > > +{
> > > +
> > > +	self->fd = open(test_device, O_RDWR);
> > > +
> > > +	ASSERT_NE(-1, self->fd) {
> > > +		TH_LOG("Can't open PCI Endpoint Test device\n");
> > > +	}
> > > +}
> > > +
> > > +FIXTURE_TEARDOWN(device)
> > > +{
> > > +	close(self->fd);
> > > +}
> > > +
> > > +TEST_F(device, BAR_TEST)
> > > +{
> > > +	int ret = -EINVAL;
> > > +	int final = 0;
> > > +
> > > +	for (int i = 0; i <= 5; i++) {
> > > +		ret = ioctl(self->fd, PCITEST_BAR, i);
> > > +
> > > +		EXPECT_EQ(1, ret) {
> > > +			TH_LOG("TEST FAILED FOR BAR %d\n", i);
> > > +			final++;
> > > +		}
> > > +	}
> > > +
> > > +	ASSERT_EQ(0, final);
> > > +}
> > > +
> > > +TEST_F(device, MSI_TEST)
> > > +{
> > > +	int ret = -EINVAL;
> > > +	int final = 0;
> > > +
> > > +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > > +	ASSERT_EQ(1, ret);
> > > +
> > > +	for (int i = 1; i <= 32; i++) {
> > > +		ret = ioctl(self->fd, PCITEST_MSI, i);
> > > +		EXPECT_EQ(1, ret) {
> > > +			TH_LOG("TEST FAILED FOR MSI%d\n", i);
> > > +			final++;
> > > +		}
> > > +	}
> > > +
> > > +	ASSERT_EQ(0, final);
> > > +}
> > > +
> > > +TEST_F(device, READ_TEST)
> > > +{
> > > +	int final = 0;
> > > +	int ret = -EINVAL;
> > > +	unsigned long SIZE[5] = {1, 1024, 1025, 1024000, 1024001};
> > > +
> > > +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > > +	ASSERT_EQ(1, ret);
> > > +
> > > +	struct xfer_param param;
> > > +
> > > +	param.flag = 0;
> > > +	for (int i = 0; i < 5; i++) {
> > > +		param.size = SIZE[i];
> > > +		ret = ioctl(self->fd, PCITEST_READ, &param);
> > > +		EXPECT_EQ(1, ret) {
> > > +			TH_LOG("TEST FAILED FOR size =%ld.\n", SIZE[i]);
> > > +			final++;
> > > +		}
> > > +	}
> > > +
> > > +	ASSERT_EQ(0, final);
> > > +}
> > > +
> > > +TEST_F(device, WRITE_TEST)
> > > +{
> > > +	int final = 0;
> > > +	int ret = -EINVAL;
> > > +	unsigned long SIZE[5] = {1, 1024, 1025, 1024000, 1024001};
> > > +
> > > +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > > +	ASSERT_EQ(1, ret);
> > > +
> > > +	struct xfer_param param;
> > > +
> > > +	param.flag = 0;
> > > +
> > > +	for (int i = 0; i < 5; i++) {
> > > +		param.size = SIZE[i];
> > > +		ret = ioctl(self->fd, PCITEST_WRITE, &param);
> > > +		EXPECT_EQ(1, ret) {
> > > +			TH_LOG("TEST FAILED FOR size =%ld.\n", SIZE[i]);
> > > +			final++;
> > > +		}
> > > +	}
> > > +
> > > +	ASSERT_EQ(0, final);
> > > +}
> > > +
> > > +TEST_F(device, COPY_TEST)
> > > +{
> > > +	int final = 0;
> > > +	int ret = -EINVAL;
> > > +	unsigned long SIZE[5] = {1, 1024, 1025, 1024000, 1024001};
> > > +
> > > +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > > +	ASSERT_EQ(1, ret);
> > > +
> > > +	struct xfer_param param;
> > > +
> > > +	param.flag = 0;
> > > +
> > > +	for (int i = 0; i < 5; i++) {
> > > +		param.size = SIZE[i];
> > > +		ret = ioctl(self->fd, PCITEST_COPY, &param);
> > > +		EXPECT_EQ(1, ret) {
> > > +			TH_LOG("TEST FAILED FOR size =%ld.\n", SIZE[i]);
> > > +			final++;
> > > +		}
> > > +	}
> > > +
> > > +	ASSERT_EQ(0, final);
> > > +}
> > > +TEST_HARNESS_MAIN
> > >
> 

-- 
மணிவண்ணன் சதாசிவம்
