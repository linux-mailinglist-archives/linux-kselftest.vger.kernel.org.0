Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEC86CF0F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 19:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjC2RXa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 13:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjC2RX3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 13:23:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8D53C05
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8SRscMN5b9HTgCA/7xjbHkj7Ve/A0/I00v8SnxaFrfs=;
        t=1680110607; x=1681320207; b=vdR4QNrXfElKgCRhyi92tiGObndNpZfg0QhFyoytyF/IonH
        K+L0fFs/rYNFaCvl1TmPOCc1pShAHPYWWgP1oU2ezQCHJ+QRWAgfkVe24eyNVBMPY8+nGojhD1Vli
        0VOPGB+n5Hz1eeZj5FY3FdTKDbUfpx7dvRWBUbMY0w/WzhBnccgGjWT6SKnV/enKQMzEgfXT+z7Vj
        G21+XPE8wNZ0sqSLNsEfnPTOj0lUxNIIQmAmNcMGY5r+FKXOH3PDKimF6dh2i1TJzbtfedyOYA6xE
        h8E5HDeTewJ0VvNOxuZ1TTTeezP4l1S2AM+BDzSyjACqVeI9dq8IfAKSwixBzDhQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1phZW8-000AZQ-1g;
        Wed, 29 Mar 2023 19:23:24 +0200
From:   benjamin@sipsolutions.net
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/3] kunit: add ability to register a simple cleanup function
Date:   Wed, 29 Mar 2023 19:23:10 +0200
Message-Id: <20230329172311.71861-2-benjamin@sipsolutions.net>
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

This is useful to e.g. automatically free resources at the end of the
test, without having to deal with kunit resource objects directly.

The whole point of doing this is that the callback is guaranteed to
happen in case the test aborts (due to an assertion). As such, use
assertions internally rather than requiring further error checking by
the API user.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 include/kunit/test.h | 20 ++++++++++++++++++++
 lib/kunit/test.c     | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 519b90261c72..ab1dacf1c9f4 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -373,6 +373,26 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
 	return kunit_kmalloc_array(test, n, size, gfp | __GFP_ZERO);
 }
 
+typedef void (*kunit_cleanup_t)(const void *);
+
+/**
+ * kunit_add_cleanup() - Add post-test cleanup action.
+ * @test: The test case to which the resource belongs.
+ * @cleanup_func: function to call at end of test.
+ * @data: data to pass to @free_func.
+ * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
+ *
+ * This adds a cleanup action to be executed after the test completes.
+ * Internally this is handled using a *test managed resource*.
+ *
+ * This function will abort the test on failure.
+ *
+ * Note: KUnit needs to allocate memory for a kunit_resource object. You must
+ * specify an @internal_gfp that is compatible with the current context.
+ */
+void kunit_add_cleanup(struct kunit *test, kunit_cleanup_t cleanup_func,
+		       const void *data, gfp_t internal_gfp);
+
 void kunit_cleanup(struct kunit *test);
 
 void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c9e15bb60058..72d956dfc324 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -719,6 +719,43 @@ void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(kunit_kmalloc_array);
 
+struct kunit_auto_cleanup {
+	struct kunit_resource resource;
+	kunit_cleanup_t cleanup_func;
+};
+
+static void kunit_auto_cleanup_free(struct kunit_resource *res)
+{
+	struct kunit_auto_cleanup *cleanup;
+
+	cleanup = container_of(res, struct kunit_auto_cleanup, resource);
+
+	cleanup->cleanup_func(cleanup->resource.data);
+}
+
+void kunit_add_cleanup(struct kunit *test, kunit_cleanup_t cleanup_func,
+		       const void *data, gfp_t internal_gfp)
+{
+	struct kunit_auto_cleanup *res;
+
+	KUNIT_ASSERT_NOT_NULL_MSG(test, cleanup_func,
+				  "Cleanup function must not be NULL");
+
+	res = kzalloc(sizeof(*res), internal_gfp);
+	if (!res) {
+		cleanup_func(data);
+		KUNIT_ASSERT_FAILURE(test, "Could not allocate resource for cleanup");
+	}
+
+	res->cleanup_func = cleanup_func;
+	res->resource.should_kfree = true;
+
+	/* Cannot fail as init is NULL */
+	__kunit_add_resource(test, NULL, kunit_auto_cleanup_free,
+			     &res->resource, (void *)data);
+}
+EXPORT_SYMBOL_GPL(kunit_add_cleanup);
+
 static inline bool kunit_kfree_match(struct kunit *test,
 				     struct kunit_resource *res, void *match_data)
 {
-- 
2.39.2

