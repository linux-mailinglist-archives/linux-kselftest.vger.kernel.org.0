Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ECB61180F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 18:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJ1Qur (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 12:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJ1Quo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 12:50:44 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B506C82619;
        Fri, 28 Oct 2022 09:50:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MzT0B6J90z9xqxc;
        Sat, 29 Oct 2022 00:44:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwD3LPk3CFxjeW4cAA--.34547S3;
        Fri, 28 Oct 2022 17:50:21 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        revest@chromium.org, jackmanb@chromium.org, shuah@kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2/3] bpf-lsm: Limit values that can be returned by security modules
Date:   Fri, 28 Oct 2022 18:49:47 +0200
Message-Id: <20221028164948.385783-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028164948.385783-1-roberto.sassu@huaweicloud.com>
References: <20221028164948.385783-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwD3LPk3CFxjeW4cAA--.34547S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4rCr15ur1rGFWxAw4DXFb_yoW3Cw4Upr
        4xJFyYkrsYvrZIqa4Iyan5Zws5AF1Fga1DKr1DGr1IkrWIvrykJw1UAr1jqr9xWryUGrsa
        gr4qvF4Yg347ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
        Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
        0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU04q
        2tUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBF1jj4TMTQABsj
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

BPF LSM defines a bpf_lsm_*() function for each LSM hook, so that
security modules can define their own implementation for the desired hooks.

Unfortunately, BPF LSM does not restrict which values security modules can
return (for non-void LSM hooks). Security modules might follow the
conventions stated in include/linux/lsm_hooks.h, or put arbitrary values.

This could cause big troubles, as the kernel is not ready to handle
possibly malicious return values from LSMs. Until now, it was not the
case, as each LSM is carefully reviewed and it won't be accepted if it
does not meet the return value conventions.

The biggest problem is when an LSM returns a positive value, instead of a
negative value, as it could be converted to a pointer. Since such pointer
escapes the IS_ERR() check, its use later in the code can cause
unpredictable consequences (e.g. invalid memory access).

Another problem is returning zero when an LSM is supposed to have done some
operations. For example, the inode_init_security hook expects that their
implementations return zero only if they set the name and value of the new
xattr to be added to the new inode. Otherwise, other kernel subsystems
might encounter unexpected conditions leading to a crash (e.g.
evm_protected_xattr_common() getting NULL as argument).

Finally, there are LSM hooks which are supposed to return just one as
positive value, or non-negative values. Also in these cases, although it
seems less critical, it is safer to return to callers of the LSM
infrastructure more precisely what they expect.

As eBPF allows code outside the kernel to run, it is its responsibility
to ensure that only expected values are returned to LSM infrastructure
callers.

Create four new BTF ID sets, respectively for hooks that can return
positive values, only one as positive value, that cannot return zero, and
that cannot return negative values. Create also corresponding functions to
check if the hook a security module is attached to belongs to one of the
defined sets.

Finally, check in the eBPF verifier the value returned by security modules
for each attached LSM hook, and return -EINVAL (the security module cannot
run) if the hook implementation does not satisfy the hook return value
policy.

Cc: stable@vger.kernel.org
Fixes: 9d3fdea789c8 ("bpf: lsm: Provide attachment points for BPF LSM programs")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/bpf_lsm.h | 24 ++++++++++++++++++
 kernel/bpf/bpf_lsm.c    | 56 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c   | 35 +++++++++++++++++++++++---
 3 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 4bcf76a9bb06..cd38aca4cfc0 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -28,6 +28,10 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 			const struct bpf_prog *prog);
 
 bool bpf_lsm_is_sleepable_hook(u32 btf_id);
+bool bpf_lsm_can_ret_pos_value(u32 btf_id);
+bool bpf_lsm_can_ret_only_one_as_pos_value(u32 btf_id);
+bool bpf_lsm_cannot_ret_zero(u32 btf_id);
+bool bpf_lsm_cannot_ret_neg_value(u32 btf_id);
 
 static inline struct bpf_storage_blob *bpf_inode(
 	const struct inode *inode)
@@ -51,6 +55,26 @@ static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
 	return false;
 }
 
+static inline bool bpf_lsm_can_ret_pos_value(u32 btf_id)
+{
+	return false;
+}
+
+static inline bool bpf_lsm_can_ret_only_one_as_pos_value(u32 btf_id)
+{
+	return false;
+}
+
+static inline bool bpf_lsm_cannot_ret_zero(u32 btf_id)
+{
+	return false;
+}
+
+static inline bool bpf_lsm_cannot_ret_neg_value(u32 btf_id)
+{
+	return false;
+}
+
 static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 				      const struct bpf_prog *prog)
 {
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index d6c9b3705f24..3dcb70b2f978 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -348,6 +348,62 @@ bool bpf_lsm_is_sleepable_hook(u32 btf_id)
 	return btf_id_set_contains(&sleepable_lsm_hooks, btf_id);
 }
 
+/* The set of hooks which are allowed to return a positive value. */
+BTF_SET_START(pos_ret_value_lsm_hooks)
+BTF_ID(func, bpf_lsm_vm_enough_memory)
+BTF_ID(func, bpf_lsm_inode_getsecurity)
+BTF_ID(func, bpf_lsm_inode_listsecurity)
+BTF_ID(func, bpf_lsm_inode_need_killpriv)
+BTF_ID(func, bpf_lsm_inode_copy_up_xattr)
+BTF_ID(func, bpf_lsm_getprocattr)
+BTF_ID(func, bpf_lsm_setprocattr)
+BTF_ID(func, bpf_lsm_xfrm_state_pol_flow_match)
+BTF_ID(func, bpf_lsm_key_getsecurity)
+BTF_ID(func, bpf_lsm_ismaclabel)
+BTF_ID(func, bpf_lsm_audit_rule_known)
+BTF_ID(func, bpf_lsm_audit_rule_match)
+BTF_SET_END(pos_ret_value_lsm_hooks)
+
+bool bpf_lsm_can_ret_pos_value(u32 btf_id)
+{
+	return btf_id_set_contains(&pos_ret_value_lsm_hooks, btf_id);
+}
+
+BTF_SET_START(one_ret_value_lsm_hooks)
+BTF_ID(func, bpf_lsm_vm_enough_memory)
+BTF_ID(func, bpf_lsm_inode_copy_up_xattr)
+BTF_ID(func, bpf_lsm_xfrm_state_pol_flow_match)
+BTF_ID(func, bpf_lsm_ismaclabel)
+BTF_ID(func, bpf_lsm_audit_rule_known)
+BTF_ID(func, bpf_lsm_audit_rule_match)
+BTF_SET_END(one_ret_value_lsm_hooks)
+
+bool bpf_lsm_can_ret_only_one_as_pos_value(u32 btf_id)
+{
+	return btf_id_set_contains(&one_ret_value_lsm_hooks, btf_id);
+}
+
+/* The set of hooks which are not allowed to return zero. */
+BTF_SET_START(not_zero_ret_value_lsm_hooks)
+BTF_ID(func, bpf_lsm_inode_init_security)
+BTF_SET_END(not_zero_ret_value_lsm_hooks)
+
+bool bpf_lsm_cannot_ret_zero(u32 btf_id)
+{
+	return btf_id_set_contains(&not_zero_ret_value_lsm_hooks, btf_id);
+}
+
+/* The set of hooks which are not allowed to return a negative value. */
+BTF_SET_START(not_neg_ret_value_lsm_hooks)
+BTF_ID(func, bpf_lsm_vm_enough_memory)
+BTF_ID(func, bpf_lsm_audit_rule_known)
+BTF_SET_END(not_neg_ret_value_lsm_hooks)
+
+bool bpf_lsm_cannot_ret_neg_value(u32 btf_id)
+{
+	return btf_id_set_contains(&not_neg_ret_value_lsm_hooks, btf_id);
+}
+
 const struct bpf_prog_ops lsm_prog_ops = {
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8f849a763b79..7ee639b9f0e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10622,9 +10622,38 @@ static int check_return_code(struct bpf_verifier_env *env)
 
 	case BPF_PROG_TYPE_LSM:
 		if (env->prog->expected_attach_type != BPF_LSM_CGROUP) {
-			/* Regular BPF_PROG_TYPE_LSM programs can return
-			 * any value.
-			 */
+			/* < 0 */
+			if (tnum_in(tnum_range((u64)(~0) << 31, (u64)(~0)), reg->var_off)) {
+				if (bpf_lsm_cannot_ret_neg_value(env->prog->aux->attach_btf_id)) {
+					verbose(env, "Invalid R0, cannot return negative value\n");
+					return -EINVAL;
+				}
+			/* = 0 */
+			} else if (tnum_equals_const(reg->var_off, 0)) {
+				if (bpf_lsm_cannot_ret_zero(env->prog->aux->attach_btf_id)) {
+					verbose(env, "Invalid R0, cannot return zero value\n");
+					return -EINVAL;
+				}
+			/* = 1 */
+			} else if (tnum_equals_const(reg->var_off, 1)) {
+				if (!bpf_lsm_can_ret_pos_value(env->prog->aux->attach_btf_id)) {
+					verbose(env, "Invalid R0, cannot return positive value\n");
+					return -EINVAL;
+				}
+			/* > 1 */
+			} else {
+				if (!bpf_lsm_can_ret_pos_value(env->prog->aux->attach_btf_id)) {
+					verbose(env, "Invalid R0, cannot return positive value\n");
+					return -EINVAL;
+				}
+
+				if (bpf_lsm_can_ret_only_one_as_pos_value(env->prog->aux->attach_btf_id)) {
+					verbose(env,
+						"Invalid R0, can return only one as positive value\n");
+					return -EINVAL;
+				}
+			}
+
 			return 0;
 		}
 		if (!env->prog->aux->attach_func_proto->type) {
-- 
2.25.1

