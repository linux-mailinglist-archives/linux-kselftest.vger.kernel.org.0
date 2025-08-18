Return-Path: <linux-kselftest+bounces-39214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BBFB29D3F
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 11:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42A22A2205
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F068830DEA0;
	Mon, 18 Aug 2025 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB1zJI0X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688C30DD36;
	Mon, 18 Aug 2025 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508101; cv=none; b=f0ZLdzz8upeVLyx9hAmhgz86pUiLJZds8J0KQZzUbUrZVg+T024fla5jpX1aTkoOhvNUvJp+RPjiL2bgj6+fRZ6wqX3RoXKXFGZAxyAjcWRpVhAQAi2J/42z9OphhTax90aWEd55YNrfwsRSNECxxuOfCayXB0hsVejlQ+TCD9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508101; c=relaxed/simple;
	bh=lZBxuhxT0/C9pXeRvInY4B4cmdkNYhGZiwqpu6LpbvE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DLDUo92rOEaWhnPF/guBAZnrXAFL+yaO3NTX9FcNpCvELvcS339rCZ9ZIC+8OdjTWN/w9a65nWODoDuLupcRUzX+Rmf1ZP0DHLG0PKdv1X+oxkbqynyFbxofMPp2ZtBYvlt/7maLgh7broyeFBdbMerSqr7NmdK3+pawrPtttTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB1zJI0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8870C4CEEB;
	Mon, 18 Aug 2025 09:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755508101;
	bh=lZBxuhxT0/C9pXeRvInY4B4cmdkNYhGZiwqpu6LpbvE=;
	h=From:Subject:Date:To:Cc:From;
	b=bB1zJI0XBjlyOCz3afkUnhpWc6WMcSejb7qbi7F/r8Q4tw/KuBaeqJgoBHLh2Rd2f
	 Dda97Rd5FP8sf/3SWlwDVgdBLxdDteDAe4pVd4pgOsgRGHINi5C2ZoXs+3THIYkCIO
	 orRaYjLiwK9k4KXoJCaiGErSGNmYH3weOx2orG+6TPpHUfmPJg7ZPtfkYRAK39nXJt
	 lOKhd1R6uXb2ou1kPqH504+JySv/Bf/OrgfxUneaEJhUWmGz4RxWPRn/+Z8wpZdtzT
	 Cvs4QnUZobCiR9zzKGLHewtLvYogtXDcWxpE8XM2Ty1uOW3jKyUG95gfsA/qCkRbEu
	 Fd1JoFrojeyvw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH nf-next v6 0/2] Add IPIP flowtable SW acceleratio
Date: Mon, 18 Aug 2025 11:07:32 +0200
Message-Id: <20250818-nf-flowtable-ipip-v6-0-eda90442739c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFTtomgC/33OTW6EMAwF4KuMsm4qOyF/s+o9qi5IcGaiooACo
 lONuHsjNqUCdfn07M9+solKooldL09WaElTGnIN+uXCwr3NN+Kpq5kJEAq0kDxHHvvha259X7s
 xjRy97IwH24E2rO6NhWJ6bOY7q+OZHjP7qMU9TfNQvrdbC271P+yCHLmwSiqnSboG3z6pZOpfh
 3LbuEXsCXNGCA48GJQAMpBR/kDIX8LA6ReyEtZCGzuJzrt4IJodgfaMaCoRrfcY0Hpn9YFQO0L
 gGaEqAVarNjpSNvwl1nX9AZ3vOwDIAQAA
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
base-commit: bab3ce404553de56242d7b09ad7ea5b70441ea41
change-id: 20250623-nf-flowtable-ipip-1b3d7b08d067

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


