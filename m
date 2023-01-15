Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB79766B2F3
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjAORV4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjAORVz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:21:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DF610AA7;
        Sun, 15 Jan 2023 09:21:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3C3F60D2E;
        Sun, 15 Jan 2023 17:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2E3C433EF;
        Sun, 15 Jan 2023 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803313;
        bh=k6v9foTxeesiel4wzya0SOENV5jsG0ViAHigsfTOyUg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uz8Hc/zbU5HSyNdtxZxPJXIAnWEXBLDYcKeRKZHgk51sP++Spr4iVvowxNTPdBpOr
         +6obdLTM8cOTnWHNykRNcp3XXcT55JzOqL1YCb8pk9wuVDHWo/N92woSC1KDL98UTk
         3WYQ6BHtAGTFUJsiTPXGLhPzwFR+FlwPGwwm7OnTL40cdq9+GORX+fXrnprRsusjao
         yHAAUBvMyS/rCTITCtlqmHYWBkm+WABitQUMQG1GTVhJdkTxoZt9GKFjd9Y4ZorT1p
         Kt3YgoSfECua3ArwgzJDYRqd1hFTSvo03AuIm9mX8t9r9kE6sLoNNv9/iZywoIPFVs
         /Mg6D6UDiIL1A==
Subject: [PATCH v2 15/41] SUNRPC: Enable rpcsec_gss_krb5.ko to be built
 without CRYPTO_DES
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:21:52 -0500
Message-ID: <167380331214.10651.11224254824457738270.stgit@bazille.1015granger.net>
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

Because the DES block cipher has been deprecated by Internet
standard, highly secure configurations might require that DES
support be blacklisted or not installed. NFS Kerberos should still
be able to work correctly with only the AES-based enctypes in that
situation.

Also note that MIT Kerberos has begun a deprecation process for DES
encryption types. Their README for 1.19.3 states:

> Beginning with the krb5-1.19 release, a warning will be issued
> if initial credentials are acquired using the des3-cbc-sha1
> encryption type.  In future releases, this encryption type will
> be disabled by default and eventually removed.
>
> Beginning with the krb5-1.18 release, single-DES encryption
> types have been removed.

Aside from the CONFIG option name change, there are two important
policy changes:

1. The 'insecure enctype' group is now disabled by default.
   Distributors have to take action to enable support for deprecated
   enctypes. Implementation of these enctypes will be removed in a
   future kernel release.

2. des3-cbc-sha1 is now considered part of the 'insecure enctype'
   group, having been deprecated by RFC 8429, and is thus disabled
   by default

After this patch is applied, SunRPC support can be built with
Kerberos 5 support but without CRYPTO_DES enabled in the kernel.
And, when these enctypes are disabled, the Linux kernel's SunRPC
RPCSEC GSS implementation fully complies with BCP 179 / RFC 6649
and BCP 218 / RFC 8429.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/Kconfig                    |   54 +++++++++++++++++++++--------
 net/sunrpc/auth_gss/gss_krb5_mech.c   |   27 +++++++++++---
 net/sunrpc/auth_gss/gss_krb5_seal.c   |   62 ++++++++++++++++++---------------
 net/sunrpc/auth_gss/gss_krb5_unseal.c |    3 +-
 net/sunrpc/auth_gss/gss_krb5_wrap.c   |    4 ++
 5 files changed, 101 insertions(+), 49 deletions(-)

diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
index bbbb5af0af13..1135ff362132 100644
--- a/net/sunrpc/Kconfig
+++ b/net/sunrpc/Kconfig
@@ -19,10 +19,10 @@ config SUNRPC_SWAP
 config RPCSEC_GSS_KRB5
 	tristate "Secure RPC: Kerberos V mechanism"
 	depends on SUNRPC && CRYPTO
-	depends on CRYPTO_MD5 && CRYPTO_DES && CRYPTO_CBC && CRYPTO_CTS
-	depends on CRYPTO_ECB && CRYPTO_HMAC && CRYPTO_SHA1 && CRYPTO_AES
 	default y
 	select SUNRPC_GSS
+	select CRYPTO_SKCIPHER
+	select CRYPTO_HASH
 	help
 	  Choose Y here to enable Secure RPC using the Kerberos version 5
 	  GSS-API mechanism (RFC 1964).
@@ -34,21 +34,47 @@ config RPCSEC_GSS_KRB5
 
 	  If unsure, say Y.
 
-config SUNRPC_DISABLE_INSECURE_ENCTYPES
-	bool "Secure RPC: Disable insecure Kerberos encryption types"
+config RPCSEC_GSS_KRB5_SIMPLIFIED
+	bool
+	depends on RPCSEC_GSS_KRB5
+
+config RPCSEC_GSS_KRB5_CRYPTOSYSTEM
+	bool
+	depends on RPCSEC_GSS_KRB5
+
+config RPCSEC_GSS_KRB5_ENCTYPES_DES
+	bool "Enable Kerberos enctypes based on DES (deprecated)"
 	depends on RPCSEC_GSS_KRB5
+	depends on CRYPTO_CBC && CRYPTO_CTS && CRYPTO_ECB
+	depends on CRYPTO_HMAC && CRYPTO_MD5 && CRYPTO_SHA1
+	depends on CRYPTO_DES
 	default n
+	select RPCSEC_GSS_KRB5_SIMPLIFIED
+	help
+	  Choose Y to enable the use of deprecated Kerberos 5
+	  encryption types that utilize Data Encryption Standard
+	  (DES) based ciphers. These include des-cbc-md5,
+	  des-cbc-crc, and des-cbc-md4, which were deprecated by
+	  RFC 6649, and des3-cbc-sha1, which was deprecated by RFC
+	  8429.
+
+	  Support for these encryption types is available for
+	  compatibility with legacy NFS client and server
+	  implementations. The default is N which is more secure.
+
+config RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1
+	bool "Enable Kerberos enctypes based on AES and SHA-1"
+	depends on RPCSEC_GSS_KRB5
+	depends on CRYPTO_CBC && CRYPTO_CTS
+	depends on CRYPTO_HMAC && CRYPTO_SHA1
+	depends on CRYPTO_AES
+	default y
+	select RPCSEC_GSS_KRB5_CRYPTOSYSTEM
 	help
-	  Choose Y here to disable the use of deprecated encryption types
-	  with the Kerberos version 5 GSS-API mechanism (RFC 1964). The
-	  deprecated encryption types include DES-CBC-MD5, DES-CBC-CRC,
-	  and DES-CBC-MD4. These types were deprecated by RFC 6649 because
-	  they were found to be insecure.
-
-	  N is the default because many sites have deployed KDCs and
-	  keytabs that contain only these deprecated encryption types.
-	  Choosing Y prevents the use of known-insecure encryption types
-	  but might result in compatibility problems.
+	  Choose Y to enable the use of Kerberos 5 encryption types
+	  that utilize Advanced Encryption Standard (AES) ciphers and
+	  SHA-1 digests. These include aes128-cts-hmac-sha1-96 and
+	  aes256-cts-hmac-sha1-96.
 
 config SUNRPC_DEBUG
 	bool "RPC: Enable dprintk debugging"
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 2553d18fd288..9ddc6fc7077f 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -29,12 +29,16 @@
 
 static struct gss_api_mech gss_kerberos_mech;
 
+#if defined(CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED)
 static int gss_krb5_import_ctx_des(struct krb5_ctx *ctx, gfp_t gfp_mask);
 static int gss_krb5_import_ctx_v1(struct krb5_ctx *ctx, gfp_t gfp_mask);
+#endif
+#if defined(CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM)
 static int gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask);
+#endif
 
 static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
-#ifndef CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES
+#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES)
 	/*
 	 * DES (All DES enctypes are mapped to the same gss functionality)
 	 */
@@ -59,7 +63,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .cksumlength = 8,
 	  .keyed_cksum = 0,
 	},
-#endif	/* CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES */
 	/*
 	 * 3DES
 	 */
@@ -84,8 +87,11 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .cksumlength = 20,
 	  .keyed_cksum = 1,
 	},
+#endif
+
+#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1)
 	/*
-	 * AES128
+	 * AES-128 with SHA-1 (RFC 3962)
 	 */
 	{
 	  .etype = ENCTYPE_AES128_CTS_HMAC_SHA1_96,
@@ -114,7 +120,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .keyed_cksum = 1,
 	},
 	/*
-	 * AES256
+	 * AES-256 with SHA-1 (RFC 3962)
 	 */
 	{
 	  .etype = ENCTYPE_AES256_CTS_HMAC_SHA1_96,
@@ -142,6 +148,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .cksumlength = 12,
 	  .keyed_cksum = 1,
 	},
+#endif
 };
 
 /*
@@ -153,10 +160,12 @@ static char gss_krb5_enctype_priority_list[64];
 static void gss_krb5_prepare_enctype_priority_list(void)
 {
 	static const u32 gss_krb5_enctypes[] = {
+#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1)
 		ENCTYPE_AES256_CTS_HMAC_SHA1_96,
 		ENCTYPE_AES128_CTS_HMAC_SHA1_96,
+#endif
+#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES)
 		ENCTYPE_DES3_CBC_SHA1,
-#ifndef CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES
 		ENCTYPE_DES_CBC_MD5,
 		ENCTYPE_DES_CBC_CRC,
 		ENCTYPE_DES_CBC_MD4,
@@ -337,7 +346,7 @@ gss_import_v1_context(const void *p, const void *end, struct krb5_ctx *ctx)
 	return PTR_ERR(p);
 }
 
-static struct crypto_sync_skcipher *
+static inline struct crypto_sync_skcipher *
 context_v2_alloc_cipher(struct krb5_ctx *ctx, const char *cname, u8 *key)
 {
 	struct crypto_sync_skcipher *cp;
@@ -367,6 +376,7 @@ set_cdata(u8 cdata[GSS_KRB5_K5CLENGTH], u32 usage, u8 seed)
 	cdata[4] = seed;
 }
 
+#if defined(CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED)
 static int
 gss_krb5_import_ctx_des(struct krb5_ctx *ctx, gfp_t gfp_mask)
 {
@@ -417,6 +427,9 @@ gss_krb5_import_ctx_v1(struct krb5_ctx *ctx, gfp_t gfp_mask)
 out_err:
 	return -EINVAL;
 }
+#endif
+
+#if defined(CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM)
 
 static struct crypto_ahash *
 gss_krb5_alloc_hash_v2(struct krb5_ctx *kctx, const struct xdr_netobj *key)
@@ -551,6 +564,8 @@ gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	goto out;
 }
 
+#endif
+
 static int
 gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 		gfp_t gfp_mask)
diff --git a/net/sunrpc/auth_gss/gss_krb5_seal.c b/net/sunrpc/auth_gss/gss_krb5_seal.c
index f74125407588..146aa755f07d 100644
--- a/net/sunrpc/auth_gss/gss_krb5_seal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_seal.c
@@ -71,6 +71,8 @@
 # define RPCDBG_FACILITY        RPCDBG_AUTH
 #endif
 
+#if defined(CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED)
+
 static void *
 setup_token(struct krb5_ctx *ctx, struct xdr_netobj *token)
 {
@@ -97,34 +99,6 @@ setup_token(struct krb5_ctx *ctx, struct xdr_netobj *token)
 	return krb5_hdr;
 }
 
-static void *
-setup_token_v2(struct krb5_ctx *ctx, struct xdr_netobj *token)
-{
-	u16 *ptr;
-	void *krb5_hdr;
-	u8 *p, flags = 0x00;
-
-	if ((ctx->flags & KRB5_CTX_FLAG_INITIATOR) == 0)
-		flags |= 0x01;
-	if (ctx->flags & KRB5_CTX_FLAG_ACCEPTOR_SUBKEY)
-		flags |= 0x04;
-
-	/* Per rfc 4121, sec 4.2.6.1, there is no header,
-	 * just start the token */
-	krb5_hdr = ptr = (u16 *)token->data;
-
-	*ptr++ = KG2_TOK_MIC;
-	p = (u8 *)ptr;
-	*p++ = flags;
-	*p++ = 0xff;
-	ptr = (u16 *)p;
-	*ptr++ = 0xffff;
-	*ptr = 0xffff;
-
-	token->len = GSS_KRB5_TOK_HDR_LEN + ctx->gk5e->cksumlength;
-	return krb5_hdr;
-}
-
 u32
 gss_krb5_get_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *text,
 		    struct xdr_netobj *token)
@@ -164,6 +138,38 @@ gss_krb5_get_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *text,
 	return (ctx->endtime < now) ? GSS_S_CONTEXT_EXPIRED : GSS_S_COMPLETE;
 }
 
+#endif
+
+static void *
+setup_token_v2(struct krb5_ctx *ctx, struct xdr_netobj *token)
+{
+	u16 *ptr;
+	void *krb5_hdr;
+	u8 *p, flags = 0x00;
+
+	if ((ctx->flags & KRB5_CTX_FLAG_INITIATOR) == 0)
+		flags |= 0x01;
+	if (ctx->flags & KRB5_CTX_FLAG_ACCEPTOR_SUBKEY)
+		flags |= 0x04;
+
+	/* Per rfc 4121, sec 4.2.6.1, there is no header,
+	 * just start the token.
+	 */
+	krb5_hdr = (u16 *)token->data;
+	ptr = krb5_hdr;
+
+	*ptr++ = KG2_TOK_MIC;
+	p = (u8 *)ptr;
+	*p++ = flags;
+	*p++ = 0xff;
+	ptr = (u16 *)p;
+	*ptr++ = 0xffff;
+	*ptr = 0xffff;
+
+	token->len = GSS_KRB5_TOK_HDR_LEN + ctx->gk5e->cksumlength;
+	return krb5_hdr;
+}
+
 u32
 gss_krb5_get_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *text,
 		    struct xdr_netobj *token)
diff --git a/net/sunrpc/auth_gss/gss_krb5_unseal.c b/net/sunrpc/auth_gss/gss_krb5_unseal.c
index 939d199eb7b7..7d6d4ae4a3c9 100644
--- a/net/sunrpc/auth_gss/gss_krb5_unseal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_unseal.c
@@ -70,9 +70,9 @@
 #endif
 
 
+#if defined(CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED)
 /* read_token is a mic token, and message_buffer is the data that the mic was
  * supposedly taken over. */
-
 u32
 gss_krb5_verify_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *message_buffer,
 		       struct xdr_netobj *read_token)
@@ -144,6 +144,7 @@ gss_krb5_verify_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *message_buffer,
 
 	return GSS_S_COMPLETE;
 }
+#endif
 
 u32
 gss_krb5_verify_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *message_buffer,
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index d983da6f9530..7dabf379406b 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -40,6 +40,8 @@
 # define RPCDBG_FACILITY	RPCDBG_AUTH
 #endif
 
+#if defined(CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED)
+
 static inline int
 gss_krb5_padding(int blocksize, int length)
 {
@@ -323,6 +325,8 @@ gss_krb5_unwrap_v1(struct krb5_ctx *kctx, int offset, int len,
 	return GSS_S_COMPLETE;
 }
 
+#endif
+
 /*
  * We can shift data by up to LOCAL_BUF_LEN bytes in a pass.  If we need
  * to do more than that, we shift repeatedly.  Kevin Coffman reports


