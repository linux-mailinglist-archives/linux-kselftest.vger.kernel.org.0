Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5EE4C59C6
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Feb 2022 06:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiB0FyX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Feb 2022 00:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiB0FyW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Feb 2022 00:54:22 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39C7B0B
        for <linux-kselftest@vger.kernel.org>; Sat, 26 Feb 2022 21:53:46 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id l19so8250249pfu.2
        for <linux-kselftest@vger.kernel.org>; Sat, 26 Feb 2022 21:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgVfnSnXEcGoaDv3DM9kOZpMqyYLQA90eGzp4dL0JZs=;
        b=xlKJWjDoLItSB7uebqRIRgwMwUpLQQOwXuhT42MOPQetqYKz/r7jt+jDjrhmys+NIL
         bxQxutaG+4uSijCSwlTS7oSEYwAtfng3w3oj5UlsfifTCjW0gJHUPtLd3V5p76rIfygr
         JORzsALKtqbjIvDsXYe9V8iqZND4/COSCaIE4UO0IuXNV8rhSstCSPx2HlGPXojTdl1u
         P/+jy/GFhqtpdv/55b3cu3aw7Aslf8cytdFa6vnF7uGPT+o8wrNLJ7RDiggWufEIEIFC
         j0EWNsuONnYZwoquElZ2efYf7Twk4bRILvC9euEdM4ljA2xKlft33Jfr/BeiLsX44eW8
         Mf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgVfnSnXEcGoaDv3DM9kOZpMqyYLQA90eGzp4dL0JZs=;
        b=P4L0mcAAwdtYdTEa3Z1qn0utrXaMCqopdj7W83xERrUvoRNOzPQqXlu+vmFpRLO1Dq
         vQXxB9zARXUO6FOjtfUhBnmb7qtxTCfeC7SbJgdjUvV7khwmHcmPbDr8X8CPfChEyBmM
         wBFJN4Nq+KEYFHsD7SOLjZsBoQ4hzIx3p3UmpiOUymuSM4mP5caxq0HQHpfcAsrgFKoh
         W+db6U+9zwBNYKBGYX7b485kJciH/0vNPCDa6MypeI3MuE+YYypicwVOdeOuqL6Zfv+2
         ruIm44OLDHYcfDU7KmIPG/yeCLq2RI+c8MhytekB3HF7X3XkuzawNGbR+rD1SpxYqfZh
         iq5g==
X-Gm-Message-State: AOAM532PCxFe68P76ctW9Dp+s1CmUH9vkxa4Hq5+yNap9EMZByPeBMaE
        2CWAoFroxOvGiL+HDCoqioNmRg==
X-Google-Smtp-Source: ABdhPJxHmaiHTqexFilShO5HJEJVx7LP+GAmBpsTaYXG7tCaWA4m/pC02xRsznsBkb4gN39hYBDvmA==
X-Received: by 2002:aa7:9902:0:b0:4e1:375c:99f6 with SMTP id z2-20020aa79902000000b004e1375c99f6mr15482327pff.44.1645941226266;
        Sat, 26 Feb 2022 21:53:46 -0800 (PST)
Received: from localhost.localdomain ([2409:8a28:e6f:a720:d522:416f:1b2a:d253])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b004f3b1c23497sm8547647pfj.101.2022.02.26.21.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 21:53:45 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 1/2] kselftest/vm: override TARGETS from arguments
Date:   Sun, 27 Feb 2022 13:53:29 +0800
Message-Id: <20220227055330.43087-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FROM_FMBLA_NEWDOM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We can specify which testcases to build using TARGETS argument,
for example: make -C tools/testing/selftests TARGETS=vm, cause
the ordinary assignment of TARGETS in Makefile will be ignored.
So we need to use override directive to change that.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 tools/testing/selftests/vm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 1607322a112c..0b330a5b1840 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -53,7 +53,7 @@ CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_progra
 CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_64bit_program.c)
 CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_program.c -no-pie)
 
-TARGETS := protection_keys
+override TARGETS := protection_keys
 BINARIES_32 := $(TARGETS:%=%_32)
 BINARIES_64 := $(TARGETS:%=%_64)
 
-- 
2.20.1

