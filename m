Return-Path: <linux-kselftest+bounces-7823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9518A3417
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 18:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829FD1C22CB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0122214C5BD;
	Fri, 12 Apr 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+D0dGhE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138014AD17
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940770; cv=none; b=kj6PqySUC/dMV0GcjhPzIIP/P7jalGJf4qxEdgkXQq3IONGnGDxJUXKyBBYVSS0v66HH3PoxYC/HUqhRMep93p2/HP6S+MCL6H7NbVoVKD7wveboDiYtHXJccWK39+roB8ZIoc+LsEI6xpPhVFUb0HAGuSt5A8iB327sy5l7l4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940770; c=relaxed/simple;
	bh=VbGG+XbpZK7oUBxGNtmxZbTCfs8JzgG6wNjJv0uXmO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OcZVkxSUZCKq7Y2kfuWvLSxXYk2f541IJByto4Ub2QjckR8AUF3xCnYtrwPP6pGuPZkdsjX35/o3QArlIV8T2SmLhySfw/9upEpMk2mW56D/WDlbZEw0QcKNelZ2iBpB7cK2VtGl3aL6SeAt+1v4G+8yrgy0EzFjPUbGnF6oKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+D0dGhE; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7cc7a6a043bso141230039f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 09:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712940766; x=1713545566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+6H8V8tRjJIRYzVICNw6xqfrh4PmImpo3mdIUVEfq4=;
        b=A+D0dGhEW6UDEpTa9HE0dPnZpdZk/Rc3owFAzEt5qSoq2OMjh+JwUUYbRbNhi7QUEM
         D7pUJdI8mTmjwGs5/SBSpNfQHIa9pCcOyQ5ctQZGklVqND5ylHDKpAeBgN1HIapT6DBi
         W/eyAGe86Xj49Tw6nZOhBgzR/jZB6kXF6Q5QxkD7UjN3xrVckWowEboDmC6uQWZQe7ji
         4wKYuDr5iAgzv6j7pbzERX/k2V5M7jZxUkmF089R0u02WALhnNNpquFxCfBA7aILDHeZ
         DGZ8x1QunqoalJ/h9JH5ZztkBxH6DhpKGWTknUisWE8vk1s3bj6up8yJkPeXGshIInOz
         oqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712940766; x=1713545566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+6H8V8tRjJIRYzVICNw6xqfrh4PmImpo3mdIUVEfq4=;
        b=PddOGyMbd/jjqmFIRWXFoya0jGZ6uC0JKCmCI4gYB/L1A0ntrr+dQReHs0NZZbJMMJ
         90oBAPH/bbP7/gVn6K45VBOpkBfOq1ZRS19XO2zFtNDZyijuhslLHbTp+Yr9FhEHnUhb
         0BCMNPFTDv5NvJmzZztObWVC9nHwnC8U41YwIPXrwhbXVwalAk56Pj/npHQhkYmlkneC
         qNvzHhv5xH9WDfNKqIyyNPxM0kcagZFARTr328OvaByKp5Q4kU78AIXIduDXEiYi2pnT
         6/Krii5y93cK2i8DsatAf2tAsoTS/ywsX6MSX3x2JzKqKkp/5TIdYMpjg/KEfteqWaNF
         /Phw==
X-Forwarded-Encrypted: i=1; AJvYcCXvVovnM4N7h/T7jwolqg5QaHjLTmsWkhHPke3uYNCQ1sq6rZew6S7Zxeg/GTLic2XLnJevZOjLuOoXo2QDJgzUzf1YAsI+Kn3gsp2WXd9v
X-Gm-Message-State: AOJu0YxbPViCKgLjSuVQA/UIo/5nUDc+WV+UlKnzF48G3BgVM3xhLBnb
	R98dP691LjFGWiKnz/WqZ8tVE3Ru+MwPdBkXbyW5Pte4xRRq/GTm3BqQdsf4kmAF0XSCimGpMg=
	=
X-Google-Smtp-Source: AGHT+IHboun2uk8X3J2EuaMqK4bjKZyknqSyRNh3Tv1P9NbCchTFkdwNskFVum0UpOckNMtEhiqHrIclbQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6638:2110:b0:482:cfdd:daeb with SMTP id
 n16-20020a056638211000b00482cfdddaebmr107769jaj.5.1712940766777; Fri, 12 Apr
 2024 09:52:46 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:52:22 -0500
In-Reply-To: <20240412165230.2009746-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240412165230.2009746-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240412165230.2009746-2-jrife@google.com>
Subject: [PATCH v2 bpf-next 1/6] selftests/bpf: Fix bind program for big
 endian systems
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Without this fix, the bind4 and bind6 programs will reject bind attempts
on big endian systems. This patch ensures that CI tests pass for the
s390x architecture.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../testing/selftests/bpf/progs/bind4_prog.c  | 18 ++++++++++--------
 .../testing/selftests/bpf/progs/bind6_prog.c  | 18 ++++++++++--------
 tools/testing/selftests/bpf/progs/bind_prog.h | 19 +++++++++++++++++++
 3 files changed, 39 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bind_prog.h

diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
index a487f60b73ac4..2bc052ecb6eef 100644
--- a/tools/testing/selftests/bpf/progs/bind4_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
@@ -12,6 +12,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include "bind_prog.h"
+
 #define SERV4_IP		0xc0a801feU /* 192.168.1.254 */
 #define SERV4_PORT		4040
 #define SERV4_REWRITE_IP	0x7f000001U /* 127.0.0.1 */
@@ -118,23 +120,23 @@ int bind_v4_prog(struct bpf_sock_addr *ctx)
 
 	// u8 narrow loads:
 	user_ip4 = 0;
-	user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[0] << 0;
-	user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[1] << 8;
-	user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[2] << 16;
-	user_ip4 |= ((volatile __u8 *)&ctx->user_ip4)[3] << 24;
+	user_ip4 |= load_byte_ntoh(ctx->user_ip4, 0, sizeof(user_ip4));
+	user_ip4 |= load_byte_ntoh(ctx->user_ip4, 1, sizeof(user_ip4));
+	user_ip4 |= load_byte_ntoh(ctx->user_ip4, 2, sizeof(user_ip4));
+	user_ip4 |= load_byte_ntoh(ctx->user_ip4, 3, sizeof(user_ip4));
 	if (ctx->user_ip4 != user_ip4)
 		return 0;
 
 	user_port = 0;
-	user_port |= ((volatile __u8 *)&ctx->user_port)[0] << 0;
-	user_port |= ((volatile __u8 *)&ctx->user_port)[1] << 8;
+	user_port |= load_byte_ntoh(ctx->user_port, 0, sizeof(user_port));
+	user_port |= load_byte_ntoh(ctx->user_port, 1, sizeof(user_port));
 	if (ctx->user_port != user_port)
 		return 0;
 
 	// u16 narrow loads:
 	user_ip4 = 0;
-	user_ip4 |= ((volatile __u16 *)&ctx->user_ip4)[0] << 0;
-	user_ip4 |= ((volatile __u16 *)&ctx->user_ip4)[1] << 16;
+	user_ip4 |= load_word_ntoh(ctx->user_ip4, 0, sizeof(user_ip4));
+	user_ip4 |= load_word_ntoh(ctx->user_ip4, 1, sizeof(user_ip4));
 	if (ctx->user_ip4 != user_ip4)
 		return 0;
 
diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
index d62cd9e9cf0ea..194583e3375bf 100644
--- a/tools/testing/selftests/bpf/progs/bind6_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
@@ -12,6 +12,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#include "bind_prog.h"
+
 #define SERV6_IP_0		0xfaceb00c /* face:b00c:1234:5678::abcd */
 #define SERV6_IP_1		0x12345678
 #define SERV6_IP_2		0x00000000
@@ -129,25 +131,25 @@ int bind_v6_prog(struct bpf_sock_addr *ctx)
 	// u8 narrow loads:
 	for (i = 0; i < 4; i++) {
 		user_ip6 = 0;
-		user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[0] << 0;
-		user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[1] << 8;
-		user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[2] << 16;
-		user_ip6 |= ((volatile __u8 *)&ctx->user_ip6[i])[3] << 24;
+		user_ip6 |= load_byte_ntoh(ctx->user_ip6[i], 0, sizeof(user_ip6));
+		user_ip6 |= load_byte_ntoh(ctx->user_ip6[i], 1, sizeof(user_ip6));
+		user_ip6 |= load_byte_ntoh(ctx->user_ip6[i], 2, sizeof(user_ip6));
+		user_ip6 |= load_byte_ntoh(ctx->user_ip6[i], 3, sizeof(user_ip6));
 		if (ctx->user_ip6[i] != user_ip6)
 			return 0;
 	}
 
 	user_port = 0;
-	user_port |= ((volatile __u8 *)&ctx->user_port)[0] << 0;
-	user_port |= ((volatile __u8 *)&ctx->user_port)[1] << 8;
+	user_port |= load_byte_ntoh(ctx->user_port, 0, sizeof(user_port));
+	user_port |= load_byte_ntoh(ctx->user_port, 1, sizeof(user_port));
 	if (ctx->user_port != user_port)
 		return 0;
 
 	// u16 narrow loads:
 	for (i = 0; i < 4; i++) {
 		user_ip6 = 0;
-		user_ip6 |= ((volatile __u16 *)&ctx->user_ip6[i])[0] << 0;
-		user_ip6 |= ((volatile __u16 *)&ctx->user_ip6[i])[1] << 16;
+		user_ip6 |= load_word_ntoh(ctx->user_ip6[i], 0, sizeof(user_ip6));
+		user_ip6 |= load_word_ntoh(ctx->user_ip6[i], 1, sizeof(user_ip6));
 		if (ctx->user_ip6[i] != user_ip6)
 			return 0;
 	}
diff --git a/tools/testing/selftests/bpf/progs/bind_prog.h b/tools/testing/selftests/bpf/progs/bind_prog.h
new file mode 100644
index 0000000000000..0fdc466aec346
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bind_prog.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BIND_PROG_H__
+#define __BIND_PROG_H__
+
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define load_byte_ntoh(src, b, s) \
+	(((volatile __u8 *)&(src))[b] << 8 * b)
+#define load_word_ntoh(src, w, s) \
+	(((volatile __u16 *)&(src))[w] << 16 * w)
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+#define load_byte_ntoh(src, b, s) \
+	(((volatile __u8 *)&(src))[(b) + (sizeof(src) - (s))] << 8 * ((s) - (b) - 1))
+#define load_word_ntoh(src, w, s) \
+	(((volatile __u16 *)&(src))[w] << 16 * (((s) / 2) - (w) - 1))
+#else
+# error "Fix your compiler's __BYTE_ORDER__?!"
+#endif
+
+#endif
-- 
2.44.0.478.gd926399ef9-goog


