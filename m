Return-Path: <linux-kselftest+bounces-14312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D121193DFC3
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 16:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5711F216EF
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 14:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB87817F39C;
	Sat, 27 Jul 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVJ8IIEz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0117A91B;
	Sat, 27 Jul 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722091113; cv=none; b=sLvPYbinnLQSix9RiLigb2hTZHC22lONWV8B4IK14WnoYB8uHIipFX7ra2iUOOsRjt/xfW89buUZcSKWOZMnt84Lrkm5Wz6PDuQJW79CbwwCb2DT5UHzNWvu7n+kUF90xatlviiVIVaU0Zhm/0fIm/Xp6zVsugE7FfAQr9eN03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722091113; c=relaxed/simple;
	bh=8y5f1zxNiODm4UXL4eX5MjelZjB7Y2NyylWPMZ1tbag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihYAVicRtL0YC1Bl+r3d+4f8hSfTt7i6nMRVtYVlTtbNjQMkiXzHbjtEnFSQiSWDl48XRKGAP3boT2vseoCSW7NGNaN1SxPnIq96jReAVlqWie7vBFtboJPx0LyKAwY0XZG3GN/hDPtM5jkppVCxK4I5bsNQnQ50mkcVhLC0HSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVJ8IIEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA9FC4AF0A;
	Sat, 27 Jul 2024 14:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722091113;
	bh=8y5f1zxNiODm4UXL4eX5MjelZjB7Y2NyylWPMZ1tbag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pVJ8IIEzH/I0l/gaMh1csDBJt6zM3aQWBVZLnJmi0spUCIHCjXMvDxNoroxuEELCg
	 Xaj1yrlThXOwSAU+h54gFP1DRc/V61gGQeCd4J4YpNKGSn0HUZkfY8uDBp0/3OaE5t
	 q4knupyV9yXB877qLLId9Pa+qmFEQORW4XtXOH7mLskM+UHq28CwOEoY9mEL3cYckg
	 en1IRUjV7vtVdmlxBTevkn2LEFq+l7XNieQ61VVrCzEkk/bUGRhiCIAj2aEHd8W2Ye
	 ljT9aLlhh0lxUx0X1bo02vvMqf8aado/yQRBmxUAAX3+XNCh6ZKfcQ8MP3Y+ibZIC2
	 OY9kTCi/JG4yw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/2] selftests: harness: rename __constructor_order for clarification
Date: Sat, 27 Jul 2024 23:37:37 +0900
Message-ID: <20240727143816.1808657-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240727143816.1808657-1-masahiroy@kernel.org>
References: <20240727143816.1808657-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, __constructor_order is boolean; 1 for forward-order systems,
0 for backward-order systems while parsing __LIST_APPEND().

Change it into a bool variable, and rename it for clarification.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
 - reword "reverse-order" to "backward-order" in commit description

 tools/testing/selftests/kselftest_harness.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 71648d2102cb..a5a72415e37b 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -818,7 +818,7 @@
 		item->prev = item; \
 		return;	\
 	} \
-	if (__constructor_order == _CONSTRUCTOR_ORDER_FORWARD) { \
+	if (__constructor_order_forward) { \
 		item->next = NULL; \
 		item->prev = head->prev; \
 		item->prev->next = item; \
@@ -882,9 +882,7 @@ struct __test_xfail {
 	}
 
 static struct __fixture_metadata *__fixture_list = &_fixture_global;
-static int __constructor_order;
-
-#define _CONSTRUCTOR_ORDER_FORWARD   1
+static bool __constructor_order_forward;
 
 static inline void __register_fixture(struct __fixture_metadata *f)
 {
@@ -935,7 +933,7 @@ static inline bool __test_passed(struct __test_metadata *metadata)
  * list so tests are run in source declaration order.
  * https://gcc.gnu.org/onlinedocs/gccint/Initialization.html
  * However, it seems not all toolchains do this correctly, so use
- * __constructor_order to detect which direction is called first
+ * __constructor_order_foward to detect which direction is called first
  * and adjust list building logic to get things running in the right
  * direction.
  */
@@ -1330,7 +1328,7 @@ static int test_harness_run(int argc, char **argv)
 
 static void __attribute__((constructor)) __constructor_order_first(void)
 {
-	__constructor_order = _CONSTRUCTOR_ORDER_FORWARD;
+	__constructor_order_forward = true;
 }
 
 #endif  /* __KSELFTEST_HARNESS_H */
-- 
2.43.0


