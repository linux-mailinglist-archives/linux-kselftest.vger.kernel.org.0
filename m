Return-Path: <linux-kselftest+bounces-29396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F20BA68139
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 01:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE86421D99
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 00:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAC019B5B8;
	Wed, 19 Mar 2025 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gIVpTV15"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE2C15A85E
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343346; cv=none; b=YO1KvzrGmYkBmTe/KZR+B7FvsUOnFw2jgSF/76y0Tyvz2STOxQuJvcqBeVz25j4n7TfUEvGcXwIeEVFMhUd//IouGQtkfdDU1Wggf98Cr7wA879UN6GA0FqZy/fxWEsDBXMZfasl/nUurGlrGyP3Tatc5QcB2qPHEUNsIKNWhmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343346; c=relaxed/simple;
	bh=SowAWf3suxdJmhbIj/+rpT/CNsAYNCCACOuR5s/3LGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbNxVzGLfrmTXGkf2R7OcIeT2k/gZ61iYIXuRclafKxKZO26g2hT/By0LaN8g4ZuXzAJn2w4beXi5zBuCNiVxzBoqOx/McGzYZuG6KliLqBuJ/0t9CtxYlYpDxxFlouSiiTTdiC+5TZzbPbUOcCh9IQNM8Na9LlQn9rJZ7vBaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gIVpTV15; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22548a28d0cso18569495ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343343; x=1742948143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BqxlSUPLPLK+n0IEZ/na32d+xFXeCa925E/NE7WMKY=;
        b=gIVpTV15hhkkYilj5BypVWGWlzUL3CqQ72S1nz2FWsVuUY16SNpf5KQkU11mnaTAKn
         1WaoeJcNBjDgCS32IwIWKfkUfCs3oFZs0wmmQtBRsXJzqoJr4KgKFKcmXmUWyDSv1UL4
         BoqqJF1llr2ptP6/5CELh0Zkw4SLxiefAIwMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343343; x=1742948143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BqxlSUPLPLK+n0IEZ/na32d+xFXeCa925E/NE7WMKY=;
        b=oyS+e1r1vjVzIC4pHOfF2lZGp8Xhg2W2xGSCwH6E3fsmfjlgNZ4DDiCAb19fsgc8mO
         0ZHrFkgf95H2PM/9/yrddeKTdrpjBR/3EFhdV53CehgYRhmHF7Gz6KcEbQ5bmmYGhgzk
         +Mg0eMUXvdtJwnnW/za2MZngB073+uGxVdL5SdduiRu0UzdHM//TZrChNrYD9acScd8b
         j0buqa+2jkjvJ8SRlp2CgXYET6SgoGRJzMCD87tvtgtW5kM+3f4ARKq5VN6yzFvEvap0
         CBjnXpakAYfafdkTiCNW+7WEmNFfveweirvfeiwj5UweL4hXp+8Oc5wg0BOAvx/W8NqG
         Xpzg==
X-Forwarded-Encrypted: i=1; AJvYcCW7P+dbnvytYKEcXztpMO1tRL9BQYtKaOJWI5CE6+8ZU25oRo3x3WBHLScjqkSzVaUF/U5PWSp0nrZgOO7PaEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7nfO9qn77aSbFd7C+cQzzFvUtNGkNsrRI3NEv2LccPcNjWTM
	qO3IGcu8qA91oGfC+zlO7fqHW9fwGxajNBmjXCtSelGwkd3ADC85+VKyuKy4n64=
X-Gm-Gg: ASbGncu4kMiuDmM8E8frhtqYbCZrCQM6c/nuLwmyGoaawR3jiwMTi0DGvjbo2tIIuMR
	hAlVK0ZZJRZohidsy5+A8VfJGYHng+xJtu40fw9ZBdWqr4DO2YEdOM6zS5AiN9xpmqaiuD0AcMl
	7+aWW5kgCKGUC5Czmt0GoqocKioY0+ZTonOolBLP2094hKkeNNc2iiACG3ZbX6sic2cyttk+tIJ
	YIMLvVt0SpsM9BcfmokQx5iD1XOpoAN1tFl3WmQtnvxAe2f5qERT1o6azEtu+EpZ5SZ5YjgYbz3
	y0s5Z7DwTCA8CUUw4wBoJkuNG1o3kO53TI/smnGpFfiDyfu/8GQb
X-Google-Smtp-Source: AGHT+IFxyw3nvWmVaD9tl0lJBbbnI8q3NC7K/P2umCsKr9U07OgWwl21w/NuymcNKusQI296uT0O6g==
X-Received: by 2002:a17:903:1cb:b0:224:76f:9e45 with SMTP id d9443c01a7336-22649a3476fmr9616615ad.21.1742343343024;
        Tue, 18 Mar 2025 17:15:43 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:42 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 04/10] splice: Add SPLICE_F_ZC and attach ubuf
Date: Wed, 19 Mar 2025 00:15:15 +0000
Message-ID: <20250319001521.53249-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the SPLICE_F_ZC flag and when it is set, allocate a ubuf and attach
it to generate zerocopy notifications.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/splice.c            | 20 ++++++++++++++++++++
 include/linux/splice.h |  3 ++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 1f27ce6d1c34..6dc60f47f84e 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -875,6 +875,11 @@ static ssize_t splice_socket_generic(struct pipe_inode_info *pipe,
 		if (out->f_flags & O_NONBLOCK)
 			msg.msg_flags |= MSG_DONTWAIT;
 
+		if (unlikely(flags & SPLICE_F_ZC) && ubuf_info) {
+			msg.msg_flags = MSG_ZEROCOPY;
+			msg.msg_ubuf = ubuf_info;
+		}
+
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, bc,
 			      len - remain);
 		ret = sock_sendmsg(sock, &msg);
@@ -1223,12 +1228,27 @@ static ssize_t do_splice_direct_actor(struct file *in, loff_t *ppos,
 	if (unlikely(out->f_flags & O_APPEND))
 		return -EINVAL;
 
+	if (unlikely(flags & SPLICE_F_ZC)) {
+		struct socket *sock = sock_from_file(out);
+		struct sock *sk = sock->sk;
+		struct ubuf_info *ubuf_info;
+
+		ubuf_info = msg_zerocopy_realloc(sk, len, NULL);
+		if (!ubuf_info)
+			return -ENOMEM;
+		sd.ubuf_info = ubuf_info;
+	}
+
 	ret = splice_direct_to_actor(in, &sd, actor);
 	if (ret > 0)
 		*ppos = sd.pos;
 
+	if (unlikely(flags & SPLICE_F_ZC))
+		refcount_dec(&sd.ubuf_info->refcnt);
+
 	return ret;
 }
+
 /**
  * do_splice_direct - splices data directly between two files
  * @in:		file to splice from
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 7477df3916e2..a88588cf2754 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -21,8 +21,9 @@
 				 /* from/to, of course */
 #define SPLICE_F_MORE	(0x04)	/* expect more data */
 #define SPLICE_F_GIFT	(0x08)	/* pages passed in are a gift */
+#define SPLICE_F_ZC	(0x10)  /* generate zero copy notifications */
 
-#define SPLICE_F_ALL (SPLICE_F_MOVE|SPLICE_F_NONBLOCK|SPLICE_F_MORE|SPLICE_F_GIFT)
+#define SPLICE_F_ALL (SPLICE_F_MOVE|SPLICE_F_NONBLOCK|SPLICE_F_MORE|SPLICE_F_GIFT|SPLICE_F_ZC)
 
 /*
  * Passed to the actors
-- 
2.43.0


