Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E686CF0F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 19:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjC2RXa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 13:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjC2RX2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 13:23:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78AB10D3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fWWMWsWDiMkkqHyM1AnILBzBWIyFWrb7Hh7aBaAQW40=;
        t=1680110607; x=1681320207; b=auuBdJjWuTJ06rGBBX7bWLF7ZnS1ZCi6sRd8RYiMTMd7j2Z
        I+6mviCluz1OKdwcKhTsa0dt6JiGJbAuZgkNQOQ72YsQAqbQ8fbKf8rNTX5KoABb03HJLoNVmAhAW
        APc3EN9I+ReIskAuBn4YMRqhl64nrd4sKrSYDgiDWFQS6L1NkCEwgg81KUU9EvKPxL7CcOYrCN2uo
        GIuqnyWrdojn02gMQ51VF2DCvugsCFFxqa0fRinRCPjQKWo9mUKoolD55v55UEt0CrO1prcKnUH6P
        5eNsIFiUJHBcybqUMwnGENX5P6LxVRB3z+uumEhnzs4/Bj+6qQ794q73m3K61ZOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1phZW8-000AZQ-2S;
        Wed, 29 Mar 2023 19:23:24 +0200
From:   benjamin@sipsolutions.net
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 3/3] kunit: add a convenience allocation wrapper for SKBs
Date:   Wed, 29 Mar 2023 19:23:11 +0200
Message-Id: <20230329172311.71861-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329172311.71861-1-benjamin@sipsolutions.net>
References: <20230329172311.71861-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

This simplifies the use of SKBs in tests by avoiding the need for
error checking.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 include/kunit/skbuff.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 include/kunit/skbuff.h

diff --git a/include/kunit/skbuff.h b/include/kunit/skbuff.h
new file mode 100644
index 000000000000..46dcb00af655
--- /dev/null
+++ b/include/kunit/skbuff.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit struct sk_buff helpers.
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+
+#ifndef _KUNIT_SKBUFF_H
+#define _KUNIT_SKBUFF_H
+
+#include <kunit/test.h>
+#include <linux/skbuff.h>
+
+/**
+ * kunit_zalloc_skb() - Allocate and initialize a resource managed skb.
+ * @test: The test case to which the skb belongs
+ * @len: size to allocate
+ * @gfp: allocation mask
+ *
+ * Allocate a new struct sk_buff, zero fill the give length and add it as a
+ * resource to the kunit test for automatic cleanup.
+ *
+ * The function will not return in case of an allocation error.
+ */
+static inline struct sk_buff *kunit_zalloc_skb(struct kunit *test, int len,
+					       gfp_t gfp)
+{
+	struct sk_buff *res = alloc_skb(len, gfp);
+
+	KUNIT_ASSERT_NOT_NULL(test, res);
+	KUNIT_ASSERT_EQ(test, skb_pad(res, len), 0);
+
+	kunit_add_cleanup(test, (kunit_cleanup_t) kfree_skb, res, gfp);
+
+	return res;
+}
+
+#endif /* _KUNIT_SKBUFF_H */
-- 
2.39.2

