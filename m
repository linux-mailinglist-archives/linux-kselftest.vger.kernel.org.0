Return-Path: <linux-kselftest+bounces-26641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C04A35A0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 10:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B831883468
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 09:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49B222F165;
	Fri, 14 Feb 2025 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PPEEy3b8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC9222E405;
	Fri, 14 Feb 2025 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524759; cv=none; b=RqHnQvKLhHefVjiwL5XBhkWbE1poNbZR2bM4g34aAu8e4XadhHC4XTIJ1fwAy3b4Ry/l5HZm5KrdQEw5gkWIfD+sY80AEqQLP5+M9gsOYNpSycfEtjzwqA5hPyREsNnSlUA3CLYYLKECkU9qfE81kw4pye4YsNRt7+AyCO7WWII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524759; c=relaxed/simple;
	bh=R4TKYRupVCB93Gl+1MTFKEaO6m65aWCRnFvBqyADbJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUCL0kkER63MvDmpmZQuyZy/NYV1cpt9wrUQg/buNtQYwQXpf8xrSvk60/OrC3IdaGRxcMsC7htsfR0T6b/Mua4GEyGtgXqdaEk1SY78fwKJdbVriIlNTCqUKbBJOcTiRhzTfWWGj3IXr/cS7Npqb3PqdrjSydnpJQdzYBIixSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PPEEy3b8; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=tPPMm
	Jd3CtmVukZjPNPlyzL9MmDEtdrVNqX16QbV6Rg=; b=PPEEy3b8m9J3ZMnqXBX5O
	E2BE7OvPZHSflGzWfGdubpinBEH59yILnHpsiIBR0R6sX+y2kAx9mwpYn4nOtwm0
	duhkR9h9OhaqfRbGu2XatEWL7zDIGglpblFm3TuCfIK6bGEyHHeyCtvqyvLyNQdG
	Fc3Nhd50eYY+Iu6JWEd6mU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3N0RjCq9nqR1PMA--.3071S5;
	Fri, 14 Feb 2025 17:18:34 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: linux-kselftest@vger.kernel.org,
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
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add selftest for may_goto
Date: Fri, 14 Feb 2025 17:18:23 +0800
Message-ID: <20250214091823.46042-4-mrpre@163.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250214091823.46042-1-mrpre@163.com>
References: <20250214091823.46042-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3N0RjCq9nqR1PMA--.3071S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryUtFyDCF18Cw4fGr4fAFb_yoW5Jr18p3
	s7Xasakr18Xw1xKw1xGFWkGFyrZF4kZr1YkFyfXr15JFnrJFn7WFn2kF9rXrsIyFs3Zw4Y
	vFWqyFZxGw4UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRMrWrUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWxTzp2evAb7U8AAAsI

Added test cases to ensure that programs with stack sizes exceeding 512
bytes are restricted in non-JITed mode, and can be executed normally in
JITed mode, even with stack sizes exceeding 512 bytes due to the presence
of may_goto instructions.

Test result:
echo "0" > /proc/sys/net/core/bpf_jit_enable
./test_progs -t verifier_stack_ptr
...
stack size 512 with may_goto with jit:SKIP
stack size 512 with may_goto without jit:OK
...
Summary: 1/27 PASSED, 25 SKIPPED, 0 FAILED

echo "1" > /proc/sys/net/core/bpf_jit_enable
./test_progs -t verifier_stack_ptr
...
stack size 512 with may_goto with jit:OK
stack size 512 with may_goto without jit:SKIP
...
Summary: 1/27 PASSED, 25 SKIPPED, 0 FAILED

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 .../selftests/bpf/progs/verifier_stack_ptr.c  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
index 417c61cd4b19..24aabc6083fd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -481,4 +481,56 @@ l1_%=:	r0 = 42;					\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("PTR_TO_STACK stack size > 512")
+__failure __msg("invalid write to stack R1 off=-520 size=8")
+__naked void stack_check_size_gt_512(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -520;					\
+	r0 = 42;					\
+	*(u64*)(r1 + 0) = r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+#ifdef __BPF_FEATURE_MAY_GOTO
+SEC("socket")
+__description("PTR_TO_STACK stack size 512 with may_goto with jit")
+__load_if_JITed()
+__success __retval(42)
+__naked void stack_check_size_512_with_may_goto_jit(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -512;					\
+	r0 = 42;					\
+	*(u32*)(r1 + 0) = r0;				\
+	may_goto l0_%=;					\
+	r2 = 100;					\
+	l0_%=:						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK stack size 512 with may_goto without jit")
+__load_if_no_JITed()
+__failure __msg("stack size 520(extra 8) is too large")
+__naked void stack_check_size_512_with_may_goto(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -512;					\
+	r0 = 42;					\
+	*(u32*)(r1 + 0) = r0;				\
+	may_goto l0_%=;					\
+	r2 = 100;					\
+	l0_%=:						\
+	exit;						\
+"	::: __clobber_all);
+}
+#endif
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


