Return-Path: <linux-kselftest+bounces-3888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF37C844A68
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3701F21FC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69F73A1BD;
	Wed, 31 Jan 2024 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrzwWars"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC23A1B2;
	Wed, 31 Jan 2024 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737833; cv=none; b=S4rKj4t8aKLo6ZzmMaAXLsz2cXnpUDUo1QTGyPfs9a/x3EY7kTcvSrtsto+JOecSbgK1QQ+og/kqbOVfwJa2DYscRxVAcd1/7j4ywgmcempDtsY9z10SpapArPuvzJmc0a7M8pDAD5FZx9y7uAX6V1dQ9a9nVuCbHnqEpAyCRjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737833; c=relaxed/simple;
	bh=XtVWm04dD3trcfcXrZCW+EahXoWD6xB/KmZ/5O9BeGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKEo3vCX0GR8vLWu0ixBcTMmtKTLzLS9WJ+6RQXX5GaWHpw7O8n71diHm23nU/BR+K3Enyk2OXXT26sMSbZlVCjDuwHXIwuRDt79eSsDb/r6qCYywjS1w3w8unmM1BewGqCOup1i3Yc1kpFATMoaMnqZ38fnYnoD2Ro5q8xbvbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrzwWars; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCACBC43390;
	Wed, 31 Jan 2024 21:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706737833;
	bh=XtVWm04dD3trcfcXrZCW+EahXoWD6xB/KmZ/5O9BeGo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RrzwWarsVKbXtbdP2GZGwqLlu4JRifG9DMttLebQQmkQwYobVwnCMk6isNehHENDj
	 utguGtso3jUpdeBNy1tlwPjQ76f3CVaYmhg5Ih1d0JKQjbA6jfBrX3ULdRL069Cywl
	 6KwZ7H4iXenz5YiYgtsS/YThHPtNL5dpz4W03+YjrR8H2UAQ3F99Z+VLwBk5Tqe6cg
	 zUMyfvf/SDn9nYM1VJChsjYccHvqKMAeFEDlpfgfpcgteJaRYJfbzEQy+HQkCRcmsy
	 BlLulbgblebvAeF8BwISSobzbc2E+f0BxmZRECt6B/Zqf6Uz+lIXS3fDNHB7TNuC39
	 T9202h4F94UXQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 22:49:47 +0100
Subject: [PATCH net 2/9] selftests: mptcp: add missing kconfig for NF
 Filter
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-2-4c1c11e571ff@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XtVWm04dD3trcfcXrZCW+EahXoWD6xB/KmZ/5O9BeGo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlusCfR91P9nAQ38Sl1t10dxK3kmfU/p9Ghx5Go
 wEZTm/qIxqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbrAnwAKCRD2t4JPQmmg
 c+qoD/wJJm8koI9Wmjf719rEoqiouQUOmms/02+JCPoL/KNOscatjiH9MIkHJbqxoHwpFgqR2ZA
 C5ojUygqzkYdanPElHDPcPVg7g6TCy/YEVSyfZeILHq5s9Z17uRXwrvgBSfXRaHVAEPO0aS0cQA
 4yawb7yU0wzKzLJaJzh4nMtRCG6tM+X7H8H78YOXWmTjGjdfdJG1mxMD7/C1oDAZqUuDnRcbXzF
 2ym1ObqHf3Pq0TwFlGwxfdKAL1Nwj5JumeHy2YMPEUl5zz6q3WzgfcFb8eAkTBjkHgzCCLP525d
 4Lv7rHN7xHVYvuW2x6nNDfcUADVT6wahFgMXYotdmlOh1FFtk8m82/aGoIf6XvayG4Mtgu3P3wb
 cHhD6vOaSLhkSfrVqPTeyETVxteoDVEdYTozhCQPGoHjDa5QcT4zJ8Ydi1hPabDxch/Kg9iwFfj
 BseEyRORU57w9HZiOec8pt177zSG9Yko+1pXAXtkfh0LV9OZ06b8kOf5DjXe4pTovigDn5K/N0u
 nCTq5SE8EYmr4FmSuFQGQs0cPIz0zCY4b8tyHQzw8GjzTdSgRrsdq0UZfdML+9pKhrv5MI4FO8w
 dWXlLTAHEp+rUz4xxduvIqFJUHUHoe6zUpQMCeNx892s6muD3YY9oA5SwV7oySe1I389H9IxK85
 MHd1kq/v/shXyGA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since the commit mentioned below, 'mptcp_join' selftests is using
IPTables to add rules to the Filter table.

It is then required to have IP_NF_FILTER KConfig.

This KConfig is usually enabled by default in many defconfig, but we
recently noticed that some CI were running our selftests without them
enabled.

Fixes: 8d014eaa9254 ("selftests: mptcp: add ADD_ADDR timeout test case")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index e317c2e44dae..2a00bf4acdfa 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -22,6 +22,7 @@ CONFIG_NFT_TPROXY=m
 CONFIG_NFT_SOCKET=m
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_NET_ACT_CSUM=m

-- 
2.43.0


