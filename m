Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C8066B317
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjAORXw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjAORXu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:23:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E60276BB;
        Sun, 15 Jan 2023 09:23:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0BFD60DB5;
        Sun, 15 Jan 2023 17:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB51C433D2;
        Sun, 15 Jan 2023 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803428;
        bh=rBUK4J0JUMICEBphNBz7FZlmL19SsGygiIYzbQSwQug=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VZvMFTTNNS6x7kOTHth1poJY1ERVV1TalTSQV69ktmmoyxSLrdZhPsqYByYNZWFG3
         V1l+jNiHGb4cricXmYSfRQ7rhlS4EA8hXlkL5vrr0nzunsmVQtYepmdcVphNwGDDYP
         k8fq1AZb6ZvhA1/rAVhAr/OSN0oN3u7G0AyWmtpDrFuuzDzvHCYpfibF5poGyuvo1i
         FyjDHtDVp77qvIEq25c0VTUBGY7iqYfDi5J9/hd5lkpTlcxuAXDQNPD0abZqxxIE1T
         BoIaybsztTY3Awadjc8LP0yU6gyAqi3yVXqEGzfhMEjalbPdZWzKU9oW0gtKDFPbhd
         4r+2zP9wg0Zyg==
Subject: [PATCH v2 33/41] SUNRPC: Add KUnit tests RFC 3961 Key Derivation
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:23:47 -0500
Message-ID: <167380342700.10651.3920868094012639583.stgit@bazille.1015granger.net>
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

RFC 3961 Appendix A provides tests for the KDF specified in that
document as well as other parts of Kerberos. The other three usage
scenarios in Section 10 are not implemented by the Linux kernel's
RPCSEC GSS Kerberos 5 mechanism, so tests are not added for those.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_test.c |  227 +++++++++++++++++++++++++++++++++++
 1 file changed, 227 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss_krb5_test.c
index f67dbf7c8af4..550f1b3a11a3 100644
--- a/net/sunrpc/auth_gss/gss_krb5_test.c
+++ b/net/sunrpc/auth_gss/gss_krb5_test.c
@@ -20,7 +20,10 @@ MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
 
 struct gss_krb5_test_param {
 	const char			*desc;
+	u32				enctype;
 	u32				nfold;
+	const struct xdr_netobj		*base_key;
+	const struct xdr_netobj		*usage;
 	const struct xdr_netobj         *plaintext;
 	const struct xdr_netobj		*expected_result;
 };
@@ -31,6 +34,34 @@ static inline void gss_krb5_get_desc(const struct gss_krb5_test_param *param,
 	strscpy(desc, param->desc, KUNIT_PARAM_DESC_SIZE);
 }
 
+static void kdf_case(struct kunit *test)
+{
+	const struct gss_krb5_test_param *param = test->param_value;
+	const struct gss_krb5_enctype *gk5e;
+	struct xdr_netobj derivedkey;
+	int err;
+
+	/* Arrange */
+	gk5e = gss_krb5_lookup_enctype(param->enctype);
+	KUNIT_ASSERT_NOT_NULL(test, gk5e);
+
+	derivedkey.data = kunit_kzalloc(test, param->expected_result->len,
+					GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, derivedkey.data);
+	derivedkey.len = param->expected_result->len;
+
+	/* Act */
+	err = gk5e->derive_key(gk5e, param->base_key, &derivedkey,
+			       param->usage, GFP_KERNEL);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	/* Assert */
+	KUNIT_EXPECT_EQ_MSG(test,
+			    memcmp(param->expected_result->data,
+				   derivedkey.data, derivedkey.len), 0,
+			    "key mismatch");
+}
+
 #define DEFINE_HEX_XDR_NETOBJ(name, hex_array...)		\
 	static const u8 name ## _data[] = { hex_array };	\
 	static const struct xdr_netobj name = {			\
@@ -225,12 +256,208 @@ static void rfc3961_nfold_case(struct kunit *test)
 			    "result mismatch");
 }
 
+/*
+ * RFC 3961 Appendix A.3.  DES3 DR and DK
+ *
+ * These tests show the derived-random and derived-key values for the
+ * des3-hmac-sha1-kd encryption scheme, using the DR and DK functions
+ * defined in section 6.3.1.  The input keys were randomly generated;
+ * the usage values are from this specification.
+ *
+ * This test material is copyright (C) The Internet Society (2005).
+ */
+
+DEFINE_HEX_XDR_NETOBJ(des3_dk_usage_155,
+		      0x00, 0x00, 0x00, 0x01, 0x55
+);
+
+DEFINE_HEX_XDR_NETOBJ(des3_dk_usage_1aa,
+		      0x00, 0x00, 0x00, 0x01, 0xaa
+);
+
+DEFINE_HEX_XDR_NETOBJ(des3_dk_usage_kerberos,
+		      0x6b, 0x65, 0x72, 0x62, 0x65, 0x72, 0x6f, 0x73
+);
+
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test1_base_key,
+		      0xdc, 0xe0, 0x6b, 0x1f, 0x64, 0xc8, 0x57, 0xa1,
+		      0x1c, 0x3d, 0xb5, 0x7c, 0x51, 0x89, 0x9b, 0x2c,
+		      0xc1, 0x79, 0x10, 0x08, 0xce, 0x97, 0x3b, 0x92
+);
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test1_derived_key,
+		      0x92, 0x51, 0x79, 0xd0, 0x45, 0x91, 0xa7, 0x9b,
+		      0x5d, 0x31, 0x92, 0xc4, 0xa7, 0xe9, 0xc2, 0x89,
+		      0xb0, 0x49, 0xc7, 0x1f, 0x6e, 0xe6, 0x04, 0xcd
+);
+
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test2_base_key,
+		      0x5e, 0x13, 0xd3, 0x1c, 0x70, 0xef, 0x76, 0x57,
+		      0x46, 0x57, 0x85, 0x31, 0xcb, 0x51, 0xc1, 0x5b,
+		      0xf1, 0x1c, 0xa8, 0x2c, 0x97, 0xce, 0xe9, 0xf2
+);
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test2_derived_key,
+		      0x9e, 0x58, 0xe5, 0xa1, 0x46, 0xd9, 0x94, 0x2a,
+		      0x10, 0x1c, 0x46, 0x98, 0x45, 0xd6, 0x7a, 0x20,
+		      0xe3, 0xc4, 0x25, 0x9e, 0xd9, 0x13, 0xf2, 0x07
+);
+
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test3_base_key,
+		      0x98, 0xe6, 0xfd, 0x8a, 0x04, 0xa4, 0xb6, 0x85,
+		      0x9b, 0x75, 0xa1, 0x76, 0x54, 0x0b, 0x97, 0x52,
+		      0xba, 0xd3, 0xec, 0xd6, 0x10, 0xa2, 0x52, 0xbc
+);
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test3_derived_key,
+		      0x13, 0xfe, 0xf8, 0x0d, 0x76, 0x3e, 0x94, 0xec,
+		      0x6d, 0x13, 0xfd, 0x2c, 0xa1, 0xd0, 0x85, 0x07,
+		      0x02, 0x49, 0xda, 0xd3, 0x98, 0x08, 0xea, 0xbf
+);
+
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test4_base_key,
+		      0x62, 0x2a, 0xec, 0x25, 0xa2, 0xfe, 0x2c, 0xad,
+		      0x70, 0x94, 0x68, 0x0b, 0x7c, 0x64, 0x94, 0x02,
+		      0x80, 0x08, 0x4c, 0x1a, 0x7c, 0xec, 0x92, 0xb5
+);
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test4_derived_key,
+		      0xf8, 0xdf, 0xbf, 0x04, 0xb0, 0x97, 0xe6, 0xd9,
+		      0xdc, 0x07, 0x02, 0x68, 0x6b, 0xcb, 0x34, 0x89,
+		      0xd9, 0x1f, 0xd9, 0xa4, 0x51, 0x6b, 0x70, 0x3e
+);
+
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test5_base_key,
+		      0xd3, 0xf8, 0x29, 0x8c, 0xcb, 0x16, 0x64, 0x38,
+		      0xdc, 0xb9, 0xb9, 0x3e, 0xe5, 0xa7, 0x62, 0x92,
+		      0x86, 0xa4, 0x91, 0xf8, 0x38, 0xf8, 0x02, 0xfb
+);
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test5_derived_key,
+		      0x23, 0x70, 0xda, 0x57, 0x5d, 0x2a, 0x3d, 0xa8,
+		      0x64, 0xce, 0xbf, 0xdc, 0x52, 0x04, 0xd5, 0x6d,
+		      0xf7, 0x79, 0xa7, 0xdf, 0x43, 0xd9, 0xda, 0x43
+);
+
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test6_base_key,
+		      0xc1, 0x08, 0x16, 0x49, 0xad, 0xa7, 0x43, 0x62,
+		      0xe6, 0xa1, 0x45, 0x9d, 0x01, 0xdf, 0xd3, 0x0d,
+		      0x67, 0xc2, 0x23, 0x4c, 0x94, 0x07, 0x04, 0xda
+);
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test6_derived_key,
+		      0x34, 0x80, 0x57, 0xec, 0x98, 0xfd, 0xc4, 0x80,
+		      0x16, 0x16, 0x1c, 0x2a, 0x4c, 0x7a, 0x94, 0x3e,
+		      0x92, 0xae, 0x49, 0x2c, 0x98, 0x91, 0x75, 0xf7
+);
+
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test7_base_key,
+		      0x5d, 0x15, 0x4a, 0xf2, 0x38, 0xf4, 0x67, 0x13,
+		      0x15, 0x57, 0x19, 0xd5, 0x5e, 0x2f, 0x1f, 0x79,
+		      0x0d, 0xd6, 0x61, 0xf2, 0x79, 0xa7, 0x91, 0x7c
+);
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test7_derived_key,
+		      0xa8, 0x80, 0x8a, 0xc2, 0x67, 0xda, 0xda, 0x3d,
+		      0xcb, 0xe9, 0xa7, 0xc8, 0x46, 0x26, 0xfb, 0xc7,
+		      0x61, 0xc2, 0x94, 0xb0, 0x13, 0x15, 0xe5, 0xc1
+);
+
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test8_base_key,
+		      0x79, 0x85, 0x62, 0xe0, 0x49, 0x85, 0x2f, 0x57,
+		      0xdc, 0x8c, 0x34, 0x3b, 0xa1, 0x7f, 0x2c, 0xa1,
+		      0xd9, 0x73, 0x94, 0xef, 0xc8, 0xad, 0xc4, 0x43
+);
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test8_derived_key,
+		      0xc8, 0x13, 0xf8, 0x8a, 0x3b, 0xe3, 0xb3, 0x34,
+		      0xf7, 0x54, 0x25, 0xce, 0x91, 0x75, 0xfb, 0xe3,
+		      0xc8, 0x49, 0x3b, 0x89, 0xc8, 0x70, 0x3b, 0x49
+);
+
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test9_base_key,
+		      0x26, 0xdc, 0xe3, 0x34, 0xb5, 0x45, 0x29, 0x2f,
+		      0x2f, 0xea, 0xb9, 0xa8, 0x70, 0x1a, 0x89, 0xa4,
+		      0xb9, 0x9e, 0xb9, 0x94, 0x2c, 0xec, 0xd0, 0x16
+);
+DEFINE_HEX_XDR_NETOBJ(des3_dk_test9_derived_key,
+		      0xf4, 0x8f, 0xfd, 0x6e, 0x83, 0xf8, 0x3e, 0x73,
+		      0x54, 0xe6, 0x94, 0xfd, 0x25, 0x2c, 0xf8, 0x3b,
+		      0xfe, 0x58, 0xf7, 0xd5, 0xba, 0x37, 0xec, 0x5d
+);
+
+static const struct gss_krb5_test_param rfc3961_kdf_test_params[] = {
+	{
+		.desc			= "des3-hmac-sha1 key derivation case 1",
+		.enctype		= ENCTYPE_DES3_CBC_RAW,
+		.base_key		= &des3_dk_test1_base_key,
+		.usage			= &des3_dk_usage_155,
+		.expected_result	= &des3_dk_test1_derived_key,
+	},
+	{
+		.desc			= "des3-hmac-sha1 key derivation case 2",
+		.enctype		= ENCTYPE_DES3_CBC_RAW,
+		.base_key		= &des3_dk_test2_base_key,
+		.usage			= &des3_dk_usage_1aa,
+		.expected_result	= &des3_dk_test2_derived_key,
+	},
+	{
+		.desc			= "des3-hmac-sha1 key derivation case 3",
+		.enctype		= ENCTYPE_DES3_CBC_RAW,
+		.base_key		= &des3_dk_test3_base_key,
+		.usage			= &des3_dk_usage_155,
+		.expected_result	= &des3_dk_test3_derived_key,
+	},
+	{
+		.desc			= "des3-hmac-sha1 key derivation case 4",
+		.enctype		= ENCTYPE_DES3_CBC_RAW,
+		.base_key		= &des3_dk_test4_base_key,
+		.usage			= &des3_dk_usage_1aa,
+		.expected_result	= &des3_dk_test4_derived_key,
+	},
+	{
+		.desc			= "des3-hmac-sha1 key derivation case 5",
+		.enctype		= ENCTYPE_DES3_CBC_RAW,
+		.base_key		= &des3_dk_test5_base_key,
+		.usage			= &des3_dk_usage_kerberos,
+		.expected_result	= &des3_dk_test5_derived_key,
+	},
+	{
+		.desc			= "des3-hmac-sha1 key derivation case 6",
+		.enctype		= ENCTYPE_DES3_CBC_RAW,
+		.base_key		= &des3_dk_test6_base_key,
+		.usage			= &des3_dk_usage_155,
+		.expected_result	= &des3_dk_test6_derived_key,
+	},
+	{
+		.desc			= "des3-hmac-sha1 key derivation case 7",
+		.enctype		= ENCTYPE_DES3_CBC_RAW,
+		.base_key		= &des3_dk_test7_base_key,
+		.usage			= &des3_dk_usage_1aa,
+		.expected_result	= &des3_dk_test7_derived_key,
+	},
+	{
+		.desc			= "des3-hmac-sha1 key derivation case 8",
+		.enctype		= ENCTYPE_DES3_CBC_RAW,
+		.base_key		= &des3_dk_test8_base_key,
+		.usage			= &des3_dk_usage_155,
+		.expected_result	= &des3_dk_test8_derived_key,
+	},
+	{
+		.desc			= "des3-hmac-sha1 key derivation case 9",
+		.enctype		= ENCTYPE_DES3_CBC_RAW,
+		.base_key		= &des3_dk_test9_base_key,
+		.usage			= &des3_dk_usage_1aa,
+		.expected_result	= &des3_dk_test9_derived_key,
+	},
+};
+
+/* Creates the function rfc3961_kdf_gen_params */
+KUNIT_ARRAY_PARAM(rfc3961_kdf, rfc3961_kdf_test_params, gss_krb5_get_desc);
+
 static struct kunit_case rfc3961_test_cases[] = {
 	{
 		.name			= "RFC 3961 n-fold",
 		.run_case		= rfc3961_nfold_case,
 		.generate_params	= rfc3961_nfold_gen_params,
 	},
+	{
+		.name			= "RFC 3961 key derivation",
+		.run_case		= kdf_case,
+		.generate_params	= rfc3961_kdf_gen_params,
+	},
 };
 
 static struct kunit_suite rfc3961_suite = {


