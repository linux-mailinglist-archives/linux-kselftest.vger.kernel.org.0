Return-Path: <linux-kselftest+bounces-489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D290D7F66C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 19:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025831C20934
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 18:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B007A41232;
	Thu, 23 Nov 2023 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="cSdtf/wV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF2CD40
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:58:31 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9fa2714e828so155763266b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700765910; x=1701370710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D52mho4bbVBLhO1MqSHLzeH5mafSEJrrR5dOy4gDBr8=;
        b=cSdtf/wVdnMJpBcJIHXBcSzwoCpd9ei0cVYoiTlsuwkgwzmMX2rsXqh7DHqJZb2GR6
         txjD7zh/dpMHGYLNjJ0pjnEAArPzqd9/sGVgLNirIjC65CIDO3vZdyEHLHMZpHudpD+o
         O3Ewgk1y5KE/2OyFRGwBZnCEWW4N1ggOKX6EOvTmUA4+CAfKWATRqeOhx+F89hWYXlP0
         0hDEF4OM/PJK079sHxwfNyiEzAxVX8TIyRVhO5k5CgI9t6VUXViKAVZMaWAaq0Znqe5a
         H/1oPod2UF2tq4WfmSMaY6fBrsEB4q7yXuupPXzwgrjQCBjyWatLxl0NmOE9Gknn7MSm
         5DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765910; x=1701370710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D52mho4bbVBLhO1MqSHLzeH5mafSEJrrR5dOy4gDBr8=;
        b=qkxZd5yV02oTo1ojD6xD23fDF93I+s9bIJPZUkolyQAQsigzO9e2lJMDf8r0GxtzPw
         n39CJAps2CYPwDQxZIcHlOfv2pKP5DHXxS0OHsiby6SuDuVy40Idac77b8tmVBXKNwep
         FrxTvQsnbi0rGcQzsU5wk86s67Bcick3jV9cZomvyP82RvBBipEcZEJlPfDwcVAfmidj
         T6bqCwJNOAUzpHA+CFp4a/sGTN6gafNvYs7h1xQXsGegmsYJJ2HRHpH7n2O2xwmChgdU
         ykG8xnzjKg7Iul5dTvvuG3zNqVI49qLov7MgEBydFvwy5HSQWrgt5Ud83J1wUXTWs3Q8
         Pvpg==
X-Gm-Message-State: AOJu0YzvTMYtYbPzS0QPIRsuRc1ltFE2uWFlt2WlF2sWRp7R45yFS9UK
	RpLw6yPDlYxbQ637VACYNCi9Mw==
X-Google-Smtp-Source: AGHT+IFVVpG1Z6gxPdaL7IaaTFJinrPmrgoX6cwu9dsiRja9dZsbaJhr6jSoHE3EsEV83YZM2drU6A==
X-Received: by 2002:a17:906:738b:b0:9f8:2f30:d74f with SMTP id f11-20020a170906738b00b009f82f30d74fmr185134ejl.7.1700765909911;
        Thu, 23 Nov 2023 10:58:29 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906231700b009ff1997ce86sm1115944eja.149.2023.11.23.10.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:58:29 -0800 (PST)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Shuah Khan <shuah@kernel.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Evan Green <evan@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH 2/5] tools: selftests: riscv: Fix compile warnings in cbo
Date: Thu, 23 Nov 2023 19:58:18 +0100
Message-ID: <20231123185821.2272504-3-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
References: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christoph Müllner <christoph.muellner@vrull.eu>

GCC prints a couple of format string warnings when compiling
the cbo test. Let's follow the recommendation in
Documentation/printk-formats.txt to fix these warnings.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 tools/testing/selftests/riscv/hwprobe/cbo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
index 50a2cc8aef38..c6a83ab11e22 100644
--- a/tools/testing/selftests/riscv/hwprobe/cbo.c
+++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
@@ -97,7 +97,7 @@ static void test_zicboz(void *arg)
 	block_size = pair.value;
 	ksft_test_result(rc == 0 && pair.key == RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE &&
 			 is_power_of_2(block_size), "Zicboz block size\n");
-	ksft_print_msg("Zicboz block size: %ld\n", block_size);
+	ksft_print_msg("Zicboz block size: %llu\n", block_size);
 
 	illegal_insn = false;
 	cbo_zero(&mem[block_size]);
@@ -121,7 +121,7 @@ static void test_zicboz(void *arg)
 		for (j = 0; j < block_size; ++j) {
 			if (mem[i * block_size + j] != expected) {
 				ksft_test_result_fail("cbo.zero check\n");
-				ksft_print_msg("cbo.zero check: mem[%d] != 0x%x\n",
+				ksft_print_msg("cbo.zero check: mem[%llu] != 0x%x\n",
 					       i * block_size + j, expected);
 				return;
 			}
@@ -201,7 +201,7 @@ int main(int argc, char **argv)
 	pair.key = RISCV_HWPROBE_KEY_IMA_EXT_0;
 	rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)&cpus, 0);
 	if (rc < 0)
-		ksft_exit_fail_msg("hwprobe() failed with %d\n", rc);
+		ksft_exit_fail_msg("hwprobe() failed with %ld\n", rc);
 	assert(rc == 0 && pair.key == RISCV_HWPROBE_KEY_IMA_EXT_0);
 
 	if (pair.value & RISCV_HWPROBE_EXT_ZICBOZ) {
-- 
2.41.0


