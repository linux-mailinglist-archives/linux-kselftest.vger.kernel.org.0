Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED3466B31B
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjAORYD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjAORYC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:24:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A52E76BB;
        Sun, 15 Jan 2023 09:24:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88A2860DB5;
        Sun, 15 Jan 2023 17:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A7EC433D2;
        Sun, 15 Jan 2023 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803441;
        bh=H89GNPbBgVD2Kdw9S2vRAbQpCE7nUW0D6NftAWIV6+s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jNzwsbkDOtVq4U/WxNttLpd3PrWyjmHWpYe+NGvwA6UCqDw/rW0/C4od+fyvnyZlr
         OeHt2SmhA5wayQ7Bv5rR2c6esUOOS5AJUnvFox5Mxi4S6fxtSbk3uzEubn/367K+OQ
         ZvZnhCpbZ8hronAPp1Dctf7uzSNwc3dbzdDv2I+JxcN7yJD6Qi/+95nx97/Wsm1Tzl
         cn8gF4F7lTd94RmlSeC/rkhQijq5Sq4IUsKWwNageAnP6WyT7srQkGNGxSqLRZlTw+
         DgO8aULoXmFxTPtI/ssCW9NozSHLaOVFy1Sl/DJT6QdqMjfp+QMUx7nzWQu1AHYuSD
         iy7oPExQ/fPAQ==
Subject: [PATCH v2 35/41] SUNRPC: Add KDF KUnit tests for the RFC 6803
 encryption types
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:23:59 -0500
Message-ID: <167380343971.10651.9447400052845040911.stgit@bazille.1015granger.net>
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

The Camellia enctypes use a new KDF, so add some tests to ensure it
is working properly.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/.kunitconfig             |    3 +
 net/sunrpc/auth_gss/gss_krb5_test.c |  125 +++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/.kunitconfig b/net/sunrpc/.kunitconfig
index 01e12729f465..90d0ad430e7e 100644
--- a/net/sunrpc/.kunitconfig
+++ b/net/sunrpc/.kunitconfig
@@ -11,14 +11,17 @@ CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_CTS=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_CMAC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_AES=y
+CONFIG_CRYPTO_CAMELLIA=y
 CONFIG_NFS_FS=y
 CONFIG_SUNRPC=y
 CONFIG_SUNRPC_GSS=y
 CONFIG_RPCSEC_GSS_KRB5=y
 CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES=y
 CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
+CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA=y
 CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=y
diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss_krb5_test.c
index 2f7e31b8004e..c80a8f6588c0 100644
--- a/net/sunrpc/auth_gss/gss_krb5_test.c
+++ b/net/sunrpc/auth_gss/gss_krb5_test.c
@@ -727,8 +727,131 @@ static struct kunit_suite rfc3962_suite = {
 	.test_cases		= rfc3962_test_cases,
 };
 
+/*
+ * From RFC 6803 Section 10.  Test vectors
+ *
+ * Sample results for key derivation
+ *
+ * Copyright (c) 2012 IETF Trust and the persons identified as the
+ * document authors.  All rights reserved.
+ */
+
+DEFINE_HEX_XDR_NETOBJ(camellia128_cts_cmac_basekey,
+		      0x57, 0xd0, 0x29, 0x72, 0x98, 0xff, 0xd9, 0xd3,
+		      0x5d, 0xe5, 0xa4, 0x7f, 0xb4, 0xbd, 0xe2, 0x4b
+);
+DEFINE_HEX_XDR_NETOBJ(camellia128_cts_cmac_Kc,
+		      0xd1, 0x55, 0x77, 0x5a, 0x20, 0x9d, 0x05, 0xf0,
+		      0x2b, 0x38, 0xd4, 0x2a, 0x38, 0x9e, 0x5a, 0x56
+);
+DEFINE_HEX_XDR_NETOBJ(camellia128_cts_cmac_Ke,
+		      0x64, 0xdf, 0x83, 0xf8, 0x5a, 0x53, 0x2f, 0x17,
+		      0x57, 0x7d, 0x8c, 0x37, 0x03, 0x57, 0x96, 0xab
+);
+DEFINE_HEX_XDR_NETOBJ(camellia128_cts_cmac_Ki,
+		      0x3e, 0x4f, 0xbd, 0xf3, 0x0f, 0xb8, 0x25, 0x9c,
+		      0x42, 0x5c, 0xb6, 0xc9, 0x6f, 0x1f, 0x46, 0x35
+);
+
+DEFINE_HEX_XDR_NETOBJ(camellia256_cts_cmac_basekey,
+		      0xb9, 0xd6, 0x82, 0x8b, 0x20, 0x56, 0xb7, 0xbe,
+		      0x65, 0x6d, 0x88, 0xa1, 0x23, 0xb1, 0xfa, 0xc6,
+		      0x82, 0x14, 0xac, 0x2b, 0x72, 0x7e, 0xcf, 0x5f,
+		      0x69, 0xaf, 0xe0, 0xc4, 0xdf, 0x2a, 0x6d, 0x2c
+);
+DEFINE_HEX_XDR_NETOBJ(camellia256_cts_cmac_Kc,
+		      0xe4, 0x67, 0xf9, 0xa9, 0x55, 0x2b, 0xc7, 0xd3,
+		      0x15, 0x5a, 0x62, 0x20, 0xaf, 0x9c, 0x19, 0x22,
+		      0x0e, 0xee, 0xd4, 0xff, 0x78, 0xb0, 0xd1, 0xe6,
+		      0xa1, 0x54, 0x49, 0x91, 0x46, 0x1a, 0x9e, 0x50
+);
+DEFINE_HEX_XDR_NETOBJ(camellia256_cts_cmac_Ke,
+		      0x41, 0x2a, 0xef, 0xc3, 0x62, 0xa7, 0x28, 0x5f,
+		      0xc3, 0x96, 0x6c, 0x6a, 0x51, 0x81, 0xe7, 0x60,
+		      0x5a, 0xe6, 0x75, 0x23, 0x5b, 0x6d, 0x54, 0x9f,
+		      0xbf, 0xc9, 0xab, 0x66, 0x30, 0xa4, 0xc6, 0x04
+);
+DEFINE_HEX_XDR_NETOBJ(camellia256_cts_cmac_Ki,
+		      0xfa, 0x62, 0x4f, 0xa0, 0xe5, 0x23, 0x99, 0x3f,
+		      0xa3, 0x88, 0xae, 0xfd, 0xc6, 0x7e, 0x67, 0xeb,
+		      0xcd, 0x8c, 0x08, 0xe8, 0xa0, 0x24, 0x6b, 0x1d,
+		      0x73, 0xb0, 0xd1, 0xdd, 0x9f, 0xc5, 0x82, 0xb0
+);
+
+DEFINE_HEX_XDR_NETOBJ(usage_checksum,
+		      0x00, 0x00, 0x00, 0x02, KEY_USAGE_SEED_CHECKSUM
+);
+DEFINE_HEX_XDR_NETOBJ(usage_encryption,
+		      0x00, 0x00, 0x00, 0x02, KEY_USAGE_SEED_ENCRYPTION
+);
+DEFINE_HEX_XDR_NETOBJ(usage_integrity,
+		      0x00, 0x00, 0x00, 0x02, KEY_USAGE_SEED_INTEGRITY
+);
+
+static const struct gss_krb5_test_param rfc6803_kdf_test_params[] = {
+	{
+		.desc			= "Derive Kc subkey for camellia128-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.base_key		= &camellia128_cts_cmac_basekey,
+		.usage			= &usage_checksum,
+		.expected_result	= &camellia128_cts_cmac_Kc,
+	},
+	{
+		.desc			= "Derive Ke subkey for camellia128-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.base_key		= &camellia128_cts_cmac_basekey,
+		.usage			= &usage_encryption,
+		.expected_result	= &camellia128_cts_cmac_Ke,
+	},
+	{
+		.desc			= "Derive Ki subkey for camellia128-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.base_key		= &camellia128_cts_cmac_basekey,
+		.usage			= &usage_integrity,
+		.expected_result	= &camellia128_cts_cmac_Ki,
+	},
+	{
+		.desc			= "Derive Kc subkey for camellia256-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.base_key		= &camellia256_cts_cmac_basekey,
+		.usage			= &usage_checksum,
+		.expected_result	= &camellia256_cts_cmac_Kc,
+	},
+	{
+		.desc			= "Derive Ke subkey for camellia256-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.base_key		= &camellia256_cts_cmac_basekey,
+		.usage			= &usage_encryption,
+		.expected_result	= &camellia256_cts_cmac_Ke,
+	},
+	{
+		.desc			= "Derive Ki subkey for camellia256-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.base_key		= &camellia256_cts_cmac_basekey,
+		.usage			= &usage_integrity,
+		.expected_result	= &camellia256_cts_cmac_Ki,
+	},
+};
+
+/* Creates the function rfc6803_kdf_gen_params */
+KUNIT_ARRAY_PARAM(rfc6803_kdf, rfc6803_kdf_test_params, gss_krb5_get_desc);
+
+static struct kunit_case rfc6803_test_cases[] = {
+	{
+		.name			= "RFC 6803 key derivation",
+		.run_case		= kdf_case,
+		.generate_params	= rfc6803_kdf_gen_params,
+	},
+};
+
+static struct kunit_suite rfc6803_suite = {
+	.name			= "RFC 6803 suite",
+	.test_cases		= rfc6803_test_cases,
+};
+
 kunit_test_suites(&rfc3961_suite,
-		  &rfc3962_suite);
+		  &rfc3962_suite,
+		  &rfc6803_suite);
 
 MODULE_DESCRIPTION("Test RPCSEC GSS Kerberos 5 functions");
 MODULE_LICENSE("GPL");


