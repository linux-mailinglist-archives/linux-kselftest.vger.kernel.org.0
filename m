Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CF4611814
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJ1QvG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 12:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJ1QvB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 12:51:01 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82EC82619;
        Fri, 28 Oct 2022 09:50:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MzT0N1hMDz9xqxV;
        Sat, 29 Oct 2022 00:44:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwD3LPk3CFxjeW4cAA--.34547S4;
        Fri, 28 Oct 2022 17:50:30 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        revest@chromium.org, jackmanb@chromium.org, shuah@kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 3/3] selftests/bpf: Check if return values of LSM programs are allowed
Date:   Fri, 28 Oct 2022 18:49:48 +0200
Message-Id: <20221028164948.385783-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028164948.385783-1-roberto.sassu@huaweicloud.com>
References: <20221028164948.385783-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwD3LPk3CFxjeW4cAA--.34547S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1kAr4UAFyxAr48Cr17ZFb_yoWrZw1Dp3
        WrZw1jkF40vF4avFWrK397uayS9FW7CrW5KwnxZwnrZa97JF4xW3W5tFy5Zr13Gr15Gr9Y
        qr17Can5u3WUZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
        v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU
        IID7DUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj4DNhQAAss
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

