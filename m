Return-Path: <linux-kselftest+bounces-10570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC888CBDC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 11:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3321C21DA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 09:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0B981726;
	Wed, 22 May 2024 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW4QyOBu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946FB80C03;
	Wed, 22 May 2024 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369861; cv=none; b=nekrY8UWotMXM9ILwUZtQwf/vTp2k/loJYOEh8Q928Nay7eSW6DxFDIux2enV7CsM8xz71+4maW1C3URYmsiAWPtz7sTDiCGuGMpzqJhBUon4sAPfHel69cm6fqJpSThdeaggnx2xAeVPZOXWUzx0pgkKZ0KkoArrv8gzS52JT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369861; c=relaxed/simple;
	bh=0yBmu5S5ncLuzNMn+4w/iLpPYelZ07NCKFaB4AGxemg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iARhnOq/wcFAd7/eQIxc7ACL0/N1/KMubYnrOIZ/UAMUq1HtTO/ri19XasbS7BRTkRFHcaOVHY9FgYQhS8JXsfbtJUqqHGJarxGHsXkpfJoKNw0q1Abl38hLa5Dvp26jpsdFLKBVlW43OGIsTeMJRKD0IbfUUvrGqduFNsilR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW4QyOBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AE7C32781;
	Wed, 22 May 2024 09:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716369861;
	bh=0yBmu5S5ncLuzNMn+4w/iLpPYelZ07NCKFaB4AGxemg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aW4QyOBuMteAXpL+Wh8xt3a/7IQzX0h+PSw8x7JI+1Iu0+XYd6Lm4g+XlJ0HIfqhT
	 426GsKxkkNyg1Db+aWC56tcnhbpAGRkUdtlxkjJWf2+lmjLdH5ap3FVhFNkl3Wl4Xt
	 0dJxkL4P/cQv4aq6mlf6UPJZGSU86o+oRHF69wwTjI7szCiDzQzZ/oE/yP+NC+ebwi
	 GxpnTw1h10GODmmJNFIgJgfLFn6aHYAec4vnx++mh5RuhWrXcUvDzGB4O2zggCw8ZU
	 Ttt+54TqewGwwvyWmDIE6XLDSrDfN/5ic88fVX5BiipOc+GGm48Ow6kb6w8obgLel5
	 vUxQEc5WeWmlw==
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
Subject: [PATCH bpf-next v3 4/8] selftests/bpf: Add start_server_str helper
Date: Wed, 22 May 2024 17:23:46 +0800
Message-ID: <8adde24c5e1637aee65f9dd8e9710a7ca8d3f930.1716369375.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716369375.git.tanggeliang@kylinos.cn>
References: <cover.1716369375.git.tanggeliang@kylinos.cn>
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
index 49e807ffcccb..ba80005d2d7a 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -119,6 +119,21 @@ static int __start_server(const struct sockaddr *addr, socklen_t addrlen,
 	return -1;
 }
 
+int start_server_str(int family, const char *addr_str, __u16 port,
+		     const struct network_helper_opts *opts)
+{
+	struct sockaddr_storage addr;
+	socklen_t addrlen;
+
+	if (!opts)
+		opts = &default_opts;
+
+	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
+		return -1;
+
+	return __start_server((struct sockaddr *)&addr, addrlen, opts);
+}
+
 int start_server(int family, int type, const char *addr_str, __u16 port,
 		 int timeout_ms)
 {
@@ -126,13 +141,8 @@ int start_server(int family, int type, const char *addr_str, __u16 port,
 		.type		= type,
 		.timeout_ms	= timeout_ms,
 	};
-	struct sockaddr_storage addr;
-	socklen_t addrlen;
-
-	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
-		return -1;
 
-	return __start_server((struct sockaddr *)&addr, addrlen, &opts);
+	return start_server_str(family, addr_str, port, &opts);
 }
 
 static int reuseport_cb(int fd, void *opts)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index c925c771bd98..d1d28d4f92bd 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -48,6 +48,8 @@ struct ipv6_packet {
 extern struct ipv6_packet pkt_v6;
 
 int settimeo(int fd, int timeout_ms);
+int start_server_str(int family, const char *addr_str, __u16 port,
+		     const struct network_helper_opts *opts);
 int start_server(int family, int type, const char *addr, __u16 port,
 		 int timeout_ms);
 int *start_reuseport_server(int family, int type, const char *addr_str,
-- 
2.43.0


