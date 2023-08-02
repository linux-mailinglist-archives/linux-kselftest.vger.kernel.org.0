Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CC676C552
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 08:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjHBGdS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 02:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjHBGdR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 02:33:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8999B
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Aug 2023 23:33:16 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a0c:5a83:9100:a000:7f51:fa54:ebdb:f0f4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 07CDA6607155;
        Wed,  2 Aug 2023 07:33:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690957995;
        bh=MPSNICo9ZNlHN3ngAhjuxMPOG6as7/43/GpFFw6CL8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=maX1WXWP77irGXi/KZSU97qbuvs/0xsdMTqwH8RYk6XA5LgVU1kpM5yLMKmzgYNd1
         7t5NCJpoQA8n4THiDn4aIW2Zii/uZsP5dybh9h1DsOk4K+xAb+2wHWNOCbPZziB51v
         K41n3MRWdFCa+FBZZ2MU3AhYhSfbAbnOrp6ogU5o7/xwVNEAQhIh5hmc850EgWs1bt
         lUasEQNrIbgwOqqrgwbejI8eu8StriwD7PjujAfUWeBE2bM+HX2LL+mWQHmRitid2U
         tW00XCjlRPYwZHrkc60r2fSnR0xlWYhAdJCvcPC/MZd44R0vjZ9jNFxHGUhx6azsxp
         KStm91MyYESfw==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     keescook@chromium.org
Cc:     kernel@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/lkdtm: Disable CONFIG_UBSAN_TRAP in test config
Date:   Wed,  2 Aug 2023 08:32:52 +0200
Message-Id: <20230802063252.1917997-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The lkdtm selftest config fragment enables CONFIG_UBSAN_TRAP to make the
ARRAY_BOUNDS test kill the calling process when an out-of-bound access
is detected by UBSAN. However, after this [1] commit, UBSAN is triggered
under many new scenarios that weren't detected before, such as in struct
definitions with fixed-size trailing arrays used as flexible arrays. As
a result, CONFIG_UBSAN_TRAP=y has become a very aggressive option to
enable except for specific situations.

`make kselftest-merge` applies CONFIG_UBSAN_TRAP=y to the kernel config
for all selftests, which makes many of them fail because of system hangs
during boot.

This change removes the config option from the lkdtm kselftest and
configures the ARRAY_BOUNDS test to look for UBSAN reports rather than
relying on the calling process being killed.

[1] commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC")'

Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

Changelog:

v2:
  - Configure the ARRAY_BOUNDS lkdtm test to match UBSAN reports instead
    of disabling the test

 tools/testing/selftests/lkdtm/config    | 1 -
 tools/testing/selftests/lkdtm/tests.txt | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index 5d52f64dfb43..7afe05e8c4d7 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -9,7 +9,6 @@ CONFIG_INIT_ON_FREE_DEFAULT_ON=y
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
 CONFIG_UBSAN=y
 CONFIG_UBSAN_BOUNDS=y
-CONFIG_UBSAN_TRAP=y
 CONFIG_STACKPROTECTOR_STRONG=y
 CONFIG_SLUB_DEBUG=y
 CONFIG_SLUB_DEBUG_ON=y
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 607b8d7e3ea3..2f3a1b96da6e 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -7,7 +7,7 @@ EXCEPTION
 #EXHAUST_STACK Corrupts memory on failure
 #CORRUPT_STACK Crashes entire system on success
 #CORRUPT_STACK_STRONG Crashes entire system on success
-ARRAY_BOUNDS
+ARRAY_BOUNDS call trace:|UBSAN: array-index-out-of-bounds
 CORRUPT_LIST_ADD list_add corruption
 CORRUPT_LIST_DEL list_del corruption
 STACK_GUARD_PAGE_LEADING
-- 
2.25.1

