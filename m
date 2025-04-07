Return-Path: <linux-kselftest+bounces-30274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CEFA7EBCD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B673F189B6CD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B96C2222B9;
	Mon,  7 Apr 2025 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu8+zKYb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650C0219A8F;
	Mon,  7 Apr 2025 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050404; cv=none; b=EmRw+Hca27DbgWQOvADPts20tPR3sYVNGPvaXQ/i6pEwNxo4Km56XDImj208Fs69DaEs+HjtH33fqKfT+EouqrwNwJ1vktY5bnD4LESeW6wxx+2+TLe363u7QpOTrCx2omI41t6ZQ6IzxcB3eJVoChMIu3r28ZawC78p9rSp/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050404; c=relaxed/simple;
	bh=dvITs+8+VfQd7ubGC+3O47LshSVcktUd+eNuWBPRrWM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QYGxR0XA7nRpgL3QfmtnnhD12AeXZDZLNTrb1xp7/QZD4W0g0CbV3P77t4dIVdNdr/2OlRbbHfBccnocqFYuyCIp7F8GKZcBIv34PN43r+r0uov9CM54IaL0/kFUT42OIixkOO21S9TkrgY54LaKpudtcOSHqriVsOJolLVOw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iu8+zKYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA66C4CEDD;
	Mon,  7 Apr 2025 18:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744050403;
	bh=dvITs+8+VfQd7ubGC+3O47LshSVcktUd+eNuWBPRrWM=;
	h=From:Subject:Date:To:Cc:From;
	b=iu8+zKYb7g2DRMhLLzvlY7bF2gC7UXn0+BMEr9l+6dHwR5u08aIJas7PmJY6fpR5y
	 GnIQuhYze/CFcbRShszeUZju9QxmmSJvy97d2p01TabMlhe1/WyOosymyDFX3e+iwW
	 4Ld2qfAgdFoL14HIGgS+i/gLBmg9VqicDnf2c7HjQJBequhcXo6aLg17IbjxWNoyBI
	 WMf7FI6oBO2ih+NYDppJZ8YRenVTxxVjguaCy4Y+JPOo9sdtUC0E90LSUwqZL83iuH
	 yzoh3nkRiJl/7NLcN7yklQ27KtvOM6YE8uvMzT4exs0cFi/B/J5PtX5TFp7gF6LgmU
	 /ro5jeYnRCMiA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/2] mptcp: only inc MPJoinAckHMacFailure for HMAC
 failures
Date: Mon, 07 Apr 2025 20:26:31 +0200
Message-Id: <20250407-net-mptcp-hmac-failure-mib-v1-0-3c9ecd0a3a50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANcY9GcC/x3MQQqEMAxA0atI1gaqThW9irjo1EQDtpZWZUC8+
 xSXb/H/DYmiUIKhuCHSJUl2n1GVBdjV+IVQ5myoVa3VR3Xo6UAXDhtwdcYiG9nOSOjki23Luu8
 bpZkbyIMQieX3zkfIHUzP8wfMbU0ZcQAAAA==
X-Change-ID: 20250407-net-mptcp-hmac-failure-mib-66f599305ff3
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dvITs+8+VfQd7ubGC+3O47LshSVcktUd+eNuWBPRrWM=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn9BjeC2CovJsWiX12gdjQ0yeoe/ZRLSUUwqIDo
 tw3tFFxxKyJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/QY3gAKCRD2t4JPQmmg
 c1G2EACOt8R1M5fv0ueRRFsZ1ba3L7lqCK/ir+0BKynwB+XmIj2xo33kEUabRaYdsaYaCddLUcW
 iSAQkO7tz8nqOrJuSB61kio3GN7KSvztUmjQ3z7zMP3irTEGNTVuiecKeyFjUMI4J1ANT6DnuK9
 vZYOmPlSlIcxdZnecufCg0ztWzl91lrpgAFsdYeJ3Z+v23faj9l1MtSw4Uqsp/MvJxX5nFHOfH+
 4/TnvZixQrQz1WVjEmYT+/SkmZEY9bB6pDoLWMBmgO6Nv0HExcIPmpNTa80GvwDMMw00ayAH/C3
 ejFKzYS+Lrrxp/TZs+Jq8maU82HPbPcLCl7OB2wMz8vu88HM/+T4dia/0SzVMoTN0sObBvBH0Y5
 2Zeby+8iDcs52jq6FrEDqM0vlGJyLTlYmWC7i0aQvxgPO89ih6CJrYYslzN1K5hh+PTHvXVgKQx
 LhwPpzVpq5cAkAyfNU/1RoCFHdEacEgBQq888HX1lbCY9Q386DKbQLnrrCyopZlH7fun/G3qpId
 bJoDa1P25yzJR0gMKYvudkT046H1DeqSlIPpFY2FhChgvcIFSDY5DJsWUSMaIjzJ3oRke+XayfL
 R915s/b0gqEiSkQlz+gkaxearbTYq1zPP51BAgKbkWnHrrVR88BuTHe9Aokl5omDifXnSMGjqYJ
 WJKnSB2DPSwhfLw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, during a debugging session using local MPTCP connections, I
noticed MPJoinAckHMacFailure was strangely not zero on the server side.

The first patch fixes this issue -- present since v5.9 -- and the second
one validates it in the selftests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      mptcp: only inc MPJoinAckHMacFailure for HMAC failures
      selftests: mptcp: validate MPJoin HMacFailure counters

 net/mptcp/subflow.c                             |  8 ++++++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)
---
base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
change-id: 20250407-net-mptcp-hmac-failure-mib-66f599305ff3

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


