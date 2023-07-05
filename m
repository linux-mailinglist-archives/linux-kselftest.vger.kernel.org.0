Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E1C748304
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 13:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjGELjm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 07:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGELjk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 07:39:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62718172D;
        Wed,  5 Jul 2023 04:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE4CF61502;
        Wed,  5 Jul 2023 11:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51ADC433CB;
        Wed,  5 Jul 2023 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688557176;
        bh=D9GSPkQfc94GriKvN2wgHJNIn0GmarOpfbjlVuo819E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWeLHX7vKcTK8N/9e06kxAsab5MXoraEbcbl0s3fZDnuBtZvseV7oVFGFgNokb+IX
         W6me0ElJ8VTA+sISXMjGJdL2P1XES2lNIMSCgBKFf/FaMYI9+1gxbCNm3F/qb/4yT4
         h/KnNT2meDWnCn5LTRykO894s/hJGeSm0O/gAiBEu9CvnvaBC6az1Pv+wVWN2zJH6a
         wficjpMq8Fr+vdOi6CL1Xu5KpoYfcadmabSQah05ZwQlj2eqcHLneZDvYrftW5Rmqn
         FBIWh0c5Te4bOed4KmnlwC0qB20X9D52cMWPsEId/O2fDGAKAK6mXCpF7xNKqBrvvR
         tSgdL5f73aTfw==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH bpf-next 1/2] selftests/bpf: Add F_NEEDS_EFFICIENT_UNALIGNED_ACCESS to some tests
Date:   Wed,  5 Jul 2023 13:39:25 +0200
Message-Id: <20230705113926.751791-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230705113926.751791-1-bjorn@kernel.org>
References: <20230705113926.751791-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Some verifier tests were missing F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
which made the test fail. Add the flag where needed.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c | 1 +
 tools/testing/selftests/bpf/verifier/ctx_skb.c        | 2 ++
 tools/testing/selftests/bpf/verifier/jmp32.c          | 8 ++++++++
 tools/testing/selftests/bpf/verifier/map_kptr.c       | 2 ++
 tools/testing/selftests/bpf/verifier/precise.c        | 2 +-
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
index b39665f33524..319337bdcfc8 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
@@ -242,4 +242,5 @@
 	.result = REJECT,
 	.errstr = "R0 invalid mem access",
 	.errstr_unpriv = "R10 partial copy of pointer",
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
diff --git a/tools/testing/selftests/bpf/verifier/ctx_skb.c b/tools/testing/selftests/bpf/verifier/ctx_skb.c
index 83cecfbd6739..0b394a7f7a2d 100644
--- a/tools/testing/selftests/bpf/verifier/ctx_skb.c
+++ b/tools/testing/selftests/bpf/verifier/ctx_skb.c
@@ -1169,6 +1169,7 @@
        },
        .result = ACCEPT,
        .prog_type = BPF_PROG_TYPE_SK_SKB,
+       .flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
 {
        "pkt_end < pkt taken check",
@@ -1190,4 +1191,5 @@
        },
        .result = ACCEPT,
        .prog_type = BPF_PROG_TYPE_SK_SKB,
+       .flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
diff --git a/tools/testing/selftests/bpf/verifier/jmp32.c b/tools/testing/selftests/bpf/verifier/jmp32.c
index 1a27a6210554..43776f6f92f4 100644
--- a/tools/testing/selftests/bpf/verifier/jmp32.c
+++ b/tools/testing/selftests/bpf/verifier/jmp32.c
@@ -290,6 +290,7 @@
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
 {
 	"jgt32: BPF_K",
@@ -360,6 +361,7 @@
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
 {
 	"jle32: BPF_K",
@@ -430,6 +432,7 @@
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
 {
 	"jlt32: BPF_K",
@@ -500,6 +503,7 @@
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
 {
 	"jsge32: BPF_K",
@@ -570,6 +574,7 @@
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
 {
 	"jsgt32: BPF_K",
@@ -640,6 +645,7 @@
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
 {
 	"jsle32: BPF_K",
@@ -710,6 +716,7 @@
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
 {
 	"jslt32: BPF_K",
@@ -780,6 +787,7 @@
 	.result_unpriv = REJECT,
 	.result = ACCEPT,
 	.retval = 2,
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
 {
 	"jgt32: range bound deduction, reg op imm",
diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/testing/selftests/bpf/verifier/map_kptr.c
index a0cfc06d75bc..d25c3e9605f1 100644
--- a/tools/testing/selftests/bpf/verifier/map_kptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
@@ -68,6 +68,7 @@
 	.fixup_map_kptr = { 1 },
 	.result = REJECT,
 	.errstr = "kptr access cannot have variable offset",
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
 {
 	"map_kptr: bpf_kptr_xchg non-const var_off",
@@ -121,6 +122,7 @@
 	.fixup_map_kptr = { 1 },
 	.result = REJECT,
 	.errstr = "kptr access misaligned expected=0 off=7",
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
 {
 	"map_kptr: reject var_off != 0",
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 99272bb890da..0d84dd1f38b6 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -216,7 +216,7 @@
 	},
 	.fixup_map_ringbuf = { 1 },
 	.prog_type = BPF_PROG_TYPE_XDP,
-	.flags = BPF_F_TEST_STATE_FREQ,
+	.flags = BPF_F_TEST_STATE_FREQ | F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 	.errstr = "invalid access to memory, mem_size=1 off=42 size=8",
 	.result = REJECT,
 },
-- 
2.39.2

