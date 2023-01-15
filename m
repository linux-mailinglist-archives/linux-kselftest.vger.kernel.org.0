Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB2C66B30D
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjAORXT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjAORXS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:23:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF431041F;
        Sun, 15 Jan 2023 09:23:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD81D60D45;
        Sun, 15 Jan 2023 17:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06503C433D2;
        Sun, 15 Jan 2023 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803396;
        bh=LmMrJ6qUWZCOaQx5ed8wvwY5cYeiSzsbmkKA7w0WmdE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e3nuc17V7fy1ZtcwXdh7vqG3qO8iFBjmxa3EtVRuDOwJpIBfJZBCDwPz4M22WwqWf
         Tis5JBPMuhF8ywzMZ4PQ6y7ILg0zcqQfA1x+PGDjFsy+++c0rn0iBNFulXSt8BiLXu
         cIwRDRh5to37nqo61ZhzxOdrZ32LZ3aV4JNTRAnfTL9FCrxVmuYvcDfFL5ZgaFZWEb
         HuG0gXMYlUXCGFkRWsaHV+4yvZ2LM3vF9qyHIxIAn3lWGhQljh84vMyKcZh05RKb5f
         H5xDLKbpmajcuFRlMEXplYW4ePB+WkGVXZh2WpsCVvEhcJBPi99ef1fwhitAf56Df1
         cGdrg3WUDwYiQ==
Subject: [PATCH v2 28/41] SUNRPC: Add KDF_FEEDBACK_CMAC
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:23:15 -0500
Message-ID: <167380339507.10651.4493706192657375677.stgit@bazille.1015granger.net>
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

The Camellia enctypes use the KDF_FEEDBACK_CMAC Key Derivation
Function defined in RFC 6803 Section 3.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_internal.h |    6 +
 net/sunrpc/auth_gss/gss_krb5_keys.c     |  143 +++++++++++++++++++++++++++++++
 net/sunrpc/auth_gss/gss_krb5_mech.c     |    2 
 3 files changed, 151 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index fd2ae11c5067..c955e7b76c4d 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -58,6 +58,12 @@ int krb5_kdf_hmac_sha2(const struct gss_krb5_enctype *gk5e,
 		       const struct xdr_netobj *in_constant,
 		       gfp_t gfp_mask);
 
+int krb5_kdf_feedback_cmac(const struct gss_krb5_enctype *gk5e,
+			   const struct xdr_netobj *inkey,
+			   struct xdr_netobj *outkey,
+			   const struct xdr_netobj *in_constant,
+			   gfp_t gfp_mask);
+
 /**
  * krb5_derive_key - Derive a subkey from a protocol key
  * @kctx: Kerberos 5 context
diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
index 724be20f5417..99251f15723a 100644
--- a/net/sunrpc/auth_gss/gss_krb5_keys.c
+++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
@@ -363,6 +363,149 @@ int krb5_derive_key_v2(const struct gss_krb5_enctype *gk5e,
 	return ret;
 }
 
+/*
+ * K(i) = CMAC(key, K(i-1) | i | constant | 0x00 | k)
+ *
+ *    i: A block counter is used with a length of 4 bytes, represented
+ *       in big-endian order.
+ *
+ *    constant: The label input to the KDF is the usage constant supplied
+ *              to the key derivation function
+ *
+ *    k: The length of the output key in bits, represented as a 4-byte
+ *       string in big-endian order.
+ *
+ * Caller fills in K(i-1) in @step, and receives the result K(i)
+ * in the same buffer.
+ */
+static int
+krb5_cmac_Ki(struct crypto_shash *tfm, const struct xdr_netobj *constant,
+	     u32 outlen, u32 count, struct xdr_netobj *step)
+{
+	__be32 k = cpu_to_be32(outlen * 8);
+	SHASH_DESC_ON_STACK(desc, tfm);
+	__be32 i = cpu_to_be32(count);
+	u8 zero = 0;
+	int ret;
+
+	desc->tfm = tfm;
+	ret = crypto_shash_init(desc);
+	if (ret)
+		goto out_err;
+
+	ret = crypto_shash_update(desc, step->data, step->len);
+	if (ret)
+		goto out_err;
+	ret = crypto_shash_update(desc, (u8 *)&i, sizeof(i));
+	if (ret)
+		goto out_err;
+	ret = crypto_shash_update(desc, constant->data, constant->len);
+	if (ret)
+		goto out_err;
+	ret = crypto_shash_update(desc, &zero, sizeof(zero));
+	if (ret)
+		goto out_err;
+	ret = crypto_shash_update(desc, (u8 *)&k, sizeof(k));
+	if (ret)
+		goto out_err;
+	ret = crypto_shash_final(desc, step->data);
+	if (ret)
+		goto out_err;
+
+out_err:
+	shash_desc_zero(desc);
+	return ret;
+}
+
+/**
+ * krb5_kdf_feedback_cmac - Derive a subkey for a Camellia/CMAC-based enctype
+ * @gk5e: Kerberos 5 enctype parameters
+ * @inkey: base protocol key
+ * @outkey: OUT: derived key
+ * @constant: subkey usage label
+ * @gfp_mask: memory allocation control flags
+ *
+ * RFC 6803 Section 3:
+ *
+ * "We use a key derivation function from the family specified in
+ *  [SP800-108], Section 5.2, 'KDF in Feedback Mode'."
+ *
+ *	n = ceiling(k / 128)
+ *	K(0) = zeros
+ *	K(i) = CMAC(key, K(i-1) | i | constant | 0x00 | k)
+ *	DR(key, constant) = k-truncate(K(1) | K(2) | ... | K(n))
+ *	KDF-FEEDBACK-CMAC(key, constant) = random-to-key(DR(key, constant))
+ *
+ * Caller sets @outkey->len to the desired length of the derived key (k).
+ *
+ * On success, returns 0 and fills in @outkey. A negative errno value
+ * is returned on failure.
+ */
+int
+krb5_kdf_feedback_cmac(const struct gss_krb5_enctype *gk5e,
+		       const struct xdr_netobj *inkey,
+		       struct xdr_netobj *outkey,
+		       const struct xdr_netobj *constant,
+		       gfp_t gfp_mask)
+{
+	struct xdr_netobj step = { .data = NULL };
+	struct xdr_netobj DR = { .data = NULL };
+	unsigned int blocksize, offset;
+	struct crypto_shash *tfm;
+	int n, count, ret;
+
+	/*
+	 * This implementation assumes the CMAC used for an enctype's
+	 * key derivation is the same as the CMAC used for its
+	 * checksumming. This happens to be true for enctypes that
+	 * are currently supported by this implementation.
+	 */
+	tfm = crypto_alloc_shash(gk5e->cksum_name, 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto out;
+	}
+	ret = crypto_shash_setkey(tfm, inkey->data, inkey->len);
+	if (ret)
+		goto out_free_tfm;
+
+	blocksize = crypto_shash_digestsize(tfm);
+	n = (outkey->len + blocksize - 1) / blocksize;
+
+	/* K(0) is all zeroes */
+	ret = -ENOMEM;
+	step.len = blocksize;
+	step.data = kzalloc(step.len, gfp_mask);
+	if (!step.data)
+		goto out_free_tfm;
+
+	DR.len = blocksize * n;
+	DR.data = kmalloc(DR.len, gfp_mask);
+	if (!DR.data)
+		goto out_free_tfm;
+
+	/* XXX: Does not handle partial-block key sizes */
+	for (offset = 0, count = 1; count <= n; count++) {
+		ret = krb5_cmac_Ki(tfm, constant, outkey->len, count, &step);
+		if (ret)
+			goto out_free_tfm;
+
+		memcpy(DR.data + offset, step.data, blocksize);
+		offset += blocksize;
+	}
+
+	/* k-truncate and random-to-key */
+	memcpy(outkey->data, DR.data, outkey->len);
+	ret = 0;
+
+out_free_tfm:
+	crypto_free_shash(tfm);
+out:
+	kfree_sensitive(step.data);
+	kfree_sensitive(DR.data);
+	return ret;
+}
+
 /*
  * K1 = HMAC-SHA(key, 0x00000001 | label | 0x00 | k)
  *
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 4e7cb49a06de..e616ec536265 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -166,6 +166,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ki_length	= BITS2OCTETS(128),
 
 		.import_ctx	= gss_krb5_import_ctx_v2,
+		.derive_key	= krb5_kdf_feedback_cmac,
 		.encrypt	= gss_krb5_aes_encrypt,
 		.decrypt	= gss_krb5_aes_decrypt,
 
@@ -192,6 +193,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ki_length	= BITS2OCTETS(256),
 
 		.import_ctx	= gss_krb5_import_ctx_v2,
+		.derive_key	= krb5_kdf_feedback_cmac,
 		.encrypt	= gss_krb5_aes_encrypt,
 		.decrypt	= gss_krb5_aes_decrypt,
 


