Return-Path: <linux-kselftest+bounces-12124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38DE90C2B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 06:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A238C28260A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 04:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EB1199259;
	Tue, 18 Jun 2024 04:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4Z/UG/T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF115532B;
	Tue, 18 Jun 2024 04:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718683697; cv=none; b=HXzuy0x64RGnb2+SmdsEComJxru+mqZB3/11pm2P8QxK561IyjnNCQ6sqvs3Cknb0d+h1qSy8E5eWAC9SFXm+Iuudny9w5tNSOBvmhgCGHyFmX6TLMp36n3EyYWt3VWq+VGbkdAazrAaL2fwxfZGMfM/faoyYZSzMMAinAzc9KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718683697; c=relaxed/simple;
	bh=ek0iCBSuhwxmBUkXZ25YiD2CARKWMEhFftoQUiEh56g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNk8I8Jpm2wpS0AlOan8n/qR2J4EBdVLB74n0M3uaThuTUSfmNoZwEcNFhF9e2YfkiHR2tl30jPPmmYTiwlB8Z5JTlUcgmMMHQowJ0nY/0y1HVFiBvholcqJjtaqOIKAimWHc6uj3vbJAOWQ7L5eH2FvkFF+uIe2bPBDhnzY7Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4Z/UG/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A859CC4AF51;
	Tue, 18 Jun 2024 04:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718683696;
	bh=ek0iCBSuhwxmBUkXZ25YiD2CARKWMEhFftoQUiEh56g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4Z/UG/T7SUK8hVg9+Z5E4EY/NLjAMgD5PbeatzY0Kk48bEjsEviq40KyMPSyi0jU
	 NrP9BCnMDIQ4AagiGefw8+sa0DTssBuEn6yo7Ag5H6ZYrJlQFqRLK4fCzKg/1sO4su
	 JnAS2ZNCFy1e/cMmu0ZQ5xQR0RLaL63yHNZ7/Rxu+3vHQWYbvkQJZGv/EDCZUaPEb2
	 0PIAVM7kU32EfE65rsBVIOxKkbjHxzWwJ621knVJ06UyhdO9MFsq2dwy4cn+5d5O8x
	 Cx3HchCng0+p0cpyWRnb+5AgDvHVwYMtW/sP4/0cxfDfZVtLiaXAmWYKUd6IzM/sMo
	 Zrn5g/XoCvb8A==
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
Subject: [PATCH bpf-next v4 6/6] selftests/bpf: Use start_server_str in test_tcp_check_syncookie_user
Date: Tue, 18 Jun 2024 12:06:56 +0800
Message-ID: <8cb3e3d02ff076666492e30a5e75098c8124519e.1718683292.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718683292.git.tanggeliang@kylinos.cn>
References: <cover.1718683292.git.tanggeliang@kylinos.cn>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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


