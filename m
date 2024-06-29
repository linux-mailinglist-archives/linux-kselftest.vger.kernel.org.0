Return-Path: <linux-kselftest+bounces-12956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226DB91C9F6
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 03:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568AB1C219F2
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC1B2139C7;
	Sat, 29 Jun 2024 01:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLtguVNr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60624430;
	Sat, 29 Jun 2024 01:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719624041; cv=none; b=BN1PSgF4lvOdWiPqLXswJfrZsDCI11GZg+dQyCyfE8hDzW8TF+NdQ1QF7xRuYLliM8CT7G3trb/hlOv9hYRshLLM7D0GZgxvCC9WBgkYxjNPx3w7ClquU5sqILKIXk4pjhtXMID+TbX+VS7mzunM7n+xJ2Dww1exzCaopXNbMUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719624041; c=relaxed/simple;
	bh=6J3QFqYCAkOLhnKytwHZMLodd5u01jabVIARSdmS/Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vho661UMMzMGiEx5UiDWbu0u90GeF5R6cBxKCSubGijiKgJ0ar/wBJf1/9tQmOHg0q+Mxj9UdYLZzhJNLTUERgm49joyVS02j4eCcZG6q38FSJfUe9sBxKpA1Kux+GB3aD91PjuLKHw+ylQ9Is+Wkj4N/VReAimVSxyvSFnrSnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLtguVNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73B7C32789;
	Sat, 29 Jun 2024 01:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719624041;
	bh=6J3QFqYCAkOLhnKytwHZMLodd5u01jabVIARSdmS/Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLtguVNrcSZwPGIWx52zQ9JPwjyL4lu2rXXN9ei5aDSaAGGy2PPY8Fpegc43Ly/bq
	 Qeo6tLJILkZsCc/JVa8fVy1Sw9+o3rSW25sdcIjNIu82Uf0XHv9ZPq1RBDsAKmz4+p
	 3RPCCqhKZzE6kMGDutGEKibJefIB0WhM+0W7qX7kY7HcgCtBaNDNk3jGc+v2cfvyXQ
	 GFi+Nqos4pZGwOQLNdoJjsuKCXb2cy+ynWJwAFuADnr4OGwfQa4LtPjxOjugBKXkFu
	 My+/7vrdEBUqrQ7nqyJ3vr/IycDrGysvHBlWFswdqSPPDtky1VmP5ccLsFe8yD7vKe
	 Gzmz0I5mruQcg==
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
Subject: [PATCH bpf-next v6 1/9] selftests/bpf: Add backlog for network_helper_opts
Date: Sat, 29 Jun 2024 09:20:11 +0800
Message-ID: <7ee521c76e45a536da7940c19a4d8de235e63e78.1719623708.git.tanggeliang@kylinos.cn>
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

Some callers expect __start_server() helper to pass their own "backlog"
value to listen() instead of the default of 1. So this patch adds struct
member "backlog" for network_helper_opts to allow callers to set "backlog"
value via start_server_str() helper.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 2 +-
 tools/testing/selftests/bpf/network_helpers.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 44c2c8fa542a..16cbb3fdcabf 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -106,7 +106,7 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
 	}
 
 	if (type == SOCK_STREAM) {
-		if (listen(fd, 1) < 0) {
+		if (listen(fd, opts->backlog ? : 1) < 0) {
 			log_err("Failed to listed on socket");
 			goto error_close;
 		}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 9ea36524b9db..8339c4e4b075 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -25,6 +25,7 @@ struct network_helper_opts {
 	int timeout_ms;
 	bool must_fail;
 	int proto;
+	int backlog;
 	int (*post_socket_cb)(int fd, void *opts);
 	void *cb_opts;
 };
-- 
2.43.0


