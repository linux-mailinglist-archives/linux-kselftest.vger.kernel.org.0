Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D782FBA4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 15:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404733AbhASOvQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 09:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393075AbhASMcZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 07:32:25 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B985C0613C1;
        Tue, 19 Jan 2021 04:31:44 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v19so12842614pgj.12;
        Tue, 19 Jan 2021 04:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+JLDSkRZX1A32iY7ojiQ/x6no5IxYCI3Qh2YXDpNLT4=;
        b=G3TNRC655dwGqNqNnIpiH041uEUGD6dfO7WXo/y23S0wYnsdle0LPGRJ+hPfSGO529
         ARiAuphiP9v8JVNIsTCPUI/ckP5feQ33jojN0k9ZUPtgeZbdOHhY8FhOlg/vex/3ijG9
         N02KDKpbE4CyNGDOxR6w/AJsm6As/oSa/0S+zbQm2jwd7IRW2OwEHtlUHGqGGRvKwCMC
         Hy2Tp/Cdjtb9z4CD2p/sq91RkA+cAaC12rMaBssyKC31IsX7CFs1k8moYx6qHceJbRKM
         beTL9tgkEWsO6D9JyNjHGkm+88yXzCqrseadvCzL/MBx1xjgMSXXduOaUzU61ATGOxuu
         RqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+JLDSkRZX1A32iY7ojiQ/x6no5IxYCI3Qh2YXDpNLT4=;
        b=rGQms7uv4AzV+7LR/0FJDopPyJmBFgDS+eP/C8Z6FvqyhH1+/c5puzYFy89p/ZhD5W
         egp5wD6smkwnnPUuRDFu0xckqfHobeqHdQy3Tm1XnFfpiAZHiI9KrglwTE54StQkVYZp
         rxQcKgQOdNGMKjb7yWQRkQRw2ZpPivLxu2HxeoHH+94RzQSKxHpiDTGIKGYpVhxs73tX
         S2t7uoicM+ZB8PesdTWH0Wrp90V4HHi+tcabAP8IzdYtlPVhzuFhyg01eH7Fi+jNjYYm
         5PGXSVeW4uPuIbL08ZonFBVmKDP/ZmgRnaSo5y4gAOtK1BfwLjC3eeshsnQ/PlV8JvhF
         I6Nw==
X-Gm-Message-State: AOAM5318b8WJCUjGmv/TAEHHvBPJjlgrlAsAmRhV6sEpYJpi6/mcwvJe
        jAYLE6JgVzp4MTqwADK1BsNd3exSSRU=
X-Google-Smtp-Source: ABdhPJzPdxqggGs5/R0uiPSxsoutD60rLp6zKUbBPVf7+xR0X8CLBMmMddtE1cI3STYfDhsOlTw1cw==
X-Received: by 2002:a63:cf06:: with SMTP id j6mr4214942pgg.195.1611059503900;
        Tue, 19 Jan 2021 04:31:43 -0800 (PST)
Received: from sol.lan (106-69-181-154.dyn.iinet.net.au. [106.69.181.154])
        by smtp.gmail.com with ESMTPSA id q4sm19283052pgr.39.2021.01.19.04.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:31:43 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v3 4/7] selftests: remove obsolete gpio references from kselftest_deps.sh
Date:   Tue, 19 Jan 2021 20:30:56 +0800
Message-Id: <20210119123059.102004-5-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210119123059.102004-1-warthog618@gmail.com>
References: <20210119123059.102004-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

GPIO Makefile has been greatly simplified so remove references to lines
which no longer exist.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 tools/testing/selftests/kselftest_deps.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kselftest_deps.sh b/tools/testing/selftests/kselftest_deps.sh
index bbc04646346b..00e60d6eb16b 100755
--- a/tools/testing/selftests/kselftest_deps.sh
+++ b/tools/testing/selftests/kselftest_deps.sh
@@ -129,13 +129,11 @@ l2_tests=$(grep -r --include=Makefile ": LDLIBS" | \
 		grep -v "VAR_LDLIBS" | awk -F: '{print $1}')
 
 # Level 3
-# gpio,  memfd and others use pkg-config to find mount and fuse libs
+# memfd and others use pkg-config to find mount and fuse libs
 # respectively and save it in VAR_LDLIBS. If pkg-config doesn't find
 # any, VAR_LDLIBS set to default.
 # Use the default value and filter out pkg-config for dependency check.
 # e.g:
-# gpio/Makefile
-#	VAR_LDLIBS := $(shell pkg-config --libs mount) 2>/dev/null)
 # memfd/Makefile
 #	VAR_LDLIBS := $(shell pkg-config fuse --libs 2>/dev/null)
 
-- 
2.30.0

