Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A408C573E10
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 22:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbiGMUqw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 16:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbiGMUql (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 16:46:41 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356BC31375
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=1QUptC0Fjaw/XB
        AE3RD77Poi50m9roxJYgB+xYZbDKg=; b=u/nhOnI8g5Ga3p/SUrz1V4BXKZUcDA
        AMNpi+FkXOYxdbslyJ/iFuK1jBy4UtSMuJvfxrh0tav2ATbrO9eDV21AVJwkja4D
        KB954AEq5NiY0bScPYK09ndIHlQhJb+er0nRXcWQlJBpe/wCUKBIHle6Q1iYRlsr
        y3sNmQg1Vc5BQ=
Received: (qmail 305753 invoked from network); 13 Jul 2022 22:46:36 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jul 2022 22:46:36 +0200
X-UD-Smtp-Session: l3s3148p1@shyS4bXjsKYgAwDtxwdRAEXXn+yo/Rze
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 5/9] selftests: timers: clocksource-switch: fix passing errors from child
Date:   Wed, 13 Jul 2022 22:46:17 +0200
Message-Id: <20220713204623.5443-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
References: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The return value from system() is a waitpid-style integer. Do not return
it directly because with the implicit masking in exit() it will always
return 0. Access it with apropriate macros to really pass on errors.

Fixes: 7290ce1423c3 ("selftests/timers: Add clocksource-switch test from timetest suite")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 tools/testing/selftests/timers/clocksource-switch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
index ef8eb3604595..b57f0a9be490 100644
--- a/tools/testing/selftests/timers/clocksource-switch.c
+++ b/tools/testing/selftests/timers/clocksource-switch.c
@@ -110,10 +110,10 @@ int run_tests(int secs)
 
 	sprintf(buf, "./inconsistency-check -t %i", secs);
 	ret = system(buf);
-	if (ret)
-		return ret;
+	if (WIFEXITED(ret) && WEXITSTATUS(ret))
+		return WEXITSTATUS(ret);
 	ret = system("./nanosleep");
-	return ret;
+	return WIFEXITED(ret) ? WEXITSTATUS(ret) : 0;
 }
 
 
-- 
2.35.1

