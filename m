Return-Path: <linux-kselftest+bounces-10604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91C88CCC76
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 08:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742812839E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 06:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007C613C838;
	Thu, 23 May 2024 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eby2GAoI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01FEC5;
	Thu, 23 May 2024 06:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447027; cv=none; b=UoSX9bYtZDOv34bU2RTnt/5FDYgPtTQ7PQtj9JFHbcebFvCRnHdImv8h7Z8fAwYkrDJrL0IU4tOEJNHXC/aDyV5dSAXUrNmOOtliRVC9u8THYj52q0crvSGcdnjBkysKsE36BrW4fo8RziCGfPaVXkH/WVVimDcQFka2+Hn5+6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447027; c=relaxed/simple;
	bh=jzxUYLvnv6hkKSXo/p1R8ovUX+pIaKQO539KVGwiG20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJB/PUHdx1ahuXv+9XvpEqkY5x5WR182yduu3UN5wN9ohUE1qx6+CCE4s475Nlc9N6sMt8NXPIhUcZ0pKYszJ/+ixMSALFuuk0UlQbPscmzgRf5+QGN84qM9c2behVeGjoQq1yoTxaQ20gQIDq4yLOHS9Rc5ZajwBwsAl/rlWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eby2GAoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A0FC2BD10;
	Thu, 23 May 2024 06:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716447027;
	bh=jzxUYLvnv6hkKSXo/p1R8ovUX+pIaKQO539KVGwiG20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eby2GAoIUIjb8+GelMPK80DThcXma/TaB4tdAg9Dpz9a+WQTRkAcbgDP7JRq/3XSM
	 9n0t59bQ7UOMVEtXr9596kjARqSzS9f0sKa4gZZxoXQs2pv6IjdSztgxu2lXaqUl0+
	 8elsjNjnh5H0IFne3CAlB+/tVA5h1ytfwYaqGyZtrOTW58f9YiaMjKW6lrB2SgoizY
	 6u7U1G4IhLJoexVXqZWXpasiaYDyKQsPW3vW+vis2DpMa6/puBwpecS/0jP7qez3g3
	 KvqraSfxxqatgmTSmAkqSs+9cxE/rUBp0sycnL5zUDE/6f5VlKz7tmrV5DMdX83v2c
	 6wZpRG1NZZyXA==
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
Subject: [PATCH bpf-next 1/8] selftests/bpf: Fix tx_prog_fd values in test_sockmap
Date: Thu, 23 May 2024 14:49:57 +0800
Message-ID: <08b20ffc544324d40939efeae93800772a91a58e.1716446893.git.tanggeliang@kylinos.cn>
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

The values of tx_prog_fd in run_options() should not be 0, so set it as -1
in else branch, and test it using "if (tx_prog_fd > 0)" condition, not
"if (tx_prog_fd)" or "if (tx_prog_fd >= 0)".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sockmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 4499b3cfc3a6..fde0dd741e69 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1027,9 +1027,9 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 	else if (txmsg_drop)
 		tx_prog_fd = prog_fd[8];
 	else
-		tx_prog_fd = 0;
+		tx_prog_fd = -1;
 
-	if (tx_prog_fd) {
+	if (tx_prog_fd > 0) {
 		int redir_fd, i = 0;
 
 		err = bpf_prog_attach(tx_prog_fd,
@@ -1285,7 +1285,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 	bpf_prog_detach2(prog_fd[0], map_fd[8], BPF_SK_SKB_STREAM_PARSER);
 	bpf_prog_detach2(prog_fd[2], map_fd[8], BPF_SK_SKB_STREAM_VERDICT);
 
-	if (tx_prog_fd >= 0)
+	if (tx_prog_fd > 0)
 		bpf_prog_detach2(tx_prog_fd, map_fd[1], BPF_SK_MSG_VERDICT);
 
 	for (i = 0; i < 8; i++) {
-- 
2.43.0


