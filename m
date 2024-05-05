Return-Path: <linux-kselftest+bounces-9476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886248BC047
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 13:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94821C20CF8
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 11:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380551804A;
	Sun,  5 May 2024 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTE24B5R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7417556;
	Sun,  5 May 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714909014; cv=none; b=Aa+dKFBJZUgUqfIAHSuGqNPkPD7RFsLVMnZ1y1X5yjozY8g6kPVkgvjA9MSrfV+1jQTT1FWmJMyZMiW+dti+kDXmdsA0Y2kVzowGjSgl9giXkvxfxNecImyJViPafUqSHQf0WeVKbe6LCNM14a02E1ab52qoz++6O21pU6YNiUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714909014; c=relaxed/simple;
	bh=r2H4ud/VlKHq3yNIYync+GN5J3XoWozHQYRqhhdu42U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sjx/UHM5eHE2o+M6IoMyNJZ27uARbhxB10VAFdWtDraCBRznsilLrq37iZp/6f6y9nQ1H/CvlHBVHSXSmGsuIx1Pk4czpVZYSZX+GyOGUypsD/iEA0kU97Aa5W6vATPvxmDu77dWZ7vpKGOslHAOqQemZfGg9xd+OSw30fzV9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTE24B5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B2DC113CC;
	Sun,  5 May 2024 11:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714909013;
	bh=r2H4ud/VlKHq3yNIYync+GN5J3XoWozHQYRqhhdu42U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jTE24B5R32/ZFizyn8/hocIvGfCs+m4Im2pJiUbWKsEjKZ1xvnX5wt7T17NBQT8md
	 kucXCFav8qK0ntHjQndjVNjiJMWoC4n1XFRV8jMmkdM63ly4Uhxyy0ML5hNB9abYXW
	 5pDW8C9DrP50lI+FhRStb9knZgel0irZPLb8y2G25OwGPLB6T+5BHB7B/KIt7scfaU
	 aHtXl5FLmCmI87IAK/a/7H4Gb7uFaOujMtTWhF5JpcuWnc5eLCHAGxeoHgVbj58fDa
	 9qZaE4R8uuN4AJmo+N4h+HI3tTwpnKtjGpTT7Z80vA+Dq5CwAV/P5D4zcdBhtLuWq0
	 ZFB0vfRJi1EAg==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next 6/6] selftests/bpf: Drop get_port in test_tcp_check_syncookie
Date: Sun,  5 May 2024 19:35:13 +0800
Message-ID: <a9b5c8064ab4cbf0f68886fe0e4706428b8d0d47.1714907662.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714907662.git.tanggeliang@kylinos.cn>
References: <cover.1714907662.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The arguments "addr" and "len" of run_test() have dropped. This makes
function get_port() useless. Drop it from test_tcp_check_syncookie_user.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../bpf/test_tcp_check_syncookie_user.c       | 21 +++----------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
index b928474f3bf9..7b5fc98838cd 100644
--- a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
+++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
@@ -139,21 +139,6 @@ static int run_test(int server_fd, int results_fd, bool xdp)
 	return ret;
 }
 
-static bool get_port(int server_fd, in_port_t *port)
-{
-	struct sockaddr_in addr;
-	socklen_t len = sizeof(addr);
-
-	if (getsockname(server_fd, (struct sockaddr *)&addr, &len)) {
-		log_err("Failed to get server addr");
-		return false;
-	}
-
-	/* sin_port and sin6_port are located at the same offset. */
-	*port = addr.sin_port;
-	return true;
-}
-
 static int v6only_true(int fd, const struct post_socket_opts *opts)
 {
 	int mode = true;
@@ -214,19 +199,19 @@ int main(int argc, char **argv)
 
 	server = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr4,
 				   sizeof(addr4), NULL);
-	if (server == -1 || !get_port(server, &addr4.sin_port))
+	if (server == -1)
 		goto err;
 
 	opts.post_socket_cb = v6only_true;
 	server_v6 = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr6,
 				      sizeof(addr6), &opts);
-	if (server_v6 == -1 || !get_port(server_v6, &addr6.sin6_port))
+	if (server_v6 == -1)
 		goto err;
 
 	opts.post_socket_cb = v6only_false;
 	server_dual = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr6dual,
 					sizeof(addr6dual), &opts);
-	if (server_dual == -1 || !get_port(server_dual, &addr4dual.sin_port))
+	if (server_dual == -1)
 		goto err;
 
 	if (run_test(server, results, xdp))
-- 
2.43.0


