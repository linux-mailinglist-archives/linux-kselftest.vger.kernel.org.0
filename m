Return-Path: <linux-kselftest+bounces-30437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67749A82A62
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 17:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD5D16A762
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B07F266B5D;
	Wed,  9 Apr 2025 15:26:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B593265CC5;
	Wed,  9 Apr 2025 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212360; cv=none; b=VhtWGUSCCE4xGFwCdUXqfdoLvuEHlP6YumYT+nLwjktEWeRHiSlGwva0JQKbsfwJ7DpNGFdk7HkSHHstpslnH1+YMZ6MPt1IVP11Cg3lEew8nHKX9+0TArP4p7hwsP6OHTrR5gfI8rKUQOEPOYuaab+Or+g5bugswuZ4EMPr1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212360; c=relaxed/simple;
	bh=51F0DtuayzHOauwLmTEGkxYdXj8m7ICSLVhNdNS0ZEA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LD0ymFDI2cVGIff0/hg7smS85QjSjEnBrFq4l2KQe7YEq9dsMetha9VhtdiOwlP0uLDBNURJnN6zvrV7t3icfLHvVEpv7MfnG+3mQ5xM5uLp00l6Bq56OV+Yfa8eBTMEwAEqxXnTal2yEeRx730niZPSpeDuQGQ6uJUUDzH6QQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D173C4CEE2;
	Wed,  9 Apr 2025 15:26:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u2XKi-00000008kR5-1VuI;
	Wed, 09 Apr 2025 11:27:20 -0400
Message-ID: <20250409152720.216356767@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 09 Apr 2025 11:15:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org,
 Andy Chiu <andybnac@gmail.com>
Subject: [PATCH 1/2] ftrace: Fix accounting of subop hashes
References: <20250409151549.788068911@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function graph infrastructure uses ftrace to hook to functions. It has
a single ftrace_ops to manage all the users of function graph. Each
individual user (tracing, bpf, fprobes, etc) has its own ftrace_ops to
track the functions it will have its callback called from. These
ftrace_ops are "subops" to the main ftrace_ops of the function graph
infrastructure.

Each ftrace_ops has a filter_hash and a notrace_hash that is defined as:

  Only trace functions that are in the filter_hash but not in the
  notrace_hash.

If the filter_hash is empty, it means to trace all functions.
If the notrace_hash is empty, it means do not disable any function.

The function graph main ftrace_ops needs to be a superset containing all
the functions to be traced by all the subops it has. The algorithm to
perform this merge was incorrect.

When the first subops was added to the main ops, it simply made the main
ops a copy of the subops (same filter_hash and notrace_hash).

When a second ops was added, it joined the new subops filter_hash with the
main ops filter_hash as a union of the two sets. The intersect between the
new subops notrace_hash and the main ops notrace_hash was created as the
new notrace_hash of the main ops.

The issue here is that it would then start tracing functions than no
subops were tracing. For example if you had two subops that had:

subops 1:

  filter_hash = '*sched*' # trace all functions with "sched" in it
  notrace_hash = '*time*' # except do not trace functions with "time"

subops 2:

  filter_hash = '*lock*' # trace all functions with "lock" in it
  notrace_hash = '*clock*' # except do not trace functions with "clock"

The intersect of '*time*' functions with '*clock*' functions could be the
empty set. That means the main ops will be tracing all functions with
'*time*' and all "*clock*" in it!

Instead, modify the algorithm to be a bit simpler and correct.

First, when adding a new subops, even if it's the first one, do not add
the notrace_hash if the filter_hash is not empty. Instead, just add the
functions that are in the filter_hash of the subops but not in the
notrace_hash of the subops into the main ops filter_hash. There's no
reason to add anything to the main ops notrace_hash.

The notrace_hash of the main ops should only be non empty iff all subops
filter_hashes are empty (meaning to trace all functions) and all subops
notrace_hashes include the same functions.

That is, the main ops notrace_hash is empty if any subops filter_hash is
non empty.

The main ops notrace_hash only has content in it if all subops
filter_hashes are empty, and the content are only functions that intersect
all the subops notrace_hashes. If any subops notrace_hash is empty, then
so is the main ops notrace_hash.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 314 ++++++++++++++++++++++++------------------
 1 file changed, 177 insertions(+), 137 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c33b126f75a1..8d55401bab22 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3255,6 +3255,31 @@ static int append_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash,
 	return 0;
 }
 
+/*
+ * Remove functions from @hash that are in @notrace_hash
+ */
+static void remove_hash(struct ftrace_hash *hash, struct ftrace_hash *notrace_hash)
+{
+	struct ftrace_func_entry *entry;
+	struct hlist_node *tmp;
+	int size;
+	int i;
+
+	/* If the notrace hash is empty, there's nothing to do */
+	if (ftrace_hash_empty(notrace_hash))
+		return;
+
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry_safe(entry, tmp, &hash->buckets[i], hlist) {
+			if (!__ftrace_lookup_ip(notrace_hash, entry->ip))
+				continue;
+			remove_hash_entry(hash, entry);
+			kfree(entry);
+		}
+	}
+}
+
 /*
  * Add to @hash only those that are in both @new_hash1 and @new_hash2
  *
@@ -3295,67 +3320,6 @@ static int intersect_hash(struct ftrace_hash **hash, struct ftrace_hash *new_has
 	return 0;
 }
 
-/* Return a new hash that has a union of all @ops->filter_hash entries */
-static struct ftrace_hash *append_hashes(struct ftrace_ops *ops)
-{
-	struct ftrace_hash *new_hash = NULL;
-	struct ftrace_ops *subops;
-	int size_bits;
-	int ret;
-
-	if (ops->func_hash->filter_hash)
-		size_bits = ops->func_hash->filter_hash->size_bits;
-	else
-		size_bits = FTRACE_HASH_DEFAULT_BITS;
-
-	list_for_each_entry(subops, &ops->subop_list, list) {
-		ret = append_hash(&new_hash, subops->func_hash->filter_hash, size_bits);
-		if (ret < 0) {
-			free_ftrace_hash(new_hash);
-			return NULL;
-		}
-		/* Nothing more to do if new_hash is empty */
-		if (ftrace_hash_empty(new_hash))
-			break;
-	}
-	/* Can't return NULL as that means this failed */
-	return new_hash ? : EMPTY_HASH;
-}
-
-/* Make @ops trace evenything except what all its subops do not trace */
-static struct ftrace_hash *intersect_hashes(struct ftrace_ops *ops)
-{
-	struct ftrace_hash *new_hash = NULL;
-	struct ftrace_ops *subops;
-	int size_bits;
-	int ret;
-
-	list_for_each_entry(subops, &ops->subop_list, list) {
-		struct ftrace_hash *next_hash;
-
-		if (!new_hash) {
-			size_bits = subops->func_hash->notrace_hash->size_bits;
-			new_hash = alloc_and_copy_ftrace_hash(size_bits, ops->func_hash->notrace_hash);
-			if (!new_hash)
-				return NULL;
-			continue;
-		}
-		size_bits = new_hash->size_bits;
-		next_hash = new_hash;
-		new_hash = alloc_ftrace_hash(size_bits);
-		ret = intersect_hash(&new_hash, next_hash, subops->func_hash->notrace_hash);
-		free_ftrace_hash(next_hash);
-		if (ret < 0) {
-			free_ftrace_hash(new_hash);
-			return NULL;
-		}
-		/* Nothing more to do if new_hash is empty */
-		if (ftrace_hash_empty(new_hash))
-			break;
-	}
-	return new_hash;
-}
-
 static bool ops_equal(struct ftrace_hash *A, struct ftrace_hash *B)
 {
 	struct ftrace_func_entry *entry;
@@ -3427,6 +3391,93 @@ static int ftrace_update_ops(struct ftrace_ops *ops, struct ftrace_hash *filter_
 	return 0;
 }
 
+static int add_first_hash(struct ftrace_hash **filter_hash, struct ftrace_hash **notrace_hash,
+			  struct ftrace_ops_hash *func_hash)
+{
+	/* If the filter hash is not empty, simply remove the nohash from it */
+	if (!ftrace_hash_empty(func_hash->filter_hash)) {
+		*filter_hash = copy_hash(func_hash->filter_hash);
+		if (!*filter_hash)
+			return -ENOMEM;
+		remove_hash(*filter_hash, func_hash->notrace_hash);
+		*notrace_hash = EMPTY_HASH;
+
+	} else {
+		*notrace_hash = copy_hash(func_hash->notrace_hash);
+		if (!*notrace_hash)
+			return -ENOMEM;
+		*filter_hash = EMPTY_HASH;
+	}
+	return 0;
+}
+
+static int add_next_hash(struct ftrace_hash **filter_hash, struct ftrace_hash **notrace_hash,
+			 struct ftrace_ops_hash *ops_hash, struct ftrace_ops_hash *subops_hash)
+{
+	int size_bits;
+	int ret;
+
+	/* If the subops trace all functions so must the main ops */
+	if (ftrace_hash_empty(ops_hash->filter_hash) ||
+	    ftrace_hash_empty(subops_hash->filter_hash)) {
+		*filter_hash = EMPTY_HASH;
+	} else {
+		/*
+		 * The main ops filter hash is not empty, so its
+		 * notrace_hash had better be, as the notrace hash
+		 * is only used for empty main filter hashes.
+		 */
+		WARN_ON_ONCE(!ftrace_hash_empty(ops_hash->notrace_hash));
+
+		size_bits = max(ops_hash->filter_hash->size_bits,
+				subops_hash->filter_hash->size_bits);
+
+		/* Copy the subops hash */
+		*filter_hash = alloc_and_copy_ftrace_hash(size_bits, subops_hash->filter_hash);
+		if (!filter_hash)
+			return -ENOMEM;
+		/* Remove any notrace functions from the copy */
+		remove_hash(*filter_hash, subops_hash->notrace_hash);
+
+		ret = append_hash(filter_hash, ops_hash->filter_hash,
+				  size_bits);
+		if (ret < 0) {
+			free_ftrace_hash(*filter_hash);
+			return ret;
+		}
+	}
+
+	/*
+	 * Only process notrace hashes if the main filter hash is empty
+	 * (tracing all functions), otherwise the filter hash will just
+	 * remove the notrace hash functions, and the notrace hash is
+	 * not needed.
+	 */
+	if (ftrace_hash_empty(*filter_hash)) {
+		/*
+		 * Intersect the notrace functions. That is, if two
+		 * subops are not tracing a set of functions, the
+		 * main ops will only not trace the functions that are
+		 * in both subops, but has to trace the functions that
+		 * are only notrace in one of the subops, for the other
+		 * subops to be able to trace them.
+		 */
+		size_bits = max(ops_hash->notrace_hash->size_bits,
+				subops_hash->notrace_hash->size_bits);
+		*notrace_hash = alloc_ftrace_hash(size_bits);
+		if (!*notrace_hash)
+			return -ENOMEM;
+
+		ret = intersect_hash(notrace_hash, ops_hash->notrace_hash,
+				     subops_hash->notrace_hash);
+		if (ret < 0) {
+			free_ftrace_hash(*notrace_hash);
+			return ret;
+		}
+	}
+	return 0;
+}
+
 /**
  * ftrace_startup_subops - enable tracing for subops of an ops
  * @ops: Manager ops (used to pick all the functions of its subops)
@@ -3443,7 +3494,6 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
 	struct ftrace_hash *notrace_hash;
 	struct ftrace_hash *save_filter_hash;
 	struct ftrace_hash *save_notrace_hash;
-	int size_bits;
 	int ret;
 
 	if (unlikely(ftrace_disabled))
@@ -3467,14 +3517,14 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
 
 	/* For the first subops to ops just enable it normally */
 	if (list_empty(&ops->subop_list)) {
-		/* Just use the subops hashes */
-		filter_hash = copy_hash(subops->func_hash->filter_hash);
-		notrace_hash = copy_hash(subops->func_hash->notrace_hash);
-		if (!filter_hash || !notrace_hash) {
-			free_ftrace_hash(filter_hash);
-			free_ftrace_hash(notrace_hash);
-			return -ENOMEM;
-		}
+
+		/* The ops was empty, should have empty hashes */
+		WARN_ON_ONCE(!ftrace_hash_empty(ops->func_hash->filter_hash));
+		WARN_ON_ONCE(!ftrace_hash_empty(ops->func_hash->notrace_hash));
+
+		ret = add_first_hash(&filter_hash, &notrace_hash, subops->func_hash);
+		if (ret < 0)
+			return ret;
 
 		save_filter_hash = ops->func_hash->filter_hash;
 		save_notrace_hash = ops->func_hash->notrace_hash;
@@ -3500,48 +3550,16 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
 
 	/*
 	 * Here there's already something attached. Here are the rules:
-	 *   o If either filter_hash is empty then the final stays empty
-	 *      o Otherwise, the final is a superset of both hashes
-	 *   o If either notrace_hash is empty then the final stays empty
-	 *      o Otherwise, the final is an intersection between the hashes
+	 *   If the new subops and main ops filter hashes are not empty:
+	 *     o Make a copy of the subops filter hash
+	 *     o Remove all functions in the nohash from it.
+	 *     o Add in the main hash filter functions
+	 *     o Remove any of these functions from the main notrace hash
 	 */
-	if (ftrace_hash_empty(ops->func_hash->filter_hash) ||
-	    ftrace_hash_empty(subops->func_hash->filter_hash)) {
-		filter_hash = EMPTY_HASH;
-	} else {
-		size_bits = max(ops->func_hash->filter_hash->size_bits,
-				subops->func_hash->filter_hash->size_bits);
-		filter_hash = alloc_and_copy_ftrace_hash(size_bits, ops->func_hash->filter_hash);
-		if (!filter_hash)
-			return -ENOMEM;
-		ret = append_hash(&filter_hash, subops->func_hash->filter_hash,
-				  size_bits);
-		if (ret < 0) {
-			free_ftrace_hash(filter_hash);
-			return ret;
-		}
-	}
 
-	if (ftrace_hash_empty(ops->func_hash->notrace_hash) ||
-	    ftrace_hash_empty(subops->func_hash->notrace_hash)) {
-		notrace_hash = EMPTY_HASH;
-	} else {
-		size_bits = max(ops->func_hash->notrace_hash->size_bits,
-				subops->func_hash->notrace_hash->size_bits);
-		notrace_hash = alloc_ftrace_hash(size_bits);
-		if (!notrace_hash) {
-			free_ftrace_hash(filter_hash);
-			return -ENOMEM;
-		}
-
-		ret = intersect_hash(&notrace_hash, ops->func_hash->notrace_hash,
-				     subops->func_hash->notrace_hash);
-		if (ret < 0) {
-			free_ftrace_hash(filter_hash);
-			free_ftrace_hash(notrace_hash);
-			return ret;
-		}
-	}
+	ret = add_next_hash(&filter_hash, &notrace_hash, ops->func_hash, subops->func_hash);
+	if (ret < 0)
+		return ret;
 
 	list_add(&subops->list, &ops->subop_list);
 
@@ -3557,6 +3575,42 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
 	return ret;
 }
 
+static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash **notrace_hash,
+			  struct ftrace_ops *ops)
+{
+	struct ftrace_ops_hash temp_hash;
+	struct ftrace_ops *subops;
+	bool first = true;
+	int ret;
+
+	temp_hash.filter_hash = EMPTY_HASH;
+	temp_hash.notrace_hash = EMPTY_HASH;
+
+	list_for_each_entry(subops, &ops->subop_list, list) {
+		*filter_hash = EMPTY_HASH;
+		*notrace_hash = EMPTY_HASH;
+
+		if (first) {
+			ret = add_first_hash(filter_hash, notrace_hash, subops->func_hash);
+			if (ret < 0)
+				return ret;
+			first = false;
+		} else {
+			ret = add_next_hash(filter_hash, notrace_hash,
+					    &temp_hash, subops->func_hash);
+			if (ret < 0) {
+				free_ftrace_hash(temp_hash.filter_hash);
+				free_ftrace_hash(temp_hash.notrace_hash);
+				return ret;
+			}
+		}
+
+		temp_hash.filter_hash = *filter_hash;
+		temp_hash.notrace_hash = *notrace_hash;
+	}
+	return 0;
+}
+
 /**
  * ftrace_shutdown_subops - Remove a subops from a manager ops
  * @ops: A manager ops to remove @subops from
@@ -3605,14 +3659,9 @@ int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, in
 	}
 
 	/* Rebuild the hashes without subops */
-	filter_hash = append_hashes(ops);
-	notrace_hash = intersect_hashes(ops);
-	if (!filter_hash || !notrace_hash) {
-		free_ftrace_hash(filter_hash);
-		free_ftrace_hash(notrace_hash);
-		list_add(&subops->list, &ops->subop_list);
-		return -ENOMEM;
-	}
+	ret = rebuild_hashes(&filter_hash, &notrace_hash, ops);
+	if (ret < 0)
+		return ret;
 
 	ret = ftrace_update_ops(ops, filter_hash, notrace_hash);
 	if (ret < 0) {
@@ -3628,11 +3677,11 @@ int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, in
 
 static int ftrace_hash_move_and_update_subops(struct ftrace_ops *subops,
 					      struct ftrace_hash **orig_subhash,
-					      struct ftrace_hash *hash,
-					      int enable)
+					      struct ftrace_hash *hash)
 {
 	struct ftrace_ops *ops = subops->managed;
-	struct ftrace_hash **orig_hash;
+	struct ftrace_hash *notrace_hash;
+	struct ftrace_hash *filter_hash;
 	struct ftrace_hash *save_hash;
 	struct ftrace_hash *new_hash;
 	int ret;
@@ -3649,24 +3698,15 @@ static int ftrace_hash_move_and_update_subops(struct ftrace_ops *subops,
 		return -ENOMEM;
 	}
 
-	/* Create a new_hash to hold the ops new functions */
-	if (enable) {
-		orig_hash = &ops->func_hash->filter_hash;
-		new_hash = append_hashes(ops);
-	} else {
-		orig_hash = &ops->func_hash->notrace_hash;
-		new_hash = intersect_hashes(ops);
-	}
-
-	/* Move the hash over to the new hash */
-	ret = __ftrace_hash_move_and_update_ops(ops, orig_hash, new_hash, enable);
-
-	free_ftrace_hash(new_hash);
+	ret = rebuild_hashes(&filter_hash, &notrace_hash, ops);
+	if (!ret)
+		ret = ftrace_update_ops(ops, filter_hash, notrace_hash);
 
 	if (ret) {
 		/* Put back the original hash */
-		free_ftrace_hash_rcu(*orig_subhash);
+		new_hash = *orig_subhash;
 		*orig_subhash = save_hash;
+		free_ftrace_hash_rcu(new_hash);
 	} else {
 		free_ftrace_hash_rcu(save_hash);
 	}
@@ -4926,7 +4966,7 @@ static int ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
 					   int enable)
 {
 	if (ops->flags & FTRACE_OPS_FL_SUBOP)
-		return ftrace_hash_move_and_update_subops(ops, orig_hash, hash, enable);
+		return ftrace_hash_move_and_update_subops(ops, orig_hash, hash);
 
 	/*
 	 * If this ops is not enabled, it could be sharing its filters
@@ -4945,7 +4985,7 @@ static int ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
 			list_for_each_entry(subops, &op->subop_list, list) {
 				if ((subops->flags & FTRACE_OPS_FL_ENABLED) &&
 				     subops->func_hash == ops->func_hash) {
-					return ftrace_hash_move_and_update_subops(subops, orig_hash, hash, enable);
+					return ftrace_hash_move_and_update_subops(subops, orig_hash, hash);
 				}
 			}
 		} while_for_each_ftrace_op(op);
-- 
2.47.2



