Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A92F66B30B
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjAORXM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjAORXL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:23:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FF276BB;
        Sun, 15 Jan 2023 09:23:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7403D60DB5;
        Sun, 15 Jan 2023 17:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E60C433D2;
        Sun, 15 Jan 2023 17:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803389;
        bh=Jlg66vxg3W43j3tYt7vzFrl+OZjxf9aBpjHbmjIIEYk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WMG0sOkUlNNt7XScLX2zQomenVKSn2HDBuaH035ysEmtwKtz9DNCW7fUpzGOmGhsn
         zaUH6YFkLnwNSqtrYcEGza3IQPseAPvrW0Kh4ljsj1Z4bLuiPE2kwNlVjoWAk2ktrK
         oIPWArcRu3zzbMFa84BlzB1aa/YE0XWbIGxmd4ObUcyPZKs6b7z15j6exEMwc+A/6A
         C+ZncCYs8o91ulHUKH2TQZlaoQlHAcMlZl5OP+ZsDCxOPbWdITmfIQREjANriMH8OH
         K+JyYVmeNtm4mj/Vfj+7A6CaZPeeb0JD1OK7M8SbMmQjmeCIVkDoG6qSPm3n98HxbT
         8OS2VVNEL0DqQ==
Subject: [PATCH v2 27/41] SUNRPC: Support the Camellia enctypes
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:23:08 -0500
Message-ID: <167380338876.10651.2238029008488959799.stgit@bazille.1015granger.net>
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

RFC 6803 defines two encryption types that use Camellia ciphers (RFC
3713) and CMAC digests. Implement support for those in SunRPC's GSS
Kerberos 5 mechanism.

There has not been an explicit request to support these enctypes.
However, this new set of enctypes provides a good alternative to the
AES-SHA1 enctypes that are to be deprecated at some point.

As this implementation is still a "beta", the default is to not
build it automatically.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h     |    4 +++
 net/sunrpc/Kconfig                  |   13 ++++++++
 net/sunrpc/auth_gss/gss_krb5_mech.c |   55 +++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 8ff397b5c04b..cbb6c8192890 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -176,6 +176,8 @@ enum seal_alg {
 #define CKSUMTYPE_HMAC_SHA1_DES3	0x000c
 #define CKSUMTYPE_HMAC_SHA1_96_AES128   0x000f
 #define CKSUMTYPE_HMAC_SHA1_96_AES256   0x0010
+#define CKSUMTYPE_CMAC_CAMELLIA128	0x0011
+#define CKSUMTYPE_CMAC_CAMELLIA256	0x0012
 #define CKSUMTYPE_HMAC_SHA256_128_AES128	0x0013
 #define CKSUMTYPE_HMAC_SHA384_192_AES256	0x0014
 #define CKSUMTYPE_HMAC_MD5_ARCFOUR      -138 /* Microsoft md5 hmac cksumtype */
@@ -220,6 +222,8 @@ enum seal_alg {
 #define ENCTYPE_AES256_CTS_HMAC_SHA384_192	0x0014
 #define ENCTYPE_ARCFOUR_HMAC            0x0017
 #define ENCTYPE_ARCFOUR_HMAC_EXP        0x0018
+#define ENCTYPE_CAMELLIA128_CTS_CMAC	0x0019
+#define ENCTYPE_CAMELLIA256_CTS_CMAC	0x001A
 #define ENCTYPE_UNKNOWN         0x01ff
 
 /*
diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
index b1aa2318e1dc..def7e1ce348b 100644
--- a/net/sunrpc/Kconfig
+++ b/net/sunrpc/Kconfig
@@ -76,6 +76,19 @@ config RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1
 	  SHA-1 digests. These include aes128-cts-hmac-sha1-96 and
 	  aes256-cts-hmac-sha1-96.
 
+config RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA
+	bool "Enable Kerberos encryption types based on Camellia and CMAC"
+	depends on RPCSEC_GSS_KRB5
+	depends on CRYPTO_CBC && CRYPTO_CTS && CRYPTO_CAMELLIA
+	depends on CRYPTO_CMAC
+	default n
+	select RPCSEC_GSS_KRB5_CRYPTOSYSTEM
+	help
+	  Choose Y to enable the use of Kerberos 5 encryption types
+	  that utilize Camellia ciphers (RFC 3713) and CMAC digests
+	  (NIST Special Publication 800-38B). These include
+	  camellia128-cts-cmac and camellia256-cts-cmac.
+
 config RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2
 	bool "Enable Kerberos enctypes based on AES and SHA-2"
 	depends on RPCSEC_GSS_KRB5
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 97a365608233..4e7cb49a06de 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -147,6 +147,61 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	},
 #endif
 
+#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA)
+	/*
+	 * Camellia-128 with CMAC (RFC 6803)
+	 */
+	{
+		.etype		= ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.ctype		= CKSUMTYPE_CMAC_CAMELLIA128,
+		.name		= "camellia128-cts-cmac",
+		.encrypt_name	= "cts(cbc(camellia))",
+		.aux_cipher	= "cbc(camellia)",
+		.cksum_name	= "cmac(camellia)",
+		.cksumlength	= BITS2OCTETS(128),
+		.keyed_cksum	= 1,
+		.keylength	= BITS2OCTETS(128),
+		.Kc_length	= BITS2OCTETS(128),
+		.Ke_length	= BITS2OCTETS(128),
+		.Ki_length	= BITS2OCTETS(128),
+
+		.import_ctx	= gss_krb5_import_ctx_v2,
+		.encrypt	= gss_krb5_aes_encrypt,
+		.decrypt	= gss_krb5_aes_decrypt,
+
+		.get_mic	= gss_krb5_get_mic_v2,
+		.verify_mic	= gss_krb5_verify_mic_v2,
+		.wrap		= gss_krb5_wrap_v2,
+		.unwrap		= gss_krb5_unwrap_v2,
+	},
+	/*
+	 * Camellia-256 with CMAC (RFC 6803)
+	 */
+	{
+		.etype		= ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.ctype		= CKSUMTYPE_CMAC_CAMELLIA256,
+		.name		= "camellia256-cts-cmac",
+		.encrypt_name	= "cts(cbc(camellia))",
+		.aux_cipher	= "cbc(camellia)",
+		.cksum_name	= "cmac(camellia)",
+		.cksumlength	= BITS2OCTETS(128),
+		.keyed_cksum	= 1,
+		.keylength	= BITS2OCTETS(256),
+		.Kc_length	= BITS2OCTETS(256),
+		.Ke_length	= BITS2OCTETS(256),
+		.Ki_length	= BITS2OCTETS(256),
+
+		.import_ctx	= gss_krb5_import_ctx_v2,
+		.encrypt	= gss_krb5_aes_encrypt,
+		.decrypt	= gss_krb5_aes_decrypt,
+
+		.get_mic	= gss_krb5_get_mic_v2,
+		.verify_mic	= gss_krb5_verify_mic_v2,
+		.wrap		= gss_krb5_wrap_v2,
+		.unwrap		= gss_krb5_unwrap_v2,
+	},
+#endif
+
 #if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2)
 	/*
 	 * AES-128 with SHA-256 (RFC 8009)


