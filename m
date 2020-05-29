Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18511E8A5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 23:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgE2Vqq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 17:46:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57170 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgE2Vqp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 17:46:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TLcIK7163940;
        Fri, 29 May 2020 21:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=4VGuIt4dHL3ixeAcObA72imlfKiZALitYWCyzm2aJKk=;
 b=NLcxbOcvPQ1yr0n+OUxRRSomhNK89q1y8vKBm4cojsMH+eV0jKczsMqEhUT6dhfL34NM
 TtbblQ6jk96SmtJK00+mWCgZnLBkNT1T4lce5s4xnZZ2o1IoSuRGvRpVfBn8fFtOPKXH
 Ehy1GTj9Sd2VXVsJogS4ciZZuFfEi64aBa6j/GZkbfldq+c4N4Gp8mAts3SESctnxP1B
 //CxZ3apfAdZVgWmlYcdzLpCFYdDN0k2mdq04pWRXPDwSlnocnYDw7oMSi4cy4yRSPpy
 8DG3VnKjmFnw5I4zga+aw7x5on/VJ2BCEDYIYZ/u2WzbXNNrk1NUgC+FGmpzGFJB7DWT 0Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 318xe1vktf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 21:46:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TLXjQZ061642;
        Fri, 29 May 2020 21:46:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31a9kutpbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 21:46:39 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04TLkcPO018245;
        Fri, 29 May 2020 21:46:38 GMT
Received: from localhost.uk.oracle.com (/10.175.189.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 14:46:38 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org
Cc:     davidgow@google.com, trishalfonso@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 kunit-next 2/2] kunit: add support for named resources
Date:   Fri, 29 May 2020 22:46:21 +0100
Message-Id: <1590788781-1895-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1590788781-1895-1-git-send-email-alan.maguire@oracle.com>
References: <1590788781-1895-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 suspectscore=2 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290155
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h   | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/kunit-test.c | 37 ++++++++++++++++++++++++++++++++++
 lib/kunit/test.c       | 24 ++++++++++++++++++++++
 3 files changed, 115 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index f9b914e..59f3144 100644
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
 	kunit_resource_free_t free;
@@ -344,6 +350,21 @@ int kunit_add_resource(struct kunit *test,
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
@@ -399,6 +420,19 @@ static inline bool kunit_resource_instance_match(struct kunit *test,
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
@@ -427,6 +461,19 @@ static inline bool kunit_resource_instance_match(struct kunit *test,
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
@@ -439,6 +486,13 @@ int kunit_destroy_resource(struct kunit *test,
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
index 569b7f9..c360372 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -441,6 +441,30 @@ int kunit_add_resource(struct kunit *test,
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

