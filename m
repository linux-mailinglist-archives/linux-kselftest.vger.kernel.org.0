Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BBD1ED609
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jun 2020 20:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgFCSVs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jun 2020 14:21:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39211 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726095AbgFCSVr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jun 2020 14:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591208505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N8+QQPH2QujNnngMCvTYk2cn6MqYerfKhZLbvp5VGaU=;
        b=cKh0Eh5xFfrwE4w3RYLwuj9Wp4wdeTNiqlzdzjjwN3hXz2B6CRIBUfhmxKdh9Tg+0cEXVt
        4/Aayuak5lC5nHGrd4VH53AI6+V7dmr2Crzv9iocjCcdEm0j2sFGszLTUgiJpwCb9P3tv2
        cg6YMGjGs5tGagpIs28KbVpmeZCNjek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-0t8LO991OQmcwyM40xm4Cw-1; Wed, 03 Jun 2020 14:21:42 -0400
X-MC-Unique: 0t8LO991OQmcwyM40xm4Cw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAFEE107ACCA;
        Wed,  3 Jun 2020 18:21:40 +0000 (UTC)
Received: from dm.redhat.com (unknown [10.10.67.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C21DF5D9CD;
        Wed,  3 Jun 2020 18:21:39 +0000 (UTC)
From:   Yannick Cote <ycote@redhat.com>
To:     live-patching@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, joe.lawrence@redhat.com,
        linux-kernel@vger.kernel.org, pmladek@suse.com, mbenes@suse.cz,
        kamalesh@linux.vnet.ibm.com
Subject: [PATCH v2 4/4] selftests/livepatch: fix mem leaks in test-klp-shadow-vars
Date:   Wed,  3 Jun 2020 14:20:58 -0400
Message-Id: <20200603182058.109470-5-ycote@redhat.com>
In-Reply-To: <20200603182058.109470-1-ycote@redhat.com>
References: <20200603182058.109470-1-ycote@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In some cases, when an error occurs during testing and the main test
routine returns, a memory leak occurs via leaving previously registered
shadow variables allocated in the kernel as well as shadow_ptr list
elements. From now on, in case of error, remove all allocated shadow
variables and shadow_ptr struct elements.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Yannick Cote <ycote@redhat.com>
---
 lib/livepatch/test_klp_shadow_vars.c | 43 ++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/lib/livepatch/test_klp_shadow_vars.c b/lib/livepatch/test_klp_shadow_vars.c
index a49265e56917..b99116490858 100644
--- a/lib/livepatch/test_klp_shadow_vars.c
+++ b/lib/livepatch/test_klp_shadow_vars.c
@@ -170,6 +170,7 @@ static int test_klp_shadow_vars_init(void)
 	char *pndup[NUM_OBJS];
 	int nfields2[NUM_OBJS], *pnfields2[NUM_OBJS], **sv2[NUM_OBJS];
 	void **sv;
+	int ret;
 	int i;
 
 	ptr_id(NULL);
@@ -196,31 +197,39 @@ static int test_klp_shadow_vars_init(void)
 					sizeof(pnfields1[i]), GFP_KERNEL,
 					shadow_ctor, &pnfields1[i]);
 		}
-		if (!sv1[i])
-			return -ENOMEM;
+		if (!sv1[i]) {
+			ret = -ENOMEM;
+			goto out;
+		}
 
 		pnfields2[i] = &nfields2[i];
 		ptr_id(pnfields2[i]);
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
 	for (i = 0; i < NUM_OBJS; i++) {
 		/* check the "char" svar for all objects */
 		sv = shadow_get(&objs[i], SV_ID1);
-		if (!sv)
-			return -EINVAL;
+		if (!sv) {
+			ret = -EINVAL;
+			goto out;
+		}
 		if ((char **)sv == sv1[i] && *sv1[i] == pnfields1[i])
 			pr_info("  got expected PTR%d -> PTR%d result\n",
 				ptr_id(sv1[i]), ptr_id(*sv1[i]));
 
 		/* check the "int" svar for all objects */
 		sv = shadow_get(&objs[i], SV_ID2);
-		if (!sv)
-			return -EINVAL;
+		if (!sv) {
+			ret = -EINVAL;
+			goto out;
+		}
 		if ((int **)sv == sv2[i] && *sv2[i] == pnfields2[i])
 			pr_info("  got expected PTR%d -> PTR%d result\n",
 				ptr_id(sv2[i]), ptr_id(*sv2[i]));
@@ -233,8 +242,10 @@ static int test_klp_shadow_vars_init(void)
 
 		sv = shadow_get_or_alloc(&objs[i], SV_ID1, sizeof(pndup[i]),
 					GFP_KERNEL, shadow_ctor, &pndup[i]);
-		if (!sv)
-			return -EINVAL;
+		if (!sv) {
+			ret = -EINVAL;
+			goto out;
+		}
 		if ((char **)sv == sv1[i] && *sv1[i] == pnfields1[i])
 			pr_info("  got expected PTR%d -> PTR%d result\n",
 					ptr_id(sv1[i]), ptr_id(*sv1[i]));
@@ -251,8 +262,10 @@ static int test_klp_shadow_vars_init(void)
 	/* pass 5: check we still find <objs[*], SV_ID2> svar pairs */
 	for (i = 0; i < NUM_OBJS; i++) {
 		sv = shadow_get(&objs[i], SV_ID2);	/* 'int' pairs */
-		if (!sv)
-			return -EINVAL;
+		if (!sv) {
+			ret = -EINVAL;
+			goto out;
+		}
 		if ((int **)sv == sv2[i] && *sv2[i] == pnfields2[i])
 			pr_info("  got expected PTR%d -> PTR%d result\n",
 					ptr_id(sv2[i]), ptr_id(*sv2[i]));
@@ -269,6 +282,12 @@ static int test_klp_shadow_vars_init(void)
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

