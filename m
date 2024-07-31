Return-Path: <linux-kselftest+bounces-14537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD9B942CDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 13:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCA01C20B84
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 11:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AB21B29BF;
	Wed, 31 Jul 2024 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkTlhcE8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32DF1B29B5;
	Wed, 31 Jul 2024 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423995; cv=none; b=dEjSyXNjYd69nYSqM4DCdsvW6P5cVGqnbzf9rr99V+ByFXezKIYTEu9PcTGN75rsvN0iVprKuvX23BVHB/layRYwIn3kPcnVpl06/aAF7FM79LFAl9vqQOipEZ7yrlK8eMWLQWCcPZ69+AgFIwOYiL4VLULDdyT271tya9ZiifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423995; c=relaxed/simple;
	bh=857ubTu1shYtmLjo2dTYUYNkByMNASD2Yszupp1zLtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OWN3qfmThDHMvEP06vlcKaD8o7/x50JQifBA2NHfE91LOcGywm0X3l8Aph908wkSupqc3UvgtiErLKYvKgznPSZsUf3VYreytZI/qqDhfAoVPB/nUWUhVfbir9YXReoga30pu8hyme0wXqFoTdmeVEETQI81930uc/lKar1bNMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkTlhcE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDE1C4AF10;
	Wed, 31 Jul 2024 11:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423995;
	bh=857ubTu1shYtmLjo2dTYUYNkByMNASD2Yszupp1zLtI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SkTlhcE8fKoAOLEqqIdu/AH9Gkw1KFIPo2QV3RrFyoBrwiVztTtIF6kkF/UlGw+vk
	 K7yYw4C7N7x38HPi2/xliQnLCyNb1f2lXJiCJfIXTGc34LwlGSgn005O/v1EdbEzQ5
	 Hnoch1dpcfRXE9sbQwcU7rQv5JicFOzhugNCuWqCYV/lMRESnRmh6AnRgsacAj/gfx
	 S82tdH+cYpROSOinIoIIEmESsMwIz7LY4163WhecPaYd8VBDQjgM9JZ+m1106AH48J
	 jUNYmB9stmE/q1svzoVssRrs/L7i99yvVip0t1iRLuafS/G7r2oVmgDQYZeHQNM2+B
	 uy4KcAdw5pazg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jul 2024 13:05:59 +0200
Subject: [PATCH net 7/7] selftests: mptcp: join: test both signal & subflow
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-7-c8a9b036493b@kernel.org>
References: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-0-c8a9b036493b@kernel.org>
In-Reply-To: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-0-c8a9b036493b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=857ubTu1shYtmLjo2dTYUYNkByMNASD2Yszupp1zLtI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmqhqixPXnJibSbhI8FfcWQqKkInBror+Nt4EPo
 SmDkR4qqw+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqoaogAKCRD2t4JPQmmg
 c8D9D/0ZDdboR90bcV5gh2Otr9rWdMbBX45B3y8vyw4qj3jTX7PhgRlw7nsuPHfN7gh1J0oRoGH
 EqMV2vFKkD9KKfRMspQnVvngda9O3CQHLMT9auMgRDc46bN+m1ZFjudj78glhUgAzlCMhRdCMC0
 May+5GnrhsWwDZDOUhuuDnVrxu31//yQNJ7OfNQtKZvbm8CO3hSV6/CT0ZD/xZ2StiWPS1jK41k
 V4dBqTycQdh06UtUJydzXQSztfigAeblzhElpCtIrslahTrQfWCvMpeU9HodZQOcVsp+aexb+iZ
 /BTgAOrlKwCibf3labEwnXzuW1EynNrCsYTN+wSWN0EXiXAdTj/eue4IE7NNrilxYn1c5CoLDXF
 pOvMSuADvo1gb+yBj+AQ1DiG48DjWW86I7fUygOi11HOMz+exc8MISKQvwk7xmacYpeS4jGy5uL
 YMk+bFuigKSe1Jj4I1/bbVJQqVOIUtMRSw7TP5Jy5qJ/ixJ+0Q1UjTQdpQtDw9sdtjch277xC1b
 XtK/5UsZCeuIriq/zBWnLqP0anPERG0a/0ltQlGmULkXSPsrCvhRxybqdfBKM9g3Vv5buJOXRHK
 pcYO2+MJrQgVdu6lkyq2B7fDPeQUKHkwHKJ/GNq/5cCZjx8guzSXeIreDVq2EpdEI1zz0m9gIXI
 8Y/wgkHLfXyi41g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It should be quite uncommon to set both the subflow and the signal
flags: the initiator of the connection is typically the one creating new
subflows, not the other peer, then no need to announce additional local
addresses, and use it to create subflows.

But some people might be confused about the flags, and set both "just to
be sure at least the right one is set". To verify the previous fix, and
avoid future regressions, this specific case is now validated: the
client announces a new address, and initiates a new subflow from the
same address.

While working on this, another bug has been noticed, where the client
reset the new subflow because an ADD_ADDR echo got received as the 3rd
ACK: this new test also explicitly checks that no RST have been sent by
the client and server.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 52a25ac43d10..9ea6d698e9d3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1989,6 +1989,21 @@ signal_address_tests()
 		chk_add_nr 1 1
 	fi
 
+	# uncommon: subflow and signal flags on the same endpoint
+	# or because the user wrongly picked both, but still expects the client
+	# to create additional subflows
+	if reset "subflow and signal together"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags signal,subflow
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1 0 invert  # only initiated by ns2
+		chk_add_nr 0 0 0         # none initiated by ns1
+		chk_rst_nr 0 0 invert    # no RST sent by the client
+		chk_rst_nr 0 0           # no RST sent by the server
+	fi
+
 	# accept and use add_addr with additional subflows
 	if reset "multiple subflows and signal"; then
 		pm_nl_set_limits $ns1 0 3

-- 
2.45.2


