Return-Path: <linux-kselftest+bounces-14117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBAD93A941
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3A41C224AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D22C148FE6;
	Tue, 23 Jul 2024 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+/CRT+w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BF9143C6B;
	Tue, 23 Jul 2024 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773421; cv=none; b=ZEXTmchjE0yBoW8TDr9TheeDYjovurGKPKXf72E592IXrQGTIqQGgPRiZs3s426b26OqlVKOFZ7xZSWRvBUPGQdCPdQrN0jYtubVGPQaGgPjabTEuoPM+TmSg8AqnPY6nYTrLruOtOnjmIaJ1H17dXlVoLP1lwdhIBiff5QZGYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773421; c=relaxed/simple;
	bh=SHYjF4mo17ALM2nROj6zICCd1uAMwHnpyC0sTX26ffQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPZiQl+d1n2uJ8v3ERsA4YPkM+XvxCV/yt66WC6ci0v7e260qFJwsCZ6nO0qJNt/OOZYlH3wwJLDxcABoQ/NwJui/ebV7g1upHUeZXzJNaUEkcapd9f/m+dcgCDYZFoZj03gVD1uXHbuAU/n7XKKhScRf/ne8LksMOdcvyIPbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+/CRT+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5956BC4AF0A;
	Tue, 23 Jul 2024 22:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773421;
	bh=SHYjF4mo17ALM2nROj6zICCd1uAMwHnpyC0sTX26ffQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+/CRT+wOpVLTY3i81U+anoR/qpAysQBi9B6bWo+oaVKpRO6+ogl/+VPzLWsFTV3+
	 NlqcM7Jra4HTpWU+epoYQqD67LwvdDYAI4STtxisstomYnbRyBACa+0Qkju+4QGoA/
	 yGPmcIEOTe1ta7QffPVmfKZlb5NVQw+gm2WUa3pb3XuI/wgKnqPfMOEdvzPXDpwY0g
	 Fbk2WzExYE0l5+960XzR9fmf4MiNW7ZPo3aoQdxbwHu8JwHweb807P6KOUfktMX4Rb
	 rgHf3k/EKvxeYIU6+TMEPTty4nfJx7ys2k39gWyb/yDvOq98WkQx3uLGuQhAnKtT0Y
	 fY6+ySy1Zrc2w==
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
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 15/15] selftests/bpf: Use start_server_str in sockmap_helpers
Date: Wed, 24 Jul 2024 06:22:21 +0800
Message-ID: <2de2cd7a23bcd02d4711ec66d3b3a77c5632d1e7.1721771340.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721771340.git.tanggeliang@kylinos.cn>
References: <cover.1721771340.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now both SOCK_SEQPACKET and SOCK_NONBLOCK can be passed as "type" parameter
into start_server_str(), use this helper in socket_loopback_reuseport() in
sockmap_helpers.h to simplify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../bpf/prog_tests/sockmap_helpers.h          | 47 ++++++++-----------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index 0fe095497f34..1e681e71e9ad 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -310,8 +310,14 @@ static inline int create_socket_pairs(int s, int family, int sotype,
 	return err;
 }
 
-static inline int enable_reuseport(int s, int progfd)
+struct cb_opts {
+	int progfd;
+};
+
+static int enable_reuseport(int s, void *opts)
 {
+	struct cb_opts *co = (struct cb_opts *)opts;
+	int progfd = co->progfd;
 	int err, one = 1;
 
 	err = xsetsockopt(s, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one));
@@ -327,34 +333,19 @@ static inline int enable_reuseport(int s, int progfd)
 
 static inline int socket_loopback_reuseport(int family, int sotype, int progfd)
 {
-	struct sockaddr_storage addr;
-	socklen_t len = 0;
-	int err, s;
-
-	init_addr_loopback(family, &addr, &len);
-
-	s = xsocket(family, sotype, 0);
-	if (s == -1)
-		return -1;
-
-	if (progfd >= 0)
-		enable_reuseport(s, progfd);
-
-	err = xbind(s, sockaddr(&addr), len);
-	if (err)
-		goto close;
-
-	if (sotype & SOCK_DGRAM)
-		return s;
-
-	err = xlisten(s, SOMAXCONN);
-	if (err)
-		goto close;
+	struct cb_opts cb_opts = {
+		.progfd = progfd,
+	};
+	struct network_helper_opts opts = {
+		.backlog = SOMAXCONN,
+	};
+
+	if (progfd >= 0) {
+		opts.post_socket_cb = enable_reuseport;
+		opts.cb_opts = &cb_opts;
+	}
 
-	return s;
-close:
-	xclose(s);
-	return -1;
+	return start_server_str(family, sotype, loopback_addr_str(family), 0, &opts);
 }
 
 static inline int socket_loopback(int family, int sotype)
-- 
2.43.0


