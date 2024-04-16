Return-Path: <linux-kselftest+bounces-8169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16F48A6F64
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFCA1C2142C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1FF130A64;
	Tue, 16 Apr 2024 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L65O9/Zc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9E130A53;
	Tue, 16 Apr 2024 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280252; cv=none; b=bAMSXi6xiDVZ+46Ukg1dVofLS0fkuToesjcHjXrXMINcNxMpuvAKer5QLGY9iis3I/QHyk0d42O4fP/R2pdMBrb/5CeF2L1wkeNvCRDCmwdgk2isftZINEpfqEGLG1iHusfyfd+7N+ubZd+doZLAAevxG7sCCKsWJDP7r5H3Qik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280252; c=relaxed/simple;
	bh=gBhQjR8yERzBtR2F1oH15eDu+jFh9H2wAEw6XnlibhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCn77OZXYQ5s/HUiLpoKRTx7szqjsuDRe8bXBPL1BhGi0+cJIL6i1irRkMPTkJlhIbue+s71IYMYpVBAYOMX+Bhw6DBdqtrXfig6U18dMEt89bbYnpboCBNpFe3r6s9eZi2N+FfNWPRq2GaqGWuO9G3/obrC+wUe4so9IkJLz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L65O9/Zc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A43C32783;
	Tue, 16 Apr 2024 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713280251;
	bh=gBhQjR8yERzBtR2F1oH15eDu+jFh9H2wAEw6XnlibhI=;
	h=From:To:Cc:Subject:Date:From;
	b=L65O9/ZcjKoGSTyRtXFSeOUn5fZulsRGtFjMV2kWXNKUs9u8xAQJhU2xE2hIbvkNT
	 SMxsKYBsI5cN8ymAvcqks0HcXawUQG2Uok8Qs7Jmqkpv5UGF9uAZELEU3q94cy+eay
	 Magtte9Jd/0iIxe1TSJ4IvGqwz8B3eRQp9bhI2UwJZLUXFmKdSerIKzo+BW32O7ngB
	 dJbx7pPOF/Ag0Q8JuVxagxyyPUAdKA70qkjWeECmZDzSoAGTTPl8NWr3SMjpb3yo9j
	 0LFQUgi/BoY6s9kPD8BUsRWSQJyNr506oDRnSEsz7cuSgVQFrXMHeeS1s0J3hhKitD
	 qlRCrSIKdBs9g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	shuah@kernel.org,
	keescook@chromium.org,
	usama.anjum@collabora.com,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH net] selftests: kselftest_harness: fix Clang warning about zero-length format
Date: Tue, 16 Apr 2024 08:10:48 -0700
Message-ID: <20240416151048.1682352-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently it's more legal to pass the format as NULL, than
it is to use an empty string. Clang complains about empty
formats:

./../kselftest_harness.h:1207:30: warning: format string is empty
[-Wformat-zero-length]
 1207 |            diagnostic ? "%s" : "", diagnostic);
      |                                 ^~
1 warning generated.

Reported-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/20240409224256.1581292-1-seanjc@google.com
Fixes: 378193eff339 ("selftests: kselftest_harness: let PASS / FAIL provide diagnostic")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
---
CC: shuah@kernel.org
CC: keescook@chromium.org
CC: usama.anjum@collabora.com
CC: linux-kselftest@vger.kernel.org
CC: llvm@lists.linux.dev
---
 tools/testing/selftests/kselftest.h         | 10 ++++++----
 tools/testing/selftests/kselftest_harness.h |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 541bf192e30e..4eca3fd1292c 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -288,15 +288,17 @@ void ksft_test_result_code(int exit_code, const char *test_name,
 	}
 
 	/* Docs seem to call for double space if directive is absent */
-	if (!directive[0] && msg[0])
+	if (!directive[0] && msg)
 		directive = " #  ";
 
-	va_start(args, msg);
 	printf("%s %u %s%s", tap_code, ksft_test_num(), test_name, directive);
 	errno = saved_errno;
-	vprintf(msg, args);
+	if (msg) {
+		va_start(args, msg);
+		vprintf(msg, args);
+		va_end(args);
+	}
 	printf("\n");
-	va_end(args);
 }
 
 static inline int ksft_exit_pass(void)
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 4fd735e48ee7..adb15cae79ab 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1202,7 +1202,7 @@ void __run_test(struct __fixture_metadata *f,
 		diagnostic = "unknown";
 
 	ksft_test_result_code(t->exit_code, test_name,
-			      diagnostic ? "%s" : "", diagnostic);
+			      diagnostic ? "%s" : NULL, diagnostic);
 }
 
 static int test_harness_run(int argc, char **argv)
-- 
2.44.0


