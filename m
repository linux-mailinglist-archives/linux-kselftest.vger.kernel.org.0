Return-Path: <linux-kselftest+bounces-7533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6166A89EBF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9261A1C20EA8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E2513CFAC;
	Wed, 10 Apr 2024 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMcMOyrs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78B126AC7;
	Wed, 10 Apr 2024 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734205; cv=none; b=gV3NuRWB+eZjBl6vuSugbWM5Cr5GpR+8XKam/nstBR4QGN5unf1L0BTBxpzm47WAelVbYgEMi4P5gj4QUAlPCc8IraNI+TSFSo1I+bX9iYWzQxNYmpAUtL4fSRKnfRkyJOTkqkfCJIlIxI87cw2cQoVGw+umwd5i5na/duOxuzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734205; c=relaxed/simple;
	bh=XKWe2SVlzlSokHo1aMPqJ8xIFb2FMSLePvMYzMc62os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jtlGKtPi5HkG+yWg2+SZ91Of6Xn6bTVVVFEiQIkKHl0MV9OsejpYFiyNS3bi8YJjFa7Ya3pB9RGdB3PXckz3B/nyw3uzqFOHCcqrNsu0Oj5NCpI8sfWEcdtRZq0zCEdfhuq8gS1XBmwArp+729IAuu+ergn/PhWTdd6N+730DHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMcMOyrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DD0C433F1;
	Wed, 10 Apr 2024 07:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734205;
	bh=XKWe2SVlzlSokHo1aMPqJ8xIFb2FMSLePvMYzMc62os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XMcMOyrsPGfx5p4x8ns4s8lwwYxOnkRDVlR++0u9qjhGxsNtdRwHZpZqLlltIybo1
	 vfWtw+OtRFXBvfLizdnTUQnnIquNiUrYE6ICokv5Y0UY5/8jYIe2FNfdCGm3pSDISi
	 ctwsSm6cvNMXNu3o4gZfk4FtM+O975jiMFZfvMrvf+/2oJzxs9zuO3CGH4E5gtyLgn
	 xfIyJmyv443sQ4PlTVPU4r/9z534BOv1xhuQsiG73y1Og92KCOpeig6ERL9qH5dhdP
	 Ss5d5j51As8XwNJK+NOSy5DFaiNaHcWGE3ZN1hky4RU37iTWIpK4cYcI7Js+dfFVRX
	 7JE2eti4MgRoA==
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
Subject: [PATCH bpf-next 01/14] selftests/bpf: Add start_server_addr helper
Date: Wed, 10 Apr 2024 15:29:34 +0800
Message-Id: <6f45dd890878de4eeb4d6b3a657f51e4eb60aff2.1712733999.git.tanggeliang@kylinos.cn>
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

In order to pair up with connect_to addr(), this patch adds a new helper
start_server_addr(), which is a wrapper of __start_server(), and accepts an
argument 'addr' of 'struct sockaddr' type instead of a string type argument
like start_server().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 5 +++++
 tools/testing/selftests/bpf/network_helpers.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index ca16ef2b648e..7ddeb6698ec7 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -185,6 +185,11 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 	return NULL;
 }
 
+int start_server_addr(const struct sockaddr *addr, socklen_t addrlen, int type)
+{
+	return __start_server(type, 0, addr, addrlen, 0, 0);
+}
+
 void free_fds(int *fds, unsigned int nr_close_fds)
 {
 	if (fds) {
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 70f4e4c92733..89f59b65ce76 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -53,6 +53,7 @@ int start_mptcp_server(int family, const char *addr, __u16 port,
 int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms,
 			    unsigned int nr_listens);
+int start_server_addr(const struct sockaddr *addr, socklen_t addrlen, int type);
 void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_addr(const struct sockaddr_storage *addr, socklen_t len, int type);
 int connect_to_fd(int server_fd, int timeout_ms);
-- 
2.40.1


