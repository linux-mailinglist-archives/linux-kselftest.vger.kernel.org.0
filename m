Return-Path: <linux-kselftest+bounces-14113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 762E493A939
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1489AB2261B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4DC1494B9;
	Tue, 23 Jul 2024 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdPm2klD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248A31487EA;
	Tue, 23 Jul 2024 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773404; cv=none; b=QLVu6dMXXtGKrTmQL5kQwlcOAjkw4o8LnUxEzZq07loNmA6APCxrCHbid/mInZNvXz1g1ovwZjFbw1kc/myG2tj28Iufm5gghrppiHtqT9NAFvxIZQ4XWi/LyN9RKul0GgC2pvGbigO+biNmEICToqWKEQ4hgzhGvk95jfyxyoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773404; c=relaxed/simple;
	bh=ME+tSI8PBgw6F7c3OiWB1NRmntbKUJH1Ek+eeeScfqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8JFndErtPbUyWIuEVBDjIPGiBHaANKDTSh6okyCytihSv73SUd4COVPfxhfGWswxRW7m2mdkckYGnHGYUoTzExY5vKeSVp8ynhHfEXTbFVElQllDYMz8rKnMNwF1om2qymWWXDHOJ8mBmAXmamYHcY95Tz17TArKfwcZPc0oKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdPm2klD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A5FC4AF09;
	Tue, 23 Jul 2024 22:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773404;
	bh=ME+tSI8PBgw6F7c3OiWB1NRmntbKUJH1Ek+eeeScfqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WdPm2klDvcfsdO0G5UKGuhYAkHxrRaapwMfpAlhKxfl0Uy3Htgav78ANecohHQvDY
	 oJdTNAIsY0tgbt3b2NxYEdLhyycCZ+rtXlFSXqbucZMJiQAZ8Nmlksa6S0cIuJjPZh
	 fEqPNPlcJ4q5AjDVeEEEt3mzClRMLlxXksSn9VbNS5ltI9f+7H3yDcyfoYxuONR7C6
	 iINXm9lHwTRNBe4Nlsl5qM19KzhwkwYzE6TnqiRsFSeLFALSd9v/4RZy/PBQ5Nstva
	 zvfK/PGqZe8pPAw5Yf01FAzUQvp4IoYDjdf1ernmv/xuGyQ8FmiNvpFrwPpLWGkClw
	 M+kiEkEDecm5w==
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
Subject: [PATCH bpf-next 11/15] selftests/bpf: Add loopback_addr_str helper
Date: Wed, 24 Jul 2024 06:22:17 +0800
Message-ID: <92d84e92e60304b26e7bae9dfc65bb3548d4f3a2.1721771340.git.tanggeliang@kylinos.cn>
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

This patch adds a new helper loopback_addr_str() to get the loopback
address string according to the given different protocol family.

Also use this new helper in start_servers() in migrate_reuseport.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.h     | 15 +++++++++++++++
 .../selftests/bpf/prog_tests/migrate_reuseport.c  |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 16f266c53b61..893f07c677da 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -55,6 +55,21 @@ struct ipv6_packet {
 } __packed;
 extern struct ipv6_packet pkt_v6;
 
+static inline char *loopback_addr_str(int family)
+{
+	switch (family) {
+	case AF_INET:
+		return "127.0.0.1";
+	case AF_INET6:
+		return "::1";
+	case AF_VSOCK:
+		return "1"; /* VMADDR_CID_LOCAL */
+	default:
+		fprintf(stderr, "unsupported address family %d", family);
+		return NULL;
+	}
+}
+
 int settimeo(int fd, int timeout_ms);
 int start_server_str(int family, int type, const char *addr_str, __u16 port,
 		     const struct network_helper_opts *opts);
diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
index 653b0a20fab9..7c31c7fdaecb 100644
--- a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
@@ -221,7 +221,7 @@ static int start_servers(struct migrate_reuseport_test_case *test_case,
 	prog_fd = bpf_program__fd(skel->progs.migrate_reuseport);
 
 	make_sockaddr(test_case->family,
-		      test_case->family == AF_INET ? "127.0.0.1" : "::1", 0,
+		      loopback_addr_str(test_case->family), 0,
 		      &test_case->addr, &test_case->addrlen);
 
 	for (i = 0; i < NR_SERVERS; i++) {
-- 
2.43.0


