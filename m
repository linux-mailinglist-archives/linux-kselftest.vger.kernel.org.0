Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0CD66B324
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjAORY2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjAORY1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:24:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645DA10AA8;
        Sun, 15 Jan 2023 09:24:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01F5860DB5;
        Sun, 15 Jan 2023 17:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228DEC433D2;
        Sun, 15 Jan 2023 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803466;
        bh=g8WJ6fhL8jNraM89KSl6j4lzOWM+L9xF2xxiCmeUPR4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AdYY/sFTN7uTBn/1mkiu7aqSP1lDINdBTdfhP1AqSzsrzDmHE0cBsLNs71cxJ2bOt
         rQukxrOKnm3v+RCp2hFhV/FHcnbDcKrFUJ7wCU7Lvgvn5jAjFzAmF4a42TXqiC5Y7Q
         gr5gdm+S7XwUC5nAqx3KKXIny7qfeYJojqOwl+2i5YMs3/9+oopX+oPe2pwwzmz0XD
         BYk7jB0THnyUlUOBcZ8MRmsdIapI1j0m0TnfaDdVF/3AQNjFTYnAHjNfmCK0zPQnkZ
         zg3x7d5/zrv+dmV9l4i3Yz5o3Gpx0DoQSzcs10ioukG6PhY+IOY3Msb7LA3R0Xg2D+
         MjR41+IlZu/Yw==
Subject: [PATCH v2 39/41] SUNRPC: Add RFC 8009 checksum KUnit tests
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:24:25 -0500
Message-ID: <167380346525.10651.6559639931984362776.stgit@bazille.1015granger.net>
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

RFC 8009 provides sample checksum results. Add KUnit tests to ensure
our implementation derives the expected results for the provided
sample input.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_test.c |   53 +++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss_krb5_test.c
index ad4737b60b56..0399f8338066 100644
--- a/net/sunrpc/auth_gss/gss_krb5_test.c
+++ b/net/sunrpc/auth_gss/gss_krb5_test.c
@@ -1514,12 +1514,65 @@ static const struct gss_krb5_test_param rfc8009_kdf_test_params[] = {
 /* Creates the function rfc8009_kdf_gen_params */
 KUNIT_ARRAY_PARAM(rfc8009_kdf, rfc8009_kdf_test_params, gss_krb5_get_desc);
 
+/*
+ * From RFC 8009 Appendix A.  Test Vectors
+ *
+ * These sample checksums use the above sample key derivation results,
+ * including use of the same base-key and key usage values.
+ *
+ * This test material is copyright (c) 2016 IETF Trust and the
+ * persons identified as the document authors.  All rights reserved.
+ */
+
+DEFINE_HEX_XDR_NETOBJ(rfc8009_checksum_plaintext,
+		      0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+		      0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+		      0x10, 0x11, 0x12, 0x13, 0x14
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_checksum_test1_expected_result,
+		      0xd7, 0x83, 0x67, 0x18, 0x66, 0x43, 0xd6, 0x7b,
+		      0x41, 0x1c, 0xba, 0x91, 0x39, 0xfc, 0x1d, 0xee
+);
+DEFINE_HEX_XDR_NETOBJ(rfc8009_checksum_test2_expected_result,
+		      0x45, 0xee, 0x79, 0x15, 0x67, 0xee, 0xfc, 0xa3,
+		      0x7f, 0x4a, 0xc1, 0xe0, 0x22, 0x2d, 0xe8, 0x0d,
+		      0x43, 0xc3, 0xbf, 0xa0, 0x66, 0x99, 0x67, 0x2a
+);
+
+static const struct gss_krb5_test_param rfc8009_checksum_test_params[] = {
+	{
+		.desc			= "Checksum with aes128-cts-hmac-sha256-128",
+		.enctype		= ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.base_key		= &aes128_cts_hmac_sha256_128_basekey,
+		.usage			= &usage_checksum,
+		.plaintext		= &rfc8009_checksum_plaintext,
+		.expected_result	= &rfc8009_checksum_test1_expected_result,
+	},
+	{
+		.desc			= "Checksum with aes256-cts-hmac-sha384-192",
+		.enctype		= ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.base_key		= &aes256_cts_hmac_sha384_192_basekey,
+		.usage			= &usage_checksum,
+		.plaintext		= &rfc8009_checksum_plaintext,
+		.expected_result	= &rfc8009_checksum_test2_expected_result,
+	},
+};
+
+/* Creates the function rfc8009_checksum_gen_params */
+KUNIT_ARRAY_PARAM(rfc8009_checksum, rfc8009_checksum_test_params,
+		  gss_krb5_get_desc);
+
 static struct kunit_case rfc8009_test_cases[] = {
 	{
 		.name			= "RFC 8009 key derivation",
 		.run_case		= kdf_case,
 		.generate_params	= rfc8009_kdf_gen_params,
 	},
+	{
+		.name			= "RFC 8009 checksum",
+		.run_case		= checksum_case,
+		.generate_params	= rfc8009_checksum_gen_params,
+	},
 };
 
 static struct kunit_suite rfc8009_suite = {


