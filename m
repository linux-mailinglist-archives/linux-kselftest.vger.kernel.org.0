Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E41E72E312
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbjFMMcs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 08:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240612AbjFMMcn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 08:32:43 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F95E7A
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 05:32:42 -0700 (PDT)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 09EF03F26D
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 12:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686659560;
        bh=hHaMBfP8cTjp0xc0R7xoilj8XNV0BDQ4DKwZIDqU/Oo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=jiG6uiNir2yOD0EIDfGwrKl1BlRbsmYe9rnz1oKwWAfJoAM0xSCr/SCAtiq1/9uaR
         YxS1YgfbyIaq3mefbHq4xGet/VB9Xd54jt3mn8EwgatV4KOlUx8wNarbFCW8M9MlZM
         JbkXmIbxXAhtnM6yIJ7qThCMzzgzevzFg6WYU6K3KHA4o9iOSI7IZcW+OWuNXRVgR2
         fYpREBoYMvgQ2FLiS8jqYDa2grR28j1qzJChvG036ulKpz5AMmoSANL/qQ+tOa0tB+
         VplaMaZX9xVUdt2ZqWw7p8D5gquok8Dksyqq0KhqydLQ7bt2ln7esvKzficQTmTEEF
         j9/48D4icmAvg==
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-39cdb840b72so1683995b6e.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 05:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686659558; x=1689251558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHaMBfP8cTjp0xc0R7xoilj8XNV0BDQ4DKwZIDqU/Oo=;
        b=XuPyxXZVwLhohiVxrBjXj2+MPlKG26q1HBCAykOUHeL17J+rE6H0rcKG90YW5oYDGW
         qz53hCtEkgFVDV9zct1zv8OmoWZPoGvZHgnnjC3sZd+jJLkHq7Jpk95y/pj55twW9W7Z
         ompO/qmvrj5/wPt3NKc71KlxyslP4Sj5x7i+3x4Vz84iOaE4J05KNIUM2OH9KquEwfpV
         6PpNiSkFuXE6vVsYmITJkQ9XJeRjHVCE1pxYek+xLdahmQfVut5/iBD7vmd0HnZ/BYav
         ZXf/zbD7y+UYx/7ORHchdD6UYiUHOFmlWff4Dh8Pb+Ngzi05EInUb/KCiTjWZsbs7bR5
         c//w==
X-Gm-Message-State: AC+VfDx6+OKZrCeodDG2okzypbQG2YHJvtdWUsqQWkfI2LGCPSgearPn
        x622AI0F23Ks1hzW/pXLSNKzYVdE4K0CjAuA95wJfdgGwHp7Ji7RqVuqgpKwmsfnPqBrxZuzVF2
        Cdna7y7erO6IRaUatBgKgBij1idUQYGahzYyqgCyt/du7Mw==
X-Received: by 2002:a05:6808:9a6:b0:39a:be43:6f13 with SMTP id e6-20020a05680809a600b0039abe436f13mr7138064oig.43.1686659558523;
        Tue, 13 Jun 2023 05:32:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RfknMhI+ej6W4l7lYiCx6ttQnGKf4kPAEtDH1QaZaaEH5xHKVB655Rt8z4qsy4Iy99d7DmA==
X-Received: by 2002:a05:6808:9a6:b0:39a:be43:6f13 with SMTP id e6-20020a05680809a600b0039abe436f13mr7138046oig.43.1686659558292;
        Tue, 13 Jun 2023 05:32:38 -0700 (PDT)
Received: from magali.. ([2804:14c:bbe3:4606:ac1a:e505:990c:70e9])
        by smtp.gmail.com with ESMTPSA id z26-20020a056808049a00b0039c532c9ae1sm4838116oid.55.2023.06.13.05.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 05:32:37 -0700 (PDT)
From:   Magali Lemes <magali.lemes@canonical.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, vfedorenko@novek.ru,
        tianjia.zhang@linux.alibaba.com
Cc:     andrei.gherzan@canonical.com, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] selftests: net: tls: check if FIPS mode is enabled
Date:   Tue, 13 Jun 2023 09:32:20 -0300
Message-Id: <20230613123222.631897-3-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613123222.631897-1-magali.lemes@canonical.com>
References: <20230613123222.631897-1-magali.lemes@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
---
Changes in v4:
 - Add R-b tag.
 - Remove extra newline.
 
Changes in v3:
 - No need to initialize static variable to zero.
 - Skip tests during test setup only.
 - Use the constructor attribute to set fips_enabled before entering
 main().
 
Changes in v2:
 - Put fips_non_compliant into the variants.
 - Turn fips_enabled into a static global variable.
 - Read /proc/sys/crypto/fips_enabled only once at main().

 tools/testing/selftests/net/tls.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index e699548d4247..ff36844d14b4 100644
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
 
@@ -1865,4 +1874,17 @@ TEST(prequeue) {
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

