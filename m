Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E560302BE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jan 2021 20:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbhAYTmi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Jan 2021 14:42:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730445AbhAYTm3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 14:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611603662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=77St/2pIleVFwEn5R0u17JSkV+PiEVZKe/zUbSvXECQ=;
        b=GrWTRVWklhPa1kdfnOQ5MBD6Dmzl5Y+AzfPeaFAECMy3n9GGDEihYU21jgMBwSC2+zAlF2
        gXvIPNIFmeGCZ9caJ2m8WAXMTce4JLrSJnvvTh8ZjqY53KPu6cDk54wbvJLDiL5T7QdoKF
        wNW+eprVSaTqZLQlR1JtDMDzK3NRdtE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-iR0jBLRSNpyyaUrNnb6Ffw-1; Mon, 25 Jan 2021 14:41:01 -0500
X-MC-Unique: iR0jBLRSNpyyaUrNnb6Ffw-1
Received: by mail-qv1-f69.google.com with SMTP id cu12so9949235qvb.10
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 11:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77St/2pIleVFwEn5R0u17JSkV+PiEVZKe/zUbSvXECQ=;
        b=UeVB1yszCa8MNgfQU5crDdutm4CK2yCwNPpPpDkyG7RY7mJ5jZuvS9n6Uo+0EHAi9n
         oGDOUtxpf0QXVBxriVBYut+D0NXjof6YexzXLQjo7LqNq2++J3TKYkXWzkxXVbQks9zp
         xv/uB2lmQN19XU7HVnbkwh4DSxtKSNY99CNo9wBu1wnBKz3+kYjDs01CllgHwMupIoZm
         1lfc+shfsPOGthWi7H/+1wYszgQ3sh9f8TZTapaqGz7VJAOKx8zR5XXXCxTW386eljv5
         QuJMqGQz0s4OHOrnBA+IomMWSb1o3IlX62Y1qT5cRKLMMtl647UfU3kH3GA8ZIt9e9aY
         1Ceg==
X-Gm-Message-State: AOAM532j+7nx8Z/nv8Td5CkxuLy2/VPcMK3+PW+jufFIDuqf5d6P3lcp
        fvwpk4PCAuP5WLXrp+h2ovgbEnoju77QY+Sw3q8BkJ4sYXf9pYsupoH3jrsiVd4GtdT4EiEoyza
        LOuEB9Ape7gbjVpkhbfsFXbKQIOUh
X-Received: by 2002:a0c:c30e:: with SMTP id f14mr2321881qvi.48.1611603660307;
        Mon, 25 Jan 2021 11:41:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyeWyuqh+JaKFJ1xqUU6SXIHkrrOLJPawhrtxXmDS0r1Vi15nggpu9AbTZjlBOBQdInBYXhhA==
X-Received: by 2002:a0c:c30e:: with SMTP id f14mr2321866qvi.48.1611603660045;
        Mon, 25 Jan 2021 11:41:00 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 203sm12845898qkd.81.2021.01.25.11.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:40:59 -0800 (PST)
From:   trix@redhat.com
To:     shuah@kernel.org, mdf@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4] selftests: drivers: fpga: A test for interrupt support
Date:   Mon, 25 Jan 2021 11:40:53 -0800
Message-Id: <20210125194053.2119041-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Check that the ioctl DFL_FPGA_PORT_ERR_GET_IRQ_NUM returns
an expected result.

Tested on vf device 0xbcc1

Sample run with
 # make -C tools/testing/selftests TARGETS=drivers/fpga run_tests
 ...
 TAP version 13
 1..1
 # selftests: drivers/fpga: intr
 # TAP version 13
 # 1..1
 # # Starting 1 tests from 1 test cases.
 # #  RUN           global.afu_intr ...
 # #            OK  global.afu_intr
 # ok 1 global.afu_intr
 # # PASSED: 1 / 1 tests passed.
 # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 1 selftests: drivers/fpga: intr

Signed-off-by: Tom Rix <trix@redhat.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v1: Convert to kselftest_harness.h framework
v2: reverse xmas tree variables
v3: rebase to linux-kselftest, tag linux-kselftest-next-5.11-rc3
---
 MAINTAINERS                                   |  1 +
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  7 ++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 tools/testing/selftests/drivers/fpga/intr.c   | 36 +++++++++++++++++++
 5 files changed, 46 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
 create mode 100644 tools/testing/selftests/drivers/fpga/config
 create mode 100644 tools/testing/selftests/drivers/fpga/intr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..10bea5417c82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6972,6 +6972,7 @@ F:	Documentation/driver-api/fpga/
 F:	Documentation/fpga/
 F:	drivers/fpga/
 F:	include/linux/fpga/
+F:	tools/testing/selftests/drivers/fpga/
 
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index afbab4aeef3c..aad4763ec348 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -9,6 +9,7 @@ TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += drivers/dma-buf
+TARGETS += drivers/fpga
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += filesystems
diff --git a/tools/testing/selftests/drivers/fpga/Makefile b/tools/testing/selftests/drivers/fpga/Makefile
new file mode 100644
index 000000000000..eba35c405d5b
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -I../../../../../usr/include/
+CFLAGS += -I../../../../../include/uapi/
+
+TEST_GEN_PROGS := intr
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/fpga/config b/tools/testing/selftests/drivers/fpga/config
new file mode 100644
index 000000000000..e2111b81d8d7
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/config
@@ -0,0 +1 @@
+CONFIG_FPGA_DFL_AFU=m
diff --git a/tools/testing/selftests/drivers/fpga/intr.c b/tools/testing/selftests/drivers/fpga/intr.c
new file mode 100644
index 000000000000..927dcc757f0b
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/intr.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/fcntl.h>
+#include <sys/ioctl.h>
+#include <linux/fpga-dfl.h>
+
+#include "../../kselftest_harness.h"
+
+TEST(afu_intr)
+{
+	struct dfl_fpga_port_info port_info;
+	uint32_t irq_num = UINT32_MAX;
+	int devfd, status;
+
+	devfd = open("/dev/dfl-port.0", O_RDONLY);
+	if (devfd < 0)
+		SKIP(0, "no fpga afu device 0");
+	/*
+	 * From fpga-dl.h :
+	 * Currently hardware supports up to 1 irq.
+	 * Return: 0 on success, -errno on failure.
+	 */
+	status = ioctl(devfd, DFL_FPGA_PORT_ERR_GET_IRQ_NUM, &irq_num);
+	ASSERT_EQ(0, status) {
+		TH_LOG("ioctl() failed to get the number irqs");
+	}
+	ASSERT_LT(irq_num, 256) {
+		TH_LOG("unexpeced number of irqs");
+	}
+	close(devfd);
+}
+
+TEST_HARNESS_MAIN
-- 
2.27.0

