Return-Path: <linux-kselftest+bounces-38995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D62B26C21
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 18:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3063B188AD8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 16:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B29227FB27;
	Thu, 14 Aug 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bdj4u54A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9811ADFFB;
	Thu, 14 Aug 2025 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187697; cv=none; b=itE0smeG5nU7tvNF6uziTdSNh6uWseUHIeVB5lM+PC+ancIl1+jNXspkFBlwVABgiFb1MP8L1EQbFDzYmqIThlTjOsgIbUP9jyJLCx8ePJeEAgSDg+04p+ULnj1gEt9cgyk2C9Tt94fNRD0b/xu0yvsG8CNLwALgr+Zoo7iovFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187697; c=relaxed/simple;
	bh=svkp08rdGVyKgFVxwgXAWa3Xf1Z0GRrg8XDC2J4AQsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5JvPaRiWCYeMTfMnLMV78Tm+/E/xSkP082UbXROjyrMIoE9ezHv4Av7S7lUpnbIJ4AImRn9bjCGqZEv98UdrK97yyyFFcVg1svYArZAGLlv++FvSXkuIUQRcYEc3uIiT9aKQT5uKu8Sx7S11SiyaPApUmOTYQND7X+WfA65hB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bdj4u54A; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ns
	TqgMpwxxk6C6R6rkKnNo1S3EeyK8BjaeGgYw51cqk=; b=bdj4u54AAT1IoAtlrX
	/Og9Kd8Stgws8RGW2N9Km2zU+WOyRLsS9Je5gI9f5x8H0xdBdbfLPRPO/pnBLLBR
	CjWUJaTQNeRpMNi67XJswH0iu6FQOo6TYe8LEkgR839b7uD+xSuMKu+5Hk/aDiH4
	9XUIzs71pypKXkzQ8hfV6GVwc=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAnEgTMCZ5otf6bBw--.46198S5;
	Fri, 15 Aug 2025 00:07:44 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v10 3/3] selftests/bpf: make usdt_o2 reliably generate SIB USDT arg spec
Date: Thu, 14 Aug 2025 16:07:39 +0000
Message-ID: <20250814160740.96150-4-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814160740.96150-1-phoenix500526@163.com>
References: <20250814160740.96150-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnEgTMCZ5otf6bBw--.46198S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1xur1fJFW3Xr43CFW3Jrb_yoW5XFWrpa
	4kJayYkF1vqFyfA34fJr42v3WrK3Z5ZFW8ArWkKw1jvr1UX3y8Xr4xKa4jv3sYk3yF934Y
	v3y8t398uay8Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-F4_UUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFB6piGieCMAXxwABsE

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
 .../selftests/bpf/prog_tests/usdt_o2.c        | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt_o2.c b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
index f02dcf5188ab..e46d5743ad24 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
@@ -15,11 +15,19 @@ __attribute__((optimize("O2")))
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
@@ -61,9 +69,11 @@ static void basic_sib_usdt(void)
 	test_usdt_o2__destroy(skel);
 }
 
-
-
 void test_usdt_o2(void)
 {
+#if !defined(__x86_64__) && !defined(__i386__)
+	test__skip();
+	return;
+#endif
 	basic_sib_usdt();
 }
-- 
2.43.0


