Return-Path: <linux-kselftest+bounces-16501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84510961F40
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 08:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039DE1F23657
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 06:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6521553AF;
	Wed, 28 Aug 2024 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEsBWlqC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DB33A8D0;
	Wed, 28 Aug 2024 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825676; cv=none; b=Hqwj2O9ERPcjfu/yNjrHuGSv66Yd8TpeU+w6pQ+YtEftPUGky56EI5SmoJnNXjYtKpW0Hm0QPTFUnh32+1YpJaxUdrWrPSBuPmoM7PlNd3AwUoT2D/eGuxcwgSDOmn1/WemOfrH+nDC52krtmBYOw8kWMaGvN553YGm5O2BVimc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825676; c=relaxed/simple;
	bh=OdWRDOd418du3sE4tmrHGr9q4vWpN0nIOaTamXbp8hI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jw8ae+x7hovVLM9/XF83UXggwkG/iuCEmE9eOEEzHRbfWzq/7lBrnkRu/oOp2Gm0EC0LYQKB2/H5yBVlETT1IgxQp4wFuhAICX+ZK+VghEmO1auaV5DpXH08osQoGW+3rnXldB2zqmNzL/QXWLNfZj4/kP8EpXJZRfkO0ya/s6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEsBWlqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B87BC4AF53;
	Wed, 28 Aug 2024 06:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825675;
	bh=OdWRDOd418du3sE4tmrHGr9q4vWpN0nIOaTamXbp8hI=;
	h=From:Subject:Date:To:Cc:From;
	b=KEsBWlqC/MvyV1ccNpVP5Ypj/kUO1Ss46ry4bt6PNUpms2RkdlMwP64OWQ9d4aHv9
	 nF7ZPKnE2l8FjidO6YVVfI/Mru/SAiaC6XDxXQYdUO01BaKpOxr/Z9upa8UkkSbk2d
	 EW6pDzIZBB2Akc25tDFkyqDcwi7dWiTG0byzG3kZg5eDOkRVP27CPwDkmlRTAL8wrI
	 sMakrG3oGxJXwMC+Y3JYPHUBiVkbogYb8sFiYdSzr+hooe+L8yje02JgWhQ508ooh5
	 9y61aMtpYTr0KkKtjgvsf6CXl1ELFIfheg5wH9Lu3hzEMP3vNnahi2+DBxjHeaRg5Z
	 69Llz6SXHCetQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net v2 00/15] mptcp: more fixes for the in-kernel PM
Date: Wed, 28 Aug 2024 08:14:23 +0200
Message-Id: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD/AzmYC/4WNQQrDIBBFrxJm3SnRFiNd9R4hi6BjIm1UxhBag
 neveIEu3//890/IxJ4yPLoTmA6ffQwV5KUDs85hIfS2Mshe3nstFQbacUu7SbhFJkwbOv9B52Y
 l5ptyWgxQt4mpxs07Qp3AVMPV5z3yt30dolV/tIfAHrWxyujBCqvs80Uc6H2NvMBUSvkBwb7/K
 8AAAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4049; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OdWRDOd418du3sE4tmrHGr9q4vWpN0nIOaTamXbp8hI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzsBHvS3V1SWWcT++5mFegZ4aK5GjF6+RUUeAM
 2QjHvTbdvmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs7ARwAKCRD2t4JPQmmg
 c4MHD/9Yq7xinABU/7nuY2F+0IjKhT/LQ5BPH/kdCv1qoIUM1ib4YqnDLX147ycHF3YT1U+cOee
 GTtvP/54VhCy4TxzjXUvk9TCkYuNofbzX2Upz/m4x0t66XG0CKFj5LwILFXMnk0qTcWuAhygp89
 SldlEaIbu35N5DlZCAYSj5cifcXoD/jzX4vLdute0mhlLNZYENGQB33sao12MM+uVv9VRZTgP+/
 yxciW9SmLRK6IWwg6//8nx87I8FtpDeVaIX+ygAb2ZAQfLwQ161VQYtpC2Pty6ZODJFFRermOrp
 ic9NUmnOq1A9zGhMbQ2QZeENH/mKnOqiG/2t01H2wqxiOwXW8S5jYU9gTq2uowu8UdhM05FJlDf
 +3XIm7FNl5DONTyMZQ6ZgeltefpfJEnw4glkLBXQ4YFkD0z2ArWHzWcOTB4nE3tYhQ02AOlhJIB
 qNwYfuRVAyUBq0hvvD8zDqlAB7dH7ixJVjZyqioT55cj0cHcpayZoPVzJB3Dfc2MtUPX5lfAOfv
 UAR6AdYnDYZDSEEI92oRu8uiAlNkFYsXiA0R/5uQYcHawEHzk8eDIqG1xilwh8GtXOxGU87j008
 k/29GOvzQAF5zojyZBWCzmo4YMryWrWwtNcEosf9mkIEiepva9+ZGjDfoXcGcxn/BcbGTIfOpED
 FSfYcJPk+VumwpQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here is a new batch of fixes for the MPTCP in-kernel path-manager:

Patch 1 ensures the address ID is set to 0 when the path-manager sends
an ADD_ADDR for the address of the initial subflow. The same fix is
applied when a new subflow is created re-using this special address. A
fix for v6.0.

Patch 2 is similar, but for the case where an endpoint is removed: if
this endpoint was used for the initial address, it is important to send
a RM_ADDR with this ID set to 0, and look for existing subflows with the
ID set to 0. A fix for v6.0 as well.

Patch 3 validates the two previous patches.

Patch 4 makes the PM selecting an "active" path to send an address
notification in an ACK, instead of taking the first path in the list. A
fix for v5.11.

Patch 5 fixes skipping the establishment of a new subflow if a previous
subflow using the same pair of addresses is being closed. A fix for
v5.13.

Patch 6 resets the ID linked to the initial subflow when the linked
endpoint is re-added, possibly with a different ID. A fix for v6.0.

Patch 7 validates the three previous patches.

Patch 8 is a small fix for the MPTCP Join selftest, when being used with
older subflows not supporting all MIB counters. A fix for a commit
introduced in v6.4, but backported up to v5.10.

Patch 9 avoids the PM to try to close the initial subflow multiple
times, and increment counters while nothing happened. A fix for v5.10.

Patch 10 stops incrementing local_addr_used and add_addr_accepted
counters when dealing with the address ID 0, because these counters are
not taking into account the initial subflow, and are then not
decremented when the linked addresses are removed. A fix for v6.0.

Patch 11 validates the previous patch.

Patch 12 avoids the PM to send multiple SUB_CLOSED events for the
initial subflow. A fix for v5.12.

Patch 13 validates the previous patch.

Patch 14 stops treating the ADD_ADDR 0 as a new address, and accepts it
in order to re-create the initial subflow if it has been closed, even if
the limit for *new* addresses -- not taking into account the address of
the initial subflow -- has been reached. A fix for v5.10.

Patch 15 validates the previous patch.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patches 11,15/15: allow the connection to run for longer, should fix
  the issue seen on the Netdev CI, with a debug kconfig.
- Link to v1: https://lore.kernel.org/r/20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org

---
Matthieu Baerts (NGI0) (15):
      mptcp: pm: reuse ID 0 after delete and re-add
      mptcp: pm: fix RM_ADDR ID for the initial subflow
      selftests: mptcp: join: check removing ID 0 endpoint
      mptcp: pm: send ACK on an active subflow
      mptcp: pm: skip connecting to already established sf
      mptcp: pm: reset MPC endp ID when re-added
      selftests: mptcp: join: check re-adding init endp with != id
      selftests: mptcp: join: no extra msg if no counter
      mptcp: pm: do not remove already closed subflows
      mptcp: pm: fix ID 0 endp usage after multiple re-creations
      selftests: mptcp: join: check re-re-adding ID 0 endp
      mptcp: avoid duplicated SUB_CLOSED events
      selftests: mptcp: join: validate event numbers
      mptcp: pm: ADD_ADDR 0 is not a new address
      selftests: mptcp: join: check re-re-adding ID 0 signal

 net/mptcp/pm.c                                  |   4 +-
 net/mptcp/pm_netlink.c                          |  87 ++++++++++----
 net/mptcp/protocol.c                            |   6 +
 net/mptcp/protocol.h                            |   5 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 153 ++++++++++++++++++++----
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |   4 +
 6 files changed, 209 insertions(+), 50 deletions(-)
---
base-commit: 3a0504d54b3b57f0d7bf3d9184a00c9f8887f6d7
change-id: 20240826-net-mptcp-more-pm-fix-ffa61a36f817

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


