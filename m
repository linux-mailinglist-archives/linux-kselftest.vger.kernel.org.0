Return-Path: <linux-kselftest+bounces-4802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 515CC856C8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F065F1F22000
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62431420C8;
	Thu, 15 Feb 2024 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Al7QWs9T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C2D1420A8;
	Thu, 15 Feb 2024 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021564; cv=none; b=VgtOka0G0C49HFlgzcr87Fs7k3OJpDZnRf6weOQ2tTxIm/5pYvRfRWEUV85Dt85z/sktGN4r6avSU/X6VY/PDteh+FRy9ascGhgs35Qpezxn3HmZmrmZ6rLrpjcXYMQAEv8VZ9cVg/E+5PIgDtqTSdlhusNaH2PrB0ubPnJQm88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021564; c=relaxed/simple;
	bh=w1Rh8ZunC8Bdt6wf4+VcdM9FXwQfuyyU9C0fs8jsrt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UG6hylZR0Cgj0XWMXMjSqFqE806EI5WQGO4+kmFz75rBf/u0dTf1iU6LWqW+8cPZmvBB5oYZfvbkQwDeZQiv6VucL2kViU3z7iSdW+NYqsZY8nmwwZ13X+h6JkW6tf1280IJJlEOSQz4yT8T7hTg+mFSi4b3qXXubM9/cuA/CNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Al7QWs9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC06C433A6;
	Thu, 15 Feb 2024 18:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708021563;
	bh=w1Rh8ZunC8Bdt6wf4+VcdM9FXwQfuyyU9C0fs8jsrt8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Al7QWs9T/G69kjvm27o1VMMXzP7FweGoKwWD30cvL0PQ5vODjxA7m5f09CuWkB+iA
	 7p2nojtejPkDbPMbuIn4aIyV6biRxay+co1pfaGMYwqz1VC37UN7yRFSYcwJR5UxxP
	 DbrHVph2017j3yTm3oUmd+zPYWZj88NF2rJSuTMsSO/k1EUxPS0Z2A6YI2LfjKvUTN
	 EgK9aJfLANIICrkayxopDau3c8aXpAClsnz39yPCVxkGcXasCw8x1buaS+L9Ao0dqw
	 dSNYAwqoJNZpsmZd0fvN+v7DedM83zwtesLLOcuP91R/yoTmBHB2i3AsChn45VRysn
	 ZNYh6kG3OpMYw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 19:25:35 +0100
Subject: [PATCH net 08/13] selftests: mptcp: pm nl: avoid error msg on
 older kernels
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-upstream-net-20240215-misc-fixes-v1-8-8c01a55d8f6a@kernel.org>
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
In-Reply-To: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1510; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=w1Rh8ZunC8Bdt6wf4+VcdM9FXwQfuyyU9C0fs8jsrt8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzlcdQJc88jVZfNYZ3LyirBDc4yQQVoMYgoC9P
 97Rdj41/QWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc5XHQAKCRD2t4JPQmmg
 czaDEADi6qZJ+L+5bbEoki4/EDqyazx9R6y7ZQqN03HsAPONCrWBnnRaG3buFlHKFbbcJalLLpA
 xAg2LEXAby0+OJYn0b5Hr+YxsriSdlyxshUfotRDb5cKD0ZiYEozAPjTqZPmhzbegP4rKVZRsWs
 gqQmPzD5UrExnsIe9izF7ywtk7uTQsVpQQLwvdhsNE/PKr3RDZgM9M3/L5ZB5zBL0W5/7s/8Kwc
 hDGv8lSAawO+XovcuW8Jp0WPLUGZ8OlGuUdMAEyW9ep7LSQVlGVkFmZP/DrV4aTqXgmAj66Sv3N
 +k8uqNjuxfL5aUbBhFoCsEb/i7NL7DKzKG9gew2b8GRNNruo4wZg8KE95yiI/UPN5xIP2/XnPJB
 H9gfmpUWhtsDQzowt/rRI4a01pp6isrCIBAvxkWAVGhP/mPqym71vrtY/p1gxPIZJj657JSV5QD
 tb3agLRIXZiXfbBp63bGWWN5OHRDmPlaAEk4YmL+aP1RhHGdI3um6htzLA6VXBDJqHjFnYFrzaR
 ktXQ0+1o4WnfU3DpvmZyDpLRoQ2lanwaEkCbHjMo3H8rdRCB+hLVllHaRCOdxXBwhN8zDp8vTHH
 s1x8b97dmCu1p5oASEQH811RZIhgiDpZQbpoCXu/udaQ3iDdcyNMR6+CfiOqjnaspURgk3GNZc6
 5MzuIGo4XVFcuKg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since the 'Fixes' commit mentioned below, and if the kernel being tested
doesn't support the 'fullmesh' flag, this error will be printed:

  netlink error -22 (Invalid argument)
  ./pm_nl_ctl: bailing out due to netlink error[s]

But that can be normal if the kernel doesn't support the feature, no
need to print this worrying error message while everything else looks
OK. So we can mute stderr. Failures will still be detected if any.

Fixes: 1dc88d241f92 ("selftests: mptcp: pm_nl_ctl: always look for errors")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 79e83a2c95de..71899a3ffa7a 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -183,7 +183,7 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow 10.0.1.1" "          (nobackup)"
 
 # fullmesh support has been added later
-ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh
+ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh 2>/dev/null
 if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
    mptcp_lib_expect_all_features; then
 	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \

-- 
2.43.0


