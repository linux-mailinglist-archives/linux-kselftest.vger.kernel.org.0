Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA053276D8
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Mar 2021 06:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhCAFTV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Mar 2021 00:19:21 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:53026 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233439AbhCAFTV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Mar 2021 00:19:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UPtRs.4_1614575916;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UPtRs.4_1614575916)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Mar 2021 13:18:36 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] selftests/sgx: fix EINIT failure dueto SGX_INVALID_SIGNATURE
Date:   Mon,  1 Mar 2021 13:18:36 +0800
Message-Id: <20210301051836.30738-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

q2 is not always 384-byte length. Sometimes it only has 383-byte.
In this case, the valid portion of q2 is reordered reversely for
little endian order, and the remaining portion is filled with zero.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
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
2.19.1.3.ge56e4f7

