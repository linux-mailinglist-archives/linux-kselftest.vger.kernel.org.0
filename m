Return-Path: <linux-kselftest+bounces-14107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03B793A92D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B711F2374C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E649414885E;
	Tue, 23 Jul 2024 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPSnLxjP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF29F14884F;
	Tue, 23 Jul 2024 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773378; cv=none; b=QRzKjpOkydrNmO/JAGFVa2lOud+XzvG7Jp8viC1kHyWEN0mLd5AEZ3m55a3x/xkDgPGEe2yuLQl7jpAn8rzJdko0nraVb1MUGGN/0MaZB30QKzN+iaRdtw7JJ+7R8Ry8RajS+TmBESy4T+A9cvI7VWKzy2u13aS2DMcRLiRySc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773378; c=relaxed/simple;
	bh=vMawzUa6obfX+VBE9Ykam0WOLhjlYMSTbs5HX0CvXPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9+2HgOceyn59qX+8KF+oOJ7/uR2YsuzVY4nllrtxy4FJ0iBPiF4nWjFMRuPtbu9NqLQIGgmCjRC5t3dWKRCaIPVTTZUpK3nxTvjPz6bm8q8TwG/aFiGxMvl5grlX0cDw0PUcorxfTIHvsTOs0QPeEdDq2vklOkp9hjDZZdewOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPSnLxjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB26EC4AF09;
	Tue, 23 Jul 2024 22:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773378;
	bh=vMawzUa6obfX+VBE9Ykam0WOLhjlYMSTbs5HX0CvXPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WPSnLxjPk5JyEmeMZwyF5/WZBbvqpLZmR6awUviXvVX02VnRG7QwIF2h0k1vV8tLW
	 sRU4RPgLd4ik3vQ7YNruKqbmnvaN08C+a8JGe3QxLfNDW28fRiOdGMK4+Dn11PFlhd
	 1Gh5AeW+jCe6G2DVPvCBy+5+RIxz/y7uz5sGGU3bPTDb74gY34oRqSKYrPkyq0uYKd
	 1cTcsYPiyRX2KfQDrsXh9pIcWUD9pm4sJCgNqE5b53vDTC6SowYHenU+htjzrn0pBD
	 BddBQVVaE25oqIGiF1p6XAQrGHxdJRIMGHQ3Le2T2811jtgd0iUlfRHj1tyEHMKz6Z
	 Anda4sQ7ixQtA==
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
Subject: [PATCH bpf-next 05/15] selftests/bpf: Add send_to_addr_str helper
Date: Wed, 24 Jul 2024 06:22:11 +0800
Message-ID: <7a909bf0164987f1b92f505a9dfb85509c57bf9d.1721771340.git.tanggeliang@kylinos.cn>
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

Similar to network helper connect_to_addr_str(), this patch adds a new
helper send_to_addr_str(). It uses make_sockaddr() to make a
sockaddr_storage type address from the "family", "addr_str" and "port"
parameters and passes it to send_to_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 16 ++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 311c3a559414..a6c158718267 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -229,6 +229,22 @@ static int send_to_addr(int type, const void *data, size_t datalen, int flags,
 	return fd;
 }
 
+int send_to_addr_str(int family, int type, const char *addr_str, __u16 port,
+		     const void *data, size_t datalen, int flags,
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
+	return send_to_addr(type, data, datalen, flags, &addr, addrlen, opts);
+}
+
 int send_to_fd_opts(int server_fd, const void *data, size_t datalen, int flags,
 		    const struct network_helper_opts *opts)
 {
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 19210a234bc1..ebed1fb1bd49 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -76,6 +76,9 @@ int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
 int send_to_fd_opts(int server_fd, const void *data, size_t datalen, int flags,
 		    const struct network_helper_opts *opts);
+int send_to_addr_str(int family, int type, const char *addr_str, __u16 port,
+		     const void *data, size_t datalen, int flags,
+		     const struct network_helper_opts *opts);
 int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
 		     int timeout_ms);
 int make_sockaddr(int family, const char *addr_str, __u16 port,
-- 
2.43.0


