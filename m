Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C04573E1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 22:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbiGMUrJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 16:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237282AbiGMUqy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 16:46:54 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1436A313BD
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=vq8ZQlQ80DA0gC
        LLtNMkwqtUV6zYyg5dthT1hi7uUhA=; b=CpCVps0CjacU4jE6XvMxEJz5jmeo/s
        i85lOXEKy+7ABJKoXTqawmfz4RM+kxUGSWmlr5+L138HmHhnHNPhDI6sw53Nxk2p
        QiCfGyFfigKPiSzk8zhJdakDpI8nQaubxBMmq4UjS3vAHJzrRSJxfJ780U+3WQop
        8CACpP214POXc=
Received: (qmail 305912 invoked from network); 13 Jul 2022 22:46:40 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jul 2022 22:46:40 +0200
X-UD-Smtp-Session: l3s3148p1@yKnN4bXjMKEgAwDtxwdRAEXXn+yo/Rze
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 9/9] selftests: timers: clocksource-switch: adapt to kselftest framework
Date:   Wed, 13 Jul 2022 22:46:21 +0200
Message-Id: <20220713204623.5443-10-wsa+renesas@sang-engineering.com>
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

So we have proper counters at the end of a test. We also print the
kselftest header at the end of the test, so we don't mix with the output
of the child process. There is only this one test anyhow.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 tools/testing/selftests/timers/clocksource-switch.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
index a1d0d33738b6..e2c0e4485ea8 100644
--- a/tools/testing/selftests/timers/clocksource-switch.c
+++ b/tools/testing/selftests/timers/clocksource-switch.c
@@ -182,7 +182,9 @@ int main(int argc, char **argv)
 out:
 	change_clocksource(orig_clk);
 
-	if (status)
-		return ksft_exit_fail();
-	return ksft_exit_pass();
+	/* Print at the end to not mix output with child process */
+	ksft_print_header();
+	ksft_set_plan(1);
+	ksft_test_result(!status, "clocksource-switch\n");
+	ksft_exit(!status);
 }
-- 
2.35.1

