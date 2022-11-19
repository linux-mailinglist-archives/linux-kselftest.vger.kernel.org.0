Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08D6630A39
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Nov 2022 03:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiKSCYV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Nov 2022 21:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbiKSCWu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Nov 2022 21:22:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD421C72C0;
        Fri, 18 Nov 2022 18:15:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4EEA6280C;
        Sat, 19 Nov 2022 02:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2EFC433C1;
        Sat, 19 Nov 2022 02:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668824119;
        bh=0Vv/bjt0ASgKc1aA94qBlEONoRr983LHAYKbEloUFU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JWHTyN1M4qxt4nqraA1KUNAfPU6XIuzrkuTRyzg//Fk3mwSWBHliLnwXOvuU/XTI0
         vsg1w44aFCZRfHnFDufUUbntkSAC5rhZmnY+arIsfeO5OUoRvreHoRMHS8/G+c4b5W
         brPQgE3OBJAjRIUwDZrKuqe1zI6XEWBiVeRRRNCfHFlfycVuq4ZeyZZwIru8xrvpSX
         LPDL/IARVDL+NYpU7cYBq8CqPrT9r2Uvtf8TXYRMwEazho58DfghYNJAoBSNBo2r7y
         byF7ZuBTLKw2siEAplDXlnKjp1SYi/4Le41q6c0S2+q7GNagsHb7a67cVuaDuaDEgp
         f5T65bidm4ZAA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Youlin Li <liulin063@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, andrii@kernel.org,
        ast@kernel.org, shuah@kernel.org, memxor@gmail.com,
        roberto.sassu@huawei.com, mykolal@fb.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 08/18] selftests/bpf: Add verifier test for release_reference()
Date:   Fri, 18 Nov 2022 21:14:49 -0500
Message-Id: <20221119021459.1775052-8-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221119021459.1775052-1-sashal@kernel.org>
References: <20221119021459.1775052-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Youlin Li <liulin063@gmail.com>

[ Upstream commit 475244f5e06beeda7b557d9dde46a5f439bf3379 ]

Add a test case to ensure that released pointer registers will not be
leaked into the map.

Before fix:

  ./test_verifier 984
    984/u reference tracking: try to leak released ptr reg FAIL
    Unexpected success to load!
    verification time 67 usec
    stack depth 4
    processed 23 insns (limit 1000000) max_states_per_insn 0 total_states 2
    peak_states 2 mark_read 1
    984/p reference tracking: try to leak released ptr reg OK
    Summary: 1 PASSED, 0 SKIPPED, 1 FAILED

After fix:

  ./test_verifier 984
    984/u reference tracking: try to leak released ptr reg OK
    984/p reference tracking: try to leak released ptr reg OK
    Summary: 2 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Youlin Li <liulin063@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20221103093440.3161-2-liulin063@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/verifier/ref_tracking.c     | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
index 006b5bd99c08..525d810b10b8 100644
--- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
+++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
@@ -901,3 +901,39 @@
 	.result_unpriv = REJECT,
 	.errstr_unpriv = "unknown func",
 },
+{
+	"reference tracking: try to leak released ptr reg",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4),
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+		BPF_LD_MAP_FD(BPF_REG_1, 0),
+		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+		BPF_EXIT_INSN(),
+		BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
+
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_LD_MAP_FD(BPF_REG_1, 0),
+		BPF_MOV64_IMM(BPF_REG_2, 8),
+		BPF_MOV64_IMM(BPF_REG_3, 0),
+		BPF_EMIT_CALL(BPF_FUNC_ringbuf_reserve),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+		BPF_EXIT_INSN(),
+		BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
+
+		BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
+		BPF_MOV64_IMM(BPF_REG_2, 0),
+		BPF_EMIT_CALL(BPF_FUNC_ringbuf_discard),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+
+		BPF_STX_MEM(BPF_DW, BPF_REG_9, BPF_REG_8, 0),
+		BPF_EXIT_INSN()
+	},
+	.fixup_map_array_48b = { 4 },
+	.fixup_map_ringbuf = { 11 },
+	.result = ACCEPT,
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "R8 !read_ok"
+},
-- 
2.35.1

