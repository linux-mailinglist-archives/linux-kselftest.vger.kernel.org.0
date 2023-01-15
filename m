Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B920D66B312
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjAORXe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjAORXd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:23:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA03D1041F;
        Sun, 15 Jan 2023 09:23:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63242B80B40;
        Sun, 15 Jan 2023 17:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C22C433F0;
        Sun, 15 Jan 2023 17:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803409;
        bh=mKINwWTR8WTVY9DFaNiqoFfR0ztBjU88mhl2U8cmLNU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ao4rj+Kmv42ji6pDYhZXQ1Vy+C7s3J8v2UBetluP1OvZ3TUqQCg1cLj51ew9Jmek7
         4jfwVku13sQpzTEV2/n4VWCOgTtGvIG50fgVbZeOaznJrvVfFcnuCjBNXHnpClscHu
         mrFUVxUdQuSS2HER9b3CFbA3u01e+GfW5CibeP2o41whFVUR0NN/z54QZ5v2EeTplh
         rZqgNvZ9Wh6fYHbJi8zXJopg9JPySc+d1E7yeS7RZ786v7z/3hIWUhDcSwdySgbOwr
         I1SRkzMKRJk5q5KEF02p32KiCKjMhssQLue0PonDzDkga5jCyu7tTOF9VDt3ShSNN0
         ke7+rPsMGgpjg==
Subject: [PATCH v2 30/41] SUNRPC: Move remaining internal definitions to
 gss_krb5_internal.h
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:23:27 -0500
Message-ID: <167380340784.10651.13072870050177651658.stgit@bazille.1015granger.net>
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

The goal is to leave only protocol-defined items in gss_krb5.h so
that it can be easily replaced by a generic header. Implementation
specific items are moved to the new internal header.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h         |  117 -------------------------------
 net/sunrpc/auth_gss/auth_gss.c          |   17 +++++
 net/sunrpc/auth_gss/gss_krb5_crypto.c   |    1 
 net/sunrpc/auth_gss/gss_krb5_internal.h |   94 +++++++++++++++++++++++++
 4 files changed, 111 insertions(+), 118 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index cbb6c8192890..78a80bf3fdcb 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -42,12 +42,6 @@
 #include <linux/sunrpc/gss_err.h>
 #include <linux/sunrpc/gss_asn1.h>
 
-/*
- * The RFCs often specify payload lengths in bits. This helper
- * converts a specified bit-length to the number of octets/bytes.
- */
-#define BITS2OCTETS(x)	((x) / 8)
-
 /* Length of constant used in key derivation */
 #define GSS_KRB5_K5CLENGTH (5)
 
@@ -60,74 +54,6 @@
 /* Maximum blocksize for the supported crypto algorithms */
 #define GSS_KRB5_MAX_BLOCKSIZE  (16)
 
-struct krb5_ctx;
-
-struct gss_krb5_enctype {
-	const u32		etype;		/* encryption (key) type */
-	const u32		ctype;		/* checksum type */
-	const char		*name;		/* "friendly" name */
-	const char		*encrypt_name;	/* crypto encrypt name */
-	const char		*aux_cipher;	/* aux encrypt cipher name */
-	const char		*cksum_name;	/* crypto checksum name */
-	const u16		signalg;	/* signing algorithm */
-	const u16		sealalg;	/* sealing algorithm */
-	const u32		cksumlength;	/* checksum length */
-	const u32		keyed_cksum;	/* is it a keyed cksum? */
-	const u32		keybytes;	/* raw key len, in bytes */
-	const u32		keylength;	/* protocol key length, in octets */
-	const u32		Kc_length;	/* checksum subkey length, in octets */
-	const u32		Ke_length;	/* encryption subkey length, in octets */
-	const u32		Ki_length;	/* integrity subkey length, in octets */
-
-	int (*import_ctx)(struct krb5_ctx *ctx, gfp_t gfp_mask);
-	int (*derive_key)(const struct gss_krb5_enctype *gk5e,
-			  const struct xdr_netobj *in,
-			  struct xdr_netobj *out,
-			  const struct xdr_netobj *label,
-			  gfp_t gfp_mask);
-	u32 (*encrypt)(struct krb5_ctx *kctx, u32 offset,
-			struct xdr_buf *buf, struct page **pages);
-	u32 (*decrypt)(struct krb5_ctx *kctx, u32 offset, u32 len,
-		       struct xdr_buf *buf, u32 *headskip, u32 *tailskip);
-	u32 (*get_mic)(struct krb5_ctx *kctx, struct xdr_buf *text,
-		       struct xdr_netobj *token);
-	u32 (*verify_mic)(struct krb5_ctx *kctx, struct xdr_buf *message_buffer,
-			  struct xdr_netobj *read_token);
-	u32 (*wrap)(struct krb5_ctx *kctx, int offset,
-		    struct xdr_buf *buf, struct page **pages);
-	u32 (*unwrap)(struct krb5_ctx *kctx, int offset, int len,
-		      struct xdr_buf *buf, unsigned int *slack,
-		      unsigned int *align);
-};
-
-/* krb5_ctx flags definitions */
-#define KRB5_CTX_FLAG_INITIATOR         0x00000001
-#define KRB5_CTX_FLAG_CFX               0x00000002
-#define KRB5_CTX_FLAG_ACCEPTOR_SUBKEY   0x00000004
-
-struct krb5_ctx {
-	int			initiate; /* 1 = initiating, 0 = accepting */
-	u32			enctype;
-	u32			flags;
-	const struct gss_krb5_enctype *gk5e; /* enctype-specific info */
-	struct crypto_sync_skcipher *enc;
-	struct crypto_sync_skcipher *seq;
-	struct crypto_sync_skcipher *acceptor_enc;
-	struct crypto_sync_skcipher *initiator_enc;
-	struct crypto_sync_skcipher *acceptor_enc_aux;
-	struct crypto_sync_skcipher *initiator_enc_aux;
-	struct crypto_ahash	*acceptor_sign;
-	struct crypto_ahash	*initiator_sign;
-	struct crypto_ahash	*initiator_integ;
-	struct crypto_ahash	*acceptor_integ;
-	u8			Ksess[GSS_KRB5_MAX_KEYLEN]; /* session key */
-	u8			cksum[GSS_KRB5_MAX_KEYLEN];
-	atomic_t		seq_send;
-	atomic64_t		seq_send64;
-	time64_t		endtime;
-	struct xdr_netobj	mech_used;
-};
-
 /* The length of the Kerberos GSS token header */
 #define GSS_KRB5_TOK_HDR_LEN	(16)
 
@@ -245,47 +171,4 @@ enum seal_alg {
 #define KG_USAGE_INITIATOR_SEAL (24)
 #define KG_USAGE_INITIATOR_SIGN (25)
 
-/*
- * This compile-time check verifies that we will not exceed the
- * slack space allotted by the client and server auth_gss code
- * before they call gss_wrap().
- */
-#define GSS_KRB5_MAX_SLACK_NEEDED \
-	(GSS_KRB5_TOK_HDR_LEN     /* gss token header */         \
-	+ GSS_KRB5_MAX_CKSUM_LEN  /* gss token checksum */       \
-	+ GSS_KRB5_MAX_BLOCKSIZE  /* confounder */               \
-	+ GSS_KRB5_MAX_BLOCKSIZE  /* possible padding */         \
-	+ GSS_KRB5_TOK_HDR_LEN    /* encrypted hdr in v2 token */\
-	+ GSS_KRB5_MAX_CKSUM_LEN  /* encryption hmac */          \
-	+ 4 + 4                   /* RPC verifier */             \
-	+ GSS_KRB5_TOK_HDR_LEN                                   \
-	+ GSS_KRB5_MAX_CKSUM_LEN)
-
-u32
-make_checksum(struct krb5_ctx *kctx, char *header, int hdrlen,
-		struct xdr_buf *body, int body_offset, u8 *cksumkey,
-		unsigned int usage, struct xdr_netobj *cksumout);
-
-int
-gss_encrypt_xdr_buf(struct crypto_sync_skcipher *tfm, struct xdr_buf *outbuf,
-		    int offset, struct page **pages);
-
-int
-gss_decrypt_xdr_buf(struct crypto_sync_skcipher *tfm, struct xdr_buf *inbuf,
-		    int offset);
-
-s32
-krb5_make_seq_num(struct krb5_ctx *kctx,
-		struct crypto_sync_skcipher *key,
-		int direction,
-		u32 seqnum, unsigned char *cksum, unsigned char *buf);
-
-s32
-krb5_get_seq_num(struct krb5_ctx *kctx,
-	       unsigned char *cksum,
-	       unsigned char *buf, int *direction, u32 *seqnum);
-
-int
-xdr_extend_head(struct xdr_buf *buf, unsigned int base, unsigned int shiftlen);
-
 #endif /* _LINUX_SUNRPC_GSS_KRB5_H */
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 2d7b1e03110a..1af71fbb0d80 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -49,6 +49,22 @@ static unsigned int gss_key_expire_timeo = GSS_KEY_EXPIRE_TIMEO;
 # define RPCDBG_FACILITY	RPCDBG_AUTH
 #endif
 
+/*
+ * This compile-time check verifies that we will not exceed the
+ * slack space allotted by the client and server auth_gss code
+ * before they call gss_wrap().
+ */
+#define GSS_KRB5_MAX_SLACK_NEEDED					\
+	(GSS_KRB5_TOK_HDR_LEN		/* gss token header */		\
+	+ GSS_KRB5_MAX_CKSUM_LEN	/* gss token checksum */	\
+	+ GSS_KRB5_MAX_BLOCKSIZE	/* confounder */		\
+	+ GSS_KRB5_MAX_BLOCKSIZE	/* possible padding */		\
+	+ GSS_KRB5_TOK_HDR_LEN		/* encrypted hdr in v2 token */	\
+	+ GSS_KRB5_MAX_CKSUM_LEN	/* encryption hmac */		\
+	+ XDR_UNIT * 2			/* RPC verifier */		\
+	+ GSS_KRB5_TOK_HDR_LEN						\
+	+ GSS_KRB5_MAX_CKSUM_LEN)
+
 #define GSS_CRED_SLACK		(RPC_MAX_AUTH_SIZE * 2)
 /* length of a krb5 verifier (48), plus data added before arguments when
  * using integrity (two 4-byte integers): */
@@ -1042,6 +1058,7 @@ gss_create_new(const struct rpc_auth_create_args *args, struct rpc_clnt *clnt)
 		goto err_put_mech;
 	auth = &gss_auth->rpc_auth;
 	auth->au_cslack = GSS_CRED_SLACK >> 2;
+	BUILD_BUG_ON(GSS_KRB5_MAX_SLACK_NEEDED > RPC_MAX_AUTH_SIZE);
 	auth->au_rslack = GSS_KRB5_MAX_SLACK_NEEDED >> 2;
 	auth->au_verfsize = GSS_VERF_SLACK >> 2;
 	auth->au_ralign = GSS_VERF_SLACK >> 2;
diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 4f29216d414a..5c811b554fd1 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -572,7 +572,6 @@ xdr_extend_head(struct xdr_buf *buf, unsigned int base, unsigned int shiftlen)
 	if (shiftlen == 0)
 		return 0;
 
-	BUILD_BUG_ON(GSS_KRB5_MAX_SLACK_NEEDED > RPC_MAX_AUTH_SIZE);
 	BUG_ON(shiftlen > RPC_MAX_AUTH_SIZE);
 
 	p = buf->head[0].iov_base + base;
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index c955e7b76c4d..850748f6733a 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -8,6 +8,79 @@
 #ifndef _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
 #define _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
 
+/*
+ * The RFCs often specify payload lengths in bits. This helper
+ * converts a specified bit-length to the number of octets/bytes.
+ */
+#define BITS2OCTETS(x)	((x) / 8)
+
+struct krb5_ctx;
+
+struct gss_krb5_enctype {
+	const u32		etype;		/* encryption (key) type */
+	const u32		ctype;		/* checksum type */
+	const char		*name;		/* "friendly" name */
+	const char		*encrypt_name;	/* crypto encrypt name */
+	const char		*aux_cipher;	/* aux encrypt cipher name */
+	const char		*cksum_name;	/* crypto checksum name */
+	const u16		signalg;	/* signing algorithm */
+	const u16		sealalg;	/* sealing algorithm */
+	const u32		cksumlength;	/* checksum length */
+	const u32		keyed_cksum;	/* is it a keyed cksum? */
+	const u32		keybytes;	/* raw key len, in bytes */
+	const u32		keylength;	/* protocol key length, in octets */
+	const u32		Kc_length;	/* checksum subkey length, in octets */
+	const u32		Ke_length;	/* encryption subkey length, in octets */
+	const u32		Ki_length;	/* integrity subkey length, in octets */
+
+	int (*import_ctx)(struct krb5_ctx *ctx, gfp_t gfp_mask);
+	int (*derive_key)(const struct gss_krb5_enctype *gk5e,
+			  const struct xdr_netobj *in,
+			  struct xdr_netobj *out,
+			  const struct xdr_netobj *label,
+			  gfp_t gfp_mask);
+	u32 (*encrypt)(struct krb5_ctx *kctx, u32 offset,
+		       struct xdr_buf *buf, struct page **pages);
+	u32 (*decrypt)(struct krb5_ctx *kctx, u32 offset, u32 len,
+		       struct xdr_buf *buf, u32 *headskip, u32 *tailskip);
+	u32 (*get_mic)(struct krb5_ctx *kctx, struct xdr_buf *text,
+		       struct xdr_netobj *token);
+	u32 (*verify_mic)(struct krb5_ctx *kctx, struct xdr_buf *message_buffer,
+			  struct xdr_netobj *read_token);
+	u32 (*wrap)(struct krb5_ctx *kctx, int offset,
+		    struct xdr_buf *buf, struct page **pages);
+	u32 (*unwrap)(struct krb5_ctx *kctx, int offset, int len,
+		      struct xdr_buf *buf, unsigned int *slack,
+		      unsigned int *align);
+};
+
+/* krb5_ctx flags definitions */
+#define KRB5_CTX_FLAG_INITIATOR         0x00000001
+#define KRB5_CTX_FLAG_ACCEPTOR_SUBKEY   0x00000004
+
+struct krb5_ctx {
+	int			initiate; /* 1 = initiating, 0 = accepting */
+	u32			enctype;
+	u32			flags;
+	const struct gss_krb5_enctype *gk5e; /* enctype-specific info */
+	struct crypto_sync_skcipher *enc;
+	struct crypto_sync_skcipher *seq;
+	struct crypto_sync_skcipher *acceptor_enc;
+	struct crypto_sync_skcipher *initiator_enc;
+	struct crypto_sync_skcipher *acceptor_enc_aux;
+	struct crypto_sync_skcipher *initiator_enc_aux;
+	struct crypto_ahash	*acceptor_sign;
+	struct crypto_ahash	*initiator_sign;
+	struct crypto_ahash	*initiator_integ;
+	struct crypto_ahash	*acceptor_integ;
+	u8			Ksess[GSS_KRB5_MAX_KEYLEN]; /* session key */
+	u8			cksum[GSS_KRB5_MAX_KEYLEN];
+	atomic_t		seq_send;
+	atomic64_t		seq_send64;
+	time64_t		endtime;
+	struct xdr_netobj	mech_used;
+};
+
 /*
  * GSS Kerberos 5 mechanism Per-Message calls.
  */
@@ -96,8 +169,19 @@ static inline int krb5_derive_key(struct krb5_ctx *kctx,
 	return gk5e->derive_key(gk5e, inkey, outkey, &label, gfp_mask);
 }
 
+s32 krb5_make_seq_num(struct krb5_ctx *kctx, struct crypto_sync_skcipher *key,
+		      int direction, u32 seqnum, unsigned char *cksum,
+		      unsigned char *buf);
+
+s32 krb5_get_seq_num(struct krb5_ctx *kctx, unsigned char *cksum,
+		     unsigned char *buf, int *direction, u32 *seqnum);
+
 void krb5_make_confounder(u8 *p, int conflen);
 
+u32 make_checksum(struct krb5_ctx *kctx, char *header, int hdrlen,
+		  struct xdr_buf *body, int body_offset, u8 *cksumkey,
+		  unsigned int usage, struct xdr_netobj *cksumout);
+
 u32 gss_krb5_checksum(struct crypto_ahash *tfm, char *header, int hdrlen,
 		      const struct xdr_buf *body, int body_offset,
 		      struct xdr_netobj *cksumout);
@@ -108,6 +192,16 @@ u32 krb5_encrypt(struct crypto_sync_skcipher *key, void *iv, void *in,
 u32 krb5_decrypt(struct crypto_sync_skcipher *key, void *iv, void *in,
 		 void *out, int length);
 
+int xdr_extend_head(struct xdr_buf *buf, unsigned int base,
+		    unsigned int shiftlen);
+
+int gss_encrypt_xdr_buf(struct crypto_sync_skcipher *tfm,
+			struct xdr_buf *outbuf, int offset,
+			struct page **pages);
+
+int gss_decrypt_xdr_buf(struct crypto_sync_skcipher *tfm,
+			struct xdr_buf *inbuf, int offset);
+
 u32 gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 			 struct xdr_buf *buf, struct page **pages);
 


