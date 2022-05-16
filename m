Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272C6528B74
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 19:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbiEPQ7m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 12:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344028AbiEPQ7J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 12:59:09 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F902BE
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 09:59:08 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id p12-20020a9d4e0c000000b00606b40860a3so10466312otf.11
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SVSiugKnf8wJOdqfsw/q25vFSKAj+trMZCib/b4SHsE=;
        b=xNCEcWiOUolnZIhOk9qAhe8FtKNTtG4QDT4fXmc/QcMlaIRHGYz4A8S+a4ZjvML9/U
         hN5zefWJ7NGp/7Xp7QcDmQBoh8TdCJy/JaCya1YhOyC80YJ6/MAahbaiUScy5TEqisNF
         Sr2iVxyK2WaSKhjWP24w4DlZ/KBux/9tlZrYQFQTET5qgcfs1PKjhP5F9HNb/WbVebre
         vyxNKYUcDEUCYbHj0MxbqZoLtGEeJYK0kZhcbFaJG2N8zCDXo790bDns7NNe3bJ25vgJ
         ZM26/1iZSZP39BGtEA4JZM44t8/QvfyOyAOng2wGnv2z1DNsb3TTcMoz0JWFNV1tCwA0
         Vy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SVSiugKnf8wJOdqfsw/q25vFSKAj+trMZCib/b4SHsE=;
        b=MMrf5bQZKfdnr4+en7ZBJlNYGBKOFqZwb8YBs3GRNeQWCFvohRYJq8m1mHQM14LTAl
         x/6lAhB3omIM6H9bnYG4jdiS3H2KSQgd/tQcc2+Yml83y5fyRJ9HSZ74Zv2ipisXBYD6
         QsrrNjUvW8hDbi7UjsGslJ9BCSOSV0GyfMIqLtX5TW1uNQKLn3BgWKuDVu4/R1AHCm68
         6nR/zxQ6/vNSDIGdtKsgSP41ploFHBN1KijgF/pj5JXy5OznXaYWNEotUL2LrKdz31KY
         Wm6zETCxTpFZLkmZrPDt0sFzx0D6dfoYuDyYb1oWxfwIHBHFRuyw7n77I/Xmb4jHmzA2
         taHg==
X-Gm-Message-State: AOAM532vEzFaZ4ZZpHKEwpMsBEiaND6unQ6gk6LN5z41HNaAx0/dfFv+
        J76DnQh7feLT7Bbawqny9OR80hUDP2y2qMUcjKw=
X-Google-Smtp-Source: ABdhPJzQ7BmCCqxGUIZGnvyc1mw1E81cQoTtZL9xm0IeZZSKzJzyHwgpPQy3DEs0+x5z6lGJSN1KAw==
X-Received: by 2002:a9d:24e7:0:b0:606:56ad:91bb with SMTP id z94-20020a9d24e7000000b0060656ad91bbmr6614249ota.40.1652720348007;
        Mon, 16 May 2022 09:59:08 -0700 (PDT)
Received: from winterfell.papolivre.org (winterfell.papolivre.org. [198.58.116.17])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b000e686d1387bsm5966536oab.21.2022.05.16.09.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:59:07 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14d:7224:81d8:1a5f:b39d:3db4:59e8])
        by winterfell.papolivre.org (Postfix) with ESMTPSA id C9C911F296;
        Mon, 16 May 2022 13:59:06 -0300 (-03)
From:   Antonio Terceiro <antonio.terceiro@linaro.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest: alsa: handle cross compilation
Date:   Mon, 16 May 2022 13:58:56 -0300
Message-Id: <20220516165856.401452-1-antonio.terceiro@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Calling just `pkg-config` is adequate for native builds, but finding the
foreign libraries with pkg-config needs pkg-config to be called via its
architecture-specific wrapper. This works in Debian, where there is a
corresponding *-pkg-config wrapper script for each enabled foreign
architecture, just like there are *-gcc, *-ld.

Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
---
 tools/testing/selftests/alsa/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index f64d9090426d..f5675b3c929d 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -1,8 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
-CFLAGS += $(shell pkg-config --cflags alsa)
-LDLIBS += $(shell pkg-config --libs alsa)
+PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
+
+CFLAGS += $(shell $(PKG_CONFIG) --cflags alsa)
+LDLIBS += $(shell $(PKG_CONFIG) --libs alsa)
 
 TEST_GEN_PROGS := mixer-test
 
-- 
2.35.1

