Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E097659B7A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 04:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiHVCa4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 22:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiHVCas (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 22:30:48 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098AB2229F;
        Sun, 21 Aug 2022 19:30:47 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id n125so9782090vsc.5;
        Sun, 21 Aug 2022 19:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xnIjsEcN4n25OOuE3ujYWSey7R6vl1yCgHuRtEPIeQM=;
        b=Mhunkwg2ed1b8By3M05qBvgu7NXP6i8qOcw20Tw5kc7w8JTkLuT+LUqlDaWb3pfWKb
         rWNr8/BI/iDVsUSsCyaEHJGSWI3XJIGdy9fz22g2O0KFcoS1PCh+7qF+TUco4beVB2MZ
         1MtbguxqIhLQFW1rSrjXAHp/Oj7FKDFSlk8SCKLakZddj8LUl2yrH7E+xVNmn2QMnUSu
         obt1vWXo0VGr5qeqlI2dCouKgVoXFSmrH6WGBisu3b8Uwp0m2VXHZKkl0PAtLhoFtLJz
         kAvMn3DrLaEZQi4wsUbQ4fstQvWI/H/7ee9P0/MH0SA6fuM2gWn4SwLB00JNuDz3WNf8
         mUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xnIjsEcN4n25OOuE3ujYWSey7R6vl1yCgHuRtEPIeQM=;
        b=dB/OfU47LWMBki9c5ZP9vSUSIO1W79nDXE02bMUD9Th+1pJyBh35ErhaBiCWJ1g6ZR
         wTKTme/UHzM+cQPxrR8PZMOSgJV8P0ugQC9fJ/FmCiqcOqmVulONWQF7NsBXqd5UO/0t
         OhZU522An4eOb45aEseXmDmCohxsqAg2Wk0k1Qq23ofKystPcw5+oQ8anOuBPi+Bcjhc
         E/LuYcOCyIo6qwjBmP0h6IKPYeg23+ENglAT401BymFSsjMfz/0ePMl5WRj2l1wzfEDd
         63pIWFeEbvsSGRZF9qGxz7fyaC8Qda97AjY7UMzNgMdac2hmqN++4oyNNqRuQDOHvhcB
         BMDw==
X-Gm-Message-State: ACgBeo27Td9+4zr6fXBJF6pJXPiQfOlL8YS/nx/A6cvCf7ZmL/FvLAxi
        Jw3490AiSbYCjjzih6aHxlEDaI26xF7ddA==
X-Google-Smtp-Source: AA6agR7/E5FFsDPkRvBdZOjaUfR0CnJriyMx2H6dCK9ZvGHuo3sfoH0pyAwMQXGNqzccQ+aKvprFsw==
X-Received: by 2002:a05:6102:313b:b0:38f:7ffa:166c with SMTP id f27-20020a056102313b00b0038f7ffa166cmr6126660vsh.46.1661135446156;
        Sun, 21 Aug 2022 19:30:46 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id y125-20020a1f3283000000b00378fe8518dcsm8330853vky.51.2022.08.21.19.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:30:45 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 7/8] lib: overflow: update reference to kunit-tool
Date:   Sun, 21 Aug 2022 23:26:45 -0300
Message-Id: <20220822022646.98581-8-tales.aparecida@gmail.com>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 lib/overflow_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 7e3e43679b73..78075106c0df 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Test cases for arithmetic overflow checks. See:
- * https://www.kernel.org/doc/html/latest/dev-tools/kunit/kunit-tool.html#configuring-building-and-running-tests
+ * "Running tests with kunit_tool" at Documentation/dev-tools/kunit/start.rst
  *	./tools/testing/kunit/kunit.py run overflow [--raw_output]
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.37.2

