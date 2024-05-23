Return-Path: <linux-kselftest+bounces-10605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748D88CCC78
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 08:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFBC281C81
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 06:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A503B13C8E1;
	Thu, 23 May 2024 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfC1r6kG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7955D13C838;
	Thu, 23 May 2024 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447033; cv=none; b=NEjOZNtTHB37z+JwTIqa2TuMlwSZRQq0r4br+fsHr66T8ysekJRv8JBnE5eNmwxrhEF6tLl1nlXKmD51wJbFOQ1ai0/Wvxb9ymx9vOvx4JWgU08NzMBS3eQI7N85EdO4PAhOY6YUlDUQRZwxz6MLes8qpVwCqG+BYqD8tUsNRZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447033; c=relaxed/simple;
	bh=42iO5udp2Ibn41SCzR7Waf2A6G0d38SJCLI0k7E2p9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwqwGHAmxdjqrJ2SvsYD4WDLzYcVmqXsTum0F4lEHFi0FEbpHj5vfoIqruYdIHH0CMou5hMYjBdtezUAwLe6tUEGnFTIRbvPTZQhOpKKDiWUikhXFXw6YmOVpNM1YIKtUMAoemLiCcM6lS5FLyVTlNDZ7IlOdimVt2TLgpJ4uIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfC1r6kG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D083C2BD10;
	Thu, 23 May 2024 06:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716447033;
	bh=42iO5udp2Ibn41SCzR7Waf2A6G0d38SJCLI0k7E2p9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rfC1r6kGtHRqIpoIVkdw8w355iSN31tdhJ5/4cnHIakh2Y/fIHVpFgS/efrk9SOD1
	 EiC7x21WWKCZmW8n+bL8eOyEXvWF09I8U41Kh0HCsJ4AIBx9wDejfLglz87lSDm6Iv
	 646TusHdPuc/eK0e95q7Y+I1eRdwmeAdZiiW8KhXNLAeC+uXD+FyjKe8Kf+IedBimM
	 yFs3A6hLTM6QVPZTrY07ozqJcM3VSEQk67DaD1zk1TzVkSR+Ey+bgtYZtfXefOZxiv
	 se1wC688HbQFx0NCZCDqe3UQw4Y3uaqNkwKCuiI81xnJqpPTl6mNQcIrnAC0h4SAp7
	 8b3yB/7aR+tTg==
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
Subject: [PATCH bpf-next 2/8] selftests/bpf: Drop duplicate definition of i in test_sockmap
Date: Thu, 23 May 2024 14:49:58 +0800
Message-ID: <8d690682330a59361562bca75d6903253d16f312.1716446893.git.tanggeliang@kylinos.cn>
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

There's already a definition of i in run_options() at the beginning, no
need to define a new one in "if (tx_prog_fd > 0)" block.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sockmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index fde0dd741e69..e7dbf49a2ca6 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1030,7 +1030,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 		tx_prog_fd = -1;
 
 	if (tx_prog_fd > 0) {
-		int redir_fd, i = 0;
+		int redir_fd;
 
 		err = bpf_prog_attach(tx_prog_fd,
 				      map_fd[1], BPF_SK_MSG_VERDICT, 0);
@@ -1041,6 +1041,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 			goto out;
 		}
 
+		i = 0;
 		err = bpf_map_update_elem(map_fd[1], &i, &c1, BPF_ANY);
 		if (err) {
 			fprintf(stderr,
-- 
2.43.0


