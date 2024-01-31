Return-Path: <linux-kselftest+bounces-3890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7BB844A71
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772C61F2294A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910A93A8ED;
	Wed, 31 Jan 2024 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDJorafb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6095C3A8E7;
	Wed, 31 Jan 2024 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737840; cv=none; b=WPg9c49Xn897uBK6Cwwi3SfpP1suiJIIt40h8Ro4tMkSa9brKL36AZFWfZqDA/0ePih16djm9b0q9bzt17BL9/pe7JoaS2shitDg2mxWAtUQJj23nqluBovrdOZ/VI7CEcR/CX/LkgqX3TDi41IRJvwF2Ye//qd0KlbdO8gXY5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737840; c=relaxed/simple;
	bh=Z8/kvzJbvCuG9qEjRicCOoTj7EKmwo9jSDmS/wWZHfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lm18+CRy/eun2rod6L96bZT0MXzmgdzvCyiPQh5mPFgOMf7ElCSJnRoba9kEce9y2t1M9k6m1QOL1GXCeQWoFCt4gofULINLpZ4lX9BAW3Bay6vNlkk7dK4UG1xpPEDLxnOXs+MgOkHUraKubCCdyeyODoKlT7dEaBHtvKqy4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDJorafb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC61C433B1;
	Wed, 31 Jan 2024 21:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706737839;
	bh=Z8/kvzJbvCuG9qEjRicCOoTj7EKmwo9jSDmS/wWZHfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tDJorafbCR8SbOVcozNiN663s37QZ2Ls0+Z1ccccA5h8ZbqMeVjACBwFoRWJKKVfU
	 Vie4dHWUjbhO4BFXvaWJtGfebUknOQqhWvEynqhDjegPCMSWxEDx0KuefOkbcI0UY/
	 uxq/UppXRHR0X2nIJHiVbfQ8YF89nvQdsYYzXaowvL5fkFPA/SONMTKpSDmImC6eSi
	 aFkSqj9i/3mAywC45c8fGH4vXEeiIwHBCHEt09yYFqR79KqYXBbkJ+MrPPwaf8+F/L
	 Vvk1h6yMZomf2HCf9ZeTzmncI57kVj2IznNGylDmG4U2ydQlc3vuq+2hHs9qFFHP0L
	 uOe8HcGmbEtnA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 22:49:49 +0100
Subject: [PATCH net 4/9] selftests: mptcp: add missing kconfig for NF
 Mangle
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-4-4c1c11e571ff@kernel.org>
References: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
In-Reply-To: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Z8/kvzJbvCuG9qEjRicCOoTj7EKmwo9jSDmS/wWZHfY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlusCgnNfSay7SQt5u2G/+Ag2Lk7XKuv5fkayXQ
 Vnq2AKewOqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbrAoAAKCRD2t4JPQmmg
 c47yD/0RC/D4Z//g8CVx4Xh4usF0W6G9dauqV/JgsFco0gYUl+SkJSYf0NCvQIh/reTofOyxeni
 ivYhTzjSaqm5icVRaMWHeyNznFKFH1KXiQS4wiCzkNk5f5evcwLoCqjPDJ2ZRk8EmDXh5nl06TB
 oH/y8SkTAaZyCN1gIDgH7AE3zwewEd0ulAdI2qXCHb0h34szWgCNKTKfSmfV0ylnigYQsxE6oB8
 PnHUsXYzrST9dhhM5DQk8gUc5zlqx0ebVr8eORNjvDdcdUpjqVOaaOlVy/lbr3xp8Pc/exGJ1Op
 PN8CDXP3Ah1KWwLYW0NpfWAklFCiiUf+9wC58gCDDlnSQKII1QsLwEO2fTluOi6dPvS9nWb855q
 VtbUAgXtsGqLQNgLRT/S0/geIvcrjm9kTZWpn8rDWGSiNhWD+mcpsoMSO4mMj0g88AyducJUr9l
 TUAdv00yZ656EAx+WdAb2ZoYHoLQr2Jhucshva40XBOnymztBrxyJCjck3uyuAOD+ncmgVxmoLV
 PQG5356X6Z7zBMretptWutRKohwULo4b2/uEZHt43ShaXcvIeu9QcnpBVlwnuBBf1Aphu99s6aS
 BGhTwN5asB56NrN2hXGTsPIGsCtEPbxgPqu4YHeOwamRCClsuzOhSI84dC0HxQvwVFEoldp+ay0
 oe/b2MUMik5BBMA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since the commit mentioned below, 'mptcp_join' selftests is using
IPTables to add rules to the Mangle table, only in IPv4.

This KConfig is usually enabled by default in many defconfig, but we
recently noticed that some CI were running our selftests without them
enabled.

Fixes: b6e074e171bc ("selftests: mptcp: add infinite map testcase")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 26fe466f803d..4f80014cae49 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -23,6 +23,7 @@ CONFIG_NFT_SOCKET=m
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IP6_NF_FILTER=m

-- 
2.43.0


