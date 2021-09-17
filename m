Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5ED40F213
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Sep 2021 08:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245264AbhIQGNN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Sep 2021 02:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245106AbhIQGM5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Sep 2021 02:12:57 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E3CC0613E1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Sep 2021 23:11:35 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d202-20020a3768d3000000b003d30722c98fso62594023qkc.10
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Sep 2021 23:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a16EJJC8qIqgq8caJJ9rZnk5BIeQcHgz6nBaZlUahJ4=;
        b=mRZGnePzs2y6KqAQfe6Ck+DkP+Foa3blX6juarQJ18Sqvw6BFn2gA7pydsaxOjMZqc
         HRlb/vKtIhygpXSgaHB409dpz9AhJrphfamLZU1gG4ObG+Rmk3RUc5SRgd4y3wPc6+Ov
         89W5x13jsc5jfnYljnXFxChRd/2j1bM7BfbH66pnCquAayMNq9LOb2+cxkEtbzLxvDTl
         0bn5yMg6sIYTVEUeGE7mezPVGCVAOAvv4bBjedRlVspT8EhMbB3w9RYNzHV/yRxBbUHi
         WToToCFsOIDqWxXvvM2ABw/iKXuTenyu46QkdzOXRU+sp4UGv+vROZ3Q5AGnAFYKsd3B
         kl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a16EJJC8qIqgq8caJJ9rZnk5BIeQcHgz6nBaZlUahJ4=;
        b=aS2vOcv03AGcl+fB7iifDmuSPn8MBBxgzLQbhY/8kCRKkXw1WDw+Az82h9UUn4BehJ
         DLlfKEgsbIvjoT+IWR94S0a1/HOE4wxXyjbeHUBIYd9f0MWjjSBbAJKstSrLclw8YpO+
         d+OTIjWOwGetSVZPZCBbZmg8a9eCf9FW1FreYrunSFJ9m9EX2jid63ADW1bXGUR8LuT9
         5Bop0qMi34BKVnlc51zXjnuS1ElprxQ9he1+Qu0Vf7W8/qGUONBrr72sPECXetAUoK95
         nkCJp0G954TsPU0BN8tZspzkDhq0BvarNLhqmcofQAFwjmpSlbuMxLO2tM6UoUZe2fQJ
         N2/Q==
X-Gm-Message-State: AOAM531yko4xw+l/tLmcpUH+Xlxa+MJF9TtUfQlrZUUgqjcTce9c2yn+
        +lufbaKRVYFC2aIh41tcOBwIt4AE+RwR5qqv1O0jng==
X-Google-Smtp-Source: ABdhPJx2QRnWG7xa+kh2z4MTN26rfm570JnuU75BFe3uCQj9UmSttAn5ZQMcMCpcxKfx8N8gvMCYdb0nOiaf4ooLmBmZeA==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:4845:43ba:3ff5:2de1])
 (user=brendanhiggins job=sendgmr) by 2002:a05:6214:2e4:: with SMTP id
 h4mr9633253qvu.3.1631859094676; Thu, 16 Sep 2021 23:11:34 -0700 (PDT)
Date:   Thu, 16 Sep 2021 23:11:02 -0700
In-Reply-To: <20210917061104.2680133-1-brendanhiggins@google.com>
Message-Id: <20210917061104.2680133-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210917061104.2680133-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v1 4/6] thunderbolt: build kunit tests without structleak plugin
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        keescook@chromium.org, rafael@kernel.org, jic23@kernel.org,
        lars@metafoo.de, ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The structleak plugin causes the stack frame size to grow immensely when
used with KUnit:

drivers/thunderbolt/test.c:1529:1: error: the frame size of 1176 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Turn it off in this file.

Linus already split up tests in this file, so this change *should* be
redundant now.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/thunderbolt/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
index da19d7987d005..78fd365893c13 100644
--- a/drivers/thunderbolt/Makefile
+++ b/drivers/thunderbolt/Makefile
@@ -7,6 +7,7 @@ thunderbolt-objs += usb4_port.o nvm.o retimer.o quirks.o
 thunderbolt-${CONFIG_ACPI} += acpi.o
 thunderbolt-$(CONFIG_DEBUG_FS) += debugfs.o
 thunderbolt-${CONFIG_USB4_KUNIT_TEST} += test.o
+CFLAGS_test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 
 thunderbolt_dma_test-${CONFIG_USB4_DMA_TEST} += dma_test.o
 obj-$(CONFIG_USB4_DMA_TEST) += thunderbolt_dma_test.o
-- 
2.33.0.464.g1972c5931b-goog

