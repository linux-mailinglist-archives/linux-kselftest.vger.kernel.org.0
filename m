Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29C666B303
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjAORWt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjAORWs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:22:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0255D10AA3;
        Sun, 15 Jan 2023 09:22:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B29CDB80B44;
        Sun, 15 Jan 2023 17:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220DEC433EF;
        Sun, 15 Jan 2023 17:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803364;
        bh=2srKmPaKM0iP/835UYP+iqVGCN8xpo3/FyKC5VfF2Gw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R+VPSunFDBuSKtv7mPl7Act/9fOuoFBk+WH4Mm3j0LyBiQNmT838J+AUyOHaNX1HM
         8E8iwzKRPsdpzUylLsaEARIx4NBmIbbWYf4aeeokNlEwcLmgUNl6F5yT6FwLhye4ti
         BZ5zKuD241LrUISQe+71iweRpPMZwPQ3xOn0bHCWFrOVYtjcAarAPkDC9c+dobn0A4
         MMmpU3+GtEPvw9JxTsZ88XFTPDeVwvvxaikwa0qIGD36gv0AAiOmbpuM1TT3ei4B6I
         u9bwT5EaCxK3G97CESLLeAAEqXo2cCQ62jiH1xWCrFW6soCelB2i6CYRHmV8zQBCct
         XyKaZ6xWxjaMQ==
Subject: [PATCH v2 23/41] SUNRPC: Add gk5e definitions for RFC 8009 encryption
 types
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:22:43 -0500
Message-ID: <167380336323.10651.16305246945409527645.stgit@bazille.1015granger.net>
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

Fill in entries in the supported_gss_krb5_enctypes array for the
encryption types defined in RFC 8009. These new enctypes use the
SHA-256 and SHA-384 message digest algorithms (as defined in
FIPS-180) instead of the deprecated SHA-1 algorithm, and are thus
more secure.

Note that NIST has scheduled SHA-1 for deprecation:

https://www.nist.gov/news-events/news/2022/12/nist-retires-sha-1-cryptographic-algorithm

Thus these new encryption types are placed under a separate CONFIG
option to enable distributors to separately introduce support for
the AES-SHA2 enctypes and deprecate support for the current set of
AES-SHA1 encryption types as their user space allows.

As this implementation is still a "beta", the default is to not
build it automatically.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h     |   19 ++++++++++++-
 net/sunrpc/Kconfig                  |   14 ++++++++++
 net/sunrpc/auth_gss/gss_krb5_mech.c |   51 +++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 3e97d2a7c87d..8ff397b5c04b 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -54,8 +54,8 @@
 /* Maximum key length (in bytes) for the supported crypto algorithms */
 #define GSS_KRB5_MAX_KEYLEN (32)
 
-/* Maximum checksum function output for the supported crypto algorithms */
-#define GSS_KRB5_MAX_CKSUM_LEN  (20)
+/* Maximum checksum function output for the supported enctypes */
+#define GSS_KRB5_MAX_CKSUM_LEN  (24)
 
 /* Maximum blocksize for the supported crypto algorithms */
 #define GSS_KRB5_MAX_BLOCKSIZE  (16)
@@ -160,6 +160,12 @@ enum seal_alg {
 	SEAL_ALG_DES3KD = 0x0002
 };
 
+/*
+ * These values are assigned by IANA and published via the
+ * subregistry at the link below:
+ *
+ * https://www.iana.org/assignments/kerberos-parameters/kerberos-parameters.xhtml#kerberos-parameters-2
+ */
 #define CKSUMTYPE_CRC32			0x0001
 #define CKSUMTYPE_RSA_MD4		0x0002
 #define CKSUMTYPE_RSA_MD4_DES		0x0003
@@ -170,6 +176,8 @@ enum seal_alg {
 #define CKSUMTYPE_HMAC_SHA1_DES3	0x000c
 #define CKSUMTYPE_HMAC_SHA1_96_AES128   0x000f
 #define CKSUMTYPE_HMAC_SHA1_96_AES256   0x0010
+#define CKSUMTYPE_HMAC_SHA256_128_AES128	0x0013
+#define CKSUMTYPE_HMAC_SHA384_192_AES256	0x0014
 #define CKSUMTYPE_HMAC_MD5_ARCFOUR      -138 /* Microsoft md5 hmac cksumtype */
 
 /* from gssapi_err_krb5.h */
@@ -190,6 +198,11 @@ enum seal_alg {
 
 /* per Kerberos v5 protocol spec crypto types from the wire. 
  * these get mapped to linux kernel crypto routines.  
+ *
+ * These values are assigned by IANA and published via the
+ * subregistry at the link below:
+ *
+ * https://www.iana.org/assignments/kerberos-parameters/kerberos-parameters.xhtml#kerberos-parameters-1
  */
 #define ENCTYPE_NULL            0x0000
 #define ENCTYPE_DES_CBC_CRC     0x0001	/* DES cbc mode with CRC-32 */
@@ -203,6 +216,8 @@ enum seal_alg {
 #define ENCTYPE_DES3_CBC_SHA1   0x0010
 #define ENCTYPE_AES128_CTS_HMAC_SHA1_96 0x0011
 #define ENCTYPE_AES256_CTS_HMAC_SHA1_96 0x0012
+#define ENCTYPE_AES128_CTS_HMAC_SHA256_128	0x0013
+#define ENCTYPE_AES256_CTS_HMAC_SHA384_192	0x0014
 #define ENCTYPE_ARCFOUR_HMAC            0x0017
 #define ENCTYPE_ARCFOUR_HMAC_EXP        0x0018
 #define ENCTYPE_UNKNOWN         0x01ff
diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
index 1135ff362132..b1aa2318e1dc 100644
--- a/net/sunrpc/Kconfig
+++ b/net/sunrpc/Kconfig
@@ -76,6 +76,20 @@ config RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1
 	  SHA-1 digests. These include aes128-cts-hmac-sha1-96 and
 	  aes256-cts-hmac-sha1-96.
 
+config RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2
+	bool "Enable Kerberos enctypes based on AES and SHA-2"
+	depends on RPCSEC_GSS_KRB5
+	depends on CRYPTO_CBC && CRYPTO_CTS
+	depends on CRYPTO_HMAC && CRYPTO_SHA256 && CRYPTO_SHA512
+	depends on CRYPTO_AES
+	default n
+	select RPCSEC_GSS_KRB5_CRYPTOSYSTEM
+	help
+	  Choose Y to enable the use of Kerberos 5 encryption types
+	  that utilize Advanced Encryption Standard (AES) ciphers and
+	  SHA-2 digests. These include aes128-cts-hmac-sha256-128 and
+	  aes256-cts-hmac-sha384-192.
+
 config SUNRPC_DEBUG
 	bool "RPC: Enable dprintk debugging"
 	depends on SUNRPC && SYSCTL
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index ec3cca8fadc5..1951867f3fa8 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -146,6 +146,57 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .keyed_cksum = 1,
 	},
 #endif
+
+#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2)
+	/*
+	 * AES-128 with SHA-256 (RFC 8009)
+	 */
+	{
+		.etype		= ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.ctype		= CKSUMTYPE_HMAC_SHA256_128_AES128,
+		.name		= "aes128-cts-hmac-sha256-128",
+		.encrypt_name	= "cts(cbc(aes))",
+		.aux_cipher	= "cbc(aes)",
+		.cksum_name	= "hmac(sha256)",
+		.cksumlength	= BITS2OCTETS(128),
+		.keyed_cksum	= 1,
+		.keylength	= BITS2OCTETS(128),
+		.Kc_length	= BITS2OCTETS(128),
+		.Ke_length	= BITS2OCTETS(128),
+		.Ki_length	= BITS2OCTETS(128),
+
+		.import_ctx	= gss_krb5_import_ctx_v2,
+
+		.get_mic	= gss_krb5_get_mic_v2,
+		.verify_mic	= gss_krb5_verify_mic_v2,
+		.wrap		= gss_krb5_wrap_v2,
+		.unwrap		= gss_krb5_unwrap_v2,
+	},
+	/*
+	 * AES-256 with SHA-384 (RFC 8009)
+	 */
+	{
+		.etype		= ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.ctype		= CKSUMTYPE_HMAC_SHA384_192_AES256,
+		.name		= "aes256-cts-hmac-sha384-192",
+		.encrypt_name	= "cts(cbc(aes))",
+		.aux_cipher	= "cbc(aes)",
+		.cksum_name	= "hmac(sha384)",
+		.cksumlength	= BITS2OCTETS(192),
+		.keyed_cksum	= 1,
+		.keylength	= BITS2OCTETS(256),
+		.Kc_length	= BITS2OCTETS(192),
+		.Ke_length	= BITS2OCTETS(256),
+		.Ki_length	= BITS2OCTETS(192),
+
+		.import_ctx	= gss_krb5_import_ctx_v2,
+
+		.get_mic	= gss_krb5_get_mic_v2,
+		.verify_mic	= gss_krb5_verify_mic_v2,
+		.wrap		= gss_krb5_wrap_v2,
+		.unwrap		= gss_krb5_unwrap_v2,
+	},
+#endif
 };
 
 /*


