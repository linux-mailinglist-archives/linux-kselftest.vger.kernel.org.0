Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6F166B326
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjAORYf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjAORYf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:24:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D8476BB;
        Sun, 15 Jan 2023 09:24:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7665C60C74;
        Sun, 15 Jan 2023 17:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83770C433D2;
        Sun, 15 Jan 2023 17:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803472;
        bh=g2vqFPxGPa80RO1ZjyhtaQ5lnSwEWWqLohUaQXFH7rM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VP5uaw7jJ8ROFAx19poGyLDRKi9gjJU/BRbgyRz0dy40HY0/ImdWrcth3a3mChviX
         EOpvv5J6wVEMzkl73j7OcbeRr4cvitSnBHggkjxTTnOk5sOIZC6wvcBYnYD+XCfg+j
         TrJ+MCqKPwpmOxdMCQkw8aaztKbjJEF1jFYMRju0fC24ckzET0i4hf1kMKX4vho2tW
         VRKida+rccuFD1R+lSUYdYSYuyYUaxf8MDSTAYT4Zs73ctGunmKLcUzco/YkdkE8GD
         pH5qZ2Nlodzu0I4Z/hXO5q6yGfDfYFOdI3gSq8oF3KQQVZ0BhSECs7ZOWaxVRHKqUS
         ogNoIlLUgavFw==
Subject: [PATCH v2 40/41] SUNRPC: Add RFC 8009 encryption KUnit tests
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:24:31 -0500
Message-ID: <167380347162.10651.584000246242169300.stgit@bazille.1015granger.net>
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

RFC 8009 provides sample encryption results. Add KUnit tests to
ensure our implementation derives the expected results for the
provided sample input.

I hate how large this test is, but using non-standard key usage
values means rfc8009_encrypt_case() can't simply reuse ->import_ctx
to allocate and key its ciphers; and the test provides its own
confounders, which means krb5_etm_encrypt() can't be used directly.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c   |   26 ++
 net/sunrpc/auth_gss/gss_krb5_internal.h |    3 
 net/sunrpc/auth_gss/gss_krb5_test.c     |  329 +++++++++++++++++++++++++++++++
 3 files changed, 354 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index c4e76a51203b..d0879a4d3122 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -886,10 +886,27 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 	return ret;
 }
 
-static u32
-krb5_etm_checksum(struct crypto_sync_skcipher *cipher,
-		  struct crypto_ahash *tfm, const struct xdr_buf *body,
-		  int body_offset, struct xdr_netobj *cksumout)
+/**
+ * krb5_etm_checksum - Compute a MAC for a GSS Wrap token
+ * @cipher: an initialized cipher transform
+ * @tfm: an initialized hash transform
+ * @body: xdr_buf containing an RPC message (body.len is the message length)
+ * @body_offset: byte offset into @body to start checksumming
+ * @cksumout: OUT: a buffer to be filled in with the computed HMAC
+ *
+ * Usually expressed as H = HMAC(K, IV | ciphertext)[1..h] .
+ *
+ * Caller provides the truncation length of the output token (h) in
+ * cksumout.len.
+ *
+ * Return values:
+ *   %GSS_S_COMPLETE: Digest computed, @cksumout filled in
+ *   %GSS_S_FAILURE: Call failed
+ */
+VISIBLE_IF_KUNIT
+u32 krb5_etm_checksum(struct crypto_sync_skcipher *cipher,
+		      struct crypto_ahash *tfm, const struct xdr_buf *body,
+		      int body_offset, struct xdr_netobj *cksumout)
 {
 	unsigned int ivsize = crypto_sync_skcipher_ivsize(cipher);
 	struct ahash_request *req;
@@ -936,6 +953,7 @@ krb5_etm_checksum(struct crypto_sync_skcipher *cipher,
 	kfree_sensitive(checksumdata);
 	return err ? GSS_S_FAILURE : GSS_S_COMPLETE;
 }
+EXPORT_SYMBOL_IF_KUNIT(krb5_etm_checksum);
 
 /**
  * krb5_etm_encrypt - Encrypt using the RFC 8009 rules
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index bebe1ec2f507..c907eda2ad72 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -221,6 +221,9 @@ int krb5_cbc_cts_encrypt(struct crypto_sync_skcipher *cts_tfm,
 			 struct crypto_sync_skcipher *cbc_tfm, u32 offset,
 			 struct xdr_buf *buf, struct page **pages,
 			 u8 *iv, unsigned int ivsize);
+u32 krb5_etm_checksum(struct crypto_sync_skcipher *cipher,
+		      struct crypto_ahash *tfm, const struct xdr_buf *body,
+		      int body_offset, struct xdr_netobj *cksumout);
 #endif
 
 #endif /* _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss_krb5_test.c
index 0399f8338066..fe3e4b81221a 100644
--- a/net/sunrpc/auth_gss/gss_krb5_test.c
+++ b/net/sunrpc/auth_gss/gss_krb5_test.c
@@ -30,6 +30,7 @@ struct gss_krb5_test_param {
 	const struct xdr_netobj		*plaintext;
 	const struct xdr_netobj		*confounder;
 	const struct xdr_netobj		*expected_result;
+	const struct xdr_netobj		*expected_hmac;
 	const struct xdr_netobj		*next_iv;
 };
 
@@ -1562,6 +1563,329 @@ static const struct gss_krb5_test_param rfc8009_checksum_test_params[] = {
 KUNIT_ARRAY_PARAM(rfc8009_checksum, rfc8009_checksum_test_params,
 		  gss_krb5_get_desc);
 
+/*
+ * From RFC 8009 Appendix A.  Test Vectors
+ *
+ * Sample encryptions (all using the default cipher state):
+ * --------------------------------------------------------
+ *
+ * These sample encryptions use the above sample key derivation results,
+ * including use of the same base-key and key usage values.
+ *
+ * This test material is copyright (c) 2016 IETF Trust and the
+ * persons identified as the document authors.  All rights reserved.
+ */
+
+static const struct xdr_netobj rfc8009_enc_empty_plaintext = {
+	.len	= 0,
+};
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_short_plaintext,
+		      0x00, 0x01, 0x02, 0x03, 0x04, 0x05
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_block_plaintext,
+		      0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+		      0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_long_plaintext,
+		      0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+		      0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+		      0x10, 0x11, 0x12, 0x13, 0x14
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test1_confounder,
+		      0x7e, 0x58, 0x95, 0xea, 0xf2, 0x67, 0x24, 0x35,
+		      0xba, 0xd8, 0x17, 0xf5, 0x45, 0xa3, 0x71, 0x48
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test1_expected_result,
+		      0xef, 0x85, 0xfb, 0x89, 0x0b, 0xb8, 0x47, 0x2f,
+		      0x4d, 0xab, 0x20, 0x39, 0x4d, 0xca, 0x78, 0x1d
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test1_expected_hmac,
+		      0xad, 0x87, 0x7e, 0xda, 0x39, 0xd5, 0x0c, 0x87,
+		      0x0c, 0x0d, 0x5a, 0x0a, 0x8e, 0x48, 0xc7, 0x18
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test2_confounder,
+		      0x7b, 0xca, 0x28, 0x5e, 0x2f, 0xd4, 0x13, 0x0f,
+		      0xb5, 0x5b, 0x1a, 0x5c, 0x83, 0xbc, 0x5b, 0x24
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test2_expected_result,
+		      0x84, 0xd7, 0xf3, 0x07, 0x54, 0xed, 0x98, 0x7b,
+		      0xab, 0x0b, 0xf3, 0x50, 0x6b, 0xeb, 0x09, 0xcf,
+		      0xb5, 0x54, 0x02, 0xce, 0xf7, 0xe6
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test2_expected_hmac,
+		      0x87, 0x7c, 0xe9, 0x9e, 0x24, 0x7e, 0x52, 0xd1,
+		      0x6e, 0xd4, 0x42, 0x1d, 0xfd, 0xf8, 0x97, 0x6c
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test3_confounder,
+		      0x56, 0xab, 0x21, 0x71, 0x3f, 0xf6, 0x2c, 0x0a,
+		      0x14, 0x57, 0x20, 0x0f, 0x6f, 0xa9, 0x94, 0x8f
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test3_expected_result,
+		      0x35, 0x17, 0xd6, 0x40, 0xf5, 0x0d, 0xdc, 0x8a,
+		      0xd3, 0x62, 0x87, 0x22, 0xb3, 0x56, 0x9d, 0x2a,
+		      0xe0, 0x74, 0x93, 0xfa, 0x82, 0x63, 0x25, 0x40,
+		      0x80, 0xea, 0x65, 0xc1, 0x00, 0x8e, 0x8f, 0xc2
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test3_expected_hmac,
+		      0x95, 0xfb, 0x48, 0x52, 0xe7, 0xd8, 0x3e, 0x1e,
+		      0x7c, 0x48, 0xc3, 0x7e, 0xeb, 0xe6, 0xb0, 0xd3
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test4_confounder,
+		      0xa7, 0xa4, 0xe2, 0x9a, 0x47, 0x28, 0xce, 0x10,
+		      0x66, 0x4f, 0xb6, 0x4e, 0x49, 0xad, 0x3f, 0xac
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test4_expected_result,
+		      0x72, 0x0f, 0x73, 0xb1, 0x8d, 0x98, 0x59, 0xcd,
+		      0x6c, 0xcb, 0x43, 0x46, 0x11, 0x5c, 0xd3, 0x36,
+		      0xc7, 0x0f, 0x58, 0xed, 0xc0, 0xc4, 0x43, 0x7c,
+		      0x55, 0x73, 0x54, 0x4c, 0x31, 0xc8, 0x13, 0xbc,
+		      0xe1, 0xe6, 0xd0, 0x72, 0xc1
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test4_expected_hmac,
+		      0x86, 0xb3, 0x9a, 0x41, 0x3c, 0x2f, 0x92, 0xca,
+		      0x9b, 0x83, 0x34, 0xa2, 0x87, 0xff, 0xcb, 0xfc
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test5_confounder,
+		      0xf7, 0x64, 0xe9, 0xfa, 0x15, 0xc2, 0x76, 0x47,
+		      0x8b, 0x2c, 0x7d, 0x0c, 0x4e, 0x5f, 0x58, 0xe4
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test5_expected_result,
+		      0x41, 0xf5, 0x3f, 0xa5, 0xbf, 0xe7, 0x02, 0x6d,
+		      0x91, 0xfa, 0xf9, 0xbe, 0x95, 0x91, 0x95, 0xa0
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test5_expected_hmac,
+		      0x58, 0x70, 0x72, 0x73, 0xa9, 0x6a, 0x40, 0xf0,
+		      0xa0, 0x19, 0x60, 0x62, 0x1a, 0xc6, 0x12, 0x74,
+		      0x8b, 0x9b, 0xbf, 0xbe, 0x7e, 0xb4, 0xce, 0x3c
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test6_confounder,
+		      0xb8, 0x0d, 0x32, 0x51, 0xc1, 0xf6, 0x47, 0x14,
+		      0x94, 0x25, 0x6f, 0xfe, 0x71, 0x2d, 0x0b, 0x9a
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test6_expected_result,
+		      0x4e, 0xd7, 0xb3, 0x7c, 0x2b, 0xca, 0xc8, 0xf7,
+		      0x4f, 0x23, 0xc1, 0xcf, 0x07, 0xe6, 0x2b, 0xc7,
+		      0xb7, 0x5f, 0xb3, 0xf6, 0x37, 0xb9
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test6_expected_hmac,
+		      0xf5, 0x59, 0xc7, 0xf6, 0x64, 0xf6, 0x9e, 0xab,
+		      0x7b, 0x60, 0x92, 0x23, 0x75, 0x26, 0xea, 0x0d,
+		      0x1f, 0x61, 0xcb, 0x20, 0xd6, 0x9d, 0x10, 0xf2
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test7_confounder,
+		      0x53, 0xbf, 0x8a, 0x0d, 0x10, 0x52, 0x65, 0xd4,
+		      0xe2, 0x76, 0x42, 0x86, 0x24, 0xce, 0x5e, 0x63
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test7_expected_result,
+		      0xbc, 0x47, 0xff, 0xec, 0x79, 0x98, 0xeb, 0x91,
+		      0xe8, 0x11, 0x5c, 0xf8, 0xd1, 0x9d, 0xac, 0x4b,
+		      0xbb, 0xe2, 0xe1, 0x63, 0xe8, 0x7d, 0xd3, 0x7f,
+		      0x49, 0xbe, 0xca, 0x92, 0x02, 0x77, 0x64, 0xf6
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test7_expected_hmac,
+		      0x8c, 0xf5, 0x1f, 0x14, 0xd7, 0x98, 0xc2, 0x27,
+		      0x3f, 0x35, 0xdf, 0x57, 0x4d, 0x1f, 0x93, 0x2e,
+		      0x40, 0xc4, 0xff, 0x25, 0x5b, 0x36, 0xa2, 0x66
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test8_confounder,
+		      0x76, 0x3e, 0x65, 0x36, 0x7e, 0x86, 0x4f, 0x02,
+		      0xf5, 0x51, 0x53, 0xc7, 0xe3, 0xb5, 0x8a, 0xf1
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test8_expected_result,
+		      0x40, 0x01, 0x3e, 0x2d, 0xf5, 0x8e, 0x87, 0x51,
+		      0x95, 0x7d, 0x28, 0x78, 0xbc, 0xd2, 0xd6, 0xfe,
+		      0x10, 0x1c, 0xcf, 0xd5, 0x56, 0xcb, 0x1e, 0xae,
+		      0x79, 0xdb, 0x3c, 0x3e, 0xe8, 0x64, 0x29, 0xf2,
+		      0xb2, 0xa6, 0x02, 0xac, 0x86
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_enc_test8_expected_hmac,
+		      0xfe, 0xf6, 0xec, 0xb6, 0x47, 0xd6, 0x29, 0x5f,
+		      0xae, 0x07, 0x7a, 0x1f, 0xeb, 0x51, 0x75, 0x08,
+		      0xd2, 0xc1, 0x6b, 0x41, 0x92, 0xe0, 0x1f, 0x62
+);
+
+static const struct gss_krb5_test_param rfc8009_encrypt_test_params[] = {
+	{
+		.desc			= "Encrypt empty plaintext with aes128-cts-hmac-sha256-128",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.plaintext		= &rfc8009_enc_empty_plaintext,
+		.confounder		= &rfc8009_enc_test1_confounder,
+		.base_key		= &aes128_cts_hmac_sha256_128_basekey,
+		.expected_result	= &rfc8009_enc_test1_expected_result,
+		.expected_hmac		= &rfc8009_enc_test1_expected_hmac,
+	},
+	{
+		.desc			= "Encrypt short plaintext with aes128-cts-hmac-sha256-128",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.plaintext		= &rfc8009_enc_short_plaintext,
+		.confounder		= &rfc8009_enc_test2_confounder,
+		.base_key		= &aes128_cts_hmac_sha256_128_basekey,
+		.expected_result	= &rfc8009_enc_test2_expected_result,
+		.expected_hmac		= &rfc8009_enc_test2_expected_hmac,
+	},
+	{
+		.desc			= "Encrypt block plaintext with aes128-cts-hmac-sha256-128",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.plaintext		= &rfc8009_enc_block_plaintext,
+		.confounder		= &rfc8009_enc_test3_confounder,
+		.base_key		= &aes128_cts_hmac_sha256_128_basekey,
+		.expected_result	= &rfc8009_enc_test3_expected_result,
+		.expected_hmac		= &rfc8009_enc_test3_expected_hmac,
+	},
+	{
+		.desc			= "Encrypt long plaintext with aes128-cts-hmac-sha256-128",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.plaintext		= &rfc8009_enc_long_plaintext,
+		.confounder		= &rfc8009_enc_test4_confounder,
+		.base_key		= &aes128_cts_hmac_sha256_128_basekey,
+		.expected_result	= &rfc8009_enc_test4_expected_result,
+		.expected_hmac		= &rfc8009_enc_test4_expected_hmac,
+	},
+	{
+		.desc			= "Encrypt empty plaintext with aes256-cts-hmac-sha384-192",
+		.enctype		= ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.plaintext		= &rfc8009_enc_empty_plaintext,
+		.confounder		= &rfc8009_enc_test5_confounder,
+		.base_key		= &aes256_cts_hmac_sha384_192_basekey,
+		.expected_result	= &rfc8009_enc_test5_expected_result,
+		.expected_hmac		= &rfc8009_enc_test5_expected_hmac,
+	},
+	{
+		.desc			= "Encrypt short plaintext with aes256-cts-hmac-sha384-192",
+		.enctype		= ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.plaintext		= &rfc8009_enc_short_plaintext,
+		.confounder		= &rfc8009_enc_test6_confounder,
+		.base_key		= &aes256_cts_hmac_sha384_192_basekey,
+		.expected_result	= &rfc8009_enc_test6_expected_result,
+		.expected_hmac		= &rfc8009_enc_test6_expected_hmac,
+	},
+	{
+		.desc			= "Encrypt block plaintext with aes256-cts-hmac-sha384-192",
+		.enctype		= ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.plaintext		= &rfc8009_enc_block_plaintext,
+		.confounder		= &rfc8009_enc_test7_confounder,
+		.base_key		= &aes256_cts_hmac_sha384_192_basekey,
+		.expected_result	= &rfc8009_enc_test7_expected_result,
+		.expected_hmac		= &rfc8009_enc_test7_expected_hmac,
+	},
+	{
+		.desc			= "Encrypt long plaintext with aes256-cts-hmac-sha384-192",
+		.enctype		= ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.plaintext		= &rfc8009_enc_long_plaintext,
+		.confounder		= &rfc8009_enc_test8_confounder,
+		.base_key		= &aes256_cts_hmac_sha384_192_basekey,
+		.expected_result	= &rfc8009_enc_test8_expected_result,
+		.expected_hmac		= &rfc8009_enc_test8_expected_hmac,
+	},
+};
+
+/* Creates the function rfc8009_encrypt_gen_params */
+KUNIT_ARRAY_PARAM(rfc8009_encrypt, rfc8009_encrypt_test_params,
+		  gss_krb5_get_desc);
+
+static void rfc8009_encrypt_case(struct kunit *test)
+{
+	const struct gss_krb5_test_param *param = test->param_value;
+	struct crypto_sync_skcipher *cts_tfm, *cbc_tfm;
+	const struct gss_krb5_enctype *gk5e;
+	struct xdr_netobj Ke, Ki, checksum;
+	u8 usage_data[GSS_KRB5_K5CLENGTH];
+	struct xdr_netobj usage = {
+		.data = usage_data,
+		.len = sizeof(usage_data),
+	};
+	struct crypto_ahash *ahash_tfm;
+	struct xdr_buf buf;
+	void *text;
+	size_t len;
+	u32 err;
+
+	/* Arrange */
+	gk5e = gss_krb5_lookup_enctype(param->enctype);
+	KUNIT_ASSERT_NOT_NULL(test, gk5e);
+
+	*(__be32 *)usage.data = cpu_to_be32(2);
+
+	Ke.len = gk5e->Ke_length;
+	Ke.data = kunit_kzalloc(test, Ke.len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, Ke.data);
+	usage.data[4] = KEY_USAGE_SEED_ENCRYPTION;
+	err = gk5e->derive_key(gk5e, param->base_key, &Ke,
+			       &usage, GFP_KERNEL);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	cbc_tfm = crypto_alloc_sync_skcipher(gk5e->aux_cipher, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cbc_tfm);
+	err = crypto_sync_skcipher_setkey(cbc_tfm, Ke.data, Ke.len);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	cts_tfm = crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cts_tfm);
+	err = crypto_sync_skcipher_setkey(cts_tfm, Ke.data, Ke.len);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	len = param->confounder->len + param->plaintext->len;
+	text = kunit_kzalloc(test, len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, text);
+	memcpy(text, param->confounder->data, param->confounder->len);
+	memcpy(text + param->confounder->len, param->plaintext->data,
+	       param->plaintext->len);
+
+	memset(&buf, 0, sizeof(buf));
+	buf.head[0].iov_base = text;
+	buf.head[0].iov_len = param->confounder->len + param->plaintext->len;
+	buf.len = buf.head[0].iov_len;
+
+	checksum.len = gk5e->cksumlength;
+	checksum.data = kunit_kzalloc(test, checksum.len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, checksum.data);
+
+	Ki.len = gk5e->Ki_length;
+	Ki.data = kunit_kzalloc(test, Ki.len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, Ki.data);
+	usage.data[4] = KEY_USAGE_SEED_INTEGRITY;
+	err = gk5e->derive_key(gk5e, param->base_key, &Ki,
+			       &usage, GFP_KERNEL);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	ahash_tfm = crypto_alloc_ahash(gk5e->cksum_name, 0, CRYPTO_ALG_ASYNC);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ahash_tfm);
+	err = crypto_ahash_setkey(ahash_tfm, Ki.data, Ki.len);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	/* Act */
+	err = krb5_cbc_cts_encrypt(cts_tfm, cbc_tfm, 0, &buf, NULL, NULL, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	err = krb5_etm_checksum(cts_tfm, ahash_tfm, &buf, 0, &checksum);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	/* Assert */
+	KUNIT_EXPECT_EQ_MSG(test,
+			    param->expected_result->len, buf.len,
+			    "ciphertext length mismatch");
+	KUNIT_EXPECT_EQ_MSG(test,
+			    memcmp(param->expected_result->data,
+				   buf.head[0].iov_base,
+				   param->expected_result->len), 0,
+			    "ciphertext mismatch");
+	KUNIT_EXPECT_EQ_MSG(test, memcmp(param->expected_hmac->data,
+					 checksum.data,
+					 checksum.len), 0,
+			    "HMAC mismatch");
+
+	crypto_free_ahash(ahash_tfm);
+	crypto_free_sync_skcipher(cts_tfm);
+	crypto_free_sync_skcipher(cbc_tfm);
+}
+
 static struct kunit_case rfc8009_test_cases[] = {
 	{
 		.name			= "RFC 8009 key derivation",
@@ -1573,6 +1897,11 @@ static struct kunit_case rfc8009_test_cases[] = {
 		.run_case		= checksum_case,
 		.generate_params	= rfc8009_checksum_gen_params,
 	},
+	{
+		.name			= "RFC 8009 encryption",
+		.run_case		= rfc8009_encrypt_case,
+		.generate_params	= rfc8009_encrypt_gen_params,
+	},
 };
 
 static struct kunit_suite rfc8009_suite = {


