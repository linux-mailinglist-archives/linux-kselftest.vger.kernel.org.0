Return-Path: <linux-kselftest+bounces-10575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74138CBF01
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 12:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F5A28523D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 10:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B63C81AB7;
	Wed, 22 May 2024 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tnd1D6SG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51901CD13;
	Wed, 22 May 2024 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372546; cv=none; b=NG44P04lMVbI/tX6mXYZVYjXZXF2T2iM5Tynqdr6ZG1q7NEPf0A8/AeJuEPpwYNznoJjDfhNe+hpatzhvCj2V3AmKW4iVt2/N23HmBxv1hnG1/3vsQorC7sgISSmLUkIZzKGOfA9qm3DDGRaIMTI+V6QyXYSAaE+0uX6agGk/48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372546; c=relaxed/simple;
	bh=acKYv/QEKvNHAThP10G1yTBlwY36qPXgLkN7FrJFuiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcSWz8W/aX1qYYO7ouBwCFD04olPpMS+/bGUmrShl1ycajsl6DVcdVRKMy/eYXfsBojSmgOPYr0/mRMJDBh4z1VX3sbbgM54QUCFXpyrjotZbdI4m0lMo560CyzRlyaTulpomQ5WeG9FtLgBZ0otCPBezb5Z/30TBMaMVgANucc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tnd1D6SG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A335C2BD11;
	Wed, 22 May 2024 10:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716372546;
	bh=acKYv/QEKvNHAThP10G1yTBlwY36qPXgLkN7FrJFuiQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Tnd1D6SGqIdi7EHCm7tNaaphJTa+6qSJg0RXXvMXho9odCkILSqIYGpjIZnsQTwxo
	 0dgzIhEhA3uxtX9LFmDt9gD2TNVdxJkB1OKR/5VYIipShcEo4LreSRMyulWKS8zECb
	 Rbet1pBHOHK/dwQ+E8laEBrp7tIWlbqg4B9wAbJ2ljOcdN+4DJnrpqFHnAQVkpLHIn
	 oe+fQ/GpHghMLXB+GiyFZfdt8YU6Prk6AhvR7qJizs4ubkm2EQq2LVnkDoF8VuQer8
	 bPq4xLrrbC5MKgqb7/+EkKkesHyNEV1jwxFguDqFnO9PgLBTO9S0mTi9VF5X500muB
	 6AtIWia38iJMQ==
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
Subject: [PATCH bpf-next] selftests/bpf: Use prog_attach_type to attach in test_sockmap
Date: Wed, 22 May 2024 18:08:53 +0800
Message-ID: <e27d7d0c1e0e79b0acd22ac6ad5d8f9f00225303.1716372485.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Since prog_attach_type[] array is defined, it makes sense to use it paired
with prog_fd[] array for bpf_prog_attach() and bpf_prog_detach2() instead
of open-coding.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sockmap.c | 44 +++++++++++-----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 4499b3cfc3a6..8c8208b82c5e 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -65,6 +65,18 @@ int map_fd[9];
 struct bpf_map *maps[9];
 int prog_fd[9];
 
+int prog_attach_type[] = {
+	BPF_SK_SKB_STREAM_PARSER,
+	BPF_SK_SKB_STREAM_VERDICT,
+	BPF_SK_SKB_STREAM_VERDICT,
+	BPF_CGROUP_SOCK_OPS,
+	BPF_SK_MSG_VERDICT,
+	BPF_SK_MSG_VERDICT,
+	BPF_SK_MSG_VERDICT,
+	BPF_SK_MSG_VERDICT,
+	BPF_SK_MSG_VERDICT,
+};
+
 int txmsg_pass;
 int txmsg_redir;
 int txmsg_drop;
@@ -961,7 +973,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 	/* Attach programs to sockmap */
 	if (!txmsg_omit_skb_parser) {
 		err = bpf_prog_attach(prog_fd[0], map_fd[0],
-				      BPF_SK_SKB_STREAM_PARSER, 0);
+				      prog_attach_type[0], 0);
 		if (err) {
 			fprintf(stderr,
 				"ERROR: bpf_prog_attach (sockmap %i->%i): %d (%s)\n",
@@ -971,7 +983,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 	}
 
 	err = bpf_prog_attach(prog_fd[1], map_fd[0],
-				BPF_SK_SKB_STREAM_VERDICT, 0);
+			      prog_attach_type[1], 0);
 	if (err) {
 		fprintf(stderr, "ERROR: bpf_prog_attach (sockmap): %d (%s)\n",
 			err, strerror(errno));
@@ -982,7 +994,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 	if (txmsg_ktls_skb) {
 		if (!txmsg_omit_skb_parser) {
 			err = bpf_prog_attach(prog_fd[0], map_fd[8],
-					      BPF_SK_SKB_STREAM_PARSER, 0);
+					      prog_attach_type[0], 0);
 			if (err) {
 				fprintf(stderr,
 					"ERROR: bpf_prog_attach (TLS sockmap %i->%i): %d (%s)\n",
@@ -992,7 +1004,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 		}
 
 		err = bpf_prog_attach(prog_fd[2], map_fd[8],
-				      BPF_SK_SKB_STREAM_VERDICT, 0);
+				      prog_attach_type[2], 0);
 		if (err) {
 			fprintf(stderr, "ERROR: bpf_prog_attach (TLS sockmap): %d (%s)\n",
 				err, strerror(errno));
@@ -1001,7 +1013,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 	}
 
 	/* Attach to cgroups */
-	err = bpf_prog_attach(prog_fd[3], cg_fd, BPF_CGROUP_SOCK_OPS, 0);
+	err = bpf_prog_attach(prog_fd[3], cg_fd, prog_attach_type[3], 0);
 	if (err) {
 		fprintf(stderr, "ERROR: bpf_prog_attach (groups): %d (%s)\n",
 			err, strerror(errno));
@@ -1279,11 +1291,11 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 		fprintf(stderr, "unknown test\n");
 out:
 	/* Detatch and zero all the maps */
-	bpf_prog_detach2(prog_fd[3], cg_fd, BPF_CGROUP_SOCK_OPS);
-	bpf_prog_detach2(prog_fd[0], map_fd[0], BPF_SK_SKB_STREAM_PARSER);
-	bpf_prog_detach2(prog_fd[1], map_fd[0], BPF_SK_SKB_STREAM_VERDICT);
-	bpf_prog_detach2(prog_fd[0], map_fd[8], BPF_SK_SKB_STREAM_PARSER);
-	bpf_prog_detach2(prog_fd[2], map_fd[8], BPF_SK_SKB_STREAM_VERDICT);
+	bpf_prog_detach2(prog_fd[3], cg_fd, prog_attach_type[3]);
+	bpf_prog_detach2(prog_fd[0], map_fd[0], prog_attach_type[0]);
+	bpf_prog_detach2(prog_fd[1], map_fd[0], prog_attach_type[1]);
+	bpf_prog_detach2(prog_fd[0], map_fd[8], prog_attach_type[0]);
+	bpf_prog_detach2(prog_fd[2], map_fd[8], prog_attach_type[2]);
 
 	if (tx_prog_fd >= 0)
 		bpf_prog_detach2(tx_prog_fd, map_fd[1], BPF_SK_MSG_VERDICT);
@@ -1783,18 +1795,6 @@ char *map_names[] = {
 	"tls_sock_map",
 };
 
-int prog_attach_type[] = {
-	BPF_SK_SKB_STREAM_PARSER,
-	BPF_SK_SKB_STREAM_VERDICT,
-	BPF_SK_SKB_STREAM_VERDICT,
-	BPF_CGROUP_SOCK_OPS,
-	BPF_SK_MSG_VERDICT,
-	BPF_SK_MSG_VERDICT,
-	BPF_SK_MSG_VERDICT,
-	BPF_SK_MSG_VERDICT,
-	BPF_SK_MSG_VERDICT,
-};
-
 int prog_type[] = {
 	BPF_PROG_TYPE_SK_SKB,
 	BPF_PROG_TYPE_SK_SKB,
-- 
2.43.0


