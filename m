Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE3E3D9910
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 00:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhG1Wvx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 18:51:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232073AbhG1Wvv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 18:51:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CCB66103C;
        Wed, 28 Jul 2021 22:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627512709;
        bh=oBJuZNTcYSVTfhtRKT7AVcyVXW3ahX3jWEHrGsp4I90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bIZpFoxwmIqFOd/3YF5dNLp73ApkdZ8lm7+HvOrEp6p+cv+GTYlz7ID252JiPTbGR
         LnGI7uxEMhuBU2gjOlp0qSOIy2GOFMyl6iKyaK7OX+mqmXLVZdMg6cliDhmh+RP37H
         BRFRaPSem74qaHQq2+KTJ9jsqxuIMEj84v69IZBUmUlO6onWq6rbedxUBFHS5qBIpA
         UAEy0uQGQQvaMtJpr6OYaFN9Xwf4tY07Gmxi3DYDFo/OWUHE3jqKroaq+9rXopvc1X
         qktDQnaw1lE0wEwoEt7d5F3sk8IioUPnrPdduNjIGZ8rvFSNTHamUD597xu8VZjcoL
         qw9UwpP5SmOYw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] selftests/sgx: Fix calculations for sub-maximum field sizes
Date:   Thu, 29 Jul 2021 01:51:38 +0300
Message-Id: <20210728225140.248408-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210728225140.248408-1-jarkko@kernel.org>
References: <20210728225140.248408-1-jarkko@kernel.org>
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

The original patch did a bad job explaining the code change but it
turned out making sense. I wrote a new description.

Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
Link: https://lore.kernel.org/linux-sgx/20210301051836.30738-1-tianjia.zhang@linux.alibaba.com/
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---

v4:
- Updated the short summary according to:
  https://lore.kernel.org/linux-sgx/4303b822-5861-ba2c-f620-0e752e499329@intel.com/

v3:
- Adjusted the fixes tag to refer to the correct commit

v2:
- Added a fixes tag.

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

