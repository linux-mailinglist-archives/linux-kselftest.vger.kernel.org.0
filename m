Return-Path: <linux-kselftest+bounces-4560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D9D8534FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 16:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9C3281595
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794E65EE94;
	Tue, 13 Feb 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jq9LsccR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507485EE82;
	Tue, 13 Feb 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839060; cv=none; b=XjNls2E2flRdaoFSu2hCls0EUAfpS3do4W4zKKwCH4co7qBM4HoXZzj46bfOT/I6s7owV/7335kIfpCApkXIfok29dzYh8C9SyCyvA0BFQr+byPFk1B9qTgifdEvjUUNOEOH/+foUA/s+s1SIwD0S33cHJ7KTZ9mmSN8wZUX0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839060; c=relaxed/simple;
	bh=ni3kaZ33B9N7PvNrBmt3HWRonPw71BUalFJvli7cMmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbU16lU9mgFr3MErT8kgXTmeY46EDXwaXJ1U+KZ+5Zt17tNeqyX/fItz05zIVveH/1al0pO2lLyDiX2fzdvk4rbondnZEeeiuUReBCNi++2pEbdNWuvFznpfAW/wGRSyJ8S+fIbvfl1XBjK+zuSqNV0TAXvdrDoXyrDIfivfbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jq9LsccR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC5DC43330;
	Tue, 13 Feb 2024 15:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707839059;
	bh=ni3kaZ33B9N7PvNrBmt3HWRonPw71BUalFJvli7cMmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jq9LsccRvJGCwCR4IWBFVuKngp56ORqhkoLsWQAcka8Tq5LCwg3JyE+/JFUJnA+cZ
	 /D3/LRr3lot176/nNl8aa1Rd+vk4ac2yVYgqLwqyMz2UT/RBo1fRiZ1ZIdNELepoBj
	 aPQQd22Vp/nY8DUsUrdBLbb29D+5Suv+fdS0MCqBOcAg5QU6vzL4amw+6gTu+gAIWQ
	 9iDy1f7W44D5LZJllewa0cajS5Hz558c/bdse6oLZf6b5NdAo0Xv7Tx4VcePAjvEh8
	 l5CX7B/kv7WYzOlrRKqrimMIign/JAPbP4ewqDM+NkO8o8PAo2wSbcZ4FWhIb8kT9T
	 11sSadK3/+9cA==
From: Jakub Kicinski <kuba@kernel.org>
To: shuah@kernel.org,
	keescook@chromium.org
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/4] selftests: kselftest_harness: use KSFT_* exit codes
Date: Tue, 13 Feb 2024 07:44:14 -0800
Message-ID: <20240213154416.422739-3-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213154416.422739-1-kuba@kernel.org>
References: <20240213154416.422739-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we no longer need low exit codes to communicate
assertion steps - use normal KSFT exit codes.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 98bdedf9a53a..618b41eac749 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -874,7 +874,7 @@ static inline void __test_check_assert(struct __test_metadata *t)
 {
 	if (t->aborted) {
 		if (t->no_print)
-			_exit(1);
+			_exit(KSFT_FAIL);
 		abort();
 	}
 }
@@ -937,7 +937,7 @@ void __wait_for_test(struct __test_metadata *t)
 		fprintf(TH_LOG_STREAM,
 			"# %s: Test terminated by timeout\n", t->name);
 	} else if (WIFEXITED(status)) {
-		if (WEXITSTATUS(status) == 255) {
+		if (WEXITSTATUS(status) == KSFT_SKIP) {
 			/* SKIP */
 			t->passed = 1;
 			t->skip = 1;
@@ -950,7 +950,7 @@ void __wait_for_test(struct __test_metadata *t)
 		} else {
 			switch (WEXITSTATUS(status)) {
 			/* Success */
-			case 0:
+			case KSFT_PASS:
 				t->passed = 1;
 				break;
 			/* Other failure, assume step report. */
@@ -1132,12 +1132,11 @@ void __run_test(struct __fixture_metadata *f,
 		setpgrp();
 		t->fn(t, variant);
 		if (t->skip)
-			_exit(255);
-		/* Pass is exit 0 */
+			_exit(KSFT_SKIP);
 		if (t->passed)
-			_exit(0);
+			_exit(KSFT_PASS);
 		/* Something else happened. */
-		_exit(1);
+		_exit(KSFT_FAIL);
 	} else {
 		__wait_for_test(t);
 	}
-- 
2.43.0


