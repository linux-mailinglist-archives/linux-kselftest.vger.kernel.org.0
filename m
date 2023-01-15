Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C61366B322
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjAORY0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjAORYY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:24:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E88113CD;
        Sun, 15 Jan 2023 09:24:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67072B80B8A;
        Sun, 15 Jan 2023 17:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD2EC433EF;
        Sun, 15 Jan 2023 17:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803460;
        bh=Ji+xFET7VBoHvSkc5p2kDI9yqVAW6IUXD5IEaE75c6Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jlpMIpkMmivdC7O/LSx9DQ7cLo08sRj6Y4Pyn8vzdDaejatBhL/JIu2Dgd/CqzyS2
         Bsoe0xt08Rzi1co0RnoVrjOgYQSgBrLzEuJg5+/f6mMHxthHe5G2TjDAY07CSrkjJo
         b+kShqKciXVcFRKEe8Z+POigPhJbwkeJik7CNtAA1arxbSS0wpgEMRqJQ5AlUHT74Z
         4qkPdy1lDdcv4EQkG4rOlFUq0Y8gsD7wZ7AWQnoxU+91uG5kTm32BUta5KIf2/+7JF
         bRySXshL7fWRJBWyojd4U6mzkfO2jnY6lkhS2a5UFHQfBQu1IHed6zogmnxc030HIq
         u2cyZragOaBXQ==
Subject: [PATCH v2 38/41] SUNRPC: Add KDF-HMAC-SHA2 Kunit tests
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:24:18 -0500
Message-ID: <167380345893.10651.18292121688919694238.stgit@bazille.1015granger.net>
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

RFC 8009 provides sample key derivation results, so Kunit tests are
added to ensure our implementation derives the expected keys for the
provided sample input.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/.kunitconfig             |    3 +
 net/sunrpc/auth_gss/gss_krb5_test.c |  113 +++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/.kunitconfig b/net/sunrpc/.kunitconfig
index 90d0ad430e7e..a55a00fa649b 100644
--- a/net/sunrpc/.kunitconfig
+++ b/net/sunrpc/.kunitconfig
@@ -14,6 +14,8 @@ CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_CMAC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_CAMELLIA=y
@@ -24,4 +26,5 @@ CONFIG_RPCSEC_GSS_KRB5=y
 CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES=y
 CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
 CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA=y
+CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2=y
 CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=y
diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss_krb5_test.c
index 3d8d41aab5fe..ad4737b60b56 100644
--- a/net/sunrpc/auth_gss/gss_krb5_test.c
+++ b/net/sunrpc/auth_gss/gss_krb5_test.c
@@ -1417,9 +1417,120 @@ static struct kunit_suite rfc6803_suite = {
 	.test_cases		= rfc6803_test_cases,
 };
 
+/*
+ * From RFC 8009 Appendix A.  Test Vectors
+ *
+ * Sample results for SHA-2 enctype key derivation
+ *
+ * This test material is copyright (c) 2016 IETF Trust and the
+ * persons identified as the document authors.  All rights reserved.
+ */
+
+DEFINE_HEX_XDR_NETOBJ(aes128_cts_hmac_sha256_128_basekey,
+		      0x37, 0x05, 0xd9, 0x60, 0x80, 0xc1, 0x77, 0x28,
+		      0xa0, 0xe8, 0x00, 0xea, 0xb6, 0xe0, 0xd2, 0x3c
+);
+DEFINE_HEX_XDR_NETOBJ(aes128_cts_hmac_sha256_128_Kc,
+		      0xb3, 0x1a, 0x01, 0x8a, 0x48, 0xf5, 0x47, 0x76,
+		      0xf4, 0x03, 0xe9, 0xa3, 0x96, 0x32, 0x5d, 0xc3
+);
+DEFINE_HEX_XDR_NETOBJ(aes128_cts_hmac_sha256_128_Ke,
+		      0x9b, 0x19, 0x7d, 0xd1, 0xe8, 0xc5, 0x60, 0x9d,
+		      0x6e, 0x67, 0xc3, 0xe3, 0x7c, 0x62, 0xc7, 0x2e
+);
+DEFINE_HEX_XDR_NETOBJ(aes128_cts_hmac_sha256_128_Ki,
+		      0x9f, 0xda, 0x0e, 0x56, 0xab, 0x2d, 0x85, 0xe1,
+		      0x56, 0x9a, 0x68, 0x86, 0x96, 0xc2, 0x6a, 0x6c
+);
+
+DEFINE_HEX_XDR_NETOBJ(aes256_cts_hmac_sha384_192_basekey,
+		      0x6d, 0x40, 0x4d, 0x37, 0xfa, 0xf7, 0x9f, 0x9d,
+		      0xf0, 0xd3, 0x35, 0x68, 0xd3, 0x20, 0x66, 0x98,
+		      0x00, 0xeb, 0x48, 0x36, 0x47, 0x2e, 0xa8, 0xa0,
+		      0x26, 0xd1, 0x6b, 0x71, 0x82, 0x46, 0x0c, 0x52
+);
+DEFINE_HEX_XDR_NETOBJ(aes256_cts_hmac_sha384_192_Kc,
+		      0xef, 0x57, 0x18, 0xbe, 0x86, 0xcc, 0x84, 0x96,
+		      0x3d, 0x8b, 0xbb, 0x50, 0x31, 0xe9, 0xf5, 0xc4,
+		      0xba, 0x41, 0xf2, 0x8f, 0xaf, 0x69, 0xe7, 0x3d
+);
+DEFINE_HEX_XDR_NETOBJ(aes256_cts_hmac_sha384_192_Ke,
+		      0x56, 0xab, 0x22, 0xbe, 0xe6, 0x3d, 0x82, 0xd7,
+		      0xbc, 0x52, 0x27, 0xf6, 0x77, 0x3f, 0x8e, 0xa7,
+		      0xa5, 0xeb, 0x1c, 0x82, 0x51, 0x60, 0xc3, 0x83,
+		      0x12, 0x98, 0x0c, 0x44, 0x2e, 0x5c, 0x7e, 0x49
+);
+DEFINE_HEX_XDR_NETOBJ(aes256_cts_hmac_sha384_192_Ki,
+		      0x69, 0xb1, 0x65, 0x14, 0xe3, 0xcd, 0x8e, 0x56,
+		      0xb8, 0x20, 0x10, 0xd5, 0xc7, 0x30, 0x12, 0xb6,
+		      0x22, 0xc4, 0xd0, 0x0f, 0xfc, 0x23, 0xed, 0x1f
+);
+
+static const struct gss_krb5_test_param rfc8009_kdf_test_params[] = {
+	{
+		.desc			= "Derive Kc subkey for aes128-cts-hmac-sha256-128",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.base_key		= &aes128_cts_hmac_sha256_128_basekey,
+		.usage			= &usage_checksum,
+		.expected_result	= &aes128_cts_hmac_sha256_128_Kc,
+	},
+	{
+		.desc			= "Derive Ke subkey for aes128-cts-hmac-sha256-128",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.base_key		= &aes128_cts_hmac_sha256_128_basekey,
+		.usage			= &usage_encryption,
+		.expected_result	= &aes128_cts_hmac_sha256_128_Ke,
+	},
+	{
+		.desc			= "Derive Ki subkey for aes128-cts-hmac-sha256-128",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.base_key		= &aes128_cts_hmac_sha256_128_basekey,
+		.usage			= &usage_integrity,
+		.expected_result	= &aes128_cts_hmac_sha256_128_Ki,
+	},
+	{
+		.desc			= "Derive Kc subkey for aes256-cts-hmac-sha384-192",
+		.enctype		= ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.base_key		= &aes256_cts_hmac_sha384_192_basekey,
+		.usage			= &usage_checksum,
+		.expected_result	= &aes256_cts_hmac_sha384_192_Kc,
+	},
+	{
+		.desc			= "Derive Ke subkey for aes256-cts-hmac-sha384-192",
+		.enctype		= ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.base_key		= &aes256_cts_hmac_sha384_192_basekey,
+		.usage			= &usage_encryption,
+		.expected_result	= &aes256_cts_hmac_sha384_192_Ke,
+	},
+	{
+		.desc			= "Derive Ki subkey for aes256-cts-hmac-sha384-192",
+		.enctype		= ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.base_key		= &aes256_cts_hmac_sha384_192_basekey,
+		.usage			= &usage_integrity,
+		.expected_result	= &aes256_cts_hmac_sha384_192_Ki,
+	},
+};
+
+/* Creates the function rfc8009_kdf_gen_params */
+KUNIT_ARRAY_PARAM(rfc8009_kdf, rfc8009_kdf_test_params, gss_krb5_get_desc);
+
+static struct kunit_case rfc8009_test_cases[] = {
+	{
+		.name			= "RFC 8009 key derivation",
+		.run_case		= kdf_case,
+		.generate_params	= rfc8009_kdf_gen_params,
+	},
+};
+
+static struct kunit_suite rfc8009_suite = {
+	.name			= "RFC 8009 suite",
+	.test_cases		= rfc8009_test_cases,
+};
+
 kunit_test_suites(&rfc3961_suite,
 		  &rfc3962_suite,
-		  &rfc6803_suite);
+		  &rfc6803_suite,
+		  &rfc8009_suite);
 
 MODULE_DESCRIPTION("Test RPCSEC GSS Kerberos 5 functions");
 MODULE_LICENSE("GPL");


