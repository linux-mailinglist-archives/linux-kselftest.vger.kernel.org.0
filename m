Return-Path: <linux-kselftest+bounces-26932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EB9A3B0D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 06:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDADD18892AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 05:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD061B3953;
	Wed, 19 Feb 2025 05:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ppAEBHcw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5101A3141
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 05:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739942473; cv=none; b=swyQqzdV98a+Rq2jJWxZ0AuUrwKGTeLaOD9FKHUIrCZZLFJjWmMG3G0h1QM3kwwA4sGanji/fJp6e8T9rWb0Qgii/a/Q4DiMKN/hA/XqdLbLcVUB3zLojRsE/cAMeyuzEVydT0LaprSGcRrmEZSMIocEP8MbudwAGKasfyta0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739942473; c=relaxed/simple;
	bh=PHQllqooUbMhiArXFPoJ4xf7aQfgAm477RV7+h4hC6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVc5Lz2+NkKSR3Dj6nkqxz2/y8dfIe4UFsv8CUaE2aDRVdmN/3Po6omMs7TkCOl4BoeiGPGiQLJlLATg8CTaBmQAYunGmcX5b1vyfbfBbLH33IeRzxro67E0UOuCcqXb9JmgkkTArxFX5lKMKaoxVLoR1XI/ZAqZsKYll2PpqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ppAEBHcw; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739942469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ng683JyK1h4LyOkLDNWozrztNxPIVIkoqqjCDrkgTXU=;
	b=ppAEBHcwJaxwkdYAlQZcN15UbSCuCebLNl/nOqkifuaQ+FPzp0Jd5H3+5Mos9CWY8pCqr4
	X5gZSVr1rKcMMWnlWVxWkphEQreM6Kb458+dbi9PwbAjxrxNE7+rl4cAFFumEcEhYCbQ6j
	iSVGSm2j1bZZJV1WdRAWYC0bfm60ZHM=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH bpf-next v2 1/2] bpf: fix ktls panic with sockmap
Date: Wed, 19 Feb 2025 13:20:14 +0800
Message-ID: <20250219052015.274405-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250219052015.274405-1-jiayuan.chen@linux.dev>
References: <20250219052015.274405-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

[ 2172.936997] ------------[ cut here ]------------
[ 2172.936999] kernel BUG at lib/iov_iter.c:629!
......
[ 2172.944996] PKRU: 55555554
[ 2172.945155] Call Trace:
[ 2172.945299]  <TASK>
[ 2172.945428]  ? die+0x36/0x90
[ 2172.945601]  ? do_trap+0xdd/0x100
[ 2172.945795]  ? iov_iter_revert+0x178/0x180
[ 2172.946031]  ? iov_iter_revert+0x178/0x180
[ 2172.946267]  ? do_error_trap+0x7d/0x110
[ 2172.946499]  ? iov_iter_revert+0x178/0x180
[ 2172.946736]  ? exc_invalid_op+0x50/0x70
[ 2172.946961]  ? iov_iter_revert+0x178/0x180
[ 2172.947197]  ? asm_exc_invalid_op+0x1a/0x20
[ 2172.947446]  ? iov_iter_revert+0x178/0x180
[ 2172.947683]  ? iov_iter_revert+0x5c/0x180
[ 2172.947913]  tls_sw_sendmsg_locked.isra.0+0x794/0x840
[ 2172.948206]  tls_sw_sendmsg+0x52/0x80
[ 2172.948420]  ? inet_sendmsg+0x1f/0x70
[ 2172.948634]  __sys_sendto+0x1cd/0x200
[ 2172.948848]  ? find_held_lock+0x2b/0x80
[ 2172.949072]  ? syscall_trace_enter+0x140/0x270
[ 2172.949330]  ? __lock_release.isra.0+0x5e/0x170
[ 2172.949595]  ? find_held_lock+0x2b/0x80
[ 2172.949817]  ? syscall_trace_enter+0x140/0x270
[ 2172.950211]  ? lockdep_hardirqs_on_prepare+0xda/0x190
[ 2172.950632]  ? ktime_get_coarse_real_ts64+0xc2/0xd0
[ 2172.951036]  __x64_sys_sendto+0x24/0x30
[ 2172.951382]  do_syscall_64+0x90/0x170
......

After calling bpf_exec_tx_verdict(), the size of msg_pl->sg may increase,
e.g., when the BPF program executes bpf_msg_push_data().

If the BPF program sets cork_bytes and sg.size is smaller than cork_bytes,
it will return -ENOSPC and attempt to roll back to the non-zero copy
logic. However, during rollback, msg->msg_iter is reset, but since
msg_pl->sg.size has been increased, subsequent executions will exceed the
actual size of msg_iter.
'''
iov_iter_revert(&msg->msg_iter, msg_pl->sg.size - orig_size);
'''

The changes in this commit are based on the following considerations:

1. When cork_bytes is set, rolling back to non-zero copy logic is
pointless and can directly go to zero-copy logic.

2. We can not calculate the correct number of bytes to revert msg_iter.

Assume the original data is "abcdefgh" (8 bytes), and after 3 pushes
by the BPF program, it becomes 11-byte data: "abc?de?fgh?".
Then, we set cork_bytes to 6, which means the first 6 bytes have been
processed, and the remaining 5 bytes "?fgh?" will be cached until the
length meets the cork_bytes requirement.

However, some data in "?fgh?" is not within 'sg->msg_iter'
(but in msg_pl instead), especially the data "?" we pushed.

So it doesn't seem as simple as just reverting through an offset of
msg_iter.

3. For non-TLS sockets in tcp_bpf_sendmsg, when a "cork" situation occurs,
the user-space send() doesn't return an error, and the returned length is
the same as the input length parameter, even if some data is cached.

Additionally, I saw that the current non-zero-copy logic for handling
corking is written as:
'''
line 1177
else if (ret != -EAGAIN) {
	if (ret == -ENOSPC)
		ret = 0;
	goto send_end;
'''

So it's ok to just return 'copied' without error when a "cork" situation
occurs.

Fixes: fcb14cb1bdac ("new iov_iter flavour - ITER_UBUF")
Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/tls/tls_sw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 914d4e1516a3..f3d7d19482da 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1120,9 +1120,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 					num_async++;
 				else if (ret == -ENOMEM)
 					goto wait_for_memory;
-				else if (ctx->open_rec && ret == -ENOSPC)
+				else if (ctx->open_rec && ret == -ENOSPC) {
+					if (msg_pl->cork_bytes) {
+						ret = 0;
+						goto send_end;
+					}
 					goto rollback_iter;
-				else if (ret != -EAGAIN)
+				} else if (ret != -EAGAIN)
 					goto send_end;
 			}
 			continue;
-- 
2.47.1


