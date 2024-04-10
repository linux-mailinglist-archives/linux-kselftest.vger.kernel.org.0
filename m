Return-Path: <linux-kselftest+bounces-7542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E5989EC0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EAAB28289C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D97213CFB3;
	Wed, 10 Apr 2024 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/7wixBX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5260513CF98;
	Wed, 10 Apr 2024 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734259; cv=none; b=Fm0RwpkjzGNtoxVGEhRMUiOsFP8V6wVOijbBvt4zXjBAMic43Xznxicq6bRCNuaHsOmvxEy8NGxOA/pCOOEW4vtAwtnnv+IJyDai08N0u1HxNDupUtppgLjrcX3wmr+wx5aznovSO3gfluLyK3hquhUATpiqmyM3yXod9GHyfnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734259; c=relaxed/simple;
	bh=+SDCASeBlQbdY90sTxT88yCEbksIr0IlK67a/PVmHMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=st79bQ6r8oX467HFJBBRxj894pai1+p5e95Ny1SXHjmCfJWVWMxPQSbUbWuC5UwgHnVLz8SxE/rm6ARjEhXbL13t/336n7CdX4FhoEMFLh6OsvvSRN7gTyP7gDn8UK7cZmUjKHAlSeOx+TI/friOJybThxpG1TWU+0s+myCR6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/7wixBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC377C433F1;
	Wed, 10 Apr 2024 07:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734258;
	bh=+SDCASeBlQbdY90sTxT88yCEbksIr0IlK67a/PVmHMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/7wixBXsfPDs4fs/uEc91FNz2P5hJI4AMxP1wgSpdEUoNuUveHLAv4OPPFK38TqU
	 hkXSBMfhhR5wQNfOAhu5bG/PQOTIMufCitdCUHV081XfJ83mGYT3kjiEm4PWGSmXzM
	 FXQ/gA+Q1gGmUbtgKVUfsyOQJHt3hVx8OG1LCQwspxdM+xQpWfsYhexzw8uED8tUVi
	 X9O7FrGwEI7t4KBSLPLYb0ozvP5TdCvecxxUwPtsEaSqet2Z8SgehWItjGl0IRdz0U
	 34LF+BmX/+9wZODx1Ra+0+YYh2GyRcIsRQpQcuPWggF8QrHHl8orvBMKPf40IIDG9b
	 45gRpxMFdW4rQ==
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
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 10/14] selftests/bpf: Add start_server_setsockopt helper
Date: Wed, 10 Apr 2024 15:29:43 +0800
Message-Id: <89960c05cde52f06be2cbfb18b500b40aed5c105.1712733999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712733999.git.tanggeliang@kylinos.cn>
References: <cover.1712733999.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper start_server_setsockopt(), which is a wrapper
of __start_server(), and accepts a function pointer setsockopt as a
parameter.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 6 ++++++
 tools/testing/selftests/bpf/network_helpers.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index ff210f0ad3ce..42e19268cd24 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -195,6 +195,12 @@ int start_server_addr(const struct sockaddr *addr, socklen_t addrlen, int type)
 	return __start_server(type, 0, addr, addrlen, 0, NULL, 0);
 }
 
+int start_server_setsockopt(const struct sockaddr *addr, socklen_t addrlen, int type,
+			    int *(*setsockopt)(int fd, int val), int val)
+{
+	return __start_server(type, 0, addr, addrlen, 0, setsockopt, val);
+}
+
 void free_fds(int *fds, unsigned int nr_close_fds)
 {
 	if (fds) {
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 738b1764f562..543295230062 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -55,6 +55,8 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms,
 			    unsigned int nr_listens);
 int start_server_addr(const struct sockaddr *addr, socklen_t addrlen, int type);
+int start_server_setsockopt(const struct sockaddr *addr, socklen_t addrlen, int type,
+			    int *(*setsockopt)(int fd, int val), int val);
 void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_addr(const struct sockaddr_storage *addr, socklen_t len, int type);
 int connect_to_fd(int server_fd, int timeout_ms);
-- 
2.40.1


