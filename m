Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F3E61185E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 18:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiJ1Q4g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 12:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiJ1Qzq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 12:55:46 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEB01CCCD1;
        Fri, 28 Oct 2022 09:55:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MzT5x3dj4z9xFQb;
        Sat, 29 Oct 2022 00:49:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBX9XFOCVxj63ccAA--.45991S4;
        Fri, 28 Oct 2022 17:55:14 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        revest@chromium.org, jackmanb@chromium.org, shuah@kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, zohar@linux.ibm.com
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, nicolas.bouchinet@clip-os.org
Subject: [RESEND][RFC][PATCH 3/3] selftests/bpf: Check if return values of LSM programs are allowed
Date:   Fri, 28 Oct 2022 18:54:23 +0200
Message-Id: <20221028165423.386151-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028165423.386151-1-roberto.sassu@huaweicloud.com>
References: <20221028165423.386151-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBX9XFOCVxj63ccAA--.45991S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1kAr4UAFyxAr48Cr17ZFb_yoWrZw1Dp3
        WrZw1jkF40vF4avFWrK397uayS9FW7CrW5KwnxZwnrZa97JF4xW3W5tFy5Zr13Gr15Gr9Y
        qr17Can5u3WUZa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
        AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
        07jTbyZUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj4DNkwAAs6
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Ensure that the eBPF verifier allows to load only LSM programs that return
an allowed value depending on the LSM hook they attach to.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../testing/selftests/bpf/verifier/lsm_ret.c  | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/lsm_ret.c

diff --git a/tools/testing/selftests/bpf/verifier/lsm_ret.c b/tools/testing/selftests/bpf/verifier/lsm_ret.c
new file mode 100644
index 000000000000..1a11f47fb24a
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/lsm_ret.c
@@ -0,0 +1,148 @@
+{
+	"lsm return value: positive not allowed, return -EPERM",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, -EPERM),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "inode_permission",
+	.expected_attach_type = BPF_LSM_MAC,
+	.result = ACCEPT,
+},
+{
+	"lsm return value: positive not allowed, return zero",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "inode_permission",
+	.expected_attach_type = BPF_LSM_MAC,
+	.result = ACCEPT,
+},
+{
+	"lsm return value: positive not allowed, return one",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "inode_permission",
+	.expected_attach_type = BPF_LSM_MAC,
+	.errstr = "Invalid R0, cannot return positive value",
+	.result = REJECT,
+},
+{
+	"lsm return value: zero/positive not allowed, return -EPERM",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, -EPERM),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "inode_init_security",
+	.expected_attach_type = BPF_LSM_MAC,
+	.result = ACCEPT,
+},
+{
+	"lsm return value: zero/positive not allowed, return zero",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "inode_init_security",
+	.expected_attach_type = BPF_LSM_MAC,
+	.errstr = "Invalid R0, cannot return zero value",
+	.result = REJECT,
+},
+{
+	"lsm return value: zero/positive not allowed, return one",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "inode_init_security",
+	.expected_attach_type = BPF_LSM_MAC,
+	.errstr = "Invalid R0, cannot return positive value",
+	.result = REJECT,
+},
+{
+	"lsm return value: positive allowed, return one",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "getprocattr",
+	.expected_attach_type = BPF_LSM_MAC,
+	.result = ACCEPT,
+},
+{
+	"lsm return value: positive allowed, return two",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "getprocattr",
+	.expected_attach_type = BPF_LSM_MAC,
+	.result = ACCEPT,
+},
+{
+	"lsm return value: only one allowed, return one",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "audit_rule_match",
+	.expected_attach_type = BPF_LSM_MAC,
+	.result = ACCEPT,
+},
+{
+	"lsm return value: only one allowed, return two",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "audit_rule_match",
+	.expected_attach_type = BPF_LSM_MAC,
+	.errstr = "Invalid R0, can return only one as positive value",
+	.result = REJECT,
+},
+{
+	"lsm return value: negative not allowed, return -EPERM",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, -EPERM),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "vm_enough_memory",
+	.expected_attach_type = BPF_LSM_MAC,
+	.errstr = "Invalid R0, cannot return negative value",
+	.result = REJECT,
+},
+{
+	"lsm return value: negative not allowed, return zero",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "vm_enough_memory",
+	.expected_attach_type = BPF_LSM_MAC,
+	.result = ACCEPT,
+},
+{
+	"lsm return value: negative not allowed, return one",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "vm_enough_memory",
+	.expected_attach_type = BPF_LSM_MAC,
+	.result = ACCEPT,
+},
-- 
2.25.1

