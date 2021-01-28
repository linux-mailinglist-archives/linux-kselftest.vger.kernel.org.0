Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811D4306BF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Jan 2021 05:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhA1EK1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Jan 2021 23:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhA1EKL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Jan 2021 23:10:11 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76BEC0613ED
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Jan 2021 19:38:38 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l18so3460466pji.3
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Jan 2021 19:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hollensbe-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sa0LdrGoX+icPNUx2o8ukzwwwiVedm4o00UL6XKixsg=;
        b=YPYW/IrsyOyG1AOjakkHteBBFPU5nvoDm8aBJJPD0Yir/8rFp/NOPiMNQwYUjwMT17
         T5FmWhIotbZzzBpFCmOoGjxkXVc6BAv6DU7OvGAImGkbqiwIR5GjtOGcJCCPfR8hX3W3
         V/bUAYIz0eFhmhQj47cIzyNGqLf+DLVjSLqW1xAGBuxWjUDwZSxiMqwW2ncVibPM66y/
         z127FkXe/40m2DHJWeHOo/oqqn9OOqNV2h7sQ2dscFkQLA1f6H8TGFbfoIgvEdGoaa77
         Qa9TyLIzVxNn6L2YPLMfcF8PoVIN1JkznWNEXxBhxGwDBVaNazhwMH5FdJtrs0XUWI6A
         KQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sa0LdrGoX+icPNUx2o8ukzwwwiVedm4o00UL6XKixsg=;
        b=Pt64VBpnsj8aWAhw4P+K/sClB86YTkoU6AJkjBbPdni3WR9tQeWSkqOzoiFbvKCQJB
         nxLtOUokivhZ3DaI/W8SPS2bwvhPGCXRLC1yRhKKjqcXH3SaQ3gaFzveLq2u9a6+R36X
         ynyoAtE/xasobY7F/X+4KG1jpb/27UKTxYRG39fQ9e/H+nCsETTO/CCuanqT4ypHLASG
         0A+Fl1syrWi1PRhJ7VhEAbBYCdvT+nBkrBcIpduENvLb92JQehmCBLkCtxv3isGQHsO0
         9sGyPKAUALRLOBIuegvDKDWD68rvH9mR+2I8RUGfYw3fo4jD/c9oi7t0ZFDjJxJ0kK2i
         RTYg==
X-Gm-Message-State: AOAM531TPpqqIeqwidSALHXuNnZPT5/SpzwSdoN+E8aYNQU9aEpjgqgw
        8l+rptRLwgtvuH3aLX6N7UT+OTTka/W2Hg==
X-Google-Smtp-Source: ABdhPJwLTFVLVwJjr+61VM/wCuDJHT29OtZU50xi0t+ov8vCBN3QT1VaHntaOaPlqeNTCCwE1K5YPQ==
X-Received: by 2002:a17:90b:1297:: with SMTP id fw23mr8852308pjb.219.1611805118134;
        Wed, 27 Jan 2021 19:38:38 -0800 (PST)
Received: from linuxdev.home ([104.220.82.74])
        by smtp.gmail.com with ESMTPSA id r14sm4142363pgi.27.2021.01.27.19.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 19:38:37 -0800 (PST)
From:   Erik Hollensbe <erik@hollensbe.org>
To:     linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, Erik Hollensbe <erik@hollensbe.org>
Subject: [PATCH] Correct leftover directories from make kselftest
Date:   Wed, 27 Jan 2021 19:37:43 -0800
Message-Id: <20210128033743.77040-2-erik@hollensbe.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128033743.77040-1-erik@hollensbe.org>
References: <20210128033743.77040-1-erik@hollensbe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Here are some directories that are created/filled as a part of the make
kselftest process, but not ignored.

Signed-off-by: Erik Hollensbe <erik@hollensbe.org>
---
 tools/testing/selftests/gpio/.gitignore   | 1 +
 tools/testing/selftests/timens/.gitignore | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/gpio/.gitignore b/tools/testing/selftests/gpio/.gitignore
index 4c69408f3e84..640b5cb4ed4e 100644
--- a/tools/testing/selftests/gpio/.gitignore
+++ b/tools/testing/selftests/gpio/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 gpio-mockup-chardev
+tools-gpio
diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 2e43851b47c1..95e97d7bc336 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -7,3 +7,4 @@ procfs
 timens
 timer
 timerfd
+futex
-- 
2.25.1

