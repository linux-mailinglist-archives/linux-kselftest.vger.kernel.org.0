Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5154828CD0C
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Oct 2020 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgJML4b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Oct 2020 07:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbgJMLyt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:49 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 643F622522;
        Tue, 13 Oct 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=/bHl1yHvnGqPKNbvJvHMSS5pZd7oY1zhfyqb1y94N8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJSDrlV6GRFR/TU/l/hKCldbSIieoO0iSbL/1nxNFEFQL6yHxmlN8TJkgl5VEKNEP
         aM1GZoG4Lm6eYBxVZyfrhLnfvqYjyPJt+1zwLRYEOg+O+M+CDgCb90iGVqeCoEQ/aJ
         bv+DGGHi2YM0CtlWVtac6KBCoYD5F84CZ5+SwW28=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt5-006CW3-EM; Tue, 13 Oct 2020 13:54:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v6 61/80] kunit: test.h: solve kernel-doc warnings
Date:   Tue, 13 Oct 2020 13:54:16 +0200
Message-Id: <ed46994d6097086de8e19ee588747194f0aa57a4.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are some warnings there:
	./include/kunit/test.h:90: warning: Function parameter or member 'name' not described in 'kunit_resource'
	./include/kunit/test.h:353: warning: Function parameter or member 'res' not described in 'kunit_add_resource'
	./include/kunit/test.h:367: warning: Function parameter or member 'res' not described in 'kunit_add_named_resource'
	./include/kunit/test.h:367: warning: Function parameter or member 'name' not described in 'kunit_add_named_resource'
	./include/kunit/test.h:367: warning: Function parameter or member 'data' not described in 'kunit_add_named_resource'
	./include/kunit/test.h:367: warning: Excess function parameter 'name_data' description in 'kunit_add_named_resource'

Address them, ensuring that all non-private arguments will
be properly described. With that regards, at struct kunit_resource,
the free argument is described as user-provided. So, this
doesn't seem to belong to the "private" part of the struct.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/kunit/test.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 59f3144f009a..41b3a266bf8c 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -25,6 +25,7 @@ typedef void (*kunit_resource_free_t)(struct kunit_resource *);
 /**
  * struct kunit_resource - represents a *test managed resource*
  * @data: for the user to store arbitrary data.
+ * @name: optional name
  * @free: a user supplied function to free the resource. Populated by
  * kunit_resource_alloc().
  *
@@ -80,10 +81,10 @@ typedef void (*kunit_resource_free_t)(struct kunit_resource *);
  */
 struct kunit_resource {
 	void *data;
-	const char *name;		/* optional name */
-
-	/* private: internal use only. */
+	const char *name;
 	kunit_resource_free_t free;
+
+	/* private: internal use only. */
 	struct kref refcount;
 	struct list_head node;
 };
@@ -343,6 +344,7 @@ static inline void kunit_put_resource(struct kunit_resource *res)
  *        none is supplied, the resource data value is simply set to @data.
  *	  If an init function is supplied, @data is passed to it instead.
  * @free: a user-supplied function to free the resource (if needed).
+ * @res: The resource.
  * @data: value to pass to init function or set in resource data field.
  */
 int kunit_add_resource(struct kunit *test,
@@ -356,7 +358,9 @@ int kunit_add_resource(struct kunit *test,
  * @test: The test context object.
  * @init: a user-supplied function to initialize the resource data, if needed.
  * @free: a user-supplied function to free the resource data, if needed.
- * @name_data: name and data to be set for resource.
+ * @res: The resource.
+ * @name: name to be set for resource.
+ * @data: value to pass to init function or set in resource data field.
  */
 int kunit_add_named_resource(struct kunit *test,
 			     kunit_resource_init_t init,
-- 
2.26.2

