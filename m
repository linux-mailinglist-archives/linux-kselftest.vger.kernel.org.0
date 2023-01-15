Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5A66B2D8
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjAORUj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjAORUi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:20:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA1E1041B;
        Sun, 15 Jan 2023 09:20:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ACF860D45;
        Sun, 15 Jan 2023 17:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298F8C433EF;
        Sun, 15 Jan 2023 17:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803236;
        bh=KldhuGSYRC2SS9/MNT62J+Rs6IstRysPw1wIfoosjFA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=loRMtL26zcQt5S2HJLc+TZP4Vdnzg6jv0QbXRL7aNbKwb46SK+W94h38w1cCab5Xj
         aBMUkpSq9KrXsOcRsdDI8ySgPq7cLXLT+sCl7clPxjTSwp5lCtokSdFneNshu7J+Jz
         rG4xOZ922lpJqF/O3CdwjYMCt8MrZ788ewnzLmXiePewMr0KsegvBvIWPttUi894Ol
         ArcjXD3Rk6vIrBdj8eQ5DBrQA/Tj/9BGP+l6T57cWrmDPxzMHL/jmHinATbpUNVkq0
         Yci4s8EqHZxU3+Yu++N1qS+w3jtNJEQWNa5lHes3FsCAkAfcw0gnocNnJ//TzCKQbl
         FljDIE9j8wVAw==
Subject: [PATCH v2 03/41] SUNRPC: Remove .conflen field from struct
 gss_krb5_enctype
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:20:35 -0500
Message-ID: <167380323522.10651.400594527559998778.stgit@bazille.1015granger.net>
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

Now that arcfour-hmac is gone, the confounder length is again the
same as the cipher blocksize for every implemented enctype. The
gss_krb5_enctype::conflen field is no longer necessary.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h       |    3 ---
 net/sunrpc/auth_gss/gss_krb5_crypto.c |    9 +++++----
 net/sunrpc/auth_gss/gss_krb5_mech.c   |    4 ----
 net/sunrpc/auth_gss/gss_krb5_wrap.c   |    4 ++--
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 9a833825b55b..51860e3a0216 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -64,9 +64,6 @@ struct gss_krb5_enctype {
 	const char		*cksum_name;	/* crypto checksum name */
 	const u16		signalg;	/* signing algorithm */
 	const u16		sealalg;	/* sealing algorithm */
-	const u32		conflen;	/* confounder length
-						   (normally the same as
-						   the blocksize) */
 	const u32		cksumlength;	/* checksum length */
 	const u32		keyed_cksum;	/* is it a keyed cksum? */
 	const u32		keybytes;	/* raw key len, in bytes */
diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 3ea58175e159..8aa5610ef660 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -610,6 +610,7 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 	struct encryptor_desc desc;
 	u32 cbcbytes;
 	unsigned int usage;
+	unsigned int conflen;
 
 	if (kctx->initiate) {
 		cipher = kctx->initiator_enc;
@@ -623,12 +624,13 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 		usage = KG_USAGE_ACCEPTOR_SEAL;
 	}
 	blocksize = crypto_sync_skcipher_blocksize(cipher);
+	conflen = crypto_sync_skcipher_blocksize(cipher);
 
 	/* hide the gss token header and insert the confounder */
 	offset += GSS_KRB5_TOK_HDR_LEN;
-	if (xdr_extend_head(buf, offset, kctx->gk5e->conflen))
+	if (xdr_extend_head(buf, offset, conflen))
 		return GSS_S_FAILURE;
-	gss_krb5_make_confounder(buf->head[0].iov_base + offset, kctx->gk5e->conflen);
+	gss_krb5_make_confounder(buf->head[0].iov_base + offset, conflen);
 	offset -= GSS_KRB5_TOK_HDR_LEN;
 
 	if (buf->tail[0].iov_base != NULL) {
@@ -744,7 +746,6 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 	}
 	blocksize = crypto_sync_skcipher_blocksize(cipher);
 
-
 	/* create a segment skipping the header and leaving out the checksum */
 	xdr_buf_subsegment(buf, &subbuf, offset + GSS_KRB5_TOK_HDR_LEN,
 				    (len - offset - GSS_KRB5_TOK_HDR_LEN -
@@ -801,7 +802,7 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 		ret = GSS_S_BAD_SIG;
 		goto out_err;
 	}
-	*headskip = kctx->gk5e->conflen;
+	*headskip = blocksize;
 	*tailskip = kctx->gk5e->cksumlength;
 out_err:
 	if (ret && ret != GSS_S_BAD_SIG)
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index dd85fc9ca80b..08a86ece665e 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -47,7 +47,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .sealalg = SEAL_ALG_DES,
 	  .keybytes = 7,
 	  .keylength = 8,
-	  .conflen = 8,
 	  .cksumlength = 8,
 	  .keyed_cksum = 0,
 	},
@@ -68,7 +67,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .sealalg = SEAL_ALG_DES3KD,
 	  .keybytes = 21,
 	  .keylength = 24,
-	  .conflen = 8,
 	  .cksumlength = 20,
 	  .keyed_cksum = 1,
 	},
@@ -90,7 +88,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .sealalg = -1,
 	  .keybytes = 16,
 	  .keylength = 16,
-	  .conflen = 16,
 	  .cksumlength = 12,
 	  .keyed_cksum = 1,
 	},
@@ -112,7 +109,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .sealalg = -1,
 	  .keybytes = 32,
 	  .keylength = 32,
-	  .conflen = 16,
 	  .cksumlength = 12,
 	  .keyed_cksum = 1,
 	},
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index 48337687848c..bd068e936947 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -168,7 +168,7 @@ gss_wrap_kerberos_v1(struct krb5_ctx *kctx, int offset,
 	struct page		**tmp_pages;
 	u32			seq_send;
 	u8			*cksumkey;
-	u32			conflen = kctx->gk5e->conflen;
+	u32			conflen = crypto_sync_skcipher_blocksize(kctx->enc);
 
 	dprintk("RPC:       %s\n", __func__);
 
@@ -261,7 +261,7 @@ gss_unwrap_kerberos_v1(struct krb5_ctx *kctx, int offset, int len,
 	void			*data_start, *orig_start;
 	int			data_len;
 	int			blocksize;
-	u32			conflen = kctx->gk5e->conflen;
+	u32			conflen = crypto_sync_skcipher_blocksize(kctx->enc);
 	int			crypt_offset;
 	u8			*cksumkey;
 	unsigned int		saved_len = buf->len;


