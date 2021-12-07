Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C78A46B72E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 10:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhLGJhu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 04:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbhLGJht (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 04:37:49 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A80EC0611F7
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 01:34:19 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d24so28302920wra.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 01:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sS1opnsxYro85V5S3ivgztdl1gAyjYFuzaHv2So6/ZM=;
        b=sNonBzfndJ5IKEmzZzYPqV4jwO3hpA6CaFfiAmwuFcvChoELHiJA2UKyCvkFcYE+5a
         nA2Kf1CA4TAiymqLz9E+PiayIJ+J3Xn5eWkB2MiL3I9W+bccux4Db34fnVUsODBXVkKM
         9vhsasbzvkTtC1NK3sHnKbrEYIJ88wJGvdA1len/t4h51PS40QuBFM/VBsW/hw2FM351
         KMfYm4zRlG4if1uZr3Je/S+6XiV5a8ohUAnmpidAxCjsHmfU23pbweOusU1VYT8HZwnd
         d1OQuS2oHeFVgCOTVzQfzRvj3VAX9kMtC17V1AzqibHK8v/A2FVwfHZyphsQW+lGK427
         8fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sS1opnsxYro85V5S3ivgztdl1gAyjYFuzaHv2So6/ZM=;
        b=LCKrSdNPTiiXV58krAfx3ov0yIhfY55i4K7yPDbMolsFzrVVL2qqDqbiAykDikne9D
         Ysn9rM9nZFh4l9JmlAxYZlC6STMVvcYKiPCYKUrgT0uGGl5VMTfVXAuJTpOxqe1obc7f
         Ta9DzDsU5CAaDMD3slk7hxSnSYNAEZJ0OGWmLeCgmNk60IQ5WnC4x0bhf/e7rSpo0owe
         zmvQ4bLeaMqRcz54XkNEOrGfd2bE7iBIjqzF8izQFnOwUu+G4N1P71z/E1n/S7uP+XwG
         4sElXNlP3522QK/Q/34RQJQsIvQFKh8KGpWOnF58r0GgkybEpm7HRTww00HANx/N0+Ya
         A5gg==
X-Gm-Message-State: AOAM530Yer4p95NCSIg2UIc2bIvpEdR6hhJbxolxkWNBn1PddonT+zrs
        43xqnvOqhAYf5t8NBMLq85ZzYw==
X-Google-Smtp-Source: ABdhPJyjVYpdhFrnZB2H1ILzIbmxnBEl++pSrx7faWzmRLSXKqRLBQOCVxHQE3hhQ8QXoOLbBlm1EQ==
X-Received: by 2002:a5d:6312:: with SMTP id i18mr51956858wru.475.1638869657697;
        Tue, 07 Dec 2021 01:34:17 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id k13sm13783291wri.6.2021.12.07.01.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 01:34:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v13 1/7] gpiolib: provide gpiod_remove_hogs()
Date:   Tue,  7 Dec 2021 10:34:06 +0100
Message-Id: <20211207093412.27833-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211207093412.27833-1-brgl@bgdev.pl>
References: <20211207093412.27833-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently all users of gpiod_add_hogs() call it only once at system
init so there never was any need for a mechanism allowing to remove
them. Now the upcoming gpio-sim will need to tear down chips with hogged
lines so provide a function that allows to remove hogs.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpiolib.c       | 11 +++++++++++
 include/linux/gpio/machine.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index abfbf546d159..22b98a590a88 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3540,6 +3540,17 @@ void gpiod_add_hogs(struct gpiod_hog *hogs)
 }
 EXPORT_SYMBOL_GPL(gpiod_add_hogs);
 
+void gpiod_remove_hogs(struct gpiod_hog *hogs)
+{
+	struct gpiod_hog *hog;
+
+	mutex_lock(&gpio_machine_hogs_mutex);
+	for (hog = &hogs[0]; hog->chip_label; hog++)
+		list_del(&hog->list);
+	mutex_unlock(&gpio_machine_hogs_mutex);
+}
+EXPORT_SYMBOL_GPL(gpiod_remove_hogs);
+
 static struct gpiod_lookup_table *gpiod_find_lookup_table(struct device *dev)
 {
 	const char *dev_id = dev ? dev_name(dev) : NULL;
diff --git a/include/linux/gpio/machine.h b/include/linux/gpio/machine.h
index d755e529c1e3..2647dd10b541 100644
--- a/include/linux/gpio/machine.h
+++ b/include/linux/gpio/machine.h
@@ -100,6 +100,7 @@ void gpiod_add_lookup_table(struct gpiod_lookup_table *table);
 void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n);
 void gpiod_remove_lookup_table(struct gpiod_lookup_table *table);
 void gpiod_add_hogs(struct gpiod_hog *hogs);
+void gpiod_remove_hogs(struct gpiod_hog *hogs);
 #else /* ! CONFIG_GPIOLIB */
 static inline
 void gpiod_add_lookup_table(struct gpiod_lookup_table *table) {}
@@ -108,6 +109,7 @@ void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n) {}
 static inline
 void gpiod_remove_lookup_table(struct gpiod_lookup_table *table) {}
 static inline void gpiod_add_hogs(struct gpiod_hog *hogs) {}
+static inline void gpiod_remove_hogs(struct gpiod_hog *hogs) {}
 #endif /* CONFIG_GPIOLIB */
 
 #endif /* __LINUX_GPIO_MACHINE_H */
-- 
2.25.1

