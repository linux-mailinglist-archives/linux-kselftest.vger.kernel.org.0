Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6247A2B8337
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 18:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgKRRjl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 12:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgKRRjl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 12:39:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F19C0613D4;
        Wed, 18 Nov 2020 09:39:40 -0800 (PST)
Date:   Wed, 18 Nov 2020 17:39:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605721179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WGG7M1saX6GKkYBMqOWccazJCHfEwu2zYn14Qobog8k=;
        b=jFDufLeHKAQRKdpREDGwyNzL07Sfpf61sqnzDuCAQZpH7xIyunALu10kPfss8qqr2ln+m3
        Qaq3UU5wHtJf8KvaqNjft2dYdetVJ9GAD6VOiTxlyRjFuPpgo9Y7lSEWgNXZGkbYhtRFeZ
        Vu1RXsqJyGUonVSIY1DNT3t38Y90T2YCM586cFW8M5FhPSuidVucIrIf6yswc0+td0Pp5F
        voJ4FxKBIFT0EvPPY5089Aowy0tAJca8ecJvaPAkH5ZhmMPrDMbg6XZf7SSHQtu1BcOxie
        sh/UFwr1W5A1UQfVOhEyekabff3GsdH0O6m2mW2cOWJ7yMMbxpC6mDl6oBaziA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605721179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WGG7M1saX6GKkYBMqOWccazJCHfEwu2zYn14Qobog8k=;
        b=MV8dJob4zeOpfBJoJmoEEJif4Te4CWQwbpA/byzD2Y5H26hforV6Om2BDAxDNA8HYR2tkg
        Y1I/mpsCPXCrIOAA==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Use a statically generated 3072-bit RSA key
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, Borislav Petkov <bp@suse.de>,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201118170640.39629-1-jarkko@kernel.org>
References: <20201118170640.39629-1-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160572117767.11244.6436872924300352142.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     0eaa8d153a1d573e53b8283c90db44057d1376f6
Gitweb:        https://git.kernel.org/tip/0eaa8d153a1d573e53b8283c90db44057d1376f6
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Wed, 18 Nov 2020 19:06:40 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 18:26:00 +01:00

selftests/sgx: Use a statically generated 3072-bit RSA key

Use a statically generated key for signing the enclave, because
generating keys on the fly can eat the kernel entropy pool. Another
good reason for doing this is predictable builds. The RSA has been
arbitrarily selected. It's contents do not matter.

This also makes the selftest execute a lot quicker instead of the delay
that it had before (because of slow key generation).

 [ bp: Disambiguate "static key" which means something else in the
   kernel, fix typos. ]

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-kselftest@vger.kernel.org
Link: https://lkml.kernel.org/r/20201118170640.39629-1-jarkko@kernel.org
---
 tools/testing/selftests/sgx/Makefile     |  6 +++-
 tools/testing/selftests/sgx/main.h       |  3 ++-
 tools/testing/selftests/sgx/sign_key.S   | 12 +++++++-
 tools/testing/selftests/sgx/sign_key.pem | 39 +++++++++++++++++++++++-
 tools/testing/selftests/sgx/sigstruct.c  | 34 +++++++-------------
 5 files changed, 71 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/sgx/sign_key.S
 create mode 100644 tools/testing/selftests/sgx/sign_key.pem

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index d51c906..7f12d55 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -25,7 +25,8 @@ endif
 $(OUTPUT)/test_sgx: $(OUTPUT)/main.o \
 		    $(OUTPUT)/load.o \
 		    $(OUTPUT)/sigstruct.o \
-		    $(OUTPUT)/call.o
+		    $(OUTPUT)/call.o \
+		    $(OUTPUT)/sign_key.o
 	$(CC) $(HOST_CFLAGS) -o $@ $^ -lcrypto
 
 $(OUTPUT)/main.o: main.c
@@ -40,6 +41,9 @@ $(OUTPUT)/sigstruct.o: sigstruct.c
 $(OUTPUT)/call.o: call.S
 	$(CC) $(HOST_CFLAGS) -c $< -o $@
 
+$(OUTPUT)/sign_key.o: sign_key.S
+	$(CC) $(HOST_CFLAGS) -c $< -o $@
+
 $(OUTPUT)/test_encl.elf: test_encl.lds test_encl.c test_encl_bootstrap.S
 	$(CC) $(ENCL_CFLAGS) -T $^ -o $@
 
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index 45e6ab6..67211a7 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -27,6 +27,9 @@ struct encl {
 	struct sgx_sigstruct sigstruct;
 };
 
+extern unsigned char sign_key[];
+extern unsigned char sign_key_end[];
+
 void encl_delete(struct encl *ctx);
 bool encl_load(const char *path, struct encl *encl);
 bool encl_measure(struct encl *encl);
diff --git a/tools/testing/selftests/sgx/sign_key.S b/tools/testing/selftests/sgx/sign_key.S
new file mode 100644
index 0000000..e4fbe94
--- /dev/null
+++ b/tools/testing/selftests/sgx/sign_key.S
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/**
+* Copyright(c) 2016-20 Intel Corporation.
+*/
+
+    .section ".rodata", "a"
+
+sign_key:
+    .globl sign_key
+    .incbin "sign_key.pem"
+sign_key_end:
+    .globl sign_key_end
diff --git a/tools/testing/selftests/sgx/sign_key.pem b/tools/testing/selftests/sgx/sign_key.pem
new file mode 100644
index 0000000..d76f21f
--- /dev/null
+++ b/tools/testing/selftests/sgx/sign_key.pem
@@ -0,0 +1,39 @@
+-----BEGIN RSA PRIVATE KEY-----
+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
+-----END RSA PRIVATE KEY-----
diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index cc06f10..dee7a3d 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -135,33 +135,21 @@ static inline const BIGNUM *get_modulus(RSA *key)
 
 static RSA *gen_sign_key(void)
 {
-	BIGNUM *e;
+	unsigned long sign_key_length;
+	BIO *bio;
 	RSA *key;
-	int ret;
 
-	e = BN_new();
-	key = RSA_new();
+	sign_key_length = (unsigned long)&sign_key_end -
+			  (unsigned long)&sign_key;
 
-	if (!e || !key)
-		goto err;
-
-	ret = BN_set_word(e, RSA_3);
-	if (ret != 1)
-		goto err;
-
-	ret = RSA_generate_key_ex(key, 3072, e, NULL);
-	if (ret != 1)
-		goto err;
+	bio = BIO_new_mem_buf(&sign_key, sign_key_length);
+	if (!bio)
+		return NULL;
 
-	BN_free(e);
+	key = PEM_read_bio_RSAPrivateKey(bio, NULL, NULL, NULL);
+	BIO_free(bio);
 
 	return key;
-
-err:
-	RSA_free(key);
-	BN_free(e);
-
-	return NULL;
 }
 
 static void reverse_bytes(void *data, int length)
@@ -339,8 +327,10 @@ bool encl_measure(struct encl *encl)
 		goto err;
 
 	key = gen_sign_key();
-	if (!key)
+	if (!key) {
+		ERR_print_errors_fp(stdout);
 		goto err;
+	}
 
 	BN_bn2bin(get_modulus(key), sigstruct->modulus);
 
