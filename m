Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD0D177B79
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Mar 2020 17:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgCCQDf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Mar 2020 11:03:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55682 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbgCCQDf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Mar 2020 11:03:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023FrmYQ006702;
        Tue, 3 Mar 2020 16:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=LFP+4Aobiqz2p4zZ2pIu0i8JltInMknsJpogB8OzCcE=;
 b=lCInhQKGJMROsuXk6ViFNkDAPYCD7cGuWwjyCOQW5DzQtzO/ClAfRrXTY37V1kEgk7sW
 HpA/un4QjeZ3ekA/F92tc2cROzLDFrUt+7v3q7kE+rycKmB8ocaxPoOy0IxCRe8jVkFI
 31+Vw4Z5QXtJTcR2/HOp+SW2As4eGQXozBuAwp2+7QCmvHjDjSac4rf1qfZrI5x3Ijro
 6zQZ3TPxhkYjmZAhCY1WY0Pl5D+l3/zDYEbh6nUT5OS/teB5d6uL3f7HM4Xj3jX1BMC6
 kqY8x41n4bJatAiaBYWTx2NPTzd18wGJuaU7F0XL8+LWJXN4r5yMlE8ffHvIt/LAy03N rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2yffcugb9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 16:03:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023G32P1155937;
        Tue, 3 Mar 2020 16:03:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2yg1gxqy1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 16:03:30 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 023G3UDf011129;
        Tue, 3 Mar 2020 16:03:30 GMT
Received: from dhcp-10-175-165-222.vpn.oracle.com (/10.175.165.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Mar 2020 16:03:29 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, trishalfonso@google.com,
        skhan@linuxfoundation.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC PATCH kunit-next 2/2] kunit: add support for named resources
Date:   Tue,  3 Mar 2020 16:02:41 +0000
Message-Id: <1583251361-12748-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583251361-12748-1-git-send-email-alan.maguire@oracle.com>
References: <1583251361-12748-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=13 malwarescore=0 mlxlogscore=535 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=13 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=591 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030113
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kunit resources API allows for custom initialization and
cleanup code (init/fini); here we use the init code to set the
new "struct kunit_resource" "name" field, and call an additional
init function if needed.  Having a simple way to name resources
is useful in cases such as multithreaded tests where a set of
resources are shared among threads; a pointer to the
"struct kunit *" test state then is all that is needed to
retrieve and use named resources.  Support is provided to add,
find and destroy named resources; the latter two are simply
wrappers that use a "match-by-name" callback.

If an attempt to add a resource with a name that already exists
is made kunit_add_named_resource() will return NULL.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/kunit/test.h   | 40 ++++++++++++++++++++++++++++++++++++++-
 lib/kunit/kunit-test.c | 37 ++++++++++++++++++++++++++++++++++++
 lib/kunit/test.c       | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 11c80f5..70ee581 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -73,9 +73,14 @@
  *			kunit_kmalloc_free, &params);
  *	}
  *
+ * Resources can also be named, with lookup/removal done on a name
+ * basis also.  kunit_add_named_resource(), kunit_find_named_resource()
+ * and kunit_destroy_named_resource() below.  Resource names must be
+ * unique within the test instance.
  */
 struct kunit_resource {
 	void *data;
+	const char *name;	/* optional name */
 	kunit_resource_init_t init;
 	kunit_resource_free_t free;
 
@@ -275,12 +280,27 @@ struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
  * @init: a user-supplied function to initialize the result (if needed).  If
  *        none is supplied, the resource data value is simply set to @data.
  *	  If an init function is supplied, @data is passed to it instead.
- * @free: a user-supplied function to free the resource (if needed).
+ * @free: a user-supplied function to free the resource data (if needed).
  * @data: value to pass to init function or set in resource data field.
  */
 int kunit_add_resource(struct kunit *test, kunit_resource_init_t init,
 		       kunit_resource_free_t free, struct kunit_resource *res,
 		       void *data);
+
+/**
+ * kunit_add_named_resource() - Add a named *test managed resource*.
+ * @test: The test context object.
+ * @init: a user-supplied function to initialize the resource data, if needed.
+ * @free: a user-supplied function to free the resource data, if needed.
+ * @name_data: name and data to be set for resource.
+ */
+int kunit_add_named_resource(struct kunit *test,
+			     kunit_resource_init_t init,
+			     kunit_resource_free_t free,
+			     struct kunit_resource *res,
+			     const char *name,
+			     void *data);
+
 /**
  * kunit_alloc_resource() - Allocates a *test managed resource*.
  * @test: The test context object.
@@ -336,6 +356,19 @@ static inline bool kunit_resource_instance_match(struct kunit *test,
 }
 
 /**
+ * kunit_resource_name_match() - Match a resource with the same name.
+ * @test: Test case to which the resource belongs.
+ * @res: The resource.
+ * @match_name: The name to match against.
+ */
+static inline bool kunit_resource_name_match(struct kunit *test,
+					     struct kunit_resource *res,
+					     void *match_name)
+{
+	return res->name && strcmp(res->name, match_name) == 0;
+}
+
+/**
  * kunit_find_resource() - Find a resource using match function/data.
  * @test: Test case to which the resource belongs.
  * @match: match function to be applied to resources/match data.
@@ -345,6 +378,9 @@ struct kunit_resource *kunit_find_resource(struct kunit *test,
 					   kunit_resource_match_t match,
 					   void *match_data);
 
+#define kunit_find_named_resource(test, name)			\
+	kunit_find_resource(test, kunit_resource_name_match, (void *)name)
+
 /**
  * kunit_destroy_resource() - Find a kunit_resource and destroy it.
  * @test: Test case to which the resource belongs.
@@ -358,6 +394,8 @@ int kunit_destroy_resource(struct kunit *test,
 			   kunit_resource_match_t match,
 			   void *match_data);
 
+#define kunit_destroy_named_resource(test, name)		\
+	kunit_destroy_resource(test, kunit_resource_name_match, name)
 
 /**
  * kunit_remove_resource: remove resource from resource list associated with
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index b8bf36d..079c558 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -317,6 +317,42 @@ static void kunit_resource_test_static(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty(&test->resources));
 }
 
+static void kunit_resource_test_named(struct kunit *test)
+{
+	struct kunit_resource res1, res2, *found = NULL;
+	struct kunit_test_resource_context ctx;
+
+	KUNIT_EXPECT_EQ(test,
+			kunit_add_named_resource(test, NULL, NULL, &res1,
+						 "resource_1", &ctx),
+			0);
+	KUNIT_EXPECT_PTR_EQ(test, res1.data, (void *)&ctx);
+
+	KUNIT_EXPECT_EQ(test,
+			kunit_add_named_resource(test, NULL, NULL, &res1,
+						 "resource_1", &ctx),
+			-EEXIST);
+
+	KUNIT_EXPECT_EQ(test,
+			kunit_add_named_resource(test, NULL, NULL, &res2,
+						 "resource_2", &ctx),
+			0);
+
+	found = kunit_find_named_resource(test, "resource_1");
+
+	KUNIT_EXPECT_PTR_EQ(test, found, &res1);
+
+	if (found)
+		kunit_put_resource(&res1);
+
+	KUNIT_EXPECT_EQ(test, kunit_destroy_named_resource(test, "resource_2"),
+			0);
+
+	kunit_cleanup(test);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&test->resources));
+}
+
 static int kunit_resource_test_init(struct kunit *test)
 {
 	struct kunit_test_resource_context *ctx =
@@ -346,6 +382,7 @@ static void kunit_resource_test_exit(struct kunit *test)
 	KUNIT_CASE(kunit_resource_test_cleanup_resources),
 	KUNIT_CASE(kunit_resource_test_proper_free_ordering),
 	KUNIT_CASE(kunit_resource_test_static),
+	KUNIT_CASE(kunit_resource_test_named),
 	{}
 };
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 132e9bf..86a4d9c 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -380,6 +380,57 @@ int kunit_add_resource(struct kunit *test, kunit_resource_init_t init,
 }
 EXPORT_SYMBOL_GPL(kunit_add_resource);
 
+/* Used to initialize named resource. */
+struct kunit_name_data {
+	const char *name;
+	kunit_resource_init_t init;
+	void *data;
+};
+
+static int kunit_init_named_resource(struct kunit_resource *res, void *data)
+{
+	struct kunit_name_data *name_data = data;
+
+	res->name = name_data->name;
+	res->data = name_data->data;
+	res->init = name_data->init;
+
+	if (res->init)
+		return res->init(res, name_data->data);
+
+	res->data = name_data->data;
+
+	return 0;
+}
+
+int kunit_add_named_resource(struct kunit *test,
+			     kunit_resource_init_t init,
+			     kunit_resource_free_t free,
+			     struct kunit_resource *res,
+			     const char *name,
+			     void *data)
+{
+	struct kunit_name_data name_data;
+	struct kunit_resource *existing;
+
+	if (!name)
+		return -EINVAL;
+
+	existing = kunit_find_named_resource(test, name);
+	if (existing) {
+		kunit_put_resource(existing);
+		return -EEXIST;
+	}
+
+	name_data.name = name;
+	name_data.init = init;
+	name_data.data = data;
+
+	return kunit_add_resource(test, kunit_init_named_resource, free, res,
+				  &name_data);
+}
+EXPORT_SYMBOL_GPL(kunit_add_named_resource);
+
 struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
 						    kunit_resource_init_t init,
 						    kunit_resource_free_t free,
-- 
1.8.3.1

