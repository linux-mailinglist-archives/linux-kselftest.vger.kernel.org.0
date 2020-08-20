Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E8B24C78A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Aug 2020 00:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHTWGD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Aug 2020 18:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgHTWGC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Aug 2020 18:06:02 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBEFC061385;
        Thu, 20 Aug 2020 15:06:01 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p18so2975723ilm.7;
        Thu, 20 Aug 2020 15:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ImZDF05n05n/CkmaZKAhMdW71wiSD26NsvWqe+Zqg4g=;
        b=JnvK7sHT6F/CmrDC+vS+458nEjhjpj/PR0QXvOeH9/jsshse9i3sVAODwmwfzz6n0Y
         c56Mm+PuFwsTibWEaqDx35yNmEEhh/GgQhF7JVPMxnQgOeEZmyLC8lGmhbLG3GkEa6TD
         iyfoiYojJ0AfNxIfntEnV0KU+jtY/s6OsN4URbm2jLf4O0LJzQGc/j62+tU5skqC7rZv
         FD8o0EVxwahI5HfllDJ4fXaTTLm5QgN1A3hsLy9L4Rm/DC5tsXzSaDFwJr/jx1/n42Rt
         drGeaMT0LomIupSLngAsXAj6rH0F0Pd5MiyL/hCmgaDSrSc7lVylL6tANc5WiMc36QAf
         vViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ImZDF05n05n/CkmaZKAhMdW71wiSD26NsvWqe+Zqg4g=;
        b=YEhgpV9k/3iimNJyo0ZKzw8eCePu/R5qk8eimuxm9rC7I8cfLGMayUX2DfKYJPfzCz
         9Go7ZL49UOYKiID5di1tDAmU9RT7lU00eCVo8/9ogwikOYvP1yLV6DxvBOXKKMuu/rSA
         qJukCyWNtvGOFF9M6Mp5VP6GPBGSNloT3i7ZgPRk2roqNLUi0nBPmMprc860CfQXI9qo
         8A+MwArWcQvjzd8PCVxd7r4qm39FMjql+7kxqr90kNSPy6FBRD7sTnji1TNO7iYPAIqq
         JMreqkq1mg2cTbtY23PcpCqLcXJipwphLxCZTQ1B5NR8WmtLBvgsY2qSJomlOQ1evbn5
         BcYw==
X-Gm-Message-State: AOAM531dYo8xnaqinEnJf/bLreuHz9mzvgSH1V/qftKQJR+RnmFKBFvW
        Tpl4o6gznl4hZApuXU0s+Tk=
X-Google-Smtp-Source: ABdhPJzbBAcSVBX+eQeZrSaXJ/fePxRGSv5oRrJzb6/L7T/wyBK+lc8uB/deuNFKd/XMEbBAEmvelQ==
X-Received: by 2002:a92:5a05:: with SMTP id o5mr136847ilb.58.1597961160968;
        Thu, 20 Aug 2020 15:06:00 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id u124sm2162827iod.20.2020.08.20.15.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:06:00 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com
Cc:     urielguajardo@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Uriel Guajardo <urielguajardojr@gmail.com>
Subject: [PATCH 1/2] kunit: expect failures from dynamic analysis tools
Date:   Thu, 20 Aug 2020 22:05:51 +0000
Message-Id: <20200820220552.3427995-1-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds support to KUnit for failure expectation for specific tools. Uses
named KUnit resources to keep track of whether or not a failure expectation has
been set by the user.

- Adds a generic KUNIT_EXPECT_TOOL_FAIL macro that can expect failure from any
supported tool that uses the same identifying name

- Adds kunit_fail_from_tool which is used to flag failures for specific
tools.

Requires "kunit: suppport failure from dynamic analysis tools":
https://lore.kernel.org/linux-kselftest/20200813205722.1384108-1-urielguajardojr@gmail.com/

Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
---
 include/kunit/test-bug.h | 53 ++++++++++++++++++++++++++++++++++++++++
 include/kunit/test.h     |  5 ++++
 lib/kunit/test.c         | 46 +++++++++++++++++++++++++++++-----
 3 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
index 283c19ec328f..383198f70cb5 100644
--- a/include/kunit/test-bug.h
+++ b/include/kunit/test-bug.h
@@ -9,16 +9,69 @@
 #ifndef _KUNIT_TEST_BUG_H
 #define _KUNIT_TEST_BUG_H
 
+/**
+ * struct kunit_expectation - represents expectations in KUnit, specifically
+ * used to keep track of failure expectations from analysis tools
+ */
+struct kunit_expectation {
+	bool expected;
+	bool found;
+};
+
 #if IS_ENABLED(CONFIG_KUNIT)
 
 extern void kunit_fail_current_test(void);
 
+/**
+ * kunit_fail_from_tool() - Fails the currently running KUnit tests under the
+ * given tool name.
+ *
+ * Note: Uses a named KUnit resource to track state. Do not use the name
+ * KUNIT_TOOL_{tool} for KUnit resources outside of here.
+ */
+#define kunit_fail_from_tool(tool)			\
+	if (current->kunit_test)			\
+		kunit_tool_fail(current->kunit_test, #tool,\
+				"KUNIT_TOOL_" #tool)
+
+/**
+ * kunit_tool_expectation() - Returns the kunit_expectation for the given
+ * tool. If it cannot find the expectation, it creates an expectation and
+ * returns it.
+ *
+ * Note: Uses a named KUnit resource to track state. Do not use the name
+ * KUNIT_TOOL_{tool} for KUnit resources outside of here.
+ */
+#define kunit_tool_expectation(test, tool)			\
+	kunit_find_expectation(test, "KUNIT_TOOL_" #tool)
+
+
+/**
+ * KUNIT_EXPECT_TOOL_FAIL() - Fails the currently running KUnit test if the
+ * condition does not cause an error within the given tool.
+ *
+ * Note: 'tool' must be consistent with the name specified in
+ * kunit_fail_from_tool(). If the tool fails KUnit using another name, KUnit
+ * will treat it as a separate tool.
+ */
+#define KUNIT_EXPECT_TOOL_FAIL(test, condition, tool) do {		\
+	struct kunit_expectation *data = kunit_tool_expectation(test, tool);\
+	data->expected = true;						\
+	data->found = false;						\
+	condition;							\
+	KUNIT_EXPECT_EQ(test, data->expected, data->found);		\
+	data->expected = false;						\
+	data->found = false;						\
+} while (0)
+
 #else
 
 static inline void kunit_fail_current_test(void)
 {
 }
 
+#define kunit_fail_from_tool(tool) do { } while (0)
+
 #endif
 
 #endif /* _KUNIT_TEST_BUG_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 81bf43a1abda..3da8e17ee32b 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -511,6 +511,11 @@ static inline int kunit_destroy_named_resource(struct kunit *test,
  */
 void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
 
+void kunit_tool_fail(struct kunit *test, char *tool_name, char *resource_name);
+
+struct kunit_expectation *kunit_find_expectation(struct kunit *test,
+						 char *resource_name);
+
 /**
  * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
  * @test: The test context object.
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index d8189d827368..458d1ad2daf2 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -22,6 +22,45 @@ void kunit_fail_current_test(void)
 		kunit_set_failure(current->kunit_test);
 }
 
+static void kunit_data_free(struct kunit_resource *res)
+{
+	kfree(res->data);
+}
+
+struct kunit_expectation *kunit_find_expectation(struct kunit *test,
+						 char *resource_name)
+{
+	struct kunit_resource *resource;
+	struct kunit_expectation *expectation;
+
+	struct kunit_resource *existing = kunit_find_named_resource(
+			test, resource_name);
+	if (!existing) {
+		expectation = kzalloc(sizeof(*expectation), GFP_KERNEL);
+		resource = kunit_alloc_and_get_resource(test, NULL,
+					kunit_data_free, GFP_KERNEL,
+					expectation);
+		resource->name = resource_name;
+		kunit_put_resource(resource);
+		return expectation;
+	}
+	kunit_put_resource(existing);
+	return existing->data;
+}
+EXPORT_SYMBOL_GPL(kunit_find_expectation);
+
+void kunit_tool_fail(struct kunit *test, char *tool_name, char *resource_name)
+{
+	struct kunit_expectation *data = kunit_find_expectation(test,
+								resource_name);
+	if (!data->expected) {
+		kunit_warn(test, "Dynamic analysis tool failure from %s",
+			   tool_name);
+		return kunit_fail_current_test();
+	}
+	data->found = true;
+}
+
 static void kunit_print_tap_version(void)
 {
 	static bool kunit_has_printed_tap_version;
@@ -538,11 +577,6 @@ static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
 	return 0;
 }
 
-static void kunit_kmalloc_free(struct kunit_resource *res)
-{
-	kfree(res->data);
-}
-
 void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
 {
 	struct kunit_kmalloc_params params = {
@@ -552,7 +586,7 @@ void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
 
 	return kunit_alloc_resource(test,
 				    kunit_kmalloc_init,
-				    kunit_kmalloc_free,
+				    kunit_data_free,
 				    gfp,
 				    &params);
 }
-- 
2.28.0.297.g1956fa8f8d-goog

