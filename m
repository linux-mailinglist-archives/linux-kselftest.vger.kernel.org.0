Return-Path: <linux-kselftest+bounces-12535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACBA914113
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 06:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FCFB22887
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 04:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37A68C13;
	Mon, 24 Jun 2024 04:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPxPRtwP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ADBD502;
	Mon, 24 Jun 2024 04:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719203677; cv=none; b=f2BhLo0JjNFqVTkWC/9xi56AEnf3sU9SLhDuqoLLOKUJjzAu/P2+SZVkjljmLy5sTy7BbMM9Hu2VBtE67UUJcfVsWCA45768huiJ2D1WqPD8isCAuFhGPMbcvvJ3U24o2HtHnvUML9DgY97zcSBVjpM0w2qG3rOg7NXQe8UW48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719203677; c=relaxed/simple;
	bh=6J3QFqYCAkOLhnKytwHZMLodd5u01jabVIARSdmS/Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rhx2YXTkBqD6AY8/It+npEIL9Ecrst9bhKQU58bJwQuG3rLJC0E3q3fkXKin1AMNEMTiUG9LwXj1nxu5MSjscAmJnExXIPxtgNoV6OPGipbUl14Mm0UR3mzjf94VlZma7KlVmQHUrWVPKs008nM3rWwKtbxlh6d7fdNM6qdwY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPxPRtwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB8CC32786;
	Mon, 24 Jun 2024 04:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719203677;
	bh=6J3QFqYCAkOLhnKytwHZMLodd5u01jabVIARSdmS/Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RPxPRtwPz7Hn9A1r3DvBUwhImgwPNt5IYCcGHGhv1yXGNtP1qIP9grzdYUNDwjN4I
	 niIbdrsboxNivMhSXFikd+785hi/MD+mqqUVRGV//MjA1RSf8G+R2bPkXu0XeXR+bf
	 5pDZEKq4kO83OKkOadXDHdNGzWVW0pn0cJNMHRs+3EI9frTLW620OT/p6GFambMX5f
	 6ZERD2jm4ECJ5DETGrtsZP1e6ehiS4LbyW8S/rFvaOv72C4Pt60ZZGhBee/0RXTsB2
	 deqYt/2/TDW3uxi2tXuHhXIo9FpPeawlAfOMp6y48OjCHlHRsFf3Rh7Ot2DUK1FYGb
	 H5udKrbibaqdw==
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
Subject: [PATCH bpf-next v4 1/9] selftests/bpf: Add backlog for network_helper_opts
Date: Mon, 24 Jun 2024 12:33:48 +0800
Message-ID: <cca255aa6baff78a6cb06d41e1eb13a5015692ea.1719203293.git.tanggeliang@kylinos.cn>
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


