Return-Path: <linux-kselftest+bounces-8837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C698B196D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 05:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D661F2336F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 03:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D811CFB2;
	Thu, 25 Apr 2024 03:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/NnXh/S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CEC1CD2B;
	Thu, 25 Apr 2024 03:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015489; cv=none; b=Z65Ogc9mQcVL4Wx/1Hj3LPLoRwY7WUU/VD6Ci+YUGRja7ADLSUaXOI6Sq8gn88esXMrx9FEFirW3c7YVtPBOgraFW7wnAvHhmaCXFM0UYrNaqZKZTt9c3v+afUTErabyTJeI/6WsbGEdT3ZZpMQou3evP2opuH2puhhPp5Ym7bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015489; c=relaxed/simple;
	bh=9+yIzx3EP2XgITiiTjTwmTvJqp8Yxc/T0zf9HG3dBbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tTVvQBYaD2Xq3a2CrGfCbcF9Qz5kE5S1qfq7DK1pVMq2Js/e4SqIyenOCbd7wVozHgqnXZJYzU3ol9CinJSWuF8aLEnM0DVjhBMCUZZtCnB9aF2ZnoQY8OYNRJuw4yKRmbknPQ+4wDgaCH0VxXe6K9uBEJmyvf7Gv+64N0k61XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/NnXh/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E139C2BD10;
	Thu, 25 Apr 2024 03:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714015488;
	bh=9+yIzx3EP2XgITiiTjTwmTvJqp8Yxc/T0zf9HG3dBbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/NnXh/Sko2uwi+bC2HZ43oJHXmJn88CqiQtAhtmoFnnqD/QKFRpKUwIGoLpG1NDx
	 p6uRpzspA+w484Aw5XyDVmBo3dFvIDT0weLT2d1PSHRX8qjQsKupHQn5babPnX9VXf
	 4kkoJyXvvzv1uJTo7sEmDPYGGxoSpAQv/eo2fE4OAzXTycocNS3cpNwfjh8CUNG9m9
	 mkA8zccYk8tWjtfOAxIsWCv205+eAHuzHqVFFeurrQziZLruo/SQU8v4AEUUex8Wu8
	 KhgoEN8fuygtGKSaaN4l+gQDGwf2GOEhjGnJC/B5+ZItpkjDfUOXSIcn6bORfWMSge
	 pNJX+ks9tKbjw==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next 3/6] selftests/bpf: Drop start_server_proto helper
Date: Thu, 25 Apr 2024 11:23:43 +0800
Message-Id: <55d8a04e0bb8240a5fda2da3e9bdffe6fc8547b2.1714014697.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1714014697.git.tanggeliang@kylinos.cn>
References: <cover.1714014697.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Protocol can be set by __start_server() helper directly now, this makes
the heler start_server_proto() useless.

This patch drops it, and implenments start_server() using make_sockaddr()
and __start_server().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 4f16f7d6ce3f..1519f02f8090 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -120,12 +120,11 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
 	return -1;
 }
 
-static int start_server_proto(int family, int type, int protocol,
-			      const char *addr_str, __u16 port, int timeout_ms)
+int start_server(int family, int type, const char *addr_str, __u16 port,
+		 int timeout_ms)
 {
 	struct network_helper_opts opts = {
 		.timeout_ms	= timeout_ms,
-		.proto		= protocol,
 	};
 	struct sockaddr_storage addr;
 	socklen_t addrlen;
@@ -136,12 +135,6 @@ static int start_server_proto(int family, int type, int protocol,
 	return __start_server(type, (struct sockaddr *)&addr, addrlen, false, &opts);
 }
 
-int start_server(int family, int type, const char *addr_str, __u16 port,
-		 int timeout_ms)
-{
-	return start_server_proto(family, type, 0, addr_str, port, timeout_ms);
-}
-
 int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms, unsigned int nr_listens)
 {
-- 
2.40.1


