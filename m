Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5AA1F3B52
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jun 2020 15:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgFINCq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Jun 2020 09:02:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37636 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728120AbgFINCl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Jun 2020 09:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591707759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=bREWkWb35OzfrHIRzdmmor2rUMQLv+plL/FvWsPvBUY=;
        b=WI0I/VkqPD8oS1Qs95Z2GaFjjtv9R2P4/zxRVAvgtuiE4rUBEpydTiVYB9Fp3/0QBEOtUJ
        oi23wLIsWKOMXwb4R50sZHgyF8Ghfgw/lziZ/hUUe/ZwsNPfgVJPgsgdePJUuw29lV+IJx
        EYmeGEjTB+QhT8paQyyJzPTC5CWpEMw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-UPSB_l1iNvmRhoDDPeXU_w-1; Tue, 09 Jun 2020 09:02:30 -0400
X-MC-Unique: UPSB_l1iNvmRhoDDPeXU_w-1
Received: by mail-qv1-f70.google.com with SMTP id p18so15674967qvy.11
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jun 2020 06:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bREWkWb35OzfrHIRzdmmor2rUMQLv+plL/FvWsPvBUY=;
        b=qXKdVUBS48u2ZEQ/zjcb0O1RD4DdQ2oyVUMLX+bUgFQ3WkdlW+Q9OHidHcBl5xHnmu
         JMqu4movWvOYOU5joXvzPz74/QRaipsF83fWxSXgZsN9r8AVLV4DtGWwB0CEgTCYeJFl
         WmpiP9cnnaRK0zDXCRLceFTOyDr2FumW8lBuy1x7NRpz2eTUUnRUMx8+vG1392EAp+wI
         AZd4Wt0LgjBFaAxGd47GuCcuVENw2It0N1pzrUoA2u/IPJ4IW46D+vMMbZGeWOSylTgv
         zqdmxsAVeWMrRo0FJhgIHgUuRVOUPOqw2l/QVVTs0SyO3+HvFgdUawiwD/t3igZZvooh
         StsA==
X-Gm-Message-State: AOAM532N9KjAOsPwgxaH9gTcD6p9Bti9A1+OniiW+cx3i8aTL1tofETu
        1GXUQIy0X09uqzNdeADAOblqbFp3M/VRspbKNjSMmGo3at2fx3Uh1agSko68cPfHqv14G8GOp6b
        aWxfOHpyO3AboPLQgZ95PamXhtShm
X-Received: by 2002:ac8:1942:: with SMTP id g2mr29381326qtk.107.1591707749676;
        Tue, 09 Jun 2020 06:02:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyG5qx7Rdh6rstfsYD4nmjRh99FD3i66w6W9E4Eo93OJSR2rUacVKoE4wgpbkgBwfiMzejw3A==
X-Received: by 2002:ac8:1942:: with SMTP id g2mr29381276qtk.107.1591707749301;
        Tue, 09 Jun 2020 06:02:29 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m7sm9635939qti.6.2020.06.09.06.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:02:28 -0700 (PDT)
From:   trix@redhat.com
To:     linux-fpga@vger.kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 1/1] selftests: fpga: dfl: A test for afu interrupt support
Date:   Tue,  9 Jun 2020 06:02:08 -0700
Message-Id: <20200609130208.27390-2-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200609130208.27390-1-trix@redhat.com>
References: <20200609130208.27390-1-trix@redhat.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Check that the ioctl DFL_FPGA_PORT_ERR_GET_IRQ_NUM returns
an expected result.

Tested on vf device 0xbcc1

Sample run with
$ sudo make -C tools/testing/selftests TARGETS=drivers/fpga run_tests
...
ok 1 selftests: drivers/fpga: afu_intr

Signed-off-by: Tom Rix <trix@redhat.com>
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  9 +++++
 .../testing/selftests/drivers/fpga/afu_intr.c | 38 +++++++++++++++++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 4 files changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
 create mode 100644 tools/testing/selftests/drivers/fpga/afu_intr.c
 create mode 100644 tools/testing/selftests/drivers/fpga/config

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 1195bd85af38..4c6eda659125 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -9,6 +9,7 @@ TARGETS += clone3
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += drivers/dma-buf
+TARGETS += drivers/fpga
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += filesystems
diff --git a/tools/testing/selftests/drivers/fpga/Makefile b/tools/testing/selftests/drivers/fpga/Makefile
new file mode 100644
index 000000000000..0a472e8c67c5
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -I../../../../../usr/include/
+CFLAGS += -I../../../../../include/uapi/
+
+TEST_GEN_PROGS := afu_intr
+
+top_srcdir ?=../../../../..
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/fpga/afu_intr.c b/tools/testing/selftests/drivers/fpga/afu_intr.c
new file mode 100644
index 000000000000..aa1efba94605
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/afu_intr.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <linux/fcntl.h>
+#include <linux/fpga-dfl.h>
+
+#define TEST_PREFIX	"drivers/fpga/afu_intr"
+
+int main(int argc, char *argv[])
+{
+	int devfd, status;
+	struct dfl_fpga_port_info port_info;
+	uint32_t irq_num;
+
+	devfd = open("/dev/dfl-port.0", O_RDONLY);
+	if (devfd < 0) {
+		printf("%s: [skip,no-ufpgaintr]\n", TEST_PREFIX);
+		exit(77);
+	}
+
+	/*
+	 * From fpga-dl.h :
+	 * Currently hardware supports up to 1 irq.
+	 * Return: 0 on success, -errno on failure.
+	 */
+	irq_num = -1;
+	status = ioctl(devfd, DFL_FPGA_PORT_ERR_GET_IRQ_NUM, &irq_num);
+	if (status != 0 || irq_num > 255) {
+		printf("%s: [FAIL,err-get-irq-num]\n", TEST_PREFIX);
+		close(devfd);
+		exit(1);
+	}
+
+	close(devfd);
+	return 0;
+}
diff --git a/tools/testing/selftests/drivers/fpga/config b/tools/testing/selftests/drivers/fpga/config
new file mode 100644
index 000000000000..e2111b81d8d7
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/config
@@ -0,0 +1 @@
+CONFIG_FPGA_DFL_AFU=m
-- 
2.18.1

