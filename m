Return-Path: <linux-kselftest+bounces-26548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE8A34000
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 14:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FE21885E00
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 13:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B59E23F42C;
	Thu, 13 Feb 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Vd+Zz+IZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044B523F423;
	Thu, 13 Feb 2025 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452401; cv=none; b=W4T4cK4sxWr5k6JKWwTD7ag6m2u0RIkXm9lRSvTLkyUkWy05QjC+pWcx9oq4LIuen5TF3Cr+VE1svKYmBYsvxQeSU3LhpRQ1ALqd+fDknFdST9S8Ry9tBP9fQQvUKTiepgckr1ME7XkZ43cMtL9RzY+NYzFjAknuykLC6SLypfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452401; c=relaxed/simple;
	bh=Na0JBBZJQCXe1Ihbx758KpxXCP4Rf018YnQvHAJqe9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7KW8PbZGIFm3KSrmP3xT1jIxHQdjxrZ5WyayNCrKAHQdIM5JE9z1ARYlWpoprtw3bOtQrO8FIcKfk4WTT1aVfBniRkvGdhrP6lLj204G6j9fr/eYsUxGRyCmEbRb15Q1ZJPxwFCaFBTpGCezaNzN64jRTweLnnPH5gK7HSKYQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Vd+Zz+IZ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Z7Ach
	ZSHkCvv6oBVXtD9AdEa2U4JNLLQOD/vEcsngtE=; b=Vd+Zz+IZCoGNdNc+FPtkx
	jnJTSLXhmnmzYuQUIeyhZ5rJrFQXzZjfMFPiyDRLCZfnx41IA4+gkMTuaI0tm1in
	miSql6iIT3vJlPYD/wRzwpzqaAgwbdi7TRzFGByH7HEQRi3rfGKQlcuy1WJ6J+T3
	cdMgNXky1Sj3VW1Y41VJFk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3N8qv761nJPMJMA--.27324S5;
	Thu, 13 Feb 2025 21:12:23 +0800 (CST)
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Add selftest for may_goto
Date: Thu, 13 Feb 2025 21:12:14 +0800
Message-ID: <20250213131214.164982-4-mrpre@163.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250213131214.164982-1-mrpre@163.com>
References: <20250213131214.164982-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3N8qv761nJPMJMA--.27324S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kry8Jw1xJry5JrykZr48Crg_yoW8tFy7p3
	4kWasI9F1kJw1xK3WxWFyDWFyrJa1kWr15Cr4ftr1rtF1DKrn7Gr1IkF9rXr4aya1fZw45
	AFZFka9xGw4UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRMrWrUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwHyp2et7vcZ2AAAsJ

Add test cases to ensure the maximum stack size can be properly limited to
512.

Test result:
echo "0" > /proc/sys/net/core/bpf_jit_enable
./test_progs -t verifier_stack_ptr
verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto with jit:SKIP
verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto without jit:OK

echo "1" > /proc/sys/net/core/bpf_jit_enable
verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto with jit:OK
verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto without jit:SKIP

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 .../selftests/bpf/progs/verifier_stack_ptr.c  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
index 417c61cd4b19..8ffe5a01d140 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -481,4 +481,54 @@ l1_%=:	r0 = 42;					\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("PTR_TO_STACK stack size > 512")
+__failure __msg("invalid write to stack R1 off=-520 size=8")
+__naked void stack_check_size_gt_512(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -520;"
+	"r0 = 42;"
+	"*(u64*)(r1 + 0) = r0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+#ifdef __BPF_FEATURE_MAY_GOTO
+SEC("socket")
+__description("PTR_TO_STACK stack size 512 with may_goto with jit")
+__use_jit()
+__success __retval(42)
+__naked void stack_check_size_512_with_may_goto_jit(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -512;"
+	"r0 = 42;"
+	"*(u32*)(r1 + 0) = r0;"
+	"may_goto l0_%=;"
+	"r2 = 100;"
+"l0_%=:	exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("PTR_TO_STACK stack size 512 with may_goto without jit")
+__use_interp()
+__failure __msg("stack size 520(extra 8) is too large")
+__naked void stack_check_size_512_with_may_goto(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -512;"
+	"r0 = 42;"
+	"*(u32*)(r1 + 0) = r0;"
+	"may_goto l0_%=;"
+	"r2 = 100;"
+"l0_%=:	exit;"
+	::: __clobber_all);
+}
+#endif
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


