Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524537D746B
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 21:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjJYTgj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 15:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYTgj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 15:36:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4976C137;
        Wed, 25 Oct 2023 12:36:37 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5aa7172bafdso141238a12.1;
        Wed, 25 Oct 2023 12:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698262597; x=1698867397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=26pJmtJb2RAX7qmuNdQwiZrEag4RUY/XohpxzktHJ4U=;
        b=RvlezJOy2Lvesfxpl4dsR6OnAIyhMX1JOerDoq8/cibiC/hF+H+BQfbxpMxffRBTld
         KQDucZBy2SNZHEyL3GVm9CdXl5zoFX6ZZHFtj+350EjR+p+HAayBUtsSN8BhmqmCkgJw
         gpItznj8/bZf/Dj+KH7yx8WvWm1VJB+S8qBEfY2rdBio/4NFTQA7pSf55P4xpTaEJktu
         s/bk96DeAIlhHWf2Eb5QKwpMbBU9bXcCPmJRyCSG9BNeE1usE0UUQ6uF2N1ssW35S47W
         TcV2y4YpKF1EsQMmdE4gaDkdlt78WhUnMK6FjPDrUmwl/C6ncKAvTzXFxBAWSFaz/k3S
         SYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698262597; x=1698867397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26pJmtJb2RAX7qmuNdQwiZrEag4RUY/XohpxzktHJ4U=;
        b=wL4cWPU0S4+FcnO6UKKkYlSV+Fgz0YZDMhAdim47OKDfVTfeeLk+IbYUE64qSbwy2J
         sZKPMlZE021hRv3iIujbn3QJ5z5mP+gPmMmQnGo0nj8fWP/pfCnyS27Admm2LVy/8odf
         moqImQ312qNCfYRwhjOqUyRjKbFGt135YNEVew8CshTZptKW95Op4Aa/nYjZ0EcuCq8U
         3m0+DicU+inx0NZy9J+uidUfcVdQGM3OqCJpkJulWv0CBotoSja8WxlFC1qpHdKXFCKH
         f07R60BkJUJG/cF7SLglET2TjkOCPhyar5nUaYLL94VK9/jjcdrizQw+2HrekGR07sry
         Tjfw==
X-Gm-Message-State: AOJu0YwnVWxpfcO2ITp048viDsmd8PN/pbVeHepAmqcCEJ9rSO+ZGB26
        D57AtVlP+FDBIxdzS8PGi7M=
X-Google-Smtp-Source: AGHT+IGoFaKQntcdg64/063AgFh2wDd8nptiNikQFkrJcRhRt+2VvrD+F+KjeonLmYe9soZtWaYTOA==
X-Received: by 2002:a05:6a20:6a0b:b0:17b:129b:1817 with SMTP id p11-20020a056a206a0b00b0017b129b1817mr7106857pzk.45.1698262596525;
        Wed, 25 Oct 2023 12:36:36 -0700 (PDT)
Received: from swarup-virtual-machine.localdomain ([171.76.80.48])
        by smtp.gmail.com with ESMTPSA id g9-20020a635209000000b00565dd935938sm9217483pgb.85.2023.10.25.12.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:36:36 -0700 (PDT)
From:   Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
To:     shuah@kernel.org, akpm@linux-foundation.org, adobriyan@gmail.com,
        hughd@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Subject: [PATCH] selftests:proc ProtectionKey check in smpas test
Date:   Thu, 26 Oct 2023 01:06:27 +0530
Message-Id: <20231025193627.316508-1-swarupkotikalapudi@gmail.com>
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

Check ProtectionKey field in /proc/*/smaps output,
if system supports page-based memory permissions.

Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 38 ++++++++++++--------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index b16c13688b88..4842f923235c 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -37,6 +37,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include "../kselftest.h"
 
 #ifdef __amd64__
 #define TEST_VSYSCALL
@@ -83,10 +84,7 @@ static const char proc_pid_smaps_vsyscall_1[] =
 "SwapPss:               0 kB\n"
 "Locked:                0 kB\n"
 "THPeligible:           0\n"
-/*
- * "ProtectionKey:" field is conditional. It is possible to check it as well,
- * but I don't have such machine.
- */
+"ProtectionKey:         0\n"
 ;
 
 static const char proc_pid_smaps_vsyscall_2[] =
@@ -113,10 +111,7 @@ static const char proc_pid_smaps_vsyscall_2[] =
 "SwapPss:               0 kB\n"
 "Locked:                0 kB\n"
 "THPeligible:           0\n"
-/*
- * "ProtectionKey:" field is conditional. It is possible to check it as well,
- * but I'm too tired.
- */
+"ProtectionKey:         0\n"
 ;
 
 static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
@@ -241,13 +236,26 @@ static int test_proc_pid_smaps(pid_t pid)
 	} else {
 		ssize_t rv = read(fd, buf, sizeof(buf));
 		close(fd);
-		if (g_vsyscall == 0) {
-			assert(rv == 0);
-		} else {
-			size_t len = strlen(g_proc_pid_maps_vsyscall);
-			/* TODO "ProtectionKey:" */
-			assert(rv > len);
-			assert(memcmp(buf, g_proc_pid_maps_vsyscall, len) == 0);
+		assert(rv >= 0);
+		assert(rv <= sizeof(buf));
+		if (g_vsyscall != 0) {
+			int pkey = pkey_alloc(0, 0);
+
+			if (pkey < 0) {
+				size_t len = strlen(g_proc_pid_maps_vsyscall);
+
+				assert(rv > len);
+				assert(memcmp(buf, g_proc_pid_maps_vsyscall, len) == 0);
+			} else {
+				pkey_free(pkey);
+				static const char * const S[] = {
+					"ProtectionKey:         0\n"
+				};
+				int i;
+
+				for (i = 0; i < ARRAY_SIZE(S); i++)
+					assert(memmem(buf, rv, S[i], strlen(S[i])));
+			}
 		}
 		return EXIT_SUCCESS;
 	}
-- 
2.34.1

