Return-Path: <linux-kselftest+bounces-24825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02D4A176F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 06:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF027A2991
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 05:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6669199223;
	Tue, 21 Jan 2025 05:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ADQEK8uJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ACE1A83F4;
	Tue, 21 Jan 2025 05:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737437097; cv=none; b=Hb1hRuMC+u6XIRyaPMFRPdQKwaTmb/kcJ+3qNT7GS6A4YiU0JrJuRDjzORmgdFSN3yqQD/vpVdmWqlGcVSrl09ZDckASqbuvmiSbOnibzEegITmdjbQMRo1b7HAkE1nQuvzITYPgPDHVvSIK8tMhHw6EOa7uejzY6hQ7OnLOoEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737437097; c=relaxed/simple;
	bh=q076FPLcnVELFIvGJ7vQmIAhrhGv9ZUwuu3/eGXujeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ximhs53ZB4HYw1JRgtb/NPTiQwAmGZZ3uLVai6YeBZ3umhRuvgszpcw1G9xBvLCk88v95XUqe6hqKuEQxqDx9X9cO9Y7E9gGdkD/DQc7jpQ+VGRc3k5qWcCl7NCk7hd6LThpq3Cm7ahgcP7jGxk9H+sxb/M1RLZLkrozpUVnqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ADQEK8uJ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=2MNTx
	I21IGNG+45HZA+umvOyB944fvSncQ36kJVgirg=; b=ADQEK8uJlnnMR/kIvl0OH
	DsIeHYomgQmF9cA4amOhGwKvjTejvsBUvVo5NlZJGR6bFHbXVaY+larlxNYus8bo
	EUi+AAd6GzuBT1YDeIXdAqCfmdYeARwB+mBr/T/7o0+40KS8y+bq/yn6A+kYMKpf
	GULyi+6FUsXtFJAFtsOPCA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHwYeaK49nTErMHA--.41409S5;
	Tue, 21 Jan 2025 13:08:24 +0800 (CST)
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
Subject: [PATCH bpf v8 3/5] bpf: disable non stream socket for strparser
Date: Tue, 21 Jan 2025 13:07:05 +0800
Message-ID: <20250121050707.55523-4-mrpre@163.com>
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
X-CM-TRANSID:_____wBHwYeaK49nTErMHA--.41409S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF18CF1DArW3Kw17uw4rZrb_yoW8JFyfp3
	s5uw4xuFZrXr4Iv398Xan0gr109wn5KayUGF1fCa4ayw4qgr15WrWrGFyavF1jkr43WFy5
	Zr4UG345Cw47XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRMrWrUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDw3bp2ePKApFRQABs1

Currently, only TCP supports strparser, but sockmap doesn't intercept
non-TCP to attach strparser. For example, with UDP, although the
read/write handlers are replaced, strparser is not executed due to the
lack of read_sock operation.

Furthermore, in udp_bpf_recvmsg(), it checks whether psock has data, and
if not, it falls back to the native UDP read interface, making
UDP + strparser appear to read correctly. According to it's commit
history, the behavior is unexpected.

Moreover, since UDP lacks the concept of streams, we intercept it
directly.

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


