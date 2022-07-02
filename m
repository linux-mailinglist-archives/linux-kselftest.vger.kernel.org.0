Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3C5563CF0
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 02:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiGBAIq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Jul 2022 20:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiGBAIl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Jul 2022 20:08:41 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753001658A;
        Fri,  1 Jul 2022 17:08:40 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id l24so3683787ion.13;
        Fri, 01 Jul 2022 17:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lYMzWkKhH/3tNWhE38B085YE86rbiEGeZQZfzPGQV+s=;
        b=cCDjrDxxzafIkwcKOXVh2b12442Foe1zqigmwg/I40Hx7pWdeZ9Z0Tgt2kyYvcDi6o
         kSsYlcJCgdTlCmlkcK2XmQIvytJNI5PlxQws9peYXiNFoqjzX6FH1tgxLRoKewDnen59
         hsuaT4l1kIKtNvTg2AAstGerF6njx0HusfTS5A3lCDCCPgNExlM/MqDJjKGmWvppw5Wh
         VX6z7nggJJUnimOa1cMMMCJcW0nBlSxVSz884sHFMXZ3ZDecwDkjJgcoc5zK3hlxvsIW
         q1EsYjQy8gov5XY4r6ip9jIqggD0m/iCo3TWp1knm+jiI30Hgx2+f6TvfLMEMrsNhD/O
         /Qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lYMzWkKhH/3tNWhE38B085YE86rbiEGeZQZfzPGQV+s=;
        b=OhcQEx9iTWQuMeBhDlLTxshhlmtQjgtQGxNo8EuNNThgD4qcPBqBN5Dy0pv/7AWsPs
         ZT+qN4dcTZexoAnvLVwCgRl5Hm+HXjcQDkag5ra4DkEBFFY2MdJFv0VmWtcj8HtNj8xP
         K/qLFGaXaoGjF2tmrwJrlw2f5WnLqJSZBeT4G5fqlVyLycOyHpzWZFkuZ8hQkKIoIGxn
         JhVzPLcQd7biM+tp8Ruj7dnzjF8LDh2fvsOQI8hNlSbyKKwHy/+xJ+D/alUnVZqsiXNd
         snjaNboTYqnJusuaqbflhKl3TCNCD/jVDqtpcW5HdSnss2Vkg4BuZ2CU2xHNEU0DUiVp
         xllA==
X-Gm-Message-State: AJIora8tTSuEJoRc3Y4OWiJjxP5yGtHLRLGXWZEB/k6PS9WNgQBd61Hi
        JFVoBU6hNGGeIfj+vcd+WlGba2JvWfY=
X-Google-Smtp-Source: AGRyM1tcTe9U+ijEojMN43N2CjFcIiUVFMfAnftF67asBv2lyn1PUEGv384O7a8BThWy8a9Nwj8dsg==
X-Received: by 2002:a05:6638:3e1a:b0:33b:1257:9220 with SMTP id co26-20020a0566383e1a00b0033b12579220mr10518691jab.23.1656720519863;
        Fri, 01 Jul 2022 17:08:39 -0700 (PDT)
Received: from localhost.localdomain ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p4-20020a056638190400b0033ea1d9858bsm1010381jal.36.2022.07.01.17.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 17:08:39 -0700 (PDT)
From:   Zan Aziz <zanaziz313@gmail.com>
To:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
        shuah@kernel.org
Cc:     Zan Aziz <zanaziz313@gmail.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests:timers: globals don't need initialization
Date:   Fri,  1 Jul 2022 18:08:34 -0600
Message-Id: <20220702000834.7724-1-zanaziz313@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Global variables do not need to be initialized to 0 and checkpatch
flags this error in tools/testing/selftests/timers/alarmtimer-suspend.c:

ERROR: do not initialise globals to 0
+int final_ret = 0;

Fix this checkpatch error.

Signed-off-by: Zan Aziz <zanaziz313@gmail.com>
---
 tools/testing/selftests/timers/alarmtimer-suspend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
index 54da4b088f4c..4332b494103d 100644
--- a/tools/testing/selftests/timers/alarmtimer-suspend.c
+++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
@@ -92,7 +92,7 @@ long long timespec_sub(struct timespec a, struct timespec b)
 	return ret;
 }
 
-int final_ret = 0;
+int final_ret;
 
 void sigalarm(int signo)
 {
-- 
2.32.0

