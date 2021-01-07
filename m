Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58242EC863
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Jan 2021 04:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbhAGC7h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jan 2021 21:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbhAGC7g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jan 2021 21:59:36 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D28DC0612F8;
        Wed,  6 Jan 2021 18:59:12 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id c132so3823647pga.3;
        Wed, 06 Jan 2021 18:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dMRs1iwMF2JFaIeyW/suJ7I5Z221XawDim3LIULysH0=;
        b=Aw44JA02gtcZMlZ5nFxAsfVE3Io/+h+ETTb8ypsYHx+djb8nqUKbnYOKpRjDFXj4ge
         rg0XQWV9GEUP4NSGTRQfo7E/GkyAtmhUP3u4WInlY/JHBRBwk+UJXT/VyuvDWFTkRkrm
         6sICm2F8Uz8Debfws9gVNp7Y3+px5H+zasF8Dl1hU5xPvSjvxGNSri6hzwsRlTmqA6km
         yvqxXo/jYEjHPtXPJaP7Kh+M5DBrtM72cug9H6zlg+Yht8Vdkif0QLd5Y1Y61+gzq27O
         D6C5UWD68uB8ep1dYr1BFvWRMk60uxZKQoCWQ8QKjKi+ETlzYqPkPjEjLPL7fM+iPHIu
         tJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dMRs1iwMF2JFaIeyW/suJ7I5Z221XawDim3LIULysH0=;
        b=t+/x98ljfi8jZLIHdW/4L6bdPTx7tFJ3XuIQqiT65/KRjuPHfCSGeGs1QORF2wtvlt
         mSi+JoP1avaLDkCocUBE2CaZQxPvbNXaUH2dDnude+/EjYNfvtlC1fusm6bngbGBX1lm
         V1dfRLI1+l0znifcyP+Myyh8C91Y9z8QoNwplLiauqdd/nGH3Yq8sUVv+ye4J5KobXo3
         ogv/i8zJch1/UI7hdBFzQpMwZkhWF2jXVXmUCN4Ip8P07zbxUajQSCmpHmZpZswst3dL
         GeBvgWrfhvybe/OVvP3fFVdi8gBCUwWhEtkTDXsF64oVQxxOEOzBUcS13vZcp/ukRnPG
         qA4w==
X-Gm-Message-State: AOAM533IH1/cTnucB5C5Bq04vO2dRc+CSD/HNz+S4htYviNB5/fi5W2D
        hIVu+YYeQJFtEDue/O8fCmQhl4mNw0X0Tw==
X-Google-Smtp-Source: ABdhPJwrDFlxMNuwAeKo6EWtG2RVDNzUlJ31uxYHFWPul6POg6GnUKidjvGF1GDRn8uK3QqoDPjgJg==
X-Received: by 2002:a62:543:0:b029:19e:5627:1c4d with SMTP id 64-20020a6205430000b029019e56271c4dmr217065pff.31.1609988351889;
        Wed, 06 Jan 2021 18:59:11 -0800 (PST)
Received: from sol.lan (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id x16sm3900120pfp.62.2021.01.06.18.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 18:59:11 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 7/7] selftests: gpio: add CONFIG_GPIO_CDEV to config
Date:   Thu,  7 Jan 2021 10:57:31 +0800
Message-Id: <20210107025731.226017-8-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210107025731.226017-1-warthog618@gmail.com>
References: <20210107025731.226017-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

GPIO CDEV is now optional and required for the selftests so add it to
the config.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
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

