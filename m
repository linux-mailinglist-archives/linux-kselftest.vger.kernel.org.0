Return-Path: <linux-kselftest+bounces-2240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72D6819263
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 22:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA671F25E24
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 21:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C5D3B193;
	Tue, 19 Dec 2023 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gkc7AUaq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE2D3A8DB;
	Tue, 19 Dec 2023 21:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A159C433C8;
	Tue, 19 Dec 2023 21:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703021897;
	bh=OTUYQIOoV+0YKQKbrrxB0SoB7Y//YH3bCks8wgeg91U=;
	h=From:Subject:Date:To:Cc:From;
	b=Gkc7AUaqKaN/KT+QKupBNCx6Q6ja1xYr973gIT7ENGaK+bkOl4CMgrdIZUVrKnzNX
	 Uyd3XIff9fMlEe9QOzydvKbS+s4CRXMI7b8AEKk2qA6TjMcBjXxgfOQ7Oqzxnvol2s
	 okc6jKgTccOTE2OGMqJaf4HH2XHR0W0BgcWEqs8SGFyla7bOelARtDk5P4NndAGC1m
	 3/S7VWotqWk0n+rbm/pPLemMFyHggL4gUsmjXHJZB0iib7+TDuk0b5TyaZXJcW2UfI
	 h8H3ZonCr+5MhahMeBrUL6mjjph37QxJ6mpRjfnd6DRGXvFjDQeWUfPeZy9+CLc4Yw
	 pY2GVgpSH+HIA==
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH net-next 0/4] mptcp: cleanup and support more ephemeral
 ports sockopts
Date: Tue, 19 Dec 2023 22:31:03 +0100
Message-Id: <20231219-upstream-net-next-20231219-mptcp-sockopts-ephemeral-ports-v1-0-2b13bedfcaf8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJcLgmUC/z2NQQrCMBBFr1Jm7YCT2qJeRboIcbRBkwwzUQqld
 zcIuviLx4f3VjDWyAbnbgXld7RYcgPadRBmn++M8doY3N715OiEL7Gq7BNmrm1Lxf+VpAZBK+F
 RpBqyzJxY/ROlaOPxMAzO8bGnkaD5RfkWl2/7Aj8bTNv2AaDe25KVAAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>, Maxim Galaganov <max@internet.ru>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OTUYQIOoV+0YKQKbrrxB0SoB7Y//YH3bCks8wgeg91U=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlgg1GgJ2hrXIcmnM6OfCZnROIMuN6eedUzJXtc
 CC6277Z1R6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZYINRgAKCRD2t4JPQmmg
 cx0eD/9xC9Pfdlve6uheSVii3I4/4GqaRLnXpZQyN9x1/nrmfzHGSiHh41ttRd50K8VTmlJ2USS
 W02ur6sGocBW0/nTw+nF+Zoe7lGCMPoQMqfBcpjMMi00JQzcUStW+smQghN2QQQYsI+SaMY3/L3
 5rb3GeqslJePZQYDbw4Bn2pZVmECWvIKcVm06IKsXdVCY+XDW77vWpEAOpa5HjA8EyNT7/ePpry
 K6+pULHEwEi78cprUxkFm0dyuFJu95JVrNWqXiao7L/IVhEJPWj3z2GCHk42+jIV8Wcuk+dOMug
 MwfjWeXkheVUvg5MTsu3N17dRYqmwTkQFbO4la66UcIwxVj6k24S3liC6bRiw5rE/7fNdp05GR1
 TKRIH/EY3pnBsYTRat+u6TNZCXAEQgliN5W2uszBsXXCgbX1UVrlCIKQqDKrgBIsA4zkP4wNdSn
 WVuIxlHHX7KgDbL7CQ6HrSqjIlf3mq3arsvURzWmWUDPyixbI836H6l57dYPgUg38JYqB2L/p2b
 MHvWDinffxoy4xo27oRY/JRefeqRtvqvCx0Wf3/P7kL/hm3UlbFERoR2TSpg9v6JCtZfCaUzN6z
 hd/nsc6rhUjSMYb5UNA3BMZuJnF5ar02jVwH/1Ddc9i27kj33xyCSdrYTjdhjiTePrl4HPnQRLz
 h/koSFzxkEEe1Ig==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Patch 1 is a cleanup one: mptcp_is_tcpsk() helper was modifying sock_ops
in some cases which is unexpected with that name.

Patch 2 to 4 add support for two socket options: IP_LOCAL_PORT_RANGE and
IP_BIND_ADDRESS_NO_PORT. The first one is a preparation patch, the
second one adds the support while the last one modifies an existing
selftest to validate the new features.

Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
Davide Caratti (1):
      mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()

Maxim Galaganov (3):
      mptcp: rename mptcp_setsockopt_sol_ip_set_transparent()
      mptcp: sockopt: support IP_LOCAL_PORT_RANGE and IP_BIND_ADDRESS_NO_PORT
      selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE

 net/mptcp/protocol.c                              | 108 +++++++++-------------
 net/mptcp/sockopt.c                               |  27 +++++-
 tools/testing/selftests/net/ip_local_port_range.c |  12 +++
 3 files changed, 79 insertions(+), 68 deletions(-)
---
base-commit: 62ed78f3baff396bd928ee77077580c5aa940149
change-id: 20231219-upstream-net-next-20231219-mptcp-sockopts-ephemeral-ports-645522e83161

Best regards,
-- 
Matthieu Baerts <matttbe@kernel.org>


