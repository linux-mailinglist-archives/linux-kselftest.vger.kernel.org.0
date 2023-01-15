Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F89666B320
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjAORYR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjAORYQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:24:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFC176BB;
        Sun, 15 Jan 2023 09:24:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F23A60C74;
        Sun, 15 Jan 2023 17:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609CBC433D2;
        Sun, 15 Jan 2023 17:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803453;
        bh=B9Grsp+KSucs7jDEeyZT6+CPUp3aLVDeWFEEnhXEoWw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eUgs5WdRiBOm/eraZYq7nHBrd2lafJOUhd061w39b7lfQHO7TFrJLPImE76TQdOVd
         oMMmOdiogSw+xjZWKTeI4G9oEvqcMig+HrbOaC21E5LR19C2bDk8DwQYiX6dtrmSka
         gtECgItExqZZiE3R3zQcophVUznoQpVLyG0TVif9QTjbAU1x4Hw9SN0tH6DCleDvYp
         mtXWPTyqQt8H7Dno6nkcHfHf/1mUBN95iibqtQoL1/ijzJ0jADT705VIxQJzECM5XX
         bjMB7DTSv6ZHP6dJEZUNU0eJGxavOQ678dKt78BT8sVaLZ/8PyA0tslCafwRCv4vU0
         cf1PBQ79EKbSQ==
Subject: [PATCH v2 37/41] SUNRPC: Add encryption KUnit tests for the RFC 6803
 encryption types
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:24:12 -0500
Message-ID: <167380345251.10651.2448115114435507842.stgit@bazille.1015granger.net>
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

Add tests for the new-to-RPCSEC Camellia cipher.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_test.c |  400 +++++++++++++++++++++++++++++++++++
 1 file changed, 400 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss_krb5_test.c
index ea8cba8c3eb3..3d8d41aab5fe 100644
--- a/net/sunrpc/auth_gss/gss_krb5_test.c
+++ b/net/sunrpc/auth_gss/gss_krb5_test.c
@@ -23,10 +23,12 @@ struct gss_krb5_test_param {
 	const char			*desc;
 	u32				enctype;
 	u32				nfold;
+	u32				constant;
 	const struct xdr_netobj		*base_key;
 	const struct xdr_netobj		*Ke;
 	const struct xdr_netobj		*usage;
 	const struct xdr_netobj		*plaintext;
+	const struct xdr_netobj		*confounder;
 	const struct xdr_netobj		*expected_result;
 	const struct xdr_netobj		*next_iv;
 };
@@ -999,6 +1001,399 @@ static const struct gss_krb5_test_param rfc6803_checksum_test_params[] = {
 KUNIT_ARRAY_PARAM(rfc6803_checksum, rfc6803_checksum_test_params,
 		  gss_krb5_get_desc);
 
+/*
+ * From RFC 6803 Section 10.  Test vectors
+ *
+ * Sample encryptions (all using the default cipher state)
+ *
+ * Copyright (c) 2012 IETF Trust and the persons identified as the
+ * document authors.  All rights reserved.
+ *
+ * Key usage values are from errata 4326 against RFC 6803.
+ */
+
+static const struct xdr_netobj rfc6803_enc_empty_plaintext = {
+	.len	= 0,
+};
+
+DEFINE_STR_XDR_NETOBJ(rfc6803_enc_1byte_plaintext, "1");
+DEFINE_STR_XDR_NETOBJ(rfc6803_enc_9byte_plaintext, "9 bytesss");
+DEFINE_STR_XDR_NETOBJ(rfc6803_enc_13byte_plaintext, "13 bytes byte");
+DEFINE_STR_XDR_NETOBJ(rfc6803_enc_30byte_plaintext,
+		      "30 bytes bytes bytes bytes byt"
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test1_confounder,
+		      0xb6, 0x98, 0x22, 0xa1, 0x9a, 0x6b, 0x09, 0xc0,
+		      0xeb, 0xc8, 0x55, 0x7d, 0x1f, 0x1b, 0x6c, 0x0a
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test1_basekey,
+		      0x1d, 0xc4, 0x6a, 0x8d, 0x76, 0x3f, 0x4f, 0x93,
+		      0x74, 0x2b, 0xcb, 0xa3, 0x38, 0x75, 0x76, 0xc3
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test1_expected_result,
+		      0xc4, 0x66, 0xf1, 0x87, 0x10, 0x69, 0x92, 0x1e,
+		      0xdb, 0x7c, 0x6f, 0xde, 0x24, 0x4a, 0x52, 0xdb,
+		      0x0b, 0xa1, 0x0e, 0xdc, 0x19, 0x7b, 0xdb, 0x80,
+		      0x06, 0x65, 0x8c, 0xa3, 0xcc, 0xce, 0x6e, 0xb8
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test2_confounder,
+		      0x6f, 0x2f, 0xc3, 0xc2, 0xa1, 0x66, 0xfd, 0x88,
+		      0x98, 0x96, 0x7a, 0x83, 0xde, 0x95, 0x96, 0xd9
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test2_basekey,
+		      0x50, 0x27, 0xbc, 0x23, 0x1d, 0x0f, 0x3a, 0x9d,
+		      0x23, 0x33, 0x3f, 0x1c, 0xa6, 0xfd, 0xbe, 0x7c
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test2_expected_result,
+		      0x84, 0x2d, 0x21, 0xfd, 0x95, 0x03, 0x11, 0xc0,
+		      0xdd, 0x46, 0x4a, 0x3f, 0x4b, 0xe8, 0xd6, 0xda,
+		      0x88, 0xa5, 0x6d, 0x55, 0x9c, 0x9b, 0x47, 0xd3,
+		      0xf9, 0xa8, 0x50, 0x67, 0xaf, 0x66, 0x15, 0x59,
+		      0xb8
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test3_confounder,
+		      0xa5, 0xb4, 0xa7, 0x1e, 0x07, 0x7a, 0xee, 0xf9,
+		      0x3c, 0x87, 0x63, 0xc1, 0x8f, 0xdb, 0x1f, 0x10
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test3_basekey,
+		      0xa1, 0xbb, 0x61, 0xe8, 0x05, 0xf9, 0xba, 0x6d,
+		      0xde, 0x8f, 0xdb, 0xdd, 0xc0, 0x5c, 0xde, 0xa0
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test3_expected_result,
+		      0x61, 0x9f, 0xf0, 0x72, 0xe3, 0x62, 0x86, 0xff,
+		      0x0a, 0x28, 0xde, 0xb3, 0xa3, 0x52, 0xec, 0x0d,
+		      0x0e, 0xdf, 0x5c, 0x51, 0x60, 0xd6, 0x63, 0xc9,
+		      0x01, 0x75, 0x8c, 0xcf, 0x9d, 0x1e, 0xd3, 0x3d,
+		      0x71, 0xdb, 0x8f, 0x23, 0xaa, 0xbf, 0x83, 0x48,
+		      0xa0
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test4_confounder,
+		      0x19, 0xfe, 0xe4, 0x0d, 0x81, 0x0c, 0x52, 0x4b,
+		      0x5b, 0x22, 0xf0, 0x18, 0x74, 0xc6, 0x93, 0xda
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test4_basekey,
+		      0x2c, 0xa2, 0x7a, 0x5f, 0xaf, 0x55, 0x32, 0x24,
+		      0x45, 0x06, 0x43, 0x4e, 0x1c, 0xef, 0x66, 0x76
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test4_expected_result,
+		      0xb8, 0xec, 0xa3, 0x16, 0x7a, 0xe6, 0x31, 0x55,
+		      0x12, 0xe5, 0x9f, 0x98, 0xa7, 0xc5, 0x00, 0x20,
+		      0x5e, 0x5f, 0x63, 0xff, 0x3b, 0xb3, 0x89, 0xaf,
+		      0x1c, 0x41, 0xa2, 0x1d, 0x64, 0x0d, 0x86, 0x15,
+		      0xc9, 0xed, 0x3f, 0xbe, 0xb0, 0x5a, 0xb6, 0xac,
+		      0xb6, 0x76, 0x89, 0xb5, 0xea
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test5_confounder,
+		      0xca, 0x7a, 0x7a, 0xb4, 0xbe, 0x19, 0x2d, 0xab,
+		      0xd6, 0x03, 0x50, 0x6d, 0xb1, 0x9c, 0x39, 0xe2
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test5_basekey,
+		      0x78, 0x24, 0xf8, 0xc1, 0x6f, 0x83, 0xff, 0x35,
+		      0x4c, 0x6b, 0xf7, 0x51, 0x5b, 0x97, 0x3f, 0x43
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test5_expected_result,
+		      0xa2, 0x6a, 0x39, 0x05, 0xa4, 0xff, 0xd5, 0x81,
+		      0x6b, 0x7b, 0x1e, 0x27, 0x38, 0x0d, 0x08, 0x09,
+		      0x0c, 0x8e, 0xc1, 0xf3, 0x04, 0x49, 0x6e, 0x1a,
+		      0xbd, 0xcd, 0x2b, 0xdc, 0xd1, 0xdf, 0xfc, 0x66,
+		      0x09, 0x89, 0xe1, 0x17, 0xa7, 0x13, 0xdd, 0xbb,
+		      0x57, 0xa4, 0x14, 0x6c, 0x15, 0x87, 0xcb, 0xa4,
+		      0x35, 0x66, 0x65, 0x59, 0x1d, 0x22, 0x40, 0x28,
+		      0x2f, 0x58, 0x42, 0xb1, 0x05, 0xa5
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test6_confounder,
+		      0x3c, 0xbb, 0xd2, 0xb4, 0x59, 0x17, 0x94, 0x10,
+		      0x67, 0xf9, 0x65, 0x99, 0xbb, 0x98, 0x92, 0x6c
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test6_basekey,
+		      0xb6, 0x1c, 0x86, 0xcc, 0x4e, 0x5d, 0x27, 0x57,
+		      0x54, 0x5a, 0xd4, 0x23, 0x39, 0x9f, 0xb7, 0x03,
+		      0x1e, 0xca, 0xb9, 0x13, 0xcb, 0xb9, 0x00, 0xbd,
+		      0x7a, 0x3c, 0x6d, 0xd8, 0xbf, 0x92, 0x01, 0x5b
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test6_expected_result,
+		      0x03, 0x88, 0x6d, 0x03, 0x31, 0x0b, 0x47, 0xa6,
+		      0xd8, 0xf0, 0x6d, 0x7b, 0x94, 0xd1, 0xdd, 0x83,
+		      0x7e, 0xcc, 0xe3, 0x15, 0xef, 0x65, 0x2a, 0xff,
+		      0x62, 0x08, 0x59, 0xd9, 0x4a, 0x25, 0x92, 0x66
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test7_confounder,
+		      0xde, 0xf4, 0x87, 0xfc, 0xeb, 0xe6, 0xde, 0x63,
+		      0x46, 0xd4, 0xda, 0x45, 0x21, 0xbb, 0xa2, 0xd2
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test7_basekey,
+		      0x1b, 0x97, 0xfe, 0x0a, 0x19, 0x0e, 0x20, 0x21,
+		      0xeb, 0x30, 0x75, 0x3e, 0x1b, 0x6e, 0x1e, 0x77,
+		      0xb0, 0x75, 0x4b, 0x1d, 0x68, 0x46, 0x10, 0x35,
+		      0x58, 0x64, 0x10, 0x49, 0x63, 0x46, 0x38, 0x33
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test7_expected_result,
+		      0x2c, 0x9c, 0x15, 0x70, 0x13, 0x3c, 0x99, 0xbf,
+		      0x6a, 0x34, 0xbc, 0x1b, 0x02, 0x12, 0x00, 0x2f,
+		      0xd1, 0x94, 0x33, 0x87, 0x49, 0xdb, 0x41, 0x35,
+		      0x49, 0x7a, 0x34, 0x7c, 0xfc, 0xd9, 0xd1, 0x8a,
+		      0x12
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test8_confounder,
+		      0xad, 0x4f, 0xf9, 0x04, 0xd3, 0x4e, 0x55, 0x53,
+		      0x84, 0xb1, 0x41, 0x00, 0xfc, 0x46, 0x5f, 0x88
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test8_basekey,
+		      0x32, 0x16, 0x4c, 0x5b, 0x43, 0x4d, 0x1d, 0x15,
+		      0x38, 0xe4, 0xcf, 0xd9, 0xbe, 0x80, 0x40, 0xfe,
+		      0x8c, 0x4a, 0xc7, 0xac, 0xc4, 0xb9, 0x3d, 0x33,
+		      0x14, 0xd2, 0x13, 0x36, 0x68, 0x14, 0x7a, 0x05
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test8_expected_result,
+		      0x9c, 0x6d, 0xe7, 0x5f, 0x81, 0x2d, 0xe7, 0xed,
+		      0x0d, 0x28, 0xb2, 0x96, 0x35, 0x57, 0xa1, 0x15,
+		      0x64, 0x09, 0x98, 0x27, 0x5b, 0x0a, 0xf5, 0x15,
+		      0x27, 0x09, 0x91, 0x3f, 0xf5, 0x2a, 0x2a, 0x9c,
+		      0x8e, 0x63, 0xb8, 0x72, 0xf9, 0x2e, 0x64, 0xc8,
+		      0x39
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test9_confounder,
+		      0xcf, 0x9b, 0xca, 0x6d, 0xf1, 0x14, 0x4e, 0x0c,
+		      0x0a, 0xf9, 0xb8, 0xf3, 0x4c, 0x90, 0xd5, 0x14
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test9_basekey,
+		      0xb0, 0x38, 0xb1, 0x32, 0xcd, 0x8e, 0x06, 0x61,
+		      0x22, 0x67, 0xfa, 0xb7, 0x17, 0x00, 0x66, 0xd8,
+		      0x8a, 0xec, 0xcb, 0xa0, 0xb7, 0x44, 0xbf, 0xc6,
+		      0x0d, 0xc8, 0x9b, 0xca, 0x18, 0x2d, 0x07, 0x15
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test9_expected_result,
+		      0xee, 0xec, 0x85, 0xa9, 0x81, 0x3c, 0xdc, 0x53,
+		      0x67, 0x72, 0xab, 0x9b, 0x42, 0xde, 0xfc, 0x57,
+		      0x06, 0xf7, 0x26, 0xe9, 0x75, 0xdd, 0xe0, 0x5a,
+		      0x87, 0xeb, 0x54, 0x06, 0xea, 0x32, 0x4c, 0xa1,
+		      0x85, 0xc9, 0x98, 0x6b, 0x42, 0xaa, 0xbe, 0x79,
+		      0x4b, 0x84, 0x82, 0x1b, 0xee
+);
+
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test10_confounder,
+		      0x64, 0x4d, 0xef, 0x38, 0xda, 0x35, 0x00, 0x72,
+		      0x75, 0x87, 0x8d, 0x21, 0x68, 0x55, 0xe2, 0x28
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test10_basekey,
+		      0xcc, 0xfc, 0xd3, 0x49, 0xbf, 0x4c, 0x66, 0x77,
+		      0xe8, 0x6e, 0x4b, 0x02, 0xb8, 0xea, 0xb9, 0x24,
+		      0xa5, 0x46, 0xac, 0x73, 0x1c, 0xf9, 0xbf, 0x69,
+		      0x89, 0xb9, 0x96, 0xe7, 0xd6, 0xbf, 0xbb, 0xa7
+);
+DEFINE_HEX_XDR_NETOBJ(rfc6803_enc_test10_expected_result,
+		      0x0e, 0x44, 0x68, 0x09, 0x85, 0x85, 0x5f, 0x2d,
+		      0x1f, 0x18, 0x12, 0x52, 0x9c, 0xa8, 0x3b, 0xfd,
+		      0x8e, 0x34, 0x9d, 0xe6, 0xfd, 0x9a, 0xda, 0x0b,
+		      0xaa, 0xa0, 0x48, 0xd6, 0x8e, 0x26, 0x5f, 0xeb,
+		      0xf3, 0x4a, 0xd1, 0x25, 0x5a, 0x34, 0x49, 0x99,
+		      0xad, 0x37, 0x14, 0x68, 0x87, 0xa6, 0xc6, 0x84,
+		      0x57, 0x31, 0xac, 0x7f, 0x46, 0x37, 0x6a, 0x05,
+		      0x04, 0xcd, 0x06, 0x57, 0x14, 0x74
+);
+
+static const struct gss_krb5_test_param rfc6803_encrypt_test_params[] = {
+	{
+		.desc			= "Encrypt empty plaintext with camellia128-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.constant		= 0,
+		.base_key		= &rfc6803_enc_test1_basekey,
+		.plaintext		= &rfc6803_enc_empty_plaintext,
+		.confounder		= &rfc6803_enc_test1_confounder,
+		.expected_result	= &rfc6803_enc_test1_expected_result,
+	},
+	{
+		.desc			= "Encrypt 1 byte with camellia128-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.constant		= 1,
+		.base_key		= &rfc6803_enc_test2_basekey,
+		.plaintext		= &rfc6803_enc_1byte_plaintext,
+		.confounder		= &rfc6803_enc_test2_confounder,
+		.expected_result	= &rfc6803_enc_test2_expected_result,
+	},
+	{
+		.desc			= "Encrypt 9 bytes with camellia128-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.constant		= 2,
+		.base_key		= &rfc6803_enc_test3_basekey,
+		.plaintext		= &rfc6803_enc_9byte_plaintext,
+		.confounder		= &rfc6803_enc_test3_confounder,
+		.expected_result	= &rfc6803_enc_test3_expected_result,
+	},
+	{
+		.desc			= "Encrypt 13 bytes with camellia128-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.constant		= 3,
+		.base_key		= &rfc6803_enc_test4_basekey,
+		.plaintext		= &rfc6803_enc_13byte_plaintext,
+		.confounder		= &rfc6803_enc_test4_confounder,
+		.expected_result	= &rfc6803_enc_test4_expected_result,
+	},
+	{
+		.desc			= "Encrypt 30 bytes with camellia128-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA128_CTS_CMAC,
+		.constant		= 4,
+		.base_key		= &rfc6803_enc_test5_basekey,
+		.plaintext		= &rfc6803_enc_30byte_plaintext,
+		.confounder		= &rfc6803_enc_test5_confounder,
+		.expected_result	= &rfc6803_enc_test5_expected_result,
+	},
+	{
+		.desc			= "Encrypt empty plaintext with camellia256-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.constant		= 0,
+		.base_key		= &rfc6803_enc_test6_basekey,
+		.plaintext		= &rfc6803_enc_empty_plaintext,
+		.confounder		= &rfc6803_enc_test6_confounder,
+		.expected_result	= &rfc6803_enc_test6_expected_result,
+	},
+	{
+		.desc			= "Encrypt 1 byte with camellia256-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.constant		= 1,
+		.base_key		= &rfc6803_enc_test7_basekey,
+		.plaintext		= &rfc6803_enc_1byte_plaintext,
+		.confounder		= &rfc6803_enc_test7_confounder,
+		.expected_result	= &rfc6803_enc_test7_expected_result,
+	},
+	{
+		.desc			= "Encrypt 9 bytes with camellia256-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.constant		= 2,
+		.base_key		= &rfc6803_enc_test8_basekey,
+		.plaintext		= &rfc6803_enc_9byte_plaintext,
+		.confounder		= &rfc6803_enc_test8_confounder,
+		.expected_result	= &rfc6803_enc_test8_expected_result,
+	},
+	{
+		.desc			= "Encrypt 13 bytes with camellia256-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.constant		= 3,
+		.base_key		= &rfc6803_enc_test9_basekey,
+		.plaintext		= &rfc6803_enc_13byte_plaintext,
+		.confounder		= &rfc6803_enc_test9_confounder,
+		.expected_result	= &rfc6803_enc_test9_expected_result,
+	},
+	{
+		.desc			= "Encrypt 30 bytes with camellia256-cts-cmac",
+		.enctype		= ENCTYPE_CAMELLIA256_CTS_CMAC,
+		.constant		= 4,
+		.base_key		= &rfc6803_enc_test10_basekey,
+		.plaintext		= &rfc6803_enc_30byte_plaintext,
+		.confounder		= &rfc6803_enc_test10_confounder,
+		.expected_result	= &rfc6803_enc_test10_expected_result,
+	},
+};
+
+/* Creates the function rfc6803_encrypt_gen_params */
+KUNIT_ARRAY_PARAM(rfc6803_encrypt, rfc6803_encrypt_test_params,
+		  gss_krb5_get_desc);
+
+static void rfc6803_encrypt_case(struct kunit *test)
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
+	unsigned int blocksize;
+	struct xdr_buf buf;
+	void *text;
+	size_t len;
+	u32 err;
+
+	/* Arrange */
+	gk5e = gss_krb5_lookup_enctype(param->enctype);
+	KUNIT_ASSERT_NOT_NULL(test, gk5e);
+
+	usage.data[3] = param->constant;
+
+	Ke.len = gk5e->Ke_length;
+	Ke.data = kunit_kzalloc(test, Ke.len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, Ke.data);
+	usage.data[4] = KEY_USAGE_SEED_ENCRYPTION;
+	err = gk5e->derive_key(gk5e, param->base_key, &Ke, &usage, GFP_KERNEL);
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
+	blocksize = crypto_sync_skcipher_blocksize(cts_tfm);
+
+	len = param->confounder->len + param->plaintext->len + blocksize;
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
+	ahash_tfm = crypto_alloc_ahash(gk5e->cksum_name, 0, CRYPTO_ALG_ASYNC);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ahash_tfm);
+	err = crypto_ahash_setkey(ahash_tfm, Ki.data, Ki.len);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	/* Act */
+	err = gss_krb5_checksum(ahash_tfm, NULL, 0, &buf, 0, &checksum);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	err = krb5_cbc_cts_encrypt(cts_tfm, cbc_tfm, 0, &buf, NULL, NULL, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	/* Assert */
+	KUNIT_EXPECT_EQ_MSG(test, param->expected_result->len,
+			    buf.len + checksum.len,
+			    "ciphertext length mismatch");
+	KUNIT_EXPECT_EQ_MSG(test,
+			    memcmp(param->expected_result->data,
+				   buf.head[0].iov_base, buf.len), 0,
+			    "encrypted result mismatch");
+	KUNIT_EXPECT_EQ_MSG(test,
+			    memcmp(param->expected_result->data +
+				   (param->expected_result->len - checksum.len),
+				   checksum.data, checksum.len), 0,
+			    "HMAC mismatch");
+
+	crypto_free_ahash(ahash_tfm);
+	crypto_free_sync_skcipher(cts_tfm);
+	crypto_free_sync_skcipher(cbc_tfm);
+}
+
 static struct kunit_case rfc6803_test_cases[] = {
 	{
 		.name			= "RFC 6803 key derivation",
@@ -1010,6 +1405,11 @@ static struct kunit_case rfc6803_test_cases[] = {
 		.run_case		= checksum_case,
 		.generate_params	= rfc6803_checksum_gen_params,
 	},
+	{
+		.name			= "RFC 6803 encryption",
+		.run_case		= rfc6803_encrypt_case,
+		.generate_params	= rfc6803_encrypt_gen_params,
+	},
 };
 
 static struct kunit_suite rfc6803_suite = {


