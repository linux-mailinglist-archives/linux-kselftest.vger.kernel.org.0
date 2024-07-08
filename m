Return-Path: <linux-kselftest+bounces-13293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01920929AC8
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 04:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F2F1C2091B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 02:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619921C17;
	Mon,  8 Jul 2024 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIvfY4sy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A90B184F;
	Mon,  8 Jul 2024 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405812; cv=none; b=YzUkKMlo8lZ6U24IYBMxaK6eBn2Xual6BbKmrxFb9I+28eQXEvr8ISFl2zwAEzJ4X+E/ZWCjNMoEy9BdeU0r5f93Mnk8yE2oDRumfsaMRiBb+ECVjESmoziiiQa8wzKQ0HIt4yMeJG6VJxydd5jdruP50g89HJiFFr7SABWVbHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405812; c=relaxed/simple;
	bh=bAX1OLxg4DkksZvjRAzn/L1GhmwINGXrUi0DgLiNpt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgWYetkHn64wBRSusieN7k3ZK5askKh70uxxY7l6DKhSo+4DkiFk67/f7+KV/d60Bg74RGTRNTabyBU4v2B3HDBScNlW08qOt+fn46aKMfMn2NKIyg/Lb5aK6yp9yazqCNoKtcsHTQiNd6eDkV+aswwazf/VCesYufJGhpuxnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIvfY4sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCB0C3277B;
	Mon,  8 Jul 2024 02:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720405811;
	bh=bAX1OLxg4DkksZvjRAzn/L1GhmwINGXrUi0DgLiNpt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIvfY4sykQmxUTM9nl3RcnC6xZ4gWee2y1YjeKwxap/1gy1uJKZ3ftNmHCVwgbojt
	 qmJEaVAjojmpfmm26PyGD0EArejZOhQNWEeCAV68vHo60mCh9G2IbRKAAb40AdavJX
	 aGaTZlDMUmLX/orWwJVekHrDEb8BbfLohGm6JajReW4jdKMhwpZcy/NnfWJ5o+zy8C
	 t77dDQSo36GETC1Pd7fwHAcxqtzNaHGfjll7Rpls2tjOulcRaZszJylXHLl0lyFHox
	 QxSNFmaTDNssx6DXTCiwW/78dO5I/+eT3oGhYg8a/nrQNgDy54oGaoZaiEFNao2TDG
	 TMmSsjqq8K1dQ==
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
Subject: [PATCH bpf-next v10 01/12] selftests/bpf: Add backlog for network_helper_opts
Date: Mon,  8 Jul 2024 10:29:39 +0800
Message-ID: <d96c5386a8bc1eeb60ae120358918c03183a4aa7.1720405046.git.tanggeliang@kylinos.cn>
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

Some callers expect __start_server() helper to pass their own "backlog"
value to listen() instead of the default of 1. So this patch adds struct
member "backlog" for network_helper_opts to allow callers to set "backlog"
value via start_server_str() helper.

listen(fd, 0 /* backlog */) can be used to enforce syncookie. Meaning
backlog 0 is a legit value.

Using 0 as a default and changing it to 1 here is fine. It makes the test
program easier to write for the common case. Enforcing syncookie mode by
using backlog 0 is a niche use case but it should at least have a way for
the caller to do that.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 2 +-
 tools/testing/selftests/bpf/network_helpers.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 44c2c8fa542a..e0cba4178e41 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -106,7 +106,7 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
 	}
 
 	if (type == SOCK_STREAM) {
-		if (listen(fd, 1) < 0) {
+		if (listen(fd, opts->backlog ? MAX(opts->backlog, 0) : 1) < 0) {
 			log_err("Failed to listed on socket");
 			goto error_close;
 		}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 9ea36524b9db..4f26bfc2dbf5 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -25,6 +25,10 @@ struct network_helper_opts {
 	int timeout_ms;
 	bool must_fail;
 	int proto;
+	/* The backlog argument for listen(), defines the maximum length to which
+	 * the queue of pending connections for sockfd may grow.
+	 */
+	int backlog;
 	int (*post_socket_cb)(int fd, void *opts);
 	void *cb_opts;
 };
-- 
2.43.0


