Return-Path: <linux-kselftest+bounces-7544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D157689EC0F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A8F1F21C04
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5E113D25C;
	Wed, 10 Apr 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwfIvGjH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DACB13CFA1;
	Wed, 10 Apr 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734271; cv=none; b=tJfz+RqZEf+kEaav5I/Axj0z8V2olzB+K9SL3xhoI+sLjMveNS5oFT6bYXAdf6y86cVQ15RLuJRd0mU84RqVOEClorh6ruXhbkAc+Uzos7vwd1XyAh/JOOyYm+Zp0lSJJz5uXbVko4v/4ZGqqLrhDGjPHUZgl031tU6Zn/OvIHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734271; c=relaxed/simple;
	bh=yZjR/xeezxILen9lY9+6wkHKExavQ/iubE/fh5VTeiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tOQpvYKOIQsbzjBKe3J3emMF4WUCUWVyQqEo5PD9bi5Ja4c3mjuE75+w3SrBHSCJwL8vpzdrjRDkhLrVrUWXN0L+o123bGaSYfASYMvYuV6wl91OAhF/PXh6UhoN9rroVAK/L1BE1RxGkbvtX1H3amfu11wwS5z/l0Im1ESmd4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwfIvGjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56189C43390;
	Wed, 10 Apr 2024 07:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734270;
	bh=yZjR/xeezxILen9lY9+6wkHKExavQ/iubE/fh5VTeiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NwfIvGjHz6lk/GwyeSH/PJHH9+X+oCSOGy0SnBwdLfxZ948IHhXVwpnirwrR/JBJK
	 ksa1Rl9+MF0LJGIigHe42jd7dUg7Ny7DMajrcb+D3P1ym2hKTlO97fCOdZLzkrwjtz
	 r0cgsNn3HEYlpeMnaHeJQNGmAU3JIz0CBMsG+Wf74eYa2IkGl4aNWLMYAFR3uRW8o3
	 tSZjcqvflVEXYqlydZVj7fD62X0o0yxxu+194K+TNj/xmMq3Lp5xNUE8SptN0IvP4v
	 gznXsM5e35kiFmpHwYPpW/ijKksaOArepxGZO617EJ9MpSlJPwVRS3lWyF47KEmArc
	 muG+Guew+lDqQ==
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
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 12/14] selftests/bpf: Use connect_to_fd in sockopt_inherit
Date: Wed, 10 Apr 2024 15:29:45 +0800
Message-Id: <e9f46389418c420f1560e7786c2e9af1fd15bd4f.1712733999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712733999.git.tanggeliang@kylinos.cn>
References: <cover.1712733999.git.tanggeliang@kylinos.cn>
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


