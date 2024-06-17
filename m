Return-Path: <linux-kselftest+bounces-12037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C37D690A87F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 10:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C841F239AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 08:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A58190479;
	Mon, 17 Jun 2024 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9+RB92B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BEA187331;
	Mon, 17 Jun 2024 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613218; cv=none; b=icpXk9JEUjNVAkHo7JjkaxgqxzQTu1YikyQB5vh0dy5CveMG2j918uPYWS5oz96N8Ji2m64Ku/bLZNlAIN1j2ucxB4S6OiNgmEMklG4KGYl5EOGJdDsUG6JwVJfCfnFoj1F2NT0sF0/wguVSTnWn2tbDRYM9NwwEbqQmjs+aZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613218; c=relaxed/simple;
	bh=aEFykOZejhBgMZF7//pmJaPg/hEDx7vFpnaHlP05k68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1O63O1IdjQbuqeMS4IPQUUSNTyuixnnrhTwK7KR8+jHC1BaNpqjSKIzQ076+ultz3A/uwbST9LdCLg8TLpDMNxVUF6+gGTZ6cmXJYgczJaqheS0u173Tc4YUnw0O5csCB591IkTdo97anXd7H8hwY4F5TSzm07c1gvhWXhesSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9+RB92B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE8EC3277B;
	Mon, 17 Jun 2024 08:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718613217;
	bh=aEFykOZejhBgMZF7//pmJaPg/hEDx7vFpnaHlP05k68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9+RB92B4IMOvz8FQzyahXUSI116AypsqCzYxaFTDtyG1JXXWKYZG1QqznniDAqnp
	 zdQjs0q7Hp0FXDJl89lGdft3FgYGYpcMkUY5//5PxIaJQf1ZwjzJaQxTKq8QIo8Eay
	 E2m4TJUddTEBlmEXQUQw26KJVkiOZvENhcLh1NRxcoxDfQShxDq9+VHY3qvlQqVL7p
	 Eu32/I3HJXfOK1RfF/64tiqVg9MEKoUBNoFlbkFx2rvAK+rPuOgjEagvecfBJ/Y8z8
	 +gYuoDaD+8P50Qfjn8dKj+uknwPjyLffHguUXnCFJN1TsNxMU9OP1zZYF1P6DT3e7K
	 /ki2X/+Zpixzw==
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
Subject: [PATCH mptcp-next v3 2/6] selftests/bpf: Use connect_to_addr in connect_to_fd_opt
Date: Mon, 17 Jun 2024 16:33:07 +0800
Message-ID: <67fd5e82a8d7041e964b8ff9d943ac4947690d7d.1718612857.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718612857.git.tanggeliang@kylinos.cn>
References: <cover.1718612857.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/network_helpers.c | 47 ++++---------------
 1 file changed, 8 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index c0efccaae488..028dfe9001e4 100644
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
@@ -306,21 +311,7 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 int connect_to_fd_opts(int server_fd, int type, const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr;
-	struct sockaddr_in *addr_in;
-	socklen_t addrlen, optlen;
-	int fd, protocol;
-
-	if (!opts)
-		opts = &default_opts;
-
-	if (opts->proto) {
-		protocol = opts->proto;
-	} else {
-		if (getsockopt(server_fd, SOL_SOCKET, SO_PROTOCOL, &protocol, &optlen)) {
-			log_err("getsockopt(SOL_PROTOCOL)");
-			return -1;
-		}
-	}
+	socklen_t addrlen;
 
 	addrlen = sizeof(addr);
 	if (getsockname(server_fd, (struct sockaddr *)&addr, &addrlen)) {
@@ -328,29 +319,7 @@ int connect_to_fd_opts(int server_fd, int type, const struct network_helper_opts
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


