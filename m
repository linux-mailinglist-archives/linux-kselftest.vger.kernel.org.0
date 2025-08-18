Return-Path: <linux-kselftest+bounces-39201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EE5B29B26
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F26F18A58D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 07:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F642874FF;
	Mon, 18 Aug 2025 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K+BiXooO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AD328724A;
	Mon, 18 Aug 2025 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503230; cv=none; b=r1bHn9FeEjkNGTCmZ+jKjxdzVEVOB70gF+86sg/xx3gtegdenCwJpOCTdcpCEtO6zR+3O1Ip3PVMTcdEX5uBvrwBgmo1YFXNXpViwKDq5k9uNB0rXmAR2juFPUoDQ3Vrjn3ad1X0sLhfhaAJQm3JwLV3Qc48Chw/BYXB6Hsb4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503230; c=relaxed/simple;
	bh=afPpq7m4/xuyQ3D2C1DuWGZ7+Me4LQ35vmaUTT4sl1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdt0BKfQ9C82KkVA3f5ee0AGM9fEsF/Dxd8d8TxrAGhIwFYxF9Zfy7rJ/amcpwx3MdL8iA/N+dhkmmbdTSu72DvwE8Ef1bdBIGEs0/R4zvI0eQ7se4Qy1xflhr7KhX2eqlS65G2P9Wvqq/CEl3hL78wb8EpR8Ticu461jnTeYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K+BiXooO; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=4r
	rb74iAfdmka58R5C+cn4MZVGRAiWBiJRY75p/xBeA=; b=K+BiXooO1hq+hl1XlT
	rAdRNKAtb6XOHn6unPJVI5Nqy2jFv8Qy2nhcqvL7/IlRCLOcuK9QeZei+e+mS+M/
	b1o7BEzncHL7K29hT7ImD8WO0DcaDu3KB6iy6HWKocm+GmLNkDkGHxTHK8E/hlTO
	rNXL8tnNRMhPmIPUkxVMQZkg4=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBH_+VZ2qJoyxi9Cg--.52195S5;
	Mon, 18 Aug 2025 15:46:37 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v11 3/3] selftests/bpf: make usdt_o1 reliably generate SIB USDT arg spec
Date: Mon, 18 Aug 2025 07:46:32 +0000
Message-ID: <20250818074632.433008-4-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818074632.433008-1-phoenix500526@163.com>
References: <20250818074632.433008-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH_+VZ2qJoyxi9Cg--.52195S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF13Ww47CFWfur45Aw1rtFb_yoW5Xr4fpa
	4kGayYkF1vqFyfA34fXr47Z3WrKF1kZFW8AFWktr1j9F1UXry8Xr4xK3WYvr9Yk3yF934Y
	v3y8t3s8uF48Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-F4_UUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFB+tiGii08WexQABso

usdt_o1 is intended to exercise the SIB (Scale-Index-Base) argument
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
* only enable on x86 platform.

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
 .../testing/selftests/bpf/prog_tests/usdt_o1.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt_o1.c b/tools/testing/selftests/bpf/prog_tests/usdt_o1.c
index 706168e804cb..6c04519b3757 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt_o1.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt_o1.c
@@ -18,11 +18,19 @@
 int lets_test_this(int);
 static volatile __u64 array[1] = {test_value};
 
-static __always_inline void trigger_func(void)
+static noinline void trigger_func(void)
 {
+#if defined(__x86_64__) || defined(__i386__)
 	/* Base address + offset + (index * scale) */
-	for (volatile int i = 0; i <= 0; i++)
-		STAP_PROBE1(test, usdt1, array[i]);
+	/* Force SIB addressing with inline assembly */
+	const __u64 *base;
+	__u32 idx;
+	/* binding base to %rdx and idx to %rax */
+	asm volatile("" : "=d"(base), "=a"(idx) : "0"(array), "1"((__u32)0) : "memory");
+	STAP_PROBE1(test, usdt1, base[idx]);
+#else
+	STAP_PROBE1(test, usdt1, array[0]);
+#endif
 }
 
 static void basic_sib_usdt(void)
@@ -66,5 +74,9 @@ static void basic_sib_usdt(void)
 
 void test_usdt_o1(void)
 {
+#if !defined(__x86_64__) && !defined(__i386__)
+	test__skip();
+	return;
+#endif
 	basic_sib_usdt();
 }
-- 
2.43.0


