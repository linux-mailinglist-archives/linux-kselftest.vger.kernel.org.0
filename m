Return-Path: <linux-kselftest+bounces-10647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B12598CDFB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 05:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3569B2140A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 03:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C444212E4A;
	Fri, 24 May 2024 03:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyM0WhOw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986961EF01;
	Fri, 24 May 2024 03:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520953; cv=none; b=soguBufa1BZeHyJP6Bo/04/Zn1XZ+kLeKSNdYNVjtte7Aj8t1Jf839YEJ5DhYeBXOvkNDUKtMaHljkI5h/oR2yrCuAibDloC25FHBhV5baCQPP0+MOCzGRfCe/q3VfUjSh9kjx34vFNL5YV2G4u3oVDEIR5pYHMwjmXyPTaOD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520953; c=relaxed/simple;
	bh=394h3Q9cvyh41rfbfaAmL8bMBRnTOy6D4vSWMspn9Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XixLBcJI8r/YGojg/nMnnNgh+4bufKjK7N+rk7bIiVVz+fNVC0JpopBR0lOe2idhousNN8gHrhSSNrxamYtT75GCOB8+c6Vw++umSu75oLqkj7oE/qQLo4lvcZcNngdXq7bowaqi4Ukd1HoOr7B42GEHcuF1QxfFEdo+G+OlbTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyM0WhOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463B0C2BD10;
	Fri, 24 May 2024 03:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716520953;
	bh=394h3Q9cvyh41rfbfaAmL8bMBRnTOy6D4vSWMspn9Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NyM0WhOwkkwvl/vJvKmaTvOmMGxbGykI6Bhd0j8CTHBG8jYn7vhPRvk5csEuAmkNc
	 dKn5FLA8GI3rHxl3tBUxG9mgmKWSZAjumHbFkGQKxeuRJqp8Bzv0E7lKIVEgPwpMsz
	 pfRaHg5tbvN3dsgxoTuG24+/6YqzmX58Wi90SjXxcgm8jmvfwEppxmyKvzJhztfr74
	 5i9U8JsqjjpFOqeE9w2s05MFQS9CtCDpDESM6LhjX/7ADmGO66fXvTdEvUPs8Sp9EY
	 LKifP1KZBzA6NzKjhPTMswvIyQfzEUKqaD62yi0HpW1o/2PHACsv9K1CpMs+sJvXTa
	 lhIT6MESs1ddw==
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
Subject: [PATCH bpf-next v4 2/6] selftests/bpf: Add start_server_str helper
Date: Fri, 24 May 2024 11:21:50 +0800
Message-ID: <e0094a0ed6c3116fdbabb0e57ee1d6dc20f8198c.1716520609.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716520609.git.tanggeliang@kylinos.cn>
References: <cover.1716520609.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

It's a tech debt that start_server() does not take the "opts" argument.
It's pretty handy to have start_server() as a helper that takes string
address.

So this patch creates a new helper start_server_str(). Then start_server()
can be a wrapper of it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 22 ++++++++++++++-----
 tools/testing/selftests/bpf/network_helpers.h |  2 ++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 4d776b78929c..0e8266f439e4 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -118,19 +118,29 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
 	return -1;
 }
 
-int start_server(int family, int type, const char *addr_str, __u16 port,
-		 int timeout_ms)
+int start_server_str(int family, int type, const char *addr_str, __u16 port,
+		     const struct network_helper_opts *opts)
 {
-	struct network_helper_opts opts = {
-		.timeout_ms	= timeout_ms,
-	};
 	struct sockaddr_storage addr;
 	socklen_t addrlen;
 
+	if (!opts)
+		opts = &default_opts;
+
 	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
 		return -1;
 
-	return __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
+	return __start_server(type, (struct sockaddr *)&addr, addrlen, opts);
+}
+
+int start_server(int family, int type, const char *addr_str, __u16 port,
+		 int timeout_ms)
+{
+	struct network_helper_opts opts = {
+		.timeout_ms	= timeout_ms,
+	};
+
+	return start_server_str(family, type, addr_str, port, &opts);
 }
 
 static int reuseport_cb(int fd, void *opts)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 40011e0f584b..4e3e6afe7d3a 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -48,6 +48,8 @@ struct ipv6_packet {
 extern struct ipv6_packet pkt_v6;
 
 int settimeo(int fd, int timeout_ms);
+int start_server_str(int family, int type, const char *addr_str, __u16 port,
+		     const struct network_helper_opts *opts);
 int start_server(int family, int type, const char *addr, __u16 port,
 		 int timeout_ms);
 int *start_reuseport_server(int family, int type, const char *addr_str,
-- 
2.43.0


