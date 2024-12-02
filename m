Return-Path: <linux-kselftest+bounces-22671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DDF9E02F7
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 14:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594D6B221E1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52D41FE463;
	Mon,  2 Dec 2024 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="iMTR94ZQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACBB1FE44D;
	Mon,  2 Dec 2024 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140664; cv=none; b=nW2J3ro4AArrPsz4iNWKMB2Z8cgvtfbI74SnWe4+XlHmyLRiy21MCW3fIPXDQ8kwVRYftg8aw1gXkAdDkRqyp+NHGE13BnwP/Ur6fLfnbV+nWHAimrBVwwvKfGgiAEQ2500CpEDakNkRHwVp6ChIqQ/qke6PlHd66QD8YfHqfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140664; c=relaxed/simple;
	bh=Qp54G1wDVlff83pTPgjxhEijVs1GRnWXj9GeuRHDTV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALn9hhBQjlDCoKUvS30CS/FCrpMpnDhYJPeg+9tcpWVjsvzBTlViwJsBc2iZ3AMe67RB61KGP6EuDjBc01u6IPjzNkhOzCmA6BhwH/Rs5D9I9diaOHzJHpM9hJmE2YQRhgBqNPTTMUi4c5YKQ4BC+Ld0apdwN7jzp8Gl1MqdxFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=iMTR94ZQ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tI4dI-008GeO-0E; Mon, 02 Dec 2024 12:30:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=N4MXPX46bSsTiOsfmmAde5fJTpY4yHbLGYMqDMKBx3k=; b=iMTR94ZQetOTqTZUdkPxJlPB8j
	5IZ6+mI8Gm4riCySLodBQZ69uaqupzIq4z/sCQh/tCS4C3ru4A4DQOLewIIeE1kPTEZ6vh8nrHIDT
	JjCi3fycfPdhzeOBd6lZDEKxWXkUMk9mEdHsTdut8yuEKuHOIjQoA9YnRczjZkY8HowSg11qrUo9P
	zDeVoYzps7hTG2m+q8mRbKIk24cEGKZubqcbn4E8qmmPhkLp3Js1l4Qn/njLPG2RQlkrP480fmw85
	yfNMEN+n7GZ2oSgzZTEJKq5/WvxW4ORNjCBtiLPn+Ch6SN3FVw8ms74otQGslwWp2dkXmkSGoiyGu
	eMmyrBTA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tI4dH-0005dz-Bz; Mon, 02 Dec 2024 12:30:27 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tI4d3-007H5a-5a; Mon, 02 Dec 2024 12:30:13 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 02 Dec 2024 12:29:23 +0100
Subject: [PATCH bpf 1/3] bpf, sockmap: Fix update element with same
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-sockmap-replace-v1-1-1e88579e7bd5@rbox.co>
References: <20241202-sockmap-replace-v1-0-1e88579e7bd5@rbox.co>
In-Reply-To: <20241202-sockmap-replace-v1-0-1e88579e7bd5@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Consider a sockmap entry being updated with the same socket:

	osk = stab->sks[idx];
	sock_map_add_link(psock, link, map, &stab->sks[idx]);
	stab->sks[idx] = sk;
	if (osk)
		sock_map_unref(osk, &stab->sks[idx]);

Due to sock_map_unref(), which invokes sock_map_del_link(), all the psock's
links for stab->sks[idx] are torn:

	list_for_each_entry_safe(link, tmp, &psock->link, list) {
		if (link->link_raw == link_raw) {
			...
			list_del(&link->list);
			sk_psock_free_link(link);
		}
	}

And that includes the new link sock_map_add_link() added just before the
unref.

This results in a sockmap holding a socket, but without the respective
link. This in turn means that close(sock) won't trigger the cleanup, i.e. a
closed socket will not be automatically removed from the sockmap.

Stop tearing the links when a matching link_raw is found.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/sock_map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 78347d7d25ef31525f8ec0a755a18e5793ad92c0..20b348b1964a10a1b0bfbe1a90a4a4cd99715b81 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -159,6 +159,7 @@ static void sock_map_del_link(struct sock *sk,
 				verdict_stop = true;
 			list_del(&link->list);
 			sk_psock_free_link(link);
+			break;
 		}
 	}
 	spin_unlock_bh(&psock->link_lock);

-- 
2.46.2


