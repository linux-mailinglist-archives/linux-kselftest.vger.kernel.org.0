Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000636A4694
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 16:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjB0P6q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 10:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjB0P6o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 10:58:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2391F915;
        Mon, 27 Feb 2023 07:58:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC4FEB80D38;
        Mon, 27 Feb 2023 15:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E66C433EF;
        Mon, 27 Feb 2023 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677513515;
        bh=gEEVoOt1hFZHp8YuqiIBgYgz6TP8vkteCT03OdVERyk=;
        h=Subject:From:To:Cc:Date:From;
        b=pb+l9PX/kc9eSPb9N7fz1lsQ2HHXlYouVkkHEHt7jySpzky95+Rj2wiUtgopMm0C9
         dISMI503FMORGn2X18f6lez2ymEIHGmDJJHJaEB1zrWqU9RGiIT74EyFIEDcxRNNyx
         tlho7KRoos1HmgcM+aJoLavmZw2YKZvvfZhNMWQW6FVYZ8UIUpq8O0BypDM1QbjjK6
         6MCLQ/1w/pg3HUvfBDpKPieuhmZDR90zRPR7FDV7fXkWUP5jiei5tIBl67sg3BADj5
         jKfHsgjZN9ZKwQii0xseNe/+2wCRp6qeJU31O6tCQg5Z5n1PsD03MwmFVMECnd3Xst
         6ENyW0nXuTACw==
Subject: [PATCH] SUNRPC: Let Kunit tests run with some enctypes compiled out
From:   Chuck Lever <cel@kernel.org>
To:     geert@linux-m68k.org
Cc:     linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Date:   Mon, 27 Feb 2023 10:58:34 -0500
Message-ID: <167751329962.149247.12935751231288858919.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Allow the new GSS Kerberos encryption type test suites to run
outside of the kunit infrastructure. Replace the assertion that
fires when lookup_enctype() so that the case is skipped instead of
failing outright.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---

Hey Geert -

This patch addresses part of your concern: with this patch applied,
you should be able to run only the tests that target the encryption
types that are enabled in your kernel. The other tests will be
skipped rather than fail outright.

 net/sunrpc/auth_gss/gss_krb5_test.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss_krb5_test.c
index c287ce15c419..0a7c5280e4e3 100644
--- a/net/sunrpc/auth_gss/gss_krb5_test.c
+++ b/net/sunrpc/auth_gss/gss_krb5_test.c
@@ -49,7 +49,8 @@ static void kdf_case(struct kunit *test)
 
 	/* Arrange */
 	gk5e = gss_krb5_lookup_enctype(param->enctype);
-	KUNIT_ASSERT_NOT_NULL(test, gk5e);
+	if (!gk5e)
+		kunit_skip(test, "Encryption type is not available");
 
 	derivedkey.data = kunit_kzalloc(test, param->expected_result->len,
 					GFP_KERNEL);
@@ -83,7 +84,8 @@ static void checksum_case(struct kunit *test)
 
 	/* Arrange */
 	gk5e = gss_krb5_lookup_enctype(param->enctype);
-	KUNIT_ASSERT_NOT_NULL(test, gk5e);
+	if (!gk5e)
+		kunit_skip(test, "Encryption type is not available");
 
 	Kc.len = gk5e->Kc_length;
 	Kc.data = kunit_kzalloc(test, Kc.len, GFP_KERNEL);
@@ -725,7 +727,8 @@ static void rfc3962_encrypt_case(struct kunit *test)
 
 	/* Arrange */
 	gk5e = gss_krb5_lookup_enctype(param->enctype);
-	KUNIT_ASSERT_NOT_NULL(test, gk5e);
+	if (!gk5e)
+		kunit_skip(test, "Encryption type is not available");
 
 	cbc_tfm = crypto_alloc_sync_skcipher(gk5e->aux_cipher, 0, 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cbc_tfm);
@@ -1319,7 +1322,8 @@ static void rfc6803_encrypt_case(struct kunit *test)
 
 	/* Arrange */
 	gk5e = gss_krb5_lookup_enctype(param->enctype);
-	KUNIT_ASSERT_NOT_NULL(test, gk5e);
+	if (!gk5e)
+		kunit_skip(test, "Encryption type is not available");
 
 	usage.data[3] = param->constant;
 
@@ -1810,7 +1814,8 @@ static void rfc8009_encrypt_case(struct kunit *test)
 
 	/* Arrange */
 	gk5e = gss_krb5_lookup_enctype(param->enctype);
-	KUNIT_ASSERT_NOT_NULL(test, gk5e);
+	if (!gk5e)
+		kunit_skip(test, "Encryption type is not available");
 
 	*(__be32 *)usage.data = cpu_to_be32(2);
 
@@ -1975,7 +1980,8 @@ static void encrypt_selftest_case(struct kunit *test)
 
 	/* Arrange */
 	gk5e = gss_krb5_lookup_enctype(param->enctype);
-	KUNIT_ASSERT_NOT_NULL(test, gk5e);
+	if (!gk5e)
+		kunit_skip(test, "Encryption type is not available");
 
 	cbc_tfm = crypto_alloc_sync_skcipher(gk5e->aux_cipher, 0, 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cbc_tfm);


