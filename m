Return-Path: <linux-kselftest+bounces-2368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFBF81CA32
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 13:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002FE1F222E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 12:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6E0179AE;
	Fri, 22 Dec 2023 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5qhg8Hw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C461CA86;
	Fri, 22 Dec 2023 12:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42E9C433C8;
	Fri, 22 Dec 2023 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703249273;
	bh=EyUZ3UqCZNaIyeU3Sh7ZrYlDoc8LVGqooafyQoOjCQw=;
	h=From:Subject:Date:To:Cc:From;
	b=a5qhg8HwFPkcGt7w+G8SxbajrkpwZ6XOdJpbBztoo6ciI3seNd9YFo/6D6Vy7xJI3
	 QP668vwTI3PXqd29lQ1HK3cBpvwSjtri6ZYYdkzbV560JcqkGmu0HPvz0wuQ6+QwXo
	 WzaHN5QEPAtkOKGXoeUijhiNdJy+h4t8j/JHvO7+CdtcAAJPwBKX5FT5Hj0Qtbpr49
	 f54QDCc1ESs33VswrnCLSXrRzLgkHK2ELn5ndGQNG7ssRTYzKn49WGdVNCHefpDZJ4
	 GIbSTzK25pkJGJpHP+dNLUPNkIQia7+SJO+2kd7puLkJ7UfhXCv6rFJVmsCYv4VjzV
	 h/AWcTjqnHj5g==
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH net-next 0/4] mptcp: add CurrEstab MIB counter
Date: Fri, 22 Dec 2023 13:47:21 +0100
Message-Id: <20231222-upstream-net-next-20231221-mptcp-currestab-v1-0-c1eb73d6b2b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFmFhWUC/z2NzQoCMQyEX2XJ2UAbf/FVxENbo+awtSRZWVj23
 S2CHubwMXwzCxirsMF5WED5LSav2iFuBijPVB+McusMFGgbiSJOzVw5jVjZe2bHfzU2Lw3LpMr
 mKeM+0elwzLtAIUMfbMp3mb9nF/jpcF3XDyQ12fiGAAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Geliang Tang <geliang.tang@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EyUZ3UqCZNaIyeU3Sh7ZrYlDoc8LVGqooafyQoOjCQw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlhYV2BBEZq0s8r6/TZBHt3VwVxg7bAGwGbzGfC
 OE/4AbXeIiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZYWFdgAKCRD2t4JPQmmg
 c5OWD/9/9eZaNEWZPQSoCfNq94+iDaSw8LXYh7jksCmsz/JUHWycua3FlxS02MjsjMjMIeb0C1A
 i4ugFR/71nufXjCafRzHzfiJKmmfYs2GGhVc1VXfA34o0ZyeJ+t9VXY5ggbAOCdw47zdOrLF7gv
 WiFP1+g5EmKNEiroZY6sTNa5D/Jd8hy0XHlsMOVG2sXPSgRKzr+wNjdo9PUe1TbSIKpIE/dimlE
 vgeYu87EN53X7Gl93ukQMaOvD5HcYAPgaZRBrwfyp9oo0JaxkuvSxYxEjpdxwOGZ5oKA4s5VI1Z
 ypQ1C3bKbhzx2WQNvaH/QFqm1QPnsGHfQFWTt96wZeMsZwxSNYckNvjZRsCy5cOsAI1ayV7dj/t
 Q00hN0o3PaIW3G8n/H6X0XZjVIH8geQyIM+UeK1XwxXgtPIhWSz5KYAy6xO/U4BdcHUqLDkwyh9
 NT0m4cQCLi+kMGQKhrkfALf+sIopWcIqGb9erKFAV9OJZjgJS0P2xNSnt6JfD94RZgiGLU93umK
 aTkf8ldywm3YH/Dknoc+RSfVwaHivHEFbONbyGqPaQsdT22eX3TxD35GxjmX9KIftTcOykeadu7
 x+mnzOzIAH8XJMQjxKtemC1CEER1mQXe+qHgXGkXWaVWKobC9vkLwOjEDvQayu9io5rkG/p3XMu
 bFsN0RajN035enQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This MIB counter is similar to the one of TCP -- CurrEstab -- available
in /proc/net/snmp. This is useful to quickly list the number of MPTCP
connections without having to iterate over all of them.

Patch 1 prepares its support by adding new helper functions:

 - MPTCP_DEC_STATS(): similar to MPTCP_INC_STATS(), but this time to
   decrement a counter.

 - mptcp_set_state(): similar to tcp_set_state(), to change the state of
   an MPTCP socket, and to inc/decrement the new counter when needed.

Patch 2 uses mptcp_set_state() instead of directly calling
inet_sk_state_store() to change the state of MPTCP sockets.

Patch 3 and 4 validate the new feature in MPTCP "join" and "diag"
selftests.

Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
Geliang Tang (4):
      mptcp: add CurrEstab MIB counter support
      mptcp: use mptcp_set_state
      selftests: mptcp: join: check CURRESTAB counters
      selftests: mptcp: diag: check CURRESTAB counters

 net/mptcp/mib.c                                 |  1 +
 net/mptcp/mib.h                                 |  8 ++++
 net/mptcp/pm_netlink.c                          |  5 +++
 net/mptcp/protocol.c                            | 56 ++++++++++++++++---------
 net/mptcp/protocol.h                            |  1 +
 net/mptcp/subflow.c                             |  2 +-
 tools/testing/selftests/net/mptcp/diag.sh       | 17 +++++++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 46 +++++++++++++++++---
 8 files changed, 110 insertions(+), 26 deletions(-)
---
base-commit: 56794e5358542b7c652f202946e53bfd2373b5e0
change-id: 20231221-upstream-net-next-20231221-mptcp-currestab-5a2867b4020b

Best regards,
-- 
Matthieu Baerts <matttbe@kernel.org>


