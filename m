Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BA466B315
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjAORXr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjAORXo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:23:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AF710AA3;
        Sun, 15 Jan 2023 09:23:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ED3060D2C;
        Sun, 15 Jan 2023 17:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A0AC433EF;
        Sun, 15 Jan 2023 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803421;
        bh=qVzt1jHN+EhmQ/GRuEFyNjj/9cUcd2N0QYpzN2a7xBk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R6t+SLGjMrkbtJwbzlea0Bc5RNRfe6hFTnzWQSLDdrU52DZz6vJsp1VCyYDYhfEc9
         EZ3Buw0e+Y447Z2XiUVB7kPB1Dlt+N87goZna7+5LDNhebj7l9jefgZm9JPipe5sQ2
         S6OAdxaQoL/MvocZUuy8W2hqVj5zE6EtOMtlKsujC+kwgW2uUnda0ZS9qZg/WJPn1l
         IGXqo50FTlfnGVjICZurB24Y24btHi3s0RAgLn8O1Nr0936XgW7PvUCWg+96+AsYg6
         ADP49cSaqmTeamjMDykl7gCu0vZthrtvLqJbj8bwKeh4RN1XrDICjEYglaXcFWYntv
         XP+AEftN3b6Ng==
Subject: [PATCH v2 32/41] SUNRPC: Export get_gss_krb5_enctype()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:23:40 -0500
Message-ID: <167380342067.10651.16290196714057748447.stgit@bazille.1015granger.net>
In-Reply-To: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

I plan to add KUnit tests that will need enctype profile
information. Export the enctype profile lookup function.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_internal.h |    1 +
 net/sunrpc/auth_gss/gss_krb5_mech.c     |   35 ++++++++++++++-----------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 9aba1647c205..cca4026f986d 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -216,6 +216,7 @@ u32 krb5_etm_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 
 #if IS_ENABLED(CONFIG_KUNIT)
 void krb5_nfold(u32 inbits, const u8 *in, u32 outbits, u8 *out);
+const struct gss_krb5_enctype *gss_krb5_lookup_enctype(u32 etype);
 #endif
 
 #endif /* _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 5909fef97d27..20e21d08badb 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -19,6 +19,7 @@
 #include <linux/sunrpc/auth.h>
 #include <linux/sunrpc/gss_krb5.h>
 #include <linux/sunrpc/xdr.h>
+#include <kunit/visibility.h>
 
 #include "auth_gss_internal.h"
 #include "gss_krb5_internal.h"
@@ -309,28 +310,24 @@ static void gss_krb5_prepare_enctype_priority_list(void)
 	}
 }
 
-static const int num_supported_enctypes =
-	ARRAY_SIZE(supported_gss_krb5_enctypes);
-
-static int
-supported_gss_krb5_enctype(int etype)
+/**
+ * gss_krb5_lookup_enctype - Retrieve profile information for a given enctype
+ * @etype: ENCTYPE value
+ *
+ * Returns a pointer to a gss_krb5_enctype structure, or NULL if no
+ * matching etype is found.
+ */
+VISIBLE_IF_KUNIT
+const struct gss_krb5_enctype *gss_krb5_lookup_enctype(u32 etype)
 {
-	int i;
-	for (i = 0; i < num_supported_enctypes; i++)
-		if (supported_gss_krb5_enctypes[i].etype == etype)
-			return 1;
-	return 0;
-}
+	size_t i;
 
-static const struct gss_krb5_enctype *
-get_gss_krb5_enctype(int etype)
-{
-	int i;
-	for (i = 0; i < num_supported_enctypes; i++)
+	for (i = 0; i < ARRAY_SIZE(supported_gss_krb5_enctypes); i++)
 		if (supported_gss_krb5_enctypes[i].etype == etype)
 			return &supported_gss_krb5_enctypes[i];
 	return NULL;
 }
+EXPORT_SYMBOL_IF_KUNIT(gss_krb5_lookup_enctype);
 
 static struct crypto_sync_skcipher *
 gss_krb5_alloc_cipher_v1(struct krb5_ctx *ctx, struct xdr_netobj *key)
@@ -366,7 +363,7 @@ get_key(const void *p, const void *end,
 		alg = ENCTYPE_DES_CBC_RAW;
 		break;
 	}
-	if (!supported_gss_krb5_enctype(alg)) {
+	if (!gss_krb5_lookup_enctype(alg)) {
 		pr_warn("gss_krb5: unsupported enctype: %d\n", alg);
 		goto out_err_inval;
 	}
@@ -405,7 +402,7 @@ gss_import_v1_context(const void *p, const void *end, struct krb5_ctx *ctx)
 	/* Old format supports only DES!  Any other enctype uses new format */
 	ctx->enctype = ENCTYPE_DES_CBC_RAW;
 
-	ctx->gk5e = get_gss_krb5_enctype(ctx->enctype);
+	ctx->gk5e = gss_krb5_lookup_enctype(ctx->enctype);
 	if (ctx->gk5e == NULL) {
 		p = ERR_PTR(-EINVAL);
 		goto out_err;
@@ -677,7 +674,7 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 	/* Map ENCTYPE_DES3_CBC_SHA1 to ENCTYPE_DES3_CBC_RAW */
 	if (ctx->enctype == ENCTYPE_DES3_CBC_SHA1)
 		ctx->enctype = ENCTYPE_DES3_CBC_RAW;
-	ctx->gk5e = get_gss_krb5_enctype(ctx->enctype);
+	ctx->gk5e = gss_krb5_lookup_enctype(ctx->enctype);
 	if (ctx->gk5e == NULL) {
 		dprintk("gss_kerberos_mech: unsupported krb5 enctype %u\n",
 			ctx->enctype);


