Return-Path: <linux-kselftest+bounces-10342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD298C85DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 13:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893692811FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 11:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789B34645B;
	Fri, 17 May 2024 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a78AsdW9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12446430;
	Fri, 17 May 2024 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715946436; cv=none; b=TqNCut4ENGLVqaxl0hZGA4Mhs0ghu14QYnLZr1gTPas9AXo4ccpag5LB0Wd2CXwj2By4JcIrhGX9SOKCVlFKKsHz0281/V63DDQOyJkmrBxx1CfBCVK0rEVLhiLhhbq9ezEya/FzIrXHaxvmJIjzfi9uUOsXSmDVD4xAmd35AfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715946436; c=relaxed/simple;
	bh=UoqNsGNyzyLu7s8bzQeD6P7uutNDfTV+vmBWhSAmYEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rdEtFGRtr/jfxKrVFX9wY065VoG0f4ofkeJNBf+kUzukhgyZpPzgKMAsZupuWwORp0ptPczS69lQ0ac/jORyLruDg5XXir00mtzGYSKPc/FbBM8u9PHl+IBJI47dZDrPEo0gw5MvDPgy7OtrJlGVQrzCe5grS1X5k7T8eluqc+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a78AsdW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9311C4AF07;
	Fri, 17 May 2024 11:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715946436;
	bh=UoqNsGNyzyLu7s8bzQeD6P7uutNDfTV+vmBWhSAmYEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a78AsdW997eVleC7I4mBtEYm9dUKx0MkihPH/trqPkmt0SCVZyhnkrzfWxuKmdel5
	 ZRMl5OVO4o4WYYz9biGJ0l+XKq316WwuLuFYxpTSlgmBGv3+l7L0/nICVxkb+U06F6
	 JVOhNBT1DpKF5hKB9cTJHLnN1Tqug05mdCvaGo6NSXasCcPRKOFM2/NUuKFGdPHSX2
	 otq4NVOyl9jGmrAMk5XAKkjaQBHoPrvokxa4leQtcSdbJD9LDGvJ7vyNYKuZO0g6RP
	 4f/3An+FQ+475nA2mt2P4Py9EQJYCwtYC6+bVRueDtx0TLUcl8OUxcO8N0nRX45k0p
	 cWJXngRytIpjw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Kees Cook <keescook@chromium.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH 2/2] selftests: harness: rename __constructor_order for clarification
Date: Fri, 17 May 2024 20:45:06 +0900
Message-Id: <20240517114506.1259203-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240517114506.1259203-1-masahiroy@kernel.org>
References: <20240517114506.1259203-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, __constructor_order is boolean; 1 for forward-order systems,
0 for reverse-order systems while parsing __LIST_APPEND().

Change it into a bool variable, and rename it for clarification.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 tools/testing/selftests/kselftest_harness.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 60c1cf5b0f0d..55f96037582b 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -774,7 +774,7 @@
 		item->prev = item; \
 		return;	\
 	} \
-	if (__constructor_order == _CONSTRUCTOR_ORDER_FORWARD) { \
+	if (__constructor_order_forward) { \
 		item->next = NULL; \
 		item->prev = head->prev; \
 		item->prev->next = item; \
@@ -837,9 +837,7 @@ struct __test_xfail {
 	}
 
 static struct __fixture_metadata *__fixture_list = &_fixture_global;
-static int __constructor_order;
-
-#define _CONSTRUCTOR_ORDER_FORWARD   1
+static bool __constructor_order_forward;
 
 static inline void __register_fixture(struct __fixture_metadata *f)
 {
@@ -891,7 +889,7 @@ static inline bool __test_passed(struct __test_metadata *metadata)
  * list so tests are run in source declaration order.
  * https://gcc.gnu.org/onlinedocs/gccint/Initialization.html
  * However, it seems not all toolchains do this correctly, so use
- * __constructor_order to detect which direction is called first
+ * __constructor_order_foward to detect which direction is called first
  * and adjust list building logic to get things running in the right
  * direction.
  */
@@ -1265,7 +1263,7 @@ static int test_harness_run(int argc, char **argv)
 
 static void __attribute__((constructor)) __constructor_order_first(void)
 {
-	__constructor_order = _CONSTRUCTOR_ORDER_FORWARD;
+	__constructor_order_forward = true;
 }
 
 #endif  /* __KSELFTEST_HARNESS_H */
-- 
2.40.1


