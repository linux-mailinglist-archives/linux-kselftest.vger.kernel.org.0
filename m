Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F286346784C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 14:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381014AbhLCNdw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 08:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352253AbhLCNdv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 08:33:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484DDC06174A
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 05:30:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d24so5900220wra.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Dec 2021 05:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xqeLJfA6Oh1Rlp7lz59H7g3xKzDYJY/OKrjBpIm8aAE=;
        b=zWDuOzN/V1dH4p0NTobrVRwvt8EFsFmiBoNJYtFdS/IGfbAKPvdnxwSppNGZqcoRd6
         fNnxE2FM1PxiUi6yDMtP5SOZvJRKzxNwVBtBIjmPY4TSn6Ez/hBeOmv7bDu0N+6Gnt5U
         2xrhjVJu0cxrTSvS3gRkMworZxKSXNjdgWIOjhQVEyH+fRFjFvC2ZtilqBnq6VO4rQae
         4sq3BTAUEIowDDKu75nE9t/bIVB1oV2h3LXm3PzK4OwNsN95H9TXxE60YixD0aEOppSm
         LGXRq6IEyW3NmTH3oHCdjVLYomlzdVQKbhDoK36EQPvfKmfFUeGUcKexN/Cz183tduu9
         9ONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xqeLJfA6Oh1Rlp7lz59H7g3xKzDYJY/OKrjBpIm8aAE=;
        b=NJ2EJ9dVeWhwPOpNb7VzwRjh/gyK62+LU9EJD5Ezolc1z+zqMXdYfH9SjfcjRZWAMp
         Ltnn7hYIzcg8hEHSwG1pRNkx4DCNjrZhf+8An/aSSFg5zu8gzNC1J54+3kS7EQBRCoQR
         xrjBh73rR5NfYD6R1IpEzhn+MOr7yrS49wCloEuvKW3ucXjrqdCteAQYCpgozC8zxBl1
         UyqWHlXlGsVR9Pt/XKJqbBJoVL50urGvFUKpsCSLM+Rh/BtaK27+X+RsQ5MDAJn+Pnx9
         Vq+SLn1/5Wl3NEiuzuFZgAdL2snx3zCOLdk451SwTd4xbQfnHgJP1H2n8b9ShlzkYEkc
         gL7w==
X-Gm-Message-State: AOAM531jrJydUUmyJ+KL0F5UrTXfAwPMFZSkP3aOaa3IUDdZHi2ulkfA
        kzYkwZWJCqcbyEh2ae83NwxOpg==
X-Google-Smtp-Source: ABdhPJxpVAgKWu6RXur2Q/VtAQ4ojbemkc59901iwKJufP6rwcMMSvpUpn3W9blhJxr3jWobWC10Dw==
X-Received: by 2002:a05:6000:1010:: with SMTP id a16mr21945249wrx.155.1638538225847;
        Fri, 03 Dec 2021 05:30:25 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id j11sm2755910wrt.3.2021.12.03.05.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:30:25 -0800 (PST)
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
Subject: [PATCH v12 2/7] gpiolib: allow to specify the firmware node in struct gpio_chip
Date:   Fri,  3 Dec 2021 14:29:58 +0100
Message-Id: <20211203133003.31786-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211203133003.31786-1-brgl@bgdev.pl>
References: <20211203133003.31786-1-brgl@bgdev.pl>
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

