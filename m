Return-Path: <linux-kselftest+bounces-42532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84717BA5CA7
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 11:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F311189C797
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CD72D73A8;
	Sat, 27 Sep 2025 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip6ypAWS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA9E224B09;
	Sat, 27 Sep 2025 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758966058; cv=none; b=AX3oo7yB9SIvGu5GdLtvUXEgxSUSfqTHHHrwPBtWkTAvh3ohN4kbLh84QD07nk0CVBFCvJX83ENL93ou12SStId7TdCFKFGWff8o7o87yNkzu0OalsCEaOztswDJxCJGyCgErZzH9Lh+FyUa95/s9/5y6aFVzWY+NKMIVOLf2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758966058; c=relaxed/simple;
	bh=dt+DecOx3QZJzbvvA3hprtLoaSDazDHK/AaHDq9Jc1I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OSXitCA1eEPGxwtDIWPVoLN8LVeP87EjqRv/dE0zvDkG4GYizUW4h2QWGmVkk2uaJQQzuKcTNUc7KkH9hyhxRLhoMAbQTSLRY6DXmObHzYwL/fStIyKFRe05lGllGM0bsTsyEgMr1+qY+A5iNj7lsQw1EzCEtewQlPVpKmd1LyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip6ypAWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C283EC4CEF8;
	Sat, 27 Sep 2025 09:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758966057;
	bh=dt+DecOx3QZJzbvvA3hprtLoaSDazDHK/AaHDq9Jc1I=;
	h=From:Subject:Date:To:Cc:From;
	b=Ip6ypAWS9p3RmzQnOrceVx+weMajQ4YgomFbO4LYYP27tFldc78k6i7K9WXmRpVkw
	 lMvf/NzF2oSzNY9cvbZGFihwbb6uTbFogWERBWaX9fzUv/xoR/oKG6IFydEQMasZy+
	 vqEOPUgNISkgHg27zxQiIxJ85lm4tHZECkda41/fX2NpP/GnFC9Jotl0O87rEIm63W
	 HfAHpFB6PUSUbuv0Q3pw4NbDTp6BO8Y86woYu/0FdBQS/t4elxXgQHjgJ9ZyGV+jJ9
	 4AaO9kAX3aHayM80Yv29Lxy+HL74V7KTuKslHD3tvnGW5cLsY1pzKY3INJIfRPGw8g
	 0Mblg9CzU4oSw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/8] mptcp: receive path improvement
Date: Sat, 27 Sep 2025 11:40:36 +0200
Message-Id: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABSx12gC/zWMQQqEMAwAvyI5G9CguPUr4qHE7JqD3dAWEcS/W
 wQPc5jDzAlJokqCsTohyq5J/6FIW1fAqw8/QV2KAzXUN44GDJILR8bNMhtG3tF8XlE3w9bR8mH
 q2PEA5WBRvno89wneEObrugH8HVOydwAAAA==
X-Change-ID: 20250927-net-next-mptcp-rcv-path-imp-192d8c24c9c7
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2508; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dt+DecOx3QZJzbvvA3hprtLoaSDazDHK/AaHDq9Jc1I=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKub5QO3nWhVaNtww71nepfbpa7z+VZzCDUlCKldn9aS
 Oc8W6UJHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNxX8HI8H5r2/o8nn2Tb3hd
 9P4969wab8/QkoPbBbq8VT86/5v9cxojw/2O2zNaXBw1OTUPsK3V4mUoiHA26269ddVvzz5r6d8
 zuQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series includes several changes to the MPTCP RX path. The main
goals are improving the RX performances, and increase the long term
maintainability.

Some changes reflects recent(ish) improvements introduced in the TCP
stack: patch 1, 2 and 3 are the MPTCP counter part of SKB deferral free
and auto-tuning improvements. Note that patch 3 could possibly fix
additional issues, and overall such patch should protect from similar
issues to arise in the future.

Patches 4-7 are aimed at introducing the socket backlog usage which will
be done in a later series to process the packets received by the
different subflows while the msk socket is owned.

Patch 8 is not related to the RX path, but it contains additional tests
for new features recently introduced in net-next.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - Sorry for sending this series that late, we had quite a few patches
   to upstream during this cycle. This is the last batch, and it has
   been heavily tested the last 2 weeks.
 - If there are some issues with some patches, but not with 1-3, it
   would be nice, if possible, if these 3 first patches can be accepted,
   to reduce the recently introduced gap with TCP.
 - Patches can be grouped like this if needed: 1-3, 4-5, 6-7, 8. 6-7 are
   preparing the ground for future on-going work, they can be dropped if
   there are issues with them.

---
Matthieu Baerts (NGI0) (1):
      selftests: mptcp: join: validate new laminar endp

Paolo Abeni (7):
      mptcp: leverage skb deferral free
      tcp: make tcp_rcvbuf_grow() accessible to mptcp code
      mptcp: rcvbuf auto-tuning improvement
      mptcp: introduce the mptcp_init_skb helper
      mptcp: remove unneeded mptcp_move_skb()
      mptcp: factor out a basic skb coalesce helper
      mptcp: minor move_skbs_to_msk() cleanup

 include/net/tcp.h                               |   1 +
 net/ipv4/tcp_input.c                            |   2 +-
 net/mptcp/protocol.c                            | 187 ++++++++++++------------
 net/mptcp/protocol.h                            |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  69 +++++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |   9 ++
 6 files changed, 177 insertions(+), 95 deletions(-)
---
base-commit: 1493c18fe8696bfc758a97130a485fc4e08387f5
change-id: 20250927-net-next-mptcp-rcv-path-imp-192d8c24c9c7

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


