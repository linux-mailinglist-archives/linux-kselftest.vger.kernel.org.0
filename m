Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8C9195773
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Mar 2020 13:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0MqL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Mar 2020 08:46:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37376 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0MqL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Mar 2020 08:46:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02RCi3lx171583;
        Fri, 27 Mar 2020 12:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=EtuvsdSirFos4AqZLPMsv7ugIs0vPYtQQbK4VHPa1fo=;
 b=lc2tTlpVWUDp22Bo8kC6j4pH7zqy1W31DRJRxlEmaTT2CsWd9C5j8bOR6NqkjxA/Ka6j
 AyzeQPh1NQVLgGnUx/cRh+dR0+37pkEuuNiWOFmh7bS3k2l4RBXgx6B5LoAtfQ0RYtS6
 evvqW+nLMmSuCltRAPw81kxYUvrBcQIasNOVw/exX7Ecu0IsQKaHd6ToMhJc32HhoKsQ
 OqefUey1S5QncAXyanHuztZiALmHnkkGKs9/DRxawkhWmmcdWUDZjhrUQLSCl1Qk+2Zr
 2Of8S5frVBH4KkU2YHkCGq1J45ulx7jVvoVlGbDwhyoDHUrd4drmrDDBC0MypiRhubl/ Nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 301459aw7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 12:46:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02RCgaVI071607;
        Fri, 27 Mar 2020 12:46:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2yxw4vsffw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 12:46:06 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02RCk5e5005499;
        Fri, 27 Mar 2020 12:46:05 GMT
Received: from localhost.uk.oracle.com (/10.175.186.71)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Mar 2020 05:46:01 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, shuah@kernel.org,
        trishalfonso@google.com, linux-kselftest@vger.kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 kunit-next 2/2] kunit: add support for named resources
Date:   Fri, 27 Mar 2020 12:45:22 +0000
Message-Id: <1585313122-26441-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585313122-26441-1-git-send-email-alan.maguire@oracle.com>
References: <1585313122-26441-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=2
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 suspectscore=2 impostorscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270117
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kunit resources API allows for custom initialization and
cleanup code (init/fini); here a new resource add function sets
the "struct kunit_resource" "name" field, and calls the standard
add function.  Having a simple way to name resources is
useful in cases such as multithreaded tests where a set of
resources are shared among threads; a pointer to the
"struct kunit *" test state then is all that is needed to
retrieve and use named resources.  Support is provided to add,
find and destroy named resources; the latter two are simply
wrappers that use a "match-by-name" callback.

If an attempt to add a resource with a name that already exists
is made kunit_add_named_resource() will return -EEXIST.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/kunit/test.h   | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/kunit-test.c | 37 ++++++++++++++++++++++++++++++++++
 lib/kunit/test.c       | 24 ++++++++++++++++++++++
 3 files changed, 115 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8c7f3ff..ac59d18 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -72,9 +72,15 @@
  *		return kunit_alloc_resource(test, kunit_kmalloc_init,
  *			kunit_kmalloc_free, &params);
  *	}
+ *
+ * Resources can also be named, with lookup/removal done on a name
+ * basis also.  kunit_add_named_resource(), kunit_find_named_resource()
+ * and kunit_destroy_named_resource().  Resource names must be
+ * unique within the test instance.
  */
 struct kunit_resource {
 	void *data;
+	const char *name;		/* optional name */
 
 	/* private: internal use only. */
 	kunit_resource_init_t init;
@@ -345,6 +351,21 @@ int kunit_add_resource(struct kunit *test,
 		       kunit_resource_free_t free,
 		       struct kunit_resource *res,
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
@@ -400,6 +421,19 @@ static inline bool kunit_resource_instance_match(struct kunit *test,
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
@@ -428,6 +462,19 @@ static inline bool kunit_resource_instance_match(struct kunit *test,
 }
 
 /**
+ * kunit_find_named_resource() - Find a resource using match name.
+ * @test: Test case to which the resource belongs.
+ * @name: match name.
+ */
+static inline struct kunit_resource *
+kunit_find_named_resource(struct kunit *test,
+			  const char *name)
+{
+	return kunit_find_resource(test, kunit_resource_name_match,
+				   (void *)name);
+}
+
+/**
  * kunit_destroy_resource() - Find a kunit_resource and destroy it.
  * @test: Test case to which the resource belongs.
  * @match: Match function. Returns whether a given resource matches @match_data.
@@ -440,6 +487,13 @@ int kunit_destroy_resource(struct kunit *test,
 			   kunit_resource_match_t match,
 			   void *match_data);
 
+static inline int kunit_destroy_named_resource(struct kunit *test,
+					       const char *name)
+{
+	return kunit_destroy_resource(test, kunit_resource_name_match,
+				      (void *)name);
+}
+
 /**
  * kunit_remove_resource: remove resource from resource list associated with
  *			  test.
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 03f3eca..69f9024 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -325,6 +325,42 @@ static void kunit_resource_test_static(struct kunit *test)
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
@@ -354,6 +390,7 @@ static void kunit_resource_test_exit(struct kunit *test)
 	KUNIT_CASE(kunit_resource_test_cleanup_resources),
 	KUNIT_CASE(kunit_resource_test_proper_free_ordering),
 	KUNIT_CASE(kunit_resource_test_static),
+	KUNIT_CASE(kunit_resource_test_named),
 	{}
 };
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 5560cdd..2cb7c62 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -442,6 +442,30 @@ int kunit_add_resource(struct kunit *test,
 }
 EXPORT_SYMBOL_GPL(kunit_add_resource);
 
+int kunit_add_named_resource(struct kunit *test,
+			     kunit_resource_init_t init,
+			     kunit_resource_free_t free,
+			     struct kunit_resource *res,
+			     const char *name,
+			     void *data)
+{
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
+	res->name = name;
+
+	return kunit_add_resource(test, init, free, res, data);
+}
+EXPORT_SYMBOL_GPL(kunit_add_named_resource);
+
 struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
 						    kunit_resource_init_t init,
 						    kunit_resource_free_t free,
-- 
1.8.3.1

