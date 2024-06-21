Return-Path: <linux-kselftest+bounces-12391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50380911863
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 04:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E512822E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 02:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E31083CD2;
	Fri, 21 Jun 2024 02:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i94PA+uf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240BB82D69;
	Fri, 21 Jun 2024 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936214; cv=none; b=p4npQJZ7sUryK0VPQmRpndrXY5njlio3mj4njct5AwFg5PcN97FcC1uxx49fpnDkKtqnYjqWh+N2NYAvUHmFVgebWduTOjaoOiftvSYByy1ApRAEU6YZsaLAUBnkV09ps8mczc9z0mUp/BuALZ1RuEhYozLG1SB/BRw7cbfCQMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936214; c=relaxed/simple;
	bh=fXayRlWFDY5aPy5AeVtyjzVtSkEID71RDaXwe1KsrSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRNK2gGYT2zxyE4ELYnq5aJQcsaUPWBdmbWv0cFRNE87NsqK916+TEYvi+D1og/l6FthJqpS6Qn5lJsL+4wBFknfgNnkKdbg505YqxVGHDf6fpozojVvTQavAYXj4fSO0UNFv6T0/TXeKgKXToVWO/+SVfz4sGHh7JOfQCU/L9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i94PA+uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586A8C32786;
	Fri, 21 Jun 2024 02:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718936213;
	bh=fXayRlWFDY5aPy5AeVtyjzVtSkEID71RDaXwe1KsrSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i94PA+ufFV20yf/ilHOWYg/knXeZ3oogPzeWZxAJR6V4T5oEAlH8yFc1/ch1bT9PG
	 sME2fdzOCJbXjAkFLT7xbJ7xd5E8vOsqq7/0w4qHSv2dhgAR5m73KqpnGtvoym6o8Q
	 S9YIL8Y2ChrtaO+Wn1DlD7pqXqbWZKzUJ2ON/xz66KcP8VmoxlDMmJWfGkla7zWXgy
	 wu1wQs1qb2Nq1xNRIirPrgln1peeaq72JnbH7+0S3fquwiM4HnAkKvtSEBab7Mupfs
	 IB0EKjl8oV3bHpYEV+u+1rOUCS4h52xpWMkPG/1H54V6gQpWbfHN2u7l7QainIyDjc
	 TseTIxKY25Q2w==
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
Subject: [PATCH bpf-next v6 6/6] selftests/bpf: Use start_server_str in test_tcp_check_syncookie_user
Date: Fri, 21 Jun 2024 10:16:03 +0800
Message-ID: <5d2f442261d37cff16c1f1b21a2b188508ab67fa.1718932493.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718932493.git.tanggeliang@kylinos.cn>
References: <cover.1718932493.git.tanggeliang@kylinos.cn>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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


