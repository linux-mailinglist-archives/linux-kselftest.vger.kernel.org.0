Return-Path: <linux-kselftest+bounces-3700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB27841229
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 19:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF2F2877A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 18:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CF1159595;
	Mon, 29 Jan 2024 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcUfAF4o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5146F08C;
	Mon, 29 Jan 2024 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553311; cv=none; b=l56VMrybng9z3EztCPMGgExLnntfVXNV/JquKl2tEyt1xvcXqbhGi0jPctp9avBDPDQa1P40DuHXS90FfUcBiblwGCo7hI/SwhQ1SPo7+F4t6LRP4H8oUX5XWlB9IjV784N1RR5tSV8KzyX0N4vccRV/7XomPIDJt41pgDhtU5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553311; c=relaxed/simple;
	bh=7VTqyRWqMQC0WC90AaVTLUlSbK4Is7wpRvZH7TdlOyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqQbUtUvs2C5l3XtpItjp9JpM3Y3mq8e02GktGHe1sUMwI8AnlVLTor4p59YclsnUKRdWr5yiUTO51qInZBlkYnt+RZcWh6+NMuXnyxYslKXIB+drqikKcVkpIwoqL1zGF0255WkObisqgaarr7ITnHMB7ZsiIku6uQekcyw4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcUfAF4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE29C433C7;
	Mon, 29 Jan 2024 18:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553310;
	bh=7VTqyRWqMQC0WC90AaVTLUlSbK4Is7wpRvZH7TdlOyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VcUfAF4oox07JxNeZjVqndQOQ73Z/AxGwW9f+B2PfZoA7mqH1pyMpdZJUO1cZG+E0
	 iXma0p+cpp5O881JaSM5OLhH2z7GjOeFvliwkUpkDQ7PG3GBEryIEYJeHD9fD55qIN
	 GmlOBy2/LRCYh5z147k2Mrh8SN5RTqxGQELlxr7p0WrT6QRphPGSRRPhTL/AUYTJxv
	 kGGXV8R777N/ybo8q9m6b3yuTJ2MRj9Fa0wj7sSxRVprWBWZtsr+Lmxw23Gg37FZw7
	 0Z+VhSs/BUylIOkX81HnXW4yniEP4xqEqQe0weFt/lIK3yMtyYv0nIBN4t17CaE/OQ
	 BQrhpVXUlb6rw==
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
	charlie@rivosinc.com,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 07/12] tools: selftests: riscv: Fix compile warnings in mm tests
Date: Mon, 29 Jan 2024 13:34:16 -0500
Message-ID: <20240129183440.463998-7-sashal@kernel.org>
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

[ Upstream commit 12c16919652b5873f524c8b361336ecfa5ce5e6b ]

When building the mm tests with a riscv32 compiler, we see a range
of shift-count-overflow errors from shifting 1UL by more than 32 bits
in do_mmaps(). Since, the relevant code is only called from code that
is gated by `__riscv_xlen == 64`, we can just apply the same gating
to do_mmaps().

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Link: https://lore.kernel.org/r/20231123185821.2272504-6-christoph.muellner@vrull.eu
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/riscv/mm/mmap_test.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/riscv/mm/mmap_test.h b/tools/testing/selftests/riscv/mm/mmap_test.h
index 9b8434f62f57..2e0db9c5be6c 100644
--- a/tools/testing/selftests/riscv/mm/mmap_test.h
+++ b/tools/testing/selftests/riscv/mm/mmap_test.h
@@ -18,6 +18,8 @@ struct addresses {
 	int *on_56_addr;
 };
 
+// Only works on 64 bit
+#if __riscv_xlen == 64
 static inline void do_mmaps(struct addresses *mmap_addresses)
 {
 	/*
@@ -50,6 +52,7 @@ static inline void do_mmaps(struct addresses *mmap_addresses)
 	mmap_addresses->on_56_addr =
 		mmap(on_56_bits, 5 * sizeof(int), prot, flags, 0, 0);
 }
+#endif /* __riscv_xlen == 64 */
 
 static inline int memory_layout(void)
 {
-- 
2.43.0


