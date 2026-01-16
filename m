Return-Path: <linux-kselftest+bounces-49128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAA5D2DEA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B71B53016227
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2522F39B8;
	Fri, 16 Jan 2026 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="judm+t80"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E90281520;
	Fri, 16 Jan 2026 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551231; cv=none; b=CeL/JP7n4Q8B+IefGSv5L850lEXTPjWjAXBrr86KEkxHoQzU916gz8T8Hd4hZ+aJZm3a+7e/u3BWqgSY4oF7bZg3HGRTEAN2RqZhd8km2Qgbtab3O4e3H1/jXgdwnce/rIY7FAW6G4+ZeEALiPsclKmS5MGMBm7gdfdYGKTqLPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551231; c=relaxed/simple;
	bh=G/mT4rw8jk66CvnxbnGbI90ZwgLcE0WYBE2mmR0DCRw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uxSIYjvS/ycbzvPi09We4k7nkhyZv4W7AxZFENDwXWpY9UZPggmdloSNmg/K29Ch6gb5795ASGw5rE9VKDOPr2uUTcEWGEZnVPCez06F7RKtuzvMmRaHbaFf98hle9fi6qODdPqqcRMNtLiZI/IMqRWaVoan+C9D9BMGf1Ivl5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=judm+t80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F45C116C6;
	Fri, 16 Jan 2026 08:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551231;
	bh=G/mT4rw8jk66CvnxbnGbI90ZwgLcE0WYBE2mmR0DCRw=;
	h=From:Subject:Date:To:Cc:From;
	b=judm+t80kSpkz8RnxjYFfEBIeshOzkjbwN+ciSFjv8KX0uCB4J6ohyIQPwBRQbpwt
	 6WXK6qacSCSck1NHKMjP2en7C6sJeXr+LnLdcyNMNUP8rlO8QLnw+B1/cojmKW2byV
	 Bb8Qoj8xdZwhnN3mc0MeQB1in/Z/DmVNr85f4DPEv0YbtDoHOgT6t8uQslaflK1e+3
	 wgFbTPlx9typ5Q3nrsp5UDn26pHEBmDGknTyufwSAeP5+csjw8rBTkREldAWckyxPn
	 YzARRIAWlyPxx4NmSCSAkKSqvDnu1M020Ol7ymp63wJXsnENBFk59aSV7vG3kmhsu3
	 dGybPAswU2N1Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH nf-next v3 0/5] Add IP6IP6 flowtable SW acceleration
Date: Fri, 16 Jan 2026 09:13:17 +0100
Message-Id: <20260116-b4-flowtable-offload-ip6ip6-v3-0-c1fcad85a905@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NsQ6CMBCA4VcxnT1DS6HFyfcwDm25QiOhpCVVQ
 3h3C5MuxuSG+2/4biERg8NIzoeFBEwuOj/mKI8HYno1dgiuzU1YwSrKCgGagx38Y1Z6QPA276o
 FN9V5QGKjmKltqYQgWZgCWvfc9estd+/i7MNrf5bodv3PTRQKoBJLpYUVXJrLHcOIw8mHjmxwY
 p9Y8xtjGeNcUmGpxsrUX9i6rm9aOJMGFAEAAA==
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
Changes in v3:
- Split patch 1/4 in two separated patches 1/4 and 2/4 and improve
  commit logs
- Add more comments in the code
- Rely on skb_header_pointer in patch 2/4
- Link to v2: https://lore.kernel.org/r/20251209-b4-flowtable-offload-ip6ip6-v2-0-44817f1be5c6@kernel.org

Changes in v2:
- Fix compilation when CONFIG_IPV6 is disabled
- Rely on ipv6_skip_exthdr() in nf_flow_ip6_tunnel_proto() to avoid
  use-after-free issues
- Drop patch 2/5 from v1
- Link to v1: https://lore.kernel.org/r/20251207-b4-flowtable-offload-ip6ip6-v1-0-18e3ab7f748c@kernel.org

---
Lorenzo Bianconi (5):
      netfilter: Add ctx pointer in nf_flow_skb_encap_protocol/nf_flow_ip4_tunnel_proto signature
      netfilter: Introduce tunnel metadata info in nf_flowtable_ctx struct
      netfilter: flowtable: Add IP6IP6 rx sw acceleration
      netfilter: flowtable: Add IP6IP6 tx sw acceleration
      selftests: netfilter: nft_flowtable.sh: Add IP6IP6 flowtable selftest

 net/ipv6/ip6_tunnel.c                              |  27 +++
 net/netfilter/nf_flow_table_ip.c                   | 231 ++++++++++++++++++---
 .../selftests/net/netfilter/nft_flowtable.sh       |  62 +++++-
 3 files changed, 277 insertions(+), 43 deletions(-)
---
base-commit: f8156ef0fd8232055396ebf1e044fa06fb8bc388
change-id: 20251207-b4-flowtable-offload-ip6ip6-8e9a2c6f3a77

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


