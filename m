Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E1A2764A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Sep 2020 01:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIWXgg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Sep 2020 19:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgIWXgY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Sep 2020 19:36:24 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B507FC0613CE
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Sep 2020 16:36:24 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 135so628905pfu.9
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Sep 2020 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ns9cS9dj1D0b/ezL20f6+qIcG/yawwfocQGXxEThZH4=;
        b=BdlUgsI/j2FnN5fHx8px2qiiZLqn4x3SgI2QlJiJgfEXSusZyV29B/a4Z38pe5q+nF
         LfaEiIV6DBnrFpc/v3o0y7QUiHJ2t0a0m0EBHnat9mBDeSfnaRhv8MVPiSaU1bwgSPbs
         q6tLOcX2cn0Lu3XHgNQ+aIdwj38GsGZ9DudZxIQAnNvJmULQTiJDvGrPpUZlJh5ORCPZ
         RIj+YXoNQ5hEhKSWFRccAJube1BKDCV4VRXTfVHY3PwDUlz+vehHKUYkFQcNUa5HcJzX
         zwGlywo8MuROR99a+BTT/TkgYy/K2QIHMYFeD5gcvTEqHtRugqptGw1jdAfZY5ZEQrG1
         npaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ns9cS9dj1D0b/ezL20f6+qIcG/yawwfocQGXxEThZH4=;
        b=kFeTercJxbPy/w7VMi93zehEUnKZm0Nf6mTi6/TvZE9zq4/lQvirdPwGvwa0mzQ9Tn
         F0haF8BNDEqRdNr5EmDl9DM56PvhgigO18JFhA5RQaG2Yo5T4GowiFapYh4927Y0cJpJ
         8VomMBEOhrApdPnzxNKETCA3XHFwp17gBKNProb402dZZP6K6+/AMCXl+fyX2fL651bW
         HPv7nRv7VIIR6y10Sg7VMr0LDrQB9cFMBlaXAKNHH7pXCpu2hwwhg65NzgDwTFZxrIKP
         BExxidanVG8k/fGFyi1t+MbtZSqxmbEPqDXXeP4Fe2QnQ/hbUjh1Tz/bT83ctSFl89KC
         HMPQ==
X-Gm-Message-State: AOAM531aFdpHuxWSRcmXGRsB7zE22TGbsPXD/CZEnLlpNeWx7rSzwslU
        GFFk1BBMW3cLDvtgABwFt25Bh5IX
X-Google-Smtp-Source: ABdhPJzSsKZViFdwP9hrb19U9urvXlXJ1wO/ZQRxPhGzH7KUrhUGGDjQS7hrVTTS7aU/nWE77axw+6b/
Sender: "posk via sendgmr" <posk@posk.svl.corp.google.com>
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:7220:84ff:fe09:7598])
 (user=posk job=sendgmr) by 2002:a17:90a:ee4f:: with SMTP id
 bu15mr1431280pjb.16.1600904184153; Wed, 23 Sep 2020 16:36:24 -0700 (PDT)
Date:   Wed, 23 Sep 2020 16:36:17 -0700
In-Reply-To: <20200923233618.2572849-1-posk@google.com>
Message-Id: <20200923233618.2572849-2-posk@google.com>
Mime-Version: 1.0
References: <20200923233618.2572849-1-posk@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v8 2/3] rseq/selftests: add rseq_offset_deref_addv
From:   Peter Oskolkov <posk@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch adds rseq_offset_deref_addv function to
tools/testing/selftests/rseq/rseq-x86.h, to be used
in a selftest in the next patch in the patchset.

v7->v8: this patch split out of the v7 selftest patch.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 tools/testing/selftests/rseq/rseq-x86.h | 57 +++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index b2da6004fe30..640411518e46 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -279,6 +279,63 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 #endif
 }
 
+#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+
+/*
+ *   pval = *(ptr+off)
+ *  *pval += inc;
+ */
+static inline __attribute__((always_inline))
+int rseq_offset_deref_addv(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
+#endif
+		/* get p+v */
+		"movq %[ptr], %%rbx\n\t"
+		"addq %[off], %%rbx\n\t"
+		/* get pv */
+		"movq (%%rbx), %%rcx\n\t"
+		/* *pv += inc */
+		"addq %[inc], (%%rcx)\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [rseq_abi]		"r" (&__rseq_abi),
+		  /* final store input */
+		  [ptr]			"m" (*ptr),
+		  [off]			"er" (off),
+		  [inc]			"er" (inc)
+		: "memory", "cc", "rax", "rbx", "rcx"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
 static inline __attribute__((always_inline))
 int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 				 intptr_t *v2, intptr_t newv2,
-- 
2.28.0.709.gb0816b6eb0-goog

