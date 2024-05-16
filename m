Return-Path: <linux-kselftest+bounces-10272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45028C6FE4
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 03:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F352841CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 01:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671C9A47;
	Thu, 16 May 2024 01:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibU4bvWb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AA84A0A;
	Thu, 16 May 2024 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715822021; cv=none; b=M6JLpgg3fHc94rDPyAKutUY2apBlqJ1LJB3adhsN7i7m8i9yQStwZQ+4IP+VQ5IDEq2vPp0aO4Cks7MKY1vQopFcTQyOtfqPut63tzqc63n4YsqW/uMmbyUR1H7EhG6DNm/eAgpI7l1I97vS/NpWtS08DXrQ7QtoTyUMvCnSD5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715822021; c=relaxed/simple;
	bh=PYLreC9y69ftkHES1PiYml+GPmE1yXRehjsAcxtM0yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epF4nD35ECiPSYlprqwaLS90ghe0x0Mh/IfyKGLVQ5cX5vrMOHajGAUMnJ3yeSUGJxgABcrPiHIfv/xYpM2WNy72Mg2q2l43ddwS2MuY/wqC8CbujCX0F0N0KfCiKUxhqpvt7drllwvOHdgYO+aQTQQcw3vvCklEw3UfqN8Q/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibU4bvWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B4AC32789;
	Thu, 16 May 2024 01:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715822020;
	bh=PYLreC9y69ftkHES1PiYml+GPmE1yXRehjsAcxtM0yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ibU4bvWbLh+yvbt5FdWsnHYegiOXOcO2vzCjNnEN5Mo/1DJBYlf00SrnZHFfNLKaU
	 V1pPwwT0d/5871mwU5BK7occF0ytCdc0dWxebcv/288+MwaKSBvPlKTn+O1i8VOx7p
	 118gmRuuZ+VmhlenVU7o0VpTMcmdug5xWVkwdJ6JynzCufatKELhrsa/Ky0t0U82KE
	 BwGn9GgkBVTLgM+BSBQ4KPv8SZ04RjkNWpvn/vtsHI7f+PUQu8xmd5gYF5IfhIL6jQ
	 bQ8IAy4ORl/oz5nvIBsXKZLc+lX9H7jtdaOD9o5gEKgN5wSCzzeadHnDxXoV2OC74J
	 ErCLedkyD4rHQ==
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
Subject: [PATCH bpf-next v2 1/8] selftests/bpf: Add unshare_netns helper
Date: Thu, 16 May 2024 09:13:07 +0800
Message-ID: <cf3c81f6014cfd1339622b1230e8dc9cca7a4440.1715821541.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715821541.git.tanggeliang@kylinos.cn>
References: <cover.1715821541.git.tanggeliang@kylinos.cn>
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


