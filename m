Return-Path: <linux-kselftest+bounces-3137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B72383013A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 09:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A732886AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 08:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336331118C;
	Wed, 17 Jan 2024 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cbUlO8+f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374BD30B
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705479925; cv=none; b=M2/144WbgNbyey2yx9lDO1T7ndI4U9brePdEsAoUtQdJONwNuowMyiU2oVarRMTbEWU5mz/6LSTvqzKvQ36e9EFtovsLFL8G1oQ5a+elAk/0EusUb1ISidMad3KjIn5VO/udavFoLdb7um0jrwgn0ZY+02rwP/qsa51ny5fxxZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705479925; c=relaxed/simple;
	bh=KYU+/R9/w0I7hKX9NysG82L25bCespxuVs1S32IvAgI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=HZCP5f9sineKi/ui1k0BcbVyyiurwmyX4ZeIOJpH8SNjCF3JHNSonBkEKP799XuQbWFzuuPZ/taGwlgAej49jf2plCeyhFnCBnoa9iONUM3PUP5RXyTzvHdxnPPgdCyl6dDHG9CDinkDD+QxmKqwVi34z3T6ovNCaAMZ5wLmgUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cbUlO8+f; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cf6d5117f9so1902102a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 00:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705479922; x=1706084722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BLAj/2p6EWO6CuOFTo5201/UFs9ytEaathr/jXBe1ac=;
        b=cbUlO8+fCuXiGCm0xFTJFFlQZBTWlVQdnWNbTDZdJK3CBVZuL44atd8Gl2BlPkfrLw
         8zuZJ0kqPBg3LOnYmlPgBhXhGWuSTqQ6m2LltBM4DRhe9+h+IvstT+bScqCp5Ekq25ka
         Fzp1wmFLzGj2OF2P0v844Ue0O/ptWKarOp0ifpeGqlRk76K3wL9M9cTML0l3eARurp0w
         m4qw3NiF2tpNze/myXj65gL2hm5sNanvmbnYitLn/bsocxOMJECrin6hdLjc8P3jPO1k
         0eJMdbN+d+M/LEoiJAVpxlK8z31JMpNzTy4gvE2yDGvcBOPMkfmqDYJ8lZ11vJcpN++X
         6Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705479922; x=1706084722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLAj/2p6EWO6CuOFTo5201/UFs9ytEaathr/jXBe1ac=;
        b=hbLrd79wRnYXzIsfB5xr5t0NJdyellOcQdqstwO+EPNaml5DWvp3bJ7VHO2ivjxxYy
         7ILTEh/Ck2UYv/2a+stid9PLbBFrWZSRfRI6r0SLnIBj/BmIP40Sj9bIBWWmOA5Pa8KB
         xZKcRDCC/yYau6ZZQQ6kRHLlicZBIpjfGkzYkDWTA3DbNhSXZPj+ZsmmRG62Q/DJVSJ5
         aPQBcxT/r3TQghuZTq7OskUXZzrzsOIyEQqWV0qXjAcuTnzGqciibKj7pOn7HkG484Br
         v/GL3A3LrKO5k6liLlSmkDeEIl0zxFyGIJYz/Dpj9Y95enMijIysc1obABCXzUK7pqYW
         sUug==
X-Gm-Message-State: AOJu0YzSaU3Cgno43/GohN8XxIm2LTw3YTiQ3XgvB0TklpGni1d4JtMn
	dDFenb9X9CTit2NLJ0C7gKNo7pmuSpnftw==
X-Google-Smtp-Source: AGHT+IHya5IfDhQf7BZmho8amnGY7/fz5x+QBoLxcJNy/Z6r0mJJOQs3go7xdMoyB52Opolqof04XA==
X-Received: by 2002:a05:6a21:338f:b0:19b:7e2c:d5db with SMTP id yy15-20020a056a21338f00b0019b7e2cd5dbmr42515pzb.38.1705479921914;
        Wed, 17 Jan 2024 00:25:21 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id jg20-20020a17090326d400b001d060c61da5sm10426802plb.134.2024.01.17.00.25.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Jan 2024 00:25:21 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: shuah@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	cuiyunhui@bytedance.com,
	ajones@ventanamicro.com,
	xiao.w.wang@intel.com,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xuzhipeng.1973@bytedance.com
Subject: [PATCH] RISC-V: selftests: fix cbo.c compilation error
Date: Wed, 17 Jan 2024 16:25:14 +0800
Message-Id: <20240117082514.42967-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with -O0, the following error will occur:
cbo.c: In function 'cbo_insn':
cbo.c:43:9: warning: 'asm' operand 1 probably does not match constraints
   43 |         asm volatile(
      |         ^~~
cbo.c:43:9: warning: 'asm' operand 2 probably does not match constraints
cbo.c:43:9: error: impossible constraint in 'asm'

Add __attribute__((optimize("O"))) to fix.

Fixes: a29e2a48afe3 ("RISC-V: selftests: Add CBO tests")
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Suggested-by: Zhipeng Xu <xuzhipeng.1973@bytedance.com>
---
 tools/testing/selftests/riscv/hwprobe/cbo.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
index 50a2cc8aef38..ff1d8e843d70 100644
--- a/tools/testing/selftests/riscv/hwprobe/cbo.c
+++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
@@ -36,7 +36,7 @@ static void sigill_handler(int sig, siginfo_t *info, void *context)
 	regs[0] += 4;
 }
 
-static void cbo_insn(char *base, int fn)
+static __always_inline void cbo_insn(char *base, int fn)
 {
 	uint32_t insn = MK_CBO(fn);
 
@@ -47,10 +47,11 @@ static void cbo_insn(char *base, int fn)
 	: : "r" (base), "i" (fn), "i" (insn) : "a0", "a1", "memory");
 }
 
-static void cbo_inval(char *base) { cbo_insn(base, 0); }
-static void cbo_clean(char *base) { cbo_insn(base, 1); }
-static void cbo_flush(char *base) { cbo_insn(base, 2); }
-static void cbo_zero(char *base)  { cbo_insn(base, 4); }
+#define OPTIMIZE __attribute__((optimize("O")))
+OPTIMIZE static void cbo_inval(char *base) { cbo_insn(base, 0); }
+OPTIMIZE static void cbo_clean(char *base) { cbo_insn(base, 1); }
+OPTIMIZE static void cbo_flush(char *base) { cbo_insn(base, 2); }
+OPTIMIZE static void cbo_zero(char *base)  { cbo_insn(base, 4); }
 
 static void test_no_zicbom(void *arg)
 {
-- 
2.20.1


