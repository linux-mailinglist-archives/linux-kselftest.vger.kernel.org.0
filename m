Return-Path: <linux-kselftest+bounces-31626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53917A9BE47
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 08:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B921B8835F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 06:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B710822B8A8;
	Fri, 25 Apr 2025 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RchA3BKr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D05156C69
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560873; cv=none; b=ew4J6RT4KQcIXeRNFGvcUAbw9tJV+DzqqZdfA4UXo+AT6aBSdVKlIG/fsFj3ejXpvYwKdNajXwNCgvGaZ5r1xp4h6Lhzyez72ThlVSH9aAOxA7RgdQN/oesS5BUiHxM7dqbojYA4yXx+pmFHhaQ194929Vl9XoOCH4I7xFcbpBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560873; c=relaxed/simple;
	bh=og8M9B4FHvzUgLuT1E7FT8iMPtVnMg+YA9UWQPvH2NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mN1B/XwYMNK70ld3Ve57pjiG8Jp1iFSlo/XHjRkd3hJpptUEqe4SGzL3VNxvRLstvLwnjhv9QPAY6gjJ/Gh+9LgzgCt7x2a4wdd+zx2Dsrpt3ELYFKJ3t5f+eRfkXCijBOKk/re2Z3JPxZ3GCmlw22O3sgqBujlALfJsUXZvocs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RchA3BKr; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745560869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdVpzvtZn2JQNi80SAYrqqWduzBTLxagERvM+Rtaows=;
	b=RchA3BKrE9IucRTtRair04PwzAS8I77OfG5Nmv4aQUBFgORhj6lpMvs8ZtSe1npK9qNXOn
	iTTHbZzZkmv1Qy3zd9mhC3k4vLKHOJ1k4bEq2EFhOtIaqSajOprVYotoRvAd+mAt1IMQbx
	zxpidx9FFroaXe0qg+3Tjv3vx55NiyQ=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 1/2] ktls, sockmap: Fix missing uncharge operation
Date: Fri, 25 Apr 2025 13:59:57 +0800
Message-ID: <20250425060015.6968-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250425060015.6968-1-jiayuan.chen@linux.dev>
References: <20250425060015.6968-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When we specify apply_bytes, we divide the msg into multiple segments,
each with a length of 'send', and every time we send this part of the data
using tcp_bpf_sendmsg_redir(), we use sk_msg_return_zero() to uncharge the
memory of the specified 'send' size.

However, if the first segment of data fails to send, for example, the
peer's buffer is full, we need to release all of the msg. When releasing
the msg, we haven't uncharged the memory of the subsequent segments.

This modification does not make significant logical changes, but only
fills in the missing uncharge places.

This issue has existed all along, until it was exposed after we added the
apply test in test_sockmap:
commit 3448ad23b34e ("selftests/bpf: Add apply_bytes test to test_txmsg_redir_wait_sndmem in test_sockmap")

Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
Closes: https://lore.kernel.org/bpf/aAmIi0vlycHtbXeb@pop-os.localdomain/T/#t
Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/tls/tls_sw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index f3d7d19482da..fc88e34b7f33 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -908,6 +908,13 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 					    &msg_redir, send, flags);
 		lock_sock(sk);
 		if (err < 0) {
+			/* Regardless of whether the data represented by
+			 * msg_redir is sent successfully, we have already
+			 * uncharged it via sk_msg_return_zero(). The
+			 * msg->sg.size represents the remaining unprocessed
+			 * data, which needs to be uncharged here.
+			 */
+			sk_mem_uncharge(sk, msg->sg.size);
 			*copied -= sk_msg_free_nocharge(sk, &msg_redir);
 			msg->sg.size = 0;
 		}
-- 
2.47.1


