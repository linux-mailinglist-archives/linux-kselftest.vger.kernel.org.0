Return-Path: <linux-kselftest+bounces-13219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD03A9280C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 05:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77267286C1A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 03:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451D271750;
	Fri,  5 Jul 2024 02:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us8zZ8TL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDE81C693;
	Fri,  5 Jul 2024 02:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720148331; cv=none; b=MJtceDrQxAIDna02ANxIC33FflzSqonX4ceBJjh5XzBheFS+Aq/r6K6Y03mptObxp3nalzYIKbAKLI0A3na0yws8wyW6wzJlAzMkSXJUKEUq9uESrPwYukmTOWOOORzIwNCiLoniQQ4FeCuOsRmfEZyx+wi9cByJot3tFSoCE5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720148331; c=relaxed/simple;
	bh=bAX1OLxg4DkksZvjRAzn/L1GhmwINGXrUi0DgLiNpt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGUTo69HOz0eAprp87Db4P9lsrmsuz9kBuEGtMC297QX3duMZWhOzeLopDH/XCFIAic2v4GcGb3kQgNbr12DCLETYP/8mJU2+DuEDuSg2FGp8rPjcYQermhUC929yjUo+XI6QTG3zcoVzCesCxGjxQXhpOotgtUFK7CAt11w8dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us8zZ8TL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE90C4AF0D;
	Fri,  5 Jul 2024 02:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720148330;
	bh=bAX1OLxg4DkksZvjRAzn/L1GhmwINGXrUi0DgLiNpt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=us8zZ8TL6HY58PbFV2b4kKvqeofS9BDLqTUALIpmnkmDJ8IAbUjUDIg0xjQlbayZI
	 xGTQ2Fm6BIOHs6Zk/lznk7jhMBhOFkW7fJzUHOiSfBGzHDhes8+v1k9spoRSHubUOL
	 r6f/C44JWHVetoAeMVaPyqLS2kpbU9HL1V8gOc9LZejxeKEcXMAglNhk0wX1PxhLHm
	 B1YOCChqfCk57nc4eBKWkn5U/7EafGlfWJZ1WSisl4zmo244f7gfWADbw1aAORLwgn
	 6nblum7YtWyDC+Pj2F2WrLX77DnZIayK5e4y7ADOtPKmKIhtRR7/ElzTuVmrVmdlh5
	 dQk4ShznAb6og==
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
Subject: [PATCH bpf-next v8 1/9] selftests/bpf: Add backlog for network_helper_opts
Date: Fri,  5 Jul 2024 10:58:23 +0800
Message-ID: <e8726f4ec0740c78416eb3a5a02921071f2f1d3a.1720147953.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720147952.git.tanggeliang@kylinos.cn>
References: <cover.1720147952.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Some callers expect __start_server() helper to pass their own "backlog"
value to listen() instead of the default of 1. So this patch adds struct
member "backlog" for network_helper_opts to allow callers to set "backlog"
value via start_server_str() helper.

listen(fd, 0 /* backlog */) can be used to enforce syncookie. Meaning
backlog 0 is a legit value.

Using 0 as a default and changing it to 1 here is fine. It makes the test
program easier to write for the common case. Enforcing syncookie mode by
using backlog 0 is a niche use case but it should at least have a way for
the caller to do that.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 2 +-
 tools/testing/selftests/bpf/network_helpers.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 44c2c8fa542a..e0cba4178e41 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -106,7 +106,7 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
 	}
 
 	if (type == SOCK_STREAM) {
-		if (listen(fd, 1) < 0) {
+		if (listen(fd, opts->backlog ? MAX(opts->backlog, 0) : 1) < 0) {
 			log_err("Failed to listed on socket");
 			goto error_close;
 		}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 9ea36524b9db..4f26bfc2dbf5 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -25,6 +25,10 @@ struct network_helper_opts {
 	int timeout_ms;
 	bool must_fail;
 	int proto;
+	/* The backlog argument for listen(), defines the maximum length to which
+	 * the queue of pending connections for sockfd may grow.
+	 */
+	int backlog;
 	int (*post_socket_cb)(int fd, void *opts);
 	void *cb_opts;
 };
-- 
2.43.0


