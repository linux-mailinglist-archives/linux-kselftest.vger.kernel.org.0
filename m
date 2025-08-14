Return-Path: <linux-kselftest+bounces-38975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B16E0B26951
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 16:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449971CE679B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3E5321451;
	Thu, 14 Aug 2025 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pkigFILR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AE7321434;
	Thu, 14 Aug 2025 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181094; cv=none; b=mx/MwdIOm+ZKevr8gEMMd64nZW68w2r8IYsbKkFGQx5TNSnLaiiqDOtBY956Xai7wGtxm3yWuXsg7mTihDVQmZN0yk8WvvpqpWCUB+RBX5hYeNmrdvltm5g9ZD4QBSY4guZZn7DdgbUy+Gty+uMYWeLl99kZjOvTd9ypIWinPzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181094; c=relaxed/simple;
	bh=IhC+AH+sL5Ewpx1ekxRZP9eUwSnEE189Nad6dFGz4wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFpbgJX5aZurXQhqXZbwEPvGToFYvidHoGL5qmNL0P2bwV8XDTy/rY+HInEMKPUUZBsfb85qgqazopO2rTfxUoZ697mYnXHW2E8GmgGvigm4NHVA8vvtlFgERjMvJm2tQwRyJzQnu/JrmuSVA+IzyF+v1eDSxU3OhxFHqai1Uos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pkigFILR; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gV
	8fEWQYv6PwrR4EGbkUj3gAtUsDrnYbn3W2p81RopA=; b=pkigFILRnwf3AjC2Tj
	lYJA8damRV/npAT4x6j1OW1ZZzeVvcIZBmo/t2H9jeEYPFAxZkLElH8Z6zphRjQr
	ojD2OXSil/LWAqmo4TZtW9zlxJNx/PUr1HkFSXbc0ERce7cAWpGfLR6srNahx2S/
	jE9QpXNyvRR52l+9EOY83LCFc=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAXt8QG8J1otxnOBw--.45910S5;
	Thu, 14 Aug 2025 22:17:45 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v9 3/3] selftests/bpf: make usdt_o2 reliably generate SIB USDT arg spec
Date: Thu, 14 Aug 2025 14:17:40 +0000
Message-ID: <20250814141741.77698-4-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814141741.77698-1-phoenix500526@163.com>
References: <20250814141741.77698-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXt8QG8J1otxnOBw--.45910S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7WryrKw48tFyDGF17ZrW5Wrg_yoW8KFykpa
	4kGayYkF1kXFyfA34xJrW7Z3WrK3Z7ArW8ArWkK34vvF1UJ348Xr47K3Wjv3s8C3yF934Y
	vay8t3s5ua18AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jT4E_UUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFAOpiGid7mspcQAAse

usdt_o2 is intended to exercise the SIB (Scale-Index-Base) argument
handling in libbpf's USDT path. With GCC 13 this reliably produced a
SIB-form argument (e.g. 8@(%rdx,%rax,8)), but with newer GCC (e.g. 15)
the compiler frequently optimizes the probe argument into a plain
register (e.g. 8@%rax) or a stack slot, so the test stops covering the
SIB code path and becomes flaky across toolchains.

Force a SIB memory operand in the probe by:
* placing the base pointer into %rdx and the index into %rax using an
  empty inline asm with output constraints ("=d", "=a") and matching
  inputs
* immediately passing base[idx] to STAP_PROBE1.

This makes the compiler encode the operand as SIB (base + index8),
which in .note.stapsdt shows up as 8@(%rdx,%rax,8) regardless of GCC
version. A memory clobber and noinline prevent reordering/re-allocation
around the probe site.

This change is x86_64-specific and does not alter program semantics; it
only stabilizes the USDT argument shape so the test consistently
validates SIB handling. Clang historically prefers stack temporaries for
such operands, but the selftests build with GCC, and this keeps behavior
stable across GCC versions without introducing a separate .S file.

Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
---
 tools/testing/selftests/bpf/prog_tests/usdt_o2.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt_o2.c b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
index f02dcf5188ab..920df73649b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
@@ -15,11 +15,15 @@ __attribute__((optimize("O2")))
 int lets_test_this(int);
 static volatile __u64 array[1] = {test_value};
 
-static __always_inline void trigger_func(void)
+static noinline void trigger_func(void)
 {
 	/* Base address + offset + (index * scale) */
-	for (volatile int i = 0; i <= 0; i++)
-		STAP_PROBE1(test, usdt1, array[i]);
+	/* Force SIB addressing with inline assembly */
+	const __u64 *base;
+	__u32 idx;
+	/* binding base to %rdx and idx to %rax */
+	asm volatile("" : "=d"(base), "=a"(idx) : "0"(array), "1"((__u32)0) : "memory");
+	STAP_PROBE1(test, usdt1, base[idx]);
 }
 
 static void basic_sib_usdt(void)
-- 
2.43.0


