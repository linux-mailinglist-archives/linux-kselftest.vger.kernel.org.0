Return-Path: <linux-kselftest+bounces-25170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62158A1C239
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 09:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5871888A64
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 08:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5642080DF;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j34qagjp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1DD207E1F;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737793828; cv=none; b=EYlJPFbDHj+iHfFXfNQJJlJCQyy9xwaKsi2zGbuhgNC0R/vRSVN0saZ9SfReIxyvVa1S2JfhuSQxqLBeLtSTVmPepUANUbC4c/fjk+Lz3GelJ0OPusD+tGoUDY49Ggy0BlROvKMJhqHLVRX9uND9vCg2n4+sh8+nqI4SIeFxw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737793828; c=relaxed/simple;
	bh=0ISlPQASi8sOGiTZRr8sXYkkw/cj+H2dHR0QbFcOJZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fE/M456cErgK0gw6qJIgcux8erovBtwTlRXH6p1VidBfGjcJt1sSvHGfQj3mwDvbzre/TwF94SWTkYBDgYuO6zeoidBU8/+IHgvPMQTDHr8532VAilGNQhxe8aNadQxh8OpXvdIkW057N4wjafzIy9qSdlsWL9/HF9KQBIHeKKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j34qagjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E522C4CEF9;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737793828;
	bh=0ISlPQASi8sOGiTZRr8sXYkkw/cj+H2dHR0QbFcOJZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j34qagjpglU0mUZTxVx7V705AZZ+TSZG8lr+v1hheI3W3UYXy8PLATiG3L7cdy1xQ
	 ezVDXNirVX6M5mbKRs77VP//QwDg/aBidH57SQTcUjtZK+rVZtQgfR7L72HniZDm7o
	 UOa24rf+87hPpVdaVcrOHRPmGOywvj9N0oTvZ+k+tAQYeZKYR2iVT44wm3IIhWlrzw
	 E04tVMxQpQnTuZtop+Vr7hjhVTEqO6ougPSFRThxqhaXfhp0z31kjPSOle5QmP/q1V
	 FxVu556UuXuMGg7rc7aQPO0v9LT83NnGA9yJjkC/zqEft7+v/nXFW7lArDr6CV2dSy
	 QebgY54JE9HEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C81C0218C;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Date: Sat, 25 Jan 2025 16:29:54 +0800
Subject: [PATCH bpf-next v2 7/7] selftests/bpf: copy_from_user_dynptr test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-bpf_dynptr_probe-v2-7-c42c87f97afe@outlook.com>
References: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
In-Reply-To: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Levi Zim <rsworktech@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2541;
 i=rsworktech@outlook.com; h=from:subject:message-id;
 bh=1lAHI+FdFmnes4eRlPuwbThpqaSf+nKUYWM4JR6lmdg=;
 b=owEBbQKS/ZANAwAIAW87mNQvxsnYAcsmYgBnlKEgaDOvvSTi2myiN4juIhT7XAwb4vipaIBC8
 te11MKDd8CJAjMEAAEIAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCZ5ShIAAKCRBvO5jUL8bJ
 2EHZD/4+UmX7SD5haN6mjGVHWxiNzKbUCDyXVJCQ4glNAR/glcfFXli/rDRJVW1037wSANcxq7G
 92qggOGmZCk2/hRHADnnTYYxdWaQhUlOdqfyX7YEhGTM8sS63DNfrryWbP9Gwxz8pTNv65nNrvM
 /iOJIGYe5oJ4XGoAV3jMqJoZHIeH7qHSw6WxCV03lGmFnw5jZrY1NYwdMhlboj2Gh6Owht3an/0
 QpV3nhuZZcGi9Ij7D48n5QFrRaso+HNYxPlR6+H198ITxErAE2jUBmh7cNGZDjdWCPK/PaMiaFy
 POx4mNrWjG2JyAGpBgdDSwDSe/YzUtpLRhoneOwlehCEm3IkbOCpabINUxII1qNb5R7KIQbDs+X
 feJXyRtTD4oe/W7cYyMqIQGsXFRG+UTj+PU71D3qH1FXhc7y/kbw+C46dljianT8fq9cjuJJmI4
 EYuDFrzvHH+Ysfglgu8hps76uV4I724bI5vC4wtDFjHhqMkQm/tkqCc3e3dqvvdDJ13PYBSZApZ
 4sRZPpCw4afkgdeJ9UeYVrclW8QslIV9ZiIgoRF48wjKQ//vqSDtcFYIaww4cO8wGxAsW9r04C8
 hRg/y/Q/TFka0xNPijh7FPE1Za5/PjkNptLlXMHqlsiCZiRZEtSuU38dvhK1XHR5fMMhvW4gyAs
 eLXZu1iOairMXpQ==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/default with
 auth_id=219
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com

From: Levi Zim <rsworktech@outlook.com>

This patch adds a test for copy_from_user_dynptr helper,
which tests reading variable length of user memory into a ringbuf
backed dynptr.

Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |  3 ++
 tools/testing/selftests/bpf/progs/dynptr_success.c | 34 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index a5a61a4c570d803bfca2af3f1a3b7d5eb0b8197f..a0095204609c710d49a6105ebf8be44723fb53d2 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -33,6 +33,7 @@ static struct {
 	{"test_dynptr_skb_tp_btf", SETUP_SKB_PROG_TP},
 	{"test_probe_read_kernel_dynptr", SETUP_RINGBUF},
 	{"test_probe_read_user_dynptr", SETUP_RINGBUF},
+	{"test_copy_from_user_dynptr", SETUP_RINGBUF},
 };
 
 static int ringbuf_cb(void *ctx, void *data, size_t len)
@@ -43,6 +44,8 @@ static int ringbuf_cb(void *ctx, void *data, size_t len)
 	if (!ASSERT_EQ(len, skel->data->test_buf.length, "length"))
 		return -E2BIG;
 
+	ASSERT_EQ(skel->bss->err, 0, "err");
+
 	if (!ASSERT_MEMEQ(buf, skel->data->test_buf.buf, len, "ringbuf_cb"))
 		return -EINVAL;
 
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index 5317860290dccb0862b6a0b94bb6f738c8d92835..10dda58fed66a05ad1b08c8684784fddabe3f4ad 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -639,3 +639,37 @@ int test_probe_read_user_dynptr(void *ctx)
 	bpf_ringbuf_submit_dynptr(&ptr, 0);
 	return 0;
 }
+
+SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
+int test_copy_from_user_dynptr(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	int copy_len;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	err = bpf_probe_read_user(&copy_len, sizeof(copy_len), &user_ptr->length);
+	if (err < 0 || copy_len < 0) {
+		err = 1;
+		return 0;
+	}
+
+	if (copy_len > MAX_BUFFER_LEN)
+		copy_len = MAX_BUFFER_LEN;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, copy_len, 0, &ptr);
+
+	if (-E2BIG != bpf_copy_from_user_dynptr(&ptr, 0, MAX_BUFFER_LEN + 1,
+		&user_ptr->buf, 0)) {
+		err = 2;
+		goto cleanup;
+	}
+
+	err = bpf_copy_from_user_dynptr(&ptr, 0, copy_len,
+		&user_ptr->buf, 0);
+
+cleanup:
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+	return 0;
+}

-- 
2.48.1



