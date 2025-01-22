Return-Path: <linux-kselftest+bounces-24925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86645A18F6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 11:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32603AD4F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 10:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD92211487;
	Wed, 22 Jan 2025 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mV+iDM39"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118A4211485;
	Wed, 22 Jan 2025 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540721; cv=none; b=YW5QAvFpsAWDxozDlV98FZvOlKpTR0lazKwXLJkadCZo3ahDtfuLz+0WLgSMoaA13Vt/yD5Zas/B4IT61/9F82QbnHzmGMzTNoJGisM5sV5c3gL4Sz6aH8Pqjd2vq+PnBbkw2FForenfZV+As7jYnWUW9UvAFIqqKQAmEAE28+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540721; c=relaxed/simple;
	bh=jfXVYK+UAqpHEjv7ruQ3nka7FuPFIWAgFNZUVpqkYeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNSEjl6mRilglowU4ZoBF32V7Gp5cwgP1yHXHEYBIE9eh2IZC6v3eLUsuHmUr5BacSMTXcCK1laZIAXFP97SjM8mCYgArO5TJ+wiRK+BF5xM13q+v/Q+bgsO5+1bHS3e5MOv/998KADsvafdDXjf88b1LkAaCaeHZOI6NmP2ttM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mV+iDM39; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=vnF9u
	T3DNxXXPl9Rv2dEcTgAAxytuWr3s5/0Tw/OsqU=; b=mV+iDM39rD+Bes2MqcjXo
	dUyebzCW9Fr82fbI12vQfMxAKdRFOylHf8NvoeB2zfBwwa/90dwNuOOhzw8P8wVD
	yp4obidYEaAuqxci5uJ5SeBMybqV8ineyyADg52p2AAJfs75++4TlmIyVeuLV7GA
	bKl9PwyvPvttau4iPp+tPQ=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAHUcjUw5Bn_UIhKA--.64788S5;
	Wed, 22 Jan 2025 18:10:10 +0800 (CST)
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
Subject: [PATCH bpf v9 3/5] bpf: disable non stream socket for strparser
Date: Wed, 22 Jan 2025 18:09:15 +0800
Message-ID: <20250122100917.49845-4-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250122100917.49845-1-mrpre@163.com>
References: <20250122100917.49845-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAHUcjUw5Bn_UIhKA--.64788S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF18CF17ury7GFW3XFy3XFb_yoW8GFyUp3
	95Cw4xCFZFvryIvwn0qan0gr18Kwn5Kw4UGF1fCa4ayws0gr15GrWrGFy3ZF1jkrsIgFyY
	vr4UG345Gw43uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRMrWrUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWxLcp2eQup+yegACsq

Currently, only TCP supports strparser, but sockmap doesn't intercept
non-TCP connections to attach strparser. For example, with UDP, although
the read/write handlers are replaced, strparser is not executed due to
the lack of a read_sock operation.

Furthermore, in udp_bpf_recvmsg(), it checks whether the psock has data,
and if not, it falls back to the native UDP read interface, making
UDP + strparser appear to read correctly. According to its commit history,
this behavior is unexpected.

Moreover, since UDP lacks the concept of streams, we intercept it directly.

Fixes: 1fa1fe8ff161 ("bpf, sockmap: Test shutdown() correctly exits epoll and recv()=0")
Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 net/core/sock_map.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index f1b9b3958792..3b0f59d9b4db 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -303,7 +303,10 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 
 	write_lock_bh(&sk->sk_callback_lock);
 	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
-		ret = sk_psock_init_strp(sk, psock);
+		if (sk_is_tcp(sk))
+			ret = sk_psock_init_strp(sk, psock);
+		else
+			ret = -EOPNOTSUPP;
 		if (ret) {
 			write_unlock_bh(&sk->sk_callback_lock);
 			sk_psock_put(sk, psock);
-- 
2.43.5


