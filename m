Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8654C2F8EE8
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Jan 2021 20:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbhAPTe7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Jan 2021 14:34:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726864AbhAPTe5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Jan 2021 14:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610825609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yj5NhUnY31IXNNcNfqCUwM5gTD0on6aNUy582FDT6rU=;
        b=eXixgf+/04h9nLJkjQC7n3f+UBuqHHdD+BQSZl7qOXLD6JzOeAobSvPgxHaUc55Vg2NzHn
        +jM2YlX3Rmnj0hzYcfTzHa2v6seQDXaW5rnuU/ENE3GMsnkwy/fWQ4/BKNtGxRVe4TK/4c
        bLoxxYJ7zU6AzNVMrUZPy4tvow/xca0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-hoN02I3ZPcW92KdvaVmYVA-1; Sat, 16 Jan 2021 14:33:28 -0500
X-MC-Unique: hoN02I3ZPcW92KdvaVmYVA-1
Received: by mail-qk1-f197.google.com with SMTP id b206so12062401qkc.14
        for <linux-kselftest@vger.kernel.org>; Sat, 16 Jan 2021 11:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yj5NhUnY31IXNNcNfqCUwM5gTD0on6aNUy582FDT6rU=;
        b=lmfgiEgtev4FchBWVu0qK5JzyHqtLUDrbxvjNfMK6tLdGR43vicBZNIvygbpYYO2zz
         UadZtp9fUdUddJtuTg3cLhSVaWC0wuUtYoBSfd7TwenSSyzAT+pkS8kSB1eOdPn+LLuM
         CnJPG3f1TZfnRtGeYHN9p1G5ty5cK6v1Yk5zB3Xz8qqenXyZI+iuOVrSissop6FFKZcE
         BwXg6itSfV8lAI7vfrRG72L9fhT7JKRfzkheeU9+v8EMfWQquDGavBox2Lwx7e8aHvLB
         8hTC+4Y5QRwihEWowiaqlwq5Kt6RQmPoLu3C0ySSE0sg4ZqQUh5dc90KwNkbg1qOt3ky
         fJYA==
X-Gm-Message-State: AOAM531rDy8VDH7IW94oTaxGSYCFFSzNMp3MLP47X3j0RAE3B5keGJeu
        J9MBsdy23TORu5w6RmsNk2CGq/cItV0S+ZdBSaEGFXpjZdF68D2nxZozbZdpvppUuqjyuNtlDk2
        dHuwzNk/X5B+x4FNgz3TsccIpDmhF
X-Received: by 2002:a05:620a:15e3:: with SMTP id p3mr18231690qkm.397.1610825607633;
        Sat, 16 Jan 2021 11:33:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2FS9AlMCp0udYXBuPpi6cNGXiFOayQWDvC7TZkO1TObCYmaoVrcOCG7wr5yQApjS3HXL3jQ==
X-Received: by 2002:a05:620a:15e3:: with SMTP id p3mr18231674qkm.397.1610825607363;
        Sat, 16 Jan 2021 11:33:27 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i129sm7483816qkd.114.2021.01.16.11.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 11:33:26 -0800 (PST)
From:   trix@redhat.com
To:     shuah@kernel.org, mdf@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] selftests: drivers: fpga: A test for interrupt support
Date:   Sat, 16 Jan 2021 11:33:21 -0800
Message-Id: <20210116193321.385848-1-trix@redhat.com>
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
---
v1: Convert to kselftest_harness.h framework
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
index de610a06cb5c..7ed3ce58d95e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6973,6 +6973,7 @@ F:	Documentation/driver-api/fpga/
 F:	Documentation/fpga/
 F:	drivers/fpga/
 F:	include/linux/fpga/
+F:	tools/testing/selftests/drivers/fpga/
 
 FPGA SECURITY MANAGER DRIVERS
 M:	Russ Weight <russell.h.weight@intel.com>
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
index 000000000000..b362fb1f788d
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
+	int devfd, status;
+	struct dfl_fpga_port_info port_info;
+	uint32_t irq_num = UINT32_MAX;
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

