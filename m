Return-Path: <linux-kselftest+bounces-13302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5C7929ADD
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 04:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFA91C20910
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 02:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FADE184F;
	Mon,  8 Jul 2024 02:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPHYMoiV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC9A803;
	Mon,  8 Jul 2024 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405871; cv=none; b=TsRgUQKaLcaZofGlpizylTb8h1g1hJlcuvno2ODfLtiIvLCXxfqmUNLLkebes12C/EjxIQbW0oXNB2fpnmV2oFTAHbaM23JLKwHLF6fRJLT/M44B0V1A2WbDF4OXhFvT3DYfJIhCgKaXQzPo9FbdDeXalayn7/pizArF+dd6+DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405871; c=relaxed/simple;
	bh=5NfKVOskZyhSWPjqaC3bovwMwDTjbj5c/qMAAgRj5xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrixLij7P/3MRKGYkXosMqNcZTPUea3uTHLM2K05pV89hoALjDSPV0OPHH32F1n1A8KTNtOeRjLN6C8wDNcw+AdOUgcwCcTSCfpMJdTonuXkR0CnVRhdKFV9zqEMwJ5T8oQBCPfAAYbyc6N+ut/HJsIpo7APvCAtj6yZHaB7kms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPHYMoiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06BCC4AF11;
	Mon,  8 Jul 2024 02:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720405869;
	bh=5NfKVOskZyhSWPjqaC3bovwMwDTjbj5c/qMAAgRj5xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KPHYMoiVa/A+SIAB/T/YQ+aYNS4XC34VT13wbwjnYilDfrpLmaL6AAinGrYjVTNRe
	 Sn+J9NtzqFw/es8/gIIFiTfiuGkLnmOr0DwOhvgCOakUZAlwB1y7UAz8QcuYPtIo/N
	 yR7avA8+m1T069m3NIGJpAU/rmI1aUnwocML9xn5iwhufeUs0+TFZBlGWaO82dNdG6
	 6UgrEjWkID1Tv9Gu/cECj9BnMkX2fVnjlnzKn5vk6LK5dEdCtG+9Ev7Yw9VItHfNra
	 2YBIqGW3mEsd0fY7oy2cwIziiBUo3yoT1N0VPXwuQg2VyfTQcW2dijx7YP5oOJAZJW
	 MGmj7yL6a2l6g==
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
Subject: [PATCH bpf-next v10 10/12] selftests/bpf: Use connect_fd_to_fd in sk_lookup
Date: Mon,  8 Jul 2024 10:29:48 +0800
Message-ID: <d378a49d14a3dd076d7e3e148c4418348138e1da.1720405046.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720405046.git.tanggeliang@kylinos.cn>
References: <cover.1720405046.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper connect_fd_to_fd() exported in
network_helpers.h instead of using getsockname() + connect() in
run_lookup_prog() in prog_tests/sk_lookup.c. This can simplify
the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index d03ea3e64a2e..184b838a9872 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -639,9 +639,6 @@ static void run_lookup_prog(const struct test *t)
 	 * BPF socket lookup.
 	 */
 	if (t->reuseport_has_conns) {
-		struct sockaddr_storage addr = {};
-		socklen_t len = sizeof(addr);
-
 		/* Add an extra socket to reuseport group */
 		reuse_conn_fd = make_server(t->sotype, t->listen_at.ip,
 					    t->listen_at.port,
@@ -649,12 +646,8 @@ static void run_lookup_prog(const struct test *t)
 		if (reuse_conn_fd < 0)
 			goto close;
 
-		/* Connect the extra socket to itself */
-		err = getsockname(reuse_conn_fd, (void *)&addr, &len);
-		if (CHECK(err, "getsockname", "errno %d\n", errno))
-			goto close;
-		err = connect(reuse_conn_fd, (void *)&addr, len);
-		if (CHECK(err, "connect", "errno %d\n", errno))
+		err = connect_fd_to_fd(reuse_conn_fd, reuse_conn_fd, NULL);
+		if (!ASSERT_OK(err, "connect_fd_to_fd"))
 			goto close;
 	}
 
-- 
2.43.0


