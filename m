Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F68573E00
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 22:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbiGMUqi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237182AbiGMUqh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 16:46:37 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA883136B
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 13:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=k1; bh=C
        3jVyBf6GniopPTZoyMQo27a4Ev3qmbBWb69XgAXuzs=; b=Rtjf4l0TxJXF2izXb
        a86+RwDpFvKzNYxo+szvnsddqDk/ujOuojmMrX5OxJnrq45SjiRuw6LoiL92UXJc
        4jXXp0dA1EMfw/VDtusnZ5I3FTSbsEtW+Vx5FVaXnh3f4TDWXdzDlgmwhilkxhJ9
        2kTTT/4Bt46JPOSvQr9dcmE7A8=
Received: (qmail 305591 invoked from network); 13 Jul 2022 22:46:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jul 2022 22:46:33 +0200
X-UD-Smtp-Session: l3s3148p1@o6tX4bXjkqYgAwDtxwdRAEXXn+yo/Rze
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/9] selftests: timers: valid-adjtimex: build fix for newer toolchains
Date:   Wed, 13 Jul 2022 22:46:13 +0200
Message-Id: <20220713204623.5443-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
References: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Toolchains with an include file 'sys/timex.h' based on 3.18 will have a
'clock_adjtime' definition added, so it can't be static in the code:

valid-adjtimex.c:43:12: error: static declaration of ‘clock_adjtime’ follows non-static declaration

Fixes: e03a58c320e1 ("kselftests: timers: Add adjtimex SETOFFSET validity tests")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 tools/testing/selftests/timers/valid-adjtimex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index 5397de708d3c..48b9a803235a 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -40,7 +40,7 @@
 #define ADJ_SETOFFSET 0x0100
 
 #include <sys/syscall.h>
-static int clock_adjtime(clockid_t id, struct timex *tx)
+int clock_adjtime(clockid_t id, struct timex *tx)
 {
 	return syscall(__NR_clock_adjtime, id, tx);
 }
-- 
2.35.1

