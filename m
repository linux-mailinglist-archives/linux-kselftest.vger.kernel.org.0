Return-Path: <linux-kselftest+bounces-33975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4980AC767A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 05:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B063A45C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 03:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B9F20E6F7;
	Thu, 29 May 2025 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="CbPH+b+m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6CF37160;
	Thu, 29 May 2025 03:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748489649; cv=none; b=jwWPZxHTaE/fF+hDkHgV5ahrYofxW6sTArKTG1n2DXjUsVAlpCyHJPzGlE9PksVa6cbvFEpXSXT6Y4CLpBh9YlX3efHdo6yt16sO5dqkLL43WsEWE+hO8kBsHJ1perc/354rgsw93j7mWBxrzXSCrWZ3yWSc5Oh1JhqHtg/+orI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748489649; c=relaxed/simple;
	bh=CBupvWDj+bp8c+zW9n63VQLzHs/I520TET911IbwSbY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=IoYUiozUh0NNlZ/q2zlXieiVfrzw3XyCUn1KLTNElBkv/+EK/BMuZtFeBiberh9q8wR+z5hA1ecR3FbvC4qIHubYhPCmKkhs4y4gZaOqF2qtD+Y7WDsXDnQkN4Jun4GM+DN4uFOJurMq4YFk1hNL4snSnVeg56XMsAN3J7NzVTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=CbPH+b+m; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1748489634;
	bh=0yxfgjZsIWQnTUAUtq7liyCcqoh9g0BEu9JK+IiDETg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CbPH+b+mfvJOlLDU+X4gv8iv/wxOVsJRnq97ZVJLhBswkb0BXU0+Hr/ZvzPcd0ifE
	 tN8nsGCFXL1YtlnUUDFdzceFsYYcLSDCKfoiTbtUlq1q6guWSNv5grQjp5uBxIbD7F
	 RIsha4f2wjaEeUqGTk6LtiTyAKAKWY/vx9aZkFJs=
Received: from NUC10.. ([39.156.73.10])
	by newxmesmtplogicsvrszgpua8-0.qq.com (NewEsmtp) with SMTP
	id 8293B21C; Thu, 29 May 2025 11:32:41 +0800
X-QQ-mid: xmsmtpt1748489561teyck2g0p
Message-ID: <tencent_97F8B56B340F51DB604B482FEBF012460505@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLGYxP4juhxZppL5xEnQkJZl/jDuQ+1KvyfyFpE1SifIj+1iHcPr
	 CerkoZOaWSmDclDEG/vhipekyH7tjamvBg94Hm5I13vVEWsqDAhDhVJp9Dft4s4t3dAGcmIjyHwE
	 tUkiytTHBzIgyqv98CkSQ260zuPMKNREBVvZ/ObMl0WU9H2K3AMCUM5LxTaUfm6YrJNZWRMxRwSx
	 0nPaDdZZt0sEa9Mvw/7I8HIp5gbkwe2nLUPKN8eIQNLbhXNjzjN3sQciWPqdVTAVa3vFc6fUp6Rj
	 j+KpJYdkLApLbDE3JroYsbTkM8ICao8tdLzh07b3EoXCjQeAO97H7lxWu1dhyTa9GhPJyqefgYuO
	 xfgSfrXfs54a1ZftUQLXjaJPWtVLCaP5jd27OpTcg2eNYDj2KyQny3kramdHr8ITn0gGfREA/g/j
	 bUbHjGeZu9iDW0vhf5pv6IE3NbS/roFK5CL9khZLibwtvJhVyYWt1lOg15bF44ygaHzb8jYE1WA3
	 3Rmnj3t6YTa1RrWRb66YAov6AERrGvJyqC0JAHRMaWOaS6V8eQhs8BQVoJCwn3cyeqJT9b9u7xqD
	 IymO8WkU50kUy/M6e6g3V6q2eZyzgPYn2a8nz2LY2ScvYPRhKOMiC61GGR3X6gOprHfG0B1Ocmge
	 nBL1kiz5UDUuC99i720N/OLTsFx00CQFCF9tUGsqcevfF4CBGe88cUA2R5QLXZ333cG1OEjpRyUb
	 p6cJc1Zdgcqse55albhvaTH54YT6+z0WKJEOFR/QQHhiIgxgVxckQofL8myivlEXnEoNROu1nkk+
	 L78BeeIyHDifRggkqnKYmccm9q259f9Au4x/DdAsmpw2aQp/kSCDfyJkCxAPQi+eAtG3GAZo+D/f
	 Kk8O3KW5WVUMq7vU3dUjv9l76O8qbapSZSvYEfCGF6UJNEFX/zyp8ZZMDwI/PNcyqTdGbKmHTJc2
	 tQWrDf5oQd6z2FdRKPjDhEdS/jx+ZaABaZwioqsZowAlxNXJGMpUYle09NgbaCnRCu/OBM2D+SFN
	 v6K0RPyWK0dS5ntiWddrTdTr7mFMLi6mIzFeevLnkb1Gdl4i5E
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Rong Tao <rtoax@foxmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: rtoax@foxmail.com,
	rongtao@cestc.cn,
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
	Juntong Deng <juntong.deng@outlook.com>,
	Amery Hung <amery.hung@bytedance.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	Hou Tao <houtao1@huawei.com>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next 1/2] bpf: Add bpf_task_cwd_from_pid() kfunc
Date: Thu, 29 May 2025 11:32:34 +0800
X-OQ-MSGID: <5af7a0a04f467df05d2e4cd54a0a7ebf396c3888.1748488784.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748488784.git.rtoax@foxmail.com>
References: <cover.1748488784.git.rtoax@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

It is a bit troublesome to get cwd based on pid in bpf program, such as
bpftrace example [1].

This patch therefore adds a new bpf_task_cwd_from_pid() kfunc which
allows BPF programs to get cwd from a pid.

[1] https://github.com/bpftrace/bpftrace/issues/3314

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b71e428ad936..0f32fbc997bb 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -24,6 +24,10 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
 #include <linux/bpf_verifier.h>
+#include <linux/fs.h>
+#include <linux/fs_struct.h>
+#include <linux/path.h>
+#include <linux/string.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -2643,6 +2647,46 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
 	return p;
 }
 
+/**
+ * bpf_task_cwd_from_pid - Get a task's absolute pathname of the current
+ * working directory from its pid.
+ * @pid: The pid of the task being looked up.
+ * @buf: The array pointed to by buf.
+ * @buf_len: buf length.
+ */
+__bpf_kfunc int bpf_task_cwd_from_pid(s32 pid, char *buf, u32 buf_len)
+{
+	struct path pwd;
+	char kpath[256], *path;
+	struct task_struct *task;
+
+	if (!buf || buf_len == 0)
+		return -EINVAL;
+
+	rcu_read_lock();
+	task = pid_task(find_vpid(pid), PIDTYPE_PID);
+	if (!task) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
+	task_lock(task);
+	if (!task->fs) {
+		task_unlock(task);
+		return -ENOENT;
+	}
+	get_fs_pwd(task->fs, &pwd);
+	task_unlock(task);
+	rcu_read_unlock();
+
+	path = d_path(&pwd, kpath, sizeof(kpath));
+	path_put(&pwd);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
+	strncpy(buf, path, buf_len);
+	return 0;
+}
+
 /**
  * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
  * @p: The dynptr whose data slice to retrieve
@@ -3314,6 +3358,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_cwd_from_pid, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
-- 
2.49.0


