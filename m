Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA581F6E08
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jun 2020 21:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgFKTim (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 15:38:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58377 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725782AbgFKTil (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 15:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591904319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=+T/pLFOFWhPqP/4Y2+KijPsKT8TaUEKgCEsaihLS+Sg=;
        b=SxvIDIbfBaq0FkKa594pM9rr7H0SJKCt9AhqemUoKb30wG68wQDO2zQQVF/z/sDsJZ2v7D
        EBIXi6lJWGknxXDoCcP6mMHj8SduaNyDrPgy+KKQ0v0NHCBwz3njp/fNDoBR6dtm0LKaGj
        8ef5L0FGK7MCcErB33KvUzcx0pN0VYI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-y_kux-AxNSeR2iCa5Z6D9A-1; Thu, 11 Jun 2020 15:38:38 -0400
X-MC-Unique: y_kux-AxNSeR2iCa5Z6D9A-1
Received: by mail-qv1-f72.google.com with SMTP id q5so5137177qvp.23
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 12:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+T/pLFOFWhPqP/4Y2+KijPsKT8TaUEKgCEsaihLS+Sg=;
        b=JCkYeHjKJY2PhFxwYAXXgXLcp7/bNWXNX+4uyUh9JoR1zsfjs5aZIaImH/8bTJcs1u
         VnoRIhi8o1AGDgxOadgtghnzZizWkst0ee9gA7wbGHiIB0iyNg1GIhebwZYJp8EtXauV
         jRl3G8BkhsYtjWOLm2BigvM7HSdfkp9W6jgZEN59PGC/9Om02Brz90mYDygz/yC3vHWn
         eKSCGaPfxHxmsSy096JWmSg+Jm1FS85G0VR9awaZmeDQSAe5xKrJkHoGhJa7A00ttQc0
         ialatVdfqdZsl+5R2PRcq2hOZ7E+5GZnlRZOSw8zqWrN8qCi36TJJsYZ2RDaPoinK0gq
         vm2Q==
X-Gm-Message-State: AOAM531cgZgoT2syKbhjZHRsqCp0cP1HRjDGhbMmrvN3xAaMy0Um1bLx
        5iMhkTeACsHOAWtEtb1QTagIjkpEgg3wqCArbl85AjAPR/3ZMtJ8qUOyQo42a933z/X8BsgvmhQ
        0g6sVzYuR+Lknn3UxUSz9GbFX6i+C
X-Received: by 2002:a05:620a:1245:: with SMTP id a5mr10654831qkl.161.1591904317562;
        Thu, 11 Jun 2020 12:38:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4dpfStmnjpuWuvm5A7olHToa/nIp2crCfHajW7c6kq15mk+mW7+DCk7P8myHlXdCLoeAhPQ==
X-Received: by 2002:a05:620a:1245:: with SMTP id a5mr10654816qkl.161.1591904317344;
        Thu, 11 Jun 2020 12:38:37 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j22sm3020783qke.117.2020.06.11.12.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 12:38:36 -0700 (PDT)
From:   trix@redhat.com
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 1/1] selftests: fpga: dfl: A test for afu interrupt support
Date:   Thu, 11 Jun 2020 12:38:27 -0700
Message-Id: <20200611193827.8302-2-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200611193827.8302-1-trix@redhat.com>
References: <20200611193827.8302-1-trix@redhat.com>
Sender: linux-kselftest-owner@vger.kernel.org
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
 # selftests: drivers/fpga: afu_intr
 # # Pass 0 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
 ok 1 selftests: drivers/fpga: afu_intr

Signed-off-by: Tom Rix <trix@redhat.com>
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  9 +++++
 .../testing/selftests/drivers/fpga/afu_intr.c | 33 +++++++++++++++++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 4 files changed, 44 insertions(+)
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
index 000000000000..e4ef3fac764d
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/afu_intr.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <linux/fcntl.h>
+#include <linux/fpga-dfl.h>
+
+#include "../../kselftest.h"
+
+int main(int argc, char *argv[])
+{
+	int devfd, status;
+	struct dfl_fpga_port_info port_info;
+	uint32_t irq_num;
+
+	devfd = open("/dev/dfl-port.0", O_RDONLY);
+	if (devfd < 0)
+		ksft_exit_skip("no fpga afu device 0\n");
+
+	/*
+	 * From fpga-dl.h :
+	 * Currently hardware supports up to 1 irq.
+	 * Return: 0 on success, -errno on failure.
+	 */
+	irq_num = -1;
+	status = ioctl(devfd, DFL_FPGA_PORT_ERR_GET_IRQ_NUM, &irq_num);
+	if (status != 0 || irq_num > 255)
+		ksft_exit_fail_msg("Could not get the number of afu error irqs\n");
+
+	close(devfd);
+	ksft_exit_pass();
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

