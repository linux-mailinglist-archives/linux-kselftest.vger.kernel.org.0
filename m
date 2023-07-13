Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B88752544
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 16:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjGMOfK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 10:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGMOfI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 10:35:08 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE572702;
        Thu, 13 Jul 2023 07:34:54 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4R1xvv49w8z9smK;
        Thu, 13 Jul 2023 16:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1689258891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjkT2Rw0tr8TGJD0iIqzpuuYdLQQeUx5R46ODfk76ks=;
        b=oUPbMSvFRXiwqcHE7ijt/I2Po5hVe412fH7+Zw7UUG7G1C9CpYODK0GqEDq3rt0TFrkkhL
        1tNmFOUhIxW+8niTHneU0GlIQIKTb6E/qvqpI4k2QGWSPUcblzv8Kr+3MQujKeJeipq92o
        fyUVU28INwU+8/j7kGpG9X88cGqLp//9GbxWyx0E8JzQ83j5jLqKPC2JSe0dm8W4DkpVib
        qOwiJzm6/m2A2CIHNt5W/m2DHigJTLnOhqLukSiyYW7RmmbCp91YhXYJTYRZLlvzdJKTiJ
        yz60SgIfQxO38akH874sgDryFay5VgDPdiEMraS/27HTPOqYmlXvXpc36qYndg==
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] selftests: memfd: error out test process when child test fails
Date:   Fri, 14 Jul 2023 00:33:48 +1000
Message-ID: <20230713143406.14342-4-cyphar@cyphar.com>
In-Reply-To: <20230713143406.14342-1-cyphar@cyphar.com>
References: <20230713143406.14342-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4R1xvv49w8z9smK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Before this change, a test runner using this self test would see a
return code of 0 when the tests using a child process (namely the
MFD_NOEXEC_SEAL and MFD_EXEC tests) failed, masking test failures.

Fixes: 11f75a01448f ("selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index d8342989c547..8b7390ad81d1 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1219,7 +1219,24 @@ static pid_t spawn_newpid_thread(unsigned int flags, int (*fn)(void *))
 
 static void join_newpid_thread(pid_t pid)
 {
-	waitpid(pid, NULL, 0);
+	int wstatus;
+
+	if (waitpid(pid, &wstatus, 0) < 0) {
+		printf("newpid thread: waitpid() failed: %m\n");
+		abort();
+	}
+
+	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) != 0) {
+		printf("newpid thread: exited with non-zero error code %d\n",
+		       WEXITSTATUS(wstatus));
+		abort();
+	}
+
+	if (WIFSIGNALED(wstatus)) {
+		printf("newpid thread: killed by signal %d\n",
+		       WTERMSIG(wstatus));
+		abort();
+	}
 }
 
 /*
-- 
2.41.0

