Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7EC58B5CC
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Aug 2022 15:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiHFN6W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Aug 2022 09:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiHFN6V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Aug 2022 09:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA89910FD7
        for <linux-kselftest@vger.kernel.org>; Sat,  6 Aug 2022 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659794298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M1VZLFzbc3QEJrqC5cuqzOWpSyIBVvFdj+5LhLu6pv4=;
        b=inktaNs7sD1gd4Wz4QEaKDFJCQGxnyXzvOzu3GH4oE6Z89zzN63rL1TpLEwEEIXUIRErtV
        rCs9m19dlRzciOeBLxnGPE71RQESrK0CcuyyT41WW1Y/PYSH8PJB0wdCH484b9OVIgeFDb
        Wv5shHh16O2E6nOTpMfxuQvQ1PtLvSk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-Wj4j2YicPJq58ibkEp1qSQ-1; Sat, 06 Aug 2022 09:58:17 -0400
X-MC-Unique: Wj4j2YicPJq58ibkEp1qSQ-1
Received: by mail-pf1-f197.google.com with SMTP id j23-20020aa78017000000b0052ee4264488so1178820pfi.16
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Aug 2022 06:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=M1VZLFzbc3QEJrqC5cuqzOWpSyIBVvFdj+5LhLu6pv4=;
        b=FJujJJYJxN0jgbwSghCVCWw+7aXZ7LFfzTdZY2x9lVAuRGfYZ+lu58Ej0TL/1qmN00
         LXhEu1/GK7StSJ47gaC8vFOYJfyXwvL5XzI2+42B6DvhlnPsN6MevlxSlIqAF6zrcDZx
         Ta6u1YgdGCUfotq1Rjye7/fppshgu/MGUC5W7Vm6AyDbzB6wKGFzw53xAdvSZgrRH5kd
         XbXyOj9JihUGijwysw0r4wNQE7gvz4/oF33geGcsP9wd9fG6ioS1IwHaqKB6e4N84ABW
         9WL8CAjA0KNJSovQlfkJ0rYLJDRiZW7RNDTJyj5WPSI0ujtErx2wBXLOh6t5ulPHLZ/F
         PxSw==
X-Gm-Message-State: ACgBeo1b0il7v+VTK1CMQUyegPQ8vn+ztrQRHUbq71+8teLmPCys0trh
        F7tA2/yajl5SKpvyTLOY/RN41TZseNZhTI7ROJIlCJZJq6D/Ejp/B19hiYDLwO5Ai3/fazup7R3
        e1lnRSJQaSMBqTiIybU9Pgl0mUOmb
X-Received: by 2002:a65:56ca:0:b0:41c:b7f6:78d7 with SMTP id w10-20020a6556ca000000b0041cb7f678d7mr9535492pgs.414.1659794296253;
        Sat, 06 Aug 2022 06:58:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zkTYFuwP5/8wgbQSavTGBbDM7tgh5zCuFh2N5fVlb4s0KISmvWWClJ/x6ktAl5IiVZ+OlLA==
X-Received: by 2002:a65:56ca:0:b0:41c:b7f6:78d7 with SMTP id w10-20020a6556ca000000b0041cb7f678d7mr9535479pgs.414.1659794295968;
        Sat, 06 Aug 2022 06:58:15 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id h12-20020a17090ac38c00b001f4fb21c11asm4871544pjt.21.2022.08.06.06.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 06:58:15 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] selftests/proc: Add support for vsyscall=xonly
Date:   Sat,  6 Aug 2022 22:57:49 +0900
Message-Id: <20220806135749.47168-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are 3 vsyscall modes: emulate, xonly, and none.  proc-pid-vm
detects the existence of the vsyscall with memory load on the vsyscall
page.

This works for emulate and none vsyscall modes, but fails for xonly
because read permission is omitted with xonly vsyscall page, and it
results in the following error:

  # ./proc-pid-vm
  proc-pid-vm: proc-pid-vm.c:328: main: Assertion `rv == len' failed.
  Aborted (core dumped)

This patch fixes this issue with introducing the following rule:

  1. vsyscall mode is emulate if it can load memory
  2. vsyscall mode is xonly if it can call gettimeofday() on vsyscall
  3. vsyscall mode is node otherwise

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 tools/testing/selftests/proc/proc-pid-vm.c | 77 ++++++++++++++++++----
 1 file changed, 65 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index 28604c9f805c..dffd263beef3 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -211,10 +211,16 @@ static int make_exe(const uint8_t *payload, size_t len)
 }
 #endif
 
-static bool g_vsyscall = false;
-
-static const char str_vsyscall[] =
-"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
+static enum { EMULATE, XONLY, NONE } g_vsyscall_mode;
+
+static const char * const str_vsyscall[] = {
+	/* emulate */
+	"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n",
+	/* xonly */
+	"ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n",
+	/* none */
+	"",
+};
 
 #ifdef __x86_64__
 static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
@@ -225,7 +231,33 @@ static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
 /*
  * vsyscall page can't be unmapped, probe it with memory load.
  */
-static void vsyscall(void)
+static bool vsyscall_emulate(void)
+{
+	*(volatile int *)0xffffffffff600000UL;
+	return true;
+}
+
+/*
+ * vsyscall page can't be unmapped, probe it with calling gettimeofday().
+ */
+static bool vsyscall_xonly(void)
+{
+	int ret;
+	struct timeval tv;
+	int (*f)(struct timeval *tv, struct timezone *tz);
+
+	/* Try to call gettimeofday() on vsyscall*/
+	f = (void *)0xffffffffff600000UL;
+	ret = f(&tv, NULL);
+	if (ret < 0) {
+		fprintf(stderr, "gettimeofday() on vsyscall, ret %d\n", ret);
+		return false;
+	}
+
+	return true;
+}
+
+static bool vsyscall_test(bool (*test)(void))
 {
 	pid_t pid;
 	int wstatus;
@@ -246,13 +278,27 @@ static void vsyscall(void)
 		act.sa_sigaction = sigaction_SIGSEGV;
 		(void)sigaction(SIGSEGV, &act, NULL);
 
-		*(volatile int *)0xffffffffff600000UL;
+		if (!test())
+			exit(1);
+
 		exit(0);
 	}
 	waitpid(pid, &wstatus, 0);
 	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0) {
-		g_vsyscall = true;
+		return true;
 	}
+
+	return false;
+}
+
+static void vsyscall(void)
+{
+	if (vsyscall_test(vsyscall_emulate))
+		g_vsyscall_mode = EMULATE;
+	else if (vsyscall_test(vsyscall_xonly))
+		g_vsyscall_mode = XONLY;
+	else
+		g_vsyscall_mode = NONE;
 }
 
 int main(void)
@@ -314,11 +360,14 @@ int main(void)
 
 	/* Test /proc/$PID/maps */
 	{
-		const size_t len = strlen(buf0) + (g_vsyscall ? strlen(str_vsyscall) : 0);
+		size_t len = strlen(buf0);
 		char buf[256];
 		ssize_t rv;
 		int fd;
 
+		if (g_vsyscall_mode != NONE)
+			len += strlen(str_vsyscall[g_vsyscall_mode]);
+
 		snprintf(buf, sizeof(buf), "/proc/%u/maps", pid);
 		fd = open(buf, O_RDONLY);
 		if (fd == -1) {
@@ -327,8 +376,10 @@ int main(void)
 		rv = read(fd, buf, sizeof(buf));
 		assert(rv == len);
 		assert(memcmp(buf, buf0, strlen(buf0)) == 0);
-		if (g_vsyscall) {
-			assert(memcmp(buf + strlen(buf0), str_vsyscall, strlen(str_vsyscall)) == 0);
+		if (g_vsyscall_mode != NONE) {
+			assert(memcmp(buf + strlen(buf0),
+				      str_vsyscall[g_vsyscall_mode],
+				      strlen(str_vsyscall[g_vsyscall_mode])) == 0);
 		}
 	}
 
@@ -374,8 +425,10 @@ int main(void)
 			assert(memmem(buf, rv, S[i], strlen(S[i])));
 		}
 
-		if (g_vsyscall) {
-			assert(memmem(buf, rv, str_vsyscall, strlen(str_vsyscall)));
+		if (g_vsyscall_mode != NONE) {
+			assert(memmem(buf, rv,
+				      str_vsyscall[g_vsyscall_mode],
+				      strlen(str_vsyscall[g_vsyscall_mode])));
 		}
 	}
 
-- 
2.37.1

