Return-Path: <linux-kselftest+bounces-48846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A11D17E09
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 11:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 989EB3011EED
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 10:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4CA340D86;
	Tue, 13 Jan 2026 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFh/IdYP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3F1226CF6;
	Tue, 13 Jan 2026 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299036; cv=none; b=MbuTIexw6BnQUM1GDBwz1kmtbkEHLzHAoy1AkExwnbF6LZZos+ynaBpDeNPmCzl8YWAXBdGbHC7QeU39hXL0uzmoFtcAc653BE33u/ksQwhZgKHCKxoB6H4mhG41tHLg8idCSwX4fZbdFnI4HbbPh5zknqFQlRTyPbxzOKomVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299036; c=relaxed/simple;
	bh=JKHef7WhHyYDGxpGQ+LVQ6TXTwmF42rEnY/TaenfQxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXTwMrbBlaigXEnpSdhJlO5JWOj8qi8b+uBFiL8fMOJJTTUnCp17fDE9E8Mh9TRlAkRzUvhu6mMkwtv7aCjtVKViNw0u5gJNh1HudYMXaSeqwMypP1cvmX3SspkiGy+XOGELmJfqOMBm2W4NPumi+97fGJ8NsI3P0/zr2bGYP9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFh/IdYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6725CC116C6;
	Tue, 13 Jan 2026 10:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768299035;
	bh=JKHef7WhHyYDGxpGQ+LVQ6TXTwmF42rEnY/TaenfQxs=;
	h=From:To:Cc:Subject:Date:From;
	b=iFh/IdYPz9atardwjFPa78PZ7U1pm1hW8m2rzuJC3kEVr1GZMzRKHCbjI7sJiJgwP
	 7CH78ygYS8pGFy45XXZxoLMQtd44yzA8KmT75WrF4yrtEVX9rr5cHM3hCfnI02Fd2x
	 SBGRQuwyiFa2yNGK8hb+wZpfsI56tZeCLZavFujlvz1vXqT8kAgu7jNYWiE3evk8GA
	 xMjQmvrydvF2f40wQXrOzUVguBkg+eJNWAp5wdzYiJrA38FwKvb/CEAmbmnJgiPa+T
	 ThWQgg0CSemzjWWXFR69nkmGWlLAu3ezM8hYCri7GV5zJCXe0dlvytrA5+UO0Wo4OU
	 uZ8fZMmGztzXw==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	"Dmitry V. Levin" <ldv@strace.io>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: harness: fix again 32-bit build warnings in __EXPECT()
Date: Tue, 13 Jan 2026 11:08:14 +0100
Message-ID: <948937bfe461cf0fb6ade2623e51f673f845fa51.1768298756.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5090; i=chleroy@kernel.org; h=from:subject:message-id; bh=JKHef7WhHyYDGxpGQ+LVQ6TXTwmF42rEnY/TaenfQxs=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSmSfbFsmmvkzjrdzUnpFz26Vyp1SZvsoTn8b6afSViz V4zrflzO0pZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBE/n9j+MN73+Xz0gT5GWov hRW/VzYm6eaci9CLTjoatviR954S2whGhk43l/23Vih7lUlcXHrw/lu2h1zchlob9M72Lp/Jdbn 5Jh8A
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/testing/selftests/kselftest_harness.h:770:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  770 |                         uintmax_t __exp_print = (uintmax_t)__exp; \
      |                                                 ^
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/testing/selftests/kselftest_harness.h:530:9: note: in expansion of macro '__EXPECT'
  530 |         __EXPECT(expected, #expected, seen, #seen, !=, 1)
      |         ^~~~~~~~
test-pcmtest-driver.c:137:9: note: in expansion of macro 'ASSERT_NE'
  137 |         ASSERT_NE(card_name, NULL);
      |         ^~~~~~~~~
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/testing/selftests/kselftest_harness.h:771:50: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  771 |                         uintmax_t __seen_print = (uintmax_t)__seen; \
      |                                                  ^
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/testing/selftests/kselftest_harness.h:530:9: note: in expansion of macro '__EXPECT'
  530 |         __EXPECT(expected, #expected, seen, #seen, !=, 1)
      |         ^~~~~~~~
test-pcmtest-driver.c:137:9: note: in expansion of macro 'ASSERT_NE'
  137 |         ASSERT_NE(card_name, NULL);
      |         ^~~~~~~~~
...

Those warnings were fixed by commit b5bb6d3068ea ("selftests/seccomp:
fix 32-bit build warnings") but then reintroduced by
commit 02bc220dc6dc ("selftests: harness: fix printing of mismatch
values in __EXPECT()")

Fix them for good this time, without re-introducing the printing
mismatch.

Fixes: 02bc220dc6dc ("selftests: harness: fix printing of mismatch values in __EXPECT()")
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 37 ++++++++++++---------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 16a119a4656c7..80a81f96fd5bf 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -759,6 +759,11 @@ static inline void __kselftest_memset_safe(void *s, int c, size_t n)
 
 #define is_signed_var(var)	(!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
 
+#define __ulong_type(x) \
+	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
+#define __long_type(x) \
+	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0L), 0LL, 0L))
+
 #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
 	/* Avoid multiple evaluation of the cases */ \
 	__typeof__(_expected) __exp = (_expected); \
@@ -767,35 +772,35 @@ static inline void __kselftest_memset_safe(void *s, int c, size_t n)
 		/* Report with actual signedness to avoid weird output. */ \
 		switch (is_signed_var(__exp) * 2 + is_signed_var(__seen)) { \
 		case 0: { \
-			uintmax_t __exp_print = (uintmax_t)__exp; \
-			uintmax_t __seen_print = (uintmax_t)__seen; \
+			__ulong_type(__exp) __exp_print = (__ulong_type(__exp))__exp; \
+			__ulong_type(__seen) __seen_print = (__ulong_type(__seen))__seen; \
 			__TH_LOG("Expected %s (%ju) %s %s (%ju)", \
-				 _expected_str, __exp_print, #_t, \
-				 _seen_str, __seen_print); \
+				 _expected_str, (uintmax_t)__exp_print, #_t, \
+				 _seen_str, (uintmax_t)__seen_print); \
 			break; \
 			} \
 		case 1: { \
-			uintmax_t __exp_print = (uintmax_t)__exp; \
-			intmax_t  __seen_print = (intmax_t)__seen; \
+			__ulong_type(__exp) __exp_print = (__ulong_type(__exp))__exp; \
+			__long_type(__seen) __seen_print = (__long_type(__seen))__seen; \
 			__TH_LOG("Expected %s (%ju) %s %s (%jd)", \
-				 _expected_str, __exp_print, #_t, \
-				 _seen_str, __seen_print); \
+				 _expected_str, (uintmax_t)__exp_print, #_t, \
+				 _seen_str, (intmax_t)__seen_print); \
 			break; \
 			} \
 		case 2: { \
-			intmax_t  __exp_print = (intmax_t)__exp; \
-			uintmax_t __seen_print = (uintmax_t)__seen; \
+			__long_type(__exp) __exp_print = (__long_type(__exp))__exp; \
+			__ulong_type(__seen) __seen_print = (__ulong_type(__seen))__seen; \
 			__TH_LOG("Expected %s (%jd) %s %s (%ju)", \
-				 _expected_str, __exp_print, #_t, \
-				 _seen_str, __seen_print); \
+				 _expected_str, (intmax_t)__exp_print, #_t, \
+				 _seen_str, (uintmax_t)__seen_print); \
 			break; \
 			} \
 		case 3: { \
-			intmax_t  __exp_print = (intmax_t)__exp; \
-			intmax_t  __seen_print = (intmax_t)__seen; \
+			__long_type(__exp) __exp_print = (__long_type(__exp))__exp; \
+			__long_type(__seen) __seen_print = (__long_type(__seen))__seen; \
 			__TH_LOG("Expected %s (%jd) %s %s (%jd)", \
-				 _expected_str, __exp_print, #_t, \
-				 _seen_str, __seen_print); \
+				 _expected_str, (intmax_t)__exp_print, #_t, \
+				 _seen_str, (intmax_t)__seen_print); \
 			break; \
 			} \
 		} \
-- 
2.49.0


