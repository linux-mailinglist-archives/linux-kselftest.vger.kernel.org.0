Return-Path: <linux-kselftest+bounces-27339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01907A41C3C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 12:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950857A7343
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 11:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6DD205AAF;
	Mon, 24 Feb 2025 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw8IrwSa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687E802;
	Mon, 24 Feb 2025 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395802; cv=none; b=KTosUJZ2cAAsccfJK/CLoNAJ5d6qWTCvQDtChlqFraI6xwbD8gnw+yweY+oPxttJd5G8xA0AuZYV6SCq7pHSikwb9Ax607bEoavp8RC73FsmB+m411V7btlbuk6H83G61JLMEI3IwRP9MOM7eZecPtyKJfNvLIpdHxGmgsZVV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395802; c=relaxed/simple;
	bh=snZu7pL4BcHs/H3bClvaolJQqBjKqx8IvUNhokoLJz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=de+/IHaS9o1euyAwnQViny8qZI8Ljn4ZnsyFMJeaNPSCe6shTgeAsglJddhObkPaXHf2tSzknYsYBJR9nMr6TjheBEdzjlI5vFkpVdTNLFGCnRTyQhQUCvdcMVGtLd6q0TblFBpZrSUN/WNQn3QKxT8Cjmc9xdu+3nghjcph7t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw8IrwSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192F3C4CED6;
	Mon, 24 Feb 2025 11:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395801;
	bh=snZu7pL4BcHs/H3bClvaolJQqBjKqx8IvUNhokoLJz4=;
	h=From:To:Cc:Subject:Date:From;
	b=jw8IrwSaKWeGIPfpQhyp+dPmmFivRly2UKmQzKTMy7IoxX9ELcIb0uA6/gPv+WpHV
	 VsHJczbCMFx7YjRm0NQ2xjxVo4Ne4CGeFA8bVYgMl8/N1eucjINXARYZTSywQExGzf
	 ABS0tH94oKRIcXPAZ6TQg1Kf20WsHx+sX2pfh7TCeWPEdcHXZh+OrvxpZLJwy9h73Y
	 /kj1wh1X7narHrN3oVFt4M1pvP2MTEU8i4nCnAlFlQZinbqfrzQvaHTwcI2ofVVCME
	 QjDO6cS8PLvNkZ8h1bK+D4YJhKdlEpJa4KX8DHAs5DFX52ayd8bIQgHD7ds+oWrSri
	 eSsDteTvEFqQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shigeru Yoshida <syoshida@redhat.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 01/32] selftests/bpf: Adjust data size to have ETH_HLEN
Date: Mon, 24 Feb 2025 06:16:07 -0500
Message-Id: <20250224111638.2212832-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
Content-Transfer-Encoding: 8bit

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit c7f2188d68c114095660a950b7e880a1e5a71c8f ]

The function bpf_test_init() now returns an error if user_size
(.data_size_in) is less than ETH_HLEN, causing the tests to
fail. Adjust the data size to ensure it meets the requirement of
ETH_HLEN.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20250121150643.671650-2-syoshida@redhat.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c  | 4 ++--
 .../testing/selftests/bpf/prog_tests/xdp_devmap_attach.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
index c7f74f068e788..df27535995af8 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
@@ -52,10 +52,10 @@ static void test_xdp_with_cpumap_helpers(void)
 	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry prog_id");
 
 	/* send a packet to trigger any potential bugs in there */
-	char data[10] = {};
+	char data[ETH_HLEN] = {};
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in = &data,
-			    .data_size_in = 10,
+			    .data_size_in = sizeof(data),
 			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
 			    .repeat = 1,
 		);
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
index 27ffed17d4be3..461ab18705d5c 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
@@ -23,7 +23,7 @@ static void test_xdp_with_devmap_helpers(void)
 	__u32 len = sizeof(info);
 	int err, dm_fd, dm_fd_redir, map_fd;
 	struct nstoken *nstoken = NULL;
-	char data[10] = {};
+	char data[ETH_HLEN] = {};
 	__u32 idx = 0;
 
 	SYS(out_close, "ip netns add %s", TEST_NS);
@@ -58,7 +58,7 @@ static void test_xdp_with_devmap_helpers(void)
 	/* send a packet to trigger any potential bugs in there */
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in = &data,
-			    .data_size_in = 10,
+			    .data_size_in = sizeof(data),
 			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
 			    .repeat = 1,
 		);
@@ -158,7 +158,7 @@ static void test_xdp_with_devmap_helpers_veth(void)
 	struct nstoken *nstoken = NULL;
 	__u32 len = sizeof(info);
 	int err, dm_fd, dm_fd_redir, map_fd, ifindex_dst;
-	char data[10] = {};
+	char data[ETH_HLEN] = {};
 	__u32 idx = 0;
 
 	SYS(out_close, "ip netns add %s", TEST_NS);
@@ -208,7 +208,7 @@ static void test_xdp_with_devmap_helpers_veth(void)
 	/* send a packet to trigger any potential bugs in there */
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in = &data,
-			    .data_size_in = 10,
+			    .data_size_in = sizeof(data),
 			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
 			    .repeat = 1,
 		);
-- 
2.39.5


