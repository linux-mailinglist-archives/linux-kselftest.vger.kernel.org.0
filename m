Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D481E62B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 15:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390486AbgE1NtE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 09:49:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37029 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390538AbgE1NtD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 09:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590673740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCTvVYkxlXoh7jPeCyIDl93N6AKkB5CbqaJp3ZyE8Ro=;
        b=QBWYvkpEmlxbpgBl6zSnv50jcT85go+EhSmFnCjhRG6CbSsb8c4YZ2U5owFC3A0TWBwRAN
        FAjoDDXNTp7aNB1Wlbv+U2RHSjZsIKNowcLxcpePRxqWJpnNuPt89IiymiFXemBcj1akqs
        16j9+pCMdkV1zX3NjacHDFgYLZ2ADH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-rKUw2BtEP5mOcGcCvY2AcQ-1; Thu, 28 May 2020 09:48:58 -0400
X-MC-Unique: rKUw2BtEP5mOcGcCvY2AcQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF01A107ACF5;
        Thu, 28 May 2020 13:48:57 +0000 (UTC)
Received: from dm.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D1C0797EB;
        Thu, 28 May 2020 13:48:57 +0000 (UTC)
From:   Yannick Cote <ycote@redhat.com>
To:     live-patching@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, joe.lawrence@redhat.com
Subject: [PATCH 3/4] selftests/livepatch: more verification in test-klp-shadow-vars
Date:   Thu, 28 May 2020 09:48:48 -0400
Message-Id: <20200528134849.7890-4-ycote@redhat.com>
In-Reply-To: <20200528134849.7890-1-ycote@redhat.com>
References: <20200528134849.7890-1-ycote@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This change makes the test feel more familiar with narrowing to a
typical usage by operating on a number of identical structure instances
and populating the same two new shadow variables symmetrically while
keeping the same testing and verification criteria for the extra
variables.

Signed-off-by: Yannick Cote <ycote@redhat.com>
---
 lib/livepatch/test_klp_shadow_vars.c          | 182 ++++++++----------
 .../selftests/livepatch/test-shadow-vars.sh   |  85 +++++---
 2 files changed, 135 insertions(+), 132 deletions(-)

diff --git a/lib/livepatch/test_klp_shadow_vars.c b/lib/livepatch/test_klp_shadow_vars.c
index ec2635cff974..195309e1edf3 100644
--- a/lib/livepatch/test_klp_shadow_vars.c
+++ b/lib/livepatch/test_klp_shadow_vars.c
@@ -128,6 +128,11 @@ static int shadow_ctor(void *obj, void *shadow_data, void *ctor_data)
 	return 0;
 }
 
+/*
+ * With more than one item to free in the list, order is not determined and
+ * shadow_dtor will not be passed to shadow_free_all() which would make the
+ * test fail. (see pass 6)
+ */
 static void shadow_dtor(void *obj, void *shadow_data)
 {
 	int **sv = shadow_data;
@@ -136,6 +141,9 @@ static void shadow_dtor(void *obj, void *shadow_data)
 		__func__, ptr_id(obj), ptr_id(sv));
 }
 
+/* number of objects we simulate that need kpatch-patch shadow vars */
+#define NUM_OBJS 3
+
 /* dynamically created obj fields have the following shadow var id values */
 #define SV_ID1 0x1234
 #define SV_ID2 0x1235
@@ -157,122 +165,96 @@ struct test_object {
 
 static int test_klp_shadow_vars_init(void)
 {
-	struct test_object obj1, obj2, obj3;
-	char nfield1, nfield2, *pnfield1, *pnfield2, **sv1, **sv2;
-	int  nfield3, nfield4, *pnfield3, *pnfield4, **sv3, **sv4;
+	struct test_object objs[NUM_OBJS];
+	char nfields1[NUM_OBJS], *pnfields1[NUM_OBJS], **sv1[NUM_OBJS];
+	char *pndup[NUM_OBJS];
+	int nfields2[NUM_OBJS], *pnfields2[NUM_OBJS], **sv2[NUM_OBJS];
 	void **sv;
-
-	pnfield1 = &nfield1;
-	pnfield2 = &nfield2;
-	pnfield3 = &nfield3;
-	pnfield4 = &nfield4;
+	int i;
 
 	ptr_id(NULL);
-	ptr_id(pnfield1);
-	ptr_id(pnfield2);
-	ptr_id(pnfield3);
-	ptr_id(pnfield4);
 
 	/*
 	 * With an empty shadow variable hash table, expect not to find
 	 * any matches.
 	 */
-	sv = shadow_get(&obj1, SV_ID1);
+	sv = shadow_get(&objs[0], SV_ID1);
 	if (!sv)
 		pr_info("  got expected NULL result\n");
 
-	/*
-	 * Allocate a few shadow variables with different <obj> and <id>.
-	 */
-	sv1 = shadow_alloc(&obj1, SV_ID1, sizeof(pnfield1), GFP_KERNEL, shadow_ctor, &pnfield1);
-	if (!sv1)
-		return -ENOMEM;
-
-	sv2 = shadow_alloc(&obj2, SV_ID1, sizeof(pnfield2), GFP_KERNEL, shadow_ctor, &pnfield2);
-	if (!sv2)
-		return -ENOMEM;
-
-	sv3 = shadow_alloc(&obj1, SV_ID2, sizeof(pnfield3), GFP_KERNEL, shadow_ctor, &pnfield3);
-	if (!sv3)
-		return -ENOMEM;
-
-	/*
-	 * Verify we can find our new shadow variables and that they point
-	 * to expected data.
-	 */
-	sv = shadow_get(&obj1, SV_ID1);
-	if (!sv)
-		return -EINVAL;
-	if ((char **)sv == sv1 && *sv1 == pnfield1)
-		pr_info("  got expected PTR%d -> PTR%d result\n",
-			ptr_id(sv1), ptr_id(*sv1));
-
-	sv = shadow_get(&obj2, SV_ID1);
-	if (!sv)
-		return -EINVAL;
-	if ((char **)sv == sv2 && *sv2 == pnfield2)
-		pr_info("  got expected PTR%d -> PTR%d result\n",
-			ptr_id(sv2), ptr_id(*sv2));
-
-	sv = shadow_get(&obj1, SV_ID2);
-	if (!sv)
-		return -EINVAL;
-	if ((int **)sv == sv3 && *sv3 == pnfield3)
-		pr_info("  got expected PTR%d -> PTR%d result\n",
-			ptr_id(sv3), ptr_id(*sv3));
-
-	/*
-	 * Allocate or get a few more, this time with the same <obj>, <id>.
-	 * The second invocation should return the same shadow var.
-	 */
-	sv4 = shadow_get_or_alloc(&obj3, SV_ID1, sizeof(pnfield4), GFP_KERNEL, shadow_ctor, &pnfield4);
-	if (!sv4)
-		return -ENOMEM;
-
-	sv = shadow_get_or_alloc(&obj3, SV_ID1, sizeof(pnfield4), GFP_KERNEL, shadow_ctor, &pnfield4);
-	if (!sv)
-		return -EINVAL;
-	if ((int **)sv == sv4 && *sv4 == pnfield4)
-		pr_info("  got expected PTR%d -> PTR%d result\n",
-			ptr_id(sv4), ptr_id(*sv4));
-
-	/*
-	 * Free the <obj=*, id> shadow variables and check that we can no
-	 * longer find them.
-	 */
-	shadow_free(&obj1, SV_ID1, shadow_dtor);		/* sv1 */
-	sv = shadow_get(&obj1, SV_ID1);
-	if (!sv)
-		pr_info("  got expected NULL result\n");
+	/* pass 1: init & alloc a char+int pair of svars for each objs */
+	for (i = 0; i < NUM_OBJS; i++) {
+		pnfields1[i] = &nfields1[i];
+		pnfields2[i] = &nfields2[i];
+		ptr_id(pnfields1[i]);
+		ptr_id(pnfields2[i]);
+
+		/* alloc a few svars with different <obj> and <id>. */
+		sv1[i] = shadow_alloc(&objs[i], SV_ID1, sizeof(pnfields1[i]),
+					GFP_KERNEL, shadow_ctor, &pnfields1[i]);
+		if (!sv1[i])
+			return -ENOMEM;
+		sv2[i] = shadow_alloc(&objs[i], SV_ID2, sizeof(pnfields2[i]),
+					GFP_KERNEL, shadow_ctor, &pnfields2[i]);
+		if (!sv2[i])
+			return -ENOMEM;
+	}
 
-	shadow_free(&obj2, SV_ID1, shadow_dtor);		/* sv2 */
-	sv = shadow_get(&obj2, SV_ID1);
-	if (!sv)
-		pr_info("  got expected NULL result\n");
+	/* pass 2: verify we find allocated svars and where they point to */
+	for (i = 0; i < NUM_OBJS; i++) {
+		/* check the "char" svar for all objects */
+		sv = shadow_get(&objs[i], SV_ID1);
+		if (!sv)
+			return -EINVAL;
+		if ((char **)sv == sv1[i] && *sv1[i] == pnfields1[i])
+			pr_info("  got expected PTR%d -> PTR%d result\n",
+				ptr_id(sv1[i]), ptr_id(*sv1[i]));
+
+		/* check the "int" svar for all objects */
+		sv = shadow_get(&objs[i], SV_ID2);
+		if (!sv)
+			return -EINVAL;
+		if ((int **)sv == sv2[i] && *sv2[i] == pnfields2[i])
+			pr_info("  got expected PTR%d -> PTR%d result\n",
+				ptr_id(sv2[i]), ptr_id(*sv2[i]));
+	}
 
-	shadow_free(&obj3, SV_ID1, shadow_dtor);		/* sv4 */
-	sv = shadow_get(&obj3, SV_ID1);
-	if (!sv)
-		pr_info("  got expected NULL result\n");
+	/* pass 3: verify that 'get_of_alloc' returns already allocated svars */
+	for (i = 0; i < NUM_OBJS; i++) {
+		sv = shadow_get_or_alloc(&objs[i], SV_ID1, sizeof(pndup[i]),
+					GFP_KERNEL, shadow_ctor, &pndup[i]);
+		if (!sv)
+			return -EINVAL;
+		if ((char **)sv == sv1[i] && *sv1[i] == pnfields1[i])
+			pr_info("  got expected PTR%d -> PTR%d result\n",
+					ptr_id(sv1[i]), ptr_id(*sv1[i]));
+	}
 
-	/*
-	 * We should still find an <id+1> variable.
-	 */
-	sv = shadow_get(&obj1, SV_ID2);
-	if (!sv)
-		return -EINVAL;
-	if ((int **)sv == sv3 && *sv3 == pnfield3)
-		pr_info("  got expected PTR%d -> PTR%d result\n",
-			ptr_id(sv3), ptr_id(*sv3));
+	/* pass 4: free <objs[*], SV_ID1> pairs of svars, verify removal */
+	for (i = 0; i < NUM_OBJS; i++) {
+		shadow_free(&objs[i], SV_ID1, shadow_dtor); /* 'char' pairs */
+		sv = shadow_get(&objs[i], SV_ID1);
+		if (!sv)
+			pr_info("  got expected NULL result\n");
+	}
 
-	/*
-	 * Free all the <id+1> variables, too.
-	 */
-	shadow_free_all(SV_ID2, shadow_dtor);			/* sv3 */
-	sv = shadow_get(&obj1, SV_ID1);
-	if (!sv)
-		pr_info("  shadow_get() got expected NULL result\n");
+	/* pass 5: check we still find <objs[*], SV_ID2> svar pairs */
+	for (i = 0; i < NUM_OBJS; i++) {
+		sv = shadow_get(&objs[i], SV_ID2);	/* 'int' pairs */
+		if (!sv)
+			return -EINVAL;
+		if ((int **)sv == sv2[i] && *sv2[i] == pnfields2[i])
+			pr_info("  got expected PTR%d -> PTR%d result\n",
+					ptr_id(sv2[i]), ptr_id(*sv2[i]));
+	}
 
+	/* pass 6: free all the <objs[*], SV_ID2> svar pairs too. */
+	shadow_free_all(SV_ID2, NULL);		/* 'int' pairs */
+	for (i = 0; i < NUM_OBJS; i++) {
+		sv = shadow_get(&objs[i], SV_ID2);
+		if (!sv)
+			pr_info("  shadow_get() got expected NULL result\n");
+	}
 
 	free_ptr_list();
 
diff --git a/tools/testing/selftests/livepatch/test-shadow-vars.sh b/tools/testing/selftests/livepatch/test-shadow-vars.sh
index 1aae73299114..469ceb345b3a 100755
--- a/tools/testing/selftests/livepatch/test-shadow-vars.sh
+++ b/tools/testing/selftests/livepatch/test-shadow-vars.sh
@@ -19,42 +19,63 @@ load_mod $MOD_TEST
 unload_mod $MOD_TEST
 
 check_result "% modprobe $MOD_TEST
-$MOD_TEST: klp_shadow_get(obj=PTR5, id=0x1234) = PTR0
+$MOD_TEST: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
 $MOD_TEST:   got expected NULL result
-$MOD_TEST: shadow_ctor: PTR6 -> PTR1
-$MOD_TEST: klp_shadow_alloc(obj=PTR5, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR7, ctor_data=PTR1 = PTR6
-$MOD_TEST: shadow_ctor: PTR8 -> PTR2
-$MOD_TEST: klp_shadow_alloc(obj=PTR9, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR7, ctor_data=PTR2 = PTR8
-$MOD_TEST: shadow_ctor: PTR10 -> PTR3
-$MOD_TEST: klp_shadow_alloc(obj=PTR5, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR7, ctor_data=PTR3 = PTR10
-$MOD_TEST: klp_shadow_get(obj=PTR5, id=0x1234) = PTR6
-$MOD_TEST:   got expected PTR6 -> PTR1 result
-$MOD_TEST: klp_shadow_get(obj=PTR9, id=0x1234) = PTR8
-$MOD_TEST:   got expected PTR8 -> PTR2 result
-$MOD_TEST: klp_shadow_get(obj=PTR5, id=0x1235) = PTR10
-$MOD_TEST:   got expected PTR10 -> PTR3 result
-$MOD_TEST: shadow_ctor: PTR11 -> PTR4
-$MOD_TEST: klp_shadow_get_or_alloc(obj=PTR12, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR7, ctor_data=PTR4 = PTR11
-$MOD_TEST: klp_shadow_get_or_alloc(obj=PTR12, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR7, ctor_data=PTR4 = PTR11
-$MOD_TEST:   got expected PTR11 -> PTR4 result
-$MOD_TEST: shadow_dtor(obj=PTR5, shadow_data=PTR6)
-$MOD_TEST: klp_shadow_free(obj=PTR5, id=0x1234, dtor=PTR13)
-$MOD_TEST: klp_shadow_get(obj=PTR5, id=0x1234) = PTR0
+$MOD_TEST: shadow_ctor: PTR4 -> PTR2
+$MOD_TEST: klp_shadow_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR2 = PTR4
+$MOD_TEST: shadow_ctor: PTR6 -> PTR3
+$MOD_TEST: klp_shadow_alloc(obj=PTR1, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR3 = PTR6
+$MOD_TEST: shadow_ctor: PTR9 -> PTR7
+$MOD_TEST: klp_shadow_alloc(obj=PTR10, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR7 = PTR9
+$MOD_TEST: shadow_ctor: PTR11 -> PTR8
+$MOD_TEST: klp_shadow_alloc(obj=PTR10, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR8 = PTR11
+$MOD_TEST: shadow_ctor: PTR14 -> PTR12
+$MOD_TEST: klp_shadow_alloc(obj=PTR15, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR12 = PTR14
+$MOD_TEST: shadow_ctor: PTR16 -> PTR13
+$MOD_TEST: klp_shadow_alloc(obj=PTR15, id=0x1235, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR13 = PTR16
+$MOD_TEST: klp_shadow_get(obj=PTR1, id=0x1234) = PTR4
+$MOD_TEST:   got expected PTR4 -> PTR2 result
+$MOD_TEST: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
+$MOD_TEST:   got expected PTR6 -> PTR3 result
+$MOD_TEST: klp_shadow_get(obj=PTR10, id=0x1234) = PTR9
+$MOD_TEST:   got expected PTR9 -> PTR7 result
+$MOD_TEST: klp_shadow_get(obj=PTR10, id=0x1235) = PTR11
+$MOD_TEST:   got expected PTR11 -> PTR8 result
+$MOD_TEST: klp_shadow_get(obj=PTR15, id=0x1234) = PTR14
+$MOD_TEST:   got expected PTR14 -> PTR12 result
+$MOD_TEST: klp_shadow_get(obj=PTR15, id=0x1235) = PTR16
+$MOD_TEST:   got expected PTR16 -> PTR13 result
+$MOD_TEST: klp_shadow_get_or_alloc(obj=PTR1, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR17 = PTR4
+$MOD_TEST:   got expected PTR4 -> PTR2 result
+$MOD_TEST: klp_shadow_get_or_alloc(obj=PTR10, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR18 = PTR9
+$MOD_TEST:   got expected PTR9 -> PTR7 result
+$MOD_TEST: klp_shadow_get_or_alloc(obj=PTR15, id=0x1234, size=8, gfp_flags=GFP_KERNEL), ctor=PTR5, ctor_data=PTR19 = PTR14
+$MOD_TEST:   got expected PTR14 -> PTR12 result
+$MOD_TEST: shadow_dtor(obj=PTR1, shadow_data=PTR4)
+$MOD_TEST: klp_shadow_free(obj=PTR1, id=0x1234, dtor=PTR20)
+$MOD_TEST: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
 $MOD_TEST:   got expected NULL result
-$MOD_TEST: shadow_dtor(obj=PTR9, shadow_data=PTR8)
-$MOD_TEST: klp_shadow_free(obj=PTR9, id=0x1234, dtor=PTR13)
-$MOD_TEST: klp_shadow_get(obj=PTR9, id=0x1234) = PTR0
+$MOD_TEST: shadow_dtor(obj=PTR10, shadow_data=PTR9)
+$MOD_TEST: klp_shadow_free(obj=PTR10, id=0x1234, dtor=PTR20)
+$MOD_TEST: klp_shadow_get(obj=PTR10, id=0x1234) = PTR0
 $MOD_TEST:   got expected NULL result
-$MOD_TEST: shadow_dtor(obj=PTR12, shadow_data=PTR11)
-$MOD_TEST: klp_shadow_free(obj=PTR12, id=0x1234, dtor=PTR13)
-$MOD_TEST: klp_shadow_get(obj=PTR12, id=0x1234) = PTR0
+$MOD_TEST: shadow_dtor(obj=PTR15, shadow_data=PTR14)
+$MOD_TEST: klp_shadow_free(obj=PTR15, id=0x1234, dtor=PTR20)
+$MOD_TEST: klp_shadow_get(obj=PTR15, id=0x1234) = PTR0
 $MOD_TEST:   got expected NULL result
-$MOD_TEST: klp_shadow_get(obj=PTR5, id=0x1235) = PTR10
-$MOD_TEST:   got expected PTR10 -> PTR3 result
-$MOD_TEST: shadow_dtor(obj=PTR5, shadow_data=PTR10)
-$MOD_TEST: klp_shadow_free_all(id=0x1235, dtor=PTR13)
-$MOD_TEST: klp_shadow_get(obj=PTR5, id=0x1234) = PTR0
+$MOD_TEST: klp_shadow_get(obj=PTR1, id=0x1235) = PTR6
+$MOD_TEST:   got expected PTR6 -> PTR3 result
+$MOD_TEST: klp_shadow_get(obj=PTR10, id=0x1235) = PTR11
+$MOD_TEST:   got expected PTR11 -> PTR8 result
+$MOD_TEST: klp_shadow_get(obj=PTR15, id=0x1235) = PTR16
+$MOD_TEST:   got expected PTR16 -> PTR13 result
+$MOD_TEST: klp_shadow_free_all(id=0x1235, dtor=PTR0)
+$MOD_TEST: klp_shadow_get(obj=PTR1, id=0x1235) = PTR0
 $MOD_TEST:   shadow_get() got expected NULL result
-% rmmod test_klp_shadow_vars"
+$MOD_TEST: klp_shadow_get(obj=PTR10, id=0x1235) = PTR0
+$MOD_TEST:   shadow_get() got expected NULL result
+$MOD_TEST: klp_shadow_get(obj=PTR15, id=0x1235) = PTR0
+$MOD_TEST:   shadow_get() got expected NULL result
+% rmmod $MOD_TEST"
 
 exit 0
-- 
2.25.4

