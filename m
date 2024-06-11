Return-Path: <linux-kselftest+bounces-11668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42249037A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 11:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258DDB21F51
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E234176AA2;
	Tue, 11 Jun 2024 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPcbD/Zq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154E7346F;
	Tue, 11 Jun 2024 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097242; cv=none; b=rN2gozoLttNzL1C/oxdlhbDB0gPktU0Cns+quIgRFIJ99IlMiQBfHsvPhmxb+IBLM5nPugti8He3cLSOzw0KQdeCe3LZ57KtfpM1bPbW1IDrrv1YB9I7F6dv+1CWUA/hLY8FwKRGxIp842T8Mvo+xZxldB+DZO3k1BUXS0GNqbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097242; c=relaxed/simple;
	bh=NGYzuForK7vVwCclKUD8cf59XgCXGzNi7zSFHo5AoQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMi3DCe0IWCuB+dlyNNjDqmRy91CwtfI9iK61IX5FIS4HErtqAj5AygzYUYFP1sV7Ipv9kY/f30NG35txzwrzJexqvjFCi0vusl1jVNljJybUrxeTMvoPemVHvpR/SWL9dVaJ6yZUm1nJbGTiZQVuxoSQKcAxNcVpa7xDl9Mq/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPcbD/Zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB110C32786;
	Tue, 11 Jun 2024 09:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718097241;
	bh=NGYzuForK7vVwCclKUD8cf59XgCXGzNi7zSFHo5AoQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GPcbD/ZqbC2yj9V6FisJZIoR46iVifeNMTphrHuPi1vvQ07UOJNXLS9tzsf9fkSvn
	 F8qY++nQMQithhnnP4teiKe8M0ZspVctoVQVtLdwRh7GB4Ipzc4WGr0kHngSAX2+OW
	 0/AoXmIYBLlLc0IsutPvhKXOYXXFCYS0Dox6ToQaxMjcpoT0a+ym9/7Rx9IiHQ7EHe
	 UDMHUT5W4JoWh8qA8V9scatM725Y5H6ar8rxsv+mNpdeTGnZcnLETqLdZLgtoM0X/I
	 iqs4/sd4KeMG7ihZDwYPP97h7IQgkdcOt0d2b/EmLJH50P2fOmtGsoRDhY//S3eRJ4
	 PqPUudKut6zkQ==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 1/2] tls: wait for receiving next skb for sk_redirect
Date: Tue, 11 Jun 2024 17:13:34 +0800
Message-ID: <3101675d11beac0ffe16a86877f7f0c5166605f6.1718096691.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718096691.git.tanggeliang@kylinos.cn>
References: <cover.1718096691.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

tls_sw_recvmsg() doesn't work in nonblock mode, it returns -EAGAIN in
that case. This patch fixes it, always wait for receiving the next skb
for sk_redirect.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_sw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 305a412785f5..d2558856ceeb 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2099,6 +2099,8 @@ int tls_sw_recvmsg(struct sock *sk,
 					rxm->full_len = 0;
 					if (err == __SK_DROP)
 						consume_skb(skb);
+					if (err == __SK_REDIRECT && flags & MSG_DONTWAIT)
+						tls_rx_rec_wait(sk, psock, false, released);
 					continue;
 				}
 			}
-- 
2.43.0


