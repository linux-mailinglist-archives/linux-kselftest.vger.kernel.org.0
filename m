Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B92F7B7FAE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 14:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbjJDMsy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 08:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242491AbjJDMsw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 08:48:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1335693;
        Wed,  4 Oct 2023 05:48:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C65C433C9;
        Wed,  4 Oct 2023 12:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696423728;
        bh=GCXPtG2gS4xIl3E4smfsoQMIyJon1TmicxEyAyK0wVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cXzreQBMuuF74CBgHzSwEN2XP6h0oZD0m2xCM0zXXfhTbBayi7b7BfShjv/w/GuwX
         dcleLXW/kTjBlrlwrCkSAwOnrkrUMQ8ZPR+MPv8maO0c5cpLYMSxcSCA3hTnnBG3fx
         FpSawKI8+A2WhDqTGl1Sqqb7u0eQJa82fgEHccU6kdfKq3uCPVskQmzIqGFrXPeZgE
         Tl0+U0BvwXOvIl0LC2W7igEasQ2LnMESCOjarMQOSEaItwmZXGox9RenhfWE5waGQq
         5Bys358TN2G57KT8cRrUbO9E8U3MPS1t45ikV712Dys5mBOly9cdjewrOSjsULg9Zv
         VWHL+PeaBg7Hw==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 2/2] kbuild: Merge per-arch config for kselftest-merge target
Date:   Wed,  4 Oct 2023 14:48:37 +0200
Message-Id: <20231004124837.56536-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004124837.56536-1-bjorn@kernel.org>
References: <20231004124837.56536-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Some kselftests has a per-arch config,
e.g. tools/testing/selftests/bpf/config.s390x.

Make sure these configs are picked up by the kselftest-merge target.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 170fb2f5e378..0303acb311cc 100644
--- a/Makefile
+++ b/Makefile
@@ -1367,7 +1367,7 @@ kselftest-%: headers FORCE
 PHONY += kselftest-merge
 kselftest-merge:
 	$(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
-	$(Q)find $(srctree)/tools/testing/selftests -name config | \
+	$(Q)find $(srctree)/tools/testing/selftests -name config -o -name config.$(UTS_MACHINE) | \
 		xargs $(srctree)/scripts/kconfig/merge_config.sh -y -m $(objtree)/.config
 	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
-- 
2.39.2

