Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC33E3BB68B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jul 2021 07:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGEFFX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jul 2021 01:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhGEFFW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jul 2021 01:05:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8747613C8;
        Mon,  5 Jul 2021 05:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625461366;
        bh=zH8QyVNRpzQzn5HVPrOanQh9jYK7M7SHHxYoIiZK8tg=;
        h=From:To:Cc:Subject:Date:From;
        b=G4a5/0srD+lqffD1gph0y1n7lGvJL2sOWMdF9K7UdeD9W5jQNU3Vdt1YYkahPCNm3
         LcUnLA8ejvm9lUnvGtX9Tdk0MSyffLoPyjaSOVW1F+rRYc5DzB/7Kp8/RjuPBi0mn/
         fc855jkoNWC/AAMcntWeL/uK83m/lyObr2gJ0N8W5gZh0bPUea1jndkVu3OPlVCNE7
         usZSIzNQe8XU7UPJXJsK5KfSiubhJcz2EbvebKKsUmLC57yBJ1WgNaeeWwEABMBRPC
         Td4ihoupTvKOiQP390mumaZ77Qss7+7GYdq/3F9cyNPiTx/iNvSTHfU0aSqhjmGbvK
         gqEsfKIhURAUA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/sgx: Fix Q1 and Q2 calculation in sigstruct.c
Date:   Mon,  5 Jul 2021 08:02:38 +0300
Message-Id: <20210705050238.63064-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Q1 and Q2 are numbers with *maximum* length of 384 bytes. If the calculated
length of Q1 and Q2 is less than 384 bytes, things will go wrong.

E.g. if Q2 is 383 bytes, then

1. The bytes of q2 are copied to sigstruct->q2 in calc_q1q2().
2. The entire sigstruct->q2 is reversed, which results it being
   256 * Q2, given that the last byte of sigstruct->q2 is added
   to before the bytes given by calc_q1q2().

Either change in key or measurement can trigger the bug. E.g. an unmeasured
heap could cause a devastating change in Q1 or Q2.

Reverse exactly the bytes of Q1 and Q2 in calc_q1q2() before returning to
the caller.

Link: https://lore.kernel.org/linux-sgx/20210301051836.30738-1-tianjia.zhang@linux.alibaba.com/
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
The original patch did a bad job explaining the code change but it
turned out making sense. I wrote a new description. 
 tools/testing/selftests/sgx/sigstruct.c | 41 +++++++++++++------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index dee7a3d6c5a5..92bbc5a15c39 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -55,10 +55,27 @@ static bool alloc_q1q2_ctx(const uint8_t *s, const uint8_t *m,
 	return true;
 }
 
+static void reverse_bytes(void *data, int length)
+{
+	int i = 0;
+	int j = length - 1;
+	uint8_t temp;
+	uint8_t *ptr = data;
+
+	while (i < j) {
+		temp = ptr[i];
+		ptr[i] = ptr[j];
+		ptr[j] = temp;
+		i++;
+		j--;
+	}
+}
+
 static bool calc_q1q2(const uint8_t *s, const uint8_t *m, uint8_t *q1,
 		      uint8_t *q2)
 {
 	struct q1q2_ctx ctx;
+	int len;
 
 	if (!alloc_q1q2_ctx(s, m, &ctx)) {
 		fprintf(stderr, "Not enough memory for Q1Q2 calculation\n");
@@ -89,8 +106,10 @@ static bool calc_q1q2(const uint8_t *s, const uint8_t *m, uint8_t *q1,
 		goto out;
 	}
 
-	BN_bn2bin(ctx.q1, q1);
-	BN_bn2bin(ctx.q2, q2);
+	len = BN_bn2bin(ctx.q1, q1);
+	reverse_bytes(q1, len);
+	len = BN_bn2bin(ctx.q2, q2);
+	reverse_bytes(q2, len);
 
 	free_q1q2_ctx(&ctx);
 	return true;
@@ -152,22 +171,6 @@ static RSA *gen_sign_key(void)
 	return key;
 }
 
-static void reverse_bytes(void *data, int length)
-{
-	int i = 0;
-	int j = length - 1;
-	uint8_t temp;
-	uint8_t *ptr = data;
-
-	while (i < j) {
-		temp = ptr[i];
-		ptr[i] = ptr[j];
-		ptr[j] = temp;
-		i++;
-		j--;
-	}
-}
-
 enum mrtags {
 	MRECREATE = 0x0045544145524345,
 	MREADD = 0x0000000044444145,
@@ -367,8 +370,6 @@ bool encl_measure(struct encl *encl)
 	/* BE -> LE */
 	reverse_bytes(sigstruct->signature, SGX_MODULUS_SIZE);
 	reverse_bytes(sigstruct->modulus, SGX_MODULUS_SIZE);
-	reverse_bytes(sigstruct->q1, SGX_MODULUS_SIZE);
-	reverse_bytes(sigstruct->q2, SGX_MODULUS_SIZE);
 
 	EVP_MD_CTX_destroy(ctx);
 	RSA_free(key);
-- 
2.32.0

