Return-Path: <linux-kselftest+bounces-13571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AA992E64B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 13:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD581F2102C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AEB16D31B;
	Thu, 11 Jul 2024 11:14:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67F16CD1D;
	Thu, 11 Jul 2024 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696451; cv=none; b=mMOhKwWT3yMGNaSNXFLFUR+Eyl25sNzc871gLr1fjbt9+yBERsJapG7M1uP5np+gRV+sq2d4oomCAGXwv3BCmYRwOfGZmxzTkNPKxeDUnot9sx5evprLxUmwpZVTvFCUDbh2pFqq/eS/GW0zMHGTNNGo74q2mGL6QUwCqqDYkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696451; c=relaxed/simple;
	bh=4aeLwWNHq/s0RMuojnFjDGBoFx4/hqYrejdNWWtuzgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jf6+jDROQRhJYLXe5ape4KUFLmbOioa6RjKiFv2IBbQiT3VG9HrV17+k1b8epAagn+BdY/gb/QZzbLDEVNK4XnXa2wBjSpDovqWvRZxbHp4MY9nhSlUBVVSXxKxeNxaVoctL5Pq2iEkMU7wZ5zT5J6DB30My6qWJF0YDAyOVcYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WKXCt6f8qz4f3jXw;
	Thu, 11 Jul 2024 19:13:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9713C1A0189;
	Thu, 11 Jul 2024 19:13:58 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgCHjPVxvo9mulQgBw--.25300S14;
	Thu, 11 Jul 2024 19:13:58 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Brendan Jackman <jackmanb@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	John Johansen <john.johansen@canonical.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH bpf-next v4 12/20] bpf, lsm: Enable BPF LSM prog to read/write return value parameters
Date: Thu, 11 Jul 2024 19:19:00 +0800
Message-Id: <20240711111908.3817636-13-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240711111908.3817636-1-xukuohai@huaweicloud.com>
References: <20240711111908.3817636-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHjPVxvo9mulQgBw--.25300S14
X-Coremail-Antispam: 1UD129KBjvJXoWxAw47XFWxWF4rtr1UGF4Durg_yoWrKr13pF
	4fJryFkr4vvrWag3ZrtFs5uFW5Jw40gw42ka9xXry0vF1jvr1rt3WUGryaqrW3KFyDJr1f
	Kr429FWY9347ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Output parameters are used to refactor the LSM hook return values.
To make these hooks usable by bpf prog, it is necessary for bpf prog
to read and write these output return value parameters.

All return value parameters are added as the last parameter and are
always pointers to integer types. This patch uses BTF ID list to
specify which LMS hooks have return value parameters and enables bpf
prog to read/write the last parameters of these hooks in the verifier.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf_lsm.h |  6 ++++++
 kernel/bpf/bpf_lsm.c    | 15 +++++++++++++++
 kernel/bpf/btf.c        | 16 +++++++++++++++-
 kernel/bpf/verifier.c   | 33 ++++++++++++++++++++++++++++++++-
 4 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 1de7ece5d36d..73e1f6dbec4a 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -45,6 +45,8 @@ void bpf_inode_storage_free(struct inode *inode);
 
 void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func);
 
+bool bpf_lsm_has_retval_param(const struct bpf_prog *prog);
+
 #else /* !CONFIG_BPF_LSM */
 
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
@@ -78,6 +80,10 @@ static inline void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 {
 }
 
+static inline bool bpf_lsm_has_retval_param(const struct bpf_prog *prog)
+{
+	return false;
+}
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index e5feb6560fe6..a8f8358c77e3 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -405,3 +405,18 @@ const struct bpf_verifier_ops lsm_verifier_ops = {
 	.get_func_proto = bpf_lsm_func_proto,
 	.is_valid_access = btf_ctx_access,
 };
+
+BTF_SET_START(retval_param_lsm_hooks)
+BTF_ID(func, bpf_lsm_inode_need_killpriv)
+BTF_ID(func, bpf_lsm_inode_getsecurity)
+BTF_ID(func, bpf_lsm_inode_listsecurity)
+BTF_ID(func, bpf_lsm_getselfattr)
+BTF_ID(func, bpf_lsm_key_getsecurity)
+BTF_ID(func, bpf_lsm_audit_rule_match)
+BTF_SET_END(retval_param_lsm_hooks)
+
+bool bpf_lsm_has_retval_param(const struct bpf_prog *prog)
+{
+	return btf_id_set_contains(&retval_param_lsm_hooks,
+				   prog->aux->attach_btf_id);
+}
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4ff11779699e..df299d600b10 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6499,8 +6499,22 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		 */
 		return true;
 
-	if (is_int_ptr(btf, t))
+
+	if (is_int_ptr(btf, t)) {
+		/* the retval param for LSM hook is always the last param. */
+		if (arg == nr_args - 1 &&
+		    prog->expected_attach_type == BPF_LSM_MAC &&
+		    bpf_lsm_has_retval_param(prog)) {
+			u32 id;
+
+			btf_type_skip_modifiers(btf, t->type, &id);
+			info->btf = btf;
+			/* the retval param should never be NULL */
+			info->reg_type = PTR_TO_BTF_ID | PTR_TRUSTED;
+			info->btf_id = id;
+		}
 		return true;
+	}
 
 	/* this is a pointer to another type */
 	for (i = 0; i < prog->aux->ctx_arg_info_size; i++) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c0263fb5ca4b..a0bbef2d14e4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6527,7 +6527,38 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (env->ops->btf_struct_access && !type_is_alloc(reg->type) && atype == BPF_WRITE) {
+	if (btf_type_is_int(t)) {
+		u32 tsize;
+		const char *tname;
+		const struct btf_type *err;
+		const char *access = atype == BPF_READ ? "read" : "write";
+
+		/* only BPF LSM is allowed */
+		if (WARN_ON_ONCE(env->prog->expected_attach_type != BPF_LSM_MAC)) {
+			verbose(env, "verifier internal error: not BPF LSM\n");
+			return -EACCES;
+		}
+
+		tname = btf_name_by_offset(reg->btf, t->name_off);
+		if (off != 0) {
+			verbose(env, "invalid %s offset: %d (expected 0, type=%s)\n",
+				access, off, tname);
+			return -EACCES;
+		}
+
+		err = btf_resolve_size(reg->btf, t, &tsize);
+		if (IS_ERR(err)) {
+			verbose(env, "unable to resolve the size of type '%s': %ld\n",
+				tname, PTR_ERR(err));
+			return PTR_ERR(err);
+		}
+		if (size != tsize) {
+			verbose(env, "invalid %s size: %d (expected %u, type=%s)\n",
+				access, size, tsize, tname);
+			return -EACCES;
+		}
+		ret = SCALAR_VALUE;
+	} else if (env->ops->btf_struct_access && !type_is_alloc(reg->type) && atype == BPF_WRITE) {
 		if (!btf_is_kernel(reg->btf)) {
 			verbose(env, "verifier internal error: reg->btf must be kernel btf\n");
 			return -EFAULT;
-- 
2.30.2


