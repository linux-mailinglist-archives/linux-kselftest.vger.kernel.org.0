Return-Path: <linux-kselftest+bounces-12201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A8B90E1BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 04:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB411284318
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2548147A40;
	Wed, 19 Jun 2024 02:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPmdfWax"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAAAA38;
	Wed, 19 Jun 2024 02:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765496; cv=none; b=Tl/TTeRVTGmRbORSqghBfi81emPq/MUtkYBDSIfFaY1+K27kFo2RJ9Lcgr9m3ybHNznoICtw4p3DcBs3r4bxCOW5KxiiIIbPfuaEWiDodsG8wpq9Ewip2hYUp0UdlOg3KnJ6q5kglu47NYdvmezApYW4DVAg33PZH6E6LmwLlGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765496; c=relaxed/simple;
	bh=IyI+5mfdXdRGEZ25H4iJ6MDa36Nwzem0EaClRMA4XKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1Ck2J+65FdRQlnp3MNhZwTJF6KVYuV1vhZX7ED8sIHkiNKXe/+dd8Jy5PKoEd1pSHRLklO+DOHwxiAESOXSnsGfpquTwZuMP0FY2w+W2nyoQIELhQcbBmIWqvHNTUuH1wqCNaVClJExBP7jSSDIcTrHfkE2dvnnCiooA8MFYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPmdfWax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A20C4AF1A;
	Wed, 19 Jun 2024 02:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718765495;
	bh=IyI+5mfdXdRGEZ25H4iJ6MDa36Nwzem0EaClRMA4XKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPmdfWaxQnE6RFW1NgHalOmC+gyAKpvcyF054vAaH6XLgaU2w+XmNmmep+GmNGQpF
	 TrdFMrjhZN6X7GLhPo2mPFJ3W3StSNcB7i/P3Zym0l3qV/3F3ETn7EOQOubqYOqHtj
	 DWwsolAO/5rMk8Z1WEhgsnhVMjhaIX26XiOTIwiE33jDZvZUsIMO5LRxonpVSMe04+
	 /CdLFjRmmdfCNiCyfwnQkH+7seUTi5WdeIZhdREWn+UZvB2aVfeYOZ1iyCgApVuDV1
	 L31bc5gPziFFmVDNmMZ5Mxn1ALVzm4njNeJrPsy2HzyKaZaOi/nAK/3kf3EqYTVsHg
	 ZNtp3doPEKSaw==
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
Subject: [PATCH bpf-next v5 2/6] selftests/bpf: Use connect_to_addr in connect_to_fd_opt
Date: Wed, 19 Jun 2024 10:51:07 +0800
Message-ID: <111461ffad4eb29083d4b73c3d15fc619914e041.1718765123.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718765123.git.tanggeliang@kylinos.cn>
References: <cover.1718765123.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch moves "post_socket_cb" and "noconnect" into connect_to_addr(),
then connect_to_fd_opts() can be implemented by getsockname() and
connect_to_addr(). This change makes connect_to_* interfaces more unified.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 33 ++++---------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index c0646d5a4283..5d1b4f165def 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -293,9 +293,14 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	if (settimeo(fd, opts->timeout_ms))
 		goto error_close;
 
-	if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
+	if (opts->post_socket_cb &&
+	    opts->post_socket_cb(fd, opts->cb_opts))
 		goto error_close;
 
+	if (!opts->noconnect)
+		if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
+			goto error_close;
+
 	return fd;
 
 error_close:
@@ -306,9 +311,7 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 int connect_to_fd_opts(int server_fd, int type, const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr;
-	struct sockaddr_in *addr_in;
 	socklen_t addrlen;
-	int fd;
 
 	if (!opts)
 		opts = &default_opts;
@@ -319,29 +322,7 @@ int connect_to_fd_opts(int server_fd, int type, const struct network_helper_opts
 		return -1;
 	}
 
-	addr_in = (struct sockaddr_in *)&addr;
-	fd = socket(addr_in->sin_family, type, opts->proto);
-	if (fd < 0) {
-		log_err("Failed to create client socket");
-		return -1;
-	}
-
-	if (settimeo(fd, opts->timeout_ms))
-		goto error_close;
-
-	if (opts->post_socket_cb &&
-	    opts->post_socket_cb(fd, opts->cb_opts))
-		goto error_close;
-
-	if (!opts->noconnect)
-		if (connect_fd_to_addr(fd, &addr, addrlen, opts->must_fail))
-			goto error_close;
-
-	return fd;
-
-error_close:
-	save_errno_close(fd);
-	return -1;
+	return connect_to_addr(type, &addr, addrlen, opts);
 }
 
 int connect_to_fd(int server_fd, int timeout_ms)
-- 
2.43.0


