Return-Path: <linux-kselftest+bounces-8931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D12D78B3E3E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 19:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4C628577E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 17:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AF4168AFD;
	Fri, 26 Apr 2024 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pbmiykND"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B6159585
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152646; cv=none; b=lWDYEFSdrbAl85oBxJg/wE6p/tgzkbtcE+qEMiBANczGtND/gj3ZWMUjjF2fZ5xbXngWuAzwgQbt3RyG6SHxAHw+NSKA6C+vE85JdnDiQblod27wRyygVxI7vmPPUTbaVUto3+BANvUrbCOQCbM+X715oJwZY7DTYSV2GoHIHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152646; c=relaxed/simple;
	bh=gwbWMnpY1+lUZlBeZaHSY89u6ODnUz6pnZkGqVpTNCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZsoOxCli8nvtJ0Ny0D09Lh+PyiGI9V9fVQRBkedxULSG93iZNL699ZMWHbXWJLdsPZoODqOtJ6n8FuU/JltnmaMJtb4nAqKc6N0YrrX00D5QtXIM0+acMQVvneMYDpfTxzI8bsnwXx5VKdERZ0EoqjYkuDrgtVoOa39OTXLY7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pbmiykND; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VR0172sVxz18Db;
	Fri, 26 Apr 2024 19:23:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714152187;
	bh=gwbWMnpY1+lUZlBeZaHSY89u6ODnUz6pnZkGqVpTNCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pbmiykND1AXRM5ZnVIIoaeUJ3Y14bvSN/SpP9EDXo5SCljXDDre058h2CAigBkjzV
	 nWHU9jZuZDz/DvGthgLXzE16Wr267NN2Nzc0uN8zynUeFZa7rcTzQHTO0AtRlfMycf
	 niblLrY9T1avT16y4yT0PlcIy4K/aUyrlLxMnx3I=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VR0166Ygpzgq1;
	Fri, 26 Apr 2024 19:23:06 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v1 3/5] selftests/harness: Fix fixture teardown
Date: Fri, 26 Apr 2024 19:22:50 +0200
Message-ID: <20240426172252.1862930-4-mic@digikod.net>
In-Reply-To: <20240426172252.1862930-1-mic@digikod.net>
References: <20240426172252.1862930-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Make sure fixture teardowns are run when test cases failed, including
when _metadata->teardown_parent is set to true.

Make sure only one fixture teardown is run per test case, handling the
case where the test child forks.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Shengyu Li <shengyu.li.evgeny@gmail.com>
Fixes: 72d7cb5c190b ("selftests/harness: Prevent infinite loop due to Assert in FIXTURE_TEARDOWN")
Fixes: 0710a1a73fb4 ("selftests/harness: Merge TEST_F_FORK() into TEST_F()")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240426172252.1862930-4-mic@digikod.net
---
 tools/testing/selftests/kselftest_harness.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index ba3ddeda24bf..73491efbae9e 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -383,7 +383,10 @@
 		FIXTURE_DATA(fixture_name) self; \
 		pid_t child = 1; \
 		int status = 0; \
-		bool jmp = false; \
+		/* Makes sure there is only one teardown, even when child forks again. */ \
+		bool *teardown = mmap(NULL, sizeof(*teardown), \
+			PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
+		*teardown = false; \
 		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
 		if (setjmp(_metadata->env) == 0) { \
 			/* Use the same _metadata. */ \
@@ -400,15 +403,16 @@
 				_metadata->exit_code = KSFT_FAIL; \
 			} \
 		} \
-		else \
-			jmp = true; \
 		if (child == 0) { \
-			if (_metadata->setup_completed && !_metadata->teardown_parent && !jmp) \
+			if (_metadata->setup_completed && !_metadata->teardown_parent && \
+					__sync_bool_compare_and_swap(teardown, false, true)) \
 				fixture_name##_teardown(_metadata, &self, variant->data); \
 			_exit(0); \
 		} \
-		if (_metadata->setup_completed && _metadata->teardown_parent) \
+		if (_metadata->setup_completed && _metadata->teardown_parent && \
+				__sync_bool_compare_and_swap(teardown, false, true)) \
 			fixture_name##_teardown(_metadata, &self, variant->data); \
+		munmap(teardown, sizeof(*teardown)); \
 		if (!WIFEXITED(status) && WIFSIGNALED(status)) \
 			/* Forward signal to __wait_for_test(). */ \
 			kill(getpid(), WTERMSIG(status)); \
-- 
2.44.0


