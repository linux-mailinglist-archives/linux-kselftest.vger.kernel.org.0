Return-Path: <linux-kselftest+bounces-43677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B985BF7F50
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 19:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5B814F9BB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 17:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F03534D4E0;
	Tue, 21 Oct 2025 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwrdX7eX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72668257859;
	Tue, 21 Oct 2025 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068926; cv=none; b=Jwd3UgbB/18PV9D7M4Igd6EMJ1ZyG8cW/9FtzdS2cqe9Op0sJap49+Y9IgCncZSDfujgd5R+5ka77HKEzG5NqdfsQm3s02qQLKXpY33xqfRTvjwged/2ocKM9+y9/N7NHln9DOPdEeQDzoSHPTHC+hCoB3jv2uBKSQhtnU81dpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068926; c=relaxed/simple;
	bh=xTK30UAO9p6bgYH8vFHy8TPEhx3i0ch7EaIe4aHEjJI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y5NBtFcQZLakcg5swZrbh97oSA7vnGmYKY8RvygcpXcSwd310pvcvkCAka3oSDKiQ7+CabIy0rTg4IioJ9Xj/JW3+k48ST1Crv2pqD0JNeSo+K+ElDy5Xt140XW3GvSLIH7G9vkGnvc9CgBlXackfBqhfT8c8pUW+2CKWIwKiC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwrdX7eX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EBAC4CEF1;
	Tue, 21 Oct 2025 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761068925;
	bh=xTK30UAO9p6bgYH8vFHy8TPEhx3i0ch7EaIe4aHEjJI=;
	h=From:Subject:Date:To:Cc:From;
	b=gwrdX7eXiagWIGx1i+O88T91LTiB7lB9GG+8QCT+M3rXrngiXJjgLUzfI79ehnuNQ
	 KT9x1yJCXntHRHa8N8dqE8jRDU1LybPUAnhFCLqaL7ZVKtvqk2nWwoDLGJZRPEGUrJ
	 NMIlBKxZope22DRMtyc8Ub9I/iHI/DLrPUYli/n8n/VMJsvZVhKXfQt8+q+08YZsaH
	 Rl00zL6xNHp8NAuP0Lyr0qDdfs+bXOTwMKmoO5gAZ8QSQI1RA9YVBuFtXJS2Qt7q6p
	 WfmRIL9ujDc/piVsLoEH5mw93YkO0AF7QKb8FxfRbP9xXMy2L6VpCV8+NljGgonTAA
	 duFh/LWcmtEcQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH nf-next v7 0/3] Add IPIP flowtable SW acceleration
Date: Tue, 21 Oct 2025 19:48:17 +0200
Message-Id: <20251021-nf-flowtable-ipip-v7-0-a45214896106@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGHH92gC/33OwW6EIBAG4FfZcC7NAAJDT32PpgfAYZfUqEFjt
 9n47iVe1kbT4+Sf+eZ/sIlKpom9XR6s0JKnPPR1sC8XFm++vxLPbZ2ZBKnBSMX7xFM3fM8+dDU
 b88hFUK0NgC0Yy+rdWCjl+2Z+sLre031mnzW45Wkeys/2axFb/A+7CC64RK20M6RcI96/qPTUv
 Q7lunGL3BP2jJAceLRCAahIVocDoZ6EhdMWqhKI4FOrhAsuHYhmRwg8I5pKJAxBRIHBoTkQekd
 IcUboSgAa7ZMjjfFImCeB5y1MJaj1DppGWuXiH2Jd11/zbAd9CwIAAA==
X-Change-ID: 20250623-nf-flowtable-ipip-1b3d7b08d067
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Phil Sutter <phil@nwl.cc>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
infrastructure. This series introduces basic infrastructure to
accelerate other tunnel types (e.g. IP6IP6).

---
Changes in v7:
- Introduce sw acceleration for tx path of IPIP tunnels
- Rely on exact match during flowtable entry lookup
- Fix typos
- Link to v6: https://lore.kernel.org/r/20250818-nf-flowtable-ipip-v6-0-eda90442739c@kernel.org

Changes in v6:
- Rebase on top of nf-next main branch
- Link to v5: https://lore.kernel.org/r/20250721-nf-flowtable-ipip-v5-0-0865af9e58c6@kernel.org

Changes in v5:
- Rely on __ipv4_addr_hash() to compute the hash used as encap ID
- Remove unnecessary pskb_may_pull() in nf_flow_tuple_encap()
- Add nf_flow_ip4_ecanp_pop utility routine
- Link to v4: https://lore.kernel.org/r/20250718-nf-flowtable-ipip-v4-0-f8bb1c18b986@kernel.org

Changes in v4:
- Use the hash value of the saddr, daddr and protocol of outer IP header as
  encapsulation id.
- Link to v3: https://lore.kernel.org/r/20250703-nf-flowtable-ipip-v3-0-880afd319b9f@kernel.org

Changes in v3:
- Add outer IP header sanity checks
- target nf-next tree instead of net-next
- Link to v2: https://lore.kernel.org/r/20250627-nf-flowtable-ipip-v2-0-c713003ce75b@kernel.org

Changes in v2:
- Introduce IPIP flowtable selftest
- Link to v1: https://lore.kernel.org/r/20250623-nf-flowtable-ipip-v1-1-2853596e3941@kernel.org

---
Lorenzo Bianconi (3):
      net: netfilter: Add IPIP flowtable rx sw acceleration
      net: netfilter: Add IPIP flowtable tx sw acceleration
      selftests: netfilter: nft_flowtable.sh: Add IPIP flowtable selftest

 include/linux/netdevice.h                          |  16 +++
 include/net/netfilter/nf_flow_table.h              |  26 +++++
 net/ipv4/ipip.c                                    |  29 +++++
 net/netfilter/nf_flow_table_core.c                 |  10 ++
 net/netfilter/nf_flow_table_ip.c                   | 118 ++++++++++++++++++++-
 net/netfilter/nft_flow_offload.c                   |  79 ++++++++++++--
 .../selftests/net/netfilter/nft_flowtable.sh       |  40 +++++++
 7 files changed, 307 insertions(+), 11 deletions(-)
---
base-commit: d1d7998df9d7d3ee20bcfc876065fa897b11506d
change-id: 20250623-nf-flowtable-ipip-1b3d7b08d067

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


