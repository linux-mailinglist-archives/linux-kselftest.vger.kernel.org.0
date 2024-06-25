Return-Path: <linux-kselftest+bounces-12615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066BF915E4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 07:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391B11C2257F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 05:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5112145B18;
	Tue, 25 Jun 2024 05:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjqgKQcM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B842143C67;
	Tue, 25 Jun 2024 05:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294203; cv=none; b=ess1mOhdn4RFaBmRtwqfrgzhjL+6zFfdvnlZyPfPnrx6zyYd6xlAZe1Zvfc9PWb5dOu3HgiMAjtBei+EjMe5Q7s40aLCE3DoqPwJV5OZoqMjBAHlkztPJunBTLH6p1Hp+MpBvXNi15mJtLZsmebzZ0DosN5C4bNEY1gKdmQkFHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294203; c=relaxed/simple;
	bh=b8plJjolo+WIbJNr4M4YV5ebpljqZyRuqrQVHyzM2eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pe3Ecofefl8vi2HeZyGBuw//9k8FAfxXrhAafPdxwpkTyhUNshGpQlzPLW16jw0ItYKcPUA3ncYYqOTHqTiDV/UAUqHotxm03ucnH5DIceRN8lDfM/djL4VpjHLz0OQoUkENs8Vi4b8q0Mnethmf1I21DGd9EHtLFBh/eXp7WGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjqgKQcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7269C32782;
	Tue, 25 Jun 2024 05:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719294203;
	bh=b8plJjolo+WIbJNr4M4YV5ebpljqZyRuqrQVHyzM2eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjqgKQcMN1Uiq0/XufJ2EBTa9SjlfakrM+YqtTQ6NbnmG2NhvDlT+QTj6P9bMU203
	 6MdcsRqjpmAsELjzgwuFH2n7wNVJvQvke89R9YEmjNU2AlyJMZaPAeTenBClY28wci
	 R+v3oDLY04PdrFpw3KqD5l8aa9/8EETpRG8OIVXxY+w9dvMicV4uHAIDt/TFdqgnBp
	 Xr3/FWBrthRGypW+/nuckZWPE5xcVmRUubSQxSAzkTI9AE7SsUZrWzo7E5/Gzq2Zfo
	 xE1E6SrMq7EEg/gOapWCuAFZBi/0BZqNFDCqhoXy5x2FuM+aj7cDEx7vwgEphp+5C7
	 issMxEeQ54Jyg==
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
Subject: [PATCH bpf-next v5 7/9] selftests/bpf: Use connect_to_fd in sk_lookup
Date: Tue, 25 Jun 2024 13:42:34 +0800
Message-ID: <546d7a0ee9fc633eb8b266e3866d14a8e172d196.1719293738.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719293738.git.tanggeliang@kylinos.cn>
References: <cover.1719293738.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper connect_to_fd() exported in network_helpers.h
instead of using make_socket() and connect() in prog_tests/sk_lookup.c.
This can simplify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/sk_lookup.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 91cba3bc784d..5a8b4ef876ef 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -874,7 +874,6 @@ static void test_redirect_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_lookup(const struct test *t)
 {
-	struct sockaddr_storage dst = {};
 	int client_fd, server_fd, err;
 	struct bpf_link *lookup_link;
 	ssize_t n;
@@ -888,12 +887,11 @@ static void drop_on_lookup(const struct test *t)
 	if (server_fd < 0)
 		goto detach;
 
-	client_fd = make_socket(t->sotype, t->connect_to.ip,
-				t->connect_to.port, &dst);
+	client_fd = connect_to_fd(server_fd, IO_TIMEOUT_SEC);
 	if (client_fd < 0)
 		goto close_srv;
 
-	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
+	err = 0;
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client_fd);
 		if (err)
@@ -988,7 +986,6 @@ static void test_drop_on_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_reuseport(const struct test *t)
 {
-	struct sockaddr_storage dst = { 0 };
 	int client, server1, server2, err;
 	struct bpf_link *lookup_link;
 	ssize_t n;
@@ -1012,12 +1009,11 @@ static void drop_on_reuseport(const struct test *t)
 	if (server2 < 0)
 		goto close_srv1;
 
-	client = make_socket(t->sotype, t->connect_to.ip,
-			     t->connect_to.port, &dst);
+	client = connect_to_fd(server2, IO_TIMEOUT_SEC);
 	if (client < 0)
 		goto close_srv2;
 
-	err = connect(client, (void *)&dst, inetaddr_len(&dst));
+	err = 0;
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client);
 		if (err)
@@ -1164,7 +1160,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 	if (server_fd < 0)
 		return;
 
-	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	connected_fd = connect_to_fd(server_fd, IO_TIMEOUT_SEC);
 	if (connected_fd < 0)
 		goto out_close_server;
 
@@ -1178,7 +1174,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 		goto out_close_connected;
 
 	/* Try to redirect TCP SYN / UDP packet to a connected socket */
-	client_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	client_fd = connect_to_fd(server_fd, IO_TIMEOUT_SEC);
 	if (client_fd < 0)
 		goto out_unlink_prog;
 	if (sotype == SOCK_DGRAM) {
-- 
2.43.0


