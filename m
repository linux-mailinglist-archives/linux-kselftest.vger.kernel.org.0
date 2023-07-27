Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3562276603A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 01:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjG0X1I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 19:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjG0X1H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 19:27:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDF62D40
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 16:27:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FBEF61F8C
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 23:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46960C433CC;
        Thu, 27 Jul 2023 23:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690500425;
        bh=U9eF72eZ37CI1cE+xa8X28h+BbO8qk9SjWJn/oLYilE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=OrYEkASthgU4BOmTQSZsyI6Zu2kEP+1oN+V2Qyabjpcv3eLyHdT8vXXL5m9LNwtGv
         hjVsCWRewoRwjCgX0zCLlyLfVHd+8zyLW6zjx9fzEasiGhGmBXNY+3h3xBHG465CI+
         Ks9Lf1Vsi5IbwsSrHwNF3flnjGFS0u4dGN9KYZzDjKZj/Niexr7yS4ofqROTmGYlq+
         HZBm17eGJgXoa7joDPunZgw30CjYa3FFqA5yuFQiusdJ9dL9G8/YBqmxk0rK1+cscY
         W0I3QfkL0mCWFk0zzbBT9mhVuN3A6BNoK/Hx1o1SMiJz7cfRj2t+FmnmeVFKyD8CA0
         BU6U8QIHsGBuw==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 28 Jul 2023 00:26:16 +0100
Subject: [PATCH v4 5/6] kselftest/arm64: Use shared OPTIMZER_HIDE_VAR()
 definiton
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230728-arm64-signal-memcpy-fix-v4-5-0c1290db5d46@kernel.org>
References: <20230728-arm64-signal-memcpy-fix-v4-0-0c1290db5d46@kernel.org>
In-Reply-To: <20230728-arm64-signal-memcpy-fix-v4-0-0c1290db5d46@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=broonie@kernel.org;
 h=from:subject:message-id; bh=U9eF72eZ37CI1cE+xa8X28h+BbO8qk9SjWJn/oLYilE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkwv09X8Mjn1yqAaOEMjsKIen70RXP0QJW8nIpTkh3
 lnMxM1qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZML9PQAKCRAk1otyXVSH0OI2B/
 9hXA4a3MhVplF/KUp49gZNZsDo+mb986YfPqBSVFgJXJR84jb8JBGk33xkR+fP78xIbq1x+YlH3Cor
 Trtjoa9QCbFbP5CpMW81jl7+0MRED48409wD74jGIxqWDnK9qEtdc+iZGmnC8u9EWP542zl1qZM4jT
 ZT3uWzmROX6NM1HUHTqy2vu6zsJtG6Gphkx5B0Xi437PUT1HT9deIP1RzLjg7Nih13uwVu1yeWM3aZ
 qUTXbOdZyXgfv32g2tOrXccCWBLmvRU4mD/biSzv4fH1f6SvqDospwE2+RYxtwMbd46t1i1ZYzjAnD
 jHeXqfxXILhpxL8v413Cr7UILUrRJe
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We had open coded the definition of OPTIMIZER_HIDE_VAR() as a fix but now
that we have the generic tools/include available and that has had a
definition of OPTIMIZER_HIDE_VAR() we can switch to the define.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/test_signals_utils.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
index c7f5627171dd..762c8fe9c54a 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
@@ -8,6 +8,8 @@
 #include <stdio.h>
 #include <string.h>
 
+#include <linux/compiler.h>
+
 #include "test_signals.h"
 
 int test_init(struct tdescr *td);
@@ -76,7 +78,7 @@ static __always_inline bool get_current_context(struct tdescr *td,
 	 */
 	for (i = 0; i < td->live_sz; i++) {
 		uc[i] = 0;
-		__asm__ ("" : "=r" (uc[i]) : "0" (uc[i]));
+		OPTIMIZER_HIDE_VAR(uc[0]);
 	}
 
 	td->live_uc = dest_uc;

-- 
2.30.2

