Return-Path: <linux-kselftest+bounces-12505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4725491372A
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 03:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0445B283176
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 01:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA8C63B;
	Sun, 23 Jun 2024 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4c3G0dk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA14C6C;
	Sun, 23 Jun 2024 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719105651; cv=none; b=fFRpd4IGrKvOXv4yOVztwme1BcHGhbggwx0qph0PTiPz6Bb1wuOgXnP2kBykQFXrEXU/ukN8HjwkvFMciOf+1KhSkfVzyHQ8RYDYNNji049yNXea2yEyOY5EqkG5ENDuAgkRoST2e7y7ZWHER37rrOmfIgBmbKLsng6XrIQZUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719105651; c=relaxed/simple;
	bh=SX7vg9jAuZBrRh97twO0P4gGLK++5xW/iSIpKE0CJtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkQmGsFbctT8AIyd7FdWx9j+Qy4MgMxw9RFb1cex8tVe3WKtyTyTRMspE3T3rfrSyO40VRzh7ia1Uf8DLMbe4Oq5kMNL64ayHENTUWIAJVzsAfzi3YmtpxQfEdCjX2iNQZHVwDV5C6aK+6AX6oMepK+odYNvCKzdiaHV9BZrFms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4c3G0dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C25C32789;
	Sun, 23 Jun 2024 01:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719105651;
	bh=SX7vg9jAuZBrRh97twO0P4gGLK++5xW/iSIpKE0CJtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b4c3G0dkpT/WzCP7dSuxhwqHOJF2ijXDIuzVYkCtWXzw5pUaVrKVIMjRyjz1IFBCd
	 yotPuVCleG7ULyb9sRo4Po/q5ecn9gbE9Agx5l6gipB1OyWtw7YHxm1cSVI/20NtJ6
	 g/pxynqu6KC6spNkoKm5yB7K6/LBRVXkQImbp9sP7AnSId22M8iWdm2Drxiy+oCoVC
	 x7mwYVT3K4bQHxhf/ft5GHCAfccj0VBB8f6Pkau4BZkdwGG15c4SlaaDlJmZOVU4xI
	 ysgyU9jYPCVvwflea3WZEwdfJyr7l+5adzLxr1efs08hzzD4vKoWqVgsX6+Ail0VZz
	 WsqhMIN48VPCg==
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
Subject: [PATCH bpf-next v3 3/8] selftests/bpf: Use connect_to_fd in sockmap_ktls
Date: Sun, 23 Jun 2024 09:19:57 +0800
Message-ID: <4357a79ef34a138816b8964b2b15165eadf5a3e1.1719105178.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719105178.git.tanggeliang@kylinos.cn>
References: <cover.1719105178.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use public network helper connect_to_fd() instead of open-coding it in
prog_tests/sockmap_ktls.c. This can avoid duplicate code.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c        | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 4dc7933bb556..a6b0ed633505 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -24,26 +24,16 @@ static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
 	struct network_helper_opts opts = {
 		.backlog = SOMAXCONN,
 	};
-	struct sockaddr_storage addr = {0};
-	socklen_t len = sizeof(addr);
 	int err, cli, srv, zero = 0;
 
 	srv = start_server_str(family, SOCK_STREAM, NULL, 0, &opts);
 	if (srv == -1)
 		return;
 
-	err = getsockname(srv, (struct sockaddr *)&addr, &len);
-	if (!ASSERT_OK(err, "getsockopt"))
-		goto close_srv;
-
-	cli = socket(family, SOCK_STREAM, 0);
-	if (!ASSERT_GE(cli, 0, "socket"))
+	cli = connect_to_fd(srv, 0);
+	if (!ASSERT_GE(cli, 0, "connect_to_fd"))
 		goto close_srv;
 
-	err = connect(cli, (struct sockaddr *)&addr, len);
-	if (!ASSERT_OK(err, "connect"))
-		goto close_cli;
-
 	err = bpf_map_update_elem(map, &zero, &cli, 0);
 	if (!ASSERT_OK(err, "bpf_map_update_elem"))
 		goto close_cli;
-- 
2.43.0


