Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF895A4038
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 02:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiH2AJu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Aug 2022 20:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiH2AJt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Aug 2022 20:09:49 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A4E2734;
        Sun, 28 Aug 2022 17:09:48 -0700 (PDT)
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mx0.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4MG9mX1DtHzDr8x;
        Mon, 29 Aug 2022 00:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1661731788; bh=ThcwD+/ARB/097HCNk/WNN4lmuiNd29bmbeq+JVzaCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h5tUqD2ZwNaJzFNdPNOm/AWpG+I3jFVLHriqritRMoIf/WVAKnrZN6U7hIN+UE8gd
         C0qNJA8Y/jtfzZG2Z7ykTjnjUzI5C+yT4VJhUG1bcwiw4x9zyS9ZTJVYQjThvjt0OS
         8hwgQyzed8NVDotjysWRmhHoRDX2INC1EUNlPwFc=
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MG9mV3Bksz9sNj;
        Mon, 29 Aug 2022 00:09:46 +0000 (UTC)
X-Riseup-User-ID: 1F040BCC012FFF67A8C1706CE96F24ADEEA8BC2421AAF385962892E6DB1139C9
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4MG9mP0Z0Tz5vTc;
        Mon, 29 Aug 2022 00:09:40 +0000 (UTC)
From:   Isabella Basso <isabbasso@riseup.net>
To:     igt-dev@lists.freedesktop.org
Cc:     magalilemes00@gmail.com, maira.canal@usp.br,
        tales.aparecida@gmail.com, rodrigo.siqueira@amd.com,
        mwen@igalia.com, andrealmeid@riseup.net, twoerner@gmail.com,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        kunit-dev@googlegroups.com, davidgow@google.com,
        dlatypov@google.com, brendanhiggins@google.com, daniel@ffwll.ch,
        skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel@fooishbar.org,
        linux-kernel@vger.kernel.org, Isabella Basso <isabbasso@riseup.net>
Subject: [PATCH i-g-t v2 1/4] lib/igt_kmod: rename kselftest functions to ktest
Date:   Sun, 28 Aug 2022 21:09:17 -0300
Message-Id: <20220829000920.38185-2-isabbasso@riseup.net>
In-Reply-To: <20220829000920.38185-1-isabbasso@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This aims at making IGT's structure more general to different kernel
testing frameworks such as KUnit, as they use a lot of the same
functionality.

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 lib/igt_kmod.c | 22 +++++++++++-----------
 lib/igt_kmod.h | 12 ++++++------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib/igt_kmod.c b/lib/igt_kmod.c
index bcf7dfeb..bb6cb7bb 100644
--- a/lib/igt_kmod.c
+++ b/lib/igt_kmod.c
@@ -718,8 +718,8 @@ static int open_parameters(const char *module_name)
 	return open(path, O_RDONLY);
 }
 
-int igt_kselftest_init(struct igt_kselftest *tst,
-		       const char *module_name)
+int igt_ktest_init(struct igt_ktest *tst,
+		   const char *module_name)
 {
 	int err;
 
@@ -738,7 +738,7 @@ int igt_kselftest_init(struct igt_kselftest *tst,
 	return 0;
 }
 
-int igt_kselftest_begin(struct igt_kselftest *tst)
+int igt_ktest_begin(struct igt_ktest *tst)
 {
 	int err;
 
@@ -753,7 +753,7 @@ int igt_kselftest_begin(struct igt_kselftest *tst)
 	return 0;
 }
 
-int igt_kselftest_execute(struct igt_kselftest *tst,
+int igt_kselftest_execute(struct igt_ktest *tst,
 			  struct igt_kselftest_list *tl,
 			  const char *options,
 			  const char *result)
@@ -791,13 +791,13 @@ int igt_kselftest_execute(struct igt_kselftest *tst,
 	return err;
 }
 
-void igt_kselftest_end(struct igt_kselftest *tst)
+void igt_ktest_end(struct igt_ktest *tst)
 {
 	kmod_module_remove_module(tst->kmod, KMOD_REMOVE_FORCE);
 	close(tst->kmsg);
 }
 
-void igt_kselftest_fini(struct igt_kselftest *tst)
+void igt_ktest_fini(struct igt_ktest *tst)
 {
 	free(tst->module_name);
 	kmod_module_unref(tst->kmod);
@@ -820,15 +820,15 @@ void igt_kselftests(const char *module_name,
 		    const char *result,
 		    const char *filter)
 {
-	struct igt_kselftest tst;
+	struct igt_ktest tst;
 	IGT_LIST_HEAD(tests);
 	struct igt_kselftest_list *tl, *tn;
 
-	if (igt_kselftest_init(&tst, module_name) != 0)
+	if (igt_ktest_init(&tst, module_name) != 0)
 		return;
 
 	igt_fixture
-		igt_require(igt_kselftest_begin(&tst) == 0);
+		igt_require(igt_ktest_begin(&tst) == 0);
 
 	igt_kselftest_get_tests(tst.kmod, filter, &tests);
 	igt_subtest_with_dynamic(filter ?: "all") {
@@ -847,9 +847,9 @@ void igt_kselftests(const char *module_name,
 	}
 
 	igt_fixture {
-		igt_kselftest_end(&tst);
+		igt_ktest_end(&tst);
 		igt_require(!igt_list_empty(&tests));
 	}
 
-	igt_kselftest_fini(&tst);
+	igt_ktest_fini(&tst);
 }
diff --git a/lib/igt_kmod.h b/lib/igt_kmod.h
index f98dd29f..ceb10cd0 100644
--- a/lib/igt_kmod.h
+++ b/lib/igt_kmod.h
@@ -50,7 +50,7 @@ void igt_kselftests(const char *module_name,
 		    const char *result_option,
 		    const char *filter);
 
-struct igt_kselftest {
+struct igt_ktest {
 	struct kmod_module *kmod;
 	char *module_name;
 	int kmsg;
@@ -63,19 +63,19 @@ struct igt_kselftest_list {
 	char param[];
 };
 
-int igt_kselftest_init(struct igt_kselftest *tst,
+int igt_ktest_init(struct igt_ktest *tst,
 		       const char *module_name);
-int igt_kselftest_begin(struct igt_kselftest *tst);
+int igt_ktest_begin(struct igt_ktest *tst);
 
 void igt_kselftest_get_tests(struct kmod_module *kmod,
 			     const char *filter,
 			     struct igt_list_head *tests);
-int igt_kselftest_execute(struct igt_kselftest *tst,
+int igt_kselftest_execute(struct igt_ktest *tst,
 			  struct igt_kselftest_list *tl,
 			  const char *module_options,
 			  const char *result);
 
-void igt_kselftest_end(struct igt_kselftest *tst);
-void igt_kselftest_fini(struct igt_kselftest *tst);
+void igt_ktest_end(struct igt_ktest *tst);
+void igt_ktest_fini(struct igt_ktest *tst);
 
 #endif /* IGT_KMOD_H */
-- 
2.37.2

