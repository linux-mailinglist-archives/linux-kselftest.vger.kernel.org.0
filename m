Return-Path: <linux-kselftest+bounces-14110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3F893A932
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6951C2242B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829F0149009;
	Tue, 23 Jul 2024 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acr3xK2P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21414831C;
	Tue, 23 Jul 2024 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773391; cv=none; b=aZq4Aj2VSr3xKBEblmw0PianGkkUmVWhSZJ9qZJb6kFaWdlPCyYRndbJZMbiBkpQx5z/HLm2faYn6Hg4kbSoYBMjybTQIFgEaxQIZXNnkKB3LzbilDjMt8lsW9WTZBMvIYjuSMgIANBhw6s1kRFK7VWc8LLMnMmss1Cq4sb7asg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773391; c=relaxed/simple;
	bh=5om8By3O7JAi0xe/XZSca4IIUIS1286qoC70zrmf0Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hk34AMLIBJmOoEGNOFtwBccB93r5vKANm3JDUCUXCSA+S9KD4t7atG0VJlTi28STp+2Yg1kFh1jJ7p8yMOhL3JEoa2BSgn45yM4AoLxggqldin17n1TmFjcH+L7qqvjLkFcpOQyAynBF4puMJpM3Empw37JuhiBV7Vgoms5ryM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acr3xK2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7A9C4AF15;
	Tue, 23 Jul 2024 22:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773391;
	bh=5om8By3O7JAi0xe/XZSca4IIUIS1286qoC70zrmf0Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=acr3xK2PzD3aIS+fw4f3hDCeUsa8MyFu4WJqeMIQT5/E3EPx+Km0SZvRFEn9ZIlmF
	 ihKTGUcXH06mdmK3m54kPrnMNL2gEVEy7N9lvrAGjWQo35LDDNIuC5SSg3eN+6lICW
	 /adU40IYjWtz9svqGYCk44f0W557TBNJkhjQHMrIE9ns2SXt/25zWffmGumxKfPE/b
	 sZOTJ5EirkBMw9Rp0EcaEsTMBGRoTLAmnAv8jLAbufaXG9WtKNGWI9fynXUZAveLew
	 Sdmq2i3niJ/Tt3NrQBSFZ0zNeVXHdkVTllq4GqyESWtyF4p25Gbti7dm7bXuRFVMvb
	 BSUL/0l9GiQdg==
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
Subject: [PATCH bpf-next 08/15] selftests/bpf: Add nolisten for network_helper_opts
Date: Wed, 24 Jul 2024 06:22:14 +0800
Message-ID: <bf1035738532f5c21ae42f05d14fc00e334079ef.1721771340.git.tanggeliang@kylinos.cn>
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

This patch adds a struct member "nolisten" for network_helper_opts,
which is used to control whether to invoke listen() or not in
start_server_addr().

Also print out a warning if backlog is set for a type not support
listen for connections.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 5 ++++-
 tools/testing/selftests/bpf/network_helpers.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 8f39adbc2c16..f140a76d3d7f 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -109,11 +109,14 @@ int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t a
 		goto error_close;
 	}
 
-	if (type == SOCK_STREAM) {
+	if (!opts->nolisten && type == SOCK_STREAM) {
 		if (listen(fd, opts->backlog ? MAX(opts->backlog, 0) : 1) < 0) {
 			log_err("Failed to listed on socket");
 			goto error_close;
 		}
+	} else if (opts->backlog) {
+		log_err("Useless network helper opts: backlog %d",
+			opts->backlog);
 	}
 
 	return fd;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index ebed1fb1bd49..16f266c53b61 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -34,6 +34,7 @@ struct network_helper_opts {
 	 *	changing the "tcp_syncookies" sysctl from 1 to 2.
 	 */
 	int backlog;
+	bool nolisten;
 	int (*post_socket_cb)(int fd, void *opts);
 	void *cb_opts;
 };
-- 
2.43.0


