Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E7E4E6AC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Mar 2022 23:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbiCXWlM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Mar 2022 18:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiCXWlK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Mar 2022 18:41:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690D7BA330
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Mar 2022 15:39:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a12-20020a25938c000000b0063467614126so4662493ybm.13
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Mar 2022 15:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2UXOWK4H/ABoSS6KabIKT0cRAkKR0ZUPw5leAS4VA2Y=;
        b=mFrw/DyLpphzNFV0Nr7i6+kDrT0/C9GU5c4FP6bzXJk/QsrgjgdsN5pw+Twz+s6tGi
         qy25SacKdr9ipsWUo6trNsVmt+dTa/NxO3N5FT6aeXplL6+ZEw1LMGDWTo0PQCwb+Bvv
         4GDi1sgE7Jd6QRrZP/c4HReJ6wxGKYe3J8j58vlNKNI0HzHCFnfQgsW07wf12tX5ifUO
         PkWd0jUpPH/MCtF459clWjsDteS21Ykgbme/qNhmrt1Ttph7wf3EUSy9EX8Ao16PvJnO
         QLKcOxdXbMcH953M7Bj/sxYtgU4u2dWspJAXKFL7VZLBu7hfRoPYI0AbX+uq/222BMVD
         SSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2UXOWK4H/ABoSS6KabIKT0cRAkKR0ZUPw5leAS4VA2Y=;
        b=cTH9V39iyzC00fqrpqBLXDfL1lVglYzLn94/OHRRHAbR6ktrpUbEkViFMiDHXBmKIP
         82qs9pX17RI98YqHBI5N6Cq3uVv6yHkJu77eFPtO5hujgeBKxzVFgx8qxn7HCIF1ehvu
         O0qQm92HmXj6CrfjQdrXSIvplMyvg/43+hgjnaoA5NO02QBqNWHxpVxqWnqEs1mswRTc
         zrUPOU5LlQi3FBUcSWyrHti8noJanro/2jp8rWEf1FBLcpn7jHbW7aMNWvv+67qB8sBE
         Tx7XUlui3G/hzqZYu6K3Fr/hqz1jg2lEgTQFjsv/h369N69yXzf3M3KYBp9jfUve/3wu
         15Bw==
X-Gm-Message-State: AOAM530BW0y90YEnlgwbHt5a+LNMlpMdxiRWp+omVIZ8ogwwWPyA0R07
        pScqOx8Re5JlADlouZc+k2CIB1ssXd6/75qytj7C
X-Google-Smtp-Source: ABdhPJw4BH07SPiQZUc2OcEknGn2R1/wKMDadrW5rM6fMHjf1XTNKTbDi8N9qPU+6gv6J5NGI8IQbzzmpbGwWUQn91RR
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:9892:9f7f:2c27:2968])
 (user=axelrasmussen job=sendgmr) by 2002:a25:5f11:0:b0:633:ee0c:ab79 with
 SMTP id t17-20020a255f11000000b00633ee0cab79mr6599611ybb.491.1648161574585;
 Thu, 24 Mar 2022 15:39:34 -0700 (PDT)
Date:   Thu, 24 Mar 2022 15:39:28 -0700
Message-Id: <20220324223929.1893741-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH 1/2] selftests: fix header dependency for pid_namespace selftests
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The way the test target was defined before, when building with clang we
get a command line like this:

clang -Wall -Werror -g -I../../../../usr/include/ \
	regression_enomem.c ../pidfd/pidfd.h  -o regression_enomem

This yields an error, because clang thinks we want to produce both a *.o
file, as well as a precompiled header:

clang: error: cannot specify -o when generating multiple output files

gcc, for whatever reason, doesn't exhibit the same behavior which I
suspect is why the problem wasn't noticed before.

This can be fixed simply by using the LOCAL_HDRS infrastructure the
selftests lib.mk provides. It does the right think and marks the target
as depending on the header (so if the header changes, we rebuild), but
it filters the header out of the compiler command line, so we don't get
the error described above.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/pid_namespace/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/pid_namespace/Makefile b/tools/testing/selftests/pid_namespace/Makefile
index dcaefa224ca0..edafaca1aeb3 100644
--- a/tools/testing/selftests/pid_namespace/Makefile
+++ b/tools/testing/selftests/pid_namespace/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -g -I../../../../usr/include/
 
-TEST_GEN_PROGS := regression_enomem
+TEST_GEN_PROGS = regression_enomem
 
-include ../lib.mk
+LOCAL_HDRS += $(selfdir)/pidfd/pidfd.h
 
-$(OUTPUT)/regression_enomem: regression_enomem.c ../pidfd/pidfd.h
+include ../lib.mk
-- 
2.35.1.1021.g381101b075-goog

