Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5955964602D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 18:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiLGR0r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 12:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiLGR0Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 12:26:16 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE4D61743;
        Wed,  7 Dec 2022 09:26:09 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NS3tP1d7vz9v7Y8;
        Thu,  8 Dec 2022 01:19:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD34m9YzJBjc9DJAA--.62662S7;
        Wed, 07 Dec 2022 18:25:45 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, mykolal@fb.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v2 5/7] selftests/bpf: Check if return values of LSM programs are allowed
Date:   Wed,  7 Dec 2022 18:24:32 +0100
Message-Id: <20221207172434.435893-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207172434.435893-1-roberto.sassu@huaweicloud.com>
References: <20221207172434.435893-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD34m9YzJBjc9DJAA--.62662S7
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1kAr4UAFyxAr48Cr17ZFb_yoWrZr4Up3
        WrZw1jkF40vF4avayrK397uayS9FW3CrWUKwnxZwnrZaykJF4xW3WUtFy5Ar13Gr15Gr9Y
        qF17Can5u3WUZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
        kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
        v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
        pf9x07j7GYLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj4JqowABsu
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
index 000000000000..c9c9cee8e406
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
+	.errstr = "Invalid R0, cannot return 1",
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
+	.errstr = "Invalid R0, cannot return 0",
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
+	.errstr = "Invalid R0, cannot return 1",
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
+	.errstr = "Invalid R0, cannot return > 1",
+	.result = REJECT,
+},
+{
+	"lsm return value: negative not allowed, return -EPERM",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, -EPERM),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "ismaclabel",
+	.expected_attach_type = BPF_LSM_MAC,
+	.errstr = "Invalid R0, cannot return < 0",
+	.result = REJECT,
+},
+{
+	"lsm return value: negative not allowed, return zero",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_LSM,
+	.kfunc = "ismaclabel",
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
+	.kfunc = "ismaclabel",
+	.expected_attach_type = BPF_LSM_MAC,
+	.result = ACCEPT,
+},
-- 
2.25.1

