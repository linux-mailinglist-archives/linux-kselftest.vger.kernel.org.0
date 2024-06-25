Return-Path: <linux-kselftest+bounces-12609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E03915E42
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 07:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9021C225DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 05:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D475145B12;
	Tue, 25 Jun 2024 05:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl1k2khC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F042D600;
	Tue, 25 Jun 2024 05:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294174; cv=none; b=pcdK+/FA3YqsZTwlUyA2v9d4CChnw6qYqn+Bn+S26VIaZNeIBOnAFD2mBWzPOGk9r2fNrTHxAiQJnmRrNQdw5seMhBEHuT+aPAPB8WZVDLFZzzFydmIAJ8pIoIi7HCAlwa4WQGz/wddURu6YULiFoF4wcMYhXY7ufjJ1eYzAutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294174; c=relaxed/simple;
	bh=6J3QFqYCAkOLhnKytwHZMLodd5u01jabVIARSdmS/Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Epm2BVRDmimjdkfEtUWIEUgiECd5JWrxIhpzLAvhGjLTQoUKGrVFhb/XFwlXkaEuvFofR1nG4uYmEGqMM1mZ2GZLcypJAujoS8WFkzwIeV+dfbzG0NsyYXX04QntwpdhXRnDOlYdjS12MXyuH1ogIMxEDzYqGki4KxKzpXaYQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl1k2khC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB0CC4AF07;
	Tue, 25 Jun 2024 05:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719294174;
	bh=6J3QFqYCAkOLhnKytwHZMLodd5u01jabVIARSdmS/Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tl1k2khCCCGnSBBDNQo2Q8YJ4QuaeXqNSQbxhYSt/NufvAFbnErrNHwKc0/TYSc2Q
	 Zy3qNTZr0VVPpNTfbxWSX6qfvSTXlFDisKp3Vyd5GApFZJwB9fJuNBePsgkLkDSLIC
	 9K+Tf6tESkSNYFm8ChYv2nJmh/nFQpL784NNoUGkwR1VDcvQC6Fit89P6urbOue2UK
	 FCRGYGFK7ieHDItIrOF1RMhKdjH0Dyk27pyRCX69Ajj6ULoZxJj2iefIDC+fWuAE7R
	 ULHuRe7YIU2j3EUmYsIBInu/WjlHu7Duysq+bnGI2QobRXp/ZSvx1+otmx5wepthmg
	 p3raFEXER6HwQ==
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
Subject: [PATCH bpf-next v5 1/9] selftests/bpf: Add backlog for network_helper_opts
Date: Tue, 25 Jun 2024 13:42:28 +0800
Message-ID: <cca255aa6baff78a6cb06d41e1eb13a5015692ea.1719293738.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719293738.git.tanggeliang@kylinos.cn>
References: <cover.1719293738.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 2 +-
 tools/testing/selftests/bpf/network_helpers.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 44c2c8fa542a..16cbb3fdcabf 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -106,7 +106,7 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
 	}
 
 	if (type == SOCK_STREAM) {
-		if (listen(fd, 1) < 0) {
+		if (listen(fd, opts->backlog ? : 1) < 0) {
 			log_err("Failed to listed on socket");
 			goto error_close;
 		}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 9ea36524b9db..8339c4e4b075 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -25,6 +25,7 @@ struct network_helper_opts {
 	int timeout_ms;
 	bool must_fail;
 	int proto;
+	int backlog;
 	int (*post_socket_cb)(int fd, void *opts);
 	void *cb_opts;
 };
-- 
2.43.0


