Return-Path: <linux-kselftest+bounces-12084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E172A90B85A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 19:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922381F222A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F3F1891B9;
	Mon, 17 Jun 2024 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGpG03KP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8AB1891A5;
	Mon, 17 Jun 2024 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646079; cv=none; b=ALEZmkXzxNnkdYVBO4XfGwPTGgLLFmXCw/9vK+PbtE1A2BFOBTDPcKCh2+MNBpgnGj0v+q1ceYxffW2Bm3jBagKwn+Ay/3+JqMh9VigXR86FOMFOE3PxG8na/wXIY0XQywQ6gJtv+FDBFp+FM+UgrNJLRWNbsCJNNKHWTbEqQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646079; c=relaxed/simple;
	bh=SyTGqPdHpuy3gJMpwFjM312Sys8XLnxtGOp+tF8HIfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kEuvdhLAsLyAzaZ7xadAFPSLMQ/dztKWRTu7iZySgJIvaCo/BXaajwPWRBcYiA0LFge70JeQvlEviOtn+Z+j6DtMQjBzyQTyZWccNfah/NDElXR2jDFzTqhxT9GM4a2g1s0wRpMlQoJukhWsOrcwcQVm3KjsZH/DIkvD04Gr60Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGpG03KP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CD1C2BD10;
	Mon, 17 Jun 2024 17:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718646079;
	bh=SyTGqPdHpuy3gJMpwFjM312Sys8XLnxtGOp+tF8HIfM=;
	h=From:To:Cc:Subject:Date:From;
	b=uGpG03KPdReyjC1/opQWeFUmIa7rjKz4qdzL3Hsr8+an6ghDa2V8srd0gkZoUKP9R
	 +eXn5MKn0jYpfdVERyjjKRjlwi1bsgAIgxK73PHYGeg/Pp1dKh4lH2iCBuThx89NQk
	 99GdpyvBmDe9YgiA5pKjb4uH6OAigy4vZfgbP9ibxuaKDKV/0Xr9rv8xZtnoZD1ZZj
	 yzUIMi5ez50LW1KmtrQLIWoIaa+wgg/CtGw/fF17npZJaWn/hBzXDyA1HnSlmwwoew
	 794/yiqgBtyjM/dOxETPIz99qXy/lESnTAbZoMVpaximCgFT4CW6VS53ZRbPAy77qk
	 /hKIqpqIHV1mQ==
From: Kees Cook <kees@kernel.org>
To: Brendan Higgins <brendan.higgins@linux.dev>
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kunit/usercopy: Disable testing on !CONFIG_MMU
Date: Mon, 17 Jun 2024 10:41:15 -0700
Message-Id: <20240617174111.work.408-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; i=kees@kernel.org; h=from:subject:message-id; bh=SyTGqPdHpuy3gJMpwFjM312Sys8XLnxtGOp+tF8HIfM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmcHU71lN3gU2U5/SabG8LFXiX7hR8Kwm6xAE7y fRNHDG70PKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnB1OwAKCRCJcvTf3G3A JiWJEACZ5pYWV/fr4xGq+aSoVJGknbuIT4sUIOHFs6bjERXU4LaLDpqPiQ7EXSIbt5ikxK9TD2a PnkHJEECwZSrQr9XZWnMETsHm82Pzy8lgYW0PQZDSg1vyiLJejZAdFNMBfE9y1b0Y/I2zzXhEEm 3umRoPCnNWVER7j/NZ+SDnYETclRNJP5DayslHfYmdd+7ixn0vrjVYWf72kaoJitTor+DKk74In D6+QAfroH2RvrvTAMrG7dgtTGnWahj+xQpqBlZH38pLtPOe1QjA2VrtNAa/RffIHS+vT5IxqqHU 6Fn1Uzlry7ZUxNPK1FySQxTbsBKC4PRLLwP3i1A/Rw4VPwdZWAdqj543xIFivMOIuGX6EpmtUiY al7xYvYqBbriDWeIm+kaNvXJOXri7Qor/jXcGG0XAT3VsDQdZnrYL1PD91OrsUheWQ6oW+TeHrS fotG8J2+PleZj7iGZYXJHqHwpPVTQ9mRckQA5zFJNguxx3GaoVmA+KBFEnhJP9XK7sn/d9MqX0x Y31O1zS7LDzDYlxjxQl6PgoYiAk3NwcEJFd2+LBwV9opREay5cOy2tn1rx17s2RER74jRdJ99ig qF1yxmGx8AVF0zph9SVyTY199DWOaVWlJkPJOi2yMfFCqIrcOzIKo7hQ0C3u8ttQ/1tfmf1Y20c /HOkTB5O3lzQu
 eQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Since arch_pick_mmap_layout() is an inline for non-MMU systems, disable
this test there.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406160505.uBge6TMY-lkp@intel.com/
Signed-off-by: Kees Cook <kees@kernel.org>
---
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


