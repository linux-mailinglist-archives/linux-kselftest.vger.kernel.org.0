Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8F059B7A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 04:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiHVCbF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 22:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiHVCaz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 22:30:55 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8F822500;
        Sun, 21 Aug 2022 19:30:50 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id t21so3821296uaq.3;
        Sun, 21 Aug 2022 19:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8OT18EiZzc67zed1enekOSrV6Cl7PLk6DpE6nm225uQ=;
        b=RPrTXZwuaXKTbsgGqVYekGHgLkS7SNnKHj/ikYP8oT3kuqDfFzbBQ6BkpZ7cOUYpDV
         dv0k8I1thp70tofntsyy8IQrm8RzoWVqjyQIWftDw/g/qrWOOrg8xu8eD7C/sEUkgItC
         UyImC+/7R4Yz3AkZ2DN/+tGiBa7mnSuHlgtNN8m25xQDDdsNc+X2L9D9TiL64n4KH5Ab
         46GzCuONuLgWdxHo4D2+EByqHe1stpecS5qW3/h2GCrQGIpO9NlmKGR4Nwc0oTnkMXs/
         AHZS/5t9fMPyqK9KjkuYUi9xPLdFEpevQTEIhbS1zAHZc79ZZN5l0uMOY6gqXzXc3jOQ
         N3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8OT18EiZzc67zed1enekOSrV6Cl7PLk6DpE6nm225uQ=;
        b=0AuIFuyXSQNLesKsZbYcBOG07U8X7M5JIt25dsLSMDO7Ghc0evwUvxxCTHGN0yHHjc
         8Fs/0OWYT3bxaNm53teb7KXT0S6Enn0iZP1mfbvZBNdH82jP9YLRRdQn9uBYaXRzDe2q
         JMpe5fUq+kwZoBjX4RPsZJvKcOVy+/JXnTi47H1Ft1Qrjr5lSbwPFPK8tQdWHqLJhhyY
         rqP0itVLFrgr2lbJ52TaLwJJMSLHPxg04/V/llFhsFgkvE6Pn5qXjIQoWxEhCx0g8+8d
         rvO+MTuEOZpZ+Qk/v0hX7AHkXIJbqPM70wVGgBrRxXsOkwztazb9fflLulCOrIsp0Xls
         q+gA==
X-Gm-Message-State: ACgBeo1vPgPm1GK9mErlrjCkHW1B/8M759u4zP0XXYmWM9OkBxSBv8vA
        Llfw0B8GoCQJ88nknkdgXC8=
X-Google-Smtp-Source: AA6agR7LJvHa1vNGh2v2eNDqr+6op1KLplZdrqtgC87Uw2T6qVqUB/tJIRVbFrRZ8HaPNtC+Y1QB2A==
X-Received: by 2002:ab0:4ad3:0:b0:392:fb0b:b617 with SMTP id t19-20020ab04ad3000000b00392fb0bb617mr6220367uae.57.1661135449859;
        Sun, 21 Aug 2022 19:30:49 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id y125-20020a1f3283000000b00378fe8518dcsm8330853vky.51.2022.08.21.19.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:30:49 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
Subject: [PATCH v2 8/8] lib: stackinit: update reference to kunit-tool
Date:   Sun, 21 Aug 2022 23:26:46 -0300
Message-Id: <20220822022646.98581-9-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822022646.98581-1-tales.aparecida@gmail.com>
References: <20220822022646.98581-1-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace URL with an updated path to the full Documentation page

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 lib/stackinit_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackinit_kunit.c b/lib/stackinit_kunit.c
index 35c69aa425b2..4591d6cf5e01 100644
--- a/lib/stackinit_kunit.c
+++ b/lib/stackinit_kunit.c
@@ -3,7 +3,7 @@
  * Test cases for compiler-based stack variable zeroing via
  * -ftrivial-auto-var-init={zero,pattern} or CONFIG_GCC_PLUGIN_STRUCTLEAK*.
  * For example, see:
- * https://www.kernel.org/doc/html/latest/dev-tools/kunit/kunit-tool.html#configuring-building-and-running-tests
+ * "Running tests with kunit_tool" at Documentation/dev-tools/kunit/start.rst
  *	./tools/testing/kunit/kunit.py run stackinit [--raw_output] \
  *		--make_option LLVM=1 \
  *		--kconfig_add CONFIG_INIT_STACK_ALL_ZERO=y
-- 
2.37.2

