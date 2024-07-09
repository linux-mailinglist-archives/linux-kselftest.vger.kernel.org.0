Return-Path: <linux-kselftest+bounces-13353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B98192B37C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 11:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA1A1C21BEB
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2E4153BE8;
	Tue,  9 Jul 2024 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea9DS2+B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C115383C;
	Tue,  9 Jul 2024 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516635; cv=none; b=kGA2GRKXcKjh6G9nNeq2hWzN1tVJj9i6jHuSq9egkdi8KrdBWoUVZ3RLnE/Gq8CNTh0+vI3YGUxHYs+03YcEZvtquXvALlH2DtgOMTHwJdLh0F/sI4wIY8AHyQICNYAowy6uMhk648bolJQ+Ps3M1xPRY/wLevFyDb5/CjVun8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516635; c=relaxed/simple;
	bh=RtLAAxP63ev6PDaj8W5yBc8/wpTYJbAhYJ9yfFG6RIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaJbjbEDYyY0njo+On6r3UpJoQUHQBJBszioZvLtFpCh1LPlDTs/thQRWTlKcL0P0yjFyfVJ1YgQaJSDHHYIpWcyTpRlXNqUOTydQUPxEKkjujd4XayWM7+YbhTaMDN+RrPSbNniE7nF/MVChcbH5WV8ASluz8SbCqHABRDFVNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea9DS2+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C42C32786;
	Tue,  9 Jul 2024 09:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720516635;
	bh=RtLAAxP63ev6PDaj8W5yBc8/wpTYJbAhYJ9yfFG6RIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ea9DS2+BKOusGq892C+lT1qD2mzSpkT97qzt9Dr4gBJjMt78oFAu0jHf9E3EmcZM6
	 JIXKaP+4D2pLCdgdR8ox6rN23163kVwsjnnddVX12JkKKwG+/EQ4RfivcYphbehvHY
	 Rbn2oufEXZbVIcKCb05lppGNXQeqN+isn7ASy1NlRAkOkXXXXAlHufz+G8YTkyCIh0
	 8y5KhrPSYi94SIgWu/l8dmp622KwmUtSgaBYhwjI/Z/ZhY/zuAIcx1xo5UaAJQ3cJf
	 i3nEImUsSzb0v1JiWAt1kUgfEvFsdWb1OWDx1L0HcwNS7lWYYr34WGuRgHkZWA0QSn
	 vfGb3/THR6x7g==
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
Subject: [PATCH bpf-next v11 5/9] selftests/bpf: Use start_server_addr in sk_lookup
Date: Tue,  9 Jul 2024 17:16:21 +0800
Message-ID: <f11cabfef4a2170ecb66a1e8e2e72116d8f621b3.1720515893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720515893.git.tanggeliang@kylinos.cn>
References: <cover.1720515893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper start_server_addr() in udp_recv_send()
in prog_tests/sk_lookup.c to simplify the code.

And use ASSERT_OK_FD() to check fd returned by start_server_addr().

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 20ee5da2c721..386e482be617 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -416,18 +416,12 @@ static int udp_recv_send(int server_fd)
 	}
 
 	/* Reply from original destination address. */
-	fd = socket(dst_addr->ss_family, SOCK_DGRAM, 0);
-	if (CHECK(fd < 0, "socket", "failed\n")) {
+	fd = start_server_addr(SOCK_DGRAM, dst_addr, sizeof(*dst_addr), NULL);
+	if (!ASSERT_OK_FD(fd, "start_server_addr")) {
 		log_err("failed to create tx socket");
 		return -1;
 	}
 
-	ret = bind(fd, (struct sockaddr *)dst_addr, sizeof(*dst_addr));
-	if (CHECK(ret, "bind", "failed\n")) {
-		log_err("failed to bind tx socket");
-		goto out;
-	}
-
 	msg.msg_control = NULL;
 	msg.msg_controllen = 0;
 	n = sendmsg(fd, &msg, 0);
-- 
2.43.0


