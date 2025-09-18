Return-Path: <linux-kselftest+bounces-41345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB52B54C19
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F8B586893
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E649313542;
	Fri, 12 Sep 2025 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0zNEf8L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DBC305047;
	Fri, 12 Sep 2025 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678080; cv=none; b=jIC7H4GkZKVpYQ+woeTVNGMpK6FITFMk74gggQtgg/2+qzHejgLW3kwn8ROHK6qzzEYrHbORuyj1EQfbQZO8kfPNXZjnqdrdVeRE7igsX58I4VVW0pEYSUlnJGXCf9rFjqxLhcu+BoTsa8iiMZH2rdSfxB1xBykrfWzrikCy6Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678080; c=relaxed/simple;
	bh=5xiw6OfhVh00mJOtdBSreH+JI53YjCepXuhC3AtIEBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DHmhUPVYpUi/Ps6hmF2HRM8oLn9AYoP7S0l4BWdQeBzyE9AEtaqxH9LNc1owCuHGxS5bLkdtTR9CpjYqbt9geVPEHy+4KhF189DZA/NywP5WNtPsxc74TP/u1sAfqfkoKt2Bq0akwPL+Lk/T5jH7bThN1B3x7095OjAwa2B/1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0zNEf8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C1DC4CEF1;
	Fri, 12 Sep 2025 11:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678078;
	bh=5xiw6OfhVh00mJOtdBSreH+JI53YjCepXuhC3AtIEBE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B0zNEf8LHJ3kMDp14M7b5mQVbcMr52WeDUsMU7X7bDGNvpqU0nHruSk6RMn4zRQPi
	 P/16NtNjh3HU5s9kJ2tIrV2Yb0A0Z+UdSP+ohbz/RG9/rWVd+AA2AQsi2grUXseMnw
	 lEzuUhpK14h8ULCqV+9KYoQEGZMYgVg81yHpnbnfljrlw7u+JYM6TOfZR1/EYVmVN7
	 0KfrVkCwuYa3lUxaMetHasYqtJhnnqH1eey0Z4XwRYpPeOMteOK/C+AFhPxoGLVEIi
	 KXacQ3etCLZp0FGOC2r47L5zzZcnVGu4zZnHRxGw/FSLksq+vDydGpfgv1V/mlOoPa
	 myAOBHKJ85i9w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:40 +0200
Subject: [PATCH v2 17/33] nstree: make iterator generic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-17-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=11888; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5xiw6OfhVh00mJOtdBSreH+JI53YjCepXuhC3AtIEBE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZzKPUeg7F8My5TViT41v1brbty2fE1+Q2z74m+yz
 w422ltO6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIkhOMDDtCT7+pOO7lLNhn
 siSmMsww8EmXof6iA9lZW6Ja50+/qsnwi7lN6j3P26R9oVu6GO+pdCeGP7kkOSnu8+0eucxF/cs
 XsAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Move the namespace iteration infrastructure originally introduced for
mount namespaces into a generic library usable by all namespace types.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h |   9 ++
 include/linux/nstree.h    |  89 ++++++++++++++++++
 include/linux/proc_ns.h   |   3 +
 kernel/Makefile           |   2 +-
 kernel/nstree.c           | 233 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 335 insertions(+), 1 deletion(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index bc2e0758e1c9..7224072cccc5 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -3,6 +3,7 @@
 #define _LINUX_NS_COMMON_H
 
 #include <linux/refcount.h>
+#include <linux/rbtree.h>
 
 struct proc_ns_operations;
 
@@ -20,6 +21,14 @@ struct ns_common {
 	const struct proc_ns_operations *ops;
 	unsigned int inum;
 	refcount_t count;
+	union {
+		struct {
+			u64 ns_id;
+			struct rb_node ns_tree_node;
+			struct list_head ns_list_node;
+		};
+		struct rcu_head ns_rcu;
+	};
 };
 
 #define to_ns_common(__ns)                              \
diff --git a/include/linux/nstree.h b/include/linux/nstree.h
new file mode 100644
index 000000000000..e26951a83924
--- /dev/null
+++ b/include/linux/nstree.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_NSTREE_H
+#define _LINUX_NSTREE_H
+
+#include <linux/ns_common.h>
+#include <linux/nsproxy.h>
+#include <linux/rbtree.h>
+#include <linux/seqlock.h>
+#include <linux/rculist.h>
+#include <linux/cookie.h>
+
+/**
+ * struct ns_tree - Namespace tree
+ * @ns_tree: Rbtree of namespaces of a particular type
+ * @ns_list: Sequentially walkable list of all namespaces of this type
+ * @ns_tree_lock: Seqlock to protect the tree and list
+ */
+struct ns_tree {
+	struct rb_root ns_tree;
+	struct list_head ns_list;
+	seqlock_t ns_tree_lock;
+	int type;
+};
+
+extern struct ns_tree cgroup_ns_tree;
+extern struct ns_tree ipc_ns_tree;
+extern struct ns_tree mnt_ns_tree;
+extern struct ns_tree net_ns_tree;
+extern struct ns_tree pid_ns_tree;
+extern struct ns_tree time_ns_tree;
+extern struct ns_tree user_ns_tree;
+extern struct ns_tree uts_ns_tree;
+
+#define to_ns_tree(__ns)					\
+	_Generic((__ns),					\
+		struct cgroup_namespace *: &(cgroup_ns_tree),	\
+		struct ipc_namespace *:    &(ipc_ns_tree),	\
+		struct net *:              &(net_ns_tree),	\
+		struct pid_namespace *:    &(pid_ns_tree),	\
+		struct mnt_namespace *:    &(mnt_ns_tree),	\
+		struct time_namespace *:   &(time_ns_tree),	\
+		struct user_namespace *:   &(user_ns_tree),	\
+		struct uts_namespace *:    &(uts_ns_tree))
+
+u64 ns_tree_gen_id(struct ns_common *ns);
+void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree);
+void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree);
+struct ns_common *ns_tree_lookup_rcu(u64 ns_id, int ns_type);
+struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
+					 struct ns_tree *ns_tree,
+					 bool previous);
+
+static inline void __ns_tree_add(struct ns_common *ns, struct ns_tree *ns_tree)
+{
+	ns_tree_gen_id(ns);
+	__ns_tree_add_raw(ns, ns_tree);
+}
+
+/**
+ * ns_tree_add_raw - Add a namespace to a namespace
+ * @ns: Namespace to add
+ *
+ * This function adds a namespace to the appropriate namespace tree
+ * without assigning a id.
+ */
+#define ns_tree_add_raw(__ns) __ns_tree_add_raw(to_ns_common(__ns), to_ns_tree(__ns))
+
+/**
+ * ns_tree_add - Add a namespace to a namespace tree
+ * @ns: Namespace to add
+ *
+ * This function assigns a new id to the namespace and adds it to the
+ * appropriate namespace tree and list.
+ */
+#define ns_tree_add(__ns) __ns_tree_add(to_ns_common(__ns), to_ns_tree(__ns))
+
+/**
+ * ns_tree_remove - Remove a namespace from a namespace tree
+ * @ns: Namespace to remove
+ *
+ * This function removes a namespace from the appropriate namespace
+ * tree and list.
+ */
+#define ns_tree_remove(__ns)  __ns_tree_remove(to_ns_common(__ns), to_ns_tree(__ns))
+
+#define ns_tree_adjoined_rcu(__ns, __previous) \
+	__ns_tree_adjoined_rcu(to_ns_common(__ns), to_ns_tree(__ns), __previous)
+
+#endif /* _LINUX_NSTREE_H */
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index e50d312f9fee..7f89f0829e60 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -79,6 +79,9 @@ static inline int ns_common_init(struct ns_common *ns,
 	refcount_set(&ns->count, 1);
 	ns->stashed = NULL;
 	ns->ops = ops;
+	ns->ns_id = 0;
+	RB_CLEAR_NODE(&ns->ns_tree_node);
+	INIT_LIST_HEAD(&ns->ns_list_node);
 	return 0;
 }
 
diff --git a/kernel/Makefile b/kernel/Makefile
index c60623448235..b807516a1b43 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -8,7 +8,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    sysctl.o capability.o ptrace.o user.o \
 	    signal.o sys.o umh.o workqueue.o pid.o task_work.o \
 	    extable.o params.o \
-	    kthread.o sys_ni.o nsproxy.o \
+	    kthread.o sys_ni.o nsproxy.o nstree.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
 	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
 
diff --git a/kernel/nstree.c b/kernel/nstree.c
new file mode 100644
index 000000000000..bbe8bedc924c
--- /dev/null
+++ b/kernel/nstree.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/nstree.h>
+#include <linux/proc_ns.h>
+#include <linux/vfsdebug.h>
+
+struct ns_tree mnt_ns_tree = {
+	.ns_tree = RB_ROOT,
+	.ns_list = LIST_HEAD_INIT(mnt_ns_tree.ns_list),
+	.ns_tree_lock = __SEQLOCK_UNLOCKED(mnt_ns_tree.ns_tree_lock),
+	.type = CLONE_NEWNS,
+};
+
+struct ns_tree net_ns_tree = {
+	.ns_tree = RB_ROOT,
+	.ns_list = LIST_HEAD_INIT(net_ns_tree.ns_list),
+	.ns_tree_lock = __SEQLOCK_UNLOCKED(net_ns_tree.ns_tree_lock),
+	.type = CLONE_NEWNET,
+};
+EXPORT_SYMBOL_GPL(net_ns_tree);
+
+struct ns_tree uts_ns_tree = {
+	.ns_tree = RB_ROOT,
+	.ns_list = LIST_HEAD_INIT(uts_ns_tree.ns_list),
+	.ns_tree_lock = __SEQLOCK_UNLOCKED(uts_ns_tree.ns_tree_lock),
+	.type = CLONE_NEWUTS,
+};
+
+struct ns_tree user_ns_tree = {
+	.ns_tree = RB_ROOT,
+	.ns_list = LIST_HEAD_INIT(user_ns_tree.ns_list),
+	.ns_tree_lock = __SEQLOCK_UNLOCKED(user_ns_tree.ns_tree_lock),
+	.type = CLONE_NEWUSER,
+};
+
+struct ns_tree ipc_ns_tree = {
+	.ns_tree = RB_ROOT,
+	.ns_list = LIST_HEAD_INIT(ipc_ns_tree.ns_list),
+	.ns_tree_lock = __SEQLOCK_UNLOCKED(ipc_ns_tree.ns_tree_lock),
+	.type = CLONE_NEWIPC,
+};
+
+struct ns_tree pid_ns_tree = {
+	.ns_tree = RB_ROOT,
+	.ns_list = LIST_HEAD_INIT(pid_ns_tree.ns_list),
+	.ns_tree_lock = __SEQLOCK_UNLOCKED(pid_ns_tree.ns_tree_lock),
+	.type = CLONE_NEWPID,
+};
+
+struct ns_tree cgroup_ns_tree = {
+	.ns_tree = RB_ROOT,
+	.ns_list = LIST_HEAD_INIT(cgroup_ns_tree.ns_list),
+	.ns_tree_lock = __SEQLOCK_UNLOCKED(cgroup_ns_tree.ns_tree_lock),
+	.type = CLONE_NEWCGROUP,
+};
+
+struct ns_tree time_ns_tree = {
+	.ns_tree = RB_ROOT,
+	.ns_list = LIST_HEAD_INIT(time_ns_tree.ns_list),
+	.ns_tree_lock = __SEQLOCK_UNLOCKED(time_ns_tree.ns_tree_lock),
+	.type = CLONE_NEWTIME,
+};
+
+DEFINE_COOKIE(namespace_cookie);
+
+static inline struct ns_common *node_to_ns(const struct rb_node *node)
+{
+	if (!node)
+		return NULL;
+	return rb_entry(node, struct ns_common, ns_tree_node);
+}
+
+static inline int ns_cmp(struct rb_node *a, const struct rb_node *b)
+{
+	struct ns_common *ns_a = node_to_ns(a);
+	struct ns_common *ns_b = node_to_ns(b);
+	u64 ns_id_a = ns_a->ns_id;
+	u64 ns_id_b = ns_b->ns_id;
+
+	if (ns_id_a < ns_id_b)
+		return -1;
+	if (ns_id_a > ns_id_b)
+		return 1;
+	return 0;
+}
+
+void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
+{
+	struct rb_node *node, *prev;
+
+	VFS_WARN_ON_ONCE(!ns->ns_id);
+
+	write_seqlock(&ns_tree->ns_tree_lock);
+
+	VFS_WARN_ON_ONCE(ns->ops->type != ns_tree->type);
+
+	node = rb_find_add_rcu(&ns->ns_tree_node, &ns_tree->ns_tree, ns_cmp);
+	/*
+	 * If there's no previous entry simply add it after the
+	 * head and if there is add it after the previous entry.
+	 */
+	prev = rb_prev(&ns->ns_tree_node);
+	if (!prev)
+		list_add_rcu(&ns->ns_list_node, &ns_tree->ns_list);
+	else
+		list_add_rcu(&ns->ns_list_node, &node_to_ns(prev)->ns_list_node);
+
+	write_sequnlock(&ns_tree->ns_tree_lock);
+
+	VFS_WARN_ON_ONCE(node);
+}
+
+void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree)
+{
+	VFS_WARN_ON_ONCE(RB_EMPTY_NODE(&ns->ns_tree_node));
+	VFS_WARN_ON_ONCE(list_empty(&ns->ns_list_node));
+	VFS_WARN_ON_ONCE(ns->ops->type != ns_tree->type);
+
+	write_seqlock(&ns_tree->ns_tree_lock);
+	rb_erase(&ns->ns_tree_node, &ns_tree->ns_tree);
+	list_bidir_del_rcu(&ns->ns_list_node);
+	RB_CLEAR_NODE(&ns->ns_tree_node);
+	write_sequnlock(&ns_tree->ns_tree_lock);
+}
+EXPORT_SYMBOL_GPL(__ns_tree_remove);
+
+static int ns_find(const void *key, const struct rb_node *node)
+{
+	const u64 ns_id = *(u64 *)key;
+	const struct ns_common *ns = node_to_ns(node);
+
+	if (ns_id < ns->ns_id)
+		return -1;
+	if (ns_id > ns->ns_id)
+		return 1;
+	return 0;
+}
+
+
+static struct ns_tree *ns_tree_from_type(int ns_type)
+{
+	switch (ns_type) {
+	case CLONE_NEWCGROUP:
+		return &cgroup_ns_tree;
+	case CLONE_NEWIPC:
+		return &ipc_ns_tree;
+	case CLONE_NEWNS:
+		return &mnt_ns_tree;
+	case CLONE_NEWNET:
+		return &net_ns_tree;
+	case CLONE_NEWPID:
+		return &pid_ns_tree;
+	case CLONE_NEWUSER:
+		return &user_ns_tree;
+	case CLONE_NEWUTS:
+		return &uts_ns_tree;
+	case CLONE_NEWTIME:
+		return &time_ns_tree;
+	}
+
+	return NULL;
+}
+
+struct ns_common *ns_tree_lookup_rcu(u64 ns_id, int ns_type)
+{
+	struct ns_tree *ns_tree;
+	struct rb_node *node;
+	unsigned int seq;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "suspicious ns_tree_lookup_rcu() usage");
+
+	ns_tree = ns_tree_from_type(ns_type);
+	if (!ns_tree)
+		return NULL;
+
+	do {
+		seq = read_seqbegin(&ns_tree->ns_tree_lock);
+		node = rb_find_rcu(&ns_id, &ns_tree->ns_tree, ns_find);
+		if (node)
+			break;
+	} while (read_seqretry(&ns_tree->ns_tree_lock, seq));
+
+	if (!node)
+		return NULL;
+
+	VFS_WARN_ON_ONCE(node_to_ns(node)->ops->type != ns_type);
+
+	return node_to_ns(node);
+}
+
+/**
+ * ns_tree_adjoined_rcu - find the next/previous namespace in the same
+ * tree
+ * @ns: namespace to start from
+ * @previous: if true find the previous namespace, otherwise the next
+ *
+ * Find the next or previous namespace in the same tree as @ns. If
+ * there is no next/previous namespace, -ENOENT is returned.
+ */
+struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
+					 struct ns_tree *ns_tree, bool previous)
+{
+	struct list_head *list;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "suspicious ns_tree_adjoined_rcu() usage");
+
+	if (previous)
+		list = rcu_dereference(list_bidir_prev_rcu(&ns->ns_list_node));
+	else
+		list = rcu_dereference(list_next_rcu(&ns->ns_list_node));
+	if (list_is_head(list, &ns_tree->ns_list))
+		return ERR_PTR(-ENOENT);
+
+	VFS_WARN_ON_ONCE(list_entry_rcu(list, struct ns_common, ns_list_node)->ops->type != ns_tree->type);
+
+	return list_entry_rcu(list, struct ns_common, ns_list_node);
+}
+
+/**
+ * ns_tree_gen_id - generate a new namespace id
+ * @ns: namespace to generate id for
+ *
+ * Generates a new namespace id and assigns it to the namespace. All
+ * namespaces types share the same id space and thus can be compared
+ * directly. IOW, when two ids of two namespace are equal, they are
+ * identical.
+ */
+u64 ns_tree_gen_id(struct ns_common *ns)
+{
+	guard(preempt)();
+	ns->ns_id = gen_cookie_next(&namespace_cookie);
+	return ns->ns_id;
+}

-- 
2.47.3


