Return-Path: <linux-kselftest+bounces-12962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBF491CA02
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 03:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B6BB21788
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 01:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FA62139C7;
	Sat, 29 Jun 2024 01:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsMjIwNU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC91184F;
	Sat, 29 Jun 2024 01:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719624070; cv=none; b=gfMiztmDSciDtmtaoqLUDI9+HIIuV7oZt41rFmSwc9u3Zxgdr3N02pcJamPYvsBF+L8/O0L8+i1nV1kS87gH7BaoDV+i1mKgwWp9b35E9Hj4+TX9we/OmHlC41RHGlifCbZuEvQoC2dJtu93H2het7x+9JfhzpSm4dY22K4HKhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719624070; c=relaxed/simple;
	bh=ZCeE8Z/nWEd6sWEM1dJoxrwtrvc9O31RPAo+rMnD5HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxCMzYBCbkr6kUUhJeyII/obX7IyX1EMPVUsyYGwE1t9PEdc9fMpZlulSiG9HGOXcty7Vy+7cTTK0wS+FYQ5MSPVDVqXKDPfsinoOVs0CMi3DuTwC0zGrruolSb8unOJRzL19Jx1FXm4Ff/AjqoTUf0A+39IcpdcFr3RCnMSXM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsMjIwNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AECDC116B1;
	Sat, 29 Jun 2024 01:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719624070;
	bh=ZCeE8Z/nWEd6sWEM1dJoxrwtrvc9O31RPAo+rMnD5HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CsMjIwNUoWtCLATMaLanZ3YcPRd+DSSHY/cNOsWWHDnIzihhXDiaCJ1tATRPtQFB9
	 d+RONX5HZ8U0gNpayF9GZlZfrBLeCG4sk1LLB9zosIBU0wOZo+xfrPTRvIwonS/7L5
	 yEw6qAh+1pdMSdFRcBuDRoUJMf397uEcYW2aOxYWzqaIdRRqOP5Jpr+6mr3N4jdKFK
	 If7wMYqBqKRnHBiQZEWGSqdR3jJDuBxM4Rh/V0Q4qb0GiMvFEt1OEF871ja+ulMsgt
	 IOVELM339zKRGf27Lw25LbWJ5YiwuFapt1L+g8uUnDtquftgVsBjjX87ojwnrS0Q61
	 5ID4CNbAqkbdQ==
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
Subject: [PATCH bpf-next v6 7/9] selftests/bpf: Use connect_to_fd in sk_lookup
Date: Sat, 29 Jun 2024 09:20:17 +0800
Message-ID: <c75727e67d72f801aedbd5e2878df9d5e7679d77.1719623708.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719623708.git.tanggeliang@kylinos.cn>
References: <cover.1719623708.git.tanggeliang@kylinos.cn>
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
index 5939be51c928..38382dffe997 100644
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


