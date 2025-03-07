Return-Path: <linux-kselftest+bounces-28523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05334A573B8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 22:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69503B7062
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F393258CF6;
	Fri,  7 Mar 2025 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kP6yB7/g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F11AA1D9;
	Fri,  7 Mar 2025 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383446; cv=none; b=iklP81RVFwfy9kMJUfwbSsr+16y5cXbE7LWCyYwAZecmNBnkLiqf4HbyYImAeZ2GyJ76P4YIqvDf3X+OZG0Yl/m/6jKdA5kZMmNXeFvrxete/RO4jdFc0fJl6j1N4+aTeO/EnWm41cG0K+9kUJGqWe9oTsnCDZ2PlttJucmIo70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383446; c=relaxed/simple;
	bh=3B9l6Kw2qRgE2kwXwLJzC0/Q3NfHEHc0R2E5KicOQm4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZmHqMfnARzmJ+3Bol7OV8m7ju4hydDS1cr+B4WHqo0aUn/et/VYYPT0YZEwRckpwmQ28UOS2+Ohc8L47q+ZQp5nD2TDFP5HhQJmBPwnuZ+9kH6e9jPXhwZ38lWL/PKu9X69fkqj9bUdXnGy3Z13wgXBDGKsDO2V9anl1FZudGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kP6yB7/g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 377362038F40;
	Fri,  7 Mar 2025 13:37:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 377362038F40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741383444;
	bh=LFS7V9tCDaJqTj35fGr6D2Ufwu+eG3KrtNQ3z6ey/Lk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kP6yB7/gcULTXCdPscBzjpQYN7vT8d9Jyc6blPDlUqdr4dxpj9r4w/pqa1sstaq0t
	 3ljPSfb3bbebjgs4ybnDecqATEpp3OfQgTe/eFLnXxys65anMeWSW6t+n51cWxMZtk
	 lx+SE3iiFoLJoYNBXu9wjbSSjSsuLzkFN3Pcimro=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 bpf-next 1/2] security: Propagate caller information in bpf hooks
Date: Fri,  7 Mar 2025 13:36:38 -0800
Message-ID: <20250307213651.3065714-2-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307213651.3065714-1-bboscaccy@linux.microsoft.com>
References: <20250307213651.3065714-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain bpf syscall subcommands are available for usage from both
userspace and the kernel. LSM modules or eBPF gatekeeper programs may
need to take a different course of action depending on whether or not
a BPF syscall originated from the kernel or userspace.

Additionally, some of the bpf_attr struct fields contain pointers to
arbitrary memory. Currently the functionality to determine whether or
not a pointer refers to kernel memory or userspace memory is exposed
to the bpf verifier, but that information is missing from various LSM
hooks.

Here we augment the LSM hooks to provide this data, by simply passing
a boolean flag indicating whether or not the call originated in the
kernel, in any hook that contains a bpf_attr struct that corresponds
to a subcommand that may be called from the kernel.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hook_defs.h                     |  6 +++---
 include/linux/security.h                          | 12 ++++++------
 kernel/bpf/syscall.c                              | 10 +++++-----
 security/security.c                               | 15 +++++++++------
 security/selinux/hooks.c                          |  6 +++---
 tools/testing/selftests/bpf/progs/rcu_read_lock.c |  3 ++-
 .../selftests/bpf/progs/test_cgroup1_hierarchy.c  |  4 ++--
 .../selftests/bpf/progs/test_kfunc_dynptr_param.c |  6 +++---
 .../testing/selftests/bpf/progs/test_lookup_key.c |  2 +-
 .../selftests/bpf/progs/test_ptr_untrusted.c      |  2 +-
 .../selftests/bpf/progs/test_task_under_cgroup.c  |  2 +-
 .../selftests/bpf/progs/test_verify_pkcs7_sig.c   |  2 +-
 12 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index e2f1ce37c41ef..f5aafd3ba5d4d 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -426,14 +426,14 @@ LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
 #endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_BPF_SYSCALL
-LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
+LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
 LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
 LSM_HOOK(int, 0, bpf_map_create, struct bpf_map *map, union bpf_attr *attr,
-	 struct bpf_token *token)
+	 struct bpf_token *token, bool kernel)
 LSM_HOOK(void, LSM_RET_VOID, bpf_map_free, struct bpf_map *map)
 LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *attr,
-	 struct bpf_token *token)
+	 struct bpf_token *token, bool kernel)
 LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
 LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_attr *attr,
 	 const struct path *path)
diff --git a/include/linux/security.h b/include/linux/security.h
index 980b6c207cade..b2010034f82bc 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2249,14 +2249,14 @@ struct bpf_map;
 struct bpf_prog;
 struct bpf_token;
 #ifdef CONFIG_SECURITY
-extern int security_bpf(int cmd, union bpf_attr *attr, unsigned int size);
+extern int security_bpf(int cmd, union bpf_attr *attr, unsigned int size, bool kernel);
 extern int security_bpf_map(struct bpf_map *map, fmode_t fmode);
 extern int security_bpf_prog(struct bpf_prog *prog);
 extern int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
-				   struct bpf_token *token);
+				   struct bpf_token *token, bool kernel);
 extern void security_bpf_map_free(struct bpf_map *map);
 extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
-				  struct bpf_token *token);
+				  struct bpf_token *token, bool kernel);
 extern void security_bpf_prog_free(struct bpf_prog *prog);
 extern int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
 				     const struct path *path);
@@ -2265,7 +2265,7 @@ extern int security_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cm
 extern int security_bpf_token_capable(const struct bpf_token *token, int cap);
 #else
 static inline int security_bpf(int cmd, union bpf_attr *attr,
-					     unsigned int size)
+			       unsigned int size, bool kernel)
 {
 	return 0;
 }
@@ -2281,7 +2281,7 @@ static inline int security_bpf_prog(struct bpf_prog *prog)
 }
 
 static inline int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
-					  struct bpf_token *token)
+					  struct bpf_token *token, bool kernel)
 {
 	return 0;
 }
@@ -2290,7 +2290,7 @@ static inline void security_bpf_map_free(struct bpf_map *map)
 { }
 
 static inline int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
-					 struct bpf_token *token)
+					 struct bpf_token *token, bool kernel)
 {
 	return 0;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 694a675769a60..5670c9f6b99fa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1306,7 +1306,7 @@ static bool bpf_net_capable(void)
 
 #define BPF_MAP_CREATE_LAST_FIELD map_token_fd
 /* called via syscall */
-static int map_create(union bpf_attr *attr)
+static int map_create(union bpf_attr *attr, bool kernel)
 {
 	const struct bpf_map_ops *ops;
 	struct bpf_token *token = NULL;
@@ -1498,7 +1498,7 @@ static int map_create(union bpf_attr *attr)
 			attr->btf_vmlinux_value_type_id;
 	}
 
-	err = security_bpf_map_create(map, attr, token);
+	err = security_bpf_map_create(map, attr, token, kernel);
 	if (err)
 		goto free_map_sec;
 
@@ -2947,7 +2947,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (err < 0)
 		goto free_prog;
 
-	err = security_bpf_prog_load(prog, attr, token);
+	err = security_bpf_prog_load(prog, attr, token, uattr.kernel);
 	if (err)
 		goto free_prog_sec;
 
@@ -5776,13 +5776,13 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	if (copy_from_bpfptr(&attr, uattr, size) != 0)
 		return -EFAULT;
 
-	err = security_bpf(cmd, &attr, size);
+	err = security_bpf(cmd, &attr, size, uattr.kernel);
 	if (err < 0)
 		return err;
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		err = map_create(&attr);
+		err = map_create(&attr, uattr.kernel);
 		break;
 	case BPF_MAP_LOOKUP_ELEM:
 		err = map_lookup_elem(&attr);
diff --git a/security/security.c b/security/security.c
index 143561ebc3e89..c369481232585 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5627,6 +5627,7 @@ int security_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
  * @cmd: command
  * @attr: bpf attribute
  * @size: size
+ * @kernel: whether or not call originated from kernel
  *
  * Do a initial check for all bpf syscalls after the attribute is copied into
  * the kernel. The actual security module can implement their own rules to
@@ -5634,9 +5635,9 @@ int security_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
+int security_bpf(int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
-	return call_int_hook(bpf, cmd, attr, size);
+	return call_int_hook(bpf, cmd, attr, size, kernel);
 }
 
 /**
@@ -5673,6 +5674,7 @@ int security_bpf_prog(struct bpf_prog *prog)
  * @map: BPF map object
  * @attr: BPF syscall attributes used to create BPF map
  * @token: BPF token used to grant user access
+ * @kernel: whether or not call originated from kernel
  *
  * Do a check when the kernel creates a new BPF map. This is also the
  * point where LSM blob is allocated for LSMs that need them.
@@ -5680,9 +5682,9 @@ int security_bpf_prog(struct bpf_prog *prog)
  * Return: Returns 0 on success, error on failure.
  */
 int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
-			    struct bpf_token *token)
+			    struct bpf_token *token, bool kernel)
 {
-	return call_int_hook(bpf_map_create, map, attr, token);
+	return call_int_hook(bpf_map_create, map, attr, token, kernel);
 }
 
 /**
@@ -5690,6 +5692,7 @@ int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
  * @prog: BPF program object
  * @attr: BPF syscall attributes used to create BPF program
  * @token: BPF token used to grant user access to BPF subsystem
+ * @kernel: whether or not call originated from kernel
  *
  * Perform an access control check when the kernel loads a BPF program and
  * allocates associated BPF program object. This hook is also responsible for
@@ -5698,9 +5701,9 @@ int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
  * Return: Returns 0 on success, error on failure.
  */
 int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
-			   struct bpf_token *token)
+			   struct bpf_token *token, bool kernel)
 {
-	return call_int_hook(bpf_prog_load, prog, attr, token);
+	return call_int_hook(bpf_prog_load, prog, attr, token, kernel);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88ba..71199d86fc97f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6866,7 +6866,7 @@ static int selinux_ib_alloc_security(void *ib_sec)
 
 #ifdef CONFIG_BPF_SYSCALL
 static int selinux_bpf(int cmd, union bpf_attr *attr,
-				     unsigned int size)
+		       unsigned int size, bool kernel)
 {
 	u32 sid = current_sid();
 	int ret;
@@ -6953,7 +6953,7 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
 }
 
 static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
-				  struct bpf_token *token)
+				  struct bpf_token *token, bool kernel)
 {
 	struct bpf_security_struct *bpfsec;
 
@@ -6976,7 +6976,7 @@ static void selinux_bpf_map_free(struct bpf_map *map)
 }
 
 static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
-				 struct bpf_token *token)
+				 struct bpf_token *token, bool kernel)
 {
 	struct bpf_security_struct *bpfsec;
 
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index ab3a532b7dd6d..582c245467c3a 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -242,7 +242,8 @@ int inproper_sleepable_helper(void *ctx)
 }
 
 SEC("?lsm.s/bpf")
-int BPF_PROG(inproper_sleepable_kfunc, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(inproper_sleepable_kfunc, int cmd, union bpf_attr *attr, unsigned int size,
+	     bool kernel)
 {
 	struct bpf_key *bkey;
 
diff --git a/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
index 44628865fe1d4..4fee0fdc76076 100644
--- a/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
+++ b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
@@ -51,13 +51,13 @@ static int bpf_link_create_verify(int cmd)
 }
 
 SEC("lsm/bpf")
-int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
 	return bpf_link_create_verify(cmd);
 }
 
 SEC("lsm.s/bpf")
-int BPF_PROG(lsm_s_run, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(lsm_s_run, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
 	return bpf_link_create_verify(cmd);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
index cd4d752bd089c..061befb004c24 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -36,7 +36,7 @@ char _license[] SEC("license") = "GPL";
 
 SEC("?lsm.s/bpf")
 __failure __msg("cannot pass in dynptr at an offset=-8")
-int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
 	unsigned long val;
 
@@ -46,7 +46,7 @@ int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size)
 
 SEC("?lsm.s/bpf")
 __failure __msg("arg#0 expected pointer to stack or const struct bpf_dynptr")
-int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
 	unsigned long val = 0;
 
@@ -55,7 +55,7 @@ int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size)
 }
 
 SEC("lsm.s/bpf")
-int BPF_PROG(dynptr_data_null, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(dynptr_data_null, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
 	struct bpf_key *trusted_keyring;
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/test_lookup_key.c b/tools/testing/selftests/bpf/progs/test_lookup_key.c
index c73776990ae30..cdbbb12f1491a 100644
--- a/tools/testing/selftests/bpf/progs/test_lookup_key.c
+++ b/tools/testing/selftests/bpf/progs/test_lookup_key.c
@@ -23,7 +23,7 @@ extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
 extern void bpf_key_put(struct bpf_key *key) __ksym;
 
 SEC("lsm.s/bpf")
-int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
 	struct bpf_key *bkey;
 	__u32 pid;
diff --git a/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c b/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
index 2fdc44e766248..89b0cd5a3e06e 100644
--- a/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
@@ -7,7 +7,7 @@
 char tp_name[128];
 
 SEC("lsm.s/bpf")
-int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
 	switch (cmd) {
 	case BPF_RAW_TRACEPOINT_OPEN:
diff --git a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
index 7e750309ce274..0b74b8bd22e87 100644
--- a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
@@ -49,7 +49,7 @@ int BPF_PROG(tp_btf_run, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("lsm.s/bpf")
-int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
 	struct cgroup *cgrp = NULL;
 	struct task_struct *task;
diff --git a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
index 12034a73ee2d2..e96d09e111155 100644
--- a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
@@ -37,7 +37,7 @@ struct {
 char _license[] SEC("license") = "GPL";
 
 SEC("lsm.s/bpf")
-int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
+int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
 	struct bpf_dynptr data_ptr, sig_ptr;
 	struct data *data_val;
-- 
2.48.1


