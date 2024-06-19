Return-Path: <linux-kselftest+bounces-12265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A900B90F77A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 22:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF801F23B3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 20:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FED177114;
	Wed, 19 Jun 2024 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzRggGZn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B9FC0C;
	Wed, 19 Jun 2024 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718828720; cv=none; b=Q7wOBoue4yFMvK2VdUPVnhwkmZNjYssTvrIGSo7+8Yram+LyittCG3+5rE6saDkMS71gun8+lps8b8Nw4oO95iFmR4yGy7+CpdAnl9pdOHCVvyvrgnbxO1aaZNGDsDj3ilR4ToFwLMbrcR5EhGcUGOgGvvlZopjUIuOh5CWueKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718828720; c=relaxed/simple;
	bh=0z/x4MbHkEbrGTPcfTeUJ/C6WA/I36PZC2kojq3ru0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y29nkmjcpiDGZw26zAUaBQS1rDmAZ8wwXektfdBm510BRdhpE+awLHHrXsdM8YVsvO7wFiTmDVbAZ26kVnzQWYjR5Lw8+tdmI1nNS99yZ7MX53Kwb5htXjStaazD1CXuivS7JqYtRWKTZdryORfUV6kD5zhwevfolWYY3XBUUDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzRggGZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5349C2BBFC;
	Wed, 19 Jun 2024 20:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718828719;
	bh=0z/x4MbHkEbrGTPcfTeUJ/C6WA/I36PZC2kojq3ru0U=;
	h=From:To:Cc:Subject:Date:From;
	b=UzRggGZnu1PG7nb9uFUxMW+IohcWrxAskgFAQgF0qAV/CF25ETWzCD4SaHDI8SLdl
	 7SYbcnt+NM+8e28uSW35DH7+YYCvxIIKL5tFKW85kBwk/XbbmU41v876fKphrq7biw
	 fqxSjDjsr8XO6GkTlrAf+C8wU0kO9GZFtkNY5pPnN65Qn3YCA0knMdlgCZtOAkaQ8s
	 T2NTNvWlBPiBufibsmAQZr67CbUg2KUjU9+lg+6Ly93QiH2U+yOdP7wYbrKMc82gnf
	 CBmKSkakkvgXKtiBd/xjZIhcaV2OfHX976lrKSeq3RQBhI37hnti5XvJH4pqygRq4H
	 G2mbjjt4DmJ3A==
From: Kees Cook <kees@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kunit/usercopy: Disable testing on !CONFIG_MMU
Date: Wed, 19 Jun 2024 13:25:17 -0700
Message-Id: <20240619202511.it.861-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2264; i=kees@kernel.org; h=from:subject:message-id; bh=0z/x4MbHkEbrGTPcfTeUJ/C6WA/I36PZC2kojq3ru0U=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmcz6ty3U7pJ3+ihHl7H2BhHZj95uen4wpNRK9Z 3dLLGlY+JCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnM+rQAKCRCJcvTf3G3A JiDxEACuAwOoGKwQIEtgmI414mZiL7poZ8RdTRgD6cSwvOyPra7Yf/2KwJkUMiXrLd5ckYIMn5Y 7P1qVJF94xz7dMHVXVuNf7CgeHBtXLvP5YWCmAVHpwKBOX1YDVelLG60ylnwvg7NTEPZ/BMrx1a aFNiaNw6dqwzm0l6efBQF8kQg1fQ9kBjYQ1FJ7O98Iu1ZdX/dn7OT/5KIXndF5mxt7RWvIZ6aVP 6Q1ZGMP1D5gqz7MKRq9ob28HdzJik3g+ehFuQ0WTUXbxzrCRDPDrDiaHnIAqVaUUTcDcm4A1QIg 5hKHvUjHucwHCf8fFK20K06pXLTQ3X1dD3c/GwG3N9aVLj6jmUg7WBo1uO/SYCoDU7RNQyp2UcE yD/Nt9MhV5gKegAzPvjCx0nAvvt7Ur2EuRS0sqojHX0qjlwljwus0jqnn/42UF+ssnSPrDjw8ZX GIZnncTWtPDf64LT+YsEDWFEoI3nAgoafnNljgiCNs3N86eQaQWB0u8EMuoSID6+vvlNBPVgjOA x9Iz3e8qO9aiPm0CgZ77bng7NBx9s++fGrvZ2uZ6olo6QzZz7zXZpdkcMcSgkBQ2gEPGhuksHOA hXWQbi/q6n1u3/ngYkDyOX+Dw8t1KVGLqKn7zEqgrrnYFiWoH2hKTiK7m8urENljyRPiHbdY0Hw q9rSpWPX7HEbz
 eA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Since arch_pick_mmap_layout() is an inline for non-MMU systems, disable
this test there.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406160505.uBge6TMY-lkp@intel.com/
Signed-off-by: Kees Cook <kees@kernel.org>
---
Resending as v2 with Shuah in To:
---
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: linux-hardening@vger.kernel.org
Cc: linux-mm@kvack.org
---
 lib/kunit/user_alloc.c | 4 ++++
 lib/usercopy_kunit.c   | 5 +++++
 mm/util.c              | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
index 76d3d1345ed7..ae935df09a5e 100644
--- a/lib/kunit/user_alloc.c
+++ b/lib/kunit/user_alloc.c
@@ -30,6 +30,10 @@ static int kunit_attach_mm(void)
 	if (current->mm)
 		return 0;
 
+	/* arch_pick_mmap_layout() is only sane with MMU systems. */
+	if (!IS_ENABLED(CONFIG_MMU))
+		return -EINVAL;
+
 	mm = mm_alloc();
 	if (!mm)
 		return -ENOMEM;
diff --git a/lib/usercopy_kunit.c b/lib/usercopy_kunit.c
index 45f1e558c464..e819561a540d 100644
--- a/lib/usercopy_kunit.c
+++ b/lib/usercopy_kunit.c
@@ -290,6 +290,11 @@ static int usercopy_test_init(struct kunit *test)
 	struct usercopy_test_priv *priv;
 	unsigned long user_addr;
 
+	if (!IS_ENABLED(CONFIG_MMU)) {
+		kunit_skip(test, "Userspace allocation testing not available on non-MMU systems");
+		return 0;
+	}
+
 	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
 	test->priv = priv;
diff --git a/mm/util.c b/mm/util.c
index df37c47d9374..e70e8e439258 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -484,7 +484,9 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	clear_bit(MMF_TOPDOWN, &mm->flags);
 }
 #endif
+#ifdef CONFIG_MMU
 EXPORT_SYMBOL_IF_KUNIT(arch_pick_mmap_layout);
+#endif
 
 /**
  * __account_locked_vm - account locked pages to an mm's locked_vm
-- 
2.34.1


