Return-Path: <linux-kselftest+bounces-10036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A63DD8C2A3F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322C01F21734
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF49345977;
	Fri, 10 May 2024 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sdLbY0XZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36A13ADA
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367785; cv=none; b=kHNlol92ZS0i1vfIATYsYQ9jUXGwH3xYjHD+N/SJXvP10ScqXhN/ROoARGIJHeMaqaTZ2k9+6J8EhtWHw05E+a5nz0Rh9zIw0dCIq/gN/5RNI+MwUjogaFOYLuM/PDNoFPhm1CdZKf/GYZbg4FdSnkOXfTOaz6cBau+N6F7h64I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367785; c=relaxed/simple;
	bh=x1ZNclz6XGRBWGUVoJl7HuJKgg0IMpw6yDjx1ViCIuU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LqPJ+EJsFiHFWC3RFrPDbp0WRERXkrJLhehh75kQS8uJL52YQdp+Gt63TpxH0QGOrhmHEHmYs9b2THcUtOvWl+x4mOIt7O9Ekf/RoCh0TJ3lh1lzJ5Ayn1o7WtH3vL39DWp4dq3LGdIMHxdJrPBmNLCgQhGb8JNC95ZIG0Q3src=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sdLbY0XZ; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7e1964b70e2so263436039f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367783; x=1715972583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+TSjlpAbaeVwYFm50W1bDQVoMu+XNSE+u70UoXzQquw=;
        b=sdLbY0XZx1Xj4ntFX81LiGFZpgrhbvjFrMe3gdrv7dwbVuWVuXsP+yIOMlH1/JTqbv
         XXE2X7YaTV1g7NZFp5ECGkquqVIKkGeLyLKM/tMgQtp2TnQPEg7/Z4WY6/BAj0YhI+qT
         49DcOn+9Vgoh1IP4cvbJTT8HEz5ly5GqJUi8HnsmBsnpwbOOT+w2+Wd26Hzl1ETw9KmN
         1+pnV8tPoeJ9wxV5P0ulpgbOV58uzRae4EucFPs0aXkjGRitG57AJAnjKDJsg3UoFxaI
         kokzXCwv3mkVMZypcY/jTSd1f9hIyLYFI1mMjvV2JtDVSWE4DTzamTaENiVfjFXw4Bbx
         MuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367783; x=1715972583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TSjlpAbaeVwYFm50W1bDQVoMu+XNSE+u70UoXzQquw=;
        b=Qt4ym9uLnCxpsqb+DO545pdiLJi9gmEQ0zbo0mq0atz44rqEbSveDyfZIgHIwyUuEx
         SsvJ2n3ZXphkwfG/nN1vMtbHowOqkj+hm4e/xlRhC6romzx4B7NfIY2qwgi77rFezwR2
         f3ayW72CAAT6IFFmAMSTbIJBRrZC9Lcn63z9DfMFZo+O53s/HAYOYaGZcpLiScrMj8/X
         r7LFcYMeuCrm7E8cWzWDD45GM+aZ11xekRBJlpdWW0F/OXNNuBh8zy+8uk33nSeO92Iy
         zjv1vqm3jVbQ7mB8WL8A5eXsXFjfRP74W/pGPFBRBiN6ck6rPA+bY2sZXwNoKKe/CHPi
         Vmdg==
X-Forwarded-Encrypted: i=1; AJvYcCWuJyGPqgqKUVSPaDImbdBw1Q1wMjH0+Au6EtXZE4gAnp+C5wlSDXgc6QQglQoQGS1wZuqaPu3WSi+zJcghW9UNlxi+AsxQML1HxuDuR2Em
X-Gm-Message-State: AOJu0YzflSi1jjzkGoYorWNV46mWPXsZZ8aNZyFSeTZ6aN3/yBb1dzbJ
	J+C+HG4oGS/XACDkYELtyLqSemwqR+kcPPjdTkzrFWlt6BI70ynCfn3hZoPGhJTJInf94kavcw=
	=
X-Google-Smtp-Source: AGHT+IEQoatQan0lpFkrvfA58RP4++KSHeceHI8QfPqVVTGdFHvSHbsGy01WpEwJkTUJHXL2NmkqWCmjHg==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6638:890c:b0:488:e34a:5f78 with SMTP id
 8926c6da1cb9f-4895955f570mr245796173.1.1715367783552; Fri, 10 May 2024
 12:03:03 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:26 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-10-jrife@google.com>
Subject: [PATCH v1 bpf-next 09/17] selftests/bpf: Migrate wildcard destination
 rewrite test
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

Migrate test case from bpf/test_sock_addr.c ensuring that sendmsg
respects when sendmsg6 hooks rewrite the destination IP with the IPv6
wildcard IP, [::].

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 17 ++++++++++++++++
 .../selftests/bpf/progs/sendmsg6_prog.c       | 20 +++++++++++++++++++
 tools/testing/selftests/bpf/test_sock_addr.c  | 20 -------------------
 3 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index f096203171b17..e3c450d11b9ef 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -448,6 +448,7 @@ BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_deny_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_preserve_dst_prog);
 BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_v4mapped_prog);
+BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_wildcard_prog);
 BPF_SKEL_FUNCS(sendmsg_unix_prog, sendmsg_unix_prog);
 BPF_SKEL_FUNCS(recvmsg4_prog, recvmsg4_prog);
 BPF_SKEL_FUNCS(recvmsg6_prog, recvmsg6_prog);
@@ -849,6 +850,22 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SYSCALL_ENOTSUPP,
 	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: sendmsg dst IP = [::] (BSD'ism) (dgram)",
+		sendmsg_v6_wildcard_prog_load,
+		sendmsg_v6_wildcard_prog_destroy,
+		BPF_CGROUP_UDP6_SENDMSG,
+		&user_ops,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+		SUCCESS,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
 		"sendmsg_unix: sendmsg (dgram)",
diff --git a/tools/testing/selftests/bpf/progs/sendmsg6_prog.c b/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
index 7611d9e17dd16..36a7f960799f0 100644
--- a/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
+++ b/tools/testing/selftests/bpf/progs/sendmsg6_prog.c
@@ -84,6 +84,26 @@ int sendmsg_v6_v4mapped_prog(struct bpf_sock_addr *ctx)
 	return 1;
 }
 
+SEC("cgroup/sendmsg6")
+int sendmsg_v6_wildcard_prog(struct bpf_sock_addr *ctx)
+{
+	/* Rewrite source. */
+	ctx->msg_src_ip6[0] = bpf_htonl(SRC_REWRITE_IP6_0);
+	ctx->msg_src_ip6[1] = bpf_htonl(SRC_REWRITE_IP6_1);
+	ctx->msg_src_ip6[2] = bpf_htonl(SRC_REWRITE_IP6_2);
+	ctx->msg_src_ip6[3] = bpf_htonl(SRC_REWRITE_IP6_3);
+
+	/* Rewrite destination. */
+	ctx->user_ip6[0] = bpf_htonl(0);
+	ctx->user_ip6[1] = bpf_htonl(0);
+	ctx->user_ip6[2] = bpf_htonl(0);
+	ctx->user_ip6[3] = bpf_htonl(0);
+
+	ctx->user_port = bpf_htons(DST_REWRITE_PORT6);
+
+	return 1;
+}
+
 SEC("cgroup/sendmsg6")
 int sendmsg_v6_preserve_dst_prog(struct bpf_sock_addr *ctx)
 {
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 4ead113753f81..85fb2a793be50 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -94,7 +94,6 @@ static int connect4_prog_load(const struct sock_addr_test *test);
 static int connect6_prog_load(const struct sock_addr_test *test);
 static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test);
-static int sendmsg6_rw_wildcard_prog_load(const struct sock_addr_test *test);
 
 static struct sock_addr_test tests[] = {
 	/* bind */
@@ -298,20 +297,6 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
-	{
-		"sendmsg6: set dst IP = [::] (BSD'ism)",
-		sendmsg6_rw_wildcard_prog_load,
-		BPF_CGROUP_UDP6_SENDMSG,
-		BPF_CGROUP_UDP6_SENDMSG,
-		AF_INET6,
-		SOCK_DGRAM,
-		SERV6_IP,
-		SERV6_PORT,
-		SERV6_REWRITE_IP,
-		SERV6_REWRITE_PORT,
-		SRC6_REWRITE_IP,
-		SUCCESS,
-	},
 };
 
 static int load_insns(const struct sock_addr_test *test,
@@ -497,11 +482,6 @@ static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test)
 	return sendmsg6_rw_dst_asm_prog_load(test, SERV6_REWRITE_IP);
 }
 
-static int sendmsg6_rw_wildcard_prog_load(const struct sock_addr_test *test)
-{
-	return sendmsg6_rw_dst_asm_prog_load(test, WILDCARD6_IP);
-}
-
 static int cmp_addr(const struct sockaddr_storage *addr1,
 		    const struct sockaddr_storage *addr2, int cmp_port)
 {
-- 
2.45.0.118.g7fe29c98d7-goog


