Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C15573E1B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 22:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbiGMUrI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 16:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbiGMUqw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 16:46:52 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4825313A0
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=3RQMJWvVubcEmy
        dV4Sxn8CpOGksV5lI/Sev4oIgvcmw=; b=QWtz3FfUMwC5c6gFVj8O5rZOvoxxqr
        PEnkDInz0RjyFcSmnW0RJN/jU7KXbxRfd12YDayb9ueIYXEeXeFUWz9wkfsiMdXX
        +dOef82nos/dq3haeY3qGJp3yCYkoUcxdFVhIVt9CCimtT56TV/Nmocil5zORfjG
        WGGRjbOpfoq3w=
Received: (qmail 305858 invoked from network); 13 Jul 2022 22:46:39 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jul 2022 22:46:39 +0200
X-UD-Smtp-Session: l3s3148p1@uza04bXjHKEgAwDtxwdRAEXXn+yo/Rze
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 7/9] selftests: timers: clocksource-switch: add command line switch to skip sanity check
Date:   Wed, 13 Jul 2022 22:46:19 +0200
Message-Id: <20220713204623.5443-8-wsa+renesas@sang-engineering.com>
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

The sanity check takes a while. If you do repeated checks when
debugging, this is time consuming. Add a parameter to skip it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../selftests/timers/clocksource-switch.c     | 40 +++++++++++++------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
index ed5b71f5b37c..5256e6215980 100644
--- a/tools/testing/selftests/timers/clocksource-switch.c
+++ b/tools/testing/selftests/timers/clocksource-switch.c
@@ -119,12 +119,26 @@ int run_tests(int secs)
 
 char clocksource_list[10][30];
 
-int main(int argv, char **argc)
+int main(int argc, char **argv)
 {
 	char orig_clk[512];
-	int count, i, status;
+	int count, i, status, opt;
+	int do_sanity_check = 1;
 	pid_t pid;
 
+	/* Process arguments */
+	while ((opt = getopt(argc, argv, "s")) != -1) {
+		switch (opt) {
+		case 's':
+			do_sanity_check = 0;
+			break;
+		default:
+			printf("Usage: %s [-s]\n", argv[0]);
+			printf("	-s: skip sanity checks\n");
+			exit(-1);
+		}
+	}
+
 	get_cur_clocksource(orig_clk, 512);
 
 	count = get_clocksources(clocksource_list);
@@ -135,19 +149,21 @@ int main(int argv, char **argc)
 	}
 
 	/* Check everything is sane before we start switching asynchronously */
-	for (i = 0; i < count; i++) {
-		printf("Validating clocksource %s\n", clocksource_list[i]);
-		if (change_clocksource(clocksource_list[i])) {
-			status = -1;
-			goto out;
-		}
-		if (run_tests(5)) {
-			status = -1;
-			goto out;
+	if (do_sanity_check) {
+		for (i = 0; i < count; i++) {
+			printf("Validating clocksource %s\n",
+				clocksource_list[i]);
+			if (change_clocksource(clocksource_list[i])) {
+				status = -1;
+				goto out;
+			}
+			if (run_tests(5)) {
+				status = -1;
+				goto out;
+			}
 		}
 	}
 
-
 	printf("Running Asynchronous Switching Tests...\n");
 	pid = fork();
 	if (!pid)
-- 
2.35.1

