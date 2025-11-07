Return-Path: <linux-kselftest+bounces-45080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50300C3FACC
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 12:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F5A04E1C06
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7233A320A14;
	Fri,  7 Nov 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSkaOG9w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44256320A00;
	Fri,  7 Nov 2025 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514112; cv=none; b=GimQT6+7glbOtnH7qZXZ1MqLtR3RNArRXlPtksrp/Ye9Y+pYPrOi+v+U6ObfHLL6El3ALEE8CZ7+Bd7zoXvyn4plfU2B1WefGExWuhZcbXBvnDMWclTcZYrq8guNk0wHxlMeP+7f1YSCu7u2/znK08POSrAZl4c+VEBYfUNaN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514112; c=relaxed/simple;
	bh=R0+I1GodW0kaLsfONU7InUNmqif4N7CYW8CRHNfhb8U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mlvhWdmwNGT0YGFxex3Dv3Fe5dzXfveltwOO5DCfGdbKmHeQBuSUrgv0uDqu9LL9vR9GOfCbOr2NguEffrHjWP1o02vuvTd4Vqu85ioKaIMWrT0/oWm6/Fhv5xC/2OPcxuEiGIJrUmTU2HEGVd0WmfdAel1l8fJqaljus3+Yo6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSkaOG9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1BDC19424;
	Fri,  7 Nov 2025 11:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762514111;
	bh=R0+I1GodW0kaLsfONU7InUNmqif4N7CYW8CRHNfhb8U=;
	h=From:Subject:Date:To:Cc:From;
	b=bSkaOG9wbHDpEphNm1vrIC/iyflW/bP6ozjv49bASRMW1yIch6h1drNW+PNlgPdzH
	 59IiYVSanQ0ieaqlysoKKYHqVagxje5k4tn/8PRgM+B3Yxzz41rOhhvGY5QwxprDU7
	 YL7h11OmRS26KFFbzQboMed9Uj53LOZ4xh3x/KZ2e9gZc3pPFWjrsQ3NIZcmXcFcn1
	 e269aOiuRNlmDzPJ2BWvHq1jVJtbLG3yq6/Ag2ydvLsOYXy9+w3FuPPzC9yvI5LCN5
	 fSVE+okshPqmIQUEWM5MABLVa0LqD+MhUKV6OpV3nxCGDCEyzzyuaFswJwKqmUGCj9
	 6y2cgT8z3150g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH nf-next v9 0/3] Add IPIP flowtable SW acceleration
Date: Fri, 07 Nov 2025 12:14:45 +0100
Message-Id: <20251107-nf-flowtable-ipip-v9-0-7cbc4090dfcb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKXUDWkC/33Qy2rDMBAF0F8JWldlRs9RVv2P0oX1SkSDbezgp
 oT8e4UXjYtFl8MdnbnozuY0lTSz4+HOprSUuQx9HdzLgYVz158SL7HOTIDQYITkfeb5MnxdO3+
 p2VhGjl5G64EiGMvqu3FKudxW853V9T7druyjBucyX4fpe7214Br/wy7IkQvSUjuTpFP49pmmP
 l1eh+m0covYErZFCA48WJQAMiSr/Y6QT8JCs4WsBBF0OUp03uUdoTYEUotQlcjkPQYk78jsCL0
 hBLYIXQkgo7vskqawJ8yToHYLU4kUOwdKCStd2BH2l0Bot7CV6JQWqMgZhH0L2hLN76RK6Kgja
 aeDlfCHeDweP4v1SHuRAgAA
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
Changes in v9:
- Fixed IPIP tunnel offloading when VLAN encapsulation is enabled.
- Add IPIP tunnel over vlan self-test
- Remove wrong filed from flow_offload_tuple key
- Cosmetics
- Link to v8: https://lore.kernel.org/r/20251023-nf-flowtable-ipip-v8-0-5d5d8595c730@kernel.org

Changes in v8:
- Rebase on top of the following series (not yet applied)
  https://patchwork.ozlabs.org/project/netfilter-devel/list/?series=477081
- Link to v7: https://lore.kernel.org/r/20251021-nf-flowtable-ipip-v7-0-a45214896106@kernel.org

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

 include/linux/netdevice.h                          |  13 ++
 include/net/netfilter/nf_flow_table.h              |  18 +++
 net/ipv4/ipip.c                                    |  25 ++++
 net/netfilter/nf_flow_table_core.c                 |   3 +
 net/netfilter/nf_flow_table_ip.c                   | 135 +++++++++++++++++++--
 net/netfilter/nf_flow_table_path.c                 |  84 +++++++++++--
 .../selftests/net/netfilter/nft_flowtable.sh       |  69 +++++++++++
 7 files changed, 328 insertions(+), 19 deletions(-)
---
base-commit: 32e4b1bf1bbfe63e52e2fff7ade0aaeb805defe3
change-id: 20250623-nf-flowtable-ipip-1b3d7b08d067

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


