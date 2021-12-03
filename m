Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB5146784F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 14:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381037AbhLCNdx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 08:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352201AbhLCNdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 08:33:52 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAACC06175A
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 05:30:28 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so4922178wme.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Dec 2021 05:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7e6xEEwbqBhZhQQISb76s4iuJL2tqNayyYZPFmmtHH4=;
        b=vWTjJuTQXs0odnKkfhWfuZ4oq8kHR5dXL67O893IlV1nFtZwNKCGbolEyeydzDXbaq
         Wd1uhZzp01NdsFTrezCYY8bvYfe1MomJCXNJt9wWdVSwuzwA5IETjVr5WAoeLY7HYPdX
         lvgzAo4gQITR2jP5onLRfyyOo9daXS4QKAuklmexVRgwaiWEdpNlwZocfGaVGhm/ZsMz
         HmAvJZgUDNCwCXa/1Zz2E4wRNP0w0MM9HVQ1W3RKN+rC+Gqimf4FRlXDBLRr96yxi9XD
         uP8Ihetuzr4wZCR/QZ+m+bubmXavbGJ2o9ftgIxrnt1RQI3tM2ju6Gy4+RI+x32UhmRX
         N6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7e6xEEwbqBhZhQQISb76s4iuJL2tqNayyYZPFmmtHH4=;
        b=nhrTyV51L9AxiXrLWUaUTIvs+e1eoks9FWR39mRWkuq5LCbKhHz9Gi/o3uFiLBgdW7
         qtwAcHJ68p5cmerqcgClMRWS68NHddXKqpSQplqJ04fpXVj9kgVA5gTFthW+HEMYYBXB
         NwIx8Jd638KvK25oTbHxidPpYH64ZOz+1sLXRy/ttX+fdzL/c3Y/0b2hx9ZjJEx/VPSD
         E+o2Ee/azRrFPbAqv+z1ajwTggQBu7CVL+lRg5grYAGPSKXuHSe3pK6AT4ZuUQdpQx62
         K+yIqksUvSZq6wHnsNEu2dYC3F3LfdSmgObtlN1x27fOVcG7wjSMumyVoZDLt9vIprHp
         rKEw==
X-Gm-Message-State: AOAM532NbnCZI4eTEYyYedVjibfUQQPCN0CUl3rO7wC7AuzxcVqCJZI6
        2K9ouhX/5tS4DAYZ34a/McqyLQ==
X-Google-Smtp-Source: ABdhPJyikGQKikVXE8VOAWZGP7+3FCDd253ukAlOlSG92UCNjA5/WvL43p099ZzQshT/l/6QKvunaA==
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr15095724wmk.27.1638538226586;
        Fri, 03 Dec 2021 05:30:26 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id j11sm2755910wrt.3.2021.12.03.05.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:30:26 -0800 (PST)
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
Subject: [PATCH v12 3/7] gpiolib: of: make fwnode take precedence in struct gpio_chip
Date:   Fri,  3 Dec 2021 14:29:59 +0100
Message-Id: <20211203133003.31786-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211203133003.31786-1-brgl@bgdev.pl>
References: <20211203133003.31786-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If the driver sets the fwnode in struct gpio_chip, let it take
precedence over the of_node.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpiolib-of.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 0ad288ab6262..91dcf2c6cdd8 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -1046,6 +1046,9 @@ void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev)
 	if (gc->parent)
 		gdev->dev.of_node = gc->parent->of_node;
 
+	if (gc->fwnode)
+		gc->of_node = to_of_node(gc->fwnode);
+
 	/* If the gpiochip has an assigned OF node this takes precedence */
 	if (gc->of_node)
 		gdev->dev.of_node = gc->of_node;
-- 
2.25.1

