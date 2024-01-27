Return-Path: <linux-kselftest+bounces-3669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 572C683EF46
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 18:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07471F238C3
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 17:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8CC2E40B;
	Sat, 27 Jan 2024 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2xWN2N/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4062D04C;
	Sat, 27 Jan 2024 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706378001; cv=none; b=AvlVNk0Fz7MoeWdP32QBrQJq/bgqQDVVAHsj77Ie9+jQ7Q7wo0/frwOw4wAkMROCBXlXU0VbWf3Ucn232hc+oOVRKCgbjolXRdhGtmukZOuF1Fo4Rm8cKbyXGeegn1mEmlhMPN+vNfLJVblf6RinD3h//OJOEmyZwZEUmXswS3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706378001; c=relaxed/simple;
	bh=FPhNJPCfmYlJH1B1BBcfKiI2kTB7BgMYUwbeyONYl9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0vv9m5a1/nWuu6rpF8oeqCE3uVcxb+b0VO3TxOK0jXPZGwlzA/5kDjbK9LNavshZ4NB52cpWFX2iwgB5j4UT7X7BO2BXAlqvf7WOhA58Rrvqjy1GzxMh1TzMpq/rv7wpCIn/605uUDiZlf1LO+mfbrqiMiXcxjtVwukL7prc+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2xWN2N/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ea5653f6bso23599085e9.3;
        Sat, 27 Jan 2024 09:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706377998; x=1706982798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozV2KGMrFgsHS1gPSO2eoaYS6GdUgNAcChmUCNMwCAk=;
        b=A2xWN2N/3TH5acS9vdnC2a6EbjT8DXrgKvBHzRvcNp/FlKc5rm59QHPq8D/n+grnOW
         74khNB/XL4bvRKHjFjSNcQaBBdFMEdWQxlLiBbH4EgcKLTJGzvf1Xqp44FZKEsTo7E/m
         EBp3vqpQuq3fFazEV8hfvG8LZCledtcvGZc0gVn/xnI4XtxHku1KM9eq9upaeEYjc7G9
         txmBRzdR5WtXXJWQL4MrAb8IByZfXws9DnnoO41mIWxU9q9Gyez0C+nPGja/qrnCauLv
         4bXpAGXbA9pJQ1XwpeG/L9qrNPHumdYGXgWplGwfZ38Hd4GIR8ai6OOPMElcZo3u7I04
         BSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706377998; x=1706982798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozV2KGMrFgsHS1gPSO2eoaYS6GdUgNAcChmUCNMwCAk=;
        b=pzqcL/ynOjTls6RNuZvHV2gVcPytnUAp48uKLKSxY/RktchXH+m4QJyGxF0Jj+UqRH
         QLj8dAsibT5soFc26H6aaIU2CuWIftBP+0j9Y8S3/xGncuMmOYSIB9BoWVZCK2pHJC8V
         OhpGSSYlqaGXqmCSOA5Id+KV494n1NKFDJryVa2riYqe3KrQTSJCro8lzur7HaZIq4CK
         4GIyEzUT8PRpCTIgK4wNJblf7roLecJDPNwJxL6qR5sm46wQ88JYDqt8xmon0Yb1FtCo
         Dca6bCJvPBsoM+o/DyrAByjYeSrDFlkmsrjeD/AHvKRRIjwwWWRre8JYN5NGJiTWaSd5
         a/cg==
X-Gm-Message-State: AOJu0YxU9kyzFEWeqj822maN8dqNv3MAL46FhOYM60I3fuN7JCZETSnJ
	cPiptemjNx0UrF3tOEO79GJBvplDRrTIwLIVnOb+ua8jcCHkRf3C
X-Google-Smtp-Source: AGHT+IGyZ4sp0ye/xpHnStxlAoFfsZB17xRWshIdpLqRd365oDnOYY4p7kscEoVnzsy9MR58aETrBQ==
X-Received: by 2002:adf:f351:0:b0:333:44e2:16b7 with SMTP id e17-20020adff351000000b0033344e216b7mr1414501wrp.49.1706377998257;
        Sat, 27 Jan 2024 09:53:18 -0800 (PST)
Received: from localhost ([185.100.87.41])
        by smtp.gmail.com with ESMTPSA id g4-20020aa7d1c4000000b0055d1a75bd0csm1803307edp.57.2024.01.27.09.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 09:53:17 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 6/6] selftests/bpf: states pruning checks for scalar vs STACK_MISC
Date: Sat, 27 Jan 2024 19:52:37 +0200
Message-ID: <20240127175237.526726-7-maxtram95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127175237.526726-1-maxtram95@gmail.com>
References: <20240127175237.526726-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

Check that stacksafe() compares spilled scalars with STACK_MISC.
The following combinations are explored:
- old spill of imprecise scalar is equivalent to cur STACK_{MISC,INVALID}
  (plus error in unpriv mode);
- old spill of precise scalar is not equivalent to cur STACK_MISC;
- old STACK_MISC is equivalent to cur scalar;
- old STACK_MISC is not equivalent to cur non-scalar.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 7f3b1319bd99..85e48069c9e6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1090,4 +1090,158 @@ l0_%=:	r1 >>= 32;					\
 	: __clobber_all);
 }
 
+/* stacksafe(): check if stack spill of an imprecise scalar in old state
+ * is considered equivalent to STACK_{MISC,INVALID} in cur state.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("8: (79) r1 = *(u64 *)(r10 -8)")
+__msg("8: safe")
+__msg("processed 11 insns")
+/* STACK_INVALID should prevent verifier in unpriv mode from
+ * considering states equivalent and force an error on second
+ * verification path (entry - label 1 - label 2).
+ */
+__failure_unpriv
+__msg_unpriv("8: (79) r1 = *(u64 *)(r10 -8)")
+__msg_unpriv("9: (95) exit")
+__msg_unpriv("8: (79) r1 = *(u64 *)(r10 -8)")
+__msg_unpriv("invalid read from stack off -8+2 size 8")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void old_imprecise_scalar_vs_cur_stack_misc(void)
+{
+	asm volatile(
+	/* get a random value for branching */
+	"call %[bpf_ktime_get_ns];"
+	"if r0 == 0 goto 1f;"
+	/* conjure scalar at fp-8 */
+	"r0 = 42;"
+	"*(u64*)(r10 - 8) = r0;"
+	"goto 2f;"
+"1:"
+	/* conjure STACK_{MISC,INVALID} at fp-8 */
+	"call %[bpf_ktime_get_ns];"
+	"*(u16*)(r10 - 8) = r0;"
+	"*(u16*)(r10 - 4) = r0;"
+"2:"
+	/* read fp-8, should be considered safe on second visit */
+	"r1 = *(u64*)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* stacksafe(): check that stack spill of a precise scalar in old state
+ * is not considered equivalent to STACK_MISC in cur state.
+ */
+SEC("socket")
+__success __log_level(2)
+/* verifier should visit 'if r1 == 0x2a ...' two times:
+ * - once for path entry - label 2;
+ * - once for path entry - label 1 - label 2.
+ */
+__msg("if r1 == 0x2a goto pc+0")
+__msg("if r1 == 0x2a goto pc+0")
+__msg("processed 15 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void old_precise_scalar_vs_cur_stack_misc(void)
+{
+	asm volatile(
+	/* get a random value for branching */
+	"call %[bpf_ktime_get_ns];"
+	"if r0 == 0 goto 1f;"
+	/* conjure scalar at fp-8 */
+	"r0 = 42;"
+	"*(u64*)(r10 - 8) = r0;"
+	"goto 2f;"
+"1:"
+	/* conjure STACK_MISC at fp-8 */
+	"call %[bpf_ktime_get_ns];"
+	"*(u64*)(r10 - 8) = r0;"
+	"*(u32*)(r10 - 4) = r0;"
+"2:"
+	/* read fp-8, should not be considered safe on second visit */
+	"r1 = *(u64*)(r10 - 8);"
+	/* use r1 in precise context */
+	"if r1 == 42 goto +0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* stacksafe(): check if STACK_MISC in old state is considered
+ * equivalent to stack spill of a scalar in cur state.
+ */
+SEC("socket")
+__success  __log_level(2)
+__msg("8: (79) r0 = *(u64 *)(r10 -8)")
+__msg("8: safe")
+__msg("processed 11 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void old_stack_misc_vs_cur_scalar(void)
+{
+	asm volatile(
+	/* get a random value for branching */
+	"call %[bpf_ktime_get_ns];"
+	"if r0 == 0 goto 1f;"
+	/* conjure STACK_{MISC,INVALID} at fp-8 */
+	"call %[bpf_ktime_get_ns];"
+	"*(u16*)(r10 - 8) = r0;"
+	"*(u16*)(r10 - 4) = r0;"
+	"goto 2f;"
+"1:"
+	/* conjure scalar at fp-8 */
+	"r0 = 42;"
+	"*(u64*)(r10 - 8) = r0;"
+"2:"
+	/* read fp-8, should be considered safe on second visit */
+	"r0 = *(u64*)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* stacksafe(): check that STACK_MISC in old state is not considered
+ * equivalent to stack spill of a non-scalar in cur state.
+ */
+SEC("socket")
+__success  __log_level(2)
+/* verifier should process exit instructions twice:
+ * - once for path entry - label 2;
+ * - once for path entry - label 1 - label 2.
+ */
+__msg("r1 = *(u64 *)(r10 -8)")
+__msg("exit")
+__msg("r1 = *(u64 *)(r10 -8)")
+__msg("exit")
+__msg("processed 11 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void old_stack_misc_vs_cur_ctx_ptr(void)
+{
+	asm volatile(
+	/* remember context pointer in r9 */
+	"r9 = r1;"
+	/* get a random value for branching */
+	"call %[bpf_ktime_get_ns];"
+	"if r0 == 0 goto 1f;"
+	/* conjure STACK_MISC at fp-8 */
+	"call %[bpf_ktime_get_ns];"
+	"*(u64*)(r10 - 8) = r0;"
+	"*(u32*)(r10 - 4) = r0;"
+	"goto 2f;"
+"1:"
+	/* conjure context pointer in fp-8 */
+	"*(u64*)(r10 - 8) = r9;"
+"2:"
+	/* read fp-8, should not be considered safe on second visit */
+	"r1 = *(u64*)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


