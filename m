Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F3566B2DA
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjAORUp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjAORUp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:20:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3431041B;
        Sun, 15 Jan 2023 09:20:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B0F060DB5;
        Sun, 15 Jan 2023 17:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977D7C433D2;
        Sun, 15 Jan 2023 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803242;
        bh=XYLaOEodGsQbFQ9E+PCCk73XsY8nJhVw0O/zK8/OpyQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HdyCDPgdRBxQ0/zGeGbdr+anex062letgWr7JNJ5aNjHcHq0XQg99Xdn+HhWH5t8b
         E7CwhYzikNimbgrGXEZc0kMUH5PtBqWAAq8EXkd8xAkXDB4yvGp7xQWUlfce7n+TNi
         HIV1IJR+cjJ/vVBedVDGZRu5rrFX6Nw1XnvsvmLC7LQVzTbnphYQ6uLut9/Up07BHd
         dwhnBC3eO5s4u16U0VQo1sqPu7PXdGPxYhWpD6tZsoBFwLoZP6f0tvq4qbhO4o+J6Z
         A7Vc1OdznyO/K0MHtEHcUZyO6TC9nL02T0hXaClRru+JUljqBWPxbI6G9njD5S3/Nl
         6lwaxrr35FCtw==
Subject: [PATCH v2 04/41] SUNRPC: Improve Kerberos confounder generation
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:20:41 -0500
Message-ID: <167380324165.10651.5190772356076504121.stgit@bazille.1015granger.net>
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

Other common Kerberos implementations use a fully random confounder
for encryption. The reason for this is explained in the new comment
added by this patch. The current get_random_bytes() implementation
does not exhaust system entropy.

Since confounder generation is part of Kerberos itself rather than
the GSS-API Kerberos mechanism, the function is renamed and moved.

Note that light top-down analysis shows that the SHA-1 transform
is by far the most CPU-intensive part of encryption. Thus we do not
expect this change to result in a significant performance impact.
However, eventually it might be necessary to generate an independent
stream of confounders for each Kerberos context to help improve I/O
parallelism.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h         |    3 --
 net/sunrpc/auth_gss/gss_krb5_crypto.c   |   33 ++++++++++++++++++++++++++-
 net/sunrpc/auth_gss/gss_krb5_internal.h |   13 +++++++++++
 net/sunrpc/auth_gss/gss_krb5_mech.c     |   15 ++++++------
 net/sunrpc/auth_gss/gss_krb5_wrap.c     |   38 ++-----------------------------
 5 files changed, 55 insertions(+), 47 deletions(-)
 create mode 100644 net/sunrpc/auth_gss/gss_krb5_internal.h

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 51860e3a0216..f0fac1e69731 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -311,7 +311,4 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 		     struct xdr_buf *buf, u32 *plainoffset,
 		     u32 *plainlen);
 
-void
-gss_krb5_make_confounder(char *p, u32 conflen);
-
 #endif /* _LINUX_SUNRPC_GSS_KRB5_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 8aa5610ef660..7c06c11e452c 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -47,10 +47,41 @@
 #include <linux/sunrpc/gss_krb5.h>
 #include <linux/sunrpc/xdr.h>
 
+#include "gss_krb5_internal.h"
+
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define RPCDBG_FACILITY        RPCDBG_AUTH
 #endif
 
+/**
+ * krb5_make_confounder - Generate a confounder string
+ * @p: memory location into which to write the string
+ * @conflen: string length to write, in octets
+ *
+ * RFCs 1964 and 3961 mention only "a random confounder" without going
+ * into detail about its function or cryptographic requirements. The
+ * assumed purpose is to prevent repeated encryption of a plaintext with
+ * the same key from generating the same ciphertext. It is also used to
+ * pad minimum plaintext length to at least a single cipher block.
+ *
+ * However, in situations like the GSS Kerberos 5 mechanism, where the
+ * encryption IV is always all zeroes, the confounder also effectively
+ * functions like an IV. Thus, not only must it be unique from message
+ * to message, but it must also be difficult to predict. Otherwise an
+ * attacker can correlate the confounder to previous or future values,
+ * making the encryption easier to break.
+ *
+ * Given that the primary consumer of this encryption mechanism is a
+ * network storage protocol, a type of traffic that often carries
+ * predictable payloads (eg, all zeroes when reading unallocated blocks
+ * from a file), our confounder generation has to be cryptographically
+ * strong.
+ */
+void krb5_make_confounder(u8 *p, int conflen)
+{
+	get_random_bytes(p, conflen);
+}
+
 u32
 krb5_encrypt(
 	struct crypto_sync_skcipher *tfm,
@@ -630,7 +661,7 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 	offset += GSS_KRB5_TOK_HDR_LEN;
 	if (xdr_extend_head(buf, offset, conflen))
 		return GSS_S_FAILURE;
-	gss_krb5_make_confounder(buf->head[0].iov_base + offset, conflen);
+	krb5_make_confounder(buf->head[0].iov_base + offset, conflen);
 	offset -= GSS_KRB5_TOK_HDR_LEN;
 
 	if (buf->tail[0].iov_base != NULL) {
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
new file mode 100644
index 000000000000..16a83d507075
--- /dev/null
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * SunRPC GSS Kerberos 5 mechanism internal definitions
+ *
+ * Copyright (c) 2022 Oracle and/or its affiliates.
+ */
+
+#ifndef _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
+#define _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
+
+void krb5_make_confounder(u8 *p, int conflen);
+
+#endif /* _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 08a86ece665e..76a0d83fe500 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -550,16 +550,15 @@ gss_import_sec_context_kerberos(const void *p, size_t len,
 		ret = gss_import_v1_context(p, end, ctx);
 	else
 		ret = gss_import_v2_context(p, end, ctx, gfp_mask);
-
-	if (ret == 0) {
-		ctx_id->internal_ctx_id = ctx;
-		if (endtime)
-			*endtime = ctx->endtime;
-	} else
+	if (ret) {
 		kfree(ctx);
+		return ret;
+	}
 
-	dprintk("RPC:       %s: returning %d\n", __func__, ret);
-	return ret;
+	ctx_id->internal_ctx_id = ctx;
+	if (endtime)
+		*endtime = ctx->endtime;
+	return 0;
 }
 
 static void
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index bd068e936947..66e65e4c6336 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -32,9 +32,10 @@
 #include <linux/types.h>
 #include <linux/jiffies.h>
 #include <linux/sunrpc/gss_krb5.h>
-#include <linux/random.h>
 #include <linux/pagemap.h>
 
+#include "gss_krb5_internal.h"
+
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define RPCDBG_FACILITY	RPCDBG_AUTH
 #endif
@@ -113,39 +114,6 @@ gss_krb5_remove_padding(struct xdr_buf *buf, int blocksize)
 	return 0;
 }
 
-void
-gss_krb5_make_confounder(char *p, u32 conflen)
-{
-	static u64 i = 0;
-	u64 *q = (u64 *)p;
-
-	/* rfc1964 claims this should be "random".  But all that's really
-	 * necessary is that it be unique.  And not even that is necessary in
-	 * our case since our "gssapi" implementation exists only to support
-	 * rpcsec_gss, so we know that the only buffers we will ever encrypt
-	 * already begin with a unique sequence number.  Just to hedge my bets
-	 * I'll make a half-hearted attempt at something unique, but ensuring
-	 * uniqueness would mean worrying about atomicity and rollover, and I
-	 * don't care enough. */
-
-	/* initialize to random value */
-	if (i == 0) {
-		i = get_random_u32();
-		i = (i << 32) | get_random_u32();
-	}
-
-	switch (conflen) {
-	case 16:
-		*q++ = i++;
-		fallthrough;
-	case 8:
-		*q++ = i++;
-		break;
-	default:
-		BUG();
-	}
-}
-
 /* Assumptions: the head and tail of inbuf are ours to play with.
  * The pages, however, may be real pages in the page cache and we replace
  * them with scratch pages from **pages before writing to them. */
@@ -211,7 +179,7 @@ gss_wrap_kerberos_v1(struct krb5_ctx *kctx, int offset,
 	ptr[6] = 0xff;
 	ptr[7] = 0xff;
 
-	gss_krb5_make_confounder(msg_start, conflen);
+	krb5_make_confounder(msg_start, conflen);
 
 	if (kctx->gk5e->keyed_cksum)
 		cksumkey = kctx->cksum;


