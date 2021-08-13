Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5851B3EBD4E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Aug 2021 22:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhHMU3T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Aug 2021 16:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbhHMU3T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Aug 2021 16:29:19 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FD1C061756
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Aug 2021 13:28:51 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id o185so17600302oih.13
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Aug 2021 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=zk1heXrMYtMEgRgp0UUFws+A6Ti7NQpBEIoZ/rcxUIA=;
        b=HpJ++4TkSiT7tXjH6uZWBqx3wvzNFo+Jrr65Jk3Irp4R5Tpxh/q00HHNAThglteN9j
         y6jesKB+sQUjm+C7RkzsC5RryrlgWSCkc4v/LHyLaGg1+OuLNhQRB/tHf5lI56eJP+vA
         rQLQNRcYp3VQgtWczVL8TyVN7W36icZHoim/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=zk1heXrMYtMEgRgp0UUFws+A6Ti7NQpBEIoZ/rcxUIA=;
        b=LKCdOTd5AIkdZWZ5RT8eYv+NVoekoKvsVxyr5t4f9LddD+t5h0fbP4BYrlMrrP+Gid
         GTLRwzlHr1mtE3HwHatVfQ2kkxu5WpKTmXOQqQmzaRu2bGTx4o91aEfNXUOeXApSV/+e
         ajFGNhuLgiUqD12t6AhR7hiYnjUH3Aa6uDGZ0nSid7TbIdvY/f5j++phPxEeuoxvheQ3
         UfzUX1BrshA2qfaYdN+Tb/DuYjQ33ZXLC4eOlnqCGbqr4EnAE4cRcYXSfA3JSNrqzZ9+
         xJw/JAxdr+bBHxn+OQpKm4n9ORwTVEiwU0DBJr3pULejW0LW+oMF8U1+IEJGzWtmVyR2
         tbtw==
X-Gm-Message-State: AOAM531HHVSx6K4iGszAKP/QezAf2XbB+sv67bujZlURaZa92FSY6zBX
        CYVM4uQyo103ztU7V0MpaJM6BQ==
X-Google-Smtp-Source: ABdhPJyPMGSNbTRUvOoP64e+K7c7MuB2NsgzhM14FVCQM63TgFT4G7ND8o9CL8N3fuyJikz2JhTh+A==
X-Received: by 2002:aca:44d4:: with SMTP id r203mr3593452oia.126.1628886531195;
        Fri, 13 Aug 2021 13:28:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 45sm537475otm.43.2021.08.13.13.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 13:28:50 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.14-rc6
Message-ID: <f27686fd-6fb5-a906-b2d0-1e07cdf83594@linuxfoundation.org>
Date:   Fri, 13 Aug 2021 14:28:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------6505005E49B8889672A6C2AA"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------6505005E49B8889672A6C2AA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.14-rc6

This Kselftest fixes update for Linux 5.14-rc6 consists of a single patch
to sgx test to fix Q1 and Q2 calculation.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

   Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.14-rc6

for you to fetch changes up to 567c39047dbee341244fe3bf79fea24ee0897ff9:

   selftests/sgx: Fix Q1 and Q2 calculation in sigstruct.c (2021-07-30 17:20:01 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-5.14-rc6

This Kselftest fixes update for Linux 5.14-rc6 consists of a single patch
to sgx test to fix Q1 and Q2 calculation.

----------------------------------------------------------------
Tianjia Zhang (1):
       selftests/sgx: Fix Q1 and Q2 calculation in sigstruct.c

  tools/testing/selftests/sgx/sigstruct.c | 41 +++++++++++++++++----------------
  1 file changed, 21 insertions(+), 20 deletions(-)
----------------------------------------------------------------

--------------6505005E49B8889672A6C2AA
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.14-rc6.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.14-rc6.diff"

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

--------------6505005E49B8889672A6C2AA--
