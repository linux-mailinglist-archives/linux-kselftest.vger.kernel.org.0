Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF96977F2F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 11:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349365AbjHQJOf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 05:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349450AbjHQJON (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 05:14:13 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAE2210E;
        Thu, 17 Aug 2023 02:14:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bdb801c667so49754775ad.1;
        Thu, 17 Aug 2023 02:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692263650; x=1692868450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e04hSPseH7pUtZ8Q4dNZi4YT1I9WSaKa5frJZEb/LHQ=;
        b=fwKiamlCWmajJvC2NbSMZpt/3IOu6EhqkeaupS1E/8NArhiX/pRCbqcAyTGoqmrOre
         tVpNXRe7/h8fefJwhvMwU6lAnvcmGZKiBqj0Hb80HApSA45il0wPc1JJmz8FkCxfmNSO
         ar6aspeGewsr9TIWXU0adNv+Gk1sd13aPi8SQdxfKKJtlmlkEsW0Fqm6sOOY33276t+Q
         eULKk2s54DByZxpqhvACtwygyEWIOxh5kpscOdRt+qD878+Ck+EwRsvuyaWlmphgZJuy
         5BYD4rh0UHchbyIDloCpqhteW4QrB27/FT+eVihQJUdvTqxKaBt1V1c5HrrLCPU47L5H
         LwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692263650; x=1692868450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e04hSPseH7pUtZ8Q4dNZi4YT1I9WSaKa5frJZEb/LHQ=;
        b=eobyn/41cbG/alilUVurhtLiUDzoslXd1R4S78nOtl+ncpyGw0iFxpPqhxG8YQktgO
         VtRe6W6/A+2JIkzpGMWj3wImY60iRJh5b6Tv1gNkgfIhTBOyyzHYSC9fQAh3vlnlPCFJ
         ZtYwrH1IqIOAQOuineSXz2ZNlGIWP/QLjdvoCNDWJ0ij25ACU4d1OGSLl5M0CHk6Aq5Z
         efJcqFfuICfqdq9zmy1w5+kPYd0qtu1TP6kihBEqJJhoHiEflNExxn/lvbAdAxlkKNTx
         hpkTa/YzxUNAVsEAnum3GuJsZ39cRIirnx/N+ePm6ElYNNFBENzAD1Oz2IqvJ8MDkiON
         pf/A==
X-Gm-Message-State: AOJu0Ywe8Z5X6Hk68uxQ9V4CfvRBXXHCwc3JI0Gq9w4yH8atDvV2ExkE
        JsQsHuIT8F3H6ZfE7SCGflxt7ijW7Ks=
X-Google-Smtp-Source: AGHT+IG+fTqswvdCEIhpfK2tXpwnLGPY1Hn2+4eU7euHhpyG6hJUIVFgdEdfUueMRgW1rOXVOjaWtA==
X-Received: by 2002:a17:903:2310:b0:1bc:5e50:9337 with SMTP id d16-20020a170903231000b001bc5e509337mr5845311plh.53.1692263649918;
        Thu, 17 Aug 2023 02:14:09 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:1afa:cf81:3a3:6ec8])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b001ab2b4105ddsm14669575plh.60.2023.08.17.02.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 02:14:09 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>, shuah@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6] selftests: rtc: Fixes rtctest error handling.
Date:   Thu, 17 Aug 2023 14:44:01 +0530
Message-Id: <20230817091401.72674-1-atulpant.linux@gmail.com>
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

Adds a check to verify if the rtc device file is valid or not
and prints a useful error message if the file is not accessible.

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---

changes since v5:
    Updated error message to use strerror().
	If the rtc file is invalid, the skip the test.

changes since v4:
    Updated the commit message.

changes since v3:
    Added Linux-kselftest and Linux-kernel mailing lists.

changes since v2:
    Changed error message when rtc file does not exist.

changes since v1:
    Removed check for uid=0
    If rtc file is invalid, then exit the test.

 tools/testing/selftests/rtc/rtctest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 630fef735c7e..27b466111885 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -15,6 +15,7 @@
 #include <sys/types.h>
 #include <time.h>
 #include <unistd.h>
+#include <error.h>
 
 #include "../kselftest_harness.h"
 #include "../kselftest.h"
@@ -437,7 +438,7 @@ int main(int argc, char **argv)
 	if (access(rtc_file, F_OK) == 0)
 		ret = test_harness_run(argc, argv);
 	else
-		ksft_exit_fail_msg("[ERROR]: Cannot access rtc file %s - Exiting\n", rtc_file);
+		ksft_exit_skip("%s: %s\n", rtc_file, strerror(errno));
 
 	return ret;
 }
-- 
2.25.1

