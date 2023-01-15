Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B1266B329
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjAORYm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjAORYl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:24:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F99476BB;
        Sun, 15 Jan 2023 09:24:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2A1660DB5;
        Sun, 15 Jan 2023 17:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB4BC433EF;
        Sun, 15 Jan 2023 17:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803479;
        bh=SduC0z5d1D+d54bhYt1PAjiRjmtc4LR5jq6bBn2gC14=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GH9/Uk5ddp3pbPw7wqVZVKmgfiCCulss7Znd8xowk7Vx4YYeTUASao988unDRDO0v
         3vD1JpZxXc8pH0X7FGPhxmm5MVg8TIIUHTdBjgAu9eOUCdAanOgFBNesbtk8hScz30
         49ZK4HnyeSPFUzYGvQSUNqQ5AiMdvRfLbSQcir++yVLwHhzqHtGsdtAJnO0vcff8Kn
         JAx8MxwinIjLeN9IUZ/xu9pOopRz2bYo6L5FO7C2xwB/jpJNTFSqqzGkSK9ZF5nubF
         rianJhIiQHkpl9xgJPkZA67tAOnCguEoR459cbaVUVgt+aa29C54ZEPle6fZcwy3r/
         /pbYypfTegtPA==
Subject: [PATCH v2 41/41] SUNRPC: Add encryption self-tests
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:24:38 -0500
Message-ID: <167380347809.10651.324873285352998096.stgit@bazille.1015granger.net>
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

With the KUnit infrastructure recently added, we are free to define
other unit tests particular to our implementation. As an example,
I've added a self-test that encrypts then decrypts a string, and
checks the result.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c   |   20 ++++-
 net/sunrpc/auth_gss/gss_krb5_internal.h |    3 +
 net/sunrpc/auth_gss/gss_krb5_test.c     |  124 +++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index d0879a4d3122..6c7c52eeed4f 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -713,10 +713,21 @@ int krb5_cbc_cts_encrypt(struct crypto_sync_skcipher *cts_tfm,
 }
 EXPORT_SYMBOL_IF_KUNIT(krb5_cbc_cts_encrypt);
 
-static int
-krb5_cbc_cts_decrypt(struct crypto_sync_skcipher *cts_tfm,
-		     struct crypto_sync_skcipher *cbc_tfm,
-		     u32 offset, struct xdr_buf *buf)
+/**
+ * krb5_cbc_cts_decrypt - decrypt in CBC mode with CTS
+ * @cts_tfm: CBC cipher with CTS
+ * @cbc_tfm: base CBC cipher
+ * @offset: starting byte offset for plaintext
+ * @buf: OUT: output buffer
+ *
+ * Return values:
+ *   %0: decryption successful
+ *   negative errno: decryption could not be completed
+ */
+VISIBLE_IF_KUNIT
+int krb5_cbc_cts_decrypt(struct crypto_sync_skcipher *cts_tfm,
+			 struct crypto_sync_skcipher *cbc_tfm,
+			 u32 offset, struct xdr_buf *buf)
 {
 	u32 blocksize, nblocks, cbcbytes;
 	struct decryptor_desc desc;
@@ -752,6 +763,7 @@ krb5_cbc_cts_decrypt(struct crypto_sync_skcipher *cts_tfm,
 	/* Remaining plaintext is handled with CBC-CTS. */
 	return gss_krb5_cts_crypt(cts_tfm, buf, cbcbytes, desc.iv, NULL, 0);
 }
+EXPORT_SYMBOL_IF_KUNIT(krb5_cbc_cts_decrypt);
 
 u32
 gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index c907eda2ad72..b673e2626acb 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -221,6 +221,9 @@ int krb5_cbc_cts_encrypt(struct crypto_sync_skcipher *cts_tfm,
 			 struct crypto_sync_skcipher *cbc_tfm, u32 offset,
 			 struct xdr_buf *buf, struct page **pages,
 			 u8 *iv, unsigned int ivsize);
+int krb5_cbc_cts_decrypt(struct crypto_sync_skcipher *cts_tfm,
+			 struct crypto_sync_skcipher *cbc_tfm,
+			 u32 offset, struct xdr_buf *buf);
 u32 krb5_etm_checksum(struct crypto_sync_skcipher *cipher,
 		      struct crypto_ahash *tfm, const struct xdr_buf *body,
 		      int body_offset, struct xdr_netobj *cksumout);
diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss_krb5_test.c
index fe3e4b81221a..c287ce15c419 100644
--- a/net/sunrpc/auth_gss/gss_krb5_test.c
+++ b/net/sunrpc/auth_gss/gss_krb5_test.c
@@ -1909,10 +1909,132 @@ static struct kunit_suite rfc8009_suite = {
 	.test_cases		= rfc8009_test_cases,
 };
 
+/*
+ * Encryption self-tests
+ */
+
+DEFINE_STR_XDR_NETOBJ(encrypt_selftest_plaintext,
+		      "This is the plaintext for the encryption self-test.");
+
+static const struct gss_krb5_test_param encrypt_selftest_params[] = {
+	{
+		.desc			= "aes128-cts-hmac-sha1-96 encryption self-test",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA1_96,
+		.Ke			= &rfc3962_encryption_key,
+		.plaintext		= &encrypt_selftest_plaintext,
+	},
+	{
+		.desc			= "aes256-cts-hmac-sha1-96 encryption self-test",
+		.enctype		= ENCTYPE_AES256_CTS_HMAC_SHA1_96,
+		.Ke			= &rfc3962_encryption_key,
+		.plaintext		= &encrypt_selftest_plaintext,
+	},
+	{
+		.desc			= "camellia128-cts-cmac encryption self-test",
+		.enctype		= ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.Ke			= &camellia128_cts_cmac_Ke,
+		.plaintext		= &encrypt_selftest_plaintext,
+	},
+	{
+		.desc			= "camellia256-cts-cmac encryption self-test",
+		.enctype		= ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.Ke			= &camellia256_cts_cmac_Ke,
+		.plaintext		= &encrypt_selftest_plaintext,
+	},
+	{
+		.desc			= "aes128-cts-hmac-sha256-128 encryption self-test",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.Ke			= &aes128_cts_hmac_sha256_128_Ke,
+		.plaintext		= &encrypt_selftest_plaintext,
+	},
+	{
+		.desc			= "aes256-cts-hmac-sha384-192 encryption self-test",
+		.enctype		= ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.Ke			= &aes256_cts_hmac_sha384_192_Ke,
+		.plaintext		= &encrypt_selftest_plaintext,
+	},
+};
+
+/* Creates the function encrypt_selftest_gen_params */
+KUNIT_ARRAY_PARAM(encrypt_selftest, encrypt_selftest_params,
+		  gss_krb5_get_desc);
+
+/*
+ * Encrypt and decrypt plaintext, and ensure the input plaintext
+ * matches the output plaintext. A confounder is not added in this
+ * case.
+ */
+static void encrypt_selftest_case(struct kunit *test)
+{
+	const struct gss_krb5_test_param *param = test->param_value;
+	struct crypto_sync_skcipher *cts_tfm, *cbc_tfm;
+	const struct gss_krb5_enctype *gk5e;
+	struct xdr_buf buf;
+	void *text;
+	int err;
+
+	/* Arrange */
+	gk5e = gss_krb5_lookup_enctype(param->enctype);
+	KUNIT_ASSERT_NOT_NULL(test, gk5e);
+
+	cbc_tfm = crypto_alloc_sync_skcipher(gk5e->aux_cipher, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cbc_tfm);
+	err = crypto_sync_skcipher_setkey(cbc_tfm, param->Ke->data, param->Ke->len);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	cts_tfm = crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cts_tfm);
+	err = crypto_sync_skcipher_setkey(cts_tfm, param->Ke->data, param->Ke->len);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	text = kunit_kzalloc(test, roundup(param->plaintext->len,
+					   crypto_sync_skcipher_blocksize(cbc_tfm)),
+			     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, text);
+
+	memcpy(text, param->plaintext->data, param->plaintext->len);
+	memset(&buf, 0, sizeof(buf));
+	buf.head[0].iov_base = text;
+	buf.head[0].iov_len = param->plaintext->len;
+	buf.len = buf.head[0].iov_len;
+
+	/* Act */
+	err = krb5_cbc_cts_encrypt(cts_tfm, cbc_tfm, 0, &buf, NULL, NULL, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	err = krb5_cbc_cts_decrypt(cts_tfm, cbc_tfm, 0, &buf);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	/* Assert */
+	KUNIT_EXPECT_EQ_MSG(test,
+			    param->plaintext->len, buf.len,
+			    "length mismatch");
+	KUNIT_EXPECT_EQ_MSG(test,
+			    memcmp(param->plaintext->data,
+				   buf.head[0].iov_base, buf.len), 0,
+			    "plaintext mismatch");
+
+	crypto_free_sync_skcipher(cts_tfm);
+	crypto_free_sync_skcipher(cbc_tfm);
+}
+
+static struct kunit_case encryption_test_cases[] = {
+	{
+		.name			= "Encryption self-tests",
+		.run_case		= encrypt_selftest_case,
+		.generate_params	= encrypt_selftest_gen_params,
+	},
+};
+
+static struct kunit_suite encryption_test_suite = {
+	.name			= "Encryption test suite",
+	.test_cases		= encryption_test_cases,
+};
+
 kunit_test_suites(&rfc3961_suite,
 		  &rfc3962_suite,
 		  &rfc6803_suite,
-		  &rfc8009_suite);
+		  &rfc8009_suite,
+		  &encryption_test_suite);
 
 MODULE_DESCRIPTION("Test RPCSEC GSS Kerberos 5 functions");
 MODULE_LICENSE("GPL");


