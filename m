Return-Path: <linux-kselftest+bounces-36434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AA2AF7711
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4EA1887323
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C962E7F0E;
	Thu,  3 Jul 2025 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk7U+xLi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943BE2E6D25;
	Thu,  3 Jul 2025 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552210; cv=none; b=EC+fD9i7FxvuLpRrNOoesn2aMzn6lZcqnI6JfRSTWekEtl1v7IgIstonB4FGyiKI+RGNA31hyfjbno/P/4+2s/GbFui8mzOazbXD7PcvaoBXUiPUK6IZ3h4nwLT3JoxQ4F/ypdOimkSHG+dYTjTdLau9pvhZw6wfMAFWKS/t/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552210; c=relaxed/simple;
	bh=wXouOklJeBivQWdES6pjn3jOZtbrOCwxeeLmtYfMl8Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f6gH+qQsFaTxifrAYML3mbtBX5OiM6B1RY81UuYXJmGTkMqKHkbaSzY5rktIvlLcKz5pnC8BaZJo5pvVF9ca6HtF9NI4fWM4vecuhyR6Grq5g2vQxP3RL2TzL6Uf0fXUNpHXBTdzGLEkDy6olJgqxZl2wJiHT6aGJBsJGM0e0Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk7U+xLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17D6C4CEED;
	Thu,  3 Jul 2025 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751552210;
	bh=wXouOklJeBivQWdES6pjn3jOZtbrOCwxeeLmtYfMl8Y=;
	h=From:Subject:Date:To:Cc:From;
	b=Rk7U+xLitFLACPo3XjuMn6GsN1VYTLstnShTzRqMqCsuoZ4Ca/WRz/jYSd5mOnvpa
	 y7WnDRophJwcvtfaVlxHoLmCrxOSkWBa7pnIXjVVYBY6mMOac+1RIDZfGfjaeqKcGT
	 kKpPWRs03SC75JLma6VT6ox63UF0QGX7u3mtPZi7tRnb6nZHODxnW8vCvnylVlvJhf
	 0JdvWxc7svWBSPZRZBFJ8ubrXqhZNE766wUas0gOlpJ1mqjqhN8OOpYuHPP8VKDUcA
	 Vh1f8i8afRVILHOUs7SPYA3Rt8xvv/LsHcm5lsD/pnucOdMmUZtsxtCotqTz/vkabV
	 m9HO+yaNmbHQQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH nf-next v3 0/2] Add IPIP flowtable SW acceleratio
Date: Thu, 03 Jul 2025 16:16:01 +0200
Message-Id: <20250703-nf-flowtable-ipip-v3-0-880afd319b9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKGQZmgC/33NTQ6CMBAF4KuYWTumP0LBlfcwLigM0Eha0pKKI
 dzdpitNjMuXN++bDQJ5QwEuhw08RROMsynI4wHasbEDoelSBsFEwUoh0fbYT+65NHpK3Wxm5Fp
 2SrOqY6WCtJs99WbN5g3SuaV1gXsqRhMW51/5V+S5/sNGjhxFVciiLknWZ359kLc0nZwfMhfFJ
 6F+EQIZtopLxmRLqtBfxL7vb46ffSD/AAAA
X-Change-ID: 20250623-nf-flowtable-ipip-1b3d7b08d067
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
infrastructure.

---
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

 net/ipv4/ipip.c                                    | 21 ++++++++++++
 net/netfilter/nf_flow_table_ip.c                   | 34 ++++++++++++++++--
 .../selftests/net/netfilter/nft_flowtable.sh       | 40 ++++++++++++++++++++++
 3 files changed, 93 insertions(+), 2 deletions(-)
---
base-commit: 8b98f34ce1d8c520403362cb785231f9898eb3ff
change-id: 20250623-nf-flowtable-ipip-1b3d7b08d067

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


