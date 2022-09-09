Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2365B3607
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 13:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIILHo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 07:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiIILHm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 07:07:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4501223B6
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Sep 2022 04:07:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [213.194.152.135])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 33F006601FAE;
        Fri,  9 Sep 2022 12:07:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662721653;
        bh=4g4y9nZxJqWZ0WrJbsdi8AQVvz3bDAst05Xjpozqjkg=;
        h=From:To:Cc:Subject:Date:From;
        b=MjSeBlapXacP0KB0xO5YzJ7p+shj8QdGhjv20tvyommlBBwomiLCo4rUKSISFkjj3
         dfF2O4WHtgbg1mcD7xwc3b0zTv42tH2EEvt8513gF67hiHh3jz25h5N4PviUPbdctV
         4wcdWPPJWJjneJ2d3zqPJ/96nDDljUFWQr1A0/QKo+l1WH15i/az/ghK/MIQjEFHOe
         EOOwyU+D2zwn+j/dpHCECW0xPTQMGA0nWlMUFNndTIqVQIM1PwsFMKoDiR36f44H9Z
         MKTGKKw7JKbCoVR63PQus2/C7b/j5H0B1eUEBmX6e5ckBsWofiTfpCvT+K3c8jOpiS
         0fOJlLE7roowA==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     linux-kselftest@vger.kernel.org
Cc:     andrealmeid@igalia.com, dvhart@infradead.org, shuah@kernel.org,
        kernel@collabora.com
Subject: [PATCH] selftests/futex: fix build for clang
Date:   Fri,  9 Sep 2022 13:07:09 +0200
Message-Id: <20220909110709.1827374-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Don't use the test-specific header files as source files to force a
target dependency, as clang will complain if more than one source file
is used for a compile command with a single '-o' flag.

Use the proper Makefile variables instead as defined in
tools/testing/selftests/lib.mk.

Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
---
 tools/testing/selftests/futex/functional/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 732149011692..5a0e0df8de9b 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -3,11 +3,11 @@ INCLUDES := -I../include -I../../ -I../../../../../usr/include/
 CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
-HEADERS := \
+LOCAL_HDRS := \
 	../include/futextest.h \
 	../include/atomic.h \
 	../include/logging.h
-TEST_GEN_FILES := \
+TEST_GEN_PROGS := \
 	futex_wait_timeout \
 	futex_wait_wouldblock \
 	futex_requeue_pi \
@@ -24,5 +24,3 @@ TEST_PROGS := run.sh
 top_srcdir = ../../../../..
 DEFAULT_INSTALL_HDR_PATH := 1
 include ../../lib.mk
-
-$(TEST_GEN_FILES): $(HEADERS)
-- 
2.25.1

