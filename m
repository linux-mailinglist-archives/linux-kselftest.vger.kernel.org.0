Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675EA77B460
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 10:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjHNIly (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 04:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjHNIlk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 04:41:40 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1337410EA;
        Mon, 14 Aug 2023 01:41:35 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RPSYR2bs0z9sWB;
        Mon, 14 Aug 2023 10:41:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1692002491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7gQyeuP4S02FF5qxYTiiXRiidByA4CAzLTryBvJ7G7w=;
        b=PWInDqWMMKzI/ONQxGwzOm9Nqjj0QWXmLPZUkhDGsxbUFUikujZWbEY1MqZPB1WBCvi77e
        kiKJ8pi/2PteW88+lQBK8ltXeZV9mb2bYVBIT+xToxGb7CsmZSjDBOtgWYsBzPZwis7wXQ
        RtHIduy6h2n0Y08EgBWVCaB3NB4595F6cDxfr1hTZLGJAVUq5dt4TkT/kmSYd5o/jIhMC4
        ijPwqZ/3W9OYLr4Ca7Mt3QrZIxPfcKZbkuVIeM0k0uGsxknhulEqFewn6BGmOkqAjyH3EK
        i++D6TrN/b3E0iNQOwpKhc/n00nHwaN4m35+mYh5wEz06ygRPqfkMrBizyhlDw==
From:   Aleksa Sarai <cyphar@cyphar.com>
Date:   Mon, 14 Aug 2023 18:40:57 +1000
Subject: [PATCH v2 1/5] selftests: memfd: error out test process when child
 test fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-memfd-vm-noexec-uapi-fixes-v2-1-7ff9e3e10ba6@cyphar.com>
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
In-Reply-To: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=+Up0ghrBW/nfRj4bC3B4yqL0dFwv9KTB+GgoZwyV0aw=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTcfLFiw/TsfmWDxoNz8nnmrvi1iHnrP6m7AWasOo8m3
 1wekyNc2FHKwiDGxSArpsiyzc8zdNP8xVeSP61kg5nDygQyhIGLUwAmkpfFyDBRc+qvi5+lrvwq
 Uu9s9nvj/PqGRbrzrqg2Y4FZ6bO7O9cw/NPdWbdxP9tDl7XxbgXfxdZNaXf791I7X+J3+4PgVBu
 9RXwA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Before this change, a test runner using this self test would see a
return code of 0 when the tests using a child process (namely the
MFD_NOEXEC_SEAL and MFD_EXEC tests) failed, masking test failures.

Fixes: 11f75a01448f ("selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC")
Reviewed-by: Jeff Xu <jeffxu@google.com>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index dbdd9ec5e397..8eb49204f9ea 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1207,7 +1207,24 @@ static pid_t spawn_newpid_thread(unsigned int flags, int (*fn)(void *))
 
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

