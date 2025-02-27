Return-Path: <linux-kselftest+bounces-27772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBBBA4815A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB2F3B7519
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F91223816C;
	Thu, 27 Feb 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gNGnGPuk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E62376E6
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666448; cv=none; b=DAUYFQpDBEwPvAP1MyXR61liLDwdaNX1zwkmga98hxhbQmLMJ6KnkRg8sqxNmzlCCeXStCoe9VNz8DCv9nfbZTyY23RSmGZxEWChoYj+oMP+Jq25uW0Blrd/G9dAvcSwwxp38laZoODwuBMXsiF1Ytzbdd6MYKTgl0z9raftmic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666448; c=relaxed/simple;
	bh=rDWiyqunZGTOtFOaj6bPovFS1empQsc83Ctjli5d8AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hm1106ktr0b+WFFNTKajriU8NrAiS4GGG6XrgFd78YW5lFnu6HNsohFmTzmAXb8SXNCmbEagJsXlrOSJFAw2dqY3F3VOk6nnYpuGYhVkH4rD03CvZSfX/aHCAya7dfa6qc8eBFc+oxQjwTWngC1yTQ2nUlOoETK0YFGGk7eC33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gNGnGPuk; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740666443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZM2tKqXjjo4I4618vU5KeTgE7YE43jJgVbf+MnAQmK4=;
	b=gNGnGPuk3qV2Kf4osot90TYQKn6u2hTi1fGtYIo6FtHBtsVui939+Ge7rD9knRdCvppp71
	zyHz7s0ufy2lNLANAc8V0OZ5R+eNb6TnTLIabEfLb9KyTCMn2E48zOqrCbn4pZdEjvdFFS
	VzuUybXQq/8gcQP4QNpg16iBBkyrWZY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH bpf-next v1 2/3] selftests/bpf: Allow auto port binding for bpf nf
Date: Thu, 27 Feb 2025 22:26:45 +0800
Message-ID: <20250227142646.59711-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250227142646.59711-1-jiayuan.chen@linux.dev>
References: <20250227142646.59711-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Allow auto port binding for bpf nf test to avoid binding conflict.

./test_progs -a bpf_nf
24/1    bpf_nf/xdp-ct:OK
24/2    bpf_nf/tc-bpf-ct:OK
24/3    bpf_nf/alloc_release:OK
24/4    bpf_nf/insert_insert:OK
24/5    bpf_nf/lookup_insert:OK
24/6    bpf_nf/set_timeout_after_insert:OK
24/7    bpf_nf/set_status_after_insert:OK
24/8    bpf_nf/change_timeout_after_alloc:OK
24/9    bpf_nf/change_status_after_alloc:OK
24/10   bpf_nf/write_not_allowlisted_field:OK
24      bpf_nf:OK
Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index a4a1f93878d4..dbd13f8e42a7 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -72,11 +72,14 @@ static void test_bpf_nf_ct(int mode)
 	if (!ASSERT_OK(system(cmd), cmd))
 		goto end;
 
-	srv_port = (mode == TEST_XDP) ? 5005 : 5006;
-	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", srv_port, TIMEOUT_MS);
+	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, TIMEOUT_MS);
 	if (!ASSERT_GE(srv_fd, 0, "start_server"))
 		goto end;
 
+	srv_port = get_socket_local_port(srv_fd);
+	if (!ASSERT_GE(srv_port, 0, "get_sock_local_port"))
+		goto end;
+
 	client_fd = connect_to_server(srv_fd);
 	if (!ASSERT_GE(client_fd, 0, "connect_to_server"))
 		goto end;
@@ -91,7 +94,7 @@ static void test_bpf_nf_ct(int mode)
 	skel->bss->saddr = peer_addr.sin_addr.s_addr;
 	skel->bss->sport = peer_addr.sin_port;
 	skel->bss->daddr = peer_addr.sin_addr.s_addr;
-	skel->bss->dport = htons(srv_port);
+	skel->bss->dport = srv_port;
 
 	if (mode == TEST_XDP)
 		prog_fd = bpf_program__fd(skel->progs.nf_xdp_ct_test);
-- 
2.47.1


