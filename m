Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAEF2FBA4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 15:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404794AbhASOvW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 09:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404286AbhASMdd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 07:33:33 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B486FC0613D6;
        Tue, 19 Jan 2021 04:31:59 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id e9so6262609plh.3;
        Tue, 19 Jan 2021 04:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IKTIqcQhkM3h5tDVoQgabgdbJqdqY8zjeGWY7T21Mo0=;
        b=Lc8inz36bV709VGqzp1ApA1O7MVA0IQfYykipyTgn/0gmhgn/eurbMV5w3oLjVzduZ
         5UtfH8SSHGlCX/EoDe6h+foEGVtNCBd/p2rrNlgRC7gZuXVOyL7yFg6hQHx8+56of6e4
         RPRVSqNr+WN7jF1mRyKnGaLItUF7rX921lru+jlO+aEMn+rGQCIs/T3VJ6BenyaJP7Kb
         +BP9Ltj+JJ8WHBpOqpmncF+apD5wErwKpFL/b0+koR2UW6v5a195W8K4E2YI/2m9254+
         26QMjlH1MYs1U+0Rzp7JRRAMtX0abw8CQXMf/73aSo6KXmBNqCU+CyDI4HsH7pUeUICy
         1LYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IKTIqcQhkM3h5tDVoQgabgdbJqdqY8zjeGWY7T21Mo0=;
        b=id4KJeXcZFqm6eZl731iP4Bok+dFN3A41+7mtgZfWE+jKc0dO6e/XfTSkuU4DWHGrT
         V6LNNDBgvv/pfcHT9AP24lHpDe+bYq0N6MN1spOJHzZKpYkcG6dBSRzPy2NQva5YR2/9
         NWUsAkYhogA0mVppY7AcUNT34d7S98foQazkoPGEr1dpId0cpDXnuLiZpKiE2K/rqupN
         NwRPUkb+4lO9ZmtUYKZ57roKP1j2S9RJb/oJJNYri/pEA+2FbbqoMEJTMlaP3JWX5Rce
         rBToICyaHtLpQ2wAh8NjvdSueCHBIBI7g7jCTa0GMgqDrpDeYsD3QCV+uGv8gjGvEzML
         JCAA==
X-Gm-Message-State: AOAM5331Mnws1neU2WT4Zz8B/HiYJPmVMhXbdk3lgdJ3qpOsGZOFSinx
        +C1i6IognDaK0TJZCwvzgyPq9kdNONw=
X-Google-Smtp-Source: ABdhPJya2Hri6hDk3mcgBsM+oNYotByVuzx9UzsuUXVoI4fHHkuvOqPQPg0Yubq/c7YO/relM51Clw==
X-Received: by 2002:a17:90a:f988:: with SMTP id cq8mr5313365pjb.71.1611059519011;
        Tue, 19 Jan 2021 04:31:59 -0800 (PST)
Received: from sol.lan (106-69-181-154.dyn.iinet.net.au. [106.69.181.154])
        by smtp.gmail.com with ESMTPSA id q4sm19283052pgr.39.2021.01.19.04.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:31:58 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v3 7/7] selftests: gpio: add CONFIG_GPIO_CDEV to config
Date:   Tue, 19 Jan 2021 20:30:59 +0800
Message-Id: <20210119123059.102004-8-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210119123059.102004-1-warthog618@gmail.com>
References: <20210119123059.102004-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

GPIO CDEV is now optional and required for the selftests so add it to
the config.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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

