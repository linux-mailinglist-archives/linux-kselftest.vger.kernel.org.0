Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AA8463A54
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 16:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbhK3Po7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 10:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbhK3Poy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 10:44:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0D1C06175A
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Nov 2021 07:41:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j3so45401128wrp.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Nov 2021 07:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R2S7hZsbaWxqnojZmhvTzst7bF3mpPWOC8sPSeXHhco=;
        b=QTTj6avdYbS8LwupOSolvw1V+rZnQJgj3t0TopIR2G1kFUI3xP7A7mxUt/6CzOaJE6
         VU8P9V4iI0tsNllKZK6GG3bPj/R3iFIkrq9w6n2pc4Ug2cCEomTUirsFnHPl8QU6h8yW
         3hzgokszrQTSfXALdUwd9tcXZ9w7SY5CPrJMbwwcAEmNDqC2pfSsTXWnYroNd0nG/xbY
         NLhPyz23m86QAWOGRRvBJnkLVblZyW7bJ0eicDqG9E1JqB/URoMJ45/t2b5cfX35bEkK
         XygvV3L24uK+f+F2JUVGCaT1Jq7zbSjHgZfnnT1d40H5wz/IDq38AjcTaRl41xaXtZME
         Txog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2S7hZsbaWxqnojZmhvTzst7bF3mpPWOC8sPSeXHhco=;
        b=oqU4i/jDx+1K8KLYrQtsnU4PnhWyNQhlRGTHCgORrJXQ1pPQAA7aVtWTq+wEzK9Tdg
         zNpjbTVqHBTyKHEXwKzkCHFNaF187HGI+KEAWuom2kG0XiibA8ohCK/155hKlnz+zCjW
         UoP3E7HHRJ7i/Y6echcxPrc5KhLIMFH7Pupgh2JYwS/AB0O2bdr1f9aycrSviMaoqrAS
         q/mgc1l02MJ2D40xF97jSKAPA5JVFaTtjG8Axm+IG8jAPzXVe85N2x8NWOjphz/PyS38
         D2Oi/SGjE4Zf+0BzdomkTPMUQa1mPk1WLrQ6bsAVxx1mEJRcxR2RdvcVjz0toZCNVaRA
         1+KA==
X-Gm-Message-State: AOAM530Cgh8Kqe3l1dBbywWyeE23VDuiUSoDzmnGaSwfXN7YEVVichzp
        FYYgbvcPgmcwvgVK8fTOMlAgzQ==
X-Google-Smtp-Source: ABdhPJzZozeWyfWUODkBPC10jiGnF31xLmcWBbejO6Sdl+B8tJJrIqIrZXAJAAPHjmpY2byw9NTVZg==
X-Received: by 2002:adf:e3ca:: with SMTP id k10mr41577212wrm.592.1638286893330;
        Tue, 30 Nov 2021 07:41:33 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id l2sm2962792wmq.42.2021.11.30.07.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 07:41:33 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v11 2/6] gpiolib: allow to specify the firmware node in struct gpio_chip
Date:   Tue, 30 Nov 2021 16:41:23 +0100
Message-Id: <20211130154127.12272-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211130154127.12272-1-brgl@bgdev.pl>
References: <20211130154127.12272-1-brgl@bgdev.pl>
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
 drivers/gpio/gpiolib.c      | 15 ++++++++++++++-
 include/linux/gpio/driver.h |  2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 22b98a590a88..2a877b4ccdee 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -593,13 +593,26 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
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
 
+#if IS_ENABLED(CONFIG_OF_GPIO)
+	if (gc->of_node && gc->fwnode) {
+		pr_err("%s: tried to set both the of_node and fwnode in gpio_chip\n",
+		       __func__);
+		return -EINVAL;
+	}
+#endif /* CONFIG_OF_GPIO */
+
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

