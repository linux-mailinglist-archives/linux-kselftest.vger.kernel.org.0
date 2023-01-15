Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7836566B305
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjAORWz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjAORWy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:22:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D5876BB;
        Sun, 15 Jan 2023 09:22:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EBDAB80B40;
        Sun, 15 Jan 2023 17:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866CDC433D2;
        Sun, 15 Jan 2023 17:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803370;
        bh=AEvxD1qTDxgDvD0h9nzEie2XrwiRsq2DBLINywC9D+s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=phV8QowMdWLSyx8VrY6102EDuPJzjWqra6JTkuD5D7eXt2jiVoEUUWVzxBsdKjfEd
         8bT29paLoJqorheESUCHhF2/u21WBol6OXZD3eXsc48P0mmNU7UPw/O2uZg8jK1427
         s0Y8J9MYx6DU+TJSXLZKYy9VxAVIHpsq/A9X9KpkfWXwM4rE2vOYi6HnA5vy7/4luX
         hyP8TJndLarUJLGh0/s4RBNW5Gh5mV2/qmlnyX9wKIxvLx6UBsbFAdf/Yj/lQM2TIg
         eOsJSwAlGMcylk063/MZb50McVHmp6EkVa47bQzwt1I2mcOP3WCoM6DpPp1znNZdaI
         rR2S7eEeKXvcQ==
Subject: [PATCH v2 24/41] SUNRPC: Add KDF-HMAC-SHA2
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:22:49 -0500
Message-ID: <167380336964.10651.5771747130886462331.stgit@bazille.1015granger.net>
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

The RFC 8009 encryption types use a different key derivation
function than the RFC 3962 encryption types. The new key derivation
function is defined in Section 3 of RFC 8009.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_internal.h |    6 ++
 net/sunrpc/auth_gss/gss_krb5_keys.c     |  117 +++++++++++++++++++++++++++++++
 net/sunrpc/auth_gss/gss_krb5_mech.c     |    2 +
 3 files changed, 125 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index c7580026adc7..33abf9ee9508 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -52,6 +52,12 @@ int krb5_derive_key_v2(const struct gss_krb5_enctype *gk5e,
 		       const struct xdr_netobj *label,
 		       gfp_t gfp_mask);
 
+int krb5_kdf_hmac_sha2(const struct gss_krb5_enctype *gk5e,
+		       const struct xdr_netobj *inkey,
+		       struct xdr_netobj *outkey,
+		       const struct xdr_netobj *in_constant,
+		       gfp_t gfp_mask);
+
 /**
  * krb5_derive_key - Derive a subkey from a protocol key
  * @kctx: Kerberos 5 context
diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
index f6de4fdd63ae..724be20f5417 100644
--- a/net/sunrpc/auth_gss/gss_krb5_keys.c
+++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
@@ -60,6 +60,7 @@
 #include <linux/sunrpc/gss_krb5.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/lcm.h>
+#include <crypto/hash.h>
 
 #include "gss_krb5_internal.h"
 
@@ -361,3 +362,119 @@ int krb5_derive_key_v2(const struct gss_krb5_enctype *gk5e,
 	kfree_sensitive(inblock.data);
 	return ret;
 }
+
+/*
+ * K1 = HMAC-SHA(key, 0x00000001 | label | 0x00 | k)
+ *
+ *    key: The source of entropy from which subsequent keys are derived.
+ *
+ *    label: An octet string describing the intended usage of the
+ *    derived key.
+ *
+ *    k: Length in bits of the key to be outputted, expressed in
+ *    big-endian binary representation in 4 bytes.
+ */
+static int
+krb5_hmac_K1(struct crypto_shash *tfm, const struct xdr_netobj *label,
+	     u32 outlen, struct xdr_netobj *K1)
+{
+	__be32 k = cpu_to_be32(outlen * 8);
+	SHASH_DESC_ON_STACK(desc, tfm);
+	__be32 one = cpu_to_be32(1);
+	u8 zero = 0;
+	int ret;
+
+	desc->tfm = tfm;
+	ret = crypto_shash_init(desc);
+	if (ret)
+		goto out_err;
+	ret = crypto_shash_update(desc, (u8 *)&one, sizeof(one));
+	if (ret)
+		goto out_err;
+	ret = crypto_shash_update(desc, label->data, label->len);
+	if (ret)
+		goto out_err;
+	ret = crypto_shash_update(desc, &zero, sizeof(zero));
+	if (ret)
+		goto out_err;
+	ret = crypto_shash_update(desc, (u8 *)&k, sizeof(k));
+	if (ret)
+		goto out_err;
+	ret = crypto_shash_final(desc, K1->data);
+	if (ret)
+		goto out_err;
+
+out_err:
+	shash_desc_zero(desc);
+	return ret;
+}
+
+/**
+ * krb5_kdf_hmac_sha2 - Derive a subkey for an AES/SHA2-based enctype
+ * @gk5e: Kerberos 5 enctype policy parameters
+ * @inkey: base protocol key
+ * @outkey: OUT: derived key
+ * @label: subkey usage label
+ * @gfp_mask: memory allocation control flags
+ *
+ * RFC 8009 Section 3:
+ *
+ *  "We use a key derivation function from Section 5.1 of [SP800-108],
+ *   which uses the HMAC algorithm as the PRF."
+ *
+ *	function KDF-HMAC-SHA2(key, label, [context,] k):
+ *		k-truncate(K1)
+ *
+ * Caller sets @outkey->len to the desired length of the derived key.
+ *
+ * On success, returns 0 and fills in @outkey. A negative errno value
+ * is returned on failure.
+ */
+int
+krb5_kdf_hmac_sha2(const struct gss_krb5_enctype *gk5e,
+		   const struct xdr_netobj *inkey,
+		   struct xdr_netobj *outkey,
+		   const struct xdr_netobj *label,
+		   gfp_t gfp_mask)
+{
+	struct crypto_shash *tfm;
+	struct xdr_netobj K1 = {
+		.data = NULL,
+	};
+	int ret;
+
+	/*
+	 * This implementation assumes the HMAC used for an enctype's
+	 * key derivation is the same as the HMAC used for its
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
+	K1.len = crypto_shash_digestsize(tfm);
+	K1.data = kmalloc(K1.len, gfp_mask);
+	if (!K1.data) {
+		ret = -ENOMEM;
+		goto out_free_tfm;
+	}
+
+	ret = krb5_hmac_K1(tfm, label, outkey->len, &K1);
+	if (ret)
+		goto out_free_tfm;
+
+	/* k-truncate and random-to-key */
+	memcpy(outkey->data, K1.data, outkey->len);
+
+out_free_tfm:
+	kfree_sensitive(K1.data);
+	crypto_free_shash(tfm);
+out:
+	return ret;
+}
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 1951867f3fa8..b55897cac459 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -166,6 +166,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ki_length	= BITS2OCTETS(128),
 
 		.import_ctx	= gss_krb5_import_ctx_v2,
+		.derive_key	= krb5_kdf_hmac_sha2,
 
 		.get_mic	= gss_krb5_get_mic_v2,
 		.verify_mic	= gss_krb5_verify_mic_v2,
@@ -190,6 +191,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ki_length	= BITS2OCTETS(192),
 
 		.import_ctx	= gss_krb5_import_ctx_v2,
+		.derive_key	= krb5_kdf_hmac_sha2,
 
 		.get_mic	= gss_krb5_get_mic_v2,
 		.verify_mic	= gss_krb5_verify_mic_v2,


