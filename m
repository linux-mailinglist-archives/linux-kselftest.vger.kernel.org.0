Return-Path: <linux-kselftest+bounces-12503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F3D913726
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 03:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7C01F225D0
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 01:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E60393;
	Sun, 23 Jun 2024 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJaKHy3v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096AF322E;
	Sun, 23 Jun 2024 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719105643; cv=none; b=mnNoHE2rtXM6Vd7r0FFZiJXHp1bLFnhJZqlXtMMTbH/Se3KuFdO0LAe7U3twZ3z29W0gWIWzzDorRN2hwY+q/yXReYyinhVkgAIQr2pm/58sGkRCI8tFnv21ficsmpfaMAti4eUcD+yjw8IvHgr/vB+Otn9vZ9s1iDN+dcMeYRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719105643; c=relaxed/simple;
	bh=79yDcImEqqHbx/0HXLa9+5R2nATdrKeFx/puip3C+yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJKwGSA/oM4P79PKFGELy/nXQo/WlyhttjJCUeNmx+6PYI3QCuexsCjF/7/5AkyYN1LljmJR7sEG7TgUTLOTH/HnbHNYAf9aY2K2hujc8zPygMB+lP0QlBsBfKltNYAxNwYhNeit9pMLEwJC9vYdFmVFa1pEdIgSKGdMZhVC0Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJaKHy3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11ABC32789;
	Sun, 23 Jun 2024 01:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719105642;
	bh=79yDcImEqqHbx/0HXLa9+5R2nATdrKeFx/puip3C+yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jJaKHy3vVtuNFbr6YJ0XP6EWe2oVULrUcJGtuY3gJ0H5eMQoSoQJBCdGz0hhusE1Z
	 Ynp7FlnG5v/UtUjRr78y5XQZuabosglWETFIVPlLfoQ0t9U1mkMuORnkkoREQNwdGB
	 9/n47jpdPQ87YEjYspgq3ONhUjE8SvFtMuakC2Ak6WC1cy7nYkBZbadS7zlRbYB4V+
	 pvX2KVz73DDtEZ+vnuB6hegA5b05WyflkCn4Q7i8vJucqtiHE8LES6Nx/ge1p5E3Vs
	 EDjxu1QGNPSLrptdmobbvrqRxb9vzMEniBkehc9ij3oQ5fR0wUsZcOklaYlcMtrSV9
	 5/rkv01SPh2Lw==
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
Subject: [PATCH bpf-next v3 1/8] selftests/bpf: Add backlog for network_helper_opts
Date: Sun, 23 Jun 2024 09:19:55 +0800
Message-ID: <b13abdb5a10206f2a06b916c19d35d336da93324.1719105178.git.tanggeliang@kylinos.cn>
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

Some callers expect __start_server() helper to pass their own "backlog"
value to listen() instead of the default of 1. So this patch adds struct
member "backlog" network_helper_opts to allow callers to set backlog via
start_server_str() helper.

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


