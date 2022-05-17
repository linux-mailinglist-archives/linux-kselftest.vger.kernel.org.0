Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89CE52A363
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 15:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244034AbiEQN35 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 May 2022 09:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242454AbiEQN35 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 May 2022 09:29:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D23445AD2;
        Tue, 17 May 2022 06:29:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 218DF1F438C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652794195;
        bh=OghcwFPcTRCWDvI8lZs817I+c7kVykTUcG5aBRYeFFY=;
        h=From:To:Cc:Subject:Date:From;
        b=Fm9QH7etdUsRLDpUGIU2xnpjwvCd0C7sz2oKyCxYIaCPCLlYh+93bO7l+H411mZLc
         9sA+woYLxJkXboDBTL66WQeX+htRQ8r5LuBIfra231dLCWTVRPb/11ZmfMVTfmgN5c
         jfTtF1kT5nViIT60YFelklGRvyPCkr/cEh5u3E076xXul/6Fcn+VuuESkIrmZClg5R
         ypyBOt483f4/jG7JvvXTmDouUwVl7po9cBwHyAR71uBxvJRmPy1t5RlZRi2FjUnKKw
         xnQGsWwHvbBxxoR3+ZUeZDVDYOaFyjL+CIyUmdPaILjJjRUrc4wxmhvp87bSNaGryW
         +iTwztr3q6sYg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/lkdtm: add config
Date:   Tue, 17 May 2022 18:29:31 +0500
Message-Id: <20220517132932.1484719-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add config options which are needed for LKDTM sub-tests.
STACKLEAK_ERASING test needs GCC_PLUGIN_STACKLEAK config.
READ_AFTER_FREE and READ_BUDDY_AFTER_FREE tests need
INIT_ON_FREE_DEFAULT_ON config.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/lkdtm/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index 3041236887394..5d52f64dfb430 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -2,8 +2,10 @@ CONFIG_LKDTM=y
 CONFIG_DEBUG_LIST=y
 CONFIG_SLAB_FREELIST_HARDENED=y
 CONFIG_FORTIFY_SOURCE=y
+CONFIG_GCC_PLUGIN_STACKLEAK=y
 CONFIG_HARDENED_USERCOPY=y
 CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
+CONFIG_INIT_ON_FREE_DEFAULT_ON=y
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
 CONFIG_UBSAN=y
 CONFIG_UBSAN_BOUNDS=y
-- 
2.30.2

