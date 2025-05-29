Return-Path: <linux-kselftest+bounces-33976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAF1AC7687
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 05:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D85137A9972
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 03:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B524677B;
	Thu, 29 May 2025 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="GL+m5nYW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF520B7EC;
	Thu, 29 May 2025 03:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490107; cv=none; b=YitKsNHxDARvK3/CuMm3tut7dkq9JS+XlnDD18rIpT65NiKv4B69/Z8st5oqNzV7DgqqL6qREZpNOXJrV6gtnmj1Cn4TUQvyewI7hngwx0rBNHaw2jCtNwrbDchTjf/u1I/2KKVvPFII4my3lviI/SkyTCBm2u9J2bNPnVyIwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490107; c=relaxed/simple;
	bh=9Gi+p7NOWdUYlyOBzHRN/ipN/78Bvj8tyDqCPEfyIh4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fSTkEjdfyosotoDj+Dxx6+vx+DmJrexJ4f1w3mwzcFU2b7D6yNkY4EgRYHuAxU+SXPmT4Ck4iiNsDO50Jysw2QR7cq986sBfLb2co/8j6DJuuZvl7abQRgGEkt1lBUhO7HK25NmFRFR21zAlzrsDQOlBJE2cqzPpaq5MiQJIU+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=GL+m5nYW; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1748489792;
	bh=51cyRcS8pE0GQdR/zXBHt3aPgQac/BxEPQcY9bI9Ah8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GL+m5nYW9yX/A5xvqeBbSu4uVhYZPoLy7VEMyfxGL2hOsXsv1mrWXQaihzQHNUCy6
	 DSfos8WMB/8VKerdlE4rO3DRaBUza0pLtieQWoWOqGVMdfhlXipSQX9+Qa/TBsjBEb
	 5ZHNL0u/5ZeoROjLPx9Px3yo6sSHzulsd+yWUHB4=
Received: from NUC10.. ([39.156.73.10])
	by newxmesmtplogicsvrszgpua8-0.qq.com (NewEsmtp) with SMTP
	id 84C280DC; Thu, 29 May 2025 11:33:12 +0800
X-QQ-mid: xmsmtpt1748489592tsa3q4n7f
Message-ID: <tencent_2B46D7106B0DB285B4B2242FFB55685EF309@qq.com>
X-QQ-XMAILINFO: NwU6Bou9okj/gKz5AmlCKddnnW1+RtLu8QmoYcmy9g6COA5vTwShMU3Q1Ko0Ya
	 f4zqdfe1MSvIEazISSt7eLqbQGhnvcV9GsL+vCWJ3CKz3zvXk5nyZMeCMCqyF5bkgs92skz95sNZ
	 LD4cOnC24CW1ANVmf3/Ye3Hz8Otewo3Zy2drSuK2vvJwKBhEI5WH5eOlC6R/JgIAxBtaxb1h6RiE
	 i01QzsoBVQRh8Letozkx8fL8UA0CyNZppoIjf06MbZ0dbm2BtO/w7ARu9GKqe043ZaLat28rbobG
	 ONRWp/zWAVzB+wTP9jykGvpLrbm+wyQdRsurBH1q8oUCGMh9+7zYuqEg1lxafHhkZ51+yYyGgJ7R
	 TJMlgcx1flT6qoDJweFWXP1FJhUvRP9wc3fhkmD8FQXU0Awus8kpnBmt0LBw85P1Kow/I1eZQhGw
	 UTKdL1jhD6ckV9pYkUeFeDWqqfrqAlYR4V9t5tjstwvGxrjQQ7hFtdbwyUG2ZH/8BgODaLBasqZg
	 JMknZuHiOCioM4UU65PkSCcqLUgJblLL8OylNfFPLaeuGBgiVNso11WpNuUeqAcWycrWbUdZYbBr
	 UeNlI1i3lmlHq0kLVwxwcavFA1GnHI2GftwA9Ag0x/5npmawDvLnIJ3RWrtM5zFIANWUue6h3HyX
	 FaBQwyaTx0fAnGGJ0zOdd1yXBChpiv2XhTYplW0Wmj5FnpkfJNGZgaNkUe31BxkLbQxFjFIpgEDC
	 JJrMpqMwRUjdrWTzdSZAc3roJi9GBKcNiFOfYSNeIHLczgqOIDUB+HB7G5PEY4Zk6pfiF63xh5nE
	 hWjLGDmTzHtAfmH+MtINz/4ZfhjdPHqEwe7MSF7Afg3gUd/18vWoHPATYsdtWR6hPhNy3t6LQJNb
	 0zQVYYKf47qCX9YUK6nbHmp2YxrYxxga/+pZidfD59Ds6IBE2vumFln45Gegun/zmcjOZGVPEXSb
	 vfVbkmGlMEIvYaTkJPekgHwhpi+mnLR6JZLngH3hJHLE8eHYZfHzlxgXp12IDeMD3eEsKMC5qUC2
	 O6tWdpn2CG3Det6rHtIzfh3OyJVcCGFQcO+eQo7fgB+74/1IyT+FHggKIfqxM=
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add selftests for bpf_task_cwd_from_pid()
Date: Thu, 29 May 2025 11:32:50 +0800
X-OQ-MSGID: <78ba76a0749baaee94023a58bc1c3a8ba517afa3.1748488784.git.rtoax@foxmail.com>
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

Add some selftest testcases that validate the expected behavior of the
bpf_task_cwd_from_pid() kfunc that was added in the prior patch.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 .../selftests/bpf/prog_tests/task_kfunc.c     |  3 ++
 .../selftests/bpf/progs/task_kfunc_common.h   |  1 +
 .../selftests/bpf/progs/task_kfunc_success.c  | 47 +++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
index 83b90335967a..c18a0cb67164 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -149,6 +149,9 @@ static const char * const success_tests[] = {
 	"task_kfunc_acquire_trusted_walked",
 	"test_task_kfunc_flavor_relo",
 	"test_task_kfunc_flavor_relo_not_found",
+	"test_task_cwd_from_pid_arg",
+	"test_task_cwd_from_pid",
+	"test_task_cwd_from_pid_current",
 };
 
 static const char * const vpid_success_tests[] = {
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_common.h b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
index e9c4fea7a4bb..b762054a1825 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
@@ -24,6 +24,7 @@ struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
 void bpf_task_release(struct task_struct *p) __ksym;
 struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
 struct task_struct *bpf_task_from_vpid(s32 vpid) __ksym;
+int bpf_task_cwd_from_pid(s32 pid, char *buf, u32 buf_len) __ksym;
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
index 5fb4fc19d26a..6424cf5c151e 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -351,6 +351,53 @@ int BPF_PROG(test_task_from_pid_invalid, struct task_struct *task, u64 clone_fla
 	return 0;
 }
 
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_cwd_from_pid_arg, struct task_struct *task, u64 clone_flags)
+{
+	char cwd[256];
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	err = 0;
+	err += bpf_task_cwd_from_pid(task->pid, NULL, sizeof(cwd)) != -EINVAL;
+	err += bpf_task_cwd_from_pid(task->pid, cwd, 0) != -EINVAL;
+	err += bpf_task_cwd_from_pid(-1, cwd, sizeof(cwd)) != -ESRCH;
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_cwd_from_pid, struct task_struct *task, u64 clone_flags)
+{
+	char cwd[256];
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	err = bpf_task_cwd_from_pid(task->pid, cwd, sizeof(cwd));
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_task_cwd_from_pid_current, struct task_struct *task, u64 clone_flags)
+{
+	char cwd[128], cwd2[128];
+	struct task_struct *current;
+
+	if (!is_test_kfunc_task())
+		return 0;
+
+	current = bpf_get_current_task_btf();
+
+	err = 0;
+	err += bpf_task_cwd_from_pid(task->pid, cwd, sizeof(cwd));
+	err += bpf_task_cwd_from_pid(current->pid, cwd2, sizeof(cwd2));
+
+	err += bpf_strncmp(cwd, sizeof(cwd), cwd2) != 0;
+
+	return 0;
+}
+
 SEC("tp_btf/task_newtask")
 int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 clone_flags)
 {
-- 
2.49.0


