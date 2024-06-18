Return-Path: <linux-kselftest+bounces-12120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C85190C2AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 06:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1138E282EE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 04:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0862F136E1D;
	Tue, 18 Jun 2024 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAKm/Wc+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E02595;
	Tue, 18 Jun 2024 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718683670; cv=none; b=oxpV2TDuIP2sgPrRMtLpgtsI9kE2HtOUT2XTCI6ImGykqel3kfM0zrLZOzYjXk2HTjfUSGLtoafXxRiZ0zQui1JAr4qF6mmYle/e6p0CJVujCi4p7XCecQeNoPdi3KZF49H3VhxiqOtD03DiPhZzydDTZzsGNPsusplsRV0j+X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718683670; c=relaxed/simple;
	bh=0rjNeAgSfA9rNmcaBi7nAyQg190Rhp086VAjo0t8FUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cv7WQvN9sJH4db6lgO1BUADtJAleWQ/hF9yqfIoKporP1zDOv/y2OWaV0aEYaHzmHcHxq80taDuT8iKh1IYxZVmMrJDlNVjGbX+/Aoo1kDMh6I3usIAm8SE0TQna2q+J8XVFj7Sr/So5HTFh+cQasHsRp7xHCjJnaPMsRryqEzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAKm/Wc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74305C4AF61;
	Tue, 18 Jun 2024 04:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718683670;
	bh=0rjNeAgSfA9rNmcaBi7nAyQg190Rhp086VAjo0t8FUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAKm/Wc+kgIy/A3ynTSuaNeyeEf4/W7uKewfwGlRnCTPGqRybSR4Nk2Rbx47okpgr
	 /q7B+BnOak33HdsO4hQgxk+Ra+iK2C0ThXEWdWkRIKRaTGpc+DxxLbDqTR8czSslag
	 kJpJMPlQqVUToL4buHugl7R3sKAQt8OYfecGgApdYyz6foJmSyPgHFmAPnFip54Do2
	 rg71X8ZYjkk5NzxBlMl/RBIrkB2yS4LRy43yneXICbJNTAFCsagJwuBKAZd7faOpZh
	 0VHBIBtVcdEq+JwbHwP+ctRNhEeJsiwq7wqsvmq2ZzARIpbeKhOzSIWMJeeQF8qKJ5
	 XfDi27K7W0loA==
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
Subject: [PATCH bpf-next v4 2/6] selftests/bpf: Use connect_to_addr in connect_to_fd_opt
Date: Tue, 18 Jun 2024 12:06:52 +0800
Message-ID: <da1e43cbd8fbaaed3249ffcfa3ce3fc460455e0e.1718683292.git.tanggeliang@kylinos.cn>
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

This patch moves "post_socket_cb" and "noconnect" into connect_to_addr(),
then connect_to_fd_opts() can be implemented by getsockname() and
connect_to_addr(). This change makes connect_to_* interfaces more unified.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 44 ++++---------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index c0efccaae488..16c2586c33ad 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -293,9 +293,14 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	if (settimeo(fd, opts->timeout_ms))
 		goto error_close;
 
-	if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
+	if (opts->post_socket_cb &&
+	    opts->post_socket_cb(fd, opts->cb_opts))
 		goto error_close;
 
+	if (!opts->noconnect)
+		if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
+			goto error_close;
+
 	return fd;
 
 error_close:
@@ -306,51 +311,18 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 int connect_to_fd_opts(int server_fd, int type, const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr;
-	struct sockaddr_in *addr_in;
-	socklen_t addrlen, optlen;
-	int fd, protocol;
+	socklen_t addrlen;
 
 	if (!opts)
 		opts = &default_opts;
 
-	if (opts->proto) {
-		protocol = opts->proto;
-	} else {
-		if (getsockopt(server_fd, SOL_SOCKET, SO_PROTOCOL, &protocol, &optlen)) {
-			log_err("getsockopt(SOL_PROTOCOL)");
-			return -1;
-		}
-	}
-
 	addrlen = sizeof(addr);
 	if (getsockname(server_fd, (struct sockaddr *)&addr, &addrlen)) {
 		log_err("Failed to get server addr");
 		return -1;
 	}
 
-	addr_in = (struct sockaddr_in *)&addr;
-	fd = socket(addr_in->sin_family, type, protocol);
-	if (fd < 0) {
-		log_err("Failed to create client socket");
-		return -1;
-	}
-
-	if (settimeo(fd, opts->timeout_ms))
-		goto error_close;
-
-	if (opts->post_socket_cb &&
-	    opts->post_socket_cb(fd, opts->cb_opts))
-		goto error_close;
-
-	if (!opts->noconnect)
-		if (connect_fd_to_addr(fd, &addr, addrlen, opts->must_fail))
-			goto error_close;
-
-	return fd;
-
-error_close:
-	save_errno_close(fd);
-	return -1;
+	return connect_to_addr(type, &addr, addrlen, opts);
 }
 
 int connect_to_fd(int server_fd, int timeout_ms)
-- 
2.43.0


