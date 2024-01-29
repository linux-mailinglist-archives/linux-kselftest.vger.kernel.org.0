Return-Path: <linux-kselftest+bounces-3698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22F2841224
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 19:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FCC1F21857
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 18:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA09158D6D;
	Mon, 29 Jan 2024 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKeisS19"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313436F068;
	Mon, 29 Jan 2024 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553298; cv=none; b=STPKj3o2jS9nAxawFq+uSmGwdRlrBCSGpaLYNTS+mclQVaWXI5NFf5VLL6ceZK0OnLiYAwH4JgPojnSrG0k1/vdP74xoEmL/+Xf6h25l18UoClY50ui0OC6QpLkmXdfzc+SvJJnb8xnUVZ4HKSHX1XlMRVQTe7Y2aKHmVWKNQqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553298; c=relaxed/simple;
	bh=PlVbhVGQ8tUCk8layvfua62R163O3sO8M81xazBObPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpvc8gcBI5ufiMnjd8Sa3kIK/itt5/h6wasJzi4cd4ptfHLcSagxA/bC7nn0WN0aPhTP93W2v405y2yVJYJw69qMDq/+ciYgOXpXvQLlsS6K2snnHfGuyvcnMdHGFzAP1uIN0SC5Ow2RTDZJo+PNEsSEKt8EGuJx+Y5ovDMijOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKeisS19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390AFC43394;
	Mon, 29 Jan 2024 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553297;
	bh=PlVbhVGQ8tUCk8layvfua62R163O3sO8M81xazBObPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KKeisS19a0LzsAh5+60QIkdDSvtzZ+1IFJHRx+y+u2zttj1SrrwkXcFIucVvCV3v7
	 B8uwqHj/BHHnyvBPkWxr9tLMc8JHKdini5MquW/zmjucciJqrTlZflSqr22Y/vF9/g
	 zyfe/VavSLHWmxOnoXycWeDlcP4UrhupqTHh7NSy332eV8gJk64H1DscwkKD2zdP57
	 zND5QFa0c85uH4NkNP99G4veJf7R58UkGrQKY78tm5pq5L0Mh5OvVjY2Q1qXrJkrw2
	 QxSP97EJX6j0A3/1jUUGHMrr3KTE/BFxwPzcY4h+VsJZmLyZVxigPlAsYw/rI1Y2NA
	 mNewIgcOdoDEw==
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
	xiao.w.wang@intel.com,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 05/12] tools: selftests: riscv: Fix compile warnings in cbo
Date: Mon, 29 Jan 2024 13:34:14 -0500
Message-ID: <20240129183440.463998-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183440.463998-1-sashal@kernel.org>
References: <20240129183440.463998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Christoph Müllner <christoph.muellner@vrull.eu>

[ Upstream commit ac7b2a02d62faff8c6d45bacb5cb9ea565b47776 ]

GCC prints a couple of format string warnings when compiling
the cbo test. Let's follow the recommendation in
Documentation/printk-formats.txt to fix these warnings.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Link: https://lore.kernel.org/r/20231123185821.2272504-3-christoph.muellner@vrull.eu
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.43.0


