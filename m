Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7FF2F93F2
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Jan 2021 17:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbhAQQT5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Jan 2021 11:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729382AbhAQQTz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Jan 2021 11:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610900307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pd4vHRZ+JWsMgYXJ+/MXzVJZ5dZGqNEtTkFAu8s+Zps=;
        b=Z+tYm7j4G4Jm9zkVWWnB+j84GfLRzpYXY5pBumBX4IlfSpqVi31yCye4No8meGPS+70jA+
        69LwMZ3Xz/6f5HU7ptGe/ThogpCZvWQ65MinbnfmazuW9M4+Q6mpwYrLWJioC1DUKgA7z9
        26NLUljT9qoe5gectsmP4whsewZpgAc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-721M2c7hPrGcp0jUz-hD0g-1; Sun, 17 Jan 2021 11:18:25 -0500
X-MC-Unique: 721M2c7hPrGcp0jUz-hD0g-1
Received: by mail-qk1-f200.google.com with SMTP id w204so14481901qka.18
        for <linux-kselftest@vger.kernel.org>; Sun, 17 Jan 2021 08:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pd4vHRZ+JWsMgYXJ+/MXzVJZ5dZGqNEtTkFAu8s+Zps=;
        b=dX9BJz6zB4w0NOMQhqPlmApqiRWbPPtBZkycWQTKlKZxTDp4vLPVMjXCtYZo+HE0yY
         kn2C+aEQd7kTfiT/qv3iS0ChcAws2DeqFKJrssUiJDD9iuDFVBAClk1wu8YRSX+nKfdK
         +nfUEPKs/4xICxEkqNe4SoJ9u53G2fs1mheoG50rta57p1ux5rwaJZ6eZFOpVGNEI/fU
         RF+dojVvE/FX5i+N8hfyIDcYfmZPknbF2Xa+oycDm0Qu3Wdyo1CdaqateJYpeT33MiAT
         Ma08zmBSsMUrcGXut+Q0iBwJDVOvEdf0cEMEZG3i2xt40ZTEGJKMrVShLgiXfa3LGTlH
         DjYQ==
X-Gm-Message-State: AOAM5337m7UVVPmSv0LnKbYihCf9Q734EUrYic7MhPDDke+AfudGLu0A
        iOFQP4YuaUFviRIKD6SC7+u+XBZmlMpiZGfiqdTKjNv8bryEuMO+hmuy0BCD6nNwcqQWh0DbwJQ
        /rHrX5TUrW6q2E+uymLHOfwLQEoS9
X-Received: by 2002:ac8:6b0a:: with SMTP id w10mr19764229qts.224.1610900303863;
        Sun, 17 Jan 2021 08:18:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+kM1gexsua9DwpZxib3OZs35p/m5WmKtlUfgtMEYDw+N6CMDgeXGQk41qH5EeAy8ZFkJePQ==
X-Received: by 2002:ac8:6b0a:: with SMTP id w10mr19764160qts.224.1610900302190;
        Sun, 17 Jan 2021 08:18:22 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i17sm8617874qtg.77.2021.01.17.08.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 08:18:21 -0800 (PST)
From:   trix@redhat.com
To:     shuah@kernel.org, mdf@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3] selftests: drivers: fpga: A test for interrupt support
Date:   Sun, 17 Jan 2021 08:18:15 -0800
Message-Id: <20210117161815.514078-1-trix@redhat.com>
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
v2: reverse xmas tree variables
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

