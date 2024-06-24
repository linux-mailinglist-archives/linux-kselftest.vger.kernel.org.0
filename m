Return-Path: <linux-kselftest+bounces-12540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4AC914122
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 06:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E4C2837E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 04:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4059D26D;
	Mon, 24 Jun 2024 04:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVQQaRIy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE24DDC1;
	Mon, 24 Jun 2024 04:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719203701; cv=none; b=MoY+srqrRmPA82ED0XxnpN374h90coi8Dag2vGJq4HEFhAiN+8lZsjG2ijhNXtBEyJmqjjPxttLybWdHTe8BedCPqBA/mcFGd3NkDAHYW0Lz4K2FCCbGQRPpMN1VL0D4+ew8BCaxglXYy4s1xe7owAjCEZHpvscyZk3GkxPDYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719203701; c=relaxed/simple;
	bh=24De1xKL58mJSoi6TfZj/WEwDXisabbp5ItsRB2yUd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKsjAKaNI/m15TilDiXSlITtAf2/uZghQvRqBdanW2TRREk+TEwygCEkLEyZRb7MclEBn+ZvCkoNt8XpR/dpYxekFq8la1JkxcZG8Qc53QsypMvHBCEFi1bUAQXnxEP30CRMaFasM5Vot/kSYZ+RYebxCy7xFURnKXzB4t//30Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVQQaRIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7042EC2BBFC;
	Mon, 24 Jun 2024 04:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719203701;
	bh=24De1xKL58mJSoi6TfZj/WEwDXisabbp5ItsRB2yUd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVQQaRIy62DSBHswtGtzyqHAIcoo5W0qH4b0ldMBh5K2zrq5d2zbFHkbU4G3t3jSA
	 SfA3s4h4RNqDQKRgPIlNSWTaHUpZrJRSq2RTNoaQ0R8eX4xGabqCHvU5Jmc2jbwe/G
	 mj6+OaisSvfOxqQUjRaUqjch72W2SPZ8oX2aR/xaI/vTTrCYIXA5DAx1XPeqOTNAQQ
	 2g/w2FGj4Bf/WcBEX3FIJ5gmlpdoailDVdZHJSkxJLMO6+Zb1CIK+0zFxVdbsy8IXG
	 qoID6uMITqWGHlSQkFI5+8HDg4uB2QjawqtsmajSqZP2uV32I2gszCpil5v2cs/KsA
	 P69AZs9reHgdg==
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
Subject: [PATCH bpf-next v4 6/9] selftests/bpf: Invoke attach_reuseport out of make_server
Date: Mon, 24 Jun 2024 12:33:53 +0800
Message-ID: <f846835a758f2e531026083253eeb747205bd0dd.1719203293.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719203293.git.tanggeliang@kylinos.cn>
References: <cover.1719203293.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In order to facilitate subsequent commits to drop make_server(), this patch
invokes attach_reuseport() out of make_server(), right after invoking
make_server() if the passed "reuseport_prog" argument is not NULL.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index de2466547efe..d87dfcf5db07 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -204,15 +204,6 @@ static int make_server(int sotype, const char *ip, int port,
 		}
 	}
 
-	/* Late attach reuseport prog so we can have one init path */
-	if (reuseport_prog) {
-		err = attach_reuseport(fd, reuseport_prog);
-		if (CHECK(err, "attach_reuseport", "failed\n")) {
-			log_err("failed to attach reuseport prog");
-			goto fail;
-		}
-	}
-
 	return fd;
 fail:
 	close(fd);
@@ -610,7 +601,8 @@ static void run_lookup_prog(const struct test *t)
 		server_fds[i] = make_server(t->sotype, t->listen_at.ip,
 					    t->listen_at.port,
 					    t->reuseport_prog);
-		if (server_fds[i] < 0)
+		if (server_fds[i] < 0 ||
+		    attach_reuseport(server_fds[i], t->reuseport_prog))
 			goto close;
 
 		err = update_lookup_map(t->sock_map, i, server_fds[i]);
@@ -636,7 +628,8 @@ static void run_lookup_prog(const struct test *t)
 		reuse_conn_fd = make_server(t->sotype, t->listen_at.ip,
 					    t->listen_at.port,
 					    t->reuseport_prog);
-		if (reuse_conn_fd < 0)
+		if (reuse_conn_fd < 0 ||
+		    attach_reuseport(reuse_conn_fd, t->reuseport_prog))
 			goto close;
 
 		/* Connect the extra socket to itself */
@@ -878,6 +871,9 @@ static void drop_on_lookup(const struct test *t)
 	if (server_fd < 0)
 		goto detach;
 
+	if (attach_reuseport(server_fd, t->reuseport_prog))
+		goto close_srv;
+
 	client_fd = make_socket(t->sotype, t->connect_to.ip,
 				t->connect_to.port, &dst);
 	if (client_fd < 0)
@@ -992,6 +988,9 @@ static void drop_on_reuseport(const struct test *t)
 	if (server1 < 0)
 		goto detach;
 
+	if (attach_reuseport(server1, t->reuseport_prog))
+		goto close_srv1;
+
 	err = update_lookup_map(t->sock_map, SERVER_A, server1);
 	if (err)
 		goto close_srv1;
-- 
2.43.0


