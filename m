Return-Path: <linux-kselftest+bounces-10606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8128CCC7A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 08:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1CE280E60
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 06:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3AF13C8E8;
	Thu, 23 May 2024 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLXTYBmC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2D13C8E1;
	Thu, 23 May 2024 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447040; cv=none; b=fxRI/gsOrGIvqqFyMFUI635tFl6eR6QXgj1tCgGZmeQIH6sLRI8VCmGAUQVRlN0b+nPy7RoJEDcN3H/e734DbQp1rvDK6JRCT2aNyfwBvnZSyycYOcqNdk5NznlVfQHeql3d3FDjqrxG+RXyBi8VnXiVqv9QwuQRGZMz44KN++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447040; c=relaxed/simple;
	bh=j+Yzr44J3a/y0uMOBUQ0oSYXFSurJrqVJ6d0Uotfark=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ew09LSNDHRg5/frDkDu+x+8p36RB0ilJ1Dp+xM8qIB8Skg13N3NYtPtgURtgM8IaCQsSG6jv0vWWIpv9+RBRNI8zZUL37MmAUkqO3exbrZkV1lN1Wgx+Xhn3+gJ7/xoqdt8AkYfA9EDP/vqpmxpimPA5rCJmcdWeGFbvawf3CU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLXTYBmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E51C32782;
	Thu, 23 May 2024 06:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716447039;
	bh=j+Yzr44J3a/y0uMOBUQ0oSYXFSurJrqVJ6d0Uotfark=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLXTYBmC9qdkVCPDH1Vxcmic2fuUaIF/DZWKMYZr7aHHhSBKr9qGWR60dBMtlZ4xt
	 TF2U3FNb6KpusCJtKrJUpkQ58ql8eAxdqqUG14fYYR81zVG+kqO1P0EPVQVgeAl5Z8
	 gdTLeL/qIfLIzQbomqeG5xlO01f2TT3Di9yJKEiw0BviUzrC2rSl5rvZQWsi8KGynh
	 w/Ve6EBVeUqY3WaFgU2Nj9gwn8W26GeVDQHtMlxMEOCsyedWzKdf7A2htnjWAhyjg1
	 mv7UmLRaDBFQ2Tb2crXn76NG2B/W+CXtjTW2pSap5XKFMJmb5lR5k/ZmJCz1gFDYUM
	 9HFIUCplfMVMw==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 3/8] selftests/bpf: Use bpf_link attachments in test_sockmap
Date: Thu, 23 May 2024 14:49:59 +0800
Message-ID: <32cf8376a810e2e9c719f8e4cfb97132ed2d1f9c.1716446893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716446893.git.tanggeliang@kylinos.cn>
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Switch attachments to bpf_link using bpf_program__attach_sockmap() instead
of bpf_prog_attach().

This patch adds a new array progs[] to replace prog_fd[] array, set in
populate_progs() for each program in bpf object.

And another new array links[] to save the attached bpf_link. It is
initalized as NULL in populate_progs, set as the return valuses of
bpf_program__attach_sockmap(), and detached by bpf_link__detach().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sockmap.c | 59 ++++++++++++----------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index e7dbf49a2ca6..d7581bbbc473 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -64,6 +64,8 @@ int failed;
 int map_fd[9];
 struct bpf_map *maps[9];
 int prog_fd[9];
+struct bpf_program *progs[9];
+struct bpf_link *links[9];
 
 int txmsg_pass;
 int txmsg_redir;
@@ -960,43 +962,39 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 
 	/* Attach programs to sockmap */
 	if (!txmsg_omit_skb_parser) {
-		err = bpf_prog_attach(prog_fd[0], map_fd[0],
-				      BPF_SK_SKB_STREAM_PARSER, 0);
-		if (err) {
+		links[0] = bpf_program__attach_sockmap(progs[0], map_fd[0]);
+		if (!links[0]) {
 			fprintf(stderr,
-				"ERROR: bpf_prog_attach (sockmap %i->%i): %d (%s)\n",
-				prog_fd[0], map_fd[0], err, strerror(errno));
-			return err;
+				"ERROR: bpf_program__attach_sockmap (sockmap %i->%i): (%s)\n",
+				bpf_program__fd(progs[0]), map_fd[0], strerror(errno));
+			return -1;
 		}
 	}
 
-	err = bpf_prog_attach(prog_fd[1], map_fd[0],
-				BPF_SK_SKB_STREAM_VERDICT, 0);
-	if (err) {
-		fprintf(stderr, "ERROR: bpf_prog_attach (sockmap): %d (%s)\n",
-			err, strerror(errno));
-		return err;
+	links[1] = bpf_program__attach_sockmap(progs[1], map_fd[0]);
+	if (!links[1]) {
+		fprintf(stderr, "ERROR: bpf_program__attach_sockmap (sockmap): (%s)\n",
+			strerror(errno));
+		return -1;
 	}
 
 	/* Attach programs to TLS sockmap */
 	if (txmsg_ktls_skb) {
 		if (!txmsg_omit_skb_parser) {
-			err = bpf_prog_attach(prog_fd[0], map_fd[8],
-					      BPF_SK_SKB_STREAM_PARSER, 0);
-			if (err) {
+			links[2] = bpf_program__attach_sockmap(progs[0], map_fd[8]);
+			if (!links[2]) {
 				fprintf(stderr,
-					"ERROR: bpf_prog_attach (TLS sockmap %i->%i): %d (%s)\n",
-					prog_fd[0], map_fd[8], err, strerror(errno));
-				return err;
+					"ERROR: bpf_program__attach_sockmap (TLS sockmap %i->%i): (%s)\n",
+					bpf_program__fd(progs[0]), map_fd[8], strerror(errno));
+				return -1;
 			}
 		}
 
-		err = bpf_prog_attach(prog_fd[2], map_fd[8],
-				      BPF_SK_SKB_STREAM_VERDICT, 0);
-		if (err) {
-			fprintf(stderr, "ERROR: bpf_prog_attach (TLS sockmap): %d (%s)\n",
-				err, strerror(errno));
-			return err;
+		links[3] = bpf_program__attach_sockmap(progs[2], map_fd[8]);
+		if (!links[3]) {
+			fprintf(stderr, "ERROR: bpf_program__attach_sockmap (TLS sockmap): (%s)\n",
+				strerror(errno));
+			return -1;
 		}
 	}
 
@@ -1281,10 +1279,11 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 out:
 	/* Detatch and zero all the maps */
 	bpf_prog_detach2(prog_fd[3], cg_fd, BPF_CGROUP_SOCK_OPS);
-	bpf_prog_detach2(prog_fd[0], map_fd[0], BPF_SK_SKB_STREAM_PARSER);
-	bpf_prog_detach2(prog_fd[1], map_fd[0], BPF_SK_SKB_STREAM_VERDICT);
-	bpf_prog_detach2(prog_fd[0], map_fd[8], BPF_SK_SKB_STREAM_PARSER);
-	bpf_prog_detach2(prog_fd[2], map_fd[8], BPF_SK_SKB_STREAM_VERDICT);
+
+	for (i = 0; i < ARRAY_SIZE(links); i++) {
+		if (links[i])
+			bpf_link__detach(links[i]);
+	}
 
 	if (tx_prog_fd > 0)
 		bpf_prog_detach2(tx_prog_fd, map_fd[1], BPF_SK_MSG_VERDICT);
@@ -1836,6 +1835,7 @@ static int populate_progs(char *bpf_file)
 	i = bpf_object__load(obj);
 	i = 0;
 	bpf_object__for_each_program(prog, obj) {
+		progs[i] = prog;
 		prog_fd[i] = bpf_program__fd(prog);
 		i++;
 	}
@@ -1850,6 +1850,9 @@ static int populate_progs(char *bpf_file)
 		}
 	}
 
+	for (i = 0; i < ARRAY_SIZE(links); i++)
+		links[i] = NULL;
+
 	return 0;
 }
 
-- 
2.43.0


