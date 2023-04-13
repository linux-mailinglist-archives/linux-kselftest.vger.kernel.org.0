Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0599E6E123A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 18:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDMQ1C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 12:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDMQ1C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 12:27:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9C89EC9;
        Thu, 13 Apr 2023 09:27:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 726A160C92;
        Thu, 13 Apr 2023 16:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C6EC433EF;
        Thu, 13 Apr 2023 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681403219;
        bh=i7GBvPvooG+tmzW0Ins3MeH/7xGbUl62e/AeD/7Wy8M=;
        h=From:Date:Subject:To:Cc:From;
        b=faoA6LtQxa3jIalaOFgMr3e2UnmQ+8FXLnCVpK7QOP0gOGoIS4hEV/pAgrQY9MPZL
         Ytq04l74NhcKDDeowu3al8TY6oi9GQhQx26tDUeFyr8Te22b6ivCUDAURdFi3IeVdM
         Nvv8xLLrPhBXyGWdGbC1cILw3XguJzAnH6M5q9UpeQfEtlYqM4JnLpeRu1qf7Tn4Ax
         zee8MXOGg6GKbefU/zE00OWog/VJwclzSLDJP9Qc0LaP/lGu/3miTptUUHkL42VQ/A
         QDl6TIJQ41+/bMsfernHFUlPMgNSJ1pMOcGtHMmtjuVgwTY7X07LIm+nT0t4WYL+2n
         zAyimj+1e7axA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Apr 2023 17:26:32 +0100
Subject: [PATCH] tools/nolibc: Fix build of stdio.h due to header ordering
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-nolibc-stdio-fix-v1-1-fa05fc3ba1fe@kernel.org>
X-B4-Tracking: v=1; b=H4sIADctOGQC/x2NywqDMBBFf0Vm7UBM3KS/UlzkMepgScqM2IL47
 41dnsM93BOUhEnh0Z0gdLByLQ2GvoO0hrIQcm4M1lhnxsFhqS+OCXXPXHHmL85xtJmcz8Z7aFk
 MShgllLTe4afKduu3UFv/n57Tdf0ADmykM3kAAAA=
To:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=broonie@kernel.org;
 h=from:subject:message-id; bh=i7GBvPvooG+tmzW0Ins3MeH/7xGbUl62e/AeD/7Wy8M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkOC1RARCbU+msmqb0fQxiZmjW+8hUcwDrICPJZOGk
 GBy2AUKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZDgtUQAKCRAk1otyXVSH0EQiB/
 0WVVRlcV3AOi3rF1c+bUbo+NqWkqSAJswpAXeXAZQaNyN7zr35bCf8TPdSB+2QG6kvF24wVTxgIteP
 m9v2NOM/Z1B//AjhJSkUMJq3v5WOMp7zG8i/GNW3roDDe3DJhIm+7aRRG2Saw+rJOxHxBQ9wwD939+
 9CdFXzdPmfoT4k4+9v7MvHyZzprE2U3eS2WzWbUxNR2+4AgdzCEUbs4mhhwPhKkV5VjWx6+AoSYXEL
 0ypqSU9FXmIuiaksj1pCXefGbnUZ037ooYEllEhIfNUNYX6ywnU9VpKnM1DbT/qPK1CBOqy/q6O9gE
 iTZ/MzuTbqLYIy4HXc1RADsnZl3Fjf
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When we added fd based file streams we created references to STx_FILENO in
stdio.h but these constants are declared in unistd.h which is the last file
included by the top level nolibc.h meaning those constants are not defined
when we try to build stdio.h. This causes programs using nolibc.h to fail
to build.

Reorder the headers to avoid this issue.

Fixes: d449546c957f ("tools/nolibc: implement fd-based FILE streams")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/include/nolibc/nolibc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 04739a6293c4..05a228a6ee78 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -99,11 +99,11 @@
 #include "sys.h"
 #include "ctype.h"
 #include "signal.h"
+#include "unistd.h"
 #include "stdio.h"
 #include "stdlib.h"
 #include "string.h"
 #include "time.h"
-#include "unistd.h"
 #include "stackprotector.h"
 
 /* Used by programs to avoid std includes */

---
base-commit: 7d8214bba44c1aa6a75921a09a691945d26a8d43
change-id: 20230413-nolibc-stdio-fix-fb42de39d099

Best regards,
-- 
Mark Brown <broonie@kernel.org>

