Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B31F66B313
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjAORXl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjAORXj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:23:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E351041F;
        Sun, 15 Jan 2023 09:23:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7341B80B40;
        Sun, 15 Jan 2023 17:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D03DC433D2;
        Sun, 15 Jan 2023 17:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803415;
        bh=0FoBf2sjDheQfj32WNuuwWqRQe1dDhI40cDLo8KD18I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=t4W2a9ZVbYZequnlAUlVg7H3KAMu7B88DwbEUxIr08MvX7/Bpk9X+PraK84dLdhsX
         8p6WuI7U+At/k6s9vYrIREDsbFI//Ck0MUp2iBGaovbxSvLpnzPU66afKG8ttGFtb7
         YlV3i2fYUcMtcIqqCBQnYkNLr5bCR0KbT5AqZ98nHWdR2SEyxu9LSb5VhP/CIWeaCZ
         6Aqlow4vmYxCJ3Ooeo9frspa7C9DQrKWrqDjj7ITJzx76vLhrAW+q2FBYa1jRi9U/E
         WpofRm9OFVqPaS66Ng5NHDpXM7mL3wcloEkTa6AMJDKGzYoPk/6uUCcxc+z63gIUwi
         WDSQLh9flIQxg==
Subject: [PATCH v2 31/41] SUNRPC: Add KUnit tests for rpcsec_krb5.ko
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:23:34 -0500
Message-ID: <167380341422.10651.7617772621466313010.stgit@bazille.1015granger.net>
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

The Kerberos RFCs provide test vectors to verify the operation of
an implementation. Introduce a KUnit test framework to exercise the
Linux kernel's implementation of Kerberos.

Start with test cases for the RFC 3961-defined n-fold function. The
sample vectors for that are found in RFC 3961 Section 10.

Run the GSS Kerberos 5 mechanism's unit tests with this command:

$ ./tools/testing/kunit/kunit.py run \
	--kunitconfig ./net/sunrpc/.kunitconfig

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/.kunitconfig                 |   22 +++
 net/sunrpc/Kconfig                      |   15 ++
 net/sunrpc/auth_gss/Makefile            |    2 
 net/sunrpc/auth_gss/gss_krb5_internal.h |    4 +
 net/sunrpc/auth_gss/gss_krb5_keys.c     |   15 +-
 net/sunrpc/auth_gss/gss_krb5_test.c     |  244 +++++++++++++++++++++++++++++++
 6 files changed, 298 insertions(+), 4 deletions(-)
 create mode 100644 net/sunrpc/.kunitconfig
 create mode 100644 net/sunrpc/auth_gss/gss_krb5_test.c

diff --git a/net/sunrpc/.kunitconfig b/net/sunrpc/.kunitconfig
new file mode 100644
index 000000000000..dc9abe4faa4f
--- /dev/null
+++ b/net/sunrpc/.kunitconfig
@@ -0,0 +1,22 @@
+CONFIG_KUNIT=y
+CONFIG_UBSAN=y
+CONFIG_STACKTRACE=y
+CONFIG_NET=y
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_INET=y
+CONFIG_FILE_LOCKING=y
+CONFIG_MULTIUSER=y
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_CTS=y
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_DES=y
+CONFIG_NFS_FS=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+CONFIG_RPCSEC_GSS_KRB5=y
+CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES=y
+CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=y
diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
index def7e1ce348b..214e07e39f7b 100644
--- a/net/sunrpc/Kconfig
+++ b/net/sunrpc/Kconfig
@@ -103,6 +103,21 @@ config RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2
 	  SHA-2 digests. These include aes128-cts-hmac-sha256-128 and
 	  aes256-cts-hmac-sha384-192.
 
+config RPCSEC_GSS_KRB5_KUNIT_TEST
+	tristate "KUnit tests for RPCSEC GSS Kerberos" if !KUNIT_ALL_TESTS
+	depends on RPCSEC_GSS_KRB5 && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the KUnit tests for RPCSEC GSS Kerberos 5.
+
+	  KUnit tests run during boot and output the results to the debug
+	  log in TAP format (https://testanything.org/). Only useful for
+	  kernel devs running KUnit test harness and are not for inclusion
+	  into a production build.
+
+	  For more information on KUnit and unit tests in general, refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
 config SUNRPC_DEBUG
 	bool "RPC: Enable dprintk debugging"
 	depends on SUNRPC && SYSCTL
diff --git a/net/sunrpc/auth_gss/Makefile b/net/sunrpc/auth_gss/Makefile
index 4a29f4c5dac4..012ae1720689 100644
--- a/net/sunrpc/auth_gss/Makefile
+++ b/net/sunrpc/auth_gss/Makefile
@@ -13,3 +13,5 @@ obj-$(CONFIG_RPCSEC_GSS_KRB5) += rpcsec_gss_krb5.o
 
 rpcsec_gss_krb5-y := gss_krb5_mech.o gss_krb5_seal.o gss_krb5_unseal.o \
 	gss_krb5_seqnum.o gss_krb5_wrap.o gss_krb5_crypto.o gss_krb5_keys.o
+
+obj-$(CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST) += gss_krb5_test.o
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 850748f6733a..9aba1647c205 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -214,4 +214,8 @@ u32 krb5_etm_encrypt(struct krb5_ctx *kctx, u32 offset, struct xdr_buf *buf,
 u32 krb5_etm_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 		     struct xdr_buf *buf, u32 *headskip, u32 *tailskip);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+void krb5_nfold(u32 inbits, const u8 *in, u32 outbits, u8 *out);
+#endif
+
 #endif /* _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
index 99251f15723a..5347fe1cc93f 100644
--- a/net/sunrpc/auth_gss/gss_krb5_keys.c
+++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
@@ -61,6 +61,7 @@
 #include <linux/sunrpc/xdr.h>
 #include <linux/lcm.h>
 #include <crypto/hash.h>
+#include <kunit/visibility.h>
 
 #include "gss_krb5_internal.h"
 
@@ -68,13 +69,18 @@
 # define RPCDBG_FACILITY        RPCDBG_AUTH
 #endif
 
-/*
+/**
+ * krb5_nfold - n-fold function
+ * @inbits: number of bits in @in
+ * @in: buffer containing input to fold
+ * @outbits: number of bits in the output buffer
+ * @out: buffer to hold the result
+ *
  * This is the n-fold function as described in rfc3961, sec 5.1
  * Taken from MIT Kerberos and modified.
  */
-
-static void krb5_nfold(u32 inbits, const u8 *in,
-		       u32 outbits, u8 *out)
+VISIBLE_IF_KUNIT
+void krb5_nfold(u32 inbits, const u8 *in, u32 outbits, u8 *out)
 {
 	unsigned long ulcm;
 	int byte, i, msbit;
@@ -135,6 +141,7 @@ static void krb5_nfold(u32 inbits, const u8 *in,
 		}
 	}
 }
+EXPORT_SYMBOL_IF_KUNIT(krb5_nfold);
 
 /*
  * This is the DK (derive_key) function as described in rfc3961, sec 5.1
diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss_krb5_test.c
new file mode 100644
index 000000000000..f67dbf7c8af4
--- /dev/null
+++ b/net/sunrpc/auth_gss/gss_krb5_test.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Oracle and/or its affiliates.
+ *
+ * KUnit test of SunRPC's GSS Kerberos mechanism. Subsystem
+ * name is "rpcsec_gss_krb5".
+ */
+
+#include <kunit/test.h>
+#include <kunit/visibility.h>
+
+#include <linux/kernel.h>
+
+#include <linux/sunrpc/xdr.h>
+#include <linux/sunrpc/gss_krb5.h>
+
+#include "gss_krb5_internal.h"
+
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+
+struct gss_krb5_test_param {
+	const char			*desc;
+	u32				nfold;
+	const struct xdr_netobj         *plaintext;
+	const struct xdr_netobj		*expected_result;
+};
+
+static inline void gss_krb5_get_desc(const struct gss_krb5_test_param *param,
+				     char *desc)
+{
+	strscpy(desc, param->desc, KUNIT_PARAM_DESC_SIZE);
+}
+
+#define DEFINE_HEX_XDR_NETOBJ(name, hex_array...)		\
+	static const u8 name ## _data[] = { hex_array };	\
+	static const struct xdr_netobj name = {			\
+		.data	= (u8 *)name##_data,			\
+		.len	= sizeof(name##_data),			\
+	}
+
+/*
+ * RFC 3961 Appendix A.1.  n-fold
+ *
+ * The n-fold function is defined in section 5.1 of RFC 3961.
+ *
+ * This test material is copyright (C) The Internet Society (2005).
+ */
+
+DEFINE_HEX_XDR_NETOBJ(nfold_test1_plaintext,
+		      0x30, 0x31, 0x32, 0x33, 0x34, 0x35
+);
+DEFINE_HEX_XDR_NETOBJ(nfold_test1_expected_result,
+		      0xbe, 0x07, 0x26, 0x31, 0x27, 0x6b, 0x19, 0x55
+);
+
+DEFINE_HEX_XDR_NETOBJ(nfold_test2_plaintext,
+		      0x70, 0x61, 0x73, 0x73, 0x77, 0x6f, 0x72, 0x64
+);
+DEFINE_HEX_XDR_NETOBJ(nfold_test2_expected_result,
+		      0x78, 0xa0, 0x7b, 0x6c, 0xaf, 0x85, 0xfa
+);
+
+DEFINE_HEX_XDR_NETOBJ(nfold_test3_plaintext,
+		      0x52, 0x6f, 0x75, 0x67, 0x68, 0x20, 0x43, 0x6f,
+		      0x6e, 0x73, 0x65, 0x6e, 0x73, 0x75, 0x73, 0x2c,
+		      0x20, 0x61, 0x6e, 0x64, 0x20, 0x52, 0x75, 0x6e,
+		      0x6e, 0x69, 0x6e, 0x67, 0x20, 0x43, 0x6f, 0x64,
+		      0x65
+);
+DEFINE_HEX_XDR_NETOBJ(nfold_test3_expected_result,
+		      0xbb, 0x6e, 0xd3, 0x08, 0x70, 0xb7, 0xf0, 0xe0
+);
+
+DEFINE_HEX_XDR_NETOBJ(nfold_test4_plaintext,
+		      0x70, 0x61, 0x73, 0x73, 0x77, 0x6f, 0x72, 0x64
+);
+DEFINE_HEX_XDR_NETOBJ(nfold_test4_expected_result,
+		      0x59, 0xe4, 0xa8, 0xca, 0x7c, 0x03, 0x85, 0xc3,
+		      0xc3, 0x7b, 0x3f, 0x6d, 0x20, 0x00, 0x24, 0x7c,
+		      0xb6, 0xe6, 0xbd, 0x5b, 0x3e
+);
+
+DEFINE_HEX_XDR_NETOBJ(nfold_test5_plaintext,
+		      0x4d, 0x41, 0x53, 0x53, 0x41, 0x43, 0x48, 0x56,
+		      0x53, 0x45, 0x54, 0x54, 0x53, 0x20, 0x49, 0x4e,
+		      0x53, 0x54, 0x49, 0x54, 0x56, 0x54, 0x45, 0x20,
+		      0x4f, 0x46, 0x20, 0x54, 0x45, 0x43, 0x48, 0x4e,
+		      0x4f, 0x4c, 0x4f, 0x47, 0x59
+);
+DEFINE_HEX_XDR_NETOBJ(nfold_test5_expected_result,
+		      0xdb, 0x3b, 0x0d, 0x8f, 0x0b, 0x06, 0x1e, 0x60,
+		      0x32, 0x82, 0xb3, 0x08, 0xa5, 0x08, 0x41, 0x22,
+		      0x9a, 0xd7, 0x98, 0xfa, 0xb9, 0x54, 0x0c, 0x1b
+);
+
+DEFINE_HEX_XDR_NETOBJ(nfold_test6_plaintext,
+		      0x51
+);
+DEFINE_HEX_XDR_NETOBJ(nfold_test6_expected_result,
+		      0x51, 0x8a, 0x54, 0xa2, 0x15, 0xa8, 0x45, 0x2a,
+		      0x51, 0x8a, 0x54, 0xa2, 0x15, 0xa8, 0x45, 0x2a,
+		      0x51, 0x8a, 0x54, 0xa2, 0x15
+);
+
+DEFINE_HEX_XDR_NETOBJ(nfold_test7_plaintext,
+		      0x62, 0x61
+);
+DEFINE_HEX_XDR_NETOBJ(nfold_test7_expected_result,
+		      0xfb, 0x25, 0xd5, 0x31, 0xae, 0x89, 0x74, 0x49,
+		      0x9f, 0x52, 0xfd, 0x92, 0xea, 0x98, 0x57, 0xc4,
+		      0xba, 0x24, 0xcf, 0x29, 0x7e
+);
+
+DEFINE_HEX_XDR_NETOBJ(nfold_test_kerberos,
+		      0x6b, 0x65, 0x72, 0x62, 0x65, 0x72, 0x6f, 0x73
+);
+DEFINE_HEX_XDR_NETOBJ(nfold_test8_expected_result,
+		      0x6b, 0x65, 0x72, 0x62, 0x65, 0x72, 0x6f, 0x73
+);
+DEFINE_HEX_XDR_NETOBJ(nfold_test9_expected_result,
+		      0x6b, 0x65, 0x72, 0x62, 0x65, 0x72, 0x6f, 0x73,
+		      0x7b, 0x9b, 0x5b, 0x2b, 0x93, 0x13, 0x2b, 0x93
+);
+DEFINE_HEX_XDR_NETOBJ(nfold_test10_expected_result,
+		      0x83, 0x72, 0xc2, 0x36, 0x34, 0x4e, 0x5f, 0x15,
+		      0x50, 0xcd, 0x07, 0x47, 0xe1, 0x5d, 0x62, 0xca,
+		      0x7a, 0x5a, 0x3b, 0xce, 0xa4
+);
+DEFINE_HEX_XDR_NETOBJ(nfold_test11_expected_result,
+		      0x6b, 0x65, 0x72, 0x62, 0x65, 0x72, 0x6f, 0x73,
+		      0x7b, 0x9b, 0x5b, 0x2b, 0x93, 0x13, 0x2b, 0x93,
+		      0x5c, 0x9b, 0xdc, 0xda, 0xd9, 0x5c, 0x98, 0x99,
+		      0xc4, 0xca, 0xe4, 0xde, 0xe6, 0xd6, 0xca, 0xe4
+);
+
+static const struct gss_krb5_test_param rfc3961_nfold_test_params[] = {
+	{
+		.desc			= "64-fold(\"012345\")",
+		.nfold			= 64,
+		.plaintext		= &nfold_test1_plaintext,
+		.expected_result	= &nfold_test1_expected_result,
+	},
+	{
+		.desc			= "56-fold(\"password\")",
+		.nfold			= 56,
+		.plaintext		= &nfold_test2_plaintext,
+		.expected_result	= &nfold_test2_expected_result,
+	},
+	{
+		.desc			= "64-fold(\"Rough Consensus, and Running Code\")",
+		.nfold			= 64,
+		.plaintext		= &nfold_test3_plaintext,
+		.expected_result	= &nfold_test3_expected_result,
+	},
+	{
+		.desc			= "168-fold(\"password\")",
+		.nfold			= 168,
+		.plaintext		= &nfold_test4_plaintext,
+		.expected_result	= &nfold_test4_expected_result,
+	},
+	{
+		.desc			= "192-fold(\"MASSACHVSETTS INSTITVTE OF TECHNOLOGY\")",
+		.nfold			= 192,
+		.plaintext		= &nfold_test5_plaintext,
+		.expected_result	= &nfold_test5_expected_result,
+	},
+	{
+		.desc			= "168-fold(\"Q\")",
+		.nfold			= 168,
+		.plaintext		= &nfold_test6_plaintext,
+		.expected_result	= &nfold_test6_expected_result,
+	},
+	{
+		.desc			= "168-fold(\"ba\")",
+		.nfold			= 168,
+		.plaintext		= &nfold_test7_plaintext,
+		.expected_result	= &nfold_test7_expected_result,
+	},
+	{
+		.desc			= "64-fold(\"kerberos\")",
+		.nfold			= 64,
+		.plaintext		= &nfold_test_kerberos,
+		.expected_result	= &nfold_test8_expected_result,
+	},
+	{
+		.desc			= "128-fold(\"kerberos\")",
+		.nfold			= 128,
+		.plaintext		= &nfold_test_kerberos,
+		.expected_result	= &nfold_test9_expected_result,
+	},
+	{
+		.desc			= "168-fold(\"kerberos\")",
+		.nfold			= 168,
+		.plaintext		= &nfold_test_kerberos,
+		.expected_result	= &nfold_test10_expected_result,
+	},
+	{
+		.desc			= "256-fold(\"kerberos\")",
+		.nfold			= 256,
+		.plaintext		= &nfold_test_kerberos,
+		.expected_result	= &nfold_test11_expected_result,
+	},
+};
+
+/* Creates the function rfc3961_nfold_gen_params */
+KUNIT_ARRAY_PARAM(rfc3961_nfold, rfc3961_nfold_test_params, gss_krb5_get_desc);
+
+static void rfc3961_nfold_case(struct kunit *test)
+{
+	const struct gss_krb5_test_param *param = test->param_value;
+	u8 *result;
+
+	/* Arrange */
+	result = kunit_kzalloc(test, 4096, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, result);
+
+	/* Act */
+	krb5_nfold(param->plaintext->len * 8, param->plaintext->data,
+		   param->expected_result->len * 8, result);
+
+	/* Assert */
+	KUNIT_EXPECT_EQ_MSG(test,
+			    memcmp(param->expected_result->data,
+				   result, param->expected_result->len), 0,
+			    "result mismatch");
+}
+
+static struct kunit_case rfc3961_test_cases[] = {
+	{
+		.name			= "RFC 3961 n-fold",
+		.run_case		= rfc3961_nfold_case,
+		.generate_params	= rfc3961_nfold_gen_params,
+	},
+};
+
+static struct kunit_suite rfc3961_suite = {
+	.name			= "RFC 3961 tests",
+	.test_cases		= rfc3961_test_cases,
+};
+
+kunit_test_suites(&rfc3961_suite);
+
+MODULE_DESCRIPTION("Test RPCSEC GSS Kerberos 5 functions");
+MODULE_LICENSE("GPL");


