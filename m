Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D599511D96
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 20:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244722AbiD0SXY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 14:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244759AbiD0SXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 14:23:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF0557B00
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 11:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4B8261EC5
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 18:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72840C385B0;
        Wed, 27 Apr 2022 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651083610;
        bh=gHy5Pzdnv72scy6DqvoelzyZ/H/4ii7tQ9zROCUikWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b2sO6LnVw7kZIEMqCaiCxxYPbBsjA1vdtFsktLbKZpIvN1Bj/mXiRHfYtwy+GjUQp
         ot04Jv/CxPGNh03LKwDV8EvLgcFHs6Hqh0zyEsl5hdLW+wR1xJEQt+jm4kcxrVJCFW
         Ws8BrXraVKQ2jL+TueqhzCb4hYfLE7YWMQ+9hjziVioepiOIZDv+2pFSXe8AjRvCSJ
         JKbvHwEuETE7VtWTKH0hU2xZnKykT1PR6RKS2VqvBKnUdQVkuN/p9uvEjvy1ebAKZ9
         6fW+HJ7ox0ZRK4knvwaIISQkkFPnjZl3vdNU7yrjfJt6yw4KeqIdHo82SX1Jngqv6q
         8JzBlQ7tP+6Hw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 2/4] selftests/arm64: Define top_srcdir for the fp tests
Date:   Wed, 27 Apr 2022 19:19:52 +0100
Message-Id: <20220427181954.357975-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220427181954.357975-1-broonie@kernel.org>
References: <20220427181954.357975-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=927; h=from:subject; bh=gHy5Pzdnv72scy6DqvoelzyZ/H/4ii7tQ9zROCUikWA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiaYlHq83De5xKzh1CORvbTOM15QkgGr2W+XxhGK0O ZyTeMPWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYmmJRwAKCRAk1otyXVSH0FshB/ 4nsTQASi7s0/tXtJ6ZDMBC9EL4uCGwwjfW1WOExi46uSjRcXH0Yz8f2Z1LPMcy+OTtUAhD936LOEUk T3X8tRnDabLKSCsWCBf9ojAhZeZpb9sFYhNN16qQ7LkVXfeMQN2FdBU9vRJhZlscgmDxjNw9Kedr4s KlnhdV1m2ODAGYmzKhvPfPyJWNQv1fTI9lQQ1rfdy1vvkArMrPO4/6HAetUeHA8jX2p6Bhe4w4pZB8 ZQKK3G7To3v/yIP7hSje6hGSuZZY890CpB822UatT7y+7CLHcALSmCGJXPtYC6ZA4oNHCbimAgJLLY 1uoEGmYgG5YEq2MRBJOE1G0w8DgUts
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some of the rules in lib.mk use a top_srcdir variable to figure out where
the top of the kselftest tree is, provide it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index a0b8cc59947e..ba758a6c6b9a 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -I../../../../../usr/include/
+# A proper top_srcdir is needed by KSFT(lib.mk)
+top_srcdir = $(realpath ../../../../../)
+
+CFLAGS += -I$(top_srcdir)/usr/include/
+
 TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg za-fork za-ptrace
 TEST_GEN_PROGS_EXTENDED := fp-pidbench fpsimd-test \
 	rdvl-sme rdvl-sve \
-- 
2.30.2

