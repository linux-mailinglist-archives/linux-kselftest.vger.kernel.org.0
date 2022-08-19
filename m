Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0525994C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 07:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346447AbiHSFdU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 01:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346462AbiHSFdR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 01:33:17 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780975FD6;
        Thu, 18 Aug 2022 22:33:13 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id o123so3528983vsc.3;
        Thu, 18 Aug 2022 22:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=AiQXm+U8E3WkfbA+FvdJ59vJ+Kvrth5UpPpIgIE1epQ=;
        b=XOtYM5HigMjn/Z81dcJSUPJAvQyGKv6skwgjXFOYjhTv6r0RN3xyFxTtnJGIFpAz8F
         5sYcmJifYTQNqgHX/tcoPreV4tMNMo8duDsTPutFsyf7t5drBxMxbzCKgc+Wc6y9mGpY
         uVMKjXYA2v0ch/betVHENW2ufvrkRy4kcD1+KHr8TMDiaSqB+Uwyi4zbNETzJMDlz2LN
         vQ6oNRG4QWuGpsUkVVQfQya3XUImP5Yw9WE7j9ebjBI8trEgxidweXUXyUtpyiq5zUv+
         dPBhx76bEHb3EYNBm0rA4AMSmImU4xngAGYA8oe4Cvgswee2IqvlFzlbAdzMC5j12btM
         FndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=AiQXm+U8E3WkfbA+FvdJ59vJ+Kvrth5UpPpIgIE1epQ=;
        b=CPsYnPNWuxFXzKKhpf5kdEKnd/ofNFnSq+d6Q5/H1PPBbAZKXLE5gn14NZSjVRG+8D
         6fg/VsFaR7TCguVlgvL89XA/qfP1xflYKRrPXB0PNItueYON5/t1QS6mT8kSIvht4iVC
         +FkmqyXeke86tbWkSOI85/lIkmAmRWczvgVKp6PxthpY4akgEdC+iAzvjLuVv4wefPRr
         HBk5xwDbFuOqAfbNM7RPzsfSUBqY8bVFRIyet/t5M72fGEWj0i0Ks+DmUilzt/Vr9BY0
         YrFDUUZ7vTZNb7sXzZJeF+Ki+ozmEemVL7tyeS6/U70XBu+EqkZDwEyGLeWHJVuW/gcN
         WKuQ==
X-Gm-Message-State: ACgBeo0W+nqZnDUY42+xZF6V81fKrzUEKpZ6+Jp5CriUbSZ2PrZm9LFw
        izyvB95WCNtugEzRvkTnIQE=
X-Google-Smtp-Source: AA6agR415xmDJQSyliXTTlM6XobnH+EKwUwtLr87HavFzkwlfCbpBdELoOiZ5XKmxHwaR6ZB+25I0Q==
X-Received: by 2002:a67:c502:0:b0:390:2656:3063 with SMTP id e2-20020a67c502000000b0039026563063mr292127vsk.83.1660887192321;
        Thu, 18 Aug 2022 22:33:12 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id w85-20020a1f9458000000b0037d0cd81996sm1999286vkd.37.2022.08.18.22.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 22:33:11 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, linux-hardening@vger.kernel.org
Subject: [PATCH 7/8] lib: overflow: update reference to kunit-tool
Date:   Fri, 19 Aug 2022 02:32:33 -0300
Message-Id: <20220819053234.241501-8-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819053234.241501-1-tales.aparecida@gmail.com>
References: <20220819053234.241501-1-tales.aparecida@gmail.com>
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
2.37.1

