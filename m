Return-Path: <linux-kselftest+bounces-10607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB238CCC7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 08:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3EC01F217C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 06:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B0313C8EE;
	Thu, 23 May 2024 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOB1RTw6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8913213C838;
	Thu, 23 May 2024 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447045; cv=none; b=Owni4GA15IZtKqjjljdIAWFCjma4/pZ7C3wy4Yo+nIASuEZs7jZcxwX8DTx2ZPbpAMD2aWVbJJTlVA8RUbLfrBi948zfz5EwF5Q5K6T9+Ixs29uF8iGMqJzjmjY3EFiT4XvA3Xv7F4cGOkZc3Pu2C+KrVtHpchy05VwtoRxdOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447045; c=relaxed/simple;
	bh=EsgKr2+15JU23386C02AiaPX82NABHkp3oBufrNJeLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7lvGqR0NqcSsCFWAwQrylhZ/EXdHSN2XSZFcx/XO011yMKgmbFQ6iMS7KmYzIAKkeDEBNpMgge5v3aNIpHZHcoC97TU/nbBnM48YZIRq0ONDiJ9aYoT3680MwFQKZseem0927Xu6p/lcryslloFuvLzCx/0mMtU0H2ghMBU0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOB1RTw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220D3C2BD10;
	Thu, 23 May 2024 06:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716447045;
	bh=EsgKr2+15JU23386C02AiaPX82NABHkp3oBufrNJeLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aOB1RTw63RqL0BbGW60bu5BO0B7L9tVOMackeER5+2CY4tKejCceupNgyj32hn5cp
	 niqoR3j5B8bz6FZQZKAXhhL/hUQ3mzn2s0E0TyapXxvnWEi/VHDwmB8YBABkkiUnA6
	 uuZHlkb4qBTRJZwN0zy0b0XNxnldrLFR9uxM4emOKjvsHCgTszWrdLwQSXIjN8f5P8
	 fOr7c0if/bF3y/+xikF+CLjEwG5ix2Se2NN8fAXozza/T6bODy+STmFULgPV0iOhXh
	 so4kE+4kXOV/OEMNRos+nitdmA9nYDCmc8Iba9j3lYTxlfb0EbpviMJrs6Au/xxp33
	 jqm3NiY5Au5Bw==
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
Subject: [PATCH bpf-next 4/8] selftests/bpf: Replace tx_prog_fd with tx_prog in test_sockmap
Date: Thu, 23 May 2024 14:50:00 +0800
Message-ID: <23b37f932c547dd1ebfe154bbc0b0e957be21ee6.1716446893.git.tanggeliang@kylinos.cn>
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

bpf_program__attach_sockmap() needs to take a parameter of type bpf_program
instead of an fd, so tx_prog_fd becomes useless. This patch uses a pointer
tx_prog to point to an item in progs[] array.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sockmap.c | 30 ++++++++++------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index d7581bbbc473..8e32d157bac0 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -954,7 +954,8 @@ enum {
 
 static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 {
-	int i, key, next_key, err, tx_prog_fd = -1, zero = 0;
+	int i, key, next_key, err, zero = 0;
+	struct bpf_program *tx_prog;
 
 	/* If base test skip BPF setup */
 	if (test == BASE || test == BASE_SENDPAGE)
@@ -1015,27 +1016,27 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 
 	/* Attach txmsg program to sockmap */
 	if (txmsg_pass)
-		tx_prog_fd = prog_fd[4];
+		tx_prog = progs[4];
 	else if (txmsg_redir)
-		tx_prog_fd = prog_fd[5];
+		tx_prog = progs[5];
 	else if (txmsg_apply)
-		tx_prog_fd = prog_fd[6];
+		tx_prog = progs[6];
 	else if (txmsg_cork)
-		tx_prog_fd = prog_fd[7];
+		tx_prog = progs[7];
 	else if (txmsg_drop)
-		tx_prog_fd = prog_fd[8];
+		tx_prog = progs[8];
 	else
-		tx_prog_fd = -1;
+		tx_prog = NULL;
 
-	if (tx_prog_fd > 0) {
+	if (tx_prog) {
 		int redir_fd;
 
-		err = bpf_prog_attach(tx_prog_fd,
-				      map_fd[1], BPF_SK_MSG_VERDICT, 0);
-		if (err) {
+		links[4] = bpf_program__attach_sockmap(tx_prog, map_fd[1]);
+		if (!links[4]) {
 			fprintf(stderr,
-				"ERROR: bpf_prog_attach (txmsg): %d (%s)\n",
-				err, strerror(errno));
+				"ERROR: bpf_program__attach_sockmap (txmsg): (%s)\n",
+				strerror(errno));
+			err = -1;
 			goto out;
 		}
 
@@ -1285,9 +1286,6 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 			bpf_link__detach(links[i]);
 	}
 
-	if (tx_prog_fd > 0)
-		bpf_prog_detach2(tx_prog_fd, map_fd[1], BPF_SK_MSG_VERDICT);
-
 	for (i = 0; i < 8; i++) {
 		key = next_key = 0;
 		bpf_map_update_elem(map_fd[i], &key, &zero, BPF_ANY);
-- 
2.43.0


