Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8056A5A683E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 18:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiH3QV0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 12:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiH3QU6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 12:20:58 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64362AF0C7;
        Tue, 30 Aug 2022 09:20:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MHC802tPSz9xFg3;
        Wed, 31 Aug 2022 00:15:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDHQl0ZOA5jLmYNAA--.2866S14;
        Tue, 30 Aug 2022 17:20:09 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v14 12/12] selftests/bpf: Add verifier tests for dynamic pointers parameters in kfuncs
Date:   Tue, 30 Aug 2022 18:17:16 +0200
Message-Id: <20220830161716.754078-13-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830161716.754078-1-roberto.sassu@huaweicloud.com>
References: <20220830161716.754078-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDHQl0ZOA5jLmYNAA--.2866S14
X-Coremail-Antispam: 1UD129KBjvJXoWxCw45KryDWFyUXF18Gr48JFb_yoW5ur4kpa
        4fWF1qkr48Xw1ava4kKFyIvw43KFWDZwsxGasFqry7ZFW7JF4rWw1UtF45JwnxKw1rJws0
        vr13Ca1kWayUZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
        AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
        W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7I
        U0189tUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAABF1jj35w-QADsH
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add verifier tests to ensure that only supported dynamic pointer types are
accepted, that the passed argument is actually a dynamic pointer, and that
the passed argument is a pointer to the stack.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../bpf/verifier/kfunc_dynptr_param.c         | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/kfunc_dynptr_param.c

diff --git a/tools/testing/selftests/bpf/verifier/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/verifier/kfunc_dynptr_param.c
new file mode 100644
index 000000000000..8abb8d566321
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/kfunc_dynptr_param.c
@@ -0,0 +1,72 @@
+{
+	"kfunc dynamic pointer param: type not supported",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -16),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_IMM(BPF_REG_2, 8),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_MOV64_REG(BPF_REG_4, BPF_REG_6),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve_dynptr),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_discard_dynptr),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_ringbuf = { 3 },
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "bpf",
+	.expected_attach_type = BPF_LSM_MAC,
+	.flags = BPF_F_SLEEPABLE,
+	.errstr = "arg#0 pointer type STRUCT bpf_dynptr_kern points to unsupported dynamic pointer type",
+	.result = REJECT,
+	.fixup_kfunc_btf_id = {
+		{ "bpf_verify_pkcs7_signature", 12 },
+	},
+},
+{
+	"kfunc dynamic pointer param: arg not a dynamic pointer",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "bpf",
+	.expected_attach_type = BPF_LSM_MAC,
+	.flags = BPF_F_SLEEPABLE,
+	.errstr = "arg#0 pointer type STRUCT bpf_dynptr_kern must be valid and initialized",
+	.result = REJECT,
+	.fixup_kfunc_btf_id = {
+		{ "bpf_verify_pkcs7_signature", 5 },
+	},
+},
+{
+	"kfunc dynamic pointer param: arg not a pointer to stack",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "bpf",
+	.expected_attach_type = BPF_LSM_MAC,
+	.flags = BPF_F_SLEEPABLE,
+	.errstr = "arg#0 pointer type STRUCT bpf_dynptr_kern not to stack",
+	.result = REJECT,
+	.fixup_kfunc_btf_id = {
+		{ "bpf_verify_pkcs7_signature", 3 },
+	},
+},
-- 
2.25.1

