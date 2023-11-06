Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E027E3116
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 00:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjKFXR6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 18:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjKFXRj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 18:17:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B98626BF;
        Mon,  6 Nov 2023 15:16:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9AFC433D9;
        Mon,  6 Nov 2023 23:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699312561;
        bh=O7HSFgEhnx5j7BpbVRWe3VcvdK1akaOH6gwOipqU6eE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4lM8voy8CHQBSzCWEvm9EpHbNXiIq3vKXjUDl6jXeH/KXTbG6Kl3Q9ZapzoqP5HT
         m458aPShdOLW3fC6PLU/PJVgT+dPclAG3NuT1o48WlL82b6WgTE5uIdaKsY7fKGPZ/
         rNIzOnuJwxSsv1ulbjbZT5MVm2pRVtdilgMgBK2Of9EnIvcSnWavWjgFDPBHZ9ZNLN
         bdGARym8i9UnhDpy/BMlLawHlPPchWFUKB+1yM9D/ub7HsMQiRxNZOjfzVjm07zPoq
         BR8fQPhPxYlBxrfKbR+4Ga9aFUvm7svpifIr6+Mpz3LHH16W0+CkJg6R/b/Hhz+V8P
         VRIphjj/rZ/PA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/11] selftests/lkdtm: Disable CONFIG_UBSAN_TRAP in test config
Date:   Mon,  6 Nov 2023 18:15:38 -0500
Message-ID: <20231106231553.3735366-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106231553.3735366-1-sashal@kernel.org>
References: <20231106231553.3735366-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ricardo Cañuelo <ricardo.canuelo@collabora.com>

[ Upstream commit cf77bf698887c3b9ebed76dea492b07a3c2c7632 ]

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
Link: https://lore.kernel.org/r/20230802063252.1917997-1-ricardo.canuelo@collabora.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/lkdtm/config    | 1 -
 tools/testing/selftests/lkdtm/tests.txt | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index 5d52f64dfb430..7afe05e8c4d79 100644
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
index 607b8d7e3ea34..2f3a1b96da6e3 100644
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
2.42.0

