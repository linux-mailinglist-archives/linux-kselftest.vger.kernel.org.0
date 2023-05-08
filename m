Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E686FB18C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 May 2023 15:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjEHNcT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 May 2023 09:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjEHNcS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 May 2023 09:32:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8AA25730;
        Mon,  8 May 2023 06:32:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C06863D1C;
        Mon,  8 May 2023 13:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0AEC433D2;
        Mon,  8 May 2023 13:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683552729;
        bh=BFbcQkbzLb4nPKXqpv19YJcpoC5MeNxkLoWEaXmzKEw=;
        h=From:Date:Subject:To:Cc:From;
        b=jIlc9eguDinI2BZ1xGzOU0lpUtej1txyRJ0U7m2jQZIQDUXdcvqR7VRWRdJNsRylW
         1oHqGmzuA38luWJfqwy9UBRZ2m7BN/5T6fHAEc2y0+wpN1nlGAfbhwCSYgdOI2//iI
         zTqdG8eO9YPt71RLp5qhx8bTmCfF7tBi3+3j1vNTlZRKvLIIledEfSXGpet+kylLFx
         nUxmODKyFqQLf9RQ6de2+hyEtJmJFS4jldACqsXhdSJJuols3X9ADrks70k1hRoV0H
         xo2dz4xUSiWH26RniJOHjXGIL1G4r71gnqK2U4CLAK4wEA99D52fG3S2fmLMw1XQ8Q
         R0ElbDtKl6b2g==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 08 May 2023 22:30:36 +0900
Subject: [PATCH v2] tools/nolibc: Fix build of stdio.h due to header
 ordering
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-nolibc-stdio-fix-v2-1-6b6bbb045a80@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHv5WGQC/32NOw6DMBAFr4JcZyN/SEGq3COi8GcNK5AdrRFJh
 Lh7DAdIOU9vNJsoyIRF3JtNMK5UKKcK+tIIP9o0IFCoLLTURrbKQMozOQ9lCZQh0geia3VA0wX
 ZdaJqzhYExzb58RDfmadjfjHW91l69pVHKkvm7xle1bH+aawKFEQrb9EbZ1XEx4SccL5mHkS/7
 /sPAEFBbMgAAAA=
To:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BFbcQkbzLb4nPKXqpv19YJcpoC5MeNxkLoWEaXmzKEw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkWPnWK8WVwLwTN8yprcVowzUgMJXNs+7+VOyCg
 lFnHGPRRiyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZFj51gAKCRAk1otyXVSH
 0F1bB/9GYlh/NzE9G7uwVV4dGZp7MeH2m/4VNUKkwMKNHsbxDy+pwDL7FgsLpfssm8FmLWyF7UY
 powYh3PLr+gCsrCeL2KddzHMXIp+MsKn3hYQb9RkuLwcZNu5qnlx+Ydowi+SDoIALxhdhgWeJT5
 WeipQuNyxzf3nvpta/fVT2V0Otnl1xSyIqmmNR3uEPXkS9EZnUWD8qGzzF7fePsN9QRAB+puN7F
 gzrcoPAUn1HBT7kp3R2yYW8a6fpNCGYHO7uVuKZpmr6HyRpFkmFzjY1Hfnfm2IZd+wnhv6qfPwU
 /5NY5c50le71sgCcEL7p6FNHmNTTGZhbHtJloGJG9DPwZ1tu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.4-rc1.
- This is now a fix for Linus' tree.
- Link to v1: https://lore.kernel.org/r/20230413-nolibc-stdio-fix-v1-1-fa05fc3ba1fe@kernel.org
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
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230413-nolibc-stdio-fix-fb42de39d099

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>

