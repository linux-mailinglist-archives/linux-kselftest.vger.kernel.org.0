Return-Path: <linux-kselftest+bounces-35967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BCFAEB7FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 14:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4177A6BF9
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9641A29C33C;
	Fri, 27 Jun 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8yiGaRb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D51C7005;
	Fri, 27 Jun 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751028350; cv=none; b=F2oypCgff29vJmUtVi4gNpIjtQi4Z0KianVkhjCjyG0EaIy+E9BvNTxkP33i/hjd19YAdEEMnfcJeUX0xcZfhJKvKULonioBQKYKoJmJUMuLA1I7/J6Z1s7oCDWP/pWXiX7I1IQFDgVxcw9MJl9d27hIs/bAziw5Grd3q3/96RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751028350; c=relaxed/simple;
	bh=CDH1XgxWC08ISud9zCqQ4nm3JL874WqzOudJDF1oB3A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PijIgud1erKwAlqhQX7uUrx4dB5P/WNIMXRGknqBFw7Q3XBy3MMW65ezXoZQLREyxEhGRXhhBoCzRB69StP9ufFEz7Z05eekRheV+hMxUMCKKAKnV66ES7OAAh1aloFENLBugk8bRGUEsO4R7GpKBd4+EoC3+mNOwK1DFzGW144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8yiGaRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74959C4CEF0;
	Fri, 27 Jun 2025 12:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751028350;
	bh=CDH1XgxWC08ISud9zCqQ4nm3JL874WqzOudJDF1oB3A=;
	h=From:Subject:Date:To:Cc:From;
	b=P8yiGaRbpDkIa3wD1+x3T0UXUcXO0zIHIi+k78xnfigdC/zEakXc9ZndOSFt8F+JT
	 aI5nJAjgTyRvUA90n8ZBNjMsiLE0lHDPVHdlAnfIFh9lgHq+2nRsJ/AzFLqzXGRxd6
	 opgGVsz2aMjdZ3FLP+l7VQN2cKPPfvHv3fQXH4CxZM6LHVmd7sPZ1khhTL29izd0ER
	 riI/thVpswyufmZ6TKqNlOB7c55v1fJYK730AuFGHQ4D7rvAWWTvtB50sW+e2ruzZ1
	 dYF+/sFHHGu+f/5nvsiD9TzNe0sIsEW5jLB/tve62noCzjL68auXIMg/apEHan5TRH
	 zptYvUmDKJb7A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v2 0/2] Add IPIP flowtable SW acceleratio
Date: Fri, 27 Jun 2025 14:45:27 +0200
Message-Id: <20250627-nf-flowtable-ipip-v2-0-c713003ce75b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGeSXmgC/32NTQ6CMBSEr0Le2pr+SAFX3sOwAPsKLzYtaQlqS
 O9u5QAuv5nMNzskjIQJrtUOETdKFHwBeargMQ9+QkamMEgua66lYt4y68JrHUZXuoUWJkZlmpG
 3husGym6JaOl9OO994ZnSGuLnuNjEL/1n2wQTTLa1qjuNqruI2xOjR3cOcYI+5/wFhwPSJ7MAA
 AA=
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
Changes in v2:
- Introduce IPIP flowtable selftest
- Link to v1: https://lore.kernel.org/r/20250623-nf-flowtable-ipip-v1-1-2853596e3941@kernel.org

---
Lorenzo Bianconi (2):
      net: netfilter: Add IPIP flowtable SW acceleration
      selftests: netfilter: nft_flowtable.sh: Add IPIP flowtable selftest

 net/ipv4/ipip.c                                    | 21 ++++++++++++
 net/netfilter/nf_flow_table_ip.c                   | 28 +++++++++++++--
 .../selftests/net/netfilter/nft_flowtable.sh       | 40 ++++++++++++++++++++++
 3 files changed, 87 insertions(+), 2 deletions(-)
---
base-commit: 8efa26fcbf8a7f783fd1ce7dd2a409e9b7758df0
change-id: 20250623-nf-flowtable-ipip-1b3d7b08d067

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


