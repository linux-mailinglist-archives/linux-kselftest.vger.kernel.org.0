Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DA85F9871
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Oct 2022 08:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiJJGig (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Oct 2022 02:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiJJGif (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Oct 2022 02:38:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8492A46604
        for <linux-kselftest@vger.kernel.org>; Sun,  9 Oct 2022 23:38:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [213.194.152.135])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1009D6602298;
        Mon, 10 Oct 2022 07:38:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665383913;
        bh=t0hmwBQB0U4PXzk9nVZiIzTnxb5vJt9usgBc/sG3RQM=;
        h=From:To:Cc:Subject:Date:From;
        b=VAXOOmepPxevCQ6hrspngzdLacy6YhMFcqgZUe56stSdcfIsgHX5GHLpXaKiwUoWy
         Volf6oYhb+qgFSNPRAGLIcxvEPaQxy6B+/Oc8xI3+MDLoNGUDK+LWLpq6n0xSdquYH
         fhzVBIMR/898wWBYzKxwDAf7nXWQsSE4ghUf5hdPO/QipMOf+UajYkszwGddN86FkY
         9EBURxPLYKJnf0ODA46nVDZQqO+29pS8dGg/L/k8gURC4v4cEPSvhJAXs7ro0Y1RnP
         wZiZ3L5lwqz3PSCEEPExJQirqXQyPbt3HgiWoY53uU9yBaStcHQimfnTs7KqbMLnJO
         UEvZ6bO45NqvA==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, kernel@collabora.com
Subject: [RESEND PATCH] selftests/intel_pstate: fix build for ARCH=x86_64
Date:   Mon, 10 Oct 2022 08:38:11 +0200
Message-Id: <20221010063811.1323371-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Handle the scenario where the build is launched with the ARCH envvar
defined as x86_64.

Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
---
 tools/testing/selftests/intel_pstate/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/intel_pstate/Makefile b/tools/testing/selftests/intel_pstate/Makefile
index 39f0fa2a8fd6..05d66ef50c97 100644
--- a/tools/testing/selftests/intel_pstate/Makefile
+++ b/tools/testing/selftests/intel_pstate/Makefile
@@ -2,10 +2,10 @@
 CFLAGS := $(CFLAGS) -Wall -D_GNU_SOURCE
 LDLIBS += -lm
 
-uname_M := $(shell uname -m 2>/dev/null || echo not)
-ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+ARCH_PROCESSED := $(shell echo $(ARCH) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
-ifeq (x86,$(ARCH))
+ifeq (x86,$(ARCH_PROCESSED))
 TEST_GEN_FILES := msr aperf
 endif
 
-- 
2.25.1

