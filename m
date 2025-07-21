Return-Path: <linux-kselftest+bounces-37782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EE4B0CC84
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 23:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC621188696C
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 21:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFBF23E342;
	Mon, 21 Jul 2025 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sI0FYXpL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B53715530C;
	Mon, 21 Jul 2025 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133046; cv=none; b=LhhsZ8sx6hR+iLnvT1cWeQNoVAz0tzkjTE22sSs9wmQarmBR3G+MW89ksfq97gSMi/ZRF6cKlyEr5N3CiYNI5fPWl2smGSHTjDgA9CbuKYZMoBYWN+flaIMCt6OrVHFqn6sNk5TyYhvWeG2fxwLFdvoZzDHMlqhJZb/jv0Ap1B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133046; c=relaxed/simple;
	bh=LTiSdmPGTSCi0yHTSsj/SPAZx0ws0MiaX1b2XCSA5Lk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QZNNMCwhMvn247LaKnsjV51RrI8FWFM/xUx02+WBlmOkQ8ernWBow2iyawmumyTk1RszMt7pdc6ba2UnCnRiO/1aPMuKccXQsabY7MbB81ogr2LDzIzIXBms3Vze5NRgMZEICbsXItRsxiAxpg50IWwN8iAOfsD4jspVxltGafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sI0FYXpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60689C4CEED;
	Mon, 21 Jul 2025 21:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753133045;
	bh=LTiSdmPGTSCi0yHTSsj/SPAZx0ws0MiaX1b2XCSA5Lk=;
	h=From:Subject:Date:To:Cc:From;
	b=sI0FYXpLn/RRKP4nltx8bPzog968UWd/w8820FGoBnZ9dft6EiK2CfsnqZza6BDFO
	 gORJJDmEbhFwWP4YQyKgjYYbhUzsxpQ2xf0HFpdsvyhS9jE4DLoZP1/AyeQgB6UHQZ
	 u1WF94DMOqgoxU0TJW41IrXiVcLBsjqhS4Z4ynHPMZuxHtICdQuNlnySxgjxJZVtik
	 +SVf9Y9PYZ/FZ+j1w0Ozp2XyiihaXBb824DNQSwP8qb4ppAqqRMtnu0++6IEb7dGZx
	 KH62/IKADPLYQZL66QHF4hi8Jys2aq4vDr3w3QhG4O1AhEv+vK4brwREN6mTvkzyju
	 YtUGk23G/Ixyg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH nf-next v5 0/2] Add IPIP flowtable SW acceleratio
Date: Mon, 21 Jul 2025 23:23:34 +0200
Message-Id: <20250721-nf-flowtable-ipip-v5-0-0865af9e58c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANavfmgC/33OwW6DMAwG4Fepcm4qOyYk6WnvMe1AwGmjooACY
 p0q3n0Rl3Yq2vHXb3/2Q0ycI0/ifHiIzEuc4pBK0MeDaK9NurCMXclCgdJQK5IpyNAP33Pj+9K
 NcZToqTMebAe1EWVvzBzifTM/RRlPfJ/FVymucZqH/LPdWnCr/2EXlCiV1aRdzeQq/LhxTtyfh
 nzZuEW9EmaPUBJka5AAqGWj/RtBT8LA7hdUCGuhCR2h8y68EdULgXaPqAoRrPfYovXO1n+IdV1
 /AXccGCOFAQAA
X-Change-ID: 20250623-nf-flowtable-ipip-1b3d7b08d067
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
infrastructure.

---
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
Lorenzo Bianconi (2):
      net: netfilter: Add IPIP flowtable SW acceleration
      selftests: netfilter: nft_flowtable.sh: Add IPIP flowtable selftest

 include/linux/netdevice.h                          |  1 +
 net/ipv4/ipip.c                                    | 28 +++++++++++
 net/netfilter/nf_flow_table_ip.c                   | 56 +++++++++++++++++++++-
 net/netfilter/nft_flow_offload.c                   |  1 +
 .../selftests/net/netfilter/nft_flowtable.sh       | 40 ++++++++++++++++
 5 files changed, 124 insertions(+), 2 deletions(-)
---
base-commit: dd500e4aecf25e48e874ca7628697969df679493
change-id: 20250623-nf-flowtable-ipip-1b3d7b08d067

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


