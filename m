Return-Path: <linux-kselftest+bounces-10031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEDE8C2A36
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43957286B1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C147945978;
	Fri, 10 May 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N67fQuwV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6321A2C3A
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367777; cv=none; b=qj+03D5qQRi5To7QFgvGyiNRXJ2ppQBnc/odWeXTRONq6BFqsLy7I1UTFjujfbnrDBAk8v8/KLSHcWOzHaO2PH318q0QQz4xgSm4tXevMd5OMBt2vrvnlsB4vLAbdCUeJxqwmYt35DWnczh1scrmBQsHOC9MsJ0FqaUJFoWTA1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367777; c=relaxed/simple;
	bh=fztEEpR7m4/NRUlZ4kYE5tFwryhBZrOJRFgR39uDdHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=srW4CArcIe2LMbJcWb0XMq4ef2qNXYhPAvW9U/KRhcEwESlWcsf2HNvPyZtlI0vFSCsNM+/Y6xKzDHbM9yfr21iJ5NKKJn1gIcF692h3kDPmxcNPFTesj1kpwAhy0yQ4ouPN5Du68r5kGhuI8IO2JyajlY3IKbuPoA/3tACRHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N67fQuwV; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-36b1d46700eso17837335ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 12:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367775; x=1715972575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kFCn2vdb1VKbwCPwkDokNVd/PgijRUXjHEsTGHgmtLI=;
        b=N67fQuwVnc4zB86XABss5lZPf+yHzN3pu/KPCORoCDXLBL4yPyKuYGb7N1DS7Icjj3
         +WcBbFMxppFmb4iFh0ufLW6p5xty1q7zFEfqnHcSD+lwKs5NZmrWlDOxRSqkLK5niQs8
         zaW50sF96C+IcXychw/BYEORN2FvEik9zysnw+dm5gd3teXoYqV53OnD/vV1hULUXzTZ
         oX6aLkVjFvuD89JIoNrDO/gr/1DUsCKXB7ycqjHljxbJFeWknNj76WpnBrlshAFUNEON
         UrzRLKJ5EY7m9DTKE7oWElytXTlZkOaE2Yh8bt+65MKXI/7XEp1lYh5a8/rXFCyzO95x
         dCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367775; x=1715972575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFCn2vdb1VKbwCPwkDokNVd/PgijRUXjHEsTGHgmtLI=;
        b=oMJYVnz/xDMPV0QTwC2qYW27cspWK0Cmb8iYp5OFBuMASVLvahhB6EU11lrOinTic+
         d8OdXuUUaGbVGAzjbduP2+7CfQeN0Rct0hg9vkSA5aT5791Lxyx1jDqUwleRMgWLAL3R
         ttiPWnlytTTLAX57MazQpviTOajD1D+V88QZyVglsnXcDlVLWnW19pZ8J7vfFQLeNUeX
         SWJ5UIvfvBoNentuuRNVfLZtQD0GC0S1nRI7v+yp7bib6FEaliFGqCQUaFQXQ4nmqpT9
         m1ABJ/2xOpQgNypag/6xByoYKTQGfZMA2D9w7iqwqCUTk3zL0fMq4U13G8MOFdqKlGxh
         XS2A==
X-Forwarded-Encrypted: i=1; AJvYcCWjwdqvnkoy6Yk89DluCzDOAKQ5NBcIJbT5+BpZng/WVdA6AEuC8KA5V6qH0NzjXvb8OW0Eo337iCtb08WiDKnR12ixooMF2rC6kLl5jtes
X-Gm-Message-State: AOJu0YzQOw9rx+jvHh1x6ia7T1MlvQswwfN47OIvIfKjAJHEr+y6zwVl
	eHDk2VpCTvhBHlp0jUvbom8oDWr44HVux0P/st16A1JifKkhtS1Rwa7lFM32Go1JI/I0vNysgA=
	=
X-Google-Smtp-Source: AGHT+IFqvlvYAgR9+7n3+qrB+K1Srlz/ymb4LAXStQHUni+k2szT1ZtVttNYjvEzFIrscNdurr7uxRV/FQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6e02:552:b0:36c:f57:acfa with SMTP id
 e9e14a558f8ab-36cc14e8c6amr390695ab.5.1715367775298; Fri, 10 May 2024
 12:02:55 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:21 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-5-jrife@google.com>
Subject: [PATCH v1 bpf-next 04/17] selftests/bpf: Handle ATTACH_REJECT test cases
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In preparation to move test cases from bpf/test_sock_addr.c that expect
ATTACH_REJECT, this patch adds BPF_SKEL_FUNCS_RAW to generate load and
destroy functions that use bpf_prog_attach() to control the attach_type.

The normal load functions use bpf_program__attach_cgroup which does not
have the same degree of control over the attach type, as
bpf_program_attach_fd() calls bpf_link_create() with the attach type
extracted from prog using bpf_program__expected_attach_type(). It is
currently not possible to modify the attach type before
bpf_program__attach_cgroup() is called, since
bpf_program__set_expected_attach_type() has no effect after the program
is loaded.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 3033641fd7567..53440458f365e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -367,6 +367,38 @@ struct sock_addr_test {
 	} expected_result;
 };
 
+#define BPF_SKEL_FUNCS_RAW(skel_name, prog_name) \
+static void *prog_name##_load_raw(int cgroup_fd, \
+				  enum bpf_attach_type attach_type, \
+				  bool expect_reject) \
+{ \
+	struct skel_name *skel = skel_name##__open(); \
+	int prog_fd = -1; \
+	if (!ASSERT_OK_PTR(skel, "skel_open")) \
+		goto cleanup; \
+	if (!ASSERT_OK(skel_name##__load(skel), "load")) \
+		goto cleanup; \
+	prog_fd = bpf_program__fd(skel->progs.prog_name); \
+	if (!ASSERT_GT(prog_fd, 0, "prog_fd")) \
+		goto cleanup; \
+	if (bpf_prog_attach(prog_fd, cgroup_fd, attach_type, \
+			      BPF_F_ALLOW_OVERRIDE), "bpf_prog_attach") { \
+		ASSERT_TRUE(expect_reject, "unexpected rejection"); \
+		goto cleanup; \
+	} \
+	if (!ASSERT_FALSE(expect_reject, "expected rejection")) \
+		goto cleanup; \
+cleanup: \
+	if (prog_fd > 0) \
+		bpf_prog_detach(cgroup_fd, attach_type); \
+	skel_name##__destroy(skel); \
+	return NULL; \
+} \
+static void prog_name##_destroy_raw(void *progfd) \
+{ \
+	/* No-op. *_load_raw does all cleanup. */ \
+} \
+
 #define BPF_SKEL_FUNCS(skel_name, prog_name) \
 static void *prog_name##_load(int cgroup_fd, \
 			      enum bpf_attach_type attach_type, \
@@ -1342,7 +1374,8 @@ void test_sock_addr(void)
 			continue;
 
 		skel = test->loadfn(cgroup_fd, test->attach_type,
-				    test->expected_result == LOAD_REJECT);
+				    test->expected_result == LOAD_REJECT ||
+					test->expected_result == ATTACH_REJECT);
 		if (!skel)
 			continue;
 
-- 
2.45.0.118.g7fe29c98d7-goog


