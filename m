Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB43113C66
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2019 08:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfLEHdf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Dec 2019 02:33:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfLEHdf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Dec 2019 02:33:35 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C71A5206DB;
        Thu,  5 Dec 2019 07:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575531214;
        bh=SBlr5dGydninkCDGtDUbXFFCG6ezPnNxiEjeRYEwuos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Va/Ukuz+0YrrEfObgoolC1QzPARgKjmUxfrq65d5byh56/HUuqj4+PW4oqeBWBaGx
         Z8+kXmkCRVhj9HV1JAVnRF9Ttr9Xa3RJ3w53ZP8w01fbyunTPE7OE/2TqwOE+ZZrlR
         QmNvrFvRGQX/6FDuzVmkDkRuSRKp3zRq+9Q7nKE8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org
Subject: [BUGFIX PATCH 2/2] selftests: safesetid: Check the return value of setuid/setgid
Date:   Thu,  5 Dec 2019 16:33:30 +0900
Message-Id: <157553121008.17524.16085800798083225143.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157553119188.17524.1379079312058580155.stgit@devnote2>
References: <157553119188.17524.1379079312058580155.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Check the return value of setuid() and setgid().
This fixes the following warnings and improves test result.

safesetid-test.c: In function ‘main’:
safesetid-test.c:294:2: warning: ignoring return value of ‘setuid’, declared with attribute warn_unused_result [-Wunused-result]
  setuid(NO_POLICY_USER);
  ^~~~~~~~~~~~~~~~~~~~~~
safesetid-test.c:295:2: warning: ignoring return value of ‘setgid’, declared with attribute warn_unused_result [-Wunused-result]
  setgid(NO_POLICY_USER);
  ^~~~~~~~~~~~~~~~~~~~~~
safesetid-test.c:309:2: warning: ignoring return value of ‘setuid’, declared with attribute warn_unused_result [-Wunused-result]
  setuid(RESTRICTED_PARENT);
  ^~~~~~~~~~~~~~~~~~~~~~~~~
safesetid-test.c:310:2: warning: ignoring return value of ‘setgid’, declared with attribute warn_unused_result [-Wunused-result]
  setgid(RESTRICTED_PARENT);
  ^~~~~~~~~~~~~~~~~~~~~~~~~
safesetid-test.c: In function ‘test_setuid’:
safesetid-test.c:216:3: warning: ignoring return value of ‘setuid’, declared with attribute warn_unused_result [-Wunused-result]
   setuid(child_uid);
   ^~~~~~~~~~~~~~~~~

Fixes: c67e8ec03f3f ("LSM: SafeSetID: add selftest")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/safesetid/safesetid-test.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index 8f40c6ecdad1..0c4d50644c13 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -213,7 +213,8 @@ static void test_setuid(uid_t child_uid, bool expect_success)
 	}
 
 	if (cpid == 0) {	    /* Code executed by child */
-		setuid(child_uid);
+		if (setuid(child_uid) < 0)
+			exit(EXIT_FAILURE);
 		if (getuid() == child_uid)
 			exit(EXIT_SUCCESS);
 		else
@@ -291,8 +292,10 @@ int main(int argc, char **argv)
 
 	// First test to make sure we can write userns mappings from a user
 	// that doesn't have any restrictions (as long as it has CAP_SETUID);
-	setuid(NO_POLICY_USER);
-	setgid(NO_POLICY_USER);
+	if (setuid(NO_POLICY_USER) < 0)
+		die("Error with set uid(%d)\n", NO_POLICY_USER);
+	if (setgid(NO_POLICY_USER) < 0)
+		die("Error with set gid(%d)\n", NO_POLICY_USER);
 
 	// Take away all but setid caps
 	drop_caps(true);
@@ -306,8 +309,10 @@ int main(int argc, char **argv)
 		die("test_userns failed when it should work\n");
 	}
 
-	setuid(RESTRICTED_PARENT);
-	setgid(RESTRICTED_PARENT);
+	if (setuid(RESTRICTED_PARENT) < 0)
+		die("Error with set uid(%d)\n", RESTRICTED_PARENT);
+	if (setgid(RESTRICTED_PARENT) < 0)
+		die("Error with set gid(%d)\n", RESTRICTED_PARENT);
 
 	test_setuid(ROOT_USER, false);
 	test_setuid(ALLOWED_CHILD1, true);

