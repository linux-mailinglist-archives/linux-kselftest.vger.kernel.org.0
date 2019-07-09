Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFEDE630E5
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2019 08:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfGIGe7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Jul 2019 02:34:59 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:38837 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfGIGe6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Jul 2019 02:34:58 -0400
Received: by mail-pf1-f201.google.com with SMTP id e25so11850351pfn.5
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Jul 2019 23:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5ITzFQ13C29abIT2H8JegwiISTqveD/hhAgmQXoh5oA=;
        b=pfhT47mdB+msD37OpeHSDm7NOliPLh60JcqomRSJpHu3vlxh+a2R4aQ9xfHIkf5j0X
         KnhNJ1NYiYDjTECuFOjHTMzkV8BfGVchCnDNBX+wIKXLdFDNaRNL+N81xmTMZNk5kx7/
         4OwgBFFNnhOjh5Lsf4WAhtI5khqpmIyGjW/vDjVq+LUKCwkl5YjWwRhWFt3BFlCyJF6G
         F/Z3wifqM0+QkSNQvmfD5Pwju19/ZJV5tyUUTtDei4J5z1GKVKUshxiq9uyZd3aJ2LQT
         v+Y4jljsq/Z7hJl9yyOENyN/mYzPOL/GVm/M4Ht2Twmlmgajb+9Ekmwpc0o8kgXeSn5S
         CGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5ITzFQ13C29abIT2H8JegwiISTqveD/hhAgmQXoh5oA=;
        b=OgVjMVCECHHFIJOkv0sk49p6voZcDMIZqKUM9ZxOhPX+msX5/EXNj8gk92S3KtXMKD
         UTcNUharAgU8bfsBCucQqHhnO5jeBzpaVAjN/juQBtgBo/OYyo4ER9jAxDwnat71c57s
         WLzeUEJLl7PHUyTFqvw+GoMPw/s6BU9iWyOnBi5yW4RI8hR9AnbuLgqPJztwBhdWxSEC
         Gm1Y4ScHKM5YVHTmHh3i3jjW+JX0r9ELK8bFNNnHjrvi9Q1GWgw188KPefa7cradEOrQ
         9LybEwTTbkkrimjEGEyt0XBnCTFjV+YEuysyYhOf2Yong2+uIigE32qjqdIy69mQnPVb
         5oEA==
X-Gm-Message-State: APjAAAWbB96+fRGSD8WsXlN4zvPcsIYsxyRFoEY6kWFE13+xnj9sPXq5
        TFuRbADzEGvob01QpevdR8HFaxsSAd9P4+ZaWXvMGg==
X-Google-Smtp-Source: APXvYqws3DP81QwZrm/xHE+kC/orcH/6Vc/CwS4Iqd+3IWEQVLYdWqn1YPeTTENDehk2rzebH/lLUNxLZgc7x0oa2Ts3Fw==
X-Received: by 2002:a63:2326:: with SMTP id j38mr29164973pgj.134.1562654097180;
 Mon, 08 Jul 2019 23:34:57 -0700 (PDT)
Date:   Mon,  8 Jul 2019 23:30:17 -0700
In-Reply-To: <20190709063023.251446-1-brendanhiggins@google.com>
Message-Id: <20190709063023.251446-13-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v7 12/18] kunit: test: add tests for KUnit managed resources
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Avinash Kondareddy <akndr41@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Avinash Kondareddy <akndr41@gmail.com>

Add unit tests for KUnit managed resources. KUnit managed resources
(struct kunit_resource) are resources that are automatically cleaned up
at the end of a KUnit test, similar to the concept of devm_* managed
resources.

Signed-off-by: Avinash Kondareddy <akndr41@gmail.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 kunit/test-test.c | 219 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)

diff --git a/kunit/test-test.c b/kunit/test-test.c
index 058f3fb37458a..b044659fe868b 100644
--- a/kunit/test-test.c
+++ b/kunit/test-test.c
@@ -101,3 +101,222 @@ static struct kunit_suite kunit_try_catch_test_suite = {
 	.test_cases = kunit_try_catch_test_cases,
 };
 kunit_test_suite(kunit_try_catch_test_suite);
+
+/*
+ * Context for testing test managed resources
+ * is_resource_initialized is used to test arbitrary resources
+ */
+struct kunit_test_resource_context {
+	struct kunit test;
+	bool is_resource_initialized;
+	int allocate_order[2];
+	int free_order[2];
+};
+
+static int fake_resource_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	res->allocation = &ctx->is_resource_initialized;
+	ctx->is_resource_initialized = true;
+	return 0;
+}
+
+static void fake_resource_free(struct kunit_resource *res)
+{
+	bool *is_resource_initialized = res->allocation;
+
+	*is_resource_initialized = false;
+}
+
+static void kunit_resource_test_init_resources(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	kunit_init_test(&ctx->test, "testing_test_init_test");
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_alloc_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res;
+	kunit_resource_free_t free = fake_resource_free;
+
+	res = kunit_alloc_resource(&ctx->test,
+				   fake_resource_init,
+				   fake_resource_free,
+				   ctx);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
+	KUNIT_EXPECT_PTR_EQ(test,
+			    &ctx->is_resource_initialized,
+			    (bool *) res->allocation);
+	KUNIT_EXPECT_TRUE(test, list_is_last(&res->node, &ctx->test.resources));
+	KUNIT_EXPECT_PTR_EQ(test, free, res->free);
+}
+
+static void kunit_resource_test_free_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res = kunit_alloc_resource(&ctx->test,
+							  fake_resource_init,
+							  fake_resource_free,
+							  ctx);
+
+	kunit_free_resource(&ctx->test, res);
+
+	KUNIT_EXPECT_FALSE(test, ctx->is_resource_initialized);
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_cleanup_resources(struct kunit *test)
+{
+	int i;
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *resources[5];
+
+	for (i = 0; i < ARRAY_SIZE(resources); i++) {
+		resources[i] = kunit_alloc_resource(&ctx->test,
+						    fake_resource_init,
+						    fake_resource_free,
+						    ctx);
+	}
+
+	kunit_cleanup(&ctx->test);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_mark_order(int order_array[],
+					   size_t order_size,
+					   int key)
+{
+	int i;
+
+	for (i = 0; i < order_size && order_array[i]; i++)
+		;
+
+	order_array[i] = key;
+}
+
+#define KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, order_field, key)		       \
+		kunit_resource_test_mark_order(ctx->order_field,	       \
+					       ARRAY_SIZE(ctx->order_field),   \
+					       key)
+
+static int fake_resource_2_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 2);
+
+	res->allocation = ctx;
+
+	return 0;
+}
+
+static void fake_resource_2_free(struct kunit_resource *res)
+{
+	struct kunit_test_resource_context *ctx = res->allocation;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 2);
+}
+
+static int fake_resource_1_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	kunit_alloc_resource(&ctx->test,
+			     fake_resource_2_init,
+			     fake_resource_2_free,
+			     ctx);
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 1);
+
+	res->allocation = ctx;
+
+	return 0;
+}
+
+static void fake_resource_1_free(struct kunit_resource *res)
+{
+	struct kunit_test_resource_context *ctx = res->allocation;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 1);
+}
+
+/*
+ * TODO(brendanhiggins@google.com): replace the arrays that keep track of the
+ * order of allocation and freeing with strict mocks using the IN_SEQUENCE macro
+ * to assert allocation and freeing order when the feature becomes available.
+ */
+static void kunit_resource_test_proper_free_ordering(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	/* fake_resource_1 allocates a fake_resource_2 in its init. */
+	kunit_alloc_resource(&ctx->test,
+			     fake_resource_1_init,
+			     fake_resource_1_free,
+			     ctx);
+
+	/*
+	 * Since fake_resource_2_init calls KUNIT_RESOURCE_TEST_MARK_ORDER
+	 * before returning to fake_resource_1_init, it should be the first to
+	 * put its key in the allocate_order array.
+	 */
+	KUNIT_EXPECT_EQ(test, ctx->allocate_order[0], 2);
+	KUNIT_EXPECT_EQ(test, ctx->allocate_order[1], 1);
+
+	kunit_cleanup(&ctx->test);
+
+	/*
+	 * Because fake_resource_2 finishes allocation before fake_resource_1,
+	 * fake_resource_1 should be freed first since it could depend on
+	 * fake_resource_2.
+	 */
+	KUNIT_EXPECT_EQ(test, ctx->free_order[0], 1);
+	KUNIT_EXPECT_EQ(test, ctx->free_order[1], 2);
+}
+
+static int kunit_resource_test_init(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx =
+			kzalloc(sizeof(*ctx), GFP_KERNEL);
+
+	if (!ctx)
+		return -ENOMEM;
+
+	test->priv = ctx;
+
+	kunit_init_test(&ctx->test, "test_test_context");
+
+	return 0;
+}
+
+static void kunit_resource_test_exit(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	kunit_cleanup(&ctx->test);
+	kfree(ctx);
+}
+
+static struct kunit_case kunit_resource_test_cases[] = {
+	KUNIT_CASE(kunit_resource_test_init_resources),
+	KUNIT_CASE(kunit_resource_test_alloc_resource),
+	KUNIT_CASE(kunit_resource_test_free_resource),
+	KUNIT_CASE(kunit_resource_test_cleanup_resources),
+	KUNIT_CASE(kunit_resource_test_proper_free_ordering),
+	{}
+};
+
+static struct kunit_suite kunit_resource_test_suite = {
+	.name = "kunit-resource-test",
+	.init = kunit_resource_test_init,
+	.exit = kunit_resource_test_exit,
+	.test_cases = kunit_resource_test_cases,
+};
+kunit_test_suite(kunit_resource_test_suite);
-- 
2.22.0.410.gd8fdbe21b5-goog

