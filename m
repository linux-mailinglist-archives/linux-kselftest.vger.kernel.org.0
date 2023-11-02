Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A827DEDA6
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 08:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjKBHup (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 03:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjKBHul (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 03:50:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D589B116
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Nov 2023 00:50:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc3388621cso14420995ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Nov 2023 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698911429; x=1699516229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Acc6wXDvPM6YXuWFiWqejrBU9UJ2gcJGWMsAnskhSnc=;
        b=U5fuf/76j4QchkCYe/smVCmdyFeV4oAJat+z2RoUQEyzADyBG3JgpICkJrXJQlDnZb
         BTVp1UnbgMxhtIN8ds2YRvwr4HMC038cb/+MuUdx5SBnBpHWVECx3OqN1e9UQ9SELl82
         8q00nIvxyS/hp7x2aUhmlY/Gua0DGfVqWZQb9CfjSxo8CIOnX41EdtYY+C7YVUoT5v9Z
         rASlu0auKA84/CR2ZvW3Nlm6nzpdAd4UbJ73uaxHA7uITaqaz+f1u5ZhuJoBTOJnp+BH
         6ZDjy38u3B51nqQ01M6ZyTqN+kvKYnUWpnjiWqj7cne/vqkxWQzdIfDG/DHAELF03MPv
         MIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698911429; x=1699516229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Acc6wXDvPM6YXuWFiWqejrBU9UJ2gcJGWMsAnskhSnc=;
        b=n7gfCS7a/HgUwdExJ50VotALWE4Ww77EKy1fkyIRnEfE/2zzBXQ/AGUt7deNTeJV92
         dgbESWnT3MHOJO5TkIvymLXatPmneeSxixoJul2vfHe+E8M6Z47mvIBG/0brrvlzxSl8
         LUzeXZJYgtwZABk/mdGvDaQVqSL5Wk4TkKLOJ8ZeUepjUYRCALwecsICvP9CjzsVZU4t
         V3+qaJPTnxRHVTG+wQEKczYbG4V4kaxnoKAfGwT65pmF0qLE01WRUXipKFb9lplrKWrB
         B6pE5A9W2y7OfzNB+ESjwRS9RiYtH8Lb02OcaoZ+ZOnCB3Me6g7i4ucIWwLlKzXVm0PS
         HfsQ==
X-Gm-Message-State: AOJu0YwRPJmSm98+iz1w1KaQqeiXRkpvI2wRpt0MkuhQp/p9tkfxl+3i
        YqqJ+wwbSXw6j8OJPsWxjS4XMgh3rCHoKw==
X-Google-Smtp-Source: AGHT+IE6eMC1aQQy00VxDfH3VeS9UxbvjVFh2/kEqdOQtbbtMrrFya3Sqbp4guGDtSVIJwuG7J5Ibw==
X-Received: by 2002:a17:90a:884:b0:27d:5568:e867 with SMTP id v4-20020a17090a088400b0027d5568e867mr11395931pjc.9.1698911429399;
        Thu, 02 Nov 2023 00:50:29 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ci18-20020a17090afc9200b0027d0a60b9c9sm1913647pjb.28.2023.11.02.00.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 00:50:28 -0700 (PDT)
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH] kselftests: add per_test_log support
Date:   Thu,  2 Nov 2023 15:50:17 +0800
Message-ID: <20231102075017.4060991-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

By default, all the test output will be printed to stdout or output.log if
-s supplied. The kselftest/runner.sh also supports per test log if the
variable per_test_logging is set. So add new option -p to set this
veriable. Note the -p option is conflict with -s option.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/run_kselftest.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
index 92743980e553..965220a314ce 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -20,7 +20,8 @@ usage()
 {
 	cat <<EOF
 Usage: $0 [OPTIONS]
-  -s | --summary		Print summary with detailed log in output.log
+  -s | --summary		Print summary with detailed log in output.log (conflict with -p)
+  -p | --per_test_log		Print test log in /tmp with each test name (conflict with -s)
   -t | --test COLLECTION:TEST	Run TEST from COLLECTION
   -c | --collection COLLECTION	Run all tests from COLLECTION
   -l | --list			List the available collection:test entries
@@ -41,6 +42,9 @@ while true; do
 			logfile="$BASE_DIR"/output.log
 			cat /dev/null > $logfile
 			shift ;;
+		-p | --per_test_log)
+			per_test_logging=1
+			shift ;;
 		-t | --test)
 			TESTS="$TESTS $2"
 			shift 2 ;;
-- 
2.41.0

