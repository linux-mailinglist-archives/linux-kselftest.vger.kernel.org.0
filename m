Return-Path: <linux-kselftest+bounces-3636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C383E325
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 21:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254231F25C7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1A522EE6;
	Fri, 26 Jan 2024 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLWcnnbV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE459241E5;
	Fri, 26 Jan 2024 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299992; cv=none; b=gl31gyej5QBJmKBAuZ7wJjF+g4uoo6IzcgY5DTTxvpNMfi/Q02eLAOt3dmarEncyxiBTl1SM5XvJ09he4JZvoacy0XFC1houo2caBGtJm+InrNK4xf/RSRHinMhVhQHB5ClhHiBr3be78LAk86ioL7R4ch6ICtWUt1CIaU4c+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299992; c=relaxed/simple;
	bh=nnxJtw6vUHGJJzShkWxwxq1ocDh53plzlcVa4ZjisC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOSIA9U6VXLln28Yl+1KdtwbHhtZkGiBTzBG732lmjdybltW3d24SEK3MuqS6iPWx+ymCDj2ycA2rb9HVOEaYil5poDyBFixg01516fb5Umbb0L0huz8nmG6AvEZVBKlgH3/j/RFpqk+wav5Ug0YlD57gcqT2i7PBCMF+HbA/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLWcnnbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5F0C433F1;
	Fri, 26 Jan 2024 20:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706299992;
	bh=nnxJtw6vUHGJJzShkWxwxq1ocDh53plzlcVa4ZjisC8=;
	h=From:To:Cc:Subject:Date:From;
	b=iLWcnnbVSTPt+/cpE1fW/hAT/egcyGCFLEewNYvX7QqJzsTlo+3yL5uSPuwxTRaYW
	 cDtqXblDgKnGugr3FfoRa60HazZEpZ+UmM1SO01XSQtk2617Vz9erOxTUQbejhBBvm
	 X7ctZv9O9PNNQvxWBWFI5zbk2vcoO9cwHiXRZsKjd1iJ2ceos4GnaV3f5eoI+2gcb/
	 p0n0pvzvPYJ6IqSDE2sDKz8bN4N7GPFjK7GSv9TE4RZrJ6krHuytOxYfrLIskU8Pkx
	 DFyFeNzZ+FPq2p2Jw2pMTfKpjBHSs3QlYQVb0CXTfmH2DfKiJTCjZlJpKz5Pta/nIY
	 M1vBa+owwaezw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: add missing config for nftables-backed iptables
Date: Fri, 26 Jan 2024 12:13:08 -0800
Message-ID: <20240126201308.2903602-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modern OSes use iptables implementation with nf_tables as a backend,
e.g.:

$ iptables -V
iptables v1.8.8 (nf_tables)

Pablo points out that we need CONFIG_NFT_COMPAT to make that work,
otherwise we see a lot of:

  Warning: Extension DNAT revision 0 not supported, missing kernel module?

with DNAT being just an example here, other modules we need
include udp, TTL, length etc.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Location for new entry chosen based on `sort --version-sort`.

CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 413ab9abcf1b..ba56f231e109 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -59,6 +59,7 @@ CONFIG_NET_SCH_HTB=m
 CONFIG_NET_SCH_FQ=m
 CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_NETEM=y
+CONFIG_NFT_COMPAT=m
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_PSAMPLE=m
 CONFIG_TCP_MD5SIG=y
-- 
2.43.0


