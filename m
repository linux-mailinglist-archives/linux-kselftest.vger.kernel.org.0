Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEDF6CF0F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 19:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjC2RX3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 13:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2RX2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 13:23:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF88422C
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=qCUo0G46cYQXreTtfAzXKfSeX+oSqchDN4KPUhh50yI=; t=1680110607; x=1681320207; 
        b=seRoA4omQ/rpHaxdDJzhcVjYFPWhYkjBbFxdCpAcCQ7YJaL3hcTzOpa1iHhgZnxB+/sZkTOo0Bc
        wvJClGTb4Ayu35Id8wV7CcKmqLIgDW/tbtU1ldQO9fdPuUTKRAd4V0ZZzp4amztG2ALVpsWOPzGUB
        riir3k1RhdShYp8eEc6NyiCs7vkhSznAt12WpH7l3z6SRZeOZwUMF5SZVKzpo4OMZK71qw/wjJzFA
        9HAp9aPHCuUEQ56cSfBokiwVzFezug4ercZsmMrw0YY+nJ+MQuqb9Ke5B/fqljYq6HbKdYwbzFv8X
        1H0IJMWVuReiXn+uXxh4Q6Obc94S9KgELqBQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1phZW8-000AZQ-10;
        Wed, 29 Mar 2023 19:23:24 +0200
From:   benjamin@sipsolutions.net
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/3] kunit: add parameter generation macro using description from array
Date:   Wed, 29 Mar 2023 19:23:09 +0200
Message-Id: <20230329172311.71861-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.39.2
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

The existing KUNIT_ARRAY_PARAM macro requires a separate function to
get the description. However, in a lot of cases the description can
just be copied directly from the array. Add a second macro that
avoids having to write a static function just for a single strscpy.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 include/kunit/test.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 08d3559dd703..519b90261c72 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1414,6 +1414,25 @@ do {									       \
 		return NULL;									\
 	}
 
+/**
+ * KUNIT_ARRAY_PARAM_DESC() - Define test parameter generator from an array.
+ * @name:  prefix for the test parameter generator function.
+ * @array: array of test parameters.
+ * @desc_member: structure member from array element to use as description
+ *
+ * Define function @name_gen_params which uses @array to generate parameters.
+ */
+#define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)					\
+	static const void *name##_gen_params(const void *prev, char *desc)			\
+	{											\
+		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
+		if (__next - (array) < ARRAY_SIZE((array))) {					\
+			strscpy(desc, __next->desc_member, KUNIT_PARAM_DESC_SIZE);		\
+			return __next;								\
+		}										\
+		return NULL;									\
+	}
+
 // TODO(dlatypov@google.com): consider eventually migrating users to explicitly
 // include resource.h themselves if they need it.
 #include <kunit/resource.h>
-- 
2.39.2

