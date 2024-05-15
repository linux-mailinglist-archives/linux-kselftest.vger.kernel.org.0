Return-Path: <linux-kselftest+bounces-10233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9DA8C6079
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 08:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5506C1F23A70
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8473C463;
	Wed, 15 May 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko+jMzfG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216303BBF4;
	Wed, 15 May 2024 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752815; cv=none; b=tc18ox/Rf+kXJN3O3aknypcSgIP7BrI6wuduyhORMErK/36jSwnO55X6vQRDiODWgbdyn9LV6pQCFlo6v0f2t0OTLILwzhO7bTgOJO8HmXwvi3wSyrYG/rhOk+2HFYpONOSL3HB4FuFSc42leSnF19CiRtMymp6Q8BDYdnCfO2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752815; c=relaxed/simple;
	bh=PYLreC9y69ftkHES1PiYml+GPmE1yXRehjsAcxtM0yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moGFNY4wjnyg4w3+jJdPBfxnUfWJOfjXFmS6Yi0npNZFHq13L4p2BS9OyBHH5p5+PA9bosCtlNN7llwVYr5y6TkoMb7lq/PWfnVZslGnxyOdJLYOv5QFSCW5EzJ/tG696T43XEe94nH7yQQDMbm4nsuMPGlFcsSGkno1A6XEy+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko+jMzfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A633C2BD11;
	Wed, 15 May 2024 06:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715752814;
	bh=PYLreC9y69ftkHES1PiYml+GPmE1yXRehjsAcxtM0yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ko+jMzfGVy07o73PO/KxNjgPETIRkKhaUUXGDbKSgD1LP03Duu7OEfpEZIM8YVS5X
	 fPTuxjCmuO9MYqBwDvmGNwueWsGtg3ehzANIQOojZfCKkVx7RbVABjChI+vfLi3nKB
	 DUOvnS+fOjO6cnGP2+RaL0tVTxeHBri+2cYQ2Z01QtojDN4YHMYRVor5murUW5Tx2r
	 NxDxg8eusl/EvZTZtyC8eX6jr5MAJIQsIZzbGqCBFTaHNwgI009XlMwv9rPPaX9mEu
	 tpzeSr6tKHoRpc2XS2CxwMrWlaBHBiN2/GzPRLF/ywOBommQ4quo87BQw0bv0DUubj
	 oVkC54l/cbFiw==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next 1/9] selftests/bpf: Add unshare_netns helper
Date: Wed, 15 May 2024 13:59:28 +0800
Message-ID: <50d0c331d3418c4dcde72bfbce45196c6806c9cc.1715751995.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715751995.git.tanggeliang@kylinos.cn>
References: <cover.1715751995.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Many BPF selftests create new test network namespaces by using CLONE_NEWNET
flag to unshare the network namespace, so that the calling process is moved
into a new network namespace which is not shared with any previously
existing process. So this patch adds a new helper in network_helpers.c
named unshare_netns(), which create a new network namespace and set the
net device lo up.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 19 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 35250e6cde7f..919bb2a0c6a6 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -670,3 +670,22 @@ int send_recv_data(int lfd, int fd, uint32_t total_bytes)
 
 	return err;
 }
+
+int unshare_netns(void)
+{
+	int err;
+
+	err = unshare(CLONE_NEWNET);
+	if (err) {
+		log_err("unshare netns failed");
+		return err;
+	}
+
+	err = SYS_NOFAIL("ip link set dev lo up");
+	if (err) {
+		log_err("set dev lo up failed");
+		return err;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 883c7ea9d8d5..b087330f2861 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -82,6 +82,7 @@ struct nstoken;
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
 int send_recv_data(int lfd, int fd, uint32_t total_bytes);
+int unshare_netns(void);
 
 static __u16 csum_fold(__u32 csum)
 {
-- 
2.43.0


