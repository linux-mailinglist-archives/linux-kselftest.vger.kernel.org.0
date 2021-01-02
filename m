Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96262E8626
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jan 2021 03:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbhABCby (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Jan 2021 21:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbhABCby (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Jan 2021 21:31:54 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305D0C0617A0;
        Fri,  1 Jan 2021 18:31:13 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v1so6730324pjr.2;
        Fri, 01 Jan 2021 18:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zR1/aMb5vn8qgmpb6q7ElMkFnsSKmzZ0BJxomysAHCE=;
        b=LU44yvR32x3PpGXFBI0z7JTzB3cnMWiIICMy3c6V5dk4OA3M6Xa1v/z35t2LOwC/aO
         Q0BOPbnZFko4UVvTZua4HvOQX+IaAl2yB5EGVZ6DdrhQx7jwdv9TT//xD3uvRSzaDK1d
         03zCqywAgGoMRvrfuHwSpM0rPuljn3kjdoBLf82EW1Erc28M4lOIN8dmIwJX/AtQyoau
         QE6snfV4+15iyGLPWw3THIrZLHAikQBHc2ZYlHNnHoqJzbObN76X8y4C1RjPgoiV334X
         OTArmleTEcuNvAI5bYZXSONULVyzz2zagmpA0uZVeB/vWREDBr44G1ntANmarJYDxZp/
         JsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zR1/aMb5vn8qgmpb6q7ElMkFnsSKmzZ0BJxomysAHCE=;
        b=hWQbUsdxXs+IgW7A37Up3O336zKmymdtaMEzeym3jpsBNlllyoT9DDaGm4itFET8F3
         FsKhb1DL9+uwAX3nvy+OolxS5o+AoTZxx4V/O1uUiCjDtYpiIkb4G9G8SV+ZS79TH8EB
         tGY1v36TygH9aM8zwx6rIl5UJTDA4ejvqTj5WsK9S0Zr/kYDUm3pVBwFM6AhzWXhy1jZ
         a+LL4AqRWbPsh0SJWOVYSdNg558TtXbUkvwe6nr5GGMel61ip1p6tUG2FpfoK2t1XYJx
         Z1ZctJzKsWAfjW3VXfN+ShZZEXQ7oKBti5Zf0yQDvWBfdhly3ZCVfpDlGOrMW7Slco0O
         bNFw==
X-Gm-Message-State: AOAM532kJbRX5xB6L9Lg8knhKntoqs0umuMUrlYYkCuYSBRSCsZcy05e
        KJ9Jj77kAcSb4xlnwg70/AapNBSe/gRr7Q==
X-Google-Smtp-Source: ABdhPJxCItGcUiUOnZUii8r/2g+w1e5ZyuHiSLyhFC3fm1lzAxapR1RmlJ6OIuPFzZf0UrrInrCIvg==
X-Received: by 2002:a17:902:9342:b029:dc:4868:d9af with SMTP id g2-20020a1709029342b02900dc4868d9afmr43447197plp.33.1609554672474;
        Fri, 01 Jan 2021 18:31:12 -0800 (PST)
Received: from sol.lan (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id cl23sm13995664pjb.23.2021.01.01.18.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 18:31:11 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 7/7] selftests: gpio: add CONFIG_GPIO_CDEV to config
Date:   Sat,  2 Jan 2021 10:29:49 +0800
Message-Id: <20210102022949.92304-8-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210102022949.92304-1-warthog618@gmail.com>
References: <20210102022949.92304-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

GPIO CDEV is now optional and required for the selftests so add it to
the config.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 tools/testing/selftests/gpio/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/gpio/config b/tools/testing/selftests/gpio/config
index abaa6902b7b6..ce100342c20b 100644
--- a/tools/testing/selftests/gpio/config
+++ b/tools/testing/selftests/gpio/config
@@ -1,2 +1,3 @@
 CONFIG_GPIOLIB=y
+CONFIG_GPIO_CDEV=y
 CONFIG_GPIO_MOCKUP=m
-- 
2.30.0

