Return-Path: <linux-kselftest+bounces-28-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FCD7E8BEB
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Nov 2023 18:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244011F20F05
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Nov 2023 17:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA431BDE4;
	Sat, 11 Nov 2023 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX7YlFSi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED526134CC
	for <linux-kselftest@vger.kernel.org>; Sat, 11 Nov 2023 17:38:17 +0000 (UTC)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E9D9F;
	Sat, 11 Nov 2023 09:38:16 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-357ccaf982eso11242775ab.0;
        Sat, 11 Nov 2023 09:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699724296; x=1700329096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjn0mx0T4ELUgwN3eqbWBleZXpgBP6Grrg4uPvTk4DY=;
        b=EX7YlFSi159vq5AXo5ZU3Qk15D2ENYI8JF4Pyg9bQiTuJ9quu5r4H7UYsISZv01wzE
         cJ19zGHMlM3AnTy3ix6q+tB71l2HYLQkR+rraub3Zc9wX1QMtWBYLwMwG632vUOzf6NQ
         Ws2RTBG90sm5i3Ebcj/B4k/25NQY8ru5fkpGoLksNFJDPKJaMV0OIchIt609J7Zius6Z
         MDB9myASZLM6WlUQaD2FEDAPr483L90rfiscdg7YqD/aSoKCx8vsHLV06FF9MWJjPjW6
         DnY3Ve5RSay9Xg1KGacHeKo+GK4urdNiSGSZSdwtKxn2s2N4h9tffJY156NWHhqkR3v/
         cFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699724296; x=1700329096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjn0mx0T4ELUgwN3eqbWBleZXpgBP6Grrg4uPvTk4DY=;
        b=biGJTs/lX6i2gEucSbdlXCPx3p31XGVaweaNUwFvE1BZ20dzcRxUaplOHw3t48+HNi
         mu079W4+AuPTmC2RLskRO5HF/V4a1LfvwHIwp6XBqGjYG4qG2SH5wIMwJ9rH4LarKh03
         rBOYtv5IZS1VGY6CrGHBBrYyk7eqx/hvurvhJ/7wN7cqgUdvFNsC93QGfZFGj34LJgpq
         HThLdELm73HefxXVEQzonai+xeY7KeWPTta3y/NojZkBUGCA2bfeienKEQmCg3MNvEcz
         HiKZ/Uum7SyKL2WtA/VwgOBzyD+naCSytlHm4SIewASeUQhCOFdoKbXGqaK1sKIg5L+W
         1+KA==
X-Gm-Message-State: AOJu0YwlsRzvKQdmRyPzl6LrNlYHn/Ul2sEqlo3RugJj6ms8e+toywBp
	tn6/QJttLjuFOY3TkKPfk7RYeN6gv7ohXg==
X-Google-Smtp-Source: AGHT+IF0rJDB1rx0Fbj9KRFWhR+y0qz9rCr0UJv6agGt7mcvW3RqlLKjHpM9emqlz/vIORxwMf8b7Q==
X-Received: by 2002:a05:6e02:16c6:b0:359:3150:c69d with SMTP id 6-20020a056e0216c600b003593150c69dmr4152096ilx.9.1699724295984;
        Sat, 11 Nov 2023 09:38:15 -0800 (PST)
Received: from swarup-virtual-machine.localdomain ([171.76.83.22])
        by smtp.gmail.com with ESMTPSA id w12-20020aa7858c000000b006b76cb6523dsm1511226pfn.165.2023.11.11.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 09:38:15 -0800 (PST)
From: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
To: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	luto@kernel.org
Cc: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Subject: [PATCH v2] selftests: capabilities: namespace create varies for root and normal user
Date: Sat, 11 Nov 2023 23:08:06 +0530
Message-Id: <20231111173806.16775-1-swarupkotikalapudi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZU+xkpH09xjzO5IS@swarup-virtual-machine>
References: <ZU+xkpH09xjzO5IS@swarup-virtual-machine>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes TODO:
"If we're already root, we could skip creating the userns."

Change namespace creation for root and non-root
user differently in create_and_enter_ns() function
in this file:
tools/testing/selftests/capabilities/test_execve.c

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

Changes in V2:
 - Change the commit message explaining
   why this patchset is needed.

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


