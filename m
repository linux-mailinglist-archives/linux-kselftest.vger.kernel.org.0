Return-Path: <linux-kselftest+bounces-43852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20663C0002D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 10:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78BBC4F471A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 08:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22777303A2C;
	Thu, 23 Oct 2025 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFeN3NjK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB98302CA5;
	Thu, 23 Oct 2025 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209434; cv=none; b=DQEDuHDqbGq5beQ0UbSHhFEmGFYdKEzjO/qgrR473ebh0lULlJm8e5yuZkAZ/TYeAhoSxP23O2zxXSPTigqxWV+Q8w3x3vUoAc5vo5qIJcf7KDY8qdhaemoBEQ480awvsDEBLPr9RY4lRnUuW9ZNlf0IMCA8yDxXL4uMcaFhR5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209434; c=relaxed/simple;
	bh=7VH3gNPmDXc9YjKI4gD5pemxcGjqpYCuYsUw+3AnEvs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O+fz8TgALJbR1bqSWRzEocBujpOpEQ2kKwOvSktanDdroxNH96FwSATqtmRl/Zf33Y4hvK6awY4A/t7LR4Ntqf9Hg/Bnxo7UdYvPa8nVF9/L8xmNcRimgFCe+pt0F/uo1B5ZwA9sQ5cj8XdW2Wc7SDJIM18Kz32RFpt5DvZ2I6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFeN3NjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D8BC4CEE7;
	Thu, 23 Oct 2025 08:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761209433;
	bh=7VH3gNPmDXc9YjKI4gD5pemxcGjqpYCuYsUw+3AnEvs=;
	h=From:Subject:Date:To:Cc:From;
	b=nFeN3NjKgOX430IkLWGxNaUQiNoFtkE3pMyJqS04xWPJQwjczC510h7KJs2cDMfCx
	 UMbTKI2GNDzJojfPXDHTXtgl9Nr0bDQrHmdxKw7kyh3xTSGxh6iGajk2HfbuQK1bXf
	 OpXWaIjqY+5ZZDE+8nH/QVTGPDrHANlJ/ufP4cV7EhUSL8GCbZGPUI+SNOuyqpbo3J
	 KYXrpVxGXPswEVTrCaOc+CdX8MMnk+DxoE2aQFDPGk9+YMv91iaev5QLKs81/USYmc
	 SRz9SLTIfrEyff5QnldrJkBXSkptnbUjo+EYn8C5AXRcaho4OD2fs9KrZ5f3hNMBT2
	 +5NDrxhh9J+BA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH nf-next v8 0/3] Add IPIP flowtable SW acceleration
Date: Thu, 23 Oct 2025 10:50:14 +0200
Message-Id: <20251023-nf-flowtable-ipip-v8-0-5d5d8595c730@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEbs+WgC/33OTWrDMBAF4KsErasyo99RVr1H6cKSpUQ02MY2b
 krw3Su8aFwsuhzezDfvwaY45jix8+nBxrjkKfddGejlxMK16S6R57bMTIDQYITkXeLp1n/Njb+
 VbMgDRy9b64FaMJaVu2GMKd83852V9S7eZ/ZRgmue5n783n4tuMX/sAty5IK01M5E6RS+fcaxi
 7fXfrxs3CL2hK0RggMPFiWADNFqfyDkk7BQbSELQQRNaiU679KBUDsCqUaoQiTyHgOSd2QOhN4
 RAmuELgSQ0U1yUVM4EuZJUL2FKURsGwdKCStdOBD2l0Cot7CFaJQWqMgZhL8t1nX9AdHj7e1OA
 gAA
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

 include/linux/netdevice.h                          |  16 +++
 include/net/netfilter/nf_flow_table.h              |  22 ++++
 net/ipv4/ipip.c                                    |  29 +++++
 net/netfilter/nf_flow_table_core.c                 |   3 +
 net/netfilter/nf_flow_table_ip.c                   | 117 ++++++++++++++++++++-
 net/netfilter/nf_flow_table_path.c                 |  86 +++++++++++++--
 .../selftests/net/netfilter/nft_flowtable.sh       |  40 +++++++
 7 files changed, 298 insertions(+), 15 deletions(-)
---
base-commit: 32e4b1bf1bbfe63e52e2fff7ade0aaeb805defe3
change-id: 20250623-nf-flowtable-ipip-1b3d7b08d067

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


