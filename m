Return-Path: <linux-kselftest+bounces-47291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F14CAF259
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 08:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D3D6300A6F9
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C47427E074;
	Tue,  9 Dec 2025 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKhm10my"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC72741AC;
	Tue,  9 Dec 2025 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265760; cv=none; b=dCj/r0CP02YShjml0t0Aqt/jDHaJe7Gp08cewH/AmK/BUe5XAXtCkmG21pRD222Ugyzmn7oexg/5p6vUPSG7xZTVmoChK9CXBuugT9RxHF9wyZZBbYhNX317qrvOTm8W4Dd8ys8pFMhFyG4jCiUsMFSV/8CdrtibxR5dMu4eSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265760; c=relaxed/simple;
	bh=rz+m2KhohhyibiCcuNEJXb+G/bF4RQKoUcygr5ERccg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QJg+VbR2U7nYzWufdQMDkGZiixqlEHFY0LL2HyvxUB0SFOjNhe+mwCCuOf53J+SnyGtsXGjiDU5gPUNhz1bExD/rosusqVtIlVffPMYgbdc6CKgaa9lnvoLKEwZGBbJXFFTX/EwI8lCVhFRbBwW2DQnTneLZ8Ptnd6O3yEE5baA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKhm10my; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A976C4CEF5;
	Tue,  9 Dec 2025 07:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765265759;
	bh=rz+m2KhohhyibiCcuNEJXb+G/bF4RQKoUcygr5ERccg=;
	h=From:Subject:Date:To:Cc:From;
	b=rKhm10myHl1kxiYWeeP5ESH8nH4DMgafY2Dh8T8CvRMXFZAeoftqz9+jvu5T2nuxC
	 NHyTa2TU6JM+WAuooRFQvIRJuoQ6Xd5FBu3HKvRm0EhtA50q4hH55T9pAEMH9a0aXt
	 Zfhu5FYdVi7VNWw/xGwwvtHXKmE6Sm7RwB3nmtwokdGhl80g62TQKNAb6GgDuu6sAE
	 mI+jdR4dLy+lbnnbMiQlZr0xOL0FZwlffKH5YRpS7oe0hGJQroa5BGE8iY0SeQZIq0
	 OLNs7cz4BJ4ABC2941fj1qmy8J2wzu52J9j+tatJka2KBrRWBThBYldO+J3yIlWMsA
	 9kz9wft8tSfRg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH nf-next v2 0/4] Add IP6IP6 flowtable SW acceleration
Date: Tue, 09 Dec 2025 08:35:30 +0100
Message-Id: <20251209-b4-flowtable-offload-ip6ip6-v2-0-44817f1be5c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7Zi2IEVX3sOwKGUKEwklLakaw
 t2tnMDkL/77i/c3iBSYItyKDQIljuznDOpUgB3NPBBynxmUUBephMauQjf512q6idC73E2PvNQ
 52NDVKFu70mgN2bAEcvw+7I8288hx9eFznCX5W//zJokCZUOl6bTTVWPvTwozTWcfBmj3ff8Cl
 Cw27scAAAA=
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
Changes in v2:
- Fix compilation when CONFIG_IPV6 is disabled
- Rely on ipv6_skip_exthdr() in nf_flow_ip6_tunnel_proto() to avoid
  use-after-free issues
- Drop patch 2/5 from v1
- Link to v1: https://lore.kernel.org/r/20251207-b4-flowtable-offload-ip6ip6-v1-0-18e3ab7f748c@kernel.org

---
Lorenzo Bianconi (4):
      netfilter: Introduce tunnel metadata info in nf_flowtable_ctx struct
      netfilter: flowtable: Add IP6IP6 rx sw acceleration
      netfilter: flowtable: Add IP6IP6 tx sw acceleration
      selftests: netfilter: nft_flowtable.sh: Add IP6IP6 flowtable selftest

 net/ipv6/ip6_tunnel.c                              |  27 +++
 net/netfilter/nf_flow_table_ip.c                   | 229 ++++++++++++++++++---
 .../selftests/net/netfilter/nft_flowtable.sh       |  62 +++++-
 3 files changed, 275 insertions(+), 43 deletions(-)
---
base-commit: f8156ef0fd8232055396ebf1e044fa06fb8bc388
change-id: 20251207-b4-flowtable-offload-ip6ip6-8e9a2c6f3a77

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


