Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285C42FBE03
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 18:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404646AbhASOvO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 09:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393064AbhASMcU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 07:32:20 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2BFC061757;
        Tue, 19 Jan 2021 04:31:39 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id q20so12147016pfu.8;
        Tue, 19 Jan 2021 04:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCSydqpnHVjAmvTqsjkiTNmZXzdwl6yVgm/Kw1jmQmE=;
        b=snSA0a1Y3HOpkhm5sl1YTuqJ52tj5O+GIL4EQwK4Cu+oXDaB8AzBVwvmXn2TwSvRGV
         32vUmE8MtVBlqosgFjROj1EONMhB0CCqekPAfQkRIiUPHOlSQsJftMLR4u+LIxePGyGg
         VEHyFIUPxWZBy6hSwYZjXinAAvEfn/ERWpGyuZH+PTX+3fJIsjxIcKSvjvf+ljiJlm0c
         bwbFMykeTZFJdmkXmMT40NNRpwsXusJlQ2io7sikbOy/sY6exMHTB+22Mmj0K+SUijWn
         tjy3Z5zrXyKIMZHcPUvcobinnSs7gwe34bcVanqyhTMtak/fdpJ4UojYfexDsxQOuASm
         Votw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NCSydqpnHVjAmvTqsjkiTNmZXzdwl6yVgm/Kw1jmQmE=;
        b=pZPBcgPaRVC/L0t+Q5Pibqtju+olOED4KvnnpY1dLQd16RIOHw5A2958FVI7qhtsjO
         5F8G/p9s1WOJDepaqHw4ovEW6N9P9ta9RAs98Nxl++erxKBfkYf5fPBXAyZpXJRwlR1A
         pwa3Hx2SpoDkZVeWlzVvAOfh64rA0GIaWnIioWepvPj9avJ1cqzTxSE3dB20mbyhDzby
         YrckHUhfcLBTbR9HpFYU/odk4uszVkKNKOWTFL4E+J8qbU1eBxb1zN4i90DCRAqqIKFW
         nwteRvfiKyUI5QNnugZLbYtCeMcVIwZ1qIrcjCr48nu8rFyVv7mxD/SLgndXyyA1wjs7
         FL9g==
X-Gm-Message-State: AOAM533mqey1hiyrqy2b8EGpI8beHGlMJ2Idc3n2FsTxYaypm9PQb4tv
        8XoEuPLH0P5ZbQ+GGUZH1+rYoLeDCoc=
X-Google-Smtp-Source: ABdhPJzOFeGsNRsxwIA/iDbyjjpbz/oKvEaUi+zGM5sFdp+jAPEcTQCGUo5EPbetf6EpXiWxv1eJkA==
X-Received: by 2002:aa7:8bc3:0:b029:1ba:7a2:7720 with SMTP id s3-20020aa78bc30000b02901ba07a27720mr999384pfd.3.1611059498924;
        Tue, 19 Jan 2021 04:31:38 -0800 (PST)
Received: from sol.lan (106-69-181-154.dyn.iinet.net.au. [106.69.181.154])
        by smtp.gmail.com with ESMTPSA id q4sm19283052pgr.39.2021.01.19.04.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:31:38 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v3 3/7] selftests: remove obsolete build restriction for gpio
Date:   Tue, 19 Jan 2021 20:30:55 +0800
Message-Id: <20210119123059.102004-4-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210119123059.102004-1-warthog618@gmail.com>
References: <20210119123059.102004-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Build restrictions related to the gpio-mockup-chardev helper are
no longer relevant so remove them.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 tools/testing/selftests/Makefile | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index afbab4aeef3c..75a30a5d9945 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -123,15 +123,6 @@ ARCH           ?= $(SUBARCH)
 export KSFT_KHDR_INSTALL_DONE := 1
 export BUILD
 
-# build and run gpio when output directory is the src dir.
-# gpio has dependency on tools/gpio and builds tools/gpio
-# objects in the src directory in all cases making the src
-# repo dirty even when objects are relocated.
-ifneq (1,$(DEFAULT_INSTALL_HDR_PATH))
-	TMP := $(filter-out gpio, $(TARGETS))
-	TARGETS := $(TMP)
-endif
-
 # set default goal to all, so make without a target runs all, even when
 # all isn't the first target in the file.
 .DEFAULT_GOAL := all
-- 
2.30.0

