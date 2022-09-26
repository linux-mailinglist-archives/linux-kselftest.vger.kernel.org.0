Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8EA5EAD32
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Sep 2022 18:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiIZQwP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Sep 2022 12:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIZQvu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Sep 2022 12:51:50 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E45FD22;
        Mon, 26 Sep 2022 08:45:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mbn4J4rLbz9xqcV;
        Mon, 26 Sep 2022 23:39:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwB3pF7lyDFjZ4d6AA--.42219S4;
        Mon, 26 Sep 2022 16:45:05 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org, oss@lmb.io
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, fengc@google.com, davem@davemloft.net
Subject: [RFC][PATCH 2/3] bpf: Enforce granted permissions in a map fd at verifier level
Date:   Mon, 26 Sep 2022 17:44:29 +0200
Message-Id: <20220926154430.1552800-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926154430.1552800-1-roberto.sassu@huaweicloud.com>
References: <20220926154430.1552800-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwB3pF7lyDFjZ4d6AA--.42219S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry3Xr43Kw1kGFyxZw4Utwb_yoW3JFWDpF
        s5GFs7GF1kJa1S93y3JayDA345t3WrXw47Ca45K340y3ZIgrn29F40gF15ZFy5AF48Ar1I
        vr129rW5GayUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
        AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
        07j7hLnUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj3941QABsj
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Commit afdb09c720b62 ("security: bpf: Add LSM hooks for bpf object related
syscall") introduced new eBPF-related hooks in the LSM framework, for
programs and maps, aiming at enforcing permissions per eBPF object.

Commit 6e71b04a82248 ("bpf: Add file mode configuration into bpf maps")
further introduced the BPF_F_RDONLY and BPF_F_WRONLY flags, for user space
to request specific permissions when using a given eBPF object.

The two patches are related, as the first ensures that LSMs grant to user
space the requested permissions (read and/or write) for performing
operations on an eBPF object. The second ensures that the granted
permissions are sufficient to perform a requested operation.

While the second check has been added for operations of the bpf() system
call that directly deal with a map, such as BPF_MAP_*_ELEM, it is missing
for bpf() system call operations that still receive a map fd, but modify a
map indirectly: map iterators (addressed separately) and the eBPF verifier.

An eBPF program might contain a map fd as argument of the BPF_PSEUDO_MAP_FD
and BPF_PSEUDO_MAP_IDX instructions. The eBPF verifier processes those
instructions, and replaces the map fd with the corresponding map address,
which can be then passed to eBPF helpers, such as bpf_map_lookup_elem() and
bpf_map_update_elem(). This has the same effect of invoking the bpf()
system call and executing the BPF_MAP_*_ELEM operations.

The problem is that, unlike BPF_MAP_*_ELEM operations of the bpf() system
call, the eBPF verifier does not check the fd modes before letting the eBPF
program do map operations. As a consequence, for example, a read-only fd
can be provided to the eBPF program, allowing it to do a map update.

A different behavior occurs when the map flags BPF_F_RDONLY_PROG and
BPF_F_WRONLY_PROG are set at map creation time. Commit 591fe9888d78 ("bpf:
add program side {rd, wr}only support for maps") ensures that only the map
operations compatible with the map flags can be executed by the eBPF
program, otherwise the verifier refuses to run that program.

As the verifier can already restrict map operations, rely on the same
mechanism to enforce permissions given with the fd. Providing a read-only
fd has the same effect of setting the BPF_F_RDONLY_PROG map flag, except
that the effect is limited to the program execution and not for the map
lifetime.

If multiple map fds are provided to the eBPF program, combine the fd modes,
as the verifier is not able to track the exact fd a map address has been
obtained from.

Finally, make sure that the resulting fd modes don't give to the eBPF
program more permissions than the ones granted by map flags. Instead, given
the initial permissions granted by map flags, clear the ones that are
missing from the fd.

Although normally map fd-based operations are not affected by BPF_F_*_PROG,
in this case it cannot be, as it is the eBPF program itself doing map
operations, which is what BPF_F_*_PROG are designed to restrict.

Cc: stable@vger.kernel.org
Fixes: 6e71b04a82248 ("bpf: Add file mode configuration into bpf maps")
Reported by: Lorenz Bauer <oss@lmb.io>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/bpf.h          | 13 +++++++++++++
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 26 ++++++++++++++++++++++++--
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index edd43edb27d6..1e18f11df7ca 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1415,6 +1415,19 @@ static inline u32 bpf_map_flags_to_cap(struct bpf_map *map)
 		return BPF_MAP_CAN_READ | BPF_MAP_CAN_WRITE;
 }
 
+static inline u32 bpf_fd_modes_to_cap(fmode_t mode)
+{
+	u32 cap = 0;
+
+	if (mode & FMODE_CAN_READ)
+		cap |= BPF_MAP_CAN_READ;
+
+	if (mode & FMODE_CAN_WRITE)
+		cap |= BPF_MAP_CAN_WRITE;
+
+	return cap;
+}
+
 static inline bool bpf_map_flags_access_ok(u32 access_flags)
 {
 	return (access_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG)) !=
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9e1e6965f407..3f490bae0bcd 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -501,6 +501,7 @@ struct bpf_verifier_env {
 	struct bpf_verifier_state_list **explored_states; /* search pruning optimization */
 	struct bpf_verifier_state_list *free_list;
 	struct bpf_map *used_maps[MAX_USED_MAPS]; /* array of map's used by eBPF program */
+	u32 used_maps_caps[MAX_USED_MAPS]; /* array of map capabilities possessed by eBPF program */
 	struct btf_mod_pair used_btfs[MAX_USED_BTFS]; /* array of BTF's used by BPF program */
 	u32 used_map_cnt;		/* number of used maps */
 	u32 used_btf_cnt;		/* number of used BTF objects */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6f6d2d511c06..ac9bd4402169 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3531,6 +3531,14 @@ static int check_map_access_type(struct bpf_verifier_env *env, u32 regno,
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_map *map = regs[regno].map_ptr;
 	u32 cap = bpf_map_flags_to_cap(map);
+	int i;
+
+	for (i = 0; i < env->used_map_cnt; i++) {
+		if (env->used_maps[i] == map) {
+			cap &= env->used_maps_caps[i];
+			break;
+		}
+	}
 
 	if (type == BPF_WRITE && !(cap & BPF_MAP_CAN_WRITE)) {
 		verbose(env, "write into map forbidden, value_size=%d off=%d size=%d\n",
@@ -7040,6 +7048,8 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
 	struct bpf_map *map = meta->map_ptr;
+	u32 cap;
+	int i;
 
 	if (func_id != BPF_FUNC_tail_call &&
 	    func_id != BPF_FUNC_map_lookup_elem &&
@@ -7058,11 +7068,20 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		return -EINVAL;
 	}
 
+	cap = bpf_map_flags_to_cap(map);
+
+	for (i = 0; i < env->used_map_cnt; i++) {
+		if (env->used_maps[i] == map) {
+			cap &= env->used_maps_caps[i];
+			break;
+		}
+	}
+
 	/* In case of read-only, some additional restrictions
 	 * need to be applied in order to prevent altering the
 	 * state of the map from program side.
 	 */
-	if ((map->map_flags & BPF_F_RDONLY_PROG) &&
+	if (!(cap & BPF_MAP_CAN_WRITE) &&
 	    (func_id == BPF_FUNC_map_delete_elem ||
 	     func_id == BPF_FUNC_map_update_elem ||
 	     func_id == BPF_FUNC_map_push_elem ||
@@ -12870,6 +12889,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			/* check whether we recorded this map already */
 			for (j = 0; j < env->used_map_cnt; j++) {
 				if (env->used_maps[j] == map) {
+					env->used_maps_caps[j] |= bpf_fd_modes_to_cap(f.file->f_mode);
 					aux->map_index = j;
 					fdput(f);
 					goto next_insn;
@@ -12889,7 +12909,9 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			bpf_map_inc(map);
 
 			aux->map_index = env->used_map_cnt;
-			env->used_maps[env->used_map_cnt++] = map;
+			env->used_maps[env->used_map_cnt] = map;
+			env->used_maps_caps[env->used_map_cnt] = bpf_fd_modes_to_cap(f.file->f_mode);
+			env->used_map_cnt++;
 
 			if (bpf_map_is_cgroup_storage(map) &&
 			    bpf_cgroup_storage_assign(env->prog->aux, map)) {
-- 
2.25.1

