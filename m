Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B5B46B733
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 10:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbhLGJhx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 04:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbhLGJhu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 04:37:50 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EB7C061746
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 01:34:20 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u17so20819773wrt.3
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 01:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xqeLJfA6Oh1Rlp7lz59H7g3xKzDYJY/OKrjBpIm8aAE=;
        b=rSoy97d1wpsKlGy4APG7XTtMNRsqxxZJn2i/lyDaJdLz0MuE+0P26BjowV/Asn2grg
         GS+AwiiTMxw2nIzEquHXmvLkjVpBIEmY5i4WxaH63JBzgZUYSoqVXugPfwqt/Vho0EPm
         X7gx4B+IUqfrgCAf9oO4KnZObU8g2sqKHxjQpghj7+W/o7c9nvIPThKw9Q0TIHgS5YFi
         k13Q0bSFjHgsglB+tgLqCBS30+YWtmKnK440DHXpfHQzIQfj0g+HdbElcISsprjLad4t
         AvlYRxXRvfriy/XZqEqrUeQzmAryR0Zkl1oAdWcV5Aa+NMPhhikdVprzsimRcucYaK49
         VZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xqeLJfA6Oh1Rlp7lz59H7g3xKzDYJY/OKrjBpIm8aAE=;
        b=JoFrFcPyORh9FonjywOa0CL/pPApoGf8EEPz0Oqw385rO6UwwwjowPA5hAKyCmODLF
         Bq1k5EMBMtc+bkemYRrBDR8FwfR8dSgv6/jwzM6rXkMbKQWt5tESH2ZUm7VFh4MDJ6If
         6WDgNUdHtjRiWzaDoL7OJDwiFewxWds2gVCeVF3SRECniIyDTYgLPU6gqZkoZmQWoSvF
         RIV49Tk8gmsNg/VYVWuGGDTaqcsATmz0+TBibCfBFTs/8FKvPfhhuZTUrM8bWmAsbboR
         nYMEOUcYoHo+KeRzz+uJxiXMf6Au7WnjJaNEkWCkp6XIHzmSc4ouGoojvu1EK7N/tPnV
         HefQ==
X-Gm-Message-State: AOAM5327hEwcdOHAZRBTL2nGRe4W9AuPRlhEU2/2MP13BfQSUky3y2jF
        xnNjpqfz7AJYOFCi7RSb0vga8A==
X-Google-Smtp-Source: ABdhPJxMAS0B/l49bX/NLJz0MZ8BxngYMy7YN2tGkwgFAHWfPt7KPrxX+UgXAOjWdqTRZkBJ1Aq06Q==
X-Received: by 2002:adf:a1d4:: with SMTP id v20mr48940915wrv.190.1638869658374;
        Tue, 07 Dec 2021 01:34:18 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id k13sm13783291wri.6.2021.12.07.01.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 01:34:18 -0800 (PST)
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
Subject: [PATCH v13 2/7] gpiolib: allow to specify the firmware node in struct gpio_chip
Date:   Tue,  7 Dec 2021 10:34:07 +0100
Message-Id: <20211207093412.27833-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211207093412.27833-1-brgl@bgdev.pl>
References: <20211207093412.27833-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Software nodes allow us to represent hierarchies for device components
that don't have their struct device representation yet - for instance:
banks of GPIOs under a common GPIO expander. The core gpiolib core
however doesn't offer any way of passing this information from the
drivers.

This extends struct gpio_chip with a pointer to fwnode that can be set
by the driver and used to pass device properties for child nodes.

This is similar to how we handle device-tree sub-nodes with
CONFIG_OF_GPIO enabled.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpiolib.c      | 7 ++++++-
 include/linux/gpio/driver.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 22b98a590a88..6af732bf4c99 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -593,13 +593,18 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *lock_key,
 			       struct lock_class_key *request_key)
 {
-	struct fwnode_handle *fwnode = gc->parent ? dev_fwnode(gc->parent) : NULL;
+	struct fwnode_handle *fwnode = NULL;
 	unsigned long	flags;
 	int		ret = 0;
 	unsigned	i;
 	int		base = gc->base;
 	struct gpio_device *gdev;
 
+	if (gc->fwnode)
+		fwnode = gc->fwnode;
+	else if (gc->parent)
+		fwnode = dev_fwnode(gc->parent);
+
 	/*
 	 * First: allocate and populate the internal stat container, and
 	 * set up the struct device.
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index a673a359e20b..b0728c8ad90c 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -289,6 +289,7 @@ struct gpio_irq_chip {
  *	number or the name of the SoC IP-block implementing it.
  * @gpiodev: the internal state holder, opaque struct
  * @parent: optional parent device providing the GPIOs
+ * @fwnode: optional fwnode providing this controller's properties
  * @owner: helps prevent removal of modules exporting active GPIOs
  * @request: optional hook for chip-specific activation, such as
  *	enabling module power and clock; may sleep
@@ -377,6 +378,7 @@ struct gpio_chip {
 	const char		*label;
 	struct gpio_device	*gpiodev;
 	struct device		*parent;
+	struct fwnode_handle	*fwnode;
 	struct module		*owner;
 
 	int			(*request)(struct gpio_chip *gc,
-- 
2.25.1

