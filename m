Return-Path: <linux-kselftest+bounces-34362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0145ACEC59
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 10:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0391896E3A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94DD1FDE39;
	Thu,  5 Jun 2025 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="sHN411Tb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9566C1DFE12;
	Thu,  5 Jun 2025 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749113512; cv=none; b=SOZ7o6r52Owf8jVDfTXzCytbJrbQSfUCnh0XPq/Wqi79V9MVEO5cN11S+W7Hipf1p9LN3yI7LrA6garLbXkK85kcstq5m4YclSYu1CDQKi5CIyUY2GCuFQfOz6HfFIL9xqJs++/sKx+rD+K+0kITaYlAA7pkui3K9KRos0Cv6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749113512; c=relaxed/simple;
	bh=DmWtOysdA0Nmoh/X3y+VMEQ694VNJeZDCcbZ+gNbVPU=;
	h=Message-ID:From:To:Subject:Date:MIME-Version; b=gV5/ZTR65nMtd9Yq4yrRbFLTR43QN9VZM0gO7713MRoyKovyuKPHmMJNHfGfol+Kmizllc5/fc9X3bVqz+LyRoV2zLNWkV1/yOqFX53u3qcmUshuPQOXeqGvHyuayMI1mBNFsdFDGojWxUlKlJ8dJQtV8CxLPS8FZ+dxXvG/dkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=sHN411Tb; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1749113503;
	bh=Ns6Z7O8rmMKISC4J3f9FZ4mWtQOdi3wfP7xqU/uLv1o=;
	h=From:To:Subject:Date;
	b=sHN411TbxK859SJhTjstwxDSuMym9RTVjToryz7HvJnHrDoc3E+uvuffdcJla7aUv
	 l1ybSgblwGQK+zMPc2/hYQ4LXk/wz3QHuSz/mhpoxQZHVW5zHrQ5fm8gMS9X6PSvXI
	 z5/bOQFtIIjvvC6x7nBE0NKpEgMbVXIyut8J4uao=
Received: from NUC10.. ([39.156.73.10])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id B51A7CC6; Thu, 05 Jun 2025 16:45:17 +0800
X-QQ-mid: xmsmtpt1749113117tqk3sbk1c
Message-ID: <tencent_3DD7405C0839EBE2724AC5FA357B5402B105@qq.com>
X-QQ-XMAILINFO: NFB6T0Z6Ys1E1T8LRCAA3Q5cCT745Of5aONkg7N3j82TuaUg4mVTA3qD1h39FH
	 rFl7K8LOKeiXnbBQR3BZHn1EZCted/XMYS1CQsX/jB2sdX8m3gdmbsjHCmhq5L9rPa1nljn7FZCa
	 FHahyWmgr+e5UCSTkAVdq2H/gQnn7rbVbKVlx9jVFIf4vO3XE7KD2LkABTWB0+5RVG0ZRN2p5GJw
	 zb1REP4WCl8Cb2t4HkaSDKWTlSnAKMcaBWJFZO3xZeEU3ZMnZgR3wgeaq7deGE9BraznIi8mtzJL
	 MJeYx2H21zxqLWBLj/LuMg6hyfqJsz/xUo9w7z1iUkhlvOtvsFxtJQ6JtXZPJwTHqX66gwyG18kZ
	 lv0W+mcmMxlR43yGCfk38Wuqqn3AOFjr6vv61/kY0ini5UmUgxanb567xpWYZ78jzl5V33lu0x8v
	 0rYwSRuYAKqJUjXWVfJQxJjPmf3vIbz74kmJhOi0PaU45hV2vYWmHktHMm8zoNfAfoLqrpMRxEuK
	 IZGeTnnaa83RHffw2h5jrl/7OTUa7yPWkESmE0VeUyPIkoYq5nKZGjDgUJSL/aUS9I3PYa8LcGcH
	 +c8akGjwRtmnwV9gcicH5PsoufybTB+2NefLATGMkxGjT7qk2MktpZCUbzLbMbgsL7jYyglDMVJ4
	 svnz7x+y2wNjwSkrnYtkKALosKTtgn+kuitt6GBcbM3e/KZqrNp0h12YAArS/V42RK2vXJYGXAW2
	 l03VsRVTsXn0qJ8MZlaF8XEIIH/W2/b/yuk6Y0aTJgc2QofraBuScScZ74ti7Syx1fJizxkUapcM
	 hEeEeySVpcUMxDIIsPsCX2QwV4Vg8b8ULHrWO6D8+I3KAISIN7jTuJ5VmBvpdF3WPGxZwn341STz
	 HMxoN2MegXFbR2c85UvvZLIBKg/PM617djQ2BxDkp9XlMBzG212meGt43qMTz9KkNmvz8n8hfGfo
	 7szGmWIBhWlIP2Rho/4EBr4T13supbNEIRoSspWTE=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Rong Tao <rtoax@foxmail.com>
To: rongtao@cestc.cn,
	rtoax@foxmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
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
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] selftests/bpf: rbtree: Fix incorrect global variable usage
Date: Thu,  5 Jun 2025 16:45:14 +0800
X-OQ-MSGID: <20250605084516.287041-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Within __add_three() function, should use function parameters instead of
global variables. So that the variables groot_nested.inner.root and
groot_nested.inner.glock in rbtree_add_nodes_nested() are tested
correctly.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/progs/rbtree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/rbtree.c b/tools/testing/selftests/bpf/progs/rbtree.c
index a3620c15c136..49fe93d7e059 100644
--- a/tools/testing/selftests/bpf/progs/rbtree.c
+++ b/tools/testing/selftests/bpf/progs/rbtree.c
@@ -61,19 +61,19 @@ static long __add_three(struct bpf_rb_root *root, struct bpf_spin_lock *lock)
 	}
 	m->key = 1;
 
-	bpf_spin_lock(&glock);
-	bpf_rbtree_add(&groot, &n->node, less);
-	bpf_rbtree_add(&groot, &m->node, less);
-	bpf_spin_unlock(&glock);
+	bpf_spin_lock(lock);
+	bpf_rbtree_add(root, &n->node, less);
+	bpf_rbtree_add(root, &m->node, less);
+	bpf_spin_unlock(lock);
 
 	n = bpf_obj_new(typeof(*n));
 	if (!n)
 		return 3;
 	n->key = 3;
 
-	bpf_spin_lock(&glock);
-	bpf_rbtree_add(&groot, &n->node, less);
-	bpf_spin_unlock(&glock);
+	bpf_spin_lock(lock);
+	bpf_rbtree_add(root, &n->node, less);
+	bpf_spin_unlock(lock);
 	return 0;
 }
 
-- 
2.49.0


