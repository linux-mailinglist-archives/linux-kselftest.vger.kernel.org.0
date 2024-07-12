Return-Path: <linux-kselftest+bounces-13676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1488792FC72
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 16:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467361C22502
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 14:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660B317166F;
	Fri, 12 Jul 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr26z2e0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4EE13F439;
	Fri, 12 Jul 2024 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794279; cv=none; b=UrCtofbyMYqFGvNVjqDc9wUrFTH9NL1lTk4p6B8UFlEz0Y8j9oMrqClXhpJ50mDnS80PGfoq3iBiisnDu3E5RPVqY32LeexF+RrcBfAga12+qvZPMIviM1lt89M6zgSQO+LYsqGRCI0gHgLdRk8LJA9OTfAvh2nxTHxSZLN4naU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794279; c=relaxed/simple;
	bh=FOFEopIEgkSl/GAHe6VBDmsgPaR+r2/zBmzqcK309pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sC+vtitIG9AUdxPE+YeLIlZmH1fEvrBpc+hD7LxaeIaYh539qpwqJtix7UgP6lVYpYXX7wb8DPqsSeoSj5EsCIfs2cWs8c49PWsLiLjAJ9khqEk6mK/NYU6Xttwe66ttlVVR6kc3dmVZgFdp+QK9Qk8u9+zch4lhiNsHYmEXCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr26z2e0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9568C4AF0B;
	Fri, 12 Jul 2024 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720794278;
	bh=FOFEopIEgkSl/GAHe6VBDmsgPaR+r2/zBmzqcK309pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kr26z2e0m4McpCRzPEx2PPfRdB7CVF4l5N6G9uSZ/iSn7J4e/duC3z5FAIbkXhfv9
	 a0LgrnMRKnhcJbOluYi4bxja/6fZiuehjZceM2vY4oiiDVaRO3BaU8p04WqUKJ3tAZ
	 v0YYPLszNOlHMZ2I9IA8BA3YXdkADgQJR2o2ORTuAG2CoHWQV3Ry79+z2EKkAWAaY7
	 w8jix5agqUbEOKJE2DizuKF7FdVNIKIeWQLbA2xCG1dUYsSXt9Y56trqFZoMJ9gGPR
	 cQ5VyWukTU4hLRjapPva7O+Tnw8OfRVsErqgkDd++gaB0tVJRJ8EpTShJLY7CZVA4s
	 nyaNA9sf6tqNw==
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
Subject: [PATCH bpf-next v2 2/3] libbpf: handle ENOTSUPP in libbpf_strerror_r
Date: Fri, 12 Jul 2024 22:24:17 +0800
Message-ID: <f44699a1dc14a5c93ee7bba7e5178530f082f813.1720791489.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720791488.git.tanggeliang@kylinos.cn>
References: <cover.1720791488.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Errno 95 (ENOTSUP or EOPNOTSUPP) can be recognized by libbpf_strerror_r(),
but 524 (ENOTSUPP) can't:

 prog 'basic_alloc3': BPF program load failed: Operation not supported
 prog 'basic_alloc3': failed to load: -95
 failed to load object 'verifier_arena'
 FAIL:unexpected_load_failure unexpected error: -95 (errno 95)

 prog 'inner_map': BPF program load failed: unknown error (-524)
 prog 'inner_map': failed to load: -524
 failed to load object 'bloom_filter_map'
 failed to load BPF skeleton 'bloom_filter_map': -524
 FAIL:bloom_filter_map__open_and_load unexpected error: -524

This patch fixes this by handling ENOTSUPP in libbpf_strerror_r(). With
this change, the new error string looks like:

 prog 'inner_map': BPF program load failed: Operation not supported

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/lib/bpf/str_error.c | 18 +++++++++++++-----
 tools/lib/bpf/str_error.h |  4 ++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/str_error.c b/tools/lib/bpf/str_error.c
index 5e6a1e27ddf9..5eef2bc7fac5 100644
--- a/tools/lib/bpf/str_error.c
+++ b/tools/lib/bpf/str_error.c
@@ -15,7 +15,8 @@
  */
 char *libbpf_strerror_r(int err, char *dst, int len)
 {
-	int ret = strerror_r(err < 0 ? -err : err, dst, len);
+	unsigned int no = err < 0 ? -err : err;
+	int ret = strerror_r(no, dst, len);
 	/* on glibc <2.13, ret == -1 and errno is set, if strerror_r() can't
 	 * handle the error, on glibc >=2.13 *positive* (errno-like) error
 	 * code is returned directly
@@ -23,11 +24,18 @@ char *libbpf_strerror_r(int err, char *dst, int len)
 	if (ret == -1)
 		ret = errno;
 	if (ret) {
-		if (ret == EINVAL)
-			/* strerror_r() doesn't recognize this specific error */
-			snprintf(dst, len, "unknown error (%d)", err < 0 ? err : -err);
-		else
+		if (ret == EINVAL) {
+			switch (no) {
+			case ENOTSUPP:
+				snprintf(dst, len, "Operation not supported");
+				break;
+			default:
+				/* strerror_r() doesn't recognize this specific error */
+				snprintf(dst, len, "unknown error (-%u)", no);
+			}
+		} else {
 			snprintf(dst, len, "ERROR: strerror_r(%d)=%d", err, ret);
+		}
 	}
 	return dst;
 }
diff --git a/tools/lib/bpf/str_error.h b/tools/lib/bpf/str_error.h
index 626d7ffb03d6..c41f6ba133cf 100644
--- a/tools/lib/bpf/str_error.h
+++ b/tools/lib/bpf/str_error.h
@@ -4,6 +4,10 @@
 
 #define STRERR_BUFSIZE  128
 
+#ifndef ENOTSUPP
+#define ENOTSUPP 524
+#endif
+
 char *libbpf_strerror_r(int err, char *dst, int len);
 
 #endif /* __LIBBPF_STR_ERROR_H */
-- 
2.43.0


