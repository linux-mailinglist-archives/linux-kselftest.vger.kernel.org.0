Return-Path: <linux-kselftest+bounces-8110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9068A67F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAA01F21BE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DEF126F05;
	Tue, 16 Apr 2024 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7bu2ClQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B11686AFC;
	Tue, 16 Apr 2024 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262467; cv=none; b=aHFtRuin/Brj8qaMAhEfX+NWxaIF3Cwo+N40iFakI/u/B5tZqX/+ekjhdsfHHKwmC0ahMWJsnHEuBmjin11LGhpisOYFcwDYPKDWTCyPiGOC1IiV1c4+Xt9yc/2agCMopC8JzPq6WLUyx1yxdJzW7BIHtuubDsc64klwkN1/DY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262467; c=relaxed/simple;
	bh=yMIeF1Ylf2uz1UFvysidSRBp1Extmmcm7xQCC+P842M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vDhD5fVdOM88VkKj7AA9qzUqi4pVZrM/oxNyVTTpcz6yfuWNHYfwYnCPxWGG+wm5i6xEP1+JBAt7ZcMk1bpYrPNz5DCVcwE//p+TNoaoelYvlPyxVAYlP6S3aZmm/v+orlaXOrohpZJQVP3hfb96PGe4Q64pUCdXh9/hyA0BCKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7bu2ClQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8205C32783;
	Tue, 16 Apr 2024 10:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262467;
	bh=yMIeF1Ylf2uz1UFvysidSRBp1Extmmcm7xQCC+P842M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7bu2ClQFU3FCRFIOo/0Y5792/deB6uNS3laDmrabV9ICCfFZf1TGMip50O7eeQOc
	 0Y6aO1kiS/9nfIoHHspKDGM2TjyopxUpQcNBBbEmhSqh7FT2vKwnbOkFW/yEptx3FF
	 zMWv6mN+27Tjtu2rh3JlA9fJSfrBxwIoAkCABniT0g0wOIBhDi5WAyXNDbahH3ba+y
	 3zgGh0k9AjK/83aNyMnVcVh7zaKcCg+ZOvSruntVfoopKtWTluKXsrplIiwPiOl2MK
	 xlLYxLX6ayhi7H876BvQvmPitXBT/MvH6Ui9pTtHxy7MD7gcGF4e9GRrVGvwcsahtE
	 9p2vI14Gjf+wQ==
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
Subject: [PATCH bpf-next v4 02/14] selftests/bpf: Add start_server_addr* helpers
Date: Tue, 16 Apr 2024 18:13:48 +0800
Message-Id: <48186b788bc029cbd3a47007175c83357fa28668.1713262052.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713262052.git.tanggeliang@kylinos.cn>
References: <cover.1713262052.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In order to pair up with connect_to_addr(), this patch adds a new helper
start_server_addr(), and another one start_server_addr_opts(), which is
a wrapper of __start_server(), only added a network_helper_opts arg at
the end.

They all accept an argument 'addr' of 'struct sockaddr_storage' type
instead of a string type argument like start_server().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 16 ++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 563dde8617dd..836436688ca6 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -185,6 +185,22 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 	return NULL;
 }
 
+int start_server_addr_opts(int type, const struct sockaddr_storage *addr, socklen_t len,
+			   const struct network_helper_opts *opts)
+{
+	return __start_server(type, 0, (struct sockaddr *)addr, len,
+			      opts->timeout_ms, 0);
+}
+
+int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t len)
+{
+	struct network_helper_opts opts = {
+		.timeout_ms = 0,
+	};
+
+	return start_server_addr_opts(type, addr, len, &opts);
+}
+
 void free_fds(int *fds, unsigned int nr_close_fds)
 {
 	if (fds) {
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index ac4da5fdcc95..9e6fcc89a8d0 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -53,6 +53,9 @@ int start_mptcp_server(int family, const char *addr, __u16 port,
 int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms,
 			    unsigned int nr_listens);
+int start_server_addr_opts(int type, const struct sockaddr_storage *addr, socklen_t len,
+			   const struct network_helper_opts *opts);
+int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t len);
 void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len);
 int connect_to_fd(int server_fd, int timeout_ms);
-- 
2.40.1


