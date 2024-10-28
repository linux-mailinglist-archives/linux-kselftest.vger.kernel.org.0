Return-Path: <linux-kselftest+bounces-20860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FFE9B3D7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D0028C16E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 22:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B1619007E;
	Mon, 28 Oct 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzAlhRyX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858BF190493
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153180; cv=none; b=q/MsrYOcIScPZQIcFabAgSo/8NFIm9DSILyNkbx+CcbN9T/TS2RtlUxG1jVnZrYdOQxVdmMHdkbrGLAEifB1kIdoncx7oQfEsdgwtfM9GOzilkl/JHl124KvliG3M0QJvy0wMelhsBUSw3htrwNpm36S1Y5hZHZXTHhl1FtbZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153180; c=relaxed/simple;
	bh=lnNh2MyW6k3PPWKeZ3lkSphmqc6oZlzuJG2jDdoCDuc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CJrCK75779l4a/haKizjvzjOtl88xc/2GDcT7y1gZyqfltWg8uQF1+GJtkEmUriAkDwJ0kloIC84v33gutck3UmYIaZ33rNF4Khifg42KClS+G2ucP62FxAXITRznpYBJPpTvGrSmXXcsIq9IuWbsBR1CPnfxQYOzrMEtzAcqik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XzAlhRyX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e32e8436adso69740297b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 15:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730153177; x=1730757977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SOY2vgqJ0KtVzbKcwr3dZPfuHJS0Y1wX9dhGpLmmysU=;
        b=XzAlhRyXDt0IKtNwkAaZzgCReQ5z9gGMXRlpYyOcbv/yDhp601ZroIh90cW7z2oleL
         PnnSDR1CtNDuegX5Do3uZpJweqKdDa1pgLKYP5rYL5uT0UW9A2xi5IR6LRQteerYcjSp
         xarBu5PuG1rXsYEckqswbikk+Pzz/Qy5x3/N3FqN3gxEpCc6AbNJF9xmbyeo1H/opSke
         SpFifHzlrVSGMO3AmFWr6oldlytnMYL48QItnldGPMwGA3Y8rMtehV1l3+lpwBJ8io5q
         HzZO/pb2IcslBZjMLGBOhoqQzzHybdY6WY97Z0qSPjIB0SX9DMp7HCxntTQYXP4gEcSL
         MM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153177; x=1730757977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOY2vgqJ0KtVzbKcwr3dZPfuHJS0Y1wX9dhGpLmmysU=;
        b=QNHyzdeO9JaNb74m0DD3SKPlFl6p3WRvv7UMy02T+B8dfQMrKFsitrBms0yZhU/G/d
         EIXfpmv2C4F1heczHGfe3c8cSlHDHyk1sbxd0pywT5/jCHGNcPpWk/VfAEFypVIDzBcx
         qwkM4JEHXviembPnzIuyVrgwmpm1qRz8uYU5MKHLCk1s0r69EDLuOJJ404JgEI11PebN
         AEKTNuzPEPhOd9osbNj0LYDgiJuQkIfJ4zs7QN15PFDneJdST+rgEp+N+gKFIQ/mr2jP
         mZhNY4SzOkKwoTfsPycKZlHL82LmhOR3w/lRVOHx8BVjoF71EPbta0bDZNF581lxDNMB
         BjLA==
X-Forwarded-Encrypted: i=1; AJvYcCXwoZzshQv1WrGYPkun7nAq/BcI0+yGqDQoZeK3ky8D1yiEPu9REBOLuVNDtgfp/i/ZwPfMEUxTMjt1VUh56w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXAP5irthIvlS1m7zHuHqRrfQiaMMflKpY6+RknS32kuCbB68
	VBXCaESMV6YTEV43mDJB6QANmVZIi3pqZkyWavbNK5VHCQPhrzxm3FYdd9lI/admrXLs6ifrxuq
	JAZIR7FIgu+u6gzPTZ7Xucg==
X-Google-Smtp-Source: AGHT+IHJS7A7yrEb37MadLUrxRTDRexnft6XJqKZL6BE/v5PEF5d2AuI0hKlTnaiOAdoLKFKUc2XiD9OoW2teZTugQ==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:dd17:1d2c:7822:7fdf])
 (user=kaleshsingh job=sendgmr) by 2002:a05:690c:9682:b0:69b:c01:82a5 with
 SMTP id 00721157ae682-6e9d8b89f8amr7192987b3.7.1730153177563; Mon, 28 Oct
 2024 15:06:17 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:43:59 -0700
In-Reply-To: <20241028214550.2099923-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241028214550.2099923-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028214550.2099923-4-kaleshsingh@google.com>
Subject: [PATCH 3/3] tracing: Fix tracefs gid mount option
From: Kalesh Singh <kaleshsingh@google.com>
To: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Eric Sandeen <sandeen@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
tracefs to use the new mount APIs caused mounting with the gid=<gid>
option to not take effect.

The tracefs superblock can be updated from multiple paths:
    - on fs_initcall() to init_trace_printk_function_export()
    - form a work queue to initialize eventfs
      tracer_init_tracefs_work_func()
    - fsconfig() syscall to mount of remount sysfs

The tracefs super block root inode gets created early on in
init_trace_printk_function_export().

With the new mount API tracefs effectively uses get_tree_single() instead
of the old API mount_single().

Previously, mount_single() ensured that the options are alway applied to
the superblock root inode:
    (1) If the root inode didn't exist, called fill_super() to create it
        and apply the options.
    (2) If the root inode exists, called reconfigure_single() which
        effectively called tracefs_apply_options() to parse and apply
        options to the subperblock's fs_info and inode and remount
        eventfs (if necessary)

On the other hand, get_tree_single() effectively calls vfs_get_super()
which:
    (3) If the root inode doesn't exists calls fill_super() to create it
        and apply the options.
    (4) If the root inode already exists, updates the fs_context root
        with the superblock's root inode.

(4) above is always the case for tracefs mounts, since the super block's
root inode will already be created by init_trace_printk_function_export().

This means that the gid mount option gets ignored:
    - Since it isn't applied to the super block's root inode, it doesn't
      get inherited by the children.
    - Since eventfs is initialized from form a separate work queue and
      before call to mount with the options, and it doesn't get remounted
      for mount.

Ensure that the mount options are applied to the super block and eventfs
is remounted to respect the new mount options.

[1] https://lore.kernel.org/r/536e99d3-345c-448b-adee-a21389d7ab4b@redhat.com/

Fixes: 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
Cc: David Howells <dhowells@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 fs/tracefs/inode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 1748dff58c3b..cfc614c638da 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -392,6 +392,9 @@ static int tracefs_reconfigure(struct fs_context *fc)
 	struct tracefs_fs_info *sb_opts = sb->s_fs_info;
 	struct tracefs_fs_info *new_opts = fc->s_fs_info;
 
+	if (!new_opts)
+		return 0;
+
 	sync_filesystem(sb);
 	/* structure copy of new mount options to sb */
 	*sb_opts = *new_opts;
@@ -478,14 +481,17 @@ static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &tracefs_super_operations;
 	sb->s_d_op = &tracefs_dentry_operations;
 
-	tracefs_apply_options(sb, false);
-
 	return 0;
 }
 
 static int tracefs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, tracefs_fill_super);
+	int err = get_tree_single(fc, tracefs_fill_super);
+
+	if (err)
+		return err;
+
+	return tracefs_reconfigure(fc);
 }
 
 static void tracefs_free_fc(struct fs_context *fc)
-- 
2.47.0.163.g1226f6d8fa-goog


