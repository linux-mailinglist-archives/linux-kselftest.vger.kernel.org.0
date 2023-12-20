Return-Path: <linux-kselftest+bounces-2264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB95C81A236
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 16:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F88F1F2514F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61BA40BEA;
	Wed, 20 Dec 2023 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eMMefgr3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE240BE4;
	Wed, 20 Dec 2023 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3dQ/koIlD9pX3qWk/1PizLnWMFvyP4MgGx4SMHiaVsI=;
	t=1703085602; x=1704295202; b=eMMefgr38W7BSQPl4Tc+BIicEzIQZtG6kvjV9rEnUcnGMRG
	KPn9UcC+2SDomdWiPUfDuUXdZwGOSiOnzfuakgzsWe/zL7zS0U5tm7oUHrWLmh9feH4+4G2usEkFi
	FuClcClKaC+TmG0Q81sw60yZ70CqepPY5w1UaqtkLTmEO/dxt47uSO0ke4V4E3y8KJpDgAI7Kgw/Z
	v25x8lEP34lJGyd9FPrz0/XXwumCOr6/Ej5ORQzJ7ROdo16o1qj4iqyRKGcQ3Ydl0LMJUE8rpb4rm
	8FwghZQPKUTceh9cFNGKsRLG+KYauUe6whyMRSgMzYqUdlOVJOLHPNpQZ5zHNQOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rFyMZ-00000001WFz-0VCN;
	Wed, 20 Dec 2023 16:19:59 +0100
From: benjamin@sipsolutions.net
To: linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/6] kunit: add a convenience allocation wrapper for SKBs
Date: Wed, 20 Dec 2023 16:19:48 +0100
Message-ID: <20231220151952.415232-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220151952.415232-1-benjamin@sipsolutions.net>
References: <20231220151952.415232-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Add a simple convenience helper to allocate and zero fill an SKB for the
use by a kunit test. Also provide a way to free it again in case that
may be desirable.

This simply mirrors the kunit_kmalloc API.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 include/kunit/skbuff.h | 56 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 include/kunit/skbuff.h

diff --git a/include/kunit/skbuff.h b/include/kunit/skbuff.h
new file mode 100644
index 000000000000..2144d01e556f
--- /dev/null
+++ b/include/kunit/skbuff.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Base unit test (KUnit) API.
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+
+#ifndef _KUNIT_SKBUFF_H
+#define _KUNIT_SKBUFF_H
+
+#include <kunit/resource.h>
+#include <linux/skbuff.h>
+
+static void kunit_action_kfree_skb(void *p)
+{
+	kfree_skb((struct sk_buff *)p);
+}
+
+/**
+ * kunit_zalloc_skb() - Allocate and initialize a resource managed skb.
+ * @test: The test case to which the skb belongs
+ * @len: size to allocate
+ *
+ * Allocate a new struct sk_buff with GFP_KERNEL, zero fill the give length
+ * and add it as a resource to the kunit test for automatic cleanup.
+ *
+ * Returns: newly allocated SKB, or %NULL on error
+ */
+static inline struct sk_buff *kunit_zalloc_skb(struct kunit *test, int len,
+					       gfp_t gfp)
+{
+	struct sk_buff *res = alloc_skb(len, GFP_KERNEL);
+
+	if (!res || skb_pad(res, len))
+		return NULL;
+
+	if (kunit_add_action_or_reset(test, kunit_action_kfree_skb, res))
+		return NULL;
+
+	return res;
+}
+
+/**
+ * kunit_kfree_skb() - Like kfree_skb except for allocations managed by KUnit.
+ * @test: The test case to which the resource belongs.
+ * @skb: The SKB to free.
+ */
+static inline void kunit_kfree_skb(struct kunit *test, struct sk_buff *skb)
+{
+	if (!skb)
+		return;
+
+	kunit_release_action(test, kunit_action_kfree_skb, (void *)skb);
+}
+
+#endif /* _KUNIT_SKBUFF_H */
-- 
2.43.0


