Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118245F7426
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Oct 2022 08:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiJGGRx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Oct 2022 02:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJGGRw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Oct 2022 02:17:52 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E118B14C2
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Oct 2022 23:17:47 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221007061744epoutp0318e588d223a8e5999ccd1a077b7e6ea9~btPf4QkhM3214632146epoutp03D
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Oct 2022 06:17:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221007061744epoutp0318e588d223a8e5999ccd1a077b7e6ea9~btPf4QkhM3214632146epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665123464;
        bh=OiQoDqU2fDF+uTvv7xAf1AWo+0LJbjpYYg/mn25JBx8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=O4Dd1yQ8jkt/Oe6ksEL7UiUWNUTA6j4NKwvIzMl374fOEJ/i/Vmir+/UbOpCZFzxC
         28a61EoLMhQHBVzkh8TEF6KIbrnPLR8v971aVKdCb1rABcZFQsB3tyhCnpB/QfJbLD
         hweW/8yYFuWFS+HURUQUQ1AzcyWnEFHxMt754vAs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221007061743epcas5p3b094a42d96aea1e7ae53a1ea748b2345~btPfZexj40542505425epcas5p38;
        Fri,  7 Oct 2022 06:17:43 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MkJ521R6fz4x9QL; Fri,  7 Oct
        2022 06:17:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.B5.26992.684CF336; Fri,  7 Oct 2022 15:17:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221007053726epcas5p357c35abb79327fee6327bc6493e0178c~bssT1rZLD1659716597epcas5p3S;
        Fri,  7 Oct 2022 05:37:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221007053726epsmtrp189b83ae83e9284eb2e3de31862fc9c85~bssT0shYb2038320383epsmtrp1V;
        Fri,  7 Oct 2022 05:37:26 +0000 (GMT)
X-AuditID: b6c32a49-319fb70000016970-8d-633fc48696c7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.1D.14392.61BBF336; Fri,  7 Oct 2022 14:37:26 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.109.115.14]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221007053724epsmtip17e1d3cc1e41bfb9fd2062c44a4bb977b~bssSUOh8G1388213882epsmtip1r;
        Fri,  7 Oct 2022 05:37:24 +0000 (GMT)
From:   Aman Gupta <aman1.gupta@samsung.com>
To:     shradha.t@samsung.com, pankaj.dubey@samsung.com, kishon@ti.com,
        lpieralisi@kernel.org, kw@linux.com, shuah@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Aman Gupta <aman1.gupta@samsung.com>,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH] selftests: pci: pci-selftest: add support for PCI endpoint
 driver test
Date:   Fri,  7 Oct 2022 11:09:34 +0530
Message-Id: <20221007053934.5188-1-aman1.gupta@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7bCmpm7bEftkg7dr2C0W7GpgtLjwtIfN
        oqHnN6vF9Dvv2SzOzjvOZtHyp4XF4ujGYItFW7+wW/QerrWY8nIduwOXx6ZVnWweT65MZ/Lo
        27KK0eP4je1MHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXm
        ptoqufgE6Lpl5gDdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7N
        S9fLSy2xMjQwMDIFKkzIzljxcxN7QZduxcnDS5gaGPerdDFyckgImEhManjP2MXIxSEksJtR
        4sCdD8wQzidGieblf9khnG+MEu8mvGSCabnYMp0VIrGXUeL4hgdQVS1MEh13L4JVsQloSZya
        1QWU4OAQEaiW2HXHGqSGWWA6o8SFmc8ZQWqEBSIlHp/vYgOxWQRUJV7e+QDWyytgLbFq62ZW
        iG3yEqs3HAC7SULgGLvE/r8n2CESLhL3jvxigbCFJV4d3wIVl5J42d8GZcdLnP+7DKomQ+Ly
        3qdQtr3EgStzWECOYxbQlFi/Sx8iLCsx9dQ6sBuYBfgken8/gfqYV2LHPBhbVeL7lA5mCFta
        oun1Wag7PSS+zjoM9peQQKzEvOuXmCcwys5C2LCAkXEVo2RqQXFuemqxaYFhXmo5PKaS83M3
        MYLTmpbnDsa7Dz7oHWJk4mA8xCjBwawkwrtzp12yEG9KYmVValF+fFFpTmrxIUZTYJhNZJYS
        Tc4HJta8knhDE0sDEzMzMxNLYzNDJXHexTO0koUE0hNLUrNTUwtSi2D6mDg4pRqYhE49tzh9
        /oFowGmdCS8nZYcfufmE6UntyxbF61c5JBvi9pivqVGYqMda/Pfb65/ZOc/brrKd/z73+aJl
        CmZ83RazXYratM/Oe8PVpDhfPtLCZ94klTOGYYEsRrqdv91Sv1hs7Ft++GPhvwd7Xt4KkpP9
        bT3l/xRGgcNBcku/7H3CqrayPEm4ecvXuWcPPmPue67ek8V7qbrowN4v/59fM2JJ4Dm84mLh
        9v9pG/5aqR07uP+srcifHypRc5N4LY9xbJF6Lhhm/9n0yLof1Ved97kkS7aWOe3N/OCxN/NF
        pLKspdydxuvagk+Tw+Z+P3JqyfaeGL+CxayXv8rNkQ538do8+dP1Y0n3z83XOzQh9rUSS3FG
        oqEWc1FxIgBVUVK49AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42LZdlhJTldst32yweZdLBYLdjUwWlx42sNm
        0dDzm9Vi+p33bBZn5x1ns2j508JicXRjsMWirV/YLXoP11pMebmO3YHLY9OqTjaPJ1emM3n0
        bVnF6HH8xnYmj8+b5AJYo7hsUlJzMstSi/TtErgyVvzcxF7QpVtx8vASpgbG/SpdjJwcEgIm
        EhdbprN2MXJxCAnsZpSYc+sEI0RCWuL+2UlsELawxMp/z9khipqYJNp3LwJLsAloSZya1QWW
        EBFoZpQ4s2EmI4jDLDCbUWLZk71Aczk4hAXCJbo7LUEaWARUJV7e+cAEYvMKWEus2rqZFWKD
        vMTqDQeYJzDyLGBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERxiWpo7GLev+qB3
        iJGJg/EQowQHs5II786ddslCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0t
        SC2CyTJxcEo1MDHPP/Fm8oIJ3WaVl2eesbsTUmfnb7ag1OWG47WlCid87xYbip1TkXGIPjN9
        rYnMnsiNT68x9yR80+Dk2Nj4l+0mf/UtzZVWEvpfw4W+eAfN/mK3iUvx/K0vsz/eWP7j5/rb
        0hNZrvl87yzWSNF/t6mlZdvzZdM5Sm+FnDj86YOMeb6Z4wyRnTVWcw85vrA71L1la13x1Jeh
        70QnOSyM/bB6heTvA0umcrzbYvKr7qv4w3Kb54mLjeU75Lbm/ni/97Tmt3fXxWX7opyzn//9
        JK0Rs1T86hQRR8tO7+4lTjP9Z/PFbao+w9I+a6dpk17XqhMHWDodJuRp9FhbzPC0zp/hsMZS
        /a33NM0vu4yD22SUWIozEg21mIuKEwFgYJfKoAIAAA==
X-CMS-MailID: 20221007053726epcas5p357c35abb79327fee6327bc6493e0178c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221007053726epcas5p357c35abb79327fee6327bc6493e0178c
References: <CGME20221007053726epcas5p357c35abb79327fee6327bc6493e0178c@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch enables the support to perform selftest on PCIe endpoint
driver present in the system. The following tests are currently
performed by the selftest utility

1. BAR Tests (BAR0 to BAR5)
2. MSI Interrupt Tests (MSI1 to MSI32)
3. Read Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
4. Write Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
5. Copy Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)

Signed-off-by: Aman Gupta <aman1.gupta@samsung.com>
Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/pci/.gitignore     |   1 +
 tools/testing/selftests/pci/Makefile       |   7 +
 tools/testing/selftests/pci/pci-selftest.c | 167 +++++++++++++++++++++
 4 files changed, 176 insertions(+)
 create mode 100644 tools/testing/selftests/pci/.gitignore
 create mode 100644 tools/testing/selftests/pci/Makefile
 create mode 100644 tools/testing/selftests/pci/pci-selftest.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c2064a35688b..81584169a80f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -49,6 +49,7 @@ TARGETS += net/forwarding
 TARGETS += net/mptcp
 TARGETS += netfilter
 TARGETS += nsfs
+TARGETS += pci
 TARGETS += pidfd
 TARGETS += pid_namespace
 TARGETS += powerpc
diff --git a/tools/testing/selftests/pci/.gitignore b/tools/testing/selftests/pci/.gitignore
new file mode 100644
index 000000000000..db01411b8200
--- /dev/null
+++ b/tools/testing/selftests/pci/.gitignore
@@ -0,0 +1 @@
+pci-selftest
diff --git a/tools/testing/selftests/pci/Makefile b/tools/testing/selftests/pci/Makefile
new file mode 100644
index 000000000000..76b7725a45ae
--- /dev/null
+++ b/tools/testing/selftests/pci/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -O2 -Wl,-no-as-needed -Wall
+LDFLAGS += -lrt -lpthread -lm
+
+TEST_GEN_PROGS = pci-selftest
+
+include ../lib.mk
diff --git a/tools/testing/selftests/pci/pci-selftest.c b/tools/testing/selftests/pci/pci-selftest.c
new file mode 100644
index 000000000000..73e8f3eb1982
--- /dev/null
+++ b/tools/testing/selftests/pci/pci-selftest.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint Driver Test Program
+ *
+ * Copyright (c) 2022 Samsung Electronics Co., Ltd.
+ *             https://www.samsung.com
+ * Author: Aman Gupta <aman1.gupta@samsung.com>
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#define PCITEST_BAR		_IO('P', 0x1)
+#define PCITEST_LEGACY_IRQ	_IO('P', 0x2)
+#define PCITEST_MSI		_IOW('P', 0x3, int)
+#define PCITEST_WRITE		_IOW('P', 0x4, unsigned long)
+#define PCITEST_READ		_IOW('P', 0x5, unsigned long)
+#define PCITEST_COPY		_IOW('P', 0x6, unsigned long)
+#define PCITEST_MSIX		_IOW('P', 0x7, int)
+#define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
+#define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
+#define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
+
+static char *test_device = "/dev/pci-endpoint-test.0";
+
+struct xfer_param {
+	unsigned long size;
+	unsigned char flag;
+	};
+
+FIXTURE(device)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(device)
+{
+
+	self->fd = open(test_device, O_RDWR);
+
+	ASSERT_NE(-1, self->fd) {
+		TH_LOG("Can't open PCI Endpoint Test device\n");
+	}
+}
+
+FIXTURE_TEARDOWN(device)
+{
+	close(self->fd);
+}
+
+TEST_F(device, BAR_TEST)
+{
+	int ret = -EINVAL;
+	int final = 0;
+
+	for (int i = 0; i <= 5; i++) {
+		ret = ioctl(self->fd, PCITEST_BAR, i);
+
+		EXPECT_EQ(1, ret) {
+			TH_LOG("TEST FAILED FOR BAR %d\n", i);
+			final++;
+		}
+	}
+
+	ASSERT_EQ(0, final);
+}
+
+TEST_F(device, MSI_TEST)
+{
+	int ret = -EINVAL;
+	int final = 0;
+
+	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
+	ASSERT_EQ(1, ret);
+
+	for (int i = 1; i <= 32; i++) {
+		ret = ioctl(self->fd, PCITEST_MSI, i);
+		EXPECT_EQ(1, ret) {
+			TH_LOG("TEST FAILED FOR MSI%d\n", i);
+			final++;
+		}
+	}
+
+	ASSERT_EQ(0, final);
+}
+
+TEST_F(device, READ_TEST)
+{
+	int final = 0;
+	int ret = -EINVAL;
+	unsigned long SIZE[5] = {1, 1024, 1025, 1024000, 1024001};
+
+	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
+	ASSERT_EQ(1, ret);
+
+	struct xfer_param param;
+
+	param.flag = 0;
+	for (int i = 0; i < 5; i++) {
+		param.size = SIZE[i];
+		ret = ioctl(self->fd, PCITEST_READ, &param);
+		EXPECT_EQ(1, ret) {
+			TH_LOG("TEST FAILED FOR size =%ld.\n", SIZE[i]);
+			final++;
+		}
+	}
+
+	ASSERT_EQ(0, final);
+}
+
+TEST_F(device, WRITE_TEST)
+{
+	int final = 0;
+	int ret = -EINVAL;
+	unsigned long SIZE[5] = {1, 1024, 1025, 1024000, 1024001};
+
+	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
+	ASSERT_EQ(1, ret);
+
+	struct xfer_param param;
+
+	param.flag = 0;
+
+	for (int i = 0; i < 5; i++) {
+		param.size = SIZE[i];
+		ret = ioctl(self->fd, PCITEST_WRITE, &param);
+		EXPECT_EQ(1, ret) {
+			TH_LOG("TEST FAILED FOR size =%ld.\n", SIZE[i]);
+			final++;
+		}
+	}
+
+	ASSERT_EQ(0, final);
+}
+
+TEST_F(device, COPY_TEST)
+{
+	int final = 0;
+	int ret = -EINVAL;
+	unsigned long SIZE[5] = {1, 1024, 1025, 1024000, 1024001};
+
+	ret = ioctl(self->fd, PCITEST_SET_IRQTYPE, 1);
+	ASSERT_EQ(1, ret);
+
+	struct xfer_param param;
+
+	param.flag = 0;
+
+	for (int i = 0; i < 5; i++) {
+		param.size = SIZE[i];
+		ret = ioctl(self->fd, PCITEST_COPY, &param);
+		EXPECT_EQ(1, ret) {
+			TH_LOG("TEST FAILED FOR size =%ld.\n", SIZE[i]);
+			final++;
+		}
+	}
+
+	ASSERT_EQ(0, final);
+}
+TEST_HARNESS_MAIN
-- 
2.17.1

