Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19708615073
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 18:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiKARTu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 13:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiKARTq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 13:19:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304371B1C9
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 10:19:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b11so13840931pjp.2
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Nov 2022 10:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZVQMtxAX0cz9FjK9FW34ZgL1oeVKjljPlqZDl/bW6Vs=;
        b=Yg1BorMt9Bq3vhlJ/TGHdm6AB1DAR89bAgWGD/pXCjW1qkUmmNGeulvcZize7tJV4b
         /REZwpw/ER2In/bKmLAgg99aPSBFj4eM9o2WRXgip9XN0c6wnsTjlJ52nHzLyQdaLzmX
         48PmvbR1/qjmuD9uAUShNOlw0U2tsPNely5wDjMc96FAVKg9We9va5d91i6KSYToVNxP
         Wj2ofVnQf/JJXAdigcX3/RHmIezSU3qwWj0h4E06jtKcrOe4Z14QvbUJ+RtaJdgnnaWU
         9LLvDk5xxuTSn+mdvL5zyZK9Bk56oLYd0p7LjwEwZEEIJ6xttAlSpmLfCYnIedK85lok
         zo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVQMtxAX0cz9FjK9FW34ZgL1oeVKjljPlqZDl/bW6Vs=;
        b=CeLf4FoM1LjQiLvPtos2dXwKYFdDvY3odMvsS4Heau2lw4djYHzidM0STM8bxKajrW
         BrmfEHKFl+EARyMyNQLxAuvFJDeelRb6KumIQn/5aPmfSB4uI47SsKKr1sDMnX1Jt4yt
         +KkHnM/ZB5vqoul1uZHcfH6Kw6NsoBgiji4BwXqqNSEvtVjG14pDBunnkkum1jijeE3y
         NtnsnlWeptYUe/x1tZP/PKkpMbWCbB63+cO+GcZ6f79QeX/Nc5Lek6cMK+hyHQ1PMUba
         QoMFknWQX0s/6NEGPQr65J6JsfqDKiNcKPHLMuXxnxUDxy0x+CfxnoE35HzktcC1XqPv
         l2wA==
X-Gm-Message-State: ACrzQf3Pf5aaAnrrg3P3V070jkTSuBn8mJyr9hV+B94A83zg2q+/6S2v
        +g3Wj48mdgoVYu8OTlZMAWYaRNa408OM
X-Google-Smtp-Source: AMsMyM6/yLAYPuI6i+qmsOfTvcRI1qfUb+M7ezSiw/3cPccVW7uP4pIy+aoZdw63h0idu7TmlMH7Hg==
X-Received: by 2002:a17:902:9b8a:b0:170:f343:ba14 with SMTP id y10-20020a1709029b8a00b00170f343ba14mr163251plp.70.1667323183401;
        Tue, 01 Nov 2022 10:19:43 -0700 (PDT)
Received: from thinkpad ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902e54e00b0017f57787a4asm6608725plf.229.2022.11.01.10.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 10:19:42 -0700 (PDT)
Date:   Tue, 1 Nov 2022 22:49:33 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Aman Gupta <aman1.gupta@samsung.com>, shradha.t@samsung.com,
        pankaj.dubey@samsung.com, kishon@ti.com, lpieralisi@kernel.org,
        kw@linux.com, shuah@kernel.org, linux-pci@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Message-ID: <20221101171933.GD244012@thinkpad>
References: <CGME20221007053726epcas5p357c35abb79327fee6327bc6493e0178c@epcas5p3.samsung.com>
 <20221007053934.5188-1-aman1.gupta@samsung.com>
 <20221101140216.GO54667@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101140216.GO54667@thinkpad>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 01, 2022 at 07:32:16PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Oct 07, 2022 at 11:09:34AM +0530, Aman Gupta wrote:
> > This patch enables the support to perform selftest on PCIe endpoint
> > driver present in the system. The following tests are currently
> > performed by the selftest utility
> > 
> > 1. BAR Tests (BAR0 to BAR5)
> > 2. MSI Interrupt Tests (MSI1 to MSI32)
> > 3. Read Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > 4. Write Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > 5. Copy Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > 
> > Signed-off-by: Aman Gupta <aman1.gupta@samsung.com>
> > Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> > ---
> >  tools/testing/selftests/Makefile           |   1 +
> >  tools/testing/selftests/pci/.gitignore     |   1 +
> >  tools/testing/selftests/pci/Makefile       |   7 +
> >  tools/testing/selftests/pci/pci-selftest.c | 167 +++++++++++++++++++++
> >  4 files changed, 176 insertions(+)
> >  create mode 100644 tools/testing/selftests/pci/.gitignore
> >  create mode 100644 tools/testing/selftests/pci/Makefile
> >  create mode 100644 tools/testing/selftests/pci/pci-selftest.c
> > 
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> > index c2064a35688b..81584169a80f 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -49,6 +49,7 @@ TARGETS += net/forwarding
> >  TARGETS += net/mptcp
> >  TARGETS += netfilter
> >  TARGETS += nsfs
> > +TARGETS += pci
> >  TARGETS += pidfd
> >  TARGETS += pid_namespace
> >  TARGETS += powerpc
> > diff --git a/tools/testing/selftests/pci/.gitignore b/tools/testing/selftests/pci/.gitignore
> > new file mode 100644
> > index 000000000000..db01411b8200
> > --- /dev/null
> > +++ b/tools/testing/selftests/pci/.gitignore
> > @@ -0,0 +1 @@
> > +pci-selftest
> > diff --git a/tools/testing/selftests/pci/Makefile b/tools/testing/selftests/pci/Makefile
> > new file mode 100644
> > index 000000000000..76b7725a45ae
> > --- /dev/null
> > +++ b/tools/testing/selftests/pci/Makefile
> > @@ -0,0 +1,7 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +CFLAGS += -O2 -Wl,-no-as-needed -Wall
> > +LDFLAGS += -lrt -lpthread -lm
> > +
> > +TEST_GEN_PROGS = pci-selftest
> > +
> > +include ../lib.mk
> > diff --git a/tools/testing/selftests/pci/pci-selftest.c b/tools/testing/selftests/pci/pci-selftest.c
> > new file mode 100644
> > index 000000000000..73e8f3eb1982
> > --- /dev/null
> > +++ b/tools/testing/selftests/pci/pci-selftest.c
> 
> endpoint-test.c
> 
> > @@ -0,0 +1,167 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCI Endpoint Driver Test Program
> > + *
> > + * Copyright (c) 2022 Samsung Electronics Co., Ltd.
> > + *             https://www.samsung.com
> > + * Author: Aman Gupta <aman1.gupta@samsung.com>
> > + */
> > +
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <sys/ioctl.h>
> > +#include <unistd.h>
> > +
> > +#include "../kselftest_harness.h"
> > +
> > +#define PCITEST_BAR		_IO('P', 0x1)
> > +#define PCITEST_LEGACY_IRQ	_IO('P', 0x2)
> > +#define PCITEST_MSI		_IOW('P', 0x3, int)
> > +#define PCITEST_WRITE		_IOW('P', 0x4, unsigned long)
> > +#define PCITEST_READ		_IOW('P', 0x5, unsigned long)
> > +#define PCITEST_COPY		_IOW('P', 0x6, unsigned long)
> > +#define PCITEST_MSIX		_IOW('P', 0x7, int)
> > +#define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
> > +#define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
> > +#define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> > +
> > +static char *test_device = "/dev/pci-endpoint-test.0";
> > +
> > +struct xfer_param {
> > +	unsigned long size;
> > +	unsigned char flag;
> > +	};
> 
> Align '}'
> 
> > +
> > +FIXTURE(device)
> > +{
> > +	int fd;
> > +};
> > +
> > +FIXTURE_SETUP(device)
> > +{
> > +
> > +	self->fd = open(test_device, O_RDWR);
> > +
> > +	ASSERT_NE(-1, self->fd) {
> > +		TH_LOG("Can't open PCI Endpoint Test device\n");
> > +	}
> > +}
> > +
> > +FIXTURE_TEARDOWN(device)
> > +{
> > +	close(self->fd);
> > +}
> > +
> > +TEST_F(device, BAR_TEST)
> > +{
> > +	int ret = -EINVAL;
> 
> Ininitialization not required here and also in other functions.
> 
> > +	int final = 0;
> > +
> > +	for (int i = 0; i <= 5; i++) {
> > +		ret = ioctl(self->fd, PCITEST_BAR, i);
> > +
> > +		EXPECT_EQ(1, ret) {
> 
> The return value of all these IOCTL's are going to change when [1] get's merged.
> 
> [1] https://lore.kernel.org/linux-pci/20220824123010.51763-1-manivannan.sadhasivam@linaro.org/
> 
> I'd suggest to resubmit this selftest after that.
> 

Looks like we might end up removing the tests under tools/pci and just use this
one. I will CC you on the v3 of PCI test cleanup series. Please rebase this
patch on top of that and post after incorporating the review comments.

Thanks,
Mani

> Thanks,
> Mani
> 
> > +			TH_LOG("TEST FAILED FOR BAR %d\n", i);
> > +			final++;
> > +		}
> > +	}
> > +
> > +	ASSERT_EQ(0, final);
> > +}
> > +
> > +TEST_F(device, MSI_TEST)
> > +{
> > +	int ret = -EINVAL;
> > +	int final = 0;
> > +
> > +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > +	ASSERT_EQ(1, ret);
> > +
> > +	for (int i = 1; i <= 32; i++) {
> > +		ret = ioctl(self->fd, PCITEST_MSI, i);
> > +		EXPECT_EQ(1, ret) {
> > +			TH_LOG("TEST FAILED FOR MSI%d\n", i);
> > +			final++;
> > +		}
> > +	}
> > +
> > +	ASSERT_EQ(0, final);
> > +}
> > +
> > +TEST_F(device, READ_TEST)
> > +{
> > +	int final = 0;
> > +	int ret = -EINVAL;
> > +	unsigned long SIZE[5] = {1, 1024, 1025, 1024000, 1024001};
> > +
> > +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > +	ASSERT_EQ(1, ret);
> > +
> > +	struct xfer_param param;
> > +
> > +	param.flag = 0;
> > +	for (int i = 0; i < 5; i++) {
> > +		param.size = SIZE[i];
> > +		ret = ioctl(self->fd, PCITEST_READ, &param);
> > +		EXPECT_EQ(1, ret) {
> > +			TH_LOG("TEST FAILED FOR size =%ld.\n", SIZE[i]);
> > +			final++;
> > +		}
> > +	}
> > +
> > +	ASSERT_EQ(0, final);
> > +}
> > +
> > +TEST_F(device, WRITE_TEST)
> > +{
> > +	int final = 0;
> > +	int ret = -EINVAL;
> > +	unsigned long SIZE[5] = {1, 1024, 1025, 1024000, 1024001};
> > +
> > +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > +	ASSERT_EQ(1, ret);
> > +
> > +	struct xfer_param param;
> > +
> > +	param.flag = 0;
> > +
> > +	for (int i = 0; i < 5; i++) {
> > +		param.size = SIZE[i];
> > +		ret = ioctl(self->fd, PCITEST_WRITE, &param);
> > +		EXPECT_EQ(1, ret) {
> > +			TH_LOG("TEST FAILED FOR size =%ld.\n", SIZE[i]);
> > +			final++;
> > +		}
> > +	}
> > +
> > +	ASSERT_EQ(0, final);
> > +}
> > +
> > +TEST_F(device, COPY_TEST)
> > +{
> > +	int final = 0;
> > +	int ret = -EINVAL;
> > +	unsigned long SIZE[5] = {1, 1024, 1025, 1024000, 1024001};
> > +
> > +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > +	ASSERT_EQ(1, ret);
> > +
> > +	struct xfer_param param;
> > +
> > +	param.flag = 0;
> > +
> > +	for (int i = 0; i < 5; i++) {
> > +		param.size = SIZE[i];
> > +		ret = ioctl(self->fd, PCITEST_COPY, &param);
> > +		EXPECT_EQ(1, ret) {
> > +			TH_LOG("TEST FAILED FOR size =%ld.\n", SIZE[i]);
> > +			final++;
> > +		}
> > +	}
> > +
> > +	ASSERT_EQ(0, final);
> > +}
> > +TEST_HARNESS_MAIN
> > -- 
> > 2.17.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
