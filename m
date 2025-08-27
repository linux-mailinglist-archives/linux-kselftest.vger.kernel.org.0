Return-Path: <linux-kselftest+bounces-40026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2A1B37880
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 05:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6858C5E13EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 03:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5108274B2B;
	Wed, 27 Aug 2025 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NFc7s06I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B11A3166;
	Wed, 27 Aug 2025 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756264593; cv=none; b=H/5Y8ncXOxyh1X2EYbGcT8+ks7jzN1vMT9cBfZ1oxc5Vh0DEBWp+TJfmceM8u0WEDMQUwTGkmoZbcjcsXxtBW60xcQlPZrwD8GyhXsZBmHPmSuMZHleoDmrdJ8G5MFOPUR/AlRO72gWqM5Y36MNjwKuhEoiYnoVme3hXL2qIfbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756264593; c=relaxed/simple;
	bh=Qs2OM8u+Lsz6MOPYflBgcuyoauChwiyNm0Qg9Fp8l+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jIIkQgwwIw9UikIa7Q1fSZx8yZaleYC4oNQp8NDO4m3kCxgS0Srq5H7ygjZGKtQqTuvg6gBb8n1sGaRueVdQnYTtlGSfVFdI8mwImcMe3VOW8VpWlbas1cg4FXSnQT8jZ078Td9Ikm5PdYS9IltivJYsf/9CWfJ0OEf7LSkBmWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NFc7s06I; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=J0
	iCFAWZwK2LvypLJsD3Kz9xYwE43hjGdHVixQJu+A4=; b=NFc7s06IbOvdJXwOCv
	qcfR255RbqM4W4cadxZZwdHdZ1419RFAnD74XK1SUCCP8tlG+HwmpDd/LDy4MG7L
	U6qlphAcKfBFMvoIOpD2usNjFGhMRJt4RDO1SGmjINMC0MvXmZIEXBisTdfSjZRt
	1zQEyW/jDcwgtB6y/P5ZKGLfw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3F+RdeK5ocMYdEw--.56776S2;
	Wed, 27 Aug 2025 11:15:42 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next] selftests/bpf: Fix the invalid operand for instruction issue
Date: Wed, 27 Aug 2025 11:15:40 +0800
Message-Id: <20250827031540.461017-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3F+RdeK5ocMYdEw--.56776S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw18tr4UZFW5tF4kuFyUZFb_yoW8Gry7pw
	18X3s8tFyS9r1UX3W7Jr4UWF1rWFsaqr48Ar40yr9rAF98GF97Jr1xKFyYgr93Xr4furW3
	Zrsrtw43CF4kAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKzuZUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiYwO2eGiudCWPIwAAsV

From: Feng Yang <yangfeng@kylinos.cn>

The following issue occurs when compiling with clang version 17.0.6,
but not with version 18.1.8. Add a version restriction to fix this problem.

progs/compute_live_registers.c:251:3: error: invalid operand for instruction
  251 |                 "r0 = 1;"
      |                 ^
<inline asm>:1:22: note: instantiated into assembly here
    1 |         r0 = 1;r2 = 2;if r1 & 0x7 goto +1;exit;r0 = r2;exit;
      |                             ^
1 error generated.

Fixes: 4a4b84ba9e453 ("selftests/bpf: verify jset handling in CFG computation")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/compute_live_registers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index 6884ab99a421..56aec43f206f 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -240,6 +240,7 @@ __naked void if2(void)
 		::: __clobber_all);
 }
 
+#if __clang_major__ >= 18
 /* Verifier misses that r2 is alive if jset is not handled properly */
 SEC("socket")
 __log_level(2)
@@ -255,6 +256,7 @@ __naked void if3_jset_bug(void)
 		"exit;"
 		::: __clobber_all);
 }
+#endif
 
 SEC("socket")
 __log_level(2)
-- 
2.43.0


