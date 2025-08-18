Return-Path: <linux-kselftest+bounces-39211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ED8B29D2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 11:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48502188D166
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C6D30DD14;
	Mon, 18 Aug 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgp7sGp/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C32030C366;
	Mon, 18 Aug 2025 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507933; cv=none; b=NhsVVkutHmDbBybgYJgGsr0Ebkb5h1JZkgmVwv/VbbX2zYnf22CmcH8rmy7tdSn/ggRf1rW2EGJCUx/oWFDnyKOcmhhqKhTGVVFWZI5IoeO5naXKUeUZcqyXhx486x4j4+ZemqeaP0wKGzPIn0LqiiVE4NaRd0u5yLlzmbX8Rfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507933; c=relaxed/simple;
	bh=dNQ2xLxbkqhX/WGlb8xDDFkpcY/MPYzvRrHMPcRpf+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxzMMfQWlHVF/M04giLAYE4v+9ihzxwAVN/iRZfPXWTAH1u5HcBVp9RFJfdXpRtuwzhvpezwNsP1Rxg4e6d1Lu9l1w+yTGGQ/067q2voyXGf98I1Bg5nRV3WR7cp3h0vuo+tFI6T8DCv3J+wnmqSSGEXIiCjGQAhdvVifW5T0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tgp7sGp/; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e9321ed5e5eso2579143276.3;
        Mon, 18 Aug 2025 02:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755507931; x=1756112731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hz/z+SnaxoNL88nSulJaSHbf2jaz0dixFKHNOBcuqI0=;
        b=Tgp7sGp/QJUCN0YplwZY8hIrq7WJ1Gl0qhBYvKmF/xOy0zKzL7ZCkfk75mxukqo8Ij
         E9bjPlzb0hT/6VCv+K70+MT6PwSn94kToWwSnesRn955gVlJK+ipBJDLC7G9BcgdZqPF
         09o8P+RRk0MJGdtUUvA9boz+ABkZrlzECZ4f+sR52D/UZkTFzSb0AqMinma82ck7OkbI
         ASGU+oeVmmE+3IgB+JxIcYbtDp6ouYvGgjxPy63NdKIFZs7qBxdaWyZcK/kcx2I6/Ye4
         9OzJoQ5TCVfrslNFZRXj17nGh24ksoN9c4S72E+EXrlptAyBfhhfie+XmBVCEnsHAGIo
         9xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507931; x=1756112731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hz/z+SnaxoNL88nSulJaSHbf2jaz0dixFKHNOBcuqI0=;
        b=Gu0s0wAU+AaczBiYi4uBttic+AX4fDznoX/NIXnP+Ph/8uMRAqOnlzgrV4vSiy1tyT
         JVOvSVbx6TKiSMCcoV3kT5+gE3Dt0J7jUAfN878HcV+9jFfbOI8ZRt9WWy8x1OB1nlAp
         ZPsm1F95YlcEuLnpk/MmQdiA83M2vIeqXv1//Dk/uv66mlEPGU+KmF6OdEhN+W3br59A
         WBQej8DDnL+nFW9j6el7JYbRXlyoEKF3ouas/xHIFNd0mnpm3j8QiSlUwuvE1XvRnOkg
         CgiLZt6RCNcdSJtWWZn9UgyR2ZXwg1npt083CUs7bxIbh++4EVf0hOu+FTo6C9f+/sT7
         dq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXibDxK7QaElCPHr6B8b59MxS4N59NVi5/JaSqLVoZyZzDmuVuArKExrJj5n/LCl8M6jU=@vger.kernel.org, AJvYcCX/0sojyxna95FZKFVDNcDQHgy5OBAVmpyiAwYq3fQQVIPkvGd3M9IAn/vy3HhzCFf67amh0aGSfk0vkoahYG5F@vger.kernel.org, AJvYcCXk3PjfXx5KBzXuFdyX5+SrM/5RHoy2/+wncMkq8RpeGrnZgylb29U6DseAYEcc9ynWUU1V90BtVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj2ZObUYCTCA8QaobnkwC7gwb93wVuUq0b9kaZdgt2nlCKXL/h
	OOcfq9q4M349wGEj+ovPJ22GJDxhCABVqrQ3pm46l1BS1gq2Xd15k+ih
X-Gm-Gg: ASbGncv3UfpAQvzPZAy1EgL748kTwVLuXti32YLcqmPi5hjdFurZVLjsT1Rqj8SnbXw
	7s0OYEp0224X9Rl7aA0W9M5bUBs7cn0tZ6/2LBg8E7rwNrAVYnCL2T5ZDRjgV+c6NOQamrsWjxO
	4Mt2TLTeBWhNh6/vVEAGXxvTzhks25T6XbQGwrgtoVip4FhGTjrw5H7uDCN29z43H4s2oiTUrqq
	30KOna96IWPXdemVfPFtuSae0ojoayT/xAwr4X4JRXlVFV19hJo6C2p7SmPWA4xBPVYJQ/7/Cnl
	8Lro7nRzkiAqwiaKXo19DswFsXuWpglsUKxrr4p9hrFnl37CCK+2alLTjJQzHSi0M9l5LI8Ksk5
	g1mQ2xEh7ikKAP8eDzmay/G5d
X-Google-Smtp-Source: AGHT+IFMlWPnbh3tU493sus1xFHCbXLkD/uFBBLRKMrYXOGSIxGh/DrgYrNVQUJbgKTDhG/ZLbT50A==
X-Received: by 2002:a05:6902:6d02:b0:e8b:c3bf:ff92 with SMTP id 3f1490d57ef6-e93324afa94mr12614103276.30.1755507931014;
        Mon, 18 Aug 2025 02:05:31 -0700 (PDT)
Received: from roronoa.. ([146.70.98.176])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e933264aabcsm2985389276.9.2025.08.18.02.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:05:30 -0700 (PDT)
From: Djalal Harouni <tixxdz@gmail.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	tixxdz@opendz.org
Cc: Djalal Harouni <tixxdz@gmail.com>
Subject: [RFC PATCH v2 bpf-next 1/3] kernfs: cgroup: support writing cgroup interfaces from a kernfs node
Date: Mon, 18 Aug 2025 10:04:22 +0100
Message-ID: <20250818090424.90458-2-tixxdz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818090424.90458-1-tixxdz@gmail.com>
References: <20250818090424.90458-1-tixxdz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Freezing a cgroup of a task from BPF is better than user space which
could be too late and is subject to races. To achieve this allow writing to
cgroup core interfaces from BPF by adding a new kfunc helper that take a
kernfs node directly.

Currently only writing to "cgroup.freeze" on the default hierarchy is
allowed. The writing goes directly via a kernfs_node which allows to
share the same path as if a kernfs_node was opened from userspace.

Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
---
 include/linux/cgroup.h |   3 ++
 kernel/cgroup/cgroup.c | 102 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b18fb5fcb38e..03a0782c94bf 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -125,6 +125,9 @@ int cgroup_rm_cftypes(struct cftype *cfts);
 void cgroup_file_notify(struct cgroup_file *cfile);
 void cgroup_file_show(struct cgroup_file *cfile, bool show);
 
+ssize_t cgroup_kn_interface_write(struct kernfs_node *kn, const char *name__str,
+				  const char *buf, size_t nbytes, loff_t off);
+
 int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry);
 int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 		     struct pid *pid, struct task_struct *tsk);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..cddd7c1d354d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -229,6 +229,24 @@ static struct file_system_type cgroup2_fs_type;
 static struct cftype cgroup_base_files[];
 static struct cftype cgroup_psi_files[];
 
+struct cgroup_kn_cftype {
+	char name[MAX_CFTYPE_NAME];
+	unsigned int namelen;
+
+	/*
+	 * write() is the write operation on a kernfs node.
+	 */
+	ssize_t (*write)(struct kernfs_node *kn, const char *buf, size_t nbytes,
+			 loff_t off, bool revalidate);
+};
+
+#define CGROUP_PREFIX "cgroup."
+#define CGROUP_CORE_INTERFACE_FREEZE_SUFFIX "freeze"
+#define CGROUP_CORE_INTERFACE_FREEZE (CGROUP_PREFIX CGROUP_CORE_INTERFACE_FREEZE_SUFFIX)
+#define CGROUP_CORE_INTERFACE_FREEZE_LEN (sizeof(CGROUP_CORE_INTERFACE_FREEZE) - 1)
+
+static struct cgroup_kn_cftype kn_cfts[];
+
 /* cgroup optional features */
 enum cgroup_opt_features {
 #ifdef CONFIG_PSI
@@ -4030,29 +4048,58 @@ static int cgroup_freeze_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static ssize_t cgroup_freeze_write(struct kernfs_open_file *of,
-				   char *buf, size_t nbytes, loff_t off)
+static bool cgroup_kn_revalidate(struct cgroup *cgrp)
+{
+	if (!cgroup_on_dfl(cgrp) || !cgroup_parent(cgrp))
+		return false;
+
+	return true;
+}
+
+static ssize_t cgroup_kn_freeze(struct kernfs_node *kn,
+				const char *buf, size_t nbytes, loff_t off,
+				bool revalidate)
 {
 	struct cgroup *cgrp;
 	ssize_t ret;
 	int freeze;
+	char b[4] = {0};
+
+	/* Handle userspace writes +(0|1)\n and fail otherwise */
+	ret = strscpy(b, buf, sizeof(b));
+	if (ret < 0)
+		return ret;
 
-	ret = kstrtoint(strstrip(buf), 0, &freeze);
+	nbytes = ret;
+	ret = kstrtoint(strstrip(b), 0, &freeze);
 	if (ret)
 		return ret;
 
 	if (freeze < 0 || freeze > 1)
 		return -ERANGE;
 
-	cgrp = cgroup_kn_lock_live(of->kn, false);
+	cgrp = cgroup_kn_lock_live(kn, false);
 	if (!cgrp)
 		return -ENOENT;
 
+	if (revalidate && !cgroup_kn_revalidate(cgrp)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	cgroup_freeze(cgrp, freeze);
 
-	cgroup_kn_unlock(of->kn);
+	ret = nbytes;
 
-	return nbytes;
+out:
+	cgroup_kn_unlock(kn);
+	return ret;
+}
+
+static ssize_t cgroup_freeze_write(struct kernfs_open_file *of,
+				   char *buf, size_t nbytes, loff_t off)
+{
+	return cgroup_kn_freeze(of->kn, buf, nbytes, off, false);
 }
 
 static void __cgroup_kill(struct cgroup *cgrp)
@@ -4601,6 +4648,49 @@ void cgroup_file_show(struct cgroup_file *cfile, bool show)
 	kernfs_put(kn);
 }
 
+static struct cgroup_kn_cftype kn_cfts[] = {
+	{
+		.name = CGROUP_CORE_INTERFACE_FREEZE,
+		.namelen = CGROUP_CORE_INTERFACE_FREEZE_LEN,
+		.write = cgroup_kn_freeze,
+	},
+	{ },
+};
+
+static const struct cgroup_kn_cftype *cgroup_kn_cft(const char *name__str)
+{
+	struct cgroup_kn_cftype *kn_cft;
+
+	for (kn_cft = kn_cfts; kn_cft && kn_cft->name[0] != '\0'; kn_cft++) {
+		if (!strncmp(name__str, kn_cft->name, kn_cft->namelen))
+			return kn_cft;
+	}
+
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+ssize_t cgroup_kn_interface_write(struct kernfs_node *kn, const char *name__str,
+				  const char *buf, size_t nbytes, loff_t off)
+{
+	const struct cgroup_kn_cftype *kn_cft;
+
+	/* empty, do not remove */
+	if (!nbytes)
+		return 0;
+
+	if (kernfs_type(kn) != KERNFS_DIR)
+		return -ENOTDIR;
+
+	kn_cft = cgroup_kn_cft(name__str);
+	if (IS_ERR(kn_cft))
+		return PTR_ERR(kn_cft);
+
+	if (unlikely(!kn_cft->write))
+		return -EOPNOTSUPP;
+
+	return kn_cft->write(kn, buf, nbytes, off, true);
+}
+
 /**
  * css_next_child - find the next child of a given css
  * @pos: the current position (%NULL to initiate traversal)
-- 
2.43.0


