Return-Path: <linux-kselftest+bounces-3701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4BA841247
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 19:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6171E1C20805
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 18:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B565D15B318;
	Mon, 29 Jan 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIBFseSC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4F14A82;
	Mon, 29 Jan 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553345; cv=none; b=D9cBfm6FukClvGFvl5IDMKO38afLmRdjOtvU9xI9eW+FSoNYoQuMltSeBViRmaxUAhI/6egDTKwLncO6qKNQQXXCk8jaC6/ebAAMrZWoRT3KBW7B2uohM3ckfndVMnK6KEHBPZMZ3MZEvRPNGiaDXWfWRV0d+Hy7oNqxcSUGM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553345; c=relaxed/simple;
	bh=H2EIKyHNqt/QqyCRuOiVadg27WBq+mf8PQAQyZ6TLnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xpu9uymfTjDczdG/gfte545vD371fwHM5vRdqkZVLFcS26iqWQnq5H4z+Z4mAAKAjrF7YrE3k4p+eoF7YQ8kWARbiEYw48HkjQ6ZwQl3qtmDEYmxCVCEgFPlEGmz4laGVvw+7fXa+eGu41aU8cpwe/2jrDuRa0iKKxtVANM75+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIBFseSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAECC433F1;
	Mon, 29 Jan 2024 18:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553345;
	bh=H2EIKyHNqt/QqyCRuOiVadg27WBq+mf8PQAQyZ6TLnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mIBFseSC70rZYAa/Hea6PoYdTS9bUhcF1Xe08TSSEaqQnfcr1gWrdOKZKCugXST89
	 TmQBIZ4HVinFZ1FavCMuyiveUliyQqudu3q5vsaHWKChf9BubAZcZjKKtIBgd+brML
	 aHLuSTXIv+KRzY4ncVrizVuT8UgDdOVv+XZehVh4NVfPRmj0fr5au5/npxsSRKHcmU
	 Tk/GD6SN0zOtNoBS0Xna6zcv0uef+fEvSf5Rtl4KKRCDqhh841Ugmr0RXZel3Yn2m2
	 AG+tiRHRkNJyA8zzqEwoJEG9c8IGBCbbZYA4mnoC2HsQ4qogs/UVKF1EvLM4LazSND
	 Vc9+80wSzgCCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	andy.chiu@sifive.com,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 04/10] tools: selftests: riscv: Fix compile warnings in vector tests
Date: Mon, 29 Jan 2024 13:35:12 -0500
Message-ID: <20240129183530.464274-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183530.464274-1-sashal@kernel.org>
References: <20240129183530.464274-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
Content-Transfer-Encoding: 8bit

From: Christoph Müllner <christoph.muellner@vrull.eu>

[ Upstream commit e1baf5e68ed128c1e22ba43e5190526d85de323c ]

GCC prints a couple of format string warnings when compiling
the vector tests. Let's follow the recommendation in
Documentation/printk-formats.txt to fix these warnings.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Link: https://lore.kernel.org/r/20231123185821.2272504-5-christoph.muellner@vrull.eu
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/riscv/vector/v_initval_nolibc.c | 2 +-
 tools/testing/selftests/riscv/vector/vstate_prctl.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
index 66764edb0d52..1dd94197da30 100644
--- a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
@@ -27,7 +27,7 @@ int main(void)
 
 	datap = malloc(MAX_VSIZE);
 	if (!datap) {
-		ksft_test_result_fail("fail to allocate memory for size = %lu\n", MAX_VSIZE);
+		ksft_test_result_fail("fail to allocate memory for size = %d\n", MAX_VSIZE);
 		exit(-1);
 	}
 
diff --git a/tools/testing/selftests/riscv/vector/vstate_prctl.c b/tools/testing/selftests/riscv/vector/vstate_prctl.c
index b348b475be57..8ad94e08ff4d 100644
--- a/tools/testing/selftests/riscv/vector/vstate_prctl.c
+++ b/tools/testing/selftests/riscv/vector/vstate_prctl.c
@@ -68,7 +68,7 @@ int test_and_compare_child(long provided, long expected, int inherit)
 	}
 	rc = launch_test(inherit);
 	if (rc != expected) {
-		ksft_test_result_fail("Test failed, check %d != %d\n", rc,
+		ksft_test_result_fail("Test failed, check %d != %ld\n", rc,
 				      expected);
 		return -2;
 	}
@@ -87,7 +87,7 @@ int main(void)
 	pair.key = RISCV_HWPROBE_KEY_IMA_EXT_0;
 	rc = riscv_hwprobe(&pair, 1, 0, NULL, 0);
 	if (rc < 0) {
-		ksft_test_result_fail("hwprobe() failed with %d\n", rc);
+		ksft_test_result_fail("hwprobe() failed with %ld\n", rc);
 		return -1;
 	}
 
-- 
2.43.0


