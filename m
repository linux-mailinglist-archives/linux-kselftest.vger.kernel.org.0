Return-Path: <linux-kselftest+bounces-8838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7A28B196F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 05:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53582831C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 03:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6981D524;
	Thu, 25 Apr 2024 03:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+NKzUGT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0B1CAA6;
	Thu, 25 Apr 2024 03:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015498; cv=none; b=ptC4ijDTuCNay2SQDMjlmxbTHoN4DM14QGCmqdQAFeiPUuZeTtdCTfAypWYapFXr1Jrxy7AxPuwxD2KstbIre/oAlDuNL2ANw6ce5BzHCQbtnwjJB2/I1+z2m8OJQ/0BaNYsHM697z81KPQLhG8ppcVP/joQo3bw6tUGZR+gTjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015498; c=relaxed/simple;
	bh=vYkUUYP6hJn1TqZiTEfrLDiwxzbySFa0BQVMKzr7Kek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IChEoskiHQ+QX3NwL+9QPit0gUPogBqt7wEghJC8LD7zwgOhA/7bzY/Uv0EnoQRR77kGirjzJKhPLRYVI9r+7NWIjPvqpYIKhiL6hm+V3u9vDYj2vW3oQmdvu0JezydtkiK0xdVV8JYSSFsxBFZD3RDqu3at9AWQaaoMy1Q5Dls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+NKzUGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DD9C32786;
	Thu, 25 Apr 2024 03:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714015498;
	bh=vYkUUYP6hJn1TqZiTEfrLDiwxzbySFa0BQVMKzr7Kek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+NKzUGTPx/caAUqEFYsXOtBlIckDxw9XzSF5yCNCf+f2ItkaHM6RwC+/Ktss1/IW
	 ByrmwAaUramzUsjS9Nft6cTyYy1wXXp5TNupTwy5ZAbXYAtN/BDtTct6RHXICX6i48
	 Amxdid9v5i6r46SfiRNiBmxUOWExo+QuhA05RPY5CazlsLk6cq4kV7pmO89dYuF0D/
	 WHHm6pkU/VQQG/f1+XUCeshLFwkB+SpfsT6+nAbJ5xQyPXx4FRkZ5fmb4WC5n3dVEX
	 BmZEuW6xLj/xb2jmcDMZcLzi6BnroUQxuJmetQZfjEHQkgCD30QhnHligqSvQQXzYq
	 6P5tvg0nFDE6A==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next 4/6] selftests/bpf: Add setsockopt for network_helper_opts
Date: Thu, 25 Apr 2024 11:23:44 +0800
Message-Id: <0f676d51126bf7c260a71cfb60df0d1acb23e552.1714014697.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1714014697.git.tanggeliang@kylinos.cn>
References: <cover.1714014697.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

__start_server() sets SO_REUSPORT through setsockopt() when the parameter
'reuseport' is set. This patch makes it more flexible by adding setsockopt
function pointer, together with optval and optlen fields into struct
network_helper_opts. Then 'reuseport' parameter can be dropped.

Now the original start_reuseport_server() can be implemented by setting
a newly defined setsockopt_reuseport() function pointer to setsockopt
filed of struct network_helper_opts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 26 ++++++++++++-------
 tools/testing/selftests/bpf/network_helpers.h |  3 +++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 1519f02f8090..baeb4acf5fae 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -81,9 +81,8 @@ int settimeo(int fd, int timeout_ms)
 #define save_errno_close(fd) ({ int __save = errno; close(fd); errno = __save; })
 
 static int __start_server(int type, const struct sockaddr *addr, socklen_t addrlen,
-			  bool reuseport, const struct network_helper_opts *opts)
+			  const struct network_helper_opts *opts)
 {
-	int on = 1;
 	int fd;
 
 	fd = socket(addr->sa_family, type, opts->proto);
@@ -95,9 +94,9 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
 	if (settimeo(fd, opts->timeout_ms))
 		goto error_close;
 
-	if (reuseport &&
-	    setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &on, sizeof(on))) {
-		log_err("Failed to set SO_REUSEPORT");
+	if (opts->setsockopt &&
+	    opts->setsockopt(fd, opts->optval, opts->optlen)) {
+		log_err("Failed to set sockopt");
 		goto error_close;
 	}
 
@@ -132,14 +131,23 @@ int start_server(int family, int type, const char *addr_str, __u16 port,
 	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
 		return -1;
 
-	return __start_server(type, (struct sockaddr *)&addr, addrlen, false, &opts);
+	return __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
+}
+
+static int setsockopt_reuseport(int fd, const void *optval, socklen_t optlen)
+{
+	return setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, optval, optlen);
 }
 
 int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms, unsigned int nr_listens)
 {
+	int on = 1;
 	struct network_helper_opts opts = {
 		.timeout_ms = timeout_ms,
+		.setsockopt = setsockopt_reuseport,
+		.optval = &on,
+		.optlen = sizeof(on),
 	};
 	struct sockaddr_storage addr;
 	unsigned int nr_fds = 0;
@@ -156,7 +164,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 	if (!fds)
 		return NULL;
 
-	fds[0] = __start_server(type, (struct sockaddr *)&addr, addrlen, true, &opts);
+	fds[0] = __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
 	if (fds[0] == -1)
 		goto close_fds;
 	nr_fds = 1;
@@ -165,7 +173,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 		goto close_fds;
 
 	for (; nr_fds < nr_listens; nr_fds++) {
-		fds[nr_fds] = __start_server(type, (struct sockaddr *)&addr, addrlen, true, &opts);
+		fds[nr_fds] = __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
 		if (fds[nr_fds] == -1)
 			goto close_fds;
 	}
@@ -183,7 +191,7 @@ int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t l
 	if (!opts)
 		opts = &default_opts;
 
-	return __start_server(type, (struct sockaddr *)addr, len, 0, opts);
+	return __start_server(type, (struct sockaddr *)addr, len, opts);
 }
 
 void free_fds(int *fds, unsigned int nr_close_fds)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index c62b54daa914..540ecfc52bd7 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -28,6 +28,9 @@ struct network_helper_opts {
 	bool noconnect;
 	int type;
 	int proto;
+	int (*setsockopt)(int fd, const void *optval, socklen_t optlen);
+	const void *optval;
+	socklen_t optlen;
 };
 
 /* ipv4 test vector */
-- 
2.40.1


