Return-Path: <linux-kselftest+bounces-8795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852A68B10E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 19:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BBBB1F260E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF52016D4F5;
	Wed, 24 Apr 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQri94Qa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2216D4F1;
	Wed, 24 Apr 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979489; cv=none; b=fhmMKxtNDvR/KUGi/mCSHvfyPZyeZDBcTxm5e/dD63KwOhO0Ed3i+L28h92vae8L/gH/jYoYxeyUMaF141ESfSby5BtDkzwYfcrX+GBF2pB215CKkoWvCjxRGxafUF/2H5PdGENHpQrmW7SlJZNf2Z+Pd71Flj522EnEcdWYCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979489; c=relaxed/simple;
	bh=mqainrt4XKLYv8z9kzm8G5QEs7BPDOFUczSJPMpBbf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t9NWYmjZVC2QyOtpu0nN4AZf1tDXhp8FbXcaxEy09dO7lk0+9pUTf2H+JJLWNREHj2kh86eXMM2sWZ1K77zQJQIvRNT8jBsCj8xdCHTxRdldSgu7Ll+q0APIV9Au4/Flw2+dqO78IPz9DwY8xkpxsEDMypSBGRWcHjVYIsnQhuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQri94Qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF86AC2BD11;
	Wed, 24 Apr 2024 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713979489;
	bh=mqainrt4XKLYv8z9kzm8G5QEs7BPDOFUczSJPMpBbf4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RQri94QaNujD4nSl1pa6U3zylHpkeH3t7VIkaeTH7mS3kPyCwRx9Dk28CC+Auv1uf
	 M5ePDrT3qVx+DR2IADn+PSp0xW+xlI51kbvPoq25QJpBwFBc3HY9soiUWfFtVCbQ2P
	 MKg6Ac0a0Hg3ulRbkOOJbmYgfbL5hSW1KOBZGt27ztldIa4nZT/sCmFD6W+dNkU4Cw
	 vXkYbyPSUidn6Ew6t+NLpYPgKaIORO+/1vgzKXBSoFiPsEl3/2JP3kSO1nPOgwWfJy
	 0WdR8X7LpptJvr1mTQP0BYErOAt7EQbcZsh4xTSfQiB48MbcXyevmRPCEjFexUMpTk
	 g0LOz8CvV0sZg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 24 Apr 2024 10:24:06 -0700
Subject: [PATCH v2 03/10] selftests: membarrier: ksft_exit_pass() does not
 return
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-ksft-exit-int-to-void-v2-3-c35f3b8c9ca0@kernel.org>
References: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
In-Reply-To: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2001; i=nathan@kernel.org;
 h=from:subject:message-id; bh=mqainrt4XKLYv8z9kzm8G5QEs7BPDOFUczSJPMpBbf4=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGmaDrGp+XcZWmt3m6y3XJs+teveNYcZk7+9dPiUGJt4y
 C2p+ezXjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCR978ZGab8djvy0ND+1ZP1
 DpPdu1oeVmn8yzTdl29+yyLht2Wk8xaG/0712dyhNkflWA83Ky2JYCks0i0L+HfpVfeH3eLtGSf
 a+AE=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
unconditionally call exit() as __noreturn"), ksft_exit_...() functions
are marked as __noreturn, which means the return type should not be
'int' but 'void' because they are not returning anything (and never were
since exit() has always been called).

To facilitate updating the return type of these functions, remove
'return' before the calls to ksft_exit_pass(), as __noreturn prevents
the compiler from warning that a caller of ksft_exit_pass() does not
return a value because the program will terminate upon calling these
functions.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 tools/testing/selftests/membarrier/membarrier_test_multi_thread.c  | 2 +-
 tools/testing/selftests/membarrier/membarrier_test_single_thread.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
index a9cc17facfb3..4e14dba81234 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
@@ -69,5 +69,5 @@ int main(int argc, char **argv)
 	/* Multi-threaded */
 	test_mt_membarrier();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
index 4cdc8b1d124c..fa3f1d6c37a0 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
@@ -24,5 +24,5 @@ int main(int argc, char **argv)
 
 	test_membarrier_get_registrations(/*cmd=*/0);
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }

-- 
2.44.0


