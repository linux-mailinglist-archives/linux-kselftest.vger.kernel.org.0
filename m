Return-Path: <linux-kselftest+bounces-3697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4765841220
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 19:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6EFC1C230D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73778158D7F;
	Mon, 29 Jan 2024 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJBeMdWe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF0158D6D;
	Mon, 29 Jan 2024 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553292; cv=none; b=anfMjfAwsWcgYePl7oYwtIjG2VpO+UFFmIVVUU0hyRQgg5PR4HYEHxr3Ep7BK0EaE1VI0IKO0bMKNMD0xa81DvuW5ZpMZfmTON516CZa+uLdSrTvqQ0IUtf/OqLH67GPEbkB0a33Iyy+PK4j6jD6y6AZNw/ATQgxkFT214kDmBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553292; c=relaxed/simple;
	bh=zbxsB1oxUos+a3QWxXh+2OjTJJLQCeYRqaI3ZWG1QEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRfaiZ2H54bzBWYvl8DWU1epFGzx2JxZcZ7hcIBzfV4udFE58EttbkVIOnki1DUzWjF9b8/n+UVT2YCxRjN4nTWTqHGrNSvrWI0HsSQUofoPNNHUPBG0pi7ZgS96kXAaAf8VU6QFKfHVuynFXvAjPC4bG8VyyXEWd+nVBvVWzHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJBeMdWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF1BC43390;
	Mon, 29 Jan 2024 18:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553291;
	bh=zbxsB1oxUos+a3QWxXh+2OjTJJLQCeYRqaI3ZWG1QEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJBeMdWerZ4vPia3gjlF2Vpy0sG+4WuBYGxJ4wA+M3Yu/2xML3PY4w1jKSwZ9JoTR
	 qCOFwAlFS0l22DHcetFC23dQThFgpKNvaTGuBNUUQNF0r7bYX84C623wRTmaNTFmSA
	 GOG/ZaCWnsJKINE9sOLhiQaUeFohtYFE/RV47JbkFIzRaSPjB77ygjsgzB+TNnn0bt
	 Ys+AXaHWwPmsbLqFRH3Wq2eq4l8qDdhnKxDJT+gn+f+omi57VTtcmJ4d6IFjckfTbs
	 trfYSI3xQaDh3ZCB8DygX727N0HXeKJU57j2zERR30XIE4JOq1L/C135lsC1b35p+k
	 Z9n5Rr68cex0Q==
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
	conor.dooley@microchip.com,
	evan@rivosinc.com,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 04/12] tools: selftests: riscv: Fix compile warnings in hwprobe
Date: Mon, 29 Jan 2024 13:34:13 -0500
Message-ID: <20240129183440.463998-4-sashal@kernel.org>
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

[ Upstream commit b91c26fdb0e8150cdb610cdaadea62bb5e43bee0 ]

GCC prints a couple of format string warnings when compiling
the hwprobe test. Let's follow the recommendation in
Documentation/printk-formats.txt to fix these warnings.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Link: https://lore.kernel.org/r/20231123185821.2272504-2-christoph.muellner@vrull.eu
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/riscv/hwprobe/hwprobe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/hwprobe.c b/tools/testing/selftests/riscv/hwprobe/hwprobe.c
index c474891df307..abb825811c70 100644
--- a/tools/testing/selftests/riscv/hwprobe/hwprobe.c
+++ b/tools/testing/selftests/riscv/hwprobe/hwprobe.c
@@ -29,7 +29,7 @@ int main(int argc, char **argv)
 		/* Fail if the kernel claims not to recognize a base key. */
 		if ((i < 4) && (pairs[i].key != i))
 			ksft_exit_fail_msg("Failed to recognize base key: key != i, "
-					   "key=%ld, i=%ld\n", pairs[i].key, i);
+					   "key=%lld, i=%ld\n", pairs[i].key, i);
 
 		if (pairs[i].key != RISCV_HWPROBE_KEY_BASE_BEHAVIOR)
 			continue;
@@ -37,7 +37,7 @@ int main(int argc, char **argv)
 		if (pairs[i].value & RISCV_HWPROBE_BASE_BEHAVIOR_IMA)
 			continue;
 
-		ksft_exit_fail_msg("Unexpected pair: (%ld, %ld)\n", pairs[i].key, pairs[i].value);
+		ksft_exit_fail_msg("Unexpected pair: (%lld, %llu)\n", pairs[i].key, pairs[i].value);
 	}
 
 	out = riscv_hwprobe(pairs, 8, 0, 0, 0);
-- 
2.43.0


