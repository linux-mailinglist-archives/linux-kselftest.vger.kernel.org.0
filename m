Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE34496190
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 15:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381396AbiAUOwe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 09:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381392AbiAUOwc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 09:52:32 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEADC06173B;
        Fri, 21 Jan 2022 06:52:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 52DF71F462EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642776750;
        bh=y6ua7Ub3gE3l3q5rm+BJjG7s5wr6jihd64dGAO2wi1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FUImww6+D0TN7J1f2u4QJSssP6A6pUFLVAnv6tev8pZy1y/jDMCaCbfUdKiWnevR/
         RvWVySQIKEf7js5aO455nZiRu4bWUQvwMZy8x2yuaeLaW0FTxRDHkzahCxNupmqWLM
         0QwDuAs8VClo3hZMrFkLgKxARpShkQIQW2d8pDgay20ZnfAOLiyoJcSyjtqYLJKwsC
         2I0sn8dB1CUHKXR6crsOmx6tDQbgn1ADJYxWnUauXJf478cF1Lom3V9/wh/rBL6Mpz
         QpeEkSjwVMcg9y9h//VVmtA03g1qs1sN4srv4ugRSRIeNfEF9PNuSQzpNZizIvz/MS
         UzKhoJ+cHGr0Q==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/lkdtm: Add UBSAN config
Date:   Fri, 21 Jan 2022 19:51:53 +0500
Message-Id: <20220121145154.1795447-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121145154.1795447-1-usama.anjum@collabora.com>
References: <20220121145154.1795447-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

UBSAN_BOUNDS and UBSAN_TRAP depend on UBSAN config option.
merge_config.sh script generates following warnings if parent config
doesn't have UBSAN config already enabled and UBSAN_BOUNDS/UBSAN_TRAP
config options don't get added to the parent config.

Value requested for CONFIG_UBSAN_BOUNDS not in final .config
Requested value:  CONFIG_UBSAN_BOUNDS=y
Actual value:

Value requested for CONFIG_UBSAN_TRAP not in final .config
Requested value:  CONFIG_UBSAN_TRAP=y
Actual value:

Fix this by including UBSAN config.

Fixes: c75be56e35b2 ("lkdtm/bugs: Add ARRAY_BOUNDS to selftests")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in V2:
	Add Fixes tag
---
 tools/testing/selftests/lkdtm/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index a7a58f885f52a..46f39ee762086 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -5,6 +5,7 @@ CONFIG_FORTIFY_SOURCE=y
 CONFIG_HARDENED_USERCOPY=y
 CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
+CONFIG_UBSAN=y
 CONFIG_UBSAN_BOUNDS=y
 CONFIG_UBSAN_TRAP=y
 CONFIG_STACKPROTECTOR_STRONG=y
-- 
2.30.2

