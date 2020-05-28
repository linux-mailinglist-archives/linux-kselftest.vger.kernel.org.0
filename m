Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB401E62BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 15:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390496AbgE1NtE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 09:49:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43575 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390497AbgE1NtD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 09:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590673741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ZuEdoQFokpyh7ut5OfaaYt9boo3QR1gcKg76iY9Rcs=;
        b=edLz5lT2sKwScCh66HUaQqB5se1ZQyvJJgYo2y/wgTRSUHy1Z08bzLO7Yq2ONTHLg1hy/1
        RPFgmLTwo1Nudsq29fqwezJxsjwpkn3tFzkhBMB0u4Em1LtlU8ngcz/pVbP+RQVAB9Suyb
        DypiI5BnbAgtdnGXTyaU89e74kiF4v0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-d38MtTYUP8im97rlVecp3g-1; Thu, 28 May 2020 09:48:59 -0400
X-MC-Unique: d38MtTYUP8im97rlVecp3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D4E218FF661;
        Thu, 28 May 2020 13:48:58 +0000 (UTC)
Received: from dm.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09A5C797EB;
        Thu, 28 May 2020 13:48:57 +0000 (UTC)
From:   Yannick Cote <ycote@redhat.com>
To:     live-patching@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, joe.lawrence@redhat.com
Subject: [PATCH 4/4] selftests/livepatch: fix mem leaks in test-klp-shadow-vars
Date:   Thu, 28 May 2020 09:48:49 -0400
Message-Id: <20200528134849.7890-5-ycote@redhat.com>
In-Reply-To: <20200528134849.7890-1-ycote@redhat.com>
References: <20200528134849.7890-1-ycote@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In some cases, when an error occurs during testing and the main test
routine returns, a memory leak occurs via leaving previously registered
shadow variables allocated in the kernel as well as shadow_ptr list
elements. From now on, in case of error, remove all allocated shadow
variables and shadow_ptr struct elements.

Signed-off-by: Yannick Cote <ycote@redhat.com>
---
 lib/livepatch/test_klp_shadow_vars.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/lib/livepatch/test_klp_shadow_vars.c b/lib/livepatch/test_klp_shadow_vars.c
index 195309e1edf3..c6d631d826e0 100644
--- a/lib/livepatch/test_klp_shadow_vars.c
+++ b/lib/livepatch/test_klp_shadow_vars.c
@@ -170,6 +170,7 @@ static int test_klp_shadow_vars_init(void)
 	char *pndup[NUM_OBJS];
 	int nfields2[NUM_OBJS], *pnfields2[NUM_OBJS], **sv2[NUM_OBJS];
 	void **sv;
+	int ret = -EINVAL;
 	int i;
 
 	ptr_id(NULL);
@@ -192,12 +193,16 @@ static int test_klp_shadow_vars_init(void)
 		/* alloc a few svars with different <obj> and <id>. */
 		sv1[i] = shadow_alloc(&objs[i], SV_ID1, sizeof(pnfields1[i]),
 					GFP_KERNEL, shadow_ctor, &pnfields1[i]);
-		if (!sv1[i])
-			return -ENOMEM;
+		if (!sv1[i]) {
+			ret = -ENOMEM;
+			goto out;
+		}
 		sv2[i] = shadow_alloc(&objs[i], SV_ID2, sizeof(pnfields2[i]),
 					GFP_KERNEL, shadow_ctor, &pnfields2[i]);
-		if (!sv2[i])
-			return -ENOMEM;
+		if (!sv2[i]) {
+			ret = -ENOMEM;
+			goto out;
+		}
 	}
 
 	/* pass 2: verify we find allocated svars and where they point to */
@@ -205,7 +210,7 @@ static int test_klp_shadow_vars_init(void)
 		/* check the "char" svar for all objects */
 		sv = shadow_get(&objs[i], SV_ID1);
 		if (!sv)
-			return -EINVAL;
+			goto out;
 		if ((char **)sv == sv1[i] && *sv1[i] == pnfields1[i])
 			pr_info("  got expected PTR%d -> PTR%d result\n",
 				ptr_id(sv1[i]), ptr_id(*sv1[i]));
@@ -213,7 +218,7 @@ static int test_klp_shadow_vars_init(void)
 		/* check the "int" svar for all objects */
 		sv = shadow_get(&objs[i], SV_ID2);
 		if (!sv)
-			return -EINVAL;
+			goto out;
 		if ((int **)sv == sv2[i] && *sv2[i] == pnfields2[i])
 			pr_info("  got expected PTR%d -> PTR%d result\n",
 				ptr_id(sv2[i]), ptr_id(*sv2[i]));
@@ -224,7 +229,7 @@ static int test_klp_shadow_vars_init(void)
 		sv = shadow_get_or_alloc(&objs[i], SV_ID1, sizeof(pndup[i]),
 					GFP_KERNEL, shadow_ctor, &pndup[i]);
 		if (!sv)
-			return -EINVAL;
+			goto out;
 		if ((char **)sv == sv1[i] && *sv1[i] == pnfields1[i])
 			pr_info("  got expected PTR%d -> PTR%d result\n",
 					ptr_id(sv1[i]), ptr_id(*sv1[i]));
@@ -242,7 +247,7 @@ static int test_klp_shadow_vars_init(void)
 	for (i = 0; i < NUM_OBJS; i++) {
 		sv = shadow_get(&objs[i], SV_ID2);	/* 'int' pairs */
 		if (!sv)
-			return -EINVAL;
+			goto out;
 		if ((int **)sv == sv2[i] && *sv2[i] == pnfields2[i])
 			pr_info("  got expected PTR%d -> PTR%d result\n",
 					ptr_id(sv2[i]), ptr_id(*sv2[i]));
@@ -259,6 +264,12 @@ static int test_klp_shadow_vars_init(void)
 	free_ptr_list();
 
 	return 0;
+out:
+	shadow_free_all(SV_ID1, NULL);		/* 'char' pairs */
+	shadow_free_all(SV_ID2, NULL);		/* 'int' pairs */
+	free_ptr_list();
+
+	return ret;
 }
 
 static void test_klp_shadow_vars_exit(void)
-- 
2.25.4

