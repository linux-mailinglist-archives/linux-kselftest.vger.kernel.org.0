Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0709466B31D
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjAORYK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjAORYJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:24:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5700B10AA7;
        Sun, 15 Jan 2023 09:24:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E803B60D2C;
        Sun, 15 Jan 2023 17:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08047C433EF;
        Sun, 15 Jan 2023 17:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803447;
        bh=YmWA5AnJYXs7PLvOIqxHmTS1Sd3TVIrvknfsAAfkX60=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JN3m/y/Z+NzTSTvrgIMy1js3Zu4VSQf7dabidkB+k1psacZ5+Sh9LewBs2TJzBpYE
         kh2Kbcfmi1KjApnnFXAyy5vYT1+j/vGPFtK/rCm2ZUcJ6K1MA3qb8HCM/avPepc9ux
         PEf7cSgMVc1XKDMrb8ImcBoPggch9NWSg5wgawuhjVzfSBiXZAUWJjkTyrxPPmcJtJ
         GITrbvS+V2R+ddZMnFrpJYHoNlOdo5vjx4u2LM6AeIty9zAkIJvJZtjOekUEDY0eIg
         a1E6S5r5gBKL8eEBNsk7ofLuTsQffWGuMeoj2r5r6iQXALsEHSH5802WnZposdtusD
         6dbkQpv5F54Rw==
Subject: [PATCH v2 36/41] SUNRPC: Add checksum KUnit tests for the RFC 6803
 encryption types
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:24:06 -0500
Message-ID: <167380344616.10651.3487869443589582500.stgit@bazille.1015granger.net>
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

Test the new-to-RPCSEC CMAC digest algorithm.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c |    1 
 net/sunrpc/auth_gss/gss_krb5_test.c   |  168 +++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 5d8dff65d014..c4e76a51203b 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -361,6 +361,7 @@ gss_krb5_checksum(struct crypto_ahash *tfm, char *header, int hdrlen,
 	kfree_sensitive(checksumdata);
 	return err ? GSS_S_FAILURE : GSS_S_COMPLETE;
 }
+EXPORT_SYMBOL_IF_KUNIT(gss_krb5_checksum);
 
 struct encryptor_desc {
 	u8 iv[GSS_KRB5_MAX_BLOCKSIZE];
diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss_krb5_test.c
index c80a8f6588c0..ea8cba8c3eb3 100644
--- a/net/sunrpc/auth_gss/gss_krb5_test.c
+++ b/net/sunrpc/auth_gss/gss_krb5_test.c
@@ -10,6 +10,7 @@
 #include <kunit/visibility.h>
 
 #include <linux/kernel.h>
+#include <crypto/hash.h>
 
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/gss_krb5.h>
@@ -64,6 +65,52 @@ static void kdf_case(struct kunit *test)
 			    "key mismatch");
 }
 
+static void checksum_case(struct kunit *test)
+{
+	const struct gss_krb5_test_param *param = test->param_value;
+	struct xdr_buf buf = {
+		.head[0].iov_base	= param->plaintext->data,
+		.head[0].iov_len	= param->plaintext->len,
+		.len			= param->plaintext->len,
+	};
+	const struct gss_krb5_enctype *gk5e;
+	struct xdr_netobj Kc, checksum;
+	struct crypto_ahash *tfm;
+	int err;
+
+	/* Arrange */
+	gk5e = gss_krb5_lookup_enctype(param->enctype);
+	KUNIT_ASSERT_NOT_NULL(test, gk5e);
+
+	Kc.len = gk5e->Kc_length;
+	Kc.data = kunit_kzalloc(test, Kc.len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, Kc.data);
+	err = gk5e->derive_key(gk5e, param->base_key, &Kc,
+			       param->usage, GFP_KERNEL);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	tfm = crypto_alloc_ahash(gk5e->cksum_name, 0, CRYPTO_ALG_ASYNC);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tfm);
+	err = crypto_ahash_setkey(tfm, Kc.data, Kc.len);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	checksum.len = gk5e->cksumlength;
+	checksum.data = kunit_kzalloc(test, checksum.len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, checksum.data);
+
+	/* Act */
+	err = gss_krb5_checksum(tfm, NULL, 0, &buf, 0, &checksum);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	/* Assert */
+	KUNIT_EXPECT_EQ_MSG(test,
+			    memcmp(param->expected_result->data,
+				   checksum.data, checksum.len), 0,
+			    "checksum mismatch");
+
+	crypto_free_ahash(tfm);
+}
+
 #define DEFINE_HEX_XDR_NETOBJ(name, hex_array...)		\
 	static const u8 name ## _data[] = { hex_array };	\
 	static const struct xdr_netobj name = {			\
@@ -71,6 +118,13 @@ static void kdf_case(struct kunit *test)
 		.len	= sizeof(name##_data),			\
 	}
 
+#define DEFINE_STR_XDR_NETOBJ(name, string)			\
+	static const u8 name ## _str[] = string;		\
+	static const struct xdr_netobj name = {			\
+		.data	= (u8 *)name##_str,			\
+		.len	= sizeof(name##_str) - 1,		\
+	}
+
 /*
  * RFC 3961 Appendix A.1.  n-fold
  *
@@ -836,12 +890,126 @@ static const struct gss_krb5_test_param rfc6803_kdf_test_params[] = {
 /* Creates the function rfc6803_kdf_gen_params */
 KUNIT_ARRAY_PARAM(rfc6803_kdf, rfc6803_kdf_test_params, gss_krb5_get_desc);
 
+/*
+ * From RFC 6803 Section 10.  Test vectors
+ *
+ * Sample checksums.
+ *
+ * Copyright (c) 2012 IETF Trust and the persons identified as the
+ * document authors.  All rights reserved.
+ *
+ * XXX: These tests are likely to fail on EBCDIC or Unicode platforms.
+ */
+DEFINE_STR_XDR_NETOBJ(rfc6803_checksum_test1_plaintext,
+		      "abcdefghijk");
+DEFINE_HEX_XDR_NETOBJ(rfc6803_checksum_test1_basekey,
+		      0x1d, 0xc4, 0x6a, 0x8d, 0x76, 0x3f, 0x4f, 0x93,
+		      0x74, 0x2b, 0xcb, 0xa3, 0x38, 0x75, 0x76, 0xc3
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_checksum_test1_usage,
+		      0x00, 0x00, 0x00, 0x07, KEY_USAGE_SEED_CHECKSUM
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_checksum_test1_expected_result,
+		      0x11, 0x78, 0xe6, 0xc5, 0xc4, 0x7a, 0x8c, 0x1a,
+		      0xe0, 0xc4, 0xb9, 0xc7, 0xd4, 0xeb, 0x7b, 0x6b
+);
+
+DEFINE_STR_XDR_NETOBJ(rfc6803_checksum_test2_plaintext,
+		      "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
+DEFINE_HEX_XDR_NETOBJ(rfc6803_checksum_test2_basekey,
+		      0x50, 0x27, 0xbc, 0x23, 0x1d, 0x0f, 0x3a, 0x9d,
+		      0x23, 0x33, 0x3f, 0x1c, 0xa6, 0xfd, 0xbe, 0x7c
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_checksum_test2_usage,
+		      0x00, 0x00, 0x00, 0x08, KEY_USAGE_SEED_CHECKSUM
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_checksum_test2_expected_result,
+		      0xd1, 0xb3, 0x4f, 0x70, 0x04, 0xa7, 0x31, 0xf2,
+		      0x3a, 0x0c, 0x00, 0xbf, 0x6c, 0x3f, 0x75, 0x3a
+);
+
+DEFINE_STR_XDR_NETOBJ(rfc6803_checksum_test3_plaintext,
+		      "123456789");
+DEFINE_HEX_XDR_NETOBJ(rfc6803_checksum_test3_basekey,
+		      0xb6, 0x1c, 0x86, 0xcc, 0x4e, 0x5d, 0x27, 0x57,
+		      0x54, 0x5a, 0xd4, 0x23, 0x39, 0x9f, 0xb7, 0x03,
+		      0x1e, 0xca, 0xb9, 0x13, 0xcb, 0xb9, 0x00, 0xbd,
+		      0x7a, 0x3c, 0x6d, 0xd8, 0xbf, 0x92, 0x01, 0x5b
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_checksum_test3_usage,
+		      0x00, 0x00, 0x00, 0x09, KEY_USAGE_SEED_CHECKSUM
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_checksum_test3_expected_result,
+		      0x87, 0xa1, 0x2c, 0xfd, 0x2b, 0x96, 0x21, 0x48,
+		      0x10, 0xf0, 0x1c, 0x82, 0x6e, 0x77, 0x44, 0xb1
+);
+
+DEFINE_STR_XDR_NETOBJ(rfc6803_checksum_test4_plaintext,
+		      "!@#$%^&*()!@#$%^&*()!@#$%^&*()");
+DEFINE_HEX_XDR_NETOBJ(rfc6803_checksum_test4_basekey,
+		      0x32, 0x16, 0x4c, 0x5b, 0x43, 0x4d, 0x1d, 0x15,
+		      0x38, 0xe4, 0xcf, 0xd9, 0xbe, 0x80, 0x40, 0xfe,
+		      0x8c, 0x4a, 0xc7, 0xac, 0xc4, 0xb9, 0x3d, 0x33,
+		      0x14, 0xd2, 0x13, 0x36, 0x68, 0x14, 0x7a, 0x05
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_checksum_test4_usage,
+		      0x00, 0x00, 0x00, 0x0a, KEY_USAGE_SEED_CHECKSUM
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_checksum_test4_expected_result,
+		      0x3f, 0xa0, 0xb4, 0x23, 0x55, 0xe5, 0x2b, 0x18,
+		      0x91, 0x87, 0x29, 0x4a, 0xa2, 0x52, 0xab, 0x64
+);
+
+static const struct gss_krb5_test_param rfc6803_checksum_test_params[] = {
+	{
+		.desc			= "camellia128-cts-cmac checksum test 1",
+		.enctype		= ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.base_key		= &rfc6803_checksum_test1_basekey,
+		.usage			= &rfc6803_checksum_test1_usage,
+		.plaintext		= &rfc6803_checksum_test1_plaintext,
+		.expected_result	= &rfc6803_checksum_test1_expected_result,
+	},
+	{
+		.desc			= "camellia128-cts-cmac checksum test 2",
+		.enctype		= ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.base_key		= &rfc6803_checksum_test2_basekey,
+		.usage			= &rfc6803_checksum_test2_usage,
+		.plaintext		= &rfc6803_checksum_test2_plaintext,
+		.expected_result	= &rfc6803_checksum_test2_expected_result,
+	},
+	{
+		.desc			= "camellia256-cts-cmac checksum test 3",
+		.enctype		= ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.base_key		= &rfc6803_checksum_test3_basekey,
+		.usage			= &rfc6803_checksum_test3_usage,
+		.plaintext		= &rfc6803_checksum_test3_plaintext,
+		.expected_result	= &rfc6803_checksum_test3_expected_result,
+	},
+	{
+		.desc			= "camellia256-cts-cmac checksum test 4",
+		.enctype		= ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.base_key		= &rfc6803_checksum_test4_basekey,
+		.usage			= &rfc6803_checksum_test4_usage,
+		.plaintext		= &rfc6803_checksum_test4_plaintext,
+		.expected_result	= &rfc6803_checksum_test4_expected_result,
+	},
+};
+
+/* Creates the function rfc6803_checksum_gen_params */
+KUNIT_ARRAY_PARAM(rfc6803_checksum, rfc6803_checksum_test_params,
+		  gss_krb5_get_desc);
+
 static struct kunit_case rfc6803_test_cases[] = {
 	{
 		.name			= "RFC 6803 key derivation",
 		.run_case		= kdf_case,
 		.generate_params	= rfc6803_kdf_gen_params,
 	},
+	{
+		.name			= "RFC 6803 checksum",
+		.run_case		= checksum_case,
+		.generate_params	= rfc6803_checksum_gen_params,
+	},
 };
 
 static struct kunit_suite rfc6803_suite = {


