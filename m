Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EFD22D0A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jul 2020 23:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgGXVgt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jul 2020 17:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGXVgr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jul 2020 17:36:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5229EC0698C4
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 14:36:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn17so6118904pjb.4
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JyyC+ze79w5yy/5GZgduMt6jr2+u0ZDeBjstvpXzNxo=;
        b=YiScMk/XWtUXVqYh5p1sBcHBoq+HKiwfKwQokdA4qc2uFvlvr8ibk4w/rEjwOvKZVY
         Ef7qg3WQ69UMP03as9mRkf095U8s4WtfJWI565xJLRkXVYze/57p62D37j5EtVpML7qy
         T0EL2Si3ru8lyGWzqcWFBA8owK3JVx8pMLKUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JyyC+ze79w5yy/5GZgduMt6jr2+u0ZDeBjstvpXzNxo=;
        b=Q+88LdbLJC+3CWd/SU8AeZhvHyjbc96KNmo8V/ksPDwQxkS7CC4jtGcFMOwlq3vIGu
         kLsrqiSs4IWeje+lyDP9Eqz9SIsJQOoWjGIKGdsM+FQZKhb9O6dilKdCiEtKro7knsKL
         xBDLJ0FZ3WdR7D3v804NQ1j3mjV/mtTn9v9/Rq5/7LzcYCxd8/+72/UxA2kAn0ZmPuqX
         t9MPLGT2fkuoCNeKhm4EHbJ1sJ014m6c9dMCuW/w7QKmqU1K9oLrxzV3V7MJwkGnaKyu
         C6zPV7I0fSel6SHWdnMVtPRngLBuPbAPuW153taZxA05yRus7NSJnnTjNeaKTVdDHCqS
         qSsg==
X-Gm-Message-State: AOAM531zCcN6TDBqFHZdCAcHThqj1aU43xfPsgztZWOYbnTj7Y/egW5y
        rv8a46+e+CLC8xRm7R7EwhZjZQ==
X-Google-Smtp-Source: ABdhPJyxsu62BcSNwCFWCj25rWr4izXVmF12tIRkYF1HLqnOMvTdzTKIxsfpP8hZUY20o+rsIAcniA==
X-Received: by 2002:a17:90b:1b11:: with SMTP id nu17mr7081861pjb.182.1595626606832;
        Fri, 24 Jul 2020 14:36:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s14sm7180427pjl.14.2020.07.24.14.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:36:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/19] test_firmware: Test platform fw loading on non-EFI systems
Date:   Fri, 24 Jul 2020 14:36:22 -0700
Message-Id: <20200724213640.389191-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724213640.389191-1-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On non-EFI systems, it wasn't possible to test the platform firmware
loader because it will have never set "checked_fw" during __init.
Instead, allow the test code to override this check. Additionally split
the declarations into a private header file so it there is greater
enforcement of the symbol visibility.

Fixes: 548193cba2a7 ("test_firmware: add support for firmware_request_platform")
Cc: stable@vger.kernel.org
Acked-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/efi/embedded-firmware.c | 21 ++++++++++++++++-----
 drivers/firmware/efi/embedded-firmware.h | 19 +++++++++++++++++++
 include/linux/efi_embedded_fw.h          | 13 -------------
 lib/test_firmware.c                      |  5 +++++
 4 files changed, 40 insertions(+), 18 deletions(-)
 create mode 100644 drivers/firmware/efi/embedded-firmware.h

diff --git a/drivers/firmware/efi/embedded-firmware.c b/drivers/firmware/efi/embedded-firmware.c
index a1b199de9006..0fb03cd0a5a2 100644
--- a/drivers/firmware/efi/embedded-firmware.c
+++ b/drivers/firmware/efi/embedded-firmware.c
@@ -14,11 +14,22 @@
 #include <linux/vmalloc.h>
 #include <crypto/sha.h>
 
+#include "embedded-firmware.h"
+
+#ifdef CONFIG_TEST_FIRMWARE
+# define EFI_EMBEDDED_FW_VISIBILITY
+#else
+# define EFI_EMBEDDED_FW_VISIBILITY static
+#endif
+
+EFI_EMBEDDED_FW_VISIBILITY LIST_HEAD(efi_embedded_fw_list);
+EFI_EMBEDDED_FW_VISIBILITY bool efi_embedded_fw_checked;
+
 /* Exported for use by lib/test_firmware.c only */
-LIST_HEAD(efi_embedded_fw_list);
+#ifdef CONFIG_TEST_FIRMWARE
 EXPORT_SYMBOL_GPL(efi_embedded_fw_list);
-
-static bool checked_for_fw;
+EXPORT_SYMBOL_GPL(efi_embedded_fw_checked);
+#endif
 
 static const struct dmi_system_id * const embedded_fw_table[] = {
 #ifdef CONFIG_TOUCHSCREEN_DMI
@@ -119,14 +130,14 @@ void __init efi_check_for_embedded_firmwares(void)
 		}
 	}
 
-	checked_for_fw = true;
+	efi_embedded_fw_checked = true;
 }
 
 int efi_get_embedded_fw(const char *name, const u8 **data, size_t *size)
 {
 	struct efi_embedded_fw *iter, *fw = NULL;
 
-	if (!checked_for_fw) {
+	if (!efi_embedded_fw_checked) {
 		pr_warn("Warning %s called while we did not check for embedded fw\n",
 			__func__);
 		return -ENOENT;
diff --git a/drivers/firmware/efi/embedded-firmware.h b/drivers/firmware/efi/embedded-firmware.h
new file mode 100644
index 000000000000..34113316d068
--- /dev/null
+++ b/drivers/firmware/efi/embedded-firmware.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EFI_EMBEDDED_FW_INTERNAL_H_
+#define _EFI_EMBEDDED_FW_INTERNAL_H_
+
+/*
+ * This struct and efi_embedded_fw_list are private to the efi-embedded fw
+ * implementation they only in separate header for use by lib/test_firmware.c.
+ */
+struct efi_embedded_fw {
+	struct list_head list;
+	const char *name;
+	const u8 *data;
+	size_t length;
+};
+
+extern struct list_head efi_embedded_fw_list;
+extern bool efi_embedded_fw_checked;
+
+#endif /* _EFI_EMBEDDED_FW_INTERNAL_H_ */
diff --git a/include/linux/efi_embedded_fw.h b/include/linux/efi_embedded_fw.h
index 57eac5241303..4ad5db9f5312 100644
--- a/include/linux/efi_embedded_fw.h
+++ b/include/linux/efi_embedded_fw.h
@@ -7,19 +7,6 @@
 
 #define EFI_EMBEDDED_FW_PREFIX_LEN		8
 
-/*
- * This struct and efi_embedded_fw_list are private to the efi-embedded fw
- * implementation they are in this header for use by lib/test_firmware.c only!
- */
-struct efi_embedded_fw {
-	struct list_head list;
-	const char *name;
-	const u8 *data;
-	size_t length;
-};
-
-extern struct list_head efi_embedded_fw_list;
-
 /**
  * struct efi_embedded_fw_desc - This struct is used by the EFI embedded-fw
  *                               code to search for embedded firmwares.
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 9fee2b93a8d1..62af792e151c 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -489,6 +489,7 @@ static ssize_t trigger_request_store(struct device *dev,
 static DEVICE_ATTR_WO(trigger_request);
 
 #ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
+#include "../drivers/firmware/efi/embedded-firmware.h"
 static ssize_t trigger_request_platform_store(struct device *dev,
 					      struct device_attribute *attr,
 					      const char *buf, size_t count)
@@ -501,6 +502,7 @@ static ssize_t trigger_request_platform_store(struct device *dev,
 	};
 	struct efi_embedded_fw efi_embedded_fw;
 	const struct firmware *firmware = NULL;
+	bool saved_efi_embedded_fw_checked;
 	char *name;
 	int rc;
 
@@ -513,6 +515,8 @@ static ssize_t trigger_request_platform_store(struct device *dev,
 	efi_embedded_fw.data = (void *)test_data;
 	efi_embedded_fw.length = sizeof(test_data);
 	list_add(&efi_embedded_fw.list, &efi_embedded_fw_list);
+	saved_efi_embedded_fw_checked = efi_embedded_fw_checked;
+	efi_embedded_fw_checked = true;
 
 	pr_info("loading '%s'\n", name);
 	rc = firmware_request_platform(&firmware, name, dev);
@@ -530,6 +534,7 @@ static ssize_t trigger_request_platform_store(struct device *dev,
 	rc = count;
 
 out:
+	efi_embedded_fw_checked = saved_efi_embedded_fw_checked;
 	release_firmware(firmware);
 	list_del(&efi_embedded_fw.list);
 	kfree(name);
-- 
2.25.1

