Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27A5573E19
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 22:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbiGMUrH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 16:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbiGMUqw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 16:46:52 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A1B313A4
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=xvIxR6FH7FCp+c
        HaoOPYWwQsjp4aowrl6rJOkVba5z0=; b=FntYzxFxekJhmB/kM1LZCdak3JPgYi
        KZpNmM3OVGYUP1YX31NpFSWlfO3lYPZA3PRItsEx5B/Aijoez3Bt66QbndT+GBvj
        vXUw+oBjF/t7rrdxllROerEH1Opo49pt8DeY9wQaqEV+BBlxfISYPjVACGTbGct+
        VsBiB3oe471+s=
Received: (qmail 305888 invoked from network); 13 Jul 2022 22:46:40 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jul 2022 22:46:40 +0200
X-UD-Smtp-Session: l3s3148p1@lRLB4bXjJqEgAwDtxwdRAEXXn+yo/Rze
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 8/9] selftests: timers: clocksource-switch: add 'runtime' command line parameter
Date:   Wed, 13 Jul 2022 22:46:20 +0200
Message-Id: <20220713204623.5443-9-wsa+renesas@sang-engineering.com>
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

So the user can decide how long the test should run.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 tools/testing/selftests/timers/clocksource-switch.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
index 5256e6215980..a1d0d33738b6 100644
--- a/tools/testing/selftests/timers/clocksource-switch.c
+++ b/tools/testing/selftests/timers/clocksource-switch.c
@@ -124,14 +124,18 @@ int main(int argc, char **argv)
 	char orig_clk[512];
 	int count, i, status, opt;
 	int do_sanity_check = 1;
+	int runtime = 60;
 	pid_t pid;
 
 	/* Process arguments */
-	while ((opt = getopt(argc, argv, "s")) != -1) {
+	while ((opt = getopt(argc, argv, "st:")) != -1) {
 		switch (opt) {
 		case 's':
 			do_sanity_check = 0;
 			break;
+		case 't':
+			runtime = atoi(optarg);
+			break;
 		default:
 			printf("Usage: %s [-s]\n", argv[0]);
 			printf("	-s: skip sanity checks\n");
@@ -167,7 +171,7 @@ int main(int argc, char **argv)
 	printf("Running Asynchronous Switching Tests...\n");
 	pid = fork();
 	if (!pid)
-		return run_tests(60);
+		return run_tests(runtime);
 
 	while (pid != waitpid(pid, &status, WNOHANG))
 		for (i = 0; i < count; i++)
-- 
2.35.1

