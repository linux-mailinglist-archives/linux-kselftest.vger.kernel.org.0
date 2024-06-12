Return-Path: <linux-kselftest+bounces-11750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F207904EFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 11:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F335F1C217E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 09:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEAD16D9BF;
	Wed, 12 Jun 2024 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeKcN0Vk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0223416D9B8;
	Wed, 12 Jun 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183967; cv=none; b=s4+ZC3bjHaMzWEYLeSB4G65J0v6NjdPD5ClhN7K8LX91MHCzVbJqOQ6H98v8xAphne4Qi0evyS6JWk2GH3Qgh+a5F7trld8UKOoR75U4z1oN02QXWvULG4dXq7IhisclLeK5lXZAAbfpw82liRqqfsk3ck3/9K9g+AuyulVGxyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183967; c=relaxed/simple;
	bh=ywnb+DhiBaWLlcskKAsMq45MMHp/bpKNsS6PRDDRLkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbILhqzkAAwKtVDHI9kYB/3OWHkr6xLI7nY1UeeTNSLc525nMmILGbqW9C7CLIC9EMufv09/3ZZNnf1qUccwrk+nTPGD0Xg8OPaovd3oVNDYwzGjtTC3yOhBG4K3xdNWk7wXKP+1NWdrAgYfaRwT2Ok7FuHd4pyqQT/OzgIajV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeKcN0Vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8571BC3277B;
	Wed, 12 Jun 2024 09:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718183966;
	bh=ywnb+DhiBaWLlcskKAsMq45MMHp/bpKNsS6PRDDRLkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EeKcN0VktEkKOw3BeFTl8YbygzXOn/yBr1pAeqnPMxJCWLXgvYDF8pjZQeAzEElwA
	 ODDFkqhv8gWsvzh8eZu10FqjszMdWmBUtMYoj8EuIHqDROApnhRB2qwO0tqdjFHSXm
	 h/vI6+utghodFw85tV9vfY9gfz1r1jUQyu2s30aZdQIH5vA2hTUFh3LVdwencO+oPn
	 EdgUFKlmI4OIHHxd2V5+qMV3YLBRIrRT6qGaUtfjH5SjvPPWgk1pv8Un8jvnIlSKyO
	 +O4Iw9/tm6UWb+Iu6E4bsm4FC7TEXB/0sE9CeAJP/EWGSkpPR9z9CzMiCr8BPEs8CZ
	 2S2mlzawJgQ9w==
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
Subject: [PATCH net-next v7 1/2] tls: receive msg again for sk_redirect
Date: Wed, 12 Jun 2024 17:19:03 +0800
Message-ID: <ce31a803e39c856f27f16f9ec03376ef7fc4da81.1718182183.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718182183.git.tanggeliang@kylinos.cn>
References: <cover.1718182183.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

tls_sw doesn't work for sk_redirect in nonblock mode, sk_msg_recvmsg()
returns 0 in that case in tls_sw_recvmsg(). This patch fixes this by using
"continue" to receive msg again instead of ending it if strp isn't ready
and rx_list is empty.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_sw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 305a412785f5..ae8bbe7dc8ec 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2017,6 +2017,9 @@ int tls_sw_recvmsg(struct sock *sk,
 					len -= chunk;
 					continue;
 				}
+				if (!chunk && !tls_strp_msg_ready(ctx) &&
+				    skb_queue_empty_lockless(&ctx->rx_list))
+					continue;
 			}
 			goto recv_end;
 		}
-- 
2.43.0


