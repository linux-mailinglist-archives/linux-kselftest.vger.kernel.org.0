Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE8D7841C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 15:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjHVNQB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 09:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbjHVNQA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 09:16:00 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691C5BE;
        Tue, 22 Aug 2023 06:15:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bd0a96e63dso3419144a34.2;
        Tue, 22 Aug 2023 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692710157; x=1693314957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RgPksFBxOItSqlc53rqP9sg2Ql5BRaniyvUG/S3vZQA=;
        b=Lqq7rBZlgW/W8/NpNTDcQpJStlieAl/FDDb81Yz+mVx6VVYYbh6O81p+kg1tZKNWi1
         44vmOYZr8UPr0GQsdoy2tOail7xtPFRGfVpF2NowHee2zCYShOhK+w40x6SX6HoLx0/m
         TGxQBaGZ01FBMTs1+unFMNzvimZFCAV1eKanwdTtKe+rGs3Eya2EeZpxlWDmVkMjZ3Xm
         YHJR8zn/QRiaXCZORJbA9MpcAExO1lEFuE4GYAmK9Pxwok5hI+PgRT1j6a0j6a5C0wwR
         9h/YayxcJ95TB/VId6DUH/7c/PXXaIOEbO7eQLvO0OTZT6YZqX/iXc+gMsXGSInY0uK4
         KiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692710157; x=1693314957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgPksFBxOItSqlc53rqP9sg2Ql5BRaniyvUG/S3vZQA=;
        b=NgWsmfXSFcr9K9cRS0TvtaZV7TDlC0wcFyyUI08632dorI9/qwg16Ki0yE7LaumZWw
         12qBm/WNi2uTfxXedmT6A9MDOIAj7goir7SRRRWIInkJCxclRy4KdahNUNuFgA/Imh17
         vljY8s1j92BToq/JTwHXPRpRzWerx81tXA1Tworik2h1P00MI7BqVnXXe+JNQQ3+jmJV
         bEYf77ConL5LOwzKw/3hzoqC7rKWfICmot3vOvgpCse54rtxHBoWqFxsZUZGeZfR61gn
         J6ayiTyC3ishUWFQdvSj4oZNGnJVJiPec1JoWX1b+zfiDr3QXUDY3Ul8kWnir3hpLNxz
         LpBg==
X-Gm-Message-State: AOJu0YyDgUJHqDyb5NFEdA5PDqF1rNGg7d+fdO6gGc2el23PSwJM3ol9
        zMKT5fTavQL/DT9SG/8zHnY=
X-Google-Smtp-Source: AGHT+IGo8zeIWBKn82j/jvQCjzmHYpJVCtYbV2axFg8O5ZXrTSIe63shHY3sDxMgIUHBR3S1rBwiKQ==
X-Received: by 2002:a9d:6295:0:b0:6b9:4216:c209 with SMTP id x21-20020a9d6295000000b006b94216c209mr10586169otk.12.1692710157602;
        Tue, 22 Aug 2023 06:15:57 -0700 (PDT)
Received: from debian.lan ([168.227.196.240])
        by smtp.gmail.com with ESMTPSA id t15-20020a9d748f000000b006b9cbad68a8sm4486071otk.30.2023.08.22.06.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 06:15:56 -0700 (PDT)
From:   "Ricardo B. Marliere" <rbmarliere@gmail.com>
To:     broonie@kernel.org, skhan@linuxfoundation.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ricardo B. Marliere" <rbmarliere@gmail.com>
Subject: [PATCH] selftests: alsa: make LDLIBS consistent
Date:   Tue, 22 Aug 2023 10:15:45 -0300
Message-Id: <20230822131544.38152-1-rbmarliere@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In kselftest_deps.sh script, the level 3 parser is broken for the alsa
subsystem Makefile.

Output before patch:

$ ./kselftest_deps.sh gcc alsa
========================================================
Kselftest Dependency Check for [./kselftest_deps.sh gcc alsa] results...
========================================================
Checked tests defining LDLIBS dependencies
--------------------------------------------------------
Total tests with Dependencies:
6 Pass: 2 Fail: 4
--------------------------------------------------------
PASS: alsa/Makefile dependency check passed -lasound
PASS: alsa/Makefile dependency check passed -lpthread
--------------------------------------------------------
Targets passed build dependency check on system:
alsa
--------------------------------------------------------
FAIL: alsa/Makefile dependency check: $(shell
FAIL: alsa/Makefile dependency check: pkg-config
FAIL: alsa/Makefile dependency check: --libs
FAIL: alsa/Makefile dependency check: alsa)
--------------------------------------------------------
Targets failed build dependency check on system:
alsa
--------------------------------------------------------
Missing libraries system
$(shell alsa) --libs pkg-config
--------------------------------------------------------
========================================================

Output after patch:

$ ./kselftest_deps.sh gcc alsa
========================================================
Kselftest Dependency Check for [./kselftest_deps.sh gcc alsa] results...
========================================================
Checked tests defining LDLIBS dependencies
--------------------------------------------------------
Total tests with Dependencies:
2 Pass: 2 Fail: 0
--------------------------------------------------------
PASS: alsa/Makefile dependency check passed -lasound
PASS: alsa/Makefile dependency check passed -lpthread
--------------------------------------------------------
Targets passed build dependency check on system:
alsa
--------------------------------------------------------
========================================================

Signed-off-by: Ricardo B. Marliere <rbmarliere@gmail.com>
---
 tools/testing/selftests/alsa/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index 5af9ba8a4645..b5670049c4e5 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -2,13 +2,13 @@
 #
 
 CFLAGS += $(shell pkg-config --cflags alsa)
-LDLIBS += $(shell pkg-config --libs alsa)
-ifeq ($(LDLIBS),)
-LDLIBS += -lasound
+VAR_LDLIBS += $(shell pkg-config --libs alsa)
+ifeq ($(VAR_LDLIBS),)
+VAR_LDLIBS += -lasound
 endif
 CFLAGS += -L$(OUTPUT) -Wl,-rpath=./
 
-LDLIBS+=-lpthread
+VAR_LDLIBS+=-lpthread
 
 OVERRIDE_TARGETS = 1
 
@@ -21,7 +21,7 @@ TEST_FILES := conf.d pcm-test.conf
 include ../lib.mk
 
 $(OUTPUT)/libatest.so: conf.c alsa-local.h
-	$(CC) $(CFLAGS) -shared -fPIC $< $(LDLIBS) -o $@
+	$(CC) $(CFLAGS) -shared -fPIC $< $(VAR_LDLIBS) -o $@
 
 $(OUTPUT)/%: %.c $(TEST_GEN_PROGS_EXTENDED) alsa-local.h
-	$(CC) $(CFLAGS) $< $(LDLIBS) -latest -o $@
+	$(CC) $(CFLAGS) $< $(VAR_LDLIBS) -latest -o $@
-- 
2.40.1

