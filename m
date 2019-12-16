Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670F8121C66
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 23:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfLPWHP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 17:07:15 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37491 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbfLPWHA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 17:07:00 -0500
Received: by mail-pf1-f202.google.com with SMTP id 13so7773217pfj.4
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2019 14:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fUKe1Twogj/Ads22pclfJ/w3t8syJGqJvSKjDedrbpw=;
        b=C3/fEW4uN1pnb8OM7dsTafKVdOwQty6te1Is6teEx+xIwPtt6UpyRl370qTrVmfj5L
         9/BoprIuaGbdjzopAOBaLBnODhEBuSztZ4TGCqUoBA35ntTHZw8rJ0hVCmNqlh7gqmBk
         Xqeriez8b1ehXW0pkDHk4T8twh4eN6gwYXUZ4F2+PEA2/3IgYZU6U+AYGJ3Iex5CP/Cu
         yDsF9vPOJyI6Mj89I2VunKR5Cel/PrwoGvu4OZ7OvZKqB1YqDEFdALgjNqxVRMFtupQJ
         JSMzuYn7OFU4NC9tt6Z2wrIi6ApUvk67cxPxWEb/1wvib/qhoJODWNO/JAxxRYMlqI6w
         3hkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fUKe1Twogj/Ads22pclfJ/w3t8syJGqJvSKjDedrbpw=;
        b=UjvwfnnZEM+V94xHXwS7LMnYnLiDOXVFzY4EluTzAHTd2mkiDsEtSybgtUYzHbi45o
         2rKFP1KzaZ/HkeyOK9KLQ7kjwUUQORtGSI6SG3YNHwugf+o/gW4862fL8JJ5dNNDfM4u
         t33frdEkPPkrAOfQFb3A+lwRF7YG1bCMhpZ0IywPqakol/yYWGovybTkFjYIL1GNuqrY
         zzYkXWaf3VMZrWKevUW/KSgxTjJF872bueDSF6sehzrDkGQbckOY2UN8vzITuNDPWGwv
         aeQIRRonhw7Oh9yaEmg7kfjpu2fqph5RFz2PC7+Tqx6QysY+NZuHSJPbb+8lmxSlIoTS
         jh5Q==
X-Gm-Message-State: APjAAAWPK97wKMeIP/3Pe4QEhpG9EnDMBnnPKcpm9txyIFGD5LOOPg96
        bf2YRwuPoqSLjrSnJmZA/idZBnxFETcilIzd8W38kQ==
X-Google-Smtp-Source: APXvYqw/XxbHOc5ekUfzWkfW60wRalC38/w8JdEAkNWydl9vLxaw9Oqdw4NQB9iWg+hS7Jnpm5VUJuMrHggDTgl/y2aI8g==
X-Received: by 2002:a63:ff52:: with SMTP id s18mr21401528pgk.253.1576534019840;
 Mon, 16 Dec 2019 14:06:59 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:05:53 -0800
In-Reply-To: <20191216220555.245089-1-brendanhiggins@google.com>
Message-Id: <20191216220555.245089-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [RFC v1 4/6] init: main: add KUnit to kernel init
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove KUnit from init calls entirely, instead call directly from
kernel_init().

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h | 9 +++++++++
 init/main.c          | 4 ++++
 lib/kunit/executor.c | 4 +---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index c070798ebb765..9da4f2cc1a3fc 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -196,6 +196,15 @@ void kunit_init_test(struct kunit *test, const char *name);
 
 int kunit_run_tests(struct kunit_suite *suite);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+int kunit_executor_init(void);
+#else
+static inline int kunit_executor_init(void)
+{
+	return 0;
+}
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 /**
  * kunit_test_suite() - used to register a &struct kunit_suite with KUnit.
  *
diff --git a/init/main.c b/init/main.c
index 91f6ebb30ef04..b299396a5466b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -103,6 +103,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/initcall.h>
 
+#include <kunit/test.h>
+
 static int kernel_init(void *);
 
 extern void init_IRQ(void);
@@ -1190,6 +1192,8 @@ static noinline void __init kernel_init_freeable(void)
 
 	do_basic_setup();
 
+	kunit_executor_init();
+
 	/* Open the /dev/console on the rootfs, this should never fail */
 	if (ksys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
 		pr_err("Warning: unable to open an initial console.\n");
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 978086cfd257d..ca880224c0bab 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -32,12 +32,10 @@ static bool kunit_run_all_tests(void)
 	return !has_test_failed;
 }
 
-static int kunit_executor_init(void)
+int kunit_executor_init(void)
 {
 	if (kunit_run_all_tests())
 		return 0;
 	else
 		return -EFAULT;
 }
-
-late_initcall(kunit_executor_init);
-- 
2.24.1.735.g03f4e72817-goog

