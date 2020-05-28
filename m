Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5371E62B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390505AbgE1NtE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 09:49:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22413 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390486AbgE1NtC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 09:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590673740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l2cvqJB46KTH7f8SdbqkLsCyORUTxh86VAPFNgoiJ8k=;
        b=InHOioVLtldu0i+BRMgmoyaCQZ51ccI/1dnPQERh3kker3VnkiQ76rKzqkvjdmoBmrnoqp
        XQN9jiJNX0wJ8mRMWrrHrcnCEHsKrP3lrjpR5D27nSvr+BFv0B7BtGsUCdRvw82py9EBCr
        KdIuQzJ5Z4IcFB8Ov7q2b7WKv0CyMzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-ZwwtmLHRPLuHp3q13nE7EA-1; Thu, 28 May 2020 09:48:58 -0400
X-MC-Unique: ZwwtmLHRPLuHp3q13nE7EA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F51A100CCC1;
        Thu, 28 May 2020 13:48:57 +0000 (UTC)
Received: from dm.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 913647A8BB;
        Thu, 28 May 2020 13:48:56 +0000 (UTC)
From:   Yannick Cote <ycote@redhat.com>
To:     live-patching@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, joe.lawrence@redhat.com
Subject: [PATCH 2/4] selftests/livepatch: rework test-klp-shadow-vars
Date:   Thu, 28 May 2020 09:48:47 -0400
Message-Id: <20200528134849.7890-3-ycote@redhat.com>
In-Reply-To: <20200528134849.7890-1-ycote@redhat.com>
References: <20200528134849.7890-1-ycote@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The initial idea was to make a change to please cppcheck and remove void
pointer arithmetics found a few times:

	portability: 'obj' is of type 'void *'. When using void pointers
	             in calculations, the behaviour is undefined.
		     [arithOperationsOnVoidPointer]

The rest of the changes are to help make the test read as an example
while continuing to verify the shadow variable code. The logic of the
test is unchanged but restructured to use descriptive names.

Signed-off-by: Yannick Cote <ycote@redhat.com>
---
 lib/livepatch/test_klp_shadow_vars.c | 101 +++++++++++++++------------
 1 file changed, 57 insertions(+), 44 deletions(-)

diff --git a/lib/livepatch/test_klp_shadow_vars.c b/lib/livepatch/test_klp_shadow_vars.c
index f0b5a1d24e55..ec2635cff974 100644
--- a/lib/livepatch/test_klp_shadow_vars.c
+++ b/lib/livepatch/test_klp_shadow_vars.c
@@ -109,8 +109,7 @@ static void shadow_free(void *obj, unsigned long id, klp_shadow_dtor_t dtor)
 static void shadow_free_all(unsigned long id, klp_shadow_dtor_t dtor)
 {
 	klp_shadow_free_all(id, dtor);
-	pr_info("klp_%s(id=0x%lx, dtor=PTR%d)\n",
-		__func__, id, ptr_id(dtor));
+	pr_info("klp_%s(id=0x%lx, dtor=PTR%d)\n", __func__, id, ptr_id(dtor));
 }
 
 
@@ -124,8 +123,7 @@ static int shadow_ctor(void *obj, void *shadow_data, void *ctor_data)
 		return -EINVAL;
 
 	*sv = *var;
-	pr_info("%s: PTR%d -> PTR%d\n",
-		__func__, ptr_id(sv), ptr_id(*var));
+	pr_info("%s: PTR%d -> PTR%d\n", __func__, ptr_id(sv), ptr_id(*var));
 
 	return 0;
 }
@@ -138,49 +136,63 @@ static void shadow_dtor(void *obj, void *shadow_data)
 		__func__, ptr_id(obj), ptr_id(sv));
 }
 
-static int test_klp_shadow_vars_init(void)
-{
-	void *obj			= THIS_MODULE;
-	int id			= 0x1234;
-	gfp_t gfp_flags		= GFP_KERNEL;
+/* dynamically created obj fields have the following shadow var id values */
+#define SV_ID1 0x1234
+#define SV_ID2 0x1235
 
-	int var1, var2, var3, var4;
-	int *pv1, *pv2, *pv3, *pv4;
-	int **sv1, **sv2, **sv3, **sv4;
+/*
+ * The main test case adds/removes new fields (shadow var) to each of these
+ * test structure instances. The last group of fields in the struct represent
+ * the idea that shadow variables may be added and removed to and from the
+ * struct during execution.
+ */
+struct test_object {
+	 /* add anything here below and avoid to define an empty struct */
+	struct shadow_ptr sp;
 
-	int **sv;
+	/* these represent shadow vars added and removed with SV_ID{1,2} */
+	/* char nfield1; */
+	/* int  nfield2; */
+};
 
-	pv1 = &var1;
-	pv2 = &var2;
-	pv3 = &var3;
-	pv4 = &var4;
+static int test_klp_shadow_vars_init(void)
+{
+	struct test_object obj1, obj2, obj3;
+	char nfield1, nfield2, *pnfield1, *pnfield2, **sv1, **sv2;
+	int  nfield3, nfield4, *pnfield3, *pnfield4, **sv3, **sv4;
+	void **sv;
+
+	pnfield1 = &nfield1;
+	pnfield2 = &nfield2;
+	pnfield3 = &nfield3;
+	pnfield4 = &nfield4;
 
 	ptr_id(NULL);
-	ptr_id(pv1);
-	ptr_id(pv2);
-	ptr_id(pv3);
-	ptr_id(pv4);
+	ptr_id(pnfield1);
+	ptr_id(pnfield2);
+	ptr_id(pnfield3);
+	ptr_id(pnfield4);
 
 	/*
 	 * With an empty shadow variable hash table, expect not to find
 	 * any matches.
 	 */
-	sv = shadow_get(obj, id);
+	sv = shadow_get(&obj1, SV_ID1);
 	if (!sv)
 		pr_info("  got expected NULL result\n");
 
 	/*
 	 * Allocate a few shadow variables with different <obj> and <id>.
 	 */
-	sv1 = shadow_alloc(obj, id, sizeof(pv1), gfp_flags, shadow_ctor, &pv1);
+	sv1 = shadow_alloc(&obj1, SV_ID1, sizeof(pnfield1), GFP_KERNEL, shadow_ctor, &pnfield1);
 	if (!sv1)
 		return -ENOMEM;
 
-	sv2 = shadow_alloc(obj + 1, id, sizeof(pv2), gfp_flags, shadow_ctor, &pv2);
+	sv2 = shadow_alloc(&obj2, SV_ID1, sizeof(pnfield2), GFP_KERNEL, shadow_ctor, &pnfield2);
 	if (!sv2)
 		return -ENOMEM;
 
-	sv3 = shadow_alloc(obj, id + 1, sizeof(pv3), gfp_flags, shadow_ctor, &pv3);
+	sv3 = shadow_alloc(&obj1, SV_ID2, sizeof(pnfield3), GFP_KERNEL, shadow_ctor, &pnfield3);
 	if (!sv3)
 		return -ENOMEM;
 
@@ -188,23 +200,24 @@ static int test_klp_shadow_vars_init(void)
 	 * Verify we can find our new shadow variables and that they point
 	 * to expected data.
 	 */
-	sv = shadow_get(obj, id);
+	sv = shadow_get(&obj1, SV_ID1);
 	if (!sv)
 		return -EINVAL;
-	if (sv == sv1 && *sv1 == pv1)
+	if ((char **)sv == sv1 && *sv1 == pnfield1)
 		pr_info("  got expected PTR%d -> PTR%d result\n",
 			ptr_id(sv1), ptr_id(*sv1));
 
-	sv = shadow_get(obj + 1, id);
+	sv = shadow_get(&obj2, SV_ID1);
 	if (!sv)
 		return -EINVAL;
-	if (sv == sv2 && *sv2 == pv2)
+	if ((char **)sv == sv2 && *sv2 == pnfield2)
 		pr_info("  got expected PTR%d -> PTR%d result\n",
 			ptr_id(sv2), ptr_id(*sv2));
-	sv = shadow_get(obj, id + 1);
+
+	sv = shadow_get(&obj1, SV_ID2);
 	if (!sv)
 		return -EINVAL;
-	if (sv == sv3 && *sv3 == pv3)
+	if ((int **)sv == sv3 && *sv3 == pnfield3)
 		pr_info("  got expected PTR%d -> PTR%d result\n",
 			ptr_id(sv3), ptr_id(*sv3));
 
@@ -212,14 +225,14 @@ static int test_klp_shadow_vars_init(void)
 	 * Allocate or get a few more, this time with the same <obj>, <id>.
 	 * The second invocation should return the same shadow var.
 	 */
-	sv4 = shadow_get_or_alloc(obj + 2, id, sizeof(pv4), gfp_flags, shadow_ctor, &pv4);
+	sv4 = shadow_get_or_alloc(&obj3, SV_ID1, sizeof(pnfield4), GFP_KERNEL, shadow_ctor, &pnfield4);
 	if (!sv4)
 		return -ENOMEM;
 
-	sv = shadow_get_or_alloc(obj + 2, id, sizeof(pv4), gfp_flags, shadow_ctor, &pv4);
+	sv = shadow_get_or_alloc(&obj3, SV_ID1, sizeof(pnfield4), GFP_KERNEL, shadow_ctor, &pnfield4);
 	if (!sv)
 		return -EINVAL;
-	if (sv == sv4 && *sv4 == pv4)
+	if ((int **)sv == sv4 && *sv4 == pnfield4)
 		pr_info("  got expected PTR%d -> PTR%d result\n",
 			ptr_id(sv4), ptr_id(*sv4));
 
@@ -227,36 +240,36 @@ static int test_klp_shadow_vars_init(void)
 	 * Free the <obj=*, id> shadow variables and check that we can no
 	 * longer find them.
 	 */
-	shadow_free(obj, id, shadow_dtor);			/* sv1 */
-	sv = shadow_get(obj, id);
+	shadow_free(&obj1, SV_ID1, shadow_dtor);		/* sv1 */
+	sv = shadow_get(&obj1, SV_ID1);
 	if (!sv)
 		pr_info("  got expected NULL result\n");
 
-	shadow_free(obj + 1, id, shadow_dtor);			/* sv2 */
-	sv = shadow_get(obj + 1, id);
+	shadow_free(&obj2, SV_ID1, shadow_dtor);		/* sv2 */
+	sv = shadow_get(&obj2, SV_ID1);
 	if (!sv)
 		pr_info("  got expected NULL result\n");
 
-	shadow_free(obj + 2, id, shadow_dtor);			/* sv4 */
-	sv = shadow_get(obj + 2, id);
+	shadow_free(&obj3, SV_ID1, shadow_dtor);		/* sv4 */
+	sv = shadow_get(&obj3, SV_ID1);
 	if (!sv)
 		pr_info("  got expected NULL result\n");
 
 	/*
 	 * We should still find an <id+1> variable.
 	 */
-	sv = shadow_get(obj, id + 1);
+	sv = shadow_get(&obj1, SV_ID2);
 	if (!sv)
 		return -EINVAL;
-	if (sv == sv3 && *sv3 == pv3)
+	if ((int **)sv == sv3 && *sv3 == pnfield3)
 		pr_info("  got expected PTR%d -> PTR%d result\n",
 			ptr_id(sv3), ptr_id(*sv3));
 
 	/*
 	 * Free all the <id+1> variables, too.
 	 */
-	shadow_free_all(id + 1, shadow_dtor);			/* sv3 */
-	sv = shadow_get(obj, id);
+	shadow_free_all(SV_ID2, shadow_dtor);			/* sv3 */
+	sv = shadow_get(&obj1, SV_ID1);
 	if (!sv)
 		pr_info("  shadow_get() got expected NULL result\n");
 
-- 
2.25.4

