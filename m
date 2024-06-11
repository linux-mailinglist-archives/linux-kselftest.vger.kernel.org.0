Return-Path: <linux-kselftest+bounces-11631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7071902E29
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EAD284E3E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 02:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4835661;
	Tue, 11 Jun 2024 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqmQMO3d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86213C00;
	Tue, 11 Jun 2024 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718071236; cv=none; b=iF1wQB1o7ZxGpF2UkihcuYFyBCkr8LD61lUn0S/4MTiexyqbI4NhVhpXTkztn3Y0+Rh/T3dx6TnpVIiJYGP6eQFx/3mLdlZFkgwvuFMuaH1t+yJ8Pk3Ker4KIzD+fhVL7cHzYSo72Bh6GTWSVlaF9CwWm2wADegbPkLKNEUX9lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718071236; c=relaxed/simple;
	bh=HEbzerycj4AKQiB0vafBFrk8TauCU0t7sQlhkaeae6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pz+oz5ND6jjR+BLSsFB/lvBysifb5U9yGpgd9TGewgqdWPTO6vAayVvY9poLtQa5OugYnKaOqErIQpFd02l48YLe8CJd/eNXb0MTR3vgX1+QGsGr3+/f7th7BNGnXpRmz/opExitq4Zgk9Vgz1uvPxL61PDpOJLojTHh5/4LJ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqmQMO3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E630C2BBFC;
	Tue, 11 Jun 2024 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718071236;
	bh=HEbzerycj4AKQiB0vafBFrk8TauCU0t7sQlhkaeae6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nqmQMO3dwkT/Pv7TxNB3wJBD/1aVV311glXFk8i+Y9+fY5pacVmXBwXTh5+LkscIj
	 RVJ1pY5Gm/Hh6wq2bcufsj/Df4X0dzM5b/xMPPseUxSD0yaylW0eAiQ4ruEMTKRojh
	 mp03XLFPFRe4wDiW8xRyVspKzMle75ZqrZkej7z9+FBD85K3sioTt8zX4Y7lMTE7QP
	 hmX7IKjHjpvS7TjIz6OjGfrbyr5Jw4oqbUjKH44BtnLa81F598aA3K33+r193tgzQK
	 tM3ei4NV5BF0wG05ioxD/DNBGePBv07+E0cxpRchK2hQgudml+eXP12pRBOVvXfitr
	 2GVNBj6h62EYA==
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
Subject: [PATCH bpf-next 5/5] selftests/bpf: Use start_server_str in test_tcp_check_syncookie_user
Date: Tue, 11 Jun 2024 09:59:38 +0800
Message-ID: <39358e8cb8b91db5587d6e5ce735d12279981732.1718070940.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718070939.git.tanggeliang@kylinos.cn>
References: <cover.1718070939.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Since start_server_str() is added now, it can be used in script
test_tcp_check_syncookie_user.c instead of start_server_addr() to
simplify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../bpf/test_tcp_check_syncookie_user.c       | 29 ++-----------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
index aebc58c24dc5..3844f9b8232a 100644
--- a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
+++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
@@ -156,10 +156,6 @@ static int v6only_false(int fd, void *opts)
 int main(int argc, char **argv)
 {
 	struct network_helper_opts opts = { 0 };
-	struct sockaddr_in addr4;
-	struct sockaddr_in6 addr6;
-	struct sockaddr_in addr4dual;
-	struct sockaddr_in6 addr6dual;
 	int server = -1;
 	int server_v6 = -1;
 	int server_dual = -1;
@@ -181,36 +177,17 @@ int main(int argc, char **argv)
 		goto err;
 	}
 
-	memset(&addr4, 0, sizeof(addr4));
-	addr4.sin_family = AF_INET;
-	addr4.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
-	addr4.sin_port = 0;
-	memcpy(&addr4dual, &addr4, sizeof(addr4dual));
-
-	memset(&addr6, 0, sizeof(addr6));
-	addr6.sin6_family = AF_INET6;
-	addr6.sin6_addr = in6addr_loopback;
-	addr6.sin6_port = 0;
-
-	memset(&addr6dual, 0, sizeof(addr6dual));
-	addr6dual.sin6_family = AF_INET6;
-	addr6dual.sin6_addr = in6addr_any;
-	addr6dual.sin6_port = 0;
-
-	server = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr4,
-				   sizeof(addr4), NULL);
+	server = start_server_str(AF_INET, SOCK_STREAM, "127.0.0.1", 0, NULL);
 	if (server == -1)
 		goto err;
 
 	opts.post_socket_cb = v6only_true;
-	server_v6 = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr6,
-				      sizeof(addr6), &opts);
+	server_v6 = start_server_str(AF_INET6, SOCK_STREAM, "::1", 0, &opts);
 	if (server_v6 == -1)
 		goto err;
 
 	opts.post_socket_cb = v6only_false;
-	server_dual = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr6dual,
-					sizeof(addr6dual), &opts);
+	server_dual = start_server_str(AF_INET6, SOCK_STREAM, "::0", 0, &opts);
 	if (server_dual == -1)
 		goto err;
 
-- 
2.43.0


