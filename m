Return-Path: <linux-kselftest+bounces-6890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E1B892420
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8F1285840
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 19:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5D113B5B9;
	Fri, 29 Mar 2024 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DbaUhS4E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4690F13B59D
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740009; cv=none; b=GMPe7UkrZgA9UwStsPDZqbE4SCjc27JEkGYbmaIl+bJtad7GAI4eqm6r1yK5xamHdcgNn9hqiMsZaJ9Rq8UySZ2y4MnP3ZhlT2wMBhsc4Na6cghl9MzscufTQc/KujOJjK7EFNkldbJFWomBbj+4ppqaaDU3Bh42AEI92xw3XMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740009; c=relaxed/simple;
	bh=VbGG+XbpZK7oUBxGNtmxZbTCfs8JzgG6wNjJv0uXmO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oXpzWSD0x7avbsS1tqEexCQD5za7/uavxQM5v3HtWhGitJCoNBdmqS9U0cjbPAEdIB2FKSquQVrxSOmPPg2csFuYsG6J1ysupXDXzRaOIR0U97usZ90iWMpAT37t+hE+huVXkQp2wjHhYnMQixOCIae/Ch7xDyfMaVY12l6r9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DbaUhS4E; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0b18e52dso27493287b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 12:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711740007; x=1712344807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+6H8V8tRjJIRYzVICNw6xqfrh4PmImpo3mdIUVEfq4=;
        b=DbaUhS4EE5ixNMLrH50oWLQPzywAOF2/kCRuJGFV9n9ZJFcHnMV3RtGNnsG1+Sz2bZ
         EWy6vA+Jms/7I2drS36pY/DqR2gRxeECecf9NbJp6sSkxIs6+4NfUsUhnBt68oC8QgxE
         v1ankrbsNa9qdDw0RBNWvSUGiHJdxwWXy3FD5DeFDDs6C4f8SKUxFexV0X6Qv2lStDW3
         OntZlLvIs1kT0uRs4Wk5csfmdReI++dohLNIypnMrDNCdRWiHNGy2hC0Zh9JU1C4WU5z
         strvYzx0Yaqf3DR9JUawLdGBJmf3et/NnAendnLT3y9PIoPYE/7qLVeP9LNoFD1HGbyw
         KPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711740007; x=1712344807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+6H8V8tRjJIRYzVICNw6xqfrh4PmImpo3mdIUVEfq4=;
        b=fRwdVOYNJUMaVFrRNZMtHjbAsrTZjNNiW9ky3blQAWvG3W/XOLS7A8Pt8oNHXPb76b
         5nQb5pOggFjnbPfhzxw3EC4FXu6OpWKLcFJWl35OWUuAD6GSBXPivRyBwRIBZYW5MW7s
         QSQUEt2s54xcQv0Zw5YieCVJhR6NB9d1yNhJBXO+mWcT+GEcTW0Ilb5aOFiDkpjG4NlF
         qVyilpUy1TfbQc6WZM6HIM+cg4ag1tYVs3dsuDtEHAPNzeVsByoNDK9u9pvRG2eQKwYw
         NiYR0/eo2jG7G0QleAyl8qbZTi6pXKuqLVqC20oO5XvVcpnikCdAOaj88wlcd1i8PgTk
         acfA==
X-Forwarded-Encrypted: i=1; AJvYcCXihY6xfDfFc/wdBiq4QWCEFN38XvNE5SNTPTvXz4JdYXJFS4rOulcl6kIup09W7hluKOTHCl6oF3yEoSuB3fHvaUJR0vIXLeIo2rPHuNF6
X-Gm-Message-State: AOJu0Yyckvm4IEyfRDvlEleMcnA3K1xnyphcV5dWLoYLhr5GA1K/teAt
	JD+9twl2DKgcGGbc1fK2GB2nr9ajUrdyUk8scFW2VfcpfaYTWHU4mQ2oQ0T6zmfeiI8Dgwc5/w=
	=
X-Google-Smtp-Source: AGHT+IHwcUgirIdazUL6RxU7j2gI/AR6RRo+4nJUn64Ts9RX9y8sDHkirAedhp2lZjPuqpBRH6ZjDSYGog==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a0d:ccd3:0:b0:614:6883:43bd with SMTP id
 o202-20020a0dccd3000000b00614688343bdmr149348ywd.1.1711740007486; Fri, 29 Mar
 2024 12:20:07 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:18:53 -0500
In-Reply-To: <20240329191907.1808635-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329191907.1808635-9-jrife@google.com>
Subject: [PATCH v1 bpf-next 8/8] selftests/bpf: Fix bind program for big
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
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>
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


