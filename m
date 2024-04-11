Return-Path: <linux-kselftest+bounces-7658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7BF8A0543
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9A01F23471
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B35604D5;
	Thu, 11 Apr 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj2O03XG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A209F3201;
	Thu, 11 Apr 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797491; cv=none; b=LBjoNtPaIaR7zI9G2SY4UsOg2uahAg4K5vlzxNhcNknJyh55u1aVpkLdU5CTAakqt2aTaOIF/BtVR/nkkQK3+gs09ToRpbQS+9mG++pnVhhxLCmrmyZNCQIz5uvm41u4w6NT11nYke4d3oYC4pBqE+CJwHtDyQzGy1Oa0W64X2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797491; c=relaxed/simple;
	bh=yZjR/xeezxILen9lY9+6wkHKExavQ/iubE/fh5VTeiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JRyrMQgfxH304s8po/Gy3EhUMR5G64qvRyjzrQWlcrcLGUu0F0b5ocwBfKMnZdaIVyEZeIFsyviZU3dHqa7qRVloirzopXi69rmeTMif9zJBiOuMlQDo8qsYJ7lZ8tdy3cAmxJmAClcDadJsS1EHvbt/+8S/ue5/Yw8QwS98oO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj2O03XG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3831C43390;
	Thu, 11 Apr 2024 01:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712797491;
	bh=yZjR/xeezxILen9lY9+6wkHKExavQ/iubE/fh5VTeiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jj2O03XGQpv2o+hE6boqz64HokWnzTXXKyD4Ooks7rPvQXu9zuCPd3qDnGi5tIw09
	 mnnt5wPUjIF4HZ3jRxlqrCR3aWrXzNJi004P3ztvataey6Jqo2t8Bww+vLY95CfKAD
	 UD4dr+Yt3jOBFC4mISZEus/p8sa8F93oGo1/PdXdAbD11Nz8u6b7eDYHENIwp5gJ4b
	 X/8zuXChZPqS5I/jP0N3/LHVv8RKy5yHFLdr2mKIKJpeuBPyrAeMt0CFBMnHA7QdCy
	 Fv2Mj391p1TzGKj/iS2L1ipdiDBWeJNrcxtFzVOjIsexZqzxlYwTPvVFwbf9OMprIJ
	 PNEQ0+z6BSsXA==
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
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 12/14] selftests/bpf: Use connect_to_fd in sockopt_inherit
Date: Thu, 11 Apr 2024 09:03:20 +0800
Message-Id: <be14ebdf824fd093b24b8751cc8d171fe09f5019.1712796967.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712796967.git.tanggeliang@kylinos.cn>
References: <cover.1712796967.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper connect_to_fd() exported in network_helpers.h
instead of the local defined function connect_to_server() in
prog_tests/sockopt_inherit.c. This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../bpf/prog_tests/sockopt_inherit.c          | 31 +------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index f000d9229765..4fee4b343255 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -10,35 +10,6 @@
 #define CUSTOM_INHERIT2			1
 #define CUSTOM_LISTENER			2
 
-static int connect_to_server(int server_fd)
-{
-	struct sockaddr_storage addr;
-	socklen_t len = sizeof(addr);
-	int fd;
-
-	fd = socket(AF_INET, SOCK_STREAM, 0);
-	if (fd < 0) {
-		log_err("Failed to create client socket");
-		return -1;
-	}
-
-	if (getsockname(server_fd, (struct sockaddr *)&addr, &len)) {
-		log_err("Failed to get server addr");
-		goto out;
-	}
-
-	if (connect(fd, (const struct sockaddr *)&addr, len) < 0) {
-		log_err("Fail to connect to server");
-		goto out;
-	}
-
-	return fd;
-
-out:
-	close(fd);
-	return -1;
-}
-
 static int verify_sockopt(int fd, int optname, const char *msg, char expected)
 {
 	socklen_t optlen = 1;
@@ -168,7 +139,7 @@ static void run_test(int cgroup_fd)
 	pthread_cond_wait(&server_started, &server_started_mtx);
 	pthread_mutex_unlock(&server_started_mtx);
 
-	client_fd = connect_to_server(server_fd);
+	client_fd = connect_to_fd(server_fd, 0);
 	if (!ASSERT_GE(client_fd, 0, "connect_to_server"))
 		goto close_server_fd;
 
-- 
2.40.1


