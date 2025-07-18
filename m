Return-Path: <linux-kselftest+bounces-37554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A19FB0A0B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 12:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B027E1C4775A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 10:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0869F29E11F;
	Fri, 18 Jul 2025 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYLs+eLC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF0D198A2F;
	Fri, 18 Jul 2025 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834691; cv=none; b=Kd7JzStqfAsCNpTESbQgKWBwPLYDCYN6qg1c3o/j3SW6w+A/GIMrZOQhC400c9+tpD8EXpHUIG2P1FLhwJviz2emzJcNiy48pziFoulbefQEpUYEVinqx8iLjnjn1DlqPjlQv8FH/W0BlJZqB8Ime0gqkbw10Lq38+DWh/fms8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834691; c=relaxed/simple;
	bh=hVDik0aO2D/9ARMeo1iKVH+iniYJyotZAtjX3iwL624=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qujus0bZ8Ap1akXFVSZ6DW6yKSPpw5M7ZVCgr5JbZGVckMgh33j9tJyx++mmyBbaajqYl2Dy5/MsWVS3w9bAj4sxuNpYZNKS1U+ShOkxOT/HpSwZ8MZvmWYbH4gJfjZsRXDQ4U1LU5D0OOCCryhiAL8aIWDxLk1mUiJgCVRbtfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYLs+eLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173C2C4CEEB;
	Fri, 18 Jul 2025 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752834691;
	bh=hVDik0aO2D/9ARMeo1iKVH+iniYJyotZAtjX3iwL624=;
	h=From:Subject:Date:To:Cc:From;
	b=PYLs+eLCC3C5ap257Bcfw6D5i0PnrJmWlCCepf+26QHQtbt+KafIMPh3433C7ngJk
	 7MX2Zw2WBliNhuXwDQ44N+bcodBbBGQDUd093FJ9eMSXA8K8IPpEMDkUEeoK/Plml9
	 FTMC4eaoPcbwQwX3ZdNmsoHEr3Qw3DenYZU0UbBLjnXl+YtryrqqhvXeK8+fGh8ElX
	 pp+RwdZEKaj610GxVTthFRITgIl42dEVGb3KTvCzqOlVY8dogoi2mt8lO8tEi2e00p
	 qyqRq0HksJI41GlwnULOHPva16U2w5ZjT9RtLEjHDM4xgZ9s5nYjFNzqNhIj0ZuCpi
	 fdeP6YK+wIwdQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH nf-next v4 0/2] Add IPIP flowtable SW acceleratio
Date: Fri, 18 Jul 2025 12:31:05 +0200
Message-Id: <20250718-nf-flowtable-ipip-v4-0-f8bb1c18b986@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGkiemgC/33OwQ6CMAwG4FcxOzvTrYyBJ9/DeGDQwSIZZBDEE
 N7dhYsaicc/f/u1CxsoOBrY+bCwQJMbXOdjSI4HVjaFr4m7KmYmQSpIJXJvuW27x1iYNna967k
 wWGkDWQWpZnGvD2TdvJlXFsc9zSO7xaJxw9iF53ZrElv9h50EF1xmClWeEuaJuNwpeGpPXag3b
 pKfhN4jJAdeaoEAWJJW5ofAN6Fh9wuMRJZBYSsUucntF7Gu6wuuCDpmQgEAAA==
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
 net/ipv4/ipip.c                                    | 25 +++++++++++
 net/netfilter/nf_flow_table_ip.c                   | 48 +++++++++++++++++++++-
 net/netfilter/nft_flow_offload.c                   |  1 +
 .../selftests/net/netfilter/nft_flowtable.sh       | 40 ++++++++++++++++++
 5 files changed, 113 insertions(+), 2 deletions(-)
---
base-commit: d61f6cb6f6ef3c70d2ccc0d9c85c508cb8017da9
change-id: 20250623-nf-flowtable-ipip-1b3d7b08d067

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


