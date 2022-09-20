Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527215BDD58
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Sep 2022 08:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiITGeB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 02:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiITGda (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 02:33:30 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91AE5F211;
        Mon, 19 Sep 2022 23:32:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso1487739pjd.1;
        Mon, 19 Sep 2022 23:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yuwEnwXoaUf46X5KnTey+NHWwOKJ7NmeJ4xeABPMGsg=;
        b=HjPZ9VrEmCcgG1snLBp4j40BWCfvfGUcpw1OHoGm5Z0kMcWW2r2YN9Cm9Ja3cZiFw9
         kUuTuwwVqWykvsARyB8NywiO0dJWyUKp19mTsOrM5Rs8fUb/iRP42eT5Ph5z5zjsnaqN
         A83hTLwCtfkU6iXawNmGnSJ7I7Q4BwZlXxix4bOrE+0fnDpakBwl9QzE60qw5o1fvPlP
         8vZ0Fv7Lcgekn799dsG2mlnu1O/01x0bLcg2sVlO6FSXpna1kOlnivgZxlHNZ/8490aQ
         MMLZRmjn5lJpX1QZjXnhRPlUTMhgKQgFR0lu3+iwCporjT/ZsI0e1QzNnl3PCvUVoTUu
         MIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yuwEnwXoaUf46X5KnTey+NHWwOKJ7NmeJ4xeABPMGsg=;
        b=mSITQ1wZzokq/flsalN2zrUH3uZeMA9zJ+avZT7auhDWHpJbeC1Po0btB+uQbENC0/
         oraWZcjRVHAzRVexD0S6Z6ZYwzKHSEMVmiEWX/oUiPqn5Uyil6jjAV9jutV2flN9L53H
         cMDP4AnAOZy13SjqKtXQaVtayRdN6Bn94q6mINolyhWZbA6RLk6ObFY6xMiqLEzfUZ0D
         58BNLUdPTfWPSsDh6H9qiX04xzBRjbDfxgetZ/26T4N12YRpm0jSmU0rUpA9ab+StGWX
         lEoOtoBSMlqTEzkBY2I3/kxUcQCn3BH9TDExwCx5GptWZuQab5BFJnNT5k+0bcwkFr1G
         X3pA==
X-Gm-Message-State: ACrzQf3tPoJ488i8werqf3hXqNwKA1Z4l/8pkgljt6ToceuAVSB5ZRSy
        CZipzKGnf4aa7v5X9c7ygl4=
X-Google-Smtp-Source: AMsMyM42KoeowrEq5MY7HfJvAy1VbkxblBgZxOTQmmo1VUB0uXMPh+jKuLqIj10fe+MOhy4/K2BN9Q==
X-Received: by 2002:a17:902:c245:b0:178:3912:f1fe with SMTP id 5-20020a170902c24500b001783912f1femr3476899plg.13.1663655530472;
        Mon, 19 Sep 2022 23:32:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902f35100b0016f1ef2cd44sm521530ple.154.2022.09.19.23.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:32:09 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     shuah@kernel.org
Cc:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] selftests: timers: Remove the unneeded result variable
Date:   Tue, 20 Sep 2022 06:32:02 +0000
Message-Id: <20220920063202.215088-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value adjtimex() directly instead of storing it in another
redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 tools/testing/selftests/timers/valid-adjtimex.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index 48b9a803235a..4bca39e0bd16 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -50,12 +50,10 @@ int clock_adjtime(clockid_t id, struct timex *tx)
 int clear_time_state(void)
 {
 	struct timex tx;
-	int ret;
 
 	tx.modes = ADJ_STATUS;
 	tx.status = 0;
-	ret = adjtimex(&tx);
-	return ret;
+	return adjtimex(&tx);
 }
 
 #define NUM_FREQ_VALID 32
-- 
2.25.1
