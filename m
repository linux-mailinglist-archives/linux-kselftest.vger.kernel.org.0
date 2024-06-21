Return-Path: <linux-kselftest+bounces-12388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D56F91185D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 04:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB481C21EEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 02:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735E783A0D;
	Fri, 21 Jun 2024 02:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+51rny5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1CEEEC6;
	Fri, 21 Jun 2024 02:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936196; cv=none; b=mFzWivw4tC+Ifnlosgmm6FbzN9sgg61JEgRACuAqRfPwD2e3fmfMQ+QfjUTnvtztnAIyzGrLbi+ylPfOMN4Ca2J78mxDaR4mXXq0OS3u6gG2p5CydQOHKc4sDEl6u+7a8mchThDEc8MQr4Adl5I0DgaxLUv3REAjQzsoQVxKUws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936196; c=relaxed/simple;
	bh=OtF8E9kgB+oaySsa4wZSdUC+f2BP+HoWoQHbyFpaL5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRb3WpY0MggnNcW/01BPaGpyB8DoV83p7m9QLiTeNlsFy1/RK5T58JhRLDcMwySlOqYdiF7QSWPPbAGjiLWD59p+P54sgGS/bDp8xvkzl57jo2DRT7ukmECg1UUfiV7JQ6tWcZBgvlThmXPAefmDpsGA8c0Jg5fPjgSe1IE+1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+51rny5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A38EC4AF07;
	Fri, 21 Jun 2024 02:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718936196;
	bh=OtF8E9kgB+oaySsa4wZSdUC+f2BP+HoWoQHbyFpaL5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+51rny51CLS8cE6VfFlljt6mpMpt2pk8JlQLKOu0rsQIefD3yuBA8Rlr/iu1md9Q
	 C6UiwUmOtBauIgmgidZVOSFLSpkYOAnbhXC8FRAiEaeIPl7twFKemHywDk4QnGN1hY
	 BbuoMJ3c5ggLoG1stnqSAhZa6fGKd7xgbqgL/gReefFWajSlNlbBJs2eD/RzDD3Nsi
	 tOq7S7LI38madQGrldWg5Eg+afZqpACIj7oQsIGtWbRRez8IpiSsTkE2rUeZFDsVy7
	 WryfOIFPf4iCwaEaVI8azhT5tcRxU6AHqb8XbRQZswxBU1wDvepocN/F+mE1s888JG
	 0RIW/oYokbv/Q==
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
Subject: [PATCH bpf-next v6 3/6] selftests/bpf: Add client_socket helper
Date: Fri, 21 Jun 2024 10:16:00 +0800
Message-ID: <4169c554e1cee79223feea49a1adc459d55e1ffe.1718932493.git.tanggeliang@kylinos.cn>
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

This patch extracts a new helper client_socket() from connect_to_fd_opts()
to create the client socket, but don't connect to the server. Then
connect_to_fd_opts() can be implemented using client_socket() and
connect_fd_to_addr(). This helper can be used in connect_to_addr() too,
and make "noconnect" opts useless.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 37 +++++++++++++++----
 tools/testing/selftests/bpf/network_helpers.h |  2 +
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 5d1b4f165def..5f8214e2880d 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -249,6 +249,34 @@ int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
 	return -1;
 }
 
+int client_socket(int family, int type,
+		  const struct network_helper_opts *opts)
+{
+	int fd;
+
+	if (!opts)
+		opts = &default_opts;
+
+	fd = socket(family, type, opts->proto);
+	if (fd < 0) {
+		log_err("Failed to create client socket");
+		return -1;
+	}
+
+	if (settimeo(fd, opts->timeout_ms))
+		goto error_close;
+
+	if (opts->post_socket_cb &&
+	    opts->post_socket_cb(fd, opts->cb_opts))
+		goto error_close;
+
+	return fd;
+
+error_close:
+	save_errno_close(fd);
+	return -1;
+}
+
 static int connect_fd_to_addr(int fd,
 			      const struct sockaddr_storage *addr,
 			      socklen_t addrlen, const bool must_fail)
@@ -284,19 +312,12 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	if (!opts)
 		opts = &default_opts;
 
-	fd = socket(addr->ss_family, type, opts->proto);
+	fd = client_socket(addr->ss_family, type, opts);
 	if (fd < 0) {
 		log_err("Failed to create client socket");
 		return -1;
 	}
 
-	if (settimeo(fd, opts->timeout_ms))
-		goto error_close;
-
-	if (opts->post_socket_cb &&
-	    opts->post_socket_cb(fd, opts->cb_opts))
-		goto error_close;
-
 	if (!opts->noconnect)
 		if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
 			goto error_close;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index c92bed35dfe2..e89eadfb02d6 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -57,6 +57,8 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
 		      const struct network_helper_opts *opts);
 void free_fds(int *fds, unsigned int nr_close_fds);
+int client_socket(int family, int type,
+		  const struct network_helper_opts *opts);
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
 		    const struct network_helper_opts *opts);
 int connect_to_fd(int server_fd, int timeout_ms);
-- 
2.43.0


