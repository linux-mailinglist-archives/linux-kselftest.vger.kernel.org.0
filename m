Return-Path: <linux-kselftest+bounces-13295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CD0929ACD
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 04:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A451C2096B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 02:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED311C17;
	Mon,  8 Jul 2024 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvBMcH6s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03931184F;
	Mon,  8 Jul 2024 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405826; cv=none; b=db4sdJ2xojLqWgpOD8K5LclRuh2RXLJtCR07bUMkbNaO1rKSjuUpmMYa+XLOtRpqfiwfSiErHqAvXRe2JlRXBDpb2gP8PC+8p+uP0zPNwd8h+Cl4nY/qydzKymISoHCqdSyvOVhcs0kC8zNsgCoe95wlo+H749VRsDlpVr1Z76M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405826; c=relaxed/simple;
	bh=Qq9hn27IvadosGSaFEY1IhNuXDt86aHiR/dUXu2AMTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SViJaJO2rWLNxFHDMgCxGxbANiWpssWDReU9EEA/He2+Gp0gJDjn04raardrS8AezXjJfrxUW/rro5sp5a3bTgEY3W34dWuBvjkNycC4KMuOh4Mjzl/RBRLwUROaRRtbbUUxp4e+5RDT8HRg60qiBmwGySayFTHaheiDXWUyf+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvBMcH6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C39EC4AF0E;
	Mon,  8 Jul 2024 02:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720405825;
	bh=Qq9hn27IvadosGSaFEY1IhNuXDt86aHiR/dUXu2AMTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvBMcH6snhujarZnl0iZUu1eGJ8IsjBTrEOAtl5knifC55cEMg1520ZqBzH8nJxJI
	 k9JyPHPsYW34c0MFQDsFJfIVgm6OiktDVXg55UGsQCEgZh3ANDQuUOYCzhKe4YYjpw
	 Qksm+5jyahozfAUV9+vSPS71kjK+FZ9eBku4pDBJ7/u8ltsWrsnOuaVwyg5MeHhLtI
	 lzPoQTVtYr9ISZEoAGEbjnrAkIoEeYx+jpugCXlEW/qoGceyl5HPupuCvZOnGN53t+
	 FzRO0FMTOAHFKvY2PEeE+mOydqz+DXA3ZYmNqU0XO0z4cViaPM6iyh0hVbPRVXONch
	 yR+1R1ZPNlEAQ==
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
Subject: [PATCH bpf-next v10 03/12] selftests/bpf: Use connect_to_fd_opts in sockmap_ktls
Date: Mon,  8 Jul 2024 10:29:41 +0800
Message-ID: <20077624db9fbde04addd639f36ccfffbda5e033.1720405046.git.tanggeliang@kylinos.cn>
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

Use public network helper connect_to_fd_opts() instead of open-coding it
in prog_tests/sockmap_ktls.c. This can avoid duplicate code.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c        | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 32be112967a5..a794aa688ab5 100644
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
 	if (!ASSERT_GE(srv, 0, "start_server_str"))
 		return;
 
-	err = getsockname(srv, (struct sockaddr *)&addr, &len);
-	if (!ASSERT_OK(err, "getsockopt"))
-		goto close_srv;
-
-	cli = socket(family, SOCK_STREAM, 0);
-	if (!ASSERT_GE(cli, 0, "socket"))
+	cli = connect_to_fd_opts(srv, SOCK_STREAM, NULL);
+	if (!ASSERT_GE(cli, 0, "connect_to_fd_opts"))
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


