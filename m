Return-Path: <linux-kselftest+bounces-47233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 329E7CAB753
	for <lists+linux-kselftest@lfdr.de>; Sun, 07 Dec 2025 17:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8CF0300F30E
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Dec 2025 16:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F6922D9ED;
	Sun,  7 Dec 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rglKUCt7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9081FBEA8;
	Sun,  7 Dec 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765123632; cv=none; b=mBe4uCM+gWxKwnF4jaBKMeSl7OEspYV2zJsmjEZoIL6vLfwkYDBVmr7ml/bvVfXMHZ2sIEueNIYuYWt+ga80OAXDaMoGfZY8vClXTdqeuu0LkNWNpvdXAgXUH9PP5U5UFcW712V4x8pM3NaOadfnFTiD3m82ppV09A4H8e6OMpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765123632; c=relaxed/simple;
	bh=5GFnji18g2zo2p1O96zrMt9Wf6ZWDF7UcPczZLRLeLM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aH7tee927uSa0HbrahbwrUQgfZM53JnTe0j09+lCqjXXYWaSFnw0t9Fm5dWq/HfSXbhZcTjDb+lzM9bYxPvO0fywfRhWbegFD8TmWY8eC4yO6gpsnKiptYv5qSz1J3WZs6mrhfJDT+1OhQu7LBQwD9Y/nUhYY/m7pICN236L4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rglKUCt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88088C4CEFB;
	Sun,  7 Dec 2025 16:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765123632;
	bh=5GFnji18g2zo2p1O96zrMt9Wf6ZWDF7UcPczZLRLeLM=;
	h=From:Subject:Date:To:Cc:From;
	b=rglKUCt7zWATOXjjl8u9WtZgExLXfyVmCMEwOZGeKz4l1sgFjdwaA8oJTKX2Eb5sI
	 uhGamOCYnf8BsPR494jsdZoVGCJ12iy4hnZQ2Qiz8Rhx5I7NL3f8yOllWirmhihWyQ
	 6RYc2/A0WGn34oJNJjfqrpAh99n8iquob6BmSIW06XM1MeYDrkHPR4VdKsMh8UDVro
	 9/CQBbu3HzA+xDjNEd7P7r2t/xTluySXKdKt7sY+9fSeh4w7bHCEcPAL5/zOQohv16
	 XGqSXAuql2x3/TfL3QVNtbNV5aXfrUj7hfIuE3CvBpxHtEfmQqqroA6QWymYlVwjuP
	 f/Cy/yOSKa4SA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH nf-next 0/5] Add IP6IP6 flowtable SW acceleration
Date: Sun, 07 Dec 2025 17:06:40 +0100
Message-Id: <20251207-b4-flowtable-offload-ip6ip6-v1-0-18e3ab7f748c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSwqFMAwAryJZG9D66XteRVxETTUgVlpRQby7Q
 ZjFzGZuiByEIzTJDYEPieJXjTxNYJhpnRhl1AaTmSo3mcW+RLf4c6d+YfROnUaUrVbwx38yQ+0
 Kshb0sAV2cn33tnueF0k4I09tAAAA
X-Change-ID: 20251207-b4-flowtable-offload-ip6ip6-8e9a2c6f3a77
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce SW acceleration for IP6IP6 tunnels in the netfilter flowtable
infrastructure.

---
Lorenzo Bianconi (5):
      netfilter: Introduce tunnel metadata info in nf_flowtable_ctx struct
      netfilter: Modify nf_flow_skb_encap_protocol() to return int intead of bool
      netfilter: flowtable: Add IP6IP6 rx sw acceleration
      netfilter: flowtable: Add IP6IP6 tx sw acceleration
      selftests: netfilter: nft_flowtable.sh: Add IP6IP6 flowtable selftest

 net/ipv6/ip6_tunnel.c                              |  27 ++
 net/netfilter/nf_flow_table_ip.c                   | 271 +++++++++++++++++----
 .../selftests/net/netfilter/nft_flowtable.sh       |  62 ++++-
 3 files changed, 306 insertions(+), 54 deletions(-)
---
base-commit: f8156ef0fd8232055396ebf1e044fa06fb8bc388
change-id: 20251207-b4-flowtable-offload-ip6ip6-8e9a2c6f3a77

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


