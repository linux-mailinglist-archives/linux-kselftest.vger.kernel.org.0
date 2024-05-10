Return-Path: <linux-kselftest+bounces-10033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF328C2A39
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C4E1C21C4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2810D45000;
	Fri, 10 May 2024 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0c8ITQy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB645945
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367781; cv=none; b=U4puRyRCQPWjbzzJZchtif5+rfRtpMu9wluvqTR8kmP/Asd6XUWHBs72AOJEqABvbgkRwTVGkEEMsIt9mjVKGQ5ZXuJzAgvOHBHvjGpHcv26mmJKQCMnRdvCmg2HiEC3Fci/cto5bKE5bFzbvGqVNvp4KnofLZvrFRieWPWqDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367781; c=relaxed/simple;
	bh=ZKBym8bL+87iuEO1eTLqx0aH90HS+ZXJ37G/jaGUc0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YkFpQWr1Y6rtBfbe7hVAJHtNXQxvKxcoqkpLJStmk0yWLJhTF5tgifoCaTzedmjhvDPuVsglAYpRK9rxxrMH7LsjtBfqTUrL8LK0KP//15PKJ6Jx6JC46UnI/3fwJSSmFEmKSH9X3Ksw6PMXRQpRjLtNi7sWys3DTuePtchyMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F0c8ITQy; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de74a2635e2so3794743276.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367778; x=1715972578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xkbaFBJQy7+phzuNx/G3f0fc96jsJ3oP7IdhCfgCmIk=;
        b=F0c8ITQyb0P9jCNCsXxgJHSDcpyQcLszDU5eKx2uHI4i5odjbWgU/dESJW/JPS5HjJ
         7QJ59DbOJ5IksH1g4B2amgA0+5VGqGHGuIeIeGc0QbUGoYUdxrp7iMujkto3WCAvOz9R
         fOzytc5xMtiaZyT43daa8Ji+eik0OTOS8m0Yrkn5X27Hy/2FdR5+hn/xUNwEg0iHRiQX
         v7fOM6b6GV61abJ+xUJozYdtJ3EwnYcaJGtqWWhpfKWQfTDm89SQvHLUg4xJJk7Lq2D1
         bYQsHMwtRFdDBTIQv/F7wmAzu7XZE+bzb9NqMdbh+OVQ2gu2q8jeEEHiQnkinVLDzLxu
         rgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367778; x=1715972578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkbaFBJQy7+phzuNx/G3f0fc96jsJ3oP7IdhCfgCmIk=;
        b=k9HOuVD3GbYYehbGkHpS70X/bjz0T3nkLvdd33cRNMPlzwWU71rsKDosJGOdi2MEgA
         GwX1wUMpUKTU7Do2FBtr8q3XEu6CliBY4QXHZseennJqKgTcx7QdpeRIdIe2Id3Fh96k
         uhIWPZveVbhE9J/HOzRqI7DCkE1vFea5muCYfcc3vFjZxtBuGinJt5zUfBtygL0y0XgY
         ttp2JXtDQFmQXYlbXyTQSYvBbzBFmqYprtyQr/uO7C9bHMn41NotPsGrezkItDkKddkk
         Q+i9QbyAbjDMrgBQd9L2TEyGD4iuU/KgQvKOKhs27+KtYJ1idIkVBXe61gn92yG1IBCk
         bb0g==
X-Forwarded-Encrypted: i=1; AJvYcCUGmKWnRvWSUDVFlGVhBXYBD8kKH3HfSLDDA51eulo6kdW82HjHbidgaPfvh/77SFxwuDffyaZmAqcqSDbxc4LaJClJYsV1TvnmhtzJsvSm
X-Gm-Message-State: AOJu0Yy2ubEdUTL7AuOzxOYFT2VtG+J5iqVACYyZGAXZh9Hg0d0JwZ3R
	Wfdwb0l1ft9aXwP6bdW/zb4lFA+nKNKXqVEpdLhFP8xW+W96Yp3yDp6+WzZC/Nd2zEou6Q+/Yw=
	=
X-Google-Smtp-Source: AGHT+IEnUdFgZ3SDhkY3B9LOnHEJlb4pHhYF8GxCtgmQffiVDZIyHiOEGpEpTF5Wfn5B8slwQa39S/H19A==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6902:150a:b0:dc2:2ace:860 with SMTP id
 3f1490d57ef6-dee4f3117c3mr274015276.2.1715367778597; Fri, 10 May 2024
 12:02:58 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:23 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-7-jrife@google.com>
Subject: [PATCH v1 bpf-next 06/17] selftests/bpf: Migrate WILDCARD_IP test
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move wildcard IP sendmsg test case out of bpf/test_sock_addr.c into
prog_tests/sock_addr.c.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 50 +++++++++++++++++++
 .../selftests/bpf/progs/sendmsg6_prog.c       |  6 +++
 tools/testing/selftests/bpf/test_sock_addr.c  | 20 --------
 3 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 626be900a8fdf..37e9ef5a5ae16 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -40,6 +40,7 @@
 #define SERV6_V4MAPPED_IP       "::ffff:192.168.0.4"
 #define SRC6_IP                 "::1"
 #define SRC6_REWRITE_IP         TEST_IPV6
+#define WILDCARD6_IP            "::"
 #define SERV6_PORT              6060
 #define SERV6_REWRITE_PORT      6666
 
@@ -443,6 +444,7 @@ BPF_SKEL_FUNCS(connect6_prog, connect_v6_prog);
 BPF_SKEL_FUNCS(connect_unix_prog, connect_unix_prog);
 BPF_SKEL_FUNCS(sendmsg4_prog, sendmsg_v4_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_prog);
+BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_preserve_dst_prog);
 BPF_SKEL_FUNCS(sendmsg_unix_prog, sendmsg_unix_prog);
 BPF_SKEL_FUNCS(recvmsg4_prog, recvmsg4_prog);
 BPF_SKEL_FUNCS(recvmsg6_prog, recvmsg6_prog);
@@ -780,6 +782,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: sendmsg [::] (BSD'ism) (dgram)",
+		sendmsg_v6_preserve_dst_prog_load,
+		sendmsg_v6_preserve_dst_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
+		&user_ops,
+		AF_INET6,
+		SOCK_DGRAM,
+		WILDCARD6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_PORT,
+		SRC6_IP,
+		SUCCESS,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sendmsg (dgram)",
@@ -830,6 +848,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: sock_sendmsg [::] (BSD'ism) (dgram)",
+		sendmsg_v6_preserve_dst_prog_load,
+		sendmsg_v6_preserve_dst_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
+		&kern_ops_sock_sendmsg,
+		AF_INET6,
+		SOCK_DGRAM,
+		WILDCARD6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_PORT,
+		SRC6_IP,
+		SUCCESS,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sock_sendmsg (dgram)",
@@ -880,6 +914,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: kernel_sendmsg [::] (BSD'ism) (dgram)",
+		sendmsg_v6_preserve_dst_prog_load,
+		sendmsg_v6_preserve_dst_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
+		&kern_ops_kernel_sendmsg,
+		AF_INET6,
+		SOCK_DGRAM,
+		WILDCARD6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_PORT,
+		SRC6_IP,
+		SUCCESS,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sock_sendmsg (dgram)",
diff --git a/tools/testing/selftests/bpf/progs/sendmsg6_prog.c b/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
index bf9b46b806f6a..03956a654ce58 100644
--- a/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
+++ b/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
@@ -59,4 +59,10 @@ int sendmsg_v6_prog(struct bpf_sock_addr *ctx)
 	return 1;
 }
 
+SEC("cgroup/sendmsg6")
+int sendmsg_v6_preserve_dst_prog(struct bpf_sock_addr *ctx)
+{
+	return 1;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 40e33167bec20..ab8ef02c9c556 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -92,7 +92,6 @@ static int bind4_prog_load(const struct sock_addr_test *test);
 static int bind6_prog_load(const struct sock_addr_test *test);
 static int connect4_prog_load(const struct sock_addr_test *test);
 static int connect6_prog_load(const struct sock_addr_test *test);
-static int sendmsg_allow_prog_load(const struct sock_addr_test *test);
 static int sendmsg_deny_prog_load(const struct sock_addr_test *test);
 static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test);
@@ -343,20 +342,6 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
-	{
-		"sendmsg6: preserve dst IP = [::] (BSD'ism)",
-		sendmsg_allow_prog_load,
-		BPF_CGROUP_UDP6_SENDMSG,
-		BPF_CGROUP_UDP6_SENDMSG,
-		AF_INET6,
-		SOCK_DGRAM,
-		WILDCARD6_IP,
-		SERV6_PORT,
-		SERV6_REWRITE_IP,
-		SERV6_PORT,
-		SRC6_IP,
-		SUCCESS,
-	},
 	{
 		"sendmsg6: deny call",
 		sendmsg_deny_prog_load,
@@ -457,11 +442,6 @@ static int xmsg_ret_only_prog_load(const struct sock_addr_test *test,
 	return load_insns(test, insns, ARRAY_SIZE(insns));
 }
 
-static int sendmsg_allow_prog_load(const struct sock_addr_test *test)
-{
-	return xmsg_ret_only_prog_load(test, /*rc*/ 1);
-}
-
 static int sendmsg_deny_prog_load(const struct sock_addr_test *test)
 {
 	return xmsg_ret_only_prog_load(test, /*rc*/ 0);
-- 
2.45.0.118.g7fe29c98d7-goog


