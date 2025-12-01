Return-Path: <linux-kselftest+bounces-46803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76422C97B61
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 14:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22093347CD7
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 13:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77703148A7;
	Mon,  1 Dec 2025 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOrWo9IJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AA972639;
	Mon,  1 Dec 2025 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596736; cv=none; b=P68H2DTOJeqtgAVYtQT1OavLdmcg+i504fpY+FVZPk+M+JtFstE2caXWk2UctME5cl+t1eRbG5vihYSd2PsWIUdoeG9ap/P01ReZtWOgBr5A9lf3r7WZRgpj0cKq63ktvO6HBf8gL9q8rHO1kfSgmBo9ox3KezBWclGM/U1tohI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596736; c=relaxed/simple;
	bh=N9MUCTaemGf7+uVYHLi0WhukbGT11K7J/3L6Cv+wswE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lPFM3cH5oIsBjKhBwzMyoKO+hiKuz0Q6iTdnrZPI1EfJICERJFDGnvO2FSRQH3bnLlYlHbivcTiytOuYSnGT4w3z7Ob8PkIplsKtE/DsMIRfwAre3JRMis8XEjlrFlev6SwjE1CQW1GFmUGFsjwtjagqxqpWyQYz6QyIt4cClxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOrWo9IJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA0BC4CEF1;
	Mon,  1 Dec 2025 13:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764596736;
	bh=N9MUCTaemGf7+uVYHLi0WhukbGT11K7J/3L6Cv+wswE=;
	h=From:Subject:Date:To:Cc:From;
	b=sOrWo9IJ9c6/4ospZKg4niu7jwb1bNjr1hRpO5Jm4uydHxTQZjm4Djm4Fl+4FPY8u
	 Dx2Ix1H2c3axvKEKK+UWUd09hmAMFbcrbazAXKAmxBrlKBGUcz+zUJubTT0D3HmhqD
	 9iKCg3hUMibH7YHr4nMo8U8T901l1GXr64u8aHHdWpdWTXN3EGDzhTgWYJL0psYhnx
	 8Ix2DHdOSPWAwoBREQmFD89d3pEdtemwPYpS1XFmak815Fcl2dmnIR7nGYMdeDUKMC
	 l82voU0BI0oG2HTmbcZ6Ro/am45MmloKpgsT9lSl0vRZZU8VzXYdMY3+dRtP1wZGKl
	 SlFd0m1rOkptQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH RFC nf-next 0/4] Add IP6IP6 flowtable SW acceleration
Date: Mon, 01 Dec 2025 14:45:12 +0100
Message-Id: <20251201-flowtable-offload-ip6ip6-v1-0-1dabf534c074@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqDMBBFrxJm3YEkaJRuCz2AW+ki1okOSCKJq
 CDevUPhLf5b/HdBocxU4KkuyLRz4RRFzEPBd/ZxIuRRHKy2tbHaYFjSsflhIUxBth+RVydg3bS
 DM9o1rmpB7mumwOc/3UP3fqkYMNK5wee+f4gqPvp3AAAA
X-Change-ID: 20251201-flowtable-offload-ip6ip6-578b61067648
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
Lorenzo Bianconi (4):
      netfilter: Introduce tunnel metadata info in nf_flowtable_ctx struct
      netfilter: flowtable: Add IP6IP6 rx sw acceleration
      netfilter: flowtable: Add IP6IP6 tx sw acceleration
      selftests: netfilter: nft_flowtable.sh: Add IP6IP6 flowtable selftest

 net/ipv6/ip6_tunnel.c                              |  27 +++
 net/netfilter/nf_flow_table_ip.c                   | 239 ++++++++++++++++++---
 .../selftests/net/netfilter/nft_flowtable.sh       |  62 +++++-
 3 files changed, 285 insertions(+), 43 deletions(-)
---
base-commit: 0177f0f07886e54e12c6f18fa58f63e63ddd3c58
change-id: 20251201-flowtable-offload-ip6ip6-578b61067648

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


