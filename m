Return-Path: <linux-kselftest+bounces-41365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A646B54DD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82996481A93
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ACB287248;
	Fri, 12 Sep 2025 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXL3nQyy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03D303A13;
	Fri, 12 Sep 2025 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679969; cv=none; b=Js5T49fTQp/mBOWNyxhMZi8WjgXCoBGMfEsz/eFLP2DL4tevye40iWvgtJGnWaetP1Gi8uiPVKj+8aRF8tGgPiS456qqpRWhZj8hjOm/g/JBtgAVkyfMf8u9I16TQiAGZZ3oGEj25BRYDQgHNP/6UJuKz5wjHL8Z/+hdOJLoaE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679969; c=relaxed/simple;
	bh=V39Rz+1RHwUbOx8EKfTfq2XSOPa4SX/Yzry+drXGDGk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TU3BJfdj4hKN4IeYN3d2BOIogut2EfLmoQ5Arjx63EQ+EQXr10puTc91BKe8/XOorP6Ism3Til3PjkKGzmnjVgFg3Om1JJO//SIEfw9z+6b2o/93qwyaiMeEVFIAmpvYcf2BrmbrzvhV+JQjlU+qcP0K9kP0gNso1NCAk9WdYD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXL3nQyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA65EC4CEF1;
	Fri, 12 Sep 2025 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757679969;
	bh=V39Rz+1RHwUbOx8EKfTfq2XSOPa4SX/Yzry+drXGDGk=;
	h=From:Subject:Date:To:Cc:From;
	b=sXL3nQyyiODekMqyUC/PMc+/0S5c+Ri2nfG74xqfpgZrviRepbJnUkosMtqTxDmwe
	 M/a7HwXuoJuPhPb89c77ItJjF3fhuSVnET9ylIJcmkwDfRLEZPWnLgAFuKq7l+dpq2
	 UoyM2gu9aqst6EF7ObH5tjnxkWUl1qYXlxJyBHaJ2L4k49MHxM01UMyTA0jb9thWog
	 gQACrqKfqnz1CHwTtV74X0Pft9zVSQVsVhrK0ruf56QwAue0RNtfN5D1TuZbnLG+my
	 WewJ1f6g/KveqhmTMYNTor+mvm6mdHQEw1vS3hBuHvl+ZvkzW+eJgMqumDQNfx1pxm
	 69BZazdmcKuQg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/5] selftests: mptcp: avoid spurious errors on TCP
 disconnect
Date: Fri, 12 Sep 2025 14:25:49 +0200
Message-Id: <20250912-net-mptcp-fix-sft-connect-v1-0-d40e77cbbf02@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE0RxGgC/x2MQQqAMAzAviI9W5gTFf2KeBiz0x6sYxsiiH+3e
 AwkeSBTYsowVQ8kujjzKQpNXYHfnWyEvCqDNbYzY2NRqOARi48Y+MYcCvpThHzBYMbOrYPrqe1
 B+5hIlf89g2awvO8HGTzwiXAAAAA=
X-Change-ID: 20250912-net-mptcp-fix-sft-connect-f095ad7a6e36
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2680; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=V39Rz+1RHwUbOx8EKfTfq2XSOPa4SX/Yzry+drXGDGk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOCIavPKjm/fuz+brPSrw7en4IObgFn088st/qeu29l
 Cl6/rZtHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPxsmVkuDzrBp/nKmaVVQXO
 HqHX1dh2XFirunuScHj4x00BK6dX3WVkmLZdaPoT7cx5Gy/vmC+3jG3Oa+fSlOmXNs1d0NVn03C
 yjxEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series should fix the recent instabilities seen by MPTCP and NIPA
CIs where the 'mptcp_connect.sh' tests fail regularly when running the
'disconnect' subtests with "plain" TCP sockets, e.g.

  # INFO: disconnect
  # 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration   996ms) [ OK ]
  # 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       (duration   851ms) [ OK ]
  # 65 ns1 TCP   -> ns1 (10.0.1.1:20003      ) MPTCP     Unexpected revents: POLLERR/POLLNVAL(19)
  # (duration   896ms) [FAIL] file received by server does not match (in, out):
  # -rw-r--r-- 1 root root 11112852 Aug 19 09:16 /tmp/tmp.hlJe5DoMoq.disconnect
  # Trailing bytes are:
  # /{ga 6@=#.8:-rw------- 1 root root 10085368 Aug 19 09:16 /tmp/tmp.blClunilxx
  # Trailing bytes are:
  # /{ga 6@=#.8:66 ns1 MPTCP -> ns1 (dead:beef:1::1:20004) MPTCP     (duration   987ms) [ OK ]
  # 67 ns1 MPTCP -> ns1 (dead:beef:1::1:20005) TCP       (duration   911ms) [ OK ]
  # 68 ns1 TCP   -> ns1 (dead:beef:1::1:20006) MPTCP     (duration   980ms) [ OK ]
  # [FAIL] Tests of the full disconnection have failed

These issues started to be visible after some behavioural changes in
TCP, where too quick re-connections after a shutdown() can now be more
easily rejected. Patch 3 modifies the selftests to wait, but this
resolution revealed an issue in MPTCP which is fixed by patch 1 (a fix
for v5.9 kernel).

Patches 2 and 4 improve some errors reported by the selftests, and patch
5 helps with the debugging of such issues.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: The last two patches are not strictly fixes, but they are useful
in case similar issues happen again. That's why they have been added
here in this series for -net. If that's an issue, please drop them, and
I can re-send them later on.

---
Matthieu Baerts (NGI0) (5):
      mptcp: propagate shutdown to subflows when possible
      selftests: mptcp: connect: catch IO errors on listen side
      selftests: mptcp: avoid spurious errors on TCP disconnect
      selftests: mptcp: print trailing bytes with od
      selftests: mptcp: connect: print pcap prefix

 net/mptcp/protocol.c                               | 16 ++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_connect.c  | 11 ++++++-----
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  6 +++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  2 +-
 4 files changed, 28 insertions(+), 7 deletions(-)
---
base-commit: 2690cb089502b80b905f2abdafd1bf2d54e1abef
change-id: 20250912-net-mptcp-fix-sft-connect-f095ad7a6e36

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


