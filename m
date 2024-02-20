Return-Path: <linux-kselftest+bounces-5067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEEC85C4AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 20:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFE01C21206
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 19:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4918914E2E8;
	Tue, 20 Feb 2024 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djnSW9lC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1AE14E2DC;
	Tue, 20 Feb 2024 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456971; cv=none; b=RWYvB8ran9tp3u5Hql4vd95pjAFSqHEvIE22395uyIEWrTEKOJS04/x7bwtHPEpU1/eXLPfPKSSXkxhjBrG+/AjmHqkHYBmg8DlIQnrOO4i99FNE46RRZH1F+YUA3L2fUCODApaAawD1twbDsIbnbBw41StEgFUpNhII37Qq4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456971; c=relaxed/simple;
	bh=cYocYM4a4DJFgijvA8HgeBwLvdbc/wQhimkAwiVCBwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnveUABhgVhmWjXSbNamiXPzKfvdOjLNCVedvMZAj8OP/UTHoj48iuun0OFrdd9I6pE0vbetRzOZs9Zh6GRpI+YJBbvDWT0tEg5+3Mcr6w0KIOUkkkncEYYpgTjsu9qVCqN9oKeJibEdue7V2bJZcteGmvUf3pplN36StZfIjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djnSW9lC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D67C43399;
	Tue, 20 Feb 2024 19:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456971;
	bh=cYocYM4a4DJFgijvA8HgeBwLvdbc/wQhimkAwiVCBwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=djnSW9lCiqYnAdp7+cy6FTQO9RrJxRa9z+5+WC4sBozKgWg4jzggnOitloUELOZNp
	 Z6Pqcli+5Biig4ssTcW5T28+fSIaoonq3HupSmHIUdLFqacXeN6d8W7ZJpbH3r7w5j
	 qQg857qmWm2xbalk1Mc9+ad63Mbd1KmJriqmgxeEzp+9sLoAs/ANS9slvMH/VtRYxT
	 8feHXbLMitgvzevMmQMTXD/XaqwQeI/kpCtBWnJk5+zjGBqNGJRRLj4RAmuTZmS7g6
	 DQ02Pe+jfc3PE2JupAku7cEjHhz2m6re0ygkEdOjcMBCp5qMXsuvd0ZyPuA3aRlET4
	 8/9GVymjZLRQQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	mic@digikod.net,
	linux-security-module@vger.kernel.org,
	keescook@chromium.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 08/11] selftests: kselftest_harness: separate diagnostic message with # in ksft_test_result_code()
Date: Tue, 20 Feb 2024 11:22:32 -0800
Message-ID: <20240220192235.2953484-9-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220192235.2953484-1-kuba@kernel.org>
References: <20240220192235.2953484-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the spec we should always print a # if we add
a diagnostic message. Having the caller pass in the new line
as part of diagnostic message makes handling this a bit
counter-intuitive, so append the new line in the helper.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest.h         | 5 +++++
 tools/testing/selftests/kselftest_harness.h | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 25e29626566e..541bf192e30e 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -287,10 +287,15 @@ void ksft_test_result_code(int exit_code, const char *test_name,
 		break;
 	}
 
+	/* Docs seem to call for double space if directive is absent */
+	if (!directive[0] && msg[0])
+		directive = " #  ";
+
 	va_start(args, msg);
 	printf("%s %u %s%s", tap_code, ksft_test_num(), test_name, directive);
 	errno = saved_errno;
 	vprintf(msg, args);
+	printf("\n");
 	va_end(args);
 }
 
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index a1a794e4b8f6..6157a7b059c6 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1152,7 +1152,7 @@ void __run_test(struct __fixture_metadata *f,
 
 	if (t->exit_code == KSFT_SKIP)
 		ksft_test_result_code(t->exit_code, test_name,
-				      "%s\n", diagnostic);
+				      "%s", diagnostic);
 	else
 		ksft_test_result(__test_passed(t), "%s\n", test_name);
 }
-- 
2.43.0


