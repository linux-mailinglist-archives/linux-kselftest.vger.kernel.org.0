Return-Path: <linux-kselftest+bounces-11629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC0D902E25
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4713C2841A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 02:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA57F3C00;
	Tue, 11 Jun 2024 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdfrdtSO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF7AD21;
	Tue, 11 Jun 2024 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718071222; cv=none; b=nCTJD/IHp8JCmMfJbaRf0/iNA9R4XbZG2Tc7P0w1Fmoe7vTNCpAK1BGDt7t7y5Xzs1/BIOK0a2JaIVQnc+D5o2YlgZeWCiViOwxAWcDFiIrRJF3pn5RInsRWH7hQQxKUnJ4jPXRXV/XwceXasDntFOdXh7rMfwKSK5Z4de5mFZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718071222; c=relaxed/simple;
	bh=sdjlLBAsvE2W4eBhVZks7M8fUv20YbIs8/ERLLS59xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owA9MI8I0GAuRkxxia5ik44ZkglUTKp4IwZNlP/xBlYmoczlEKPoEE8WDxe1q0O/r7EjlsjqYt/ti9d4XflCe3Q3RyHBl0G96ompqs8pAPBY7GlZUZIEK0Od5afKI8ShsJzXHgOzxR9ZLVtyfkKI9y9moUxtO3O+wN6gywZ7lLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdfrdtSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2EEC4AF5F;
	Tue, 11 Jun 2024 02:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718071222;
	bh=sdjlLBAsvE2W4eBhVZks7M8fUv20YbIs8/ERLLS59xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CdfrdtSOagmZRRENoqnsqI8hEC1l//F0Cy0n/Mh1pzgjoR1eqLAqX/V0PHg1mfepG
	 94Xbibw+s/mrXhkRXc8HryAMFC/ktH92wQAOg7ybTsozmoNc5ZuP03I2QHsLEPv6Vm
	 d5RblyuZ2dFlq/p3qkEj2p0pJDIYP6Coep8bwNYWDjeuN91vgeDvU6PXH9UagMp3Oi
	 Tcq8ZQDJikyfHnz71ThDDJ0vUN2C7jsglaHyqMk2OJOsLk6tTP82ZD2HIvdkwXmkpV
	 ZaYFwd8ORhP+td9CT3KbVaRzVyJnF1PI5EuaHb+fB1eZe1LBFoI2p1w01euwN9giXK
	 TED9pBh0A8vgg==
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
Subject: [PATCH bpf-next 3/5] selftests/bpf: Drop must_fail from network_helper_opts
Date: Tue, 11 Jun 2024 09:59:36 +0800
Message-ID: <281d02d849e0f6bbf7b89f301301d0be5889107a.1718070940.git.tanggeliang@kylinos.cn>
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

This patch adds another new parameter "must_fail" for __connect_to_fd_opts,
then opts->must_fail can be replaced by "must_fail" parameter in it. In
run_test() of cgroup_v1v2, true is passed to it, while false is passed in
other places. And the strcut member "must_fail" of network_helper_opts can
be dropped now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c            | 8 ++++----
 tools/testing/selftests/bpf/network_helpers.h            | 3 +--
 tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c     | 5 +----
 tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c | 4 ++--
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 0f53638ae5a0..1c4c783719b7 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -293,7 +293,7 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	if (settimeo(fd, opts->timeout_ms))
 		goto error_close;
 
-	if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
+	if (connect_fd_to_addr(fd, addr, addrlen, false))
 		goto error_close;
 
 	return fd;
@@ -303,7 +303,7 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	return -1;
 }
 
-int __connect_to_fd_opts(int server_fd, int type, bool noconnect,
+int __connect_to_fd_opts(int server_fd, int type, bool noconnect, bool must_fail,
 			 const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr;
@@ -353,7 +353,7 @@ int __connect_to_fd_opts(int server_fd, int type, bool noconnect,
 		goto error_close;
 
 	if (!noconnect)
-		if (connect_fd_to_addr(fd, &addr, addrlen, opts->must_fail))
+		if (connect_fd_to_addr(fd, &addr, addrlen, must_fail))
 			goto error_close;
 
 	return fd;
@@ -365,7 +365,7 @@ int __connect_to_fd_opts(int server_fd, int type, bool noconnect,
 
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts)
 {
-	return __connect_to_fd_opts(server_fd, 0, false, opts);
+	return __connect_to_fd_opts(server_fd, 0, false, false, opts);
 }
 
 int connect_to_fd(int server_fd, int timeout_ms)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index e029d4ff983e..fefe2ed0c798 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -23,7 +23,6 @@ typedef __u16 __sum16;
 
 struct network_helper_opts {
 	int timeout_ms;
-	bool must_fail;
 	int proto;
 	int (*post_socket_cb)(int fd, void *opts);
 	void *cb_opts;
@@ -59,7 +58,7 @@ void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
 		    const struct network_helper_opts *opts);
 int connect_to_fd(int server_fd, int timeout_ms);
-int __connect_to_fd_opts(int server_fd, int type, bool noconnect,
+int __connect_to_fd_opts(int server_fd, int type, bool noconnect, bool must_fail,
 			 const struct network_helper_opts *opts);
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
index addf720428f7..124132b435ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
@@ -9,9 +9,6 @@
 
 static int run_test(int cgroup_fd, int server_fd, bool classid)
 {
-	struct network_helper_opts opts = {
-		.must_fail = true,
-	};
 	struct connect4_dropper *skel;
 	int fd, err = 0;
 
@@ -32,7 +29,7 @@ static int run_test(int cgroup_fd, int server_fd, bool classid)
 		goto out;
 	}
 
-	fd = connect_to_fd_opts(server_fd, &opts);
+	fd = __connect_to_fd_opts(server_fd, 0, false, true, NULL);
 	if (fd < 0)
 		err = -1;
 	else
diff --git a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
index 330dfba95c56..948e1ca287a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
+++ b/tools/testing/selftests/bpf/prog_tests/ip_check_defrag.c
@@ -198,7 +198,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_tx_fd = __connect_to_fd_opts(srv_fd, SOCK_RAW, true, &tx_ops);
+	client_tx_fd = __connect_to_fd_opts(srv_fd, SOCK_RAW, true, false, &tx_ops);
 	close_netns(nstoken);
 	if (!ASSERT_GE(client_tx_fd, 0, "connect_to_fd_opts"))
 		goto out;
@@ -207,7 +207,7 @@ void test_bpf_ip_check_defrag_ok(bool ipv6)
 	nstoken = open_netns(NS0);
 	if (!ASSERT_OK_PTR(nstoken, "setns ns0"))
 		goto out;
-	client_rx_fd = __connect_to_fd_opts(srv_fd, 0, true, &rx_opts);
+	client_rx_fd = __connect_to_fd_opts(srv_fd, 0, true, false, &rx_opts);
 	close_netns(nstoken);
 	if (!ASSERT_GE(client_rx_fd, 0, "connect_to_fd_opts"))
 		goto out;
-- 
2.43.0


