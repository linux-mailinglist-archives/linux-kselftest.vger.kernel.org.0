Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245A25994B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 07:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346470AbiHSFdU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 01:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346464AbiHSFdS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 01:33:18 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E06612A9E;
        Thu, 18 Aug 2022 22:33:17 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id l7so3274472vsc.0;
        Thu, 18 Aug 2022 22:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PJWZ+ww9nWKSQKWZ24nwvV/pHbapUiWjpSIQxLnH82U=;
        b=jHmkDZoi5mmEoeqCUl50yLnOI0A0M/wRgcOqhvDai8m5bne/mm/ZvWe4sqXYuoN/+o
         JtLb5eKPOPgV7s6wLUcSUszmbegvR9oKNZ8m1wbAXdqQn9nAz3ed/GeC1eOLRLzTHQx9
         XBPJpuQNqGzm/RSpdavJmGYf2SGEEhTCi08G5FYkibnMOc390ErQi/C+MGhpFMYApGNa
         Lu5EdbMYzYZe/2gEIiKWbgE0f7k5IAJC5nF97j1Voo2KPpg7y9N0smceGoO8s+IRtLvf
         ENdRWoZ0uwNvdHIZykwr+cnyWaYV9Wj8kYNQyAOKeMY6HvZg2zWWPzWCK0nrIyhXwr8g
         HcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PJWZ+ww9nWKSQKWZ24nwvV/pHbapUiWjpSIQxLnH82U=;
        b=w5n3z6pX5HeU5l6aI1tNykGmvscBA8rNSgvx7vRWclazo04fvsZ+PB+MZAIoL/yDnG
         4YM0RoObcaBKK0H1J3zCrF0D2rsv8HrlJVgoB+QlJXraohVNcwmCcxpm0fO6wmhtx/Wx
         RTC//zS0QQgXA+/KN8pQ/7QUoTDfk19aNc5+ijtYdKWPQzFzmiIeMXFpdMAWcJF/LcCg
         TPjoz/cRG3cEKqjt3OZYGbgahjZsVwAxHSpJL0CzUIzYDIFuT/CzHnXE4UfG7DFDnb26
         dvrGO/kZ9sUQMHgcKi0Xx56dsG/0xe8DmKTVqgzTCOr6D7E1/E//YMfrUf3hz5U5K8n/
         z00g==
X-Gm-Message-State: ACgBeo0GsFsbmHp2j0CenROsJquV8gpGrOkSoF61VFh4zamCQStUNPE0
        H3ugUj8+jcR7s/2bxqZSy8svvQvHHFAxUg==
X-Google-Smtp-Source: AA6agR55cZ0M/b99d5Dw/K0cMaGSOr2xQ4g6dkAG1k71T4VyLWjdcHDEGp0R8f2+Ealgju6EgV4IcA==
X-Received: by 2002:a05:6102:497:b0:388:d95e:771b with SMTP id n23-20020a056102049700b00388d95e771bmr2229227vsa.44.1660887196472;
        Thu, 18 Aug 2022 22:33:16 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id w85-20020a1f9458000000b0037d0cd81996sm1999286vkd.37.2022.08.18.22.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 22:33:16 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, linux-hardening@vger.kernel.org
Subject: [PATCH 8/8] lib: stackinit: update reference to kunit-tool
Date:   Fri, 19 Aug 2022 02:32:34 -0300
Message-Id: <20220819053234.241501-9-tales.aparecida@gmail.com>
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
2.37.1

