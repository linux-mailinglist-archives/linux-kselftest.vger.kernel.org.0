Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927776A35E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 01:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjB0AWD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Feb 2023 19:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0AWD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Feb 2023 19:22:03 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35B8CDD4;
        Sun, 26 Feb 2023 16:22:01 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id y10so416615qtj.2;
        Sun, 26 Feb 2023 16:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677457321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5be06YHYRkke1Ci4JVJc3LyV4Jo5b0vnSbZ7t2ii5Mo=;
        b=O95IqFgj68nB6P/Llv29DHMzJgP1wxZsLN9fh3QjGxpIUFBlTkj/W6KFGcpSCU1/Y+
         cktLsuuR/evXRxVGHkmqeWlD2mzyak+0vjDlPAPJ6niTX+GZMaLm/+juH2kpIyYJxLDP
         gdsFINv/Y+pXue47VYLP1Oxm98M3qLEvHj8uEvs1Pl01Jk14DssNJzUCAJmumTMgI8K9
         S/f2+CUVwjVkY3Tj5cXqB70vBNQ50UlSzUHYXlBcqW5dwf53fmATQvNm++JqS9zCmRsf
         CKVsYd2AYN+sqZ4x38FuKzog7ZGQcP/uO+mq6arNZZF0udzewYSfUMBtRTHCCjsninyy
         2ihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677457321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5be06YHYRkke1Ci4JVJc3LyV4Jo5b0vnSbZ7t2ii5Mo=;
        b=AOmtEz8C0ExuhJ1ZXk+SSkXB/PmfdDLvSEmzg67I/mIh2HbxlOrsYqeJRFf2mvhs8f
         //NfA1cTGH6/GBcKvZ+KxdTAte3ZdRo1nnZUSocIOm+uVNUby9aeAP0S6ewD5lphG9nl
         Uc3cccjVuSEJkYDR3v1bspOXN8tV1BYJMGCIKgS6G4pZLfzxK9XcXmAXNjkOMZE/OAti
         3JAAA8nyfyVsLaH5PXCvU0Vta5SO5X5cgZA7w16KXRAyR2uL/WV3VzYAdb0rflX6MUGe
         9pR74EyCdLqIODr7W9r12QdXyktT1Bfm3f5RT7YDg7FTSDuyXtyLWzm/kctpehnleMeI
         lCTw==
X-Gm-Message-State: AO0yUKUmx1Nejr8NQql516giMec8zVEkuonWbtip+ECORzffhS/R36eN
        50kEMfBNAO8AF4pwswBGJ5E=
X-Google-Smtp-Source: AK7set+ZvlZjQTIMJrvwb52BT2vwI4cRuXdGf37WVLj+2OyNfYrTEM/vvRdDjmaH0UQZEtlXTB/RyQ==
X-Received: by 2002:a05:622a:184:b0:3b4:7efb:36a7 with SMTP id s4-20020a05622a018400b003b47efb36a7mr12705451qtw.27.1677457320657;
        Sun, 26 Feb 2023 16:22:00 -0800 (PST)
Received: from localhost.localdomain (c-68-48-11-160.hsd1.mi.comcast.net. [68.48.11.160])
        by smtp.gmail.com with ESMTPSA id o26-20020ac8429a000000b003b64f1b1f40sm3698071qtl.40.2023.02.26.16.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 16:22:00 -0800 (PST)
From:   Sukrut Bellary <sukrut.bellary@gmail.com>
To:     shuah@kernel.org, ray.huang@amd.com, li.meng@amd.com
Cc:     Sukrut Bellary <sukrut.bellary@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest: amd-pstate: Fix spelling mistakes
Date:   Sun, 26 Feb 2023 16:21:55 -0800
Message-Id: <20230227002155.3287-1-sukrut.bellary@gmail.com>
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

Fix spelling mistakes in run.sh "drvier" => "driver" and
in gitsource.sh "senconds" => "seconds".

Signed-off-by: Sukrut Bellary <sukrut.bellary@gmail.com>
---
 tools/testing/selftests/amd-pstate/gitsource.sh | 4 ++--
 tools/testing/selftests/amd-pstate/run.sh       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
index dbc1fe45599d..5f2171f0116d 100755
--- a/tools/testing/selftests/amd-pstate/gitsource.sh
+++ b/tools/testing/selftests/amd-pstate/gitsource.sh
@@ -117,7 +117,7 @@ parse_gitsource()
 	printf "Gitsource-$1-#$2 power consumption(J): $en_sum\n" | tee -a $OUTFILE_GIT.result
 
 	# Permance is the number of run gitsource per second, denoted 1/t, where 1 is the number of run gitsource in t
-	# senconds. It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
+	# seconds. It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
 	# and t is time measured in seconds(s). This means that performance per watt becomes
 	#        1/t     1/t     1
 	#       ----- = ----- = ---
@@ -175,7 +175,7 @@ gather_gitsource()
 	printf "Gitsource-$1 avg power consumption(J): $avg_en\n" | tee -a $OUTFILE_GIT.result
 
 	# Permance is the number of run gitsource per second, denoted 1/t, where 1 is the number of run gitsource in t
-	# senconds. It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
+	# seconds. It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
 	# and t is time measured in seconds(s). This means that performance per watt becomes
 	#        1/t     1/t     1
 	#       ----- = ----- = ---
diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
index 57cad57e59c0..de4d8e9c9565 100755
--- a/tools/testing/selftests/amd-pstate/run.sh
+++ b/tools/testing/selftests/amd-pstate/run.sh
@@ -244,7 +244,7 @@ prerequisite()
 		if [ "$scaling_driver" != "$CURRENT_TEST" ]; then
 			echo "$0 # Skipped: Test can only run on $CURRENT_TEST driver or run comparative test."
 			echo "$0 # Please set X86_AMD_PSTATE enabled or run comparative test."
-			echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
+			echo "$0 # Current cpufreq scaling driver is $scaling_driver."
 			exit $ksft_skip
 		fi
 	else
@@ -252,7 +252,7 @@ prerequisite()
 			"tbench" | "gitsource")
 				if [ "$scaling_driver" != "$COMPARATIVE_TEST" ]; then
 					echo "$0 # Skipped: Comparison test can only run on $COMPARISON_TEST driver."
-					echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
+					echo "$0 # Current cpufreq scaling driver is $scaling_driver."
 					exit $ksft_skip
 				fi
 				;;
-- 
2.25.1

