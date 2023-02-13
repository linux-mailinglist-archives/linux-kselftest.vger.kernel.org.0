Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9B5694D55
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 17:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBMQwD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 11:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjBMQwD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 11:52:03 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4D51A498
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 08:51:53 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id o1so4663523ioo.10
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 08:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bmmLz8nohbcch6FxeAT3SlKM+5+qck2x1XsBsKmtgNI=;
        b=PwoV3X3eyjemyEy2AWNYQFDQJ55zPWiCWjFMAJ5oriqnYvrq7qSQOQnTANnS+QVldc
         u0Lhf3Ed4lk3WZ2QWHyiizxbJJfMvOhk2MMntY3u853PBH1vitkusNy86R8m5gD+YL3m
         PcdXURAQaDOBE1ty02cvZN0STh5mRx7OvZ7j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmmLz8nohbcch6FxeAT3SlKM+5+qck2x1XsBsKmtgNI=;
        b=mxt30sPIuyBpf0ZDQwJlFGyBpMGz5TWbAjAnUGI6oBm2i+U3PgfLj6eHnnOVKKin/G
         Og2oAPhSIFVos5Wfa1E5ruNUVrHwCTcHACbUatH306S6lb8T3ahqDC95WJHjFXL4fvlb
         TPLKejluJo+AAjxQi6PFE6ByqO4KWJIzLfu5jph5G9DpBGMts5atRw9Saurr8Tx+dAF7
         BtiAQTHSDfguS57KFz/twVNH+WOhYz0GDuZyJMEFhIDBf9Ja1cX+vAcuylzdgtM64oVQ
         dcE+UdNDmiyG58Pct30GFm2OetS5/IB99x3EUdO3XkPQw0cNHyM7MZR7zL2DBEzcuvm+
         ei4w==
X-Gm-Message-State: AO0yUKUnQcmWBYkt6K5FxrjraoGhQtsPCBbvi3CeeTzfBK64mGJXJX2K
        pSCq4t3joTE0z2ctrHR4x8vyWw==
X-Google-Smtp-Source: AK7set8jdWwcHS37THmZN5Wyabh6n9pOvmNz4ORIZKR+xxUYVMozNWiBEzoeBwsrHlz2Qu0zrfCqsw==
X-Received: by 2002:a6b:ed05:0:b0:716:8f6a:f480 with SMTP id n5-20020a6bed05000000b007168f6af480mr18443243iog.0.1676307112355;
        Mon, 13 Feb 2023 08:51:52 -0800 (PST)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r83-20020a6b8f56000000b00710a7bf7f7esm4300508iod.51.2023.02.13.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 08:51:51 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/ptp: Remove clean target from Makefile
Date:   Mon, 13 Feb 2023 09:51:49 -0700
Message-Id: <20230213165149.224527-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following build warn removing unnecessary clean target
from the Makefile. lib.mk handles clean.

Makefile:10: warning: overriding recipe for target clean
../lib.mk:124: warning: ignoring old recipe for target clean

In addition, fix to use TEST_GEN_PROGS for generated test executables
and TES_PROGS for the shell script. Ger rid of all target as lib.mk
handles it.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/ptp/Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ptp/Makefile b/tools/testing/selftests/ptp/Makefile
index eeab44cc6863..8f57f88ecadd 100644
--- a/tools/testing/selftests/ptp/Makefile
+++ b/tools/testing/selftests/ptp/Makefile
@@ -1,10 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += $(KHDR_INCLUDES)
-TEST_PROGS := testptp
+TEST_GEN_PROGS := testptp
 LDLIBS += -lrt
-all: $(TEST_PROGS)
+TEST_PROGS = phc.sh
 
 include ../lib.mk
-
-clean:
-	rm -fr $(TEST_PROGS)
-- 
2.37.2

