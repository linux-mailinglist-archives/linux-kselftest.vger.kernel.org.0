Return-Path: <linux-kselftest+bounces-24820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A99A176CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 06:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CC307A22F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 05:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDCF198E6D;
	Tue, 21 Jan 2025 05:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CYqtfD4r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E99A55;
	Tue, 21 Jan 2025 05:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737436171; cv=none; b=K+1t1YfM1FIquD8zWTTapt+A6b1xfeixXLj0l4AOXDYghGN99JDHQk0fITy0y8A/W59NdA2IU+nCwaOlBN8JB/3O3M1x/jkIhbx2uJBVqcDKbLuyqG2zwpBfwqjTJr/TXkHEZ4yLDTZTM0RoU4QEYsergQ4uZquUJ5F5s/WJG24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737436171; c=relaxed/simple;
	bh=z6Urh4wc14X05JB3h9mGWagV2qSr0pIR99APQ4T4mVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSkskOtmP7m9/uaR9UIeyqOe+PBNoUxKRCeH3UwgbJlmW6Juliw9HiHrBW7ZcaEYirRhppZWyntzmgKnzZQiK63ZSDdie+BFOFERKBg0adDAf7bCs9b8nNQ/1AtYiRvxAy8NT5euygChXZgdtd4OMTHiibaZIJIYgKhmdIMwVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CYqtfD4r; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=QyFc5
	uhHFtEAQ0FPGz0v1oE7DiUl7c1R1dxohQo/yV4=; b=CYqtfD4rONGkot+oPwaQf
	8xkaYDZIoUE2rO2q0Ljg9xJqWcymnK8L+aERp4p/bMLEuNNQDy7q6uQtmA4+FP8h
	K5HS9T1sQYqisyvbKoeIlvAQ6+L4gYT/AOTPzJrFUI+p89E7dFCf6Sk9z9vSOeBs
	4LN0KvdM2mPDF/q+kT7bic=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHwYeaK49nTErMHA--.41409S3;
	Tue, 21 Jan 2025 13:08:02 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com
Cc: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	song@kernel.org,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	horms@kernel.org,
	corbet@lwn.net,
	eddyz87@gmail.com,
	cong.wang@bytedance.com,
	shuah@kernel.org,
	mykolal@fb.com,
	jolsa@kernel.org,
	haoluo@google.com,
	sdf@fomichev.me,
	kpsingh@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v8 1/5] strparser: add read_sock callback
Date: Tue, 21 Jan 2025 13:07:03 +0800
Message-ID: <20250121050707.55523-2-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250121050707.55523-1-mrpre@163.com>
References: <20250121050707.55523-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHwYeaK49nTErMHA--.41409S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFW7Jr17KF4fXw15uw4DJwb_yoW5Zw18pF
	nxCayxWr47tFy8uan3Jr97KrWqgr1rKayUCFyFq34SyF4kGryYqFyFkr4jyF1UGr4rZFWU
	KrsxWr4avr1DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piAnY7UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDwnbp2ePKc4lUQAAsB

Added a new read_sock handler, allowing users to customize read operations
instead of relying on the native socket's read_sock.

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 Documentation/networking/strparser.rst |  9 ++++++++-
 include/net/strparser.h                |  2 ++
 net/strparser/strparser.c              | 11 +++++++++--
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/strparser.rst b/Documentation/networking/strparser.rst
index 6cab1f74ae05..7f623d1db72a 100644
--- a/Documentation/networking/strparser.rst
+++ b/Documentation/networking/strparser.rst
@@ -112,7 +112,7 @@ Functions
 Callbacks
 =========
 
-There are six callbacks:
+There are seven callbacks:
 
     ::
 
@@ -182,6 +182,13 @@ There are six callbacks:
     the length of the message. skb->len - offset may be greater
     then full_len since strparser does not trim the skb.
 
+    ::
+
+	int (*read_sock)(struct strparser *strp, read_descriptor_t *desc,
+                     sk_read_actor_t recv_actor);
+
+    The read_sock callback is used by strparser instead of
+    sock->ops->read_sock, if provided.
     ::
 
 	int (*read_sock_done)(struct strparser *strp, int err);
diff --git a/include/net/strparser.h b/include/net/strparser.h
index 41e2ce9e9e10..0a83010b3a64 100644
--- a/include/net/strparser.h
+++ b/include/net/strparser.h
@@ -43,6 +43,8 @@ struct strparser;
 struct strp_callbacks {
 	int (*parse_msg)(struct strparser *strp, struct sk_buff *skb);
 	void (*rcv_msg)(struct strparser *strp, struct sk_buff *skb);
+	int (*read_sock)(struct strparser *strp, read_descriptor_t *desc,
+			 sk_read_actor_t recv_actor);
 	int (*read_sock_done)(struct strparser *strp, int err);
 	void (*abort_parser)(struct strparser *strp, int err);
 	void (*lock)(struct strparser *strp);
diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 8299ceb3e373..95696f42647e 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -347,7 +347,10 @@ static int strp_read_sock(struct strparser *strp)
 	struct socket *sock = strp->sk->sk_socket;
 	read_descriptor_t desc;
 
-	if (unlikely(!sock || !sock->ops || !sock->ops->read_sock))
+	if (unlikely(!sock || !sock->ops))
+		return -EBUSY;
+
+	if (unlikely(!strp->cb.read_sock && !sock->ops->read_sock))
 		return -EBUSY;
 
 	desc.arg.data = strp;
@@ -355,7 +358,10 @@ static int strp_read_sock(struct strparser *strp)
 	desc.count = 1; /* give more than one skb per call */
 
 	/* sk should be locked here, so okay to do read_sock */
-	sock->ops->read_sock(strp->sk, &desc, strp_recv);
+	if (strp->cb.read_sock)
+		strp->cb.read_sock(strp, &desc, strp_recv);
+	else
+		sock->ops->read_sock(strp->sk, &desc, strp_recv);
 
 	desc.error = strp->cb.read_sock_done(strp, desc.error);
 
@@ -468,6 +474,7 @@ int strp_init(struct strparser *strp, struct sock *sk,
 	strp->cb.unlock = cb->unlock ? : strp_sock_unlock;
 	strp->cb.rcv_msg = cb->rcv_msg;
 	strp->cb.parse_msg = cb->parse_msg;
+	strp->cb.read_sock = cb->read_sock;
 	strp->cb.read_sock_done = cb->read_sock_done ? : default_read_sock_done;
 	strp->cb.abort_parser = cb->abort_parser ? : strp_abort_strp;
 
-- 
2.43.5


