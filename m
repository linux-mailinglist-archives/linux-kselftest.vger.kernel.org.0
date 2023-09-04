Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3517917EB
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 15:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbjIDNWL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 09:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbjIDNWK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 09:22:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706F9CD1
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Sep 2023 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ZwLfUM/cdMYzDf00Kwl/BwjmCoVZQCyb2gPuJnz8cPg=;
        t=1693833723; x=1695043323; b=Njzmdk0yvPIlbzqYHdJCxunv2byqo4Bls8QacSONcxO2PtE
        Jr1U7IVLWELlt3VCtZpXvgp3OXRvu+nxWFr71getH9HgetZQA7lUZrVWnXzEqPiZJNnSKKvrGdNdt
        QYSoF3bDm/cfdmLBfoTeh6eQiQYhJGuAEDsLXcGVdNRtSAJgf+dInHOuftQrJD2RWQtFyPXdlWbwl
        CUIo7E0nSgamjdPNp+6xE8I2e/w5ImE3n1VfrenX2vfMUvAMq79hIy+hTRzNbVTv/UNXk5wjPE4us
        3/Rz3SKbkNZOoCzNkWV6EdaDkZtUCn0H+OynYbFULuY3YyKuvPSum1EWWCe2t0oA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1qd9Wi-00D8YX-1m;
        Mon, 04 Sep 2023 15:22:00 +0200
From:   benjamin@sipsolutions.net
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/2] kunit: add a convenience allocation wrapper for SKBs
Date:   Mon,  4 Sep 2023 15:21:39 +0200
Message-ID: <20230904132139.103140-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904132139.103140-1-benjamin@sipsolutions.net>
References: <20230904132139.103140-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

Add a simple convenience helper to allocate and zero fill an SKB for the
use by a kunit test. Also provide a way to free it again in case that
may be desirable.

This simply mirrors the kunit_kmalloc API.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 include/kunit/skbuff.h | 51 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 include/kunit/skbuff.h

diff --git a/include/kunit/skbuff.h b/include/kunit/skbuff.h
new file mode 100644
index 000000000000..947fc8b5b48f
--- /dev/null
+++ b/include/kunit/skbuff.h
@@ -0,0 +1,51 @@
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
+	if (kunit_add_action_or_reset(test, (kunit_action_t *)kfree_skb, res))
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
+	kunit_release_action(test, (kunit_action_t *)kfree_skb, (void *)skb);
+}
+
+#endif /* _KUNIT_SKBUFF_H */
-- 
2.41.0

