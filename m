Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB0F72C501
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 14:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjFLMvk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 08:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjFLMva (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 08:51:30 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430F010D3
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 05:51:25 -0700 (PDT)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 036F13F377
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 12:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686574284;
        bh=53EQLqkSYcnfUW7tWTa0tl0p5nwMGKAhLFezoflGDnw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=em66Y0x0xK6FWG+1lf/NjIPCTgDURMm49rSxe4/PG7NCnSqjVK5+2NqC5TE3zpuOf
         bq0VMge0MjifR68KwWTOd35JAmnQEi1T0pULT/FnXmH7IS0vR03VQVHNWLoOvtWNU5
         2GIhl5AH0Apj6h/Q6ar0UGTwPJGRhMxMWwhHOmVt70eu3rE3DMSR8+N4+CnFOuDXlY
         yrUZDVNTc3erNVfs1jsHYkrg4zbvSswRJrOwFtZxR+kBRMpmufbzoc1JOLF7GKPXGK
         hm+oykrUMQkPXE9jfGowjSrXCsq90lRmWJYBcj9wzweQzPApw1Bu5GCQfbPDiqfSnT
         h+YiSStHtN4bg==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1a689be8e85so800558fac.3
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 05:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574283; x=1689166283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53EQLqkSYcnfUW7tWTa0tl0p5nwMGKAhLFezoflGDnw=;
        b=guyaoTjPOs6ceNXdtxAO7YZexQIYJ/YcpYupx8HfnqLFv2qtEWnPC8T/dVsb/qEn/e
         XHuwLIpZocTMVowgpe0bluI1L0KJlekh0hKPiYOyFo738kDl0d8BgqHJy08PAGrKA4UF
         X8QQ+jup61DghpIlCjtoqq5uXvkj6C3m4IxmFuInJiEcnA2yUGdBIHPOu2EXfOA9yx6f
         opjPlZ0iOxBALC7xg6+2nZLXey1s00KfJYHm9bvzy7aeYfR0Mn0JJJ+mMEKrsRqV3GyF
         5mYTAbNOU7Z3q+BFAx9yEIVdD0d/ui6MpBCSKDKnxS50HAPq8TDESMjdciPpdFmjOwK1
         zd/A==
X-Gm-Message-State: AC+VfDzxjMscXT4sEQTZ9W6CmAxgoMeQLIVVGBtM1g/5ih28WIkStxXS
        Sx4dh78rDf800wbd1qPtTOJ8gRC7Y1H4vMyASZI3vtooJqchaXgkRFzSfPywNrOgaYOIBUUjJKU
        HMYuulc+jRTufwDCUfIybKeHPQdqc1DuKW6IgfF5Qb0O39g==
X-Received: by 2002:a05:6870:8785:b0:1a6:88c4:5815 with SMTP id r5-20020a056870878500b001a688c45815mr2399848oam.57.1686574282897;
        Mon, 12 Jun 2023 05:51:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7d6CuEdbi4X+dikuOxYc7owlwRtCAJacFJFzXKOQlEcvp7Jz/z6S00gZUboMLR6TJ52c8YVQ==
X-Received: by 2002:a05:6870:8785:b0:1a6:88c4:5815 with SMTP id r5-20020a056870878500b001a688c45815mr2399831oam.57.1686574282715;
        Mon, 12 Jun 2023 05:51:22 -0700 (PDT)
Received: from magali.. ([2804:14c:bbe3:4606:d612:b95d:6bdc:8f6d])
        by smtp.gmail.com with ESMTPSA id j22-20020a4ad196000000b00529cc3986c8sm3157193oor.40.2023.06.12.05.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:51:22 -0700 (PDT)
From:   Magali Lemes <magali.lemes@canonical.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, vfedorenko@novek.ru,
        tianjia.zhang@linux.alibaba.com
Cc:     andrei.gherzan@canonical.com, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] selftests: net: tls: check if FIPS mode is enabled
Date:   Mon, 12 Jun 2023 09:51:05 -0300
Message-Id: <20230612125107.73795-3-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612125107.73795-1-magali.lemes@canonical.com>
References: <20230612125107.73795-1-magali.lemes@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

TLS selftests use the ChaCha20-Poly1305 and SM4 algorithms, which are not
FIPS compliant. When fips=1, this set of tests fails. Add a check and only
run these tests if not in FIPS mode.

Fixes: 4f336e88a870 ("selftests/tls: add CHACHA20-POLY1305 to tls selftests")
Fixes: e506342a03c7 ("selftests/tls: add SM4 GCM/CCM to tls selftests")
Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
---
Changes in v3:
 - No need to initialize static variable to zero.
 - Skip tests during test setup only.
 - Use the constructor attribute to set fips_enabled before entering
 main().
 
Changes in v2:
 - Put fips_non_compliant into the variants.
 - Turn fips_enabled into a static global variable.
 - Read /proc/sys/crypto/fips_enabled only once at main().

 tools/testing/selftests/net/tls.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index e699548d4247..e4efe80d55e9 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -25,6 +25,8 @@
 #define TLS_PAYLOAD_MAX_LEN 16384
 #define SOL_TLS 282
 
+static int fips_enabled;
+
 struct tls_crypto_info_keys {
 	union {
 		struct tls12_crypto_info_aes_gcm_128 aes128;
@@ -235,7 +237,7 @@ FIXTURE_VARIANT(tls)
 {
 	uint16_t tls_version;
 	uint16_t cipher_type;
-	bool nopad;
+	bool nopad, fips_non_compliant;
 };
 
 FIXTURE_VARIANT_ADD(tls, 12_aes_gcm)
@@ -254,24 +256,28 @@ FIXTURE_VARIANT_ADD(tls, 12_chacha)
 {
 	.tls_version = TLS_1_2_VERSION,
 	.cipher_type = TLS_CIPHER_CHACHA20_POLY1305,
+	.fips_non_compliant = true,
 };
 
 FIXTURE_VARIANT_ADD(tls, 13_chacha)
 {
 	.tls_version = TLS_1_3_VERSION,
 	.cipher_type = TLS_CIPHER_CHACHA20_POLY1305,
+	.fips_non_compliant = true,
 };
 
 FIXTURE_VARIANT_ADD(tls, 13_sm4_gcm)
 {
 	.tls_version = TLS_1_3_VERSION,
 	.cipher_type = TLS_CIPHER_SM4_GCM,
+	.fips_non_compliant = true,
 };
 
 FIXTURE_VARIANT_ADD(tls, 13_sm4_ccm)
 {
 	.tls_version = TLS_1_3_VERSION,
 	.cipher_type = TLS_CIPHER_SM4_CCM,
+	.fips_non_compliant = true,
 };
 
 FIXTURE_VARIANT_ADD(tls, 12_aes_ccm)
@@ -311,6 +317,9 @@ FIXTURE_SETUP(tls)
 	int one = 1;
 	int ret;
 
+	if (fips_enabled && variant->fips_non_compliant)
+		SKIP(return, "Unsupported cipher in FIPS mode");
+
 	tls_crypto_info_init(variant->tls_version, variant->cipher_type,
 			     &tls12);
 
@@ -406,6 +415,7 @@ static void chunked_sendfile(struct __test_metadata *_metadata,
 
 TEST_F(tls, multi_chunk_sendfile)
 {
+
 	chunked_sendfile(_metadata, self, 4096, 4096);
 	chunked_sendfile(_metadata, self, 4096, 0);
 	chunked_sendfile(_metadata, self, 4096, 1);
@@ -1865,4 +1875,17 @@ TEST(prequeue) {
 	close(cfd);
 }
 
+static void __attribute__((constructor)) fips_check(void) {
+	int res;
+	FILE *f;
+
+	f = fopen("/proc/sys/crypto/fips_enabled", "r");
+	if (f) {
+		res = fscanf(f, "%d", &fips_enabled);
+		if (res != 1)
+			ksft_print_msg("ERROR: Couldn't read /proc/sys/crypto/fips_enabled\n");
+		fclose(f);
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.34.1

