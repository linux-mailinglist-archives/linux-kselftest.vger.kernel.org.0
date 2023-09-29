Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2967B32D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 14:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjI2MyB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 08:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjI2MyA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 08:54:00 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204DC94;
        Fri, 29 Sep 2023 05:53:59 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-692c02adeefso8807529b3a.3;
        Fri, 29 Sep 2023 05:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695992038; x=1696596838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=76gM6BDUUWAlgjRd9QMQTyUL0C7Q49QbZ5DAn9QkE6g=;
        b=bzr1WQ5oRYwSU7xEjtnNtHQKpsZHkP7fBgz7RA+3dMh9uy18f2xMoV58zaLiK50gDk
         e09O1AsS2aXJ6f895NO9rXdJYaf1krHDtcxKeTbjfaz8XH6aE+Gg9qIqfPzgvPMlRsU5
         rX9aG8Y+nirg/SANdDZ+tPs/W+++U8OuCOVprpW2bFXg2GU9P00F5X+WMy3szh4GzVrB
         F3uuwfxiZ4689xZapQTDkxosn5w/e+IPqxfFJFIt6nUJvNl4PezfWTglJFKH2BfZnWcu
         ZL0ZNiS6ByBtYw64Kzqy4pYka+dlsZuffBI40mcNGG78LlzfqIn7CkJsWbeT/EuegYzS
         Hk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695992038; x=1696596838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76gM6BDUUWAlgjRd9QMQTyUL0C7Q49QbZ5DAn9QkE6g=;
        b=FOfbSKO0aYLZs9o0Nk1TEmsViqUHirjNdQpyBjq5hAMFKbfQOZkWMScgEHvwwotRI2
         uM4Ro1PNGxyyjSJFEnddyiiP8Ww+l+Mli2BaocRoMsNKDjHYXkttjvbsGQxC7DJt58Cn
         u2M/ko4D3eycX00f0U/eOCVeIyugdmpm798U2tBMOHb1XXcie85ySXPpLdyDSyOqKTOv
         PBf/LL7f4bLX40KhbRS5/ySK6fslqgyqZOyCm2Rno2xAFBamz8VASR0JkjnIlxemRrVx
         Y3M0fd6BtvpiCM/76ne4Q2j2A8T1jthVY5J7lvOfxPk5qMB3VG40M97bX3tAYDfS/hCy
         ZUKg==
X-Gm-Message-State: AOJu0YwXKuBHwAHqOih3aHh3glWa5YR9ayj54YWoc5j2afwSRr4bvojp
        pm9LXHzgRFBWtr5wJRIg4fI=
X-Google-Smtp-Source: AGHT+IE2N53vnfZ9QHFbyMOxxgoiNewsUxoq53+ellAryOcJ/cfMO0iR6bshi22LSzmRUbusGzGTFQ==
X-Received: by 2002:a05:6a00:22c3:b0:68e:2822:fb36 with SMTP id f3-20020a056a0022c300b0068e2822fb36mr4011566pfj.8.1695992038070;
        Fri, 29 Sep 2023 05:53:58 -0700 (PDT)
Received: from swarup-virtual-machine.localdomain ([171.76.87.78])
        by smtp.gmail.com with ESMTPSA id do17-20020a056a004a1100b00692b0d413c8sm12473465pfb.197.2023.09.29.05.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 05:53:57 -0700 (PDT)
From:   Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        swarupkotikalapudi@gmail.com
Subject: [PATCH] selftests: capabilities: namespace create varies for root and normal user
Date:   Fri, 29 Sep 2023 18:23:48 +0530
Message-Id: <20230929125348.13302-1-swarupkotikalapudi@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Change namespace creation for root and non-root
user differently in create_and_enter_ns() function

Test result with root user:
$sudo make  TARGETS="capabilities" kselftest
 ...
 TAP version 13
 1..1
 timeout set to 45
 selftests: capabilities: test_execve
 TAP version 13
 1..12
 [RUN]       +++ Tests with uid == 0 +++
 [NOTE]      Using global UIDs for tests
 [RUN]       Root => ep
 ...
 ok 12 Passed
 Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
 ==================================================
 TAP version 13
 1..9
 [RUN]       +++ Tests with uid != 0 +++
 [NOTE]      Using global UIDs for tests
 [RUN]       Non-root => no caps
 ...
 ok 9 Passed
 Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0

Test result without root or normal user:
$make  TARGETS="capabilities" kselftest
 ...
 timeout set to 45
 selftests: capabilities: test_execve
 TAP version 13
 1..12
 [RUN]       +++ Tests with uid == 0 +++
 [NOTE]      Using a user namespace for tests
 [RUN]       Root => ep
 validate_cap:: Capabilities after execve were correct
 ok 1 Passed
 Check cap_ambient manipulation rules
 ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
 ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
 ok 4 PR_CAP_AMBIENT_RAISE worked
 ok 5 Basic manipulation appears to work
 [RUN]       Root +i => eip
 validate_cap:: Capabilities after execve were correct
 ok 6 Passed
 [RUN]       UID 0 +ia => eipa
 validate_cap:: Capabilities after execve were correct
 ok 7 Passed
 ok 8 # SKIP SUID/SGID tests (needs privilege)
 Planned tests != run tests (12 != 8)
 Totals: pass:7 fail:0 xfail:0 xpass:0 skip:1 error:0
 ==================================================
 TAP version 13
 1..9
 [RUN]       +++ Tests with uid != 0 +++
 [NOTE]      Using a user namespace for tests
 [RUN]       Non-root => no caps
 validate_cap:: Capabilities after execve were correct
 ok 1 Passed
 Check cap_ambient manipulation rules
 ok 2 PR_CAP_AMBIENT_RAISE failed on non-inheritable cap
 ok 3 PR_CAP_AMBIENT_RAISE failed on non-permitted cap
 ok 4 PR_CAP_AMBIENT_RAISE worked
 ok 5 Basic manipulation appears to work
 [RUN]       Non-root +i => i
 validate_cap:: Capabilities after execve were correct
 ok 6 Passed
 [RUN]       UID 1 +ia => eipa
 validate_cap:: Capabilities after execve were correct
 ok 7 Passed
 ok 8 # SKIP SUID/SGID tests (needs privilege)
 Planned tests != run tests (9 != 8)
 Totals: pass:7 fail:0 xfail:0 xpass:0 skip:1 error:0

Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
---
 tools/testing/selftests/capabilities/test_execve.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index df0ef02b4036..8236150d377e 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -96,11 +96,7 @@ static bool create_and_enter_ns(uid_t inner_uid)
 	outer_uid = getuid();
 	outer_gid = getgid();
 
-	/*
-	 * TODO: If we're already root, we could skip creating the userns.
-	 */
-
-	if (unshare(CLONE_NEWNS) == 0) {
+	if (outer_uid == 0 && unshare(CLONE_NEWNS) == 0) {
 		ksft_print_msg("[NOTE]\tUsing global UIDs for tests\n");
 		if (prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0) != 0)
 			ksft_exit_fail_msg("PR_SET_KEEPCAPS - %s\n",
-- 
2.34.1

