Return-Path: <linux-kselftest+bounces-31033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52181A91250
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 06:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B5844486A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 04:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35151DE3BA;
	Thu, 17 Apr 2025 04:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y1CVEXUg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0F51DE2AD
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 04:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744865117; cv=none; b=QTco3XIfyHVaCiUMMVDCk69D3cyNb2WXo6CtgbCHFcBXUucBBds2E1oxIgyVhzFGXDcDElmBnDLhYRJIWmOvpeX5lCIOGJFXaMCfCqaa5qGFGQORpAhVrXPlXukyHPvBUTPacseXYaWSxIj/6+xlPhl4XjlY+OlcNI7TrfFjX/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744865117; c=relaxed/simple;
	bh=vPo4QG4NL53RR6IrS9918ebEYkZH/A2adH6XSD9ZW9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhoQMKz+auAJRdrTZM2XmAbMtuUIw0lwxIdByRJ764RbXhuD+w3SOrP/a3jDBn1uDKGTq8tJv2Xf3FSbS+CWzasHG5dCIk2KXLMCeI3r0uGDb0bazX2qFSHE6WWPdvI/K5D1+kENI5l1Jk6VzgoRXu17YlINc8ODbSVnwRL3VuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y1CVEXUg; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744865113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8KJjhl4HK3mOe4QIRQp+eto7y07QRFjVt0dMaj3rC4=;
	b=Y1CVEXUgT9cvB5fsp+8zrWAEUYCFxcGgNylQ+0wE3oic7bQPsnvdKPtIkJA5NysxlD0/9S
	8cT1zen56CJgRvIfbM+bXjyhvFTtgXy4os0PV6zK7Pg5gR/Iaf7CHBH7UsGLlyD1cSb0zd
	J485zZuX96j4S1ukw8NvpN3jXHZcldo=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: andrii@kernel.org,
	martin.lau@linux.dev,
	bpf@vger.kernel.org
Cc: alexis.lothore@bootlin.com,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+e6e8f6618a2d4b35e4e0@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 1/2] bpf: Create cgroup storage if needed when updating link
Date: Thu, 17 Apr 2025 12:40:14 +0800
Message-ID: <20250417044041.252874-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250417044041.252874-1-jiayuan.chen@linux.dev>
References: <20250417044041.252874-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

when we attach a prog without cgroup_storage map being used,
cgroup_storage in struct bpf_prog_array_item is empty. Then, if we use
BPF_LINK_UPDATE to replace old prog with a new one that uses the
cgroup_storage map, we miss cgroup_storage being initiated.

This cause a painc when accessing stroage in bpf_get_local_storage.

Reported-by: syzbot+e6e8f6618a2d4b35e4e0@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67fc867e.050a0220.2970f9.03b8.GAE@google.com/T/
Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/cgroup.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 84f58f3d028a..cdf0211ddc79 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -770,12 +770,14 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
 }
 
 /* Swap updated BPF program for given link in effective program arrays across
- * all descendant cgroups. This function is guaranteed to succeed.
+ * all descendant cgroups.
  */
-static void replace_effective_prog(struct cgroup *cgrp,
-				   enum cgroup_bpf_attach_type atype,
-				   struct bpf_cgroup_link *link)
+static int replace_effective_prog(struct cgroup *cgrp,
+				  enum cgroup_bpf_attach_type atype,
+				  struct bpf_cgroup_link *link)
 {
+	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_prog_array_item *item;
 	struct cgroup_subsys_state *css;
 	struct bpf_prog_array *progs;
@@ -784,6 +786,10 @@ static void replace_effective_prog(struct cgroup *cgrp,
 	struct cgroup *cg;
 	int pos;
 
+	if (bpf_cgroup_storages_alloc(storage, new_storage, link->type,
+				      link->link.prog, cgrp))
+		return -ENOMEM;
+
 	css_for_each_descendant_pre(css, &cgrp->self) {
 		struct cgroup *desc = container_of(css, struct cgroup, self);
 
@@ -810,8 +816,11 @@ static void replace_effective_prog(struct cgroup *cgrp,
 				desc->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
 		item = &progs->items[pos];
+		bpf_cgroup_storages_assign(item->cgroup_storage, storage);
 		WRITE_ONCE(item->prog, link->link.prog);
 	}
+	bpf_cgroup_storages_link(new_storage, cgrp, link->type);
+	return 0;
 }
 
 /**
@@ -833,6 +842,7 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	struct bpf_prog_list *pl;
 	struct hlist_head *progs;
 	bool found = false;
+	int err;
 
 	atype = bpf_cgroup_atype_find(link->type, new_prog->aux->attach_btf_id);
 	if (atype < 0)
@@ -853,7 +863,11 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 		return -ENOENT;
 
 	old_prog = xchg(&link->link.prog, new_prog);
-	replace_effective_prog(cgrp, atype, link);
+	err = replace_effective_prog(cgrp, atype, link);
+	if (err) {
+		xchg(&link->link.prog, old_prog);
+		return err;
+	}
 	bpf_prog_put(old_prog);
 	return 0;
 }
-- 
2.47.1


