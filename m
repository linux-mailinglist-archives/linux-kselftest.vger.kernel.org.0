Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56A1652D40
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Dec 2022 08:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiLUHYm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Dec 2022 02:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiLUHYl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Dec 2022 02:24:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C00140F5;
        Tue, 20 Dec 2022 23:24:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C16A9616FD;
        Wed, 21 Dec 2022 07:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E4DC433D2;
        Wed, 21 Dec 2022 07:24:33 +0000 (UTC)
Date:   Wed, 21 Dec 2022 12:54:23 +0530
From:   'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
To:     Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics 
        <aman1.gupta@samsung.com>
Cc:     'Manivannan Sadhasivam' <mani@kernel.org>, shradha.t@samsung.com,
        pankaj.dubey@samsung.com, kishon@ti.com, lpieralisi@kernel.org,
        kw@linux.com, shuah@kernel.org, linux-pci@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        'Padmanabhan Rajanbabu' <p.rajanbabu@samsung.com>
Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Message-ID: <20221221072423.GC2922@thinkpad>
References: <CGME20221219043044epcas5p3d5476a9a5d6ae7a5cd2bb3fa92708e73@epcas5p3.samsung.com>
 <001501d91362$a8689810$f939c830$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <001501d91362$a8689810$f939c830$@samsung.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 19, 2022 at 10:00:40AM +0530, Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics wrote:
> 
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam [mailto:manivannan.sadhasivam@linaro.org]
> > Sent: 01 November 2022 22:50
> > To: Manivannan Sadhasivam <mani@kernel.org>
> > Cc: Aman Gupta <aman1.gupta@samsung.com>; shradha.t@samsung.com;
> > pankaj.dubey@samsung.com; kishon@ti.com; lpieralisi@kernel.org;
> > kw@linux.com; shuah@kernel.org; linux-pci@vger.kernel.org; linux-
> > kselftest@vger.kernel.org; Padmanabhan Rajanbabu
> > <p.rajanbabu@samsung.com>
> > Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI endpoint
> > driver test
> > 
> > On Tue, Nov 01, 2022 at 07:32:16PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Oct 07, 2022 at 11:09:34AM +0530, Aman Gupta wrote:
> > > > This patch enables the support to perform selftest on PCIe endpoint
> > > > driver present in the system. The following tests are currently
> > > > performed by the selftest utility
> > > >
> > > > 1. BAR Tests (BAR0 to BAR5)
> > > > 2. MSI Interrupt Tests (MSI1 to MSI32) 3. Read Tests (For 1, 1024,
> > > > 1025, 1024000, 1024001 Bytes) 4. Write Tests (For 1, 1024, 1025,
> > > > 1024000, 1024001 Bytes) 5. Copy Tests (For 1, 1024, 1025, 1024000,
> > > > 1024001 Bytes)
> > > >
> > > > Signed-off-by: Aman Gupta <aman1.gupta@samsung.com>
> > > > Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> > > > ---
> > > >  tools/testing/selftests/Makefile           |   1 +
> > > >  tools/testing/selftests/pci/.gitignore     |   1 +
> > > >  tools/testing/selftests/pci/Makefile       |   7 +
> > > >  tools/testing/selftests/pci/pci-selftest.c | 167
> > > > +++++++++++++++++++++
> > > >  4 files changed, 176 insertions(+)
> > > >  create mode 100644 tools/testing/selftests/pci/.gitignore
> > > >  create mode 100644 tools/testing/selftests/pci/Makefile
> > > >  create mode 100644 tools/testing/selftests/pci/pci-selftest.c
> > > >
> > > > diff --git a/tools/testing/selftests/Makefile
> > > > b/tools/testing/selftests/Makefile
> > > > index c2064a35688b..81584169a80f 100644
> > > > --- a/tools/testing/selftests/Makefile
> > > > +++ b/tools/testing/selftests/Makefile
> > > > @@ -49,6 +49,7 @@ TARGETS += net/forwarding  TARGETS += net/mptcp
> > > > TARGETS += netfilter  TARGETS += nsfs
> > > > +TARGETS += pci
> > > >  TARGETS += pidfd
> > > >  TARGETS += pid_namespace
> > > >  TARGETS += powerpc
> > > > diff --git a/tools/testing/selftests/pci/.gitignore
> > > > b/tools/testing/selftests/pci/.gitignore
> > > > new file mode 100644
> > > > index 000000000000..db01411b8200
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/pci/.gitignore
> > > > @@ -0,0 +1 @@
> > > > +pci-selftest
> > > > diff --git a/tools/testing/selftests/pci/Makefile
> > > > b/tools/testing/selftests/pci/Makefile
> > > > new file mode 100644
> > > > index 000000000000..76b7725a45ae
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/pci/Makefile
> > > > @@ -0,0 +1,7 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +CFLAGS += -O2 -Wl,-no-as-needed -Wall LDFLAGS += -lrt -lpthread -lm
> > > > +
> > > > +TEST_GEN_PROGS = pci-selftest
> > > > +
> > > > +include ../lib.mk
> > > > diff --git a/tools/testing/selftests/pci/pci-selftest.c
> > > > b/tools/testing/selftests/pci/pci-selftest.c
> > > > new file mode 100644
> > > > index 000000000000..73e8f3eb1982
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/pci/pci-selftest.c
> > >
> > > endpoint-test.c
> Okay I will change the file name in the next patch.
> > >
> > > > @@ -0,0 +1,167 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * PCI Endpoint Driver Test Program
> > > > + *
> > > > + * Copyright (c) 2022 Samsung Electronics Co., Ltd.
> > > > + *             https://www.samsung.com
> > > > + * Author: Aman Gupta <aman1.gupta@samsung.com>  */
> > > > +
> > > > +#include <errno.h>
> > > > +#include <fcntl.h>
> > > > +#include <stdbool.h>
> > > > +#include <stdio.h>
> > > > +#include <stdlib.h>
> > > > +#include <sys/ioctl.h>
> > > > +#include <unistd.h>
> > > > +
> > > > +#include "../kselftest_harness.h"
> > > > +
> > > > +#define PCITEST_BAR		_IO('P', 0x1)
> > > > +#define PCITEST_LEGACY_IRQ	_IO('P', 0x2)
> > > > +#define PCITEST_MSI		_IOW('P', 0x3, int)
> > > > +#define PCITEST_WRITE		_IOW('P', 0x4, unsigned long)
> > > > +#define PCITEST_READ		_IOW('P', 0x5, unsigned long)
> > > > +#define PCITEST_COPY		_IOW('P', 0x6, unsigned long)
> > > > +#define PCITEST_MSIX		_IOW('P', 0x7, int)
> > > > +#define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
> > > > +#define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
> > > > +#define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> > > > +
> > > > +static char *test_device = "/dev/pci-endpoint-test.0";
> > > > +
> > > > +struct xfer_param {
> > > > +	unsigned long size;
> > > > +	unsigned char flag;
> > > > +	};
> > >
> > > Align '}'
> Okay.
> > >
> > > > +
> > > > +FIXTURE(device)
> > > > +{
> > > > +	int fd;
> > > > +};
> > > > +
> > > > +FIXTURE_SETUP(device)
> > > > +{
> > > > +
> > > > +	self->fd = open(test_device, O_RDWR);
> > > > +
> > > > +	ASSERT_NE(-1, self->fd) {
> > > > +		TH_LOG("Can't open PCI Endpoint Test device\n");
> > > > +	}
> > > > +}
> > > > +
> > > > +FIXTURE_TEARDOWN(device)
> > > > +{
> > > > +	close(self->fd);
> > > > +}
> > > > +
> > > > +TEST_F(device, BAR_TEST)
> > > > +{
> > > > +	int ret = -EINVAL;
> > >
> > > Ininitialization not required here and also in other functions.
> Understood , I will make the changes in the next patch.
> > >
> > > > +	int final = 0;
> > > > +
> > > > +	for (int i = 0; i <= 5; i++) {
> > > > +		ret = ioctl(self->fd, PCITEST_BAR, i);
> > > > +
> > > > +		EXPECT_EQ(1, ret) {
> > >
> > > The return value of all these IOCTL's are going to change when [1] get's
> > merged.
> > >
> > > [1]
> > > https://lore.kernel.org/linux-pci/20220824123010.51763-1-manivannan.sa
> > > dhasivam@linaro.org/
> > >
> > > I'd suggest to resubmit this selftest after that.
> 
> 
> Manivannan, the patch link you have provided cannot be directly applies 
> on the latest kernel and hence it requires some re work .I can rework these 
> patches along with the kselftest patch if not please allow me to go ahead 
> and post the kselftest patch till then.

I've pushed my patches here: https://git.linaro.org/people/manivannan.sadhasivam/linux.git/log/?h=pci-endpoint-test-fix

Please pick them and rebase your patch(es) on top and post as a series. You
should also make the series a continuation of my v2, preserving the cover
letter and keeping everyone in CC.

After the kselftest patch, the tools/pci directory should be removed and the
endpoint documentation (Documentation/PCI/endpoint/pci-test-howto.rst) should
be modified to reflect kselftest.

Thanks for your contribution!

- Mani

> > >
> > 
> > Looks like we might end up removing the tests under tools/pci and just use
> > this one. I will CC you on the v3 of PCI test cleanup series. Please rebase this
> > patch on top of that and post after incorporating the review comments.
> 
> Okay, I will rebase the patches after v3 clean up gets posted.
> > 
> > Thanks,
> > Mani
> > 
> > > Thanks,
> > > Mani
> > >
> > > > +			TH_LOG("TEST FAILED FOR BAR %d\n", i);
> > > > +			final++;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	ASSERT_EQ(0, final);
> > > > +}
> > > > +
> > > > +TEST_F(device, MSI_TEST)
> > > > +{
> > > > +	int ret = -EINVAL;
> > > > +	int final = 0;
> > > > +
> > > > +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > > > +	ASSERT_EQ(1, ret);
> > > > +
> > > > +	for (int i = 1; i <= 32; i++) {
> > > > +		ret = ioctl(self->fd, PCITEST_MSI, i);
> > > > +		EXPECT_EQ(1, ret) {
> > > > +			TH_LOG("TEST FAILED FOR MSI%d\n", i);
> > > > +			final++;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	ASSERT_EQ(0, final);
> > > > +}
> > > > +
> > > > +TEST_F(device, READ_TEST)
> > > > +{
> > > > +	int final = 0;
> > > > +	int ret = -EINVAL;
> > > > +	unsigned long SIZE[5] = {1, 1024, 1025, 1024000, 1024001};
> > > > +
> > > > +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > > > +	ASSERT_EQ(1, ret);
> > > > +
> > > > +	struct xfer_param param;
> > > > +
> > > > +	param.flag = 0;
> > > > +	for (int i = 0; i < 5; i++) {
> > > > +		param.size = SIZE[i];
> > > > +		ret = ioctl(self->fd, PCITEST_READ, &param);
> > > > +		EXPECT_EQ(1, ret) {
> > > > +			TH_LOG("TEST FAILED FOR size =%ld.\n", SIZE[i]);
> > > > +			final++;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	ASSERT_EQ(0, final);
> > > > +}
> > > > +
> > > > +TEST_F(device, WRITE_TEST)
> > > > +{
> > > > +	int final = 0;
> > > > +	int ret = -EINVAL;
> > > > +	unsigned long SIZE[5] = {1, 1024, 1025, 1024000, 1024001};
> > > > +
> > > > +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > > > +	ASSERT_EQ(1, ret);
> > > > +
> > > > +	struct xfer_param param;
> > > > +
> > > > +	param.flag = 0;
> > > > +
> > > > +	for (int i = 0; i < 5; i++) {
> > > > +		param.size = SIZE[i];
> > > > +		ret = ioctl(self->fd, PCITEST_WRITE, &param);
> > > > +		EXPECT_EQ(1, ret) {
> > > > +			TH_LOG("TEST FAILED FOR size =%ld.\n", SIZE[i]);
> > > > +			final++;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	ASSERT_EQ(0, final);
> > > > +}
> > > > +
> > > > +TEST_F(device, COPY_TEST)
> > > > +{
> > > > +	int final = 0;
> > > > +	int ret = -EINVAL;
> > > > +	unsigned long SIZE[5] = {1, 1024, 1025, 1024000, 1024001};
> > > > +
> > > > +	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
> > > > +	ASSERT_EQ(1, ret);
> > > > +
> > > > +	struct xfer_param param;
> > > > +
> > > > +	param.flag = 0;
> > > > +
> > > > +	for (int i = 0; i < 5; i++) {
> > > > +		param.size = SIZE[i];
> > > > +		ret = ioctl(self->fd, PCITEST_COPY, &param);
> > > > +		EXPECT_EQ(1, ret) {
> > > > +			TH_LOG("TEST FAILED FOR size =%ld.\n", SIZE[i]);
> > > > +			final++;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	ASSERT_EQ(0, final);
> > > > +}
> > > > +TEST_HARNESS_MAIN
> > > > --
> > > > 2.17.1
> > > >
> > >
> > > --
> > > மணிவண்ணன் சதாசிவம்
> > 
> > --
> > மணிவண்ணன் சதாசிவம்
> Thank you for reviewing the patch.
> 
> Regards
> Aman gupta
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
