Return-Path: <linux-kselftest+bounces-39110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771D8B284F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 19:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 631C57B6E12
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 17:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D8B30F533;
	Fri, 15 Aug 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkKIQ8dz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AD930F524;
	Fri, 15 Aug 2025 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278927; cv=none; b=XRZDvboh6J0E1x05JqljziDY30KVViazt5tBtI59JGyjBd6DSgdSC4QHFyPxNypeEuTYZbBDxivqATDRKarc9q1HX/PEBwNk9njhP6/4Dw3CVzcVPlfnSyr9wn4RlLaz2/8ZdLBx11YylnrgyVAOYi9//RWzOvpnJbAfriOC00s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278927; c=relaxed/simple;
	bh=kFHaCPABuJTztGrxoIXb4alwdVui2jyyPeZPCucfwVY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HRIfnqCPDkiM7dSY7THcqh6a7lXRNk4BEab6W/f1wtqKBHUthY2P8RoUlMnU2JLdQeC8GL/w0OJvTs69k+BYUnZLwfCCtqlD0aiL+AdwPijtbkHUTXJiKercvE4K5DXIKZZaa+ZP5I68Ye+o6AGssmWVgLN8YzB0QDU5lx9x0zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkKIQ8dz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8A1C4CEEB;
	Fri, 15 Aug 2025 17:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755278926;
	bh=kFHaCPABuJTztGrxoIXb4alwdVui2jyyPeZPCucfwVY=;
	h=From:Subject:Date:To:Cc:From;
	b=bkKIQ8dzTbYZ35KkicwmdW4kZIp3/+t6dxRRrIVSzsgnIwvN2uwkpauye0h555nKc
	 azVUvz6v/foa1Xk1aobOVw817ANQNivLfRRCtNp1/6WHV28qfe97uczLIVtsdyngM8
	 hfO7xwbfYci6rcb4iYrF17H6N68Jqgm0TrKVJ7Es6JIu88l+RPpWGKrkI5oGKFBmwC
	 iNfg0Eo5LKYkOrEWTg2Gc2NsSdGlbG6ULcIq/z3C4owsGPx1PB7nojpdS2/zNGOnJa
	 4Jsc1nIbVeDer6LtMVlUs7G9q6mKW4WikvcYXbCdNzmPt1Ex+IzBafOAMEd7EbRf0X
	 6P7blVGAANrLQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/8] mptcp: misc fixes for v6.17-rc
Date: Fri, 15 Aug 2025 19:28:18 +0200
Message-Id: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADJun2gC/x2MzQqDMBAGX0X23A9M/At9ldJDTbZ1D6YhK6Ugv
 ruLx4GZ2Um5Civdm50q/0Tlmw3craG4vPKHIcmYfOuHNrgBmTesZYsFq2jEW/6sGOEm1OiRXJh
 9300cUk/2KJUvwxYPspSex3ECaHtIkXQAAAA=
X-Change-ID: 20250815-net-mptcp-misc-fixes-6-17-rc2-d18b2437e8d4
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jianguo Wu <wujianguo@chinatelecom.cn>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, zhenwei pi <pizhenwei@bytedance.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Christoph Paasch <cpaasch@openai.com>, stable@vger.kernel.org, 
 Thomas Dreibholz <dreibh@simula.no>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1941; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kFHaCPABuJTztGrxoIXb4alwdVui2jyyPeZPCucfwVY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLm59mzhffvk71p3Ly2Q2jRi2K2AyzSYqf3LdBad9FLq
 0Ckcm14RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESaohkZ+kI8z1zc8/CchHPS
 jJJbP869E7v4iWOb68Qr/5jbHqrYz2BkeDfRr1InirX/3c793j/PMk+YYHtx8VyuR5tsyiWSFqz
 VYgUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various fixes:

- Patch 1: Better handling SKB extension allocation failures. A fix for
  v5.7.

- Patches 2, 3: Avoid resetting MPTCP limits when flushing MPTCP
  endpoints. With a validation in the selftests. Fixes for v5.7.

- Patches 4, 5, 6: Disallow '0' as ADD_ADDR retransmission timeout.
  With a preparation patch, and a validation in the selftests. Fixes for
  v5.11.

- Patches 8, 9: Fix C23 extension warnings in the selftests, spotted by
  GCC. Fixes for v6.16.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Christoph Paasch (1):
      mptcp: drop skb if MPTCP skb extension allocation fails

Geliang Tang (3):
      mptcp: remove duplicate sk_reset_timer call
      mptcp: disable add_addr retransmission when timeout is 0
      selftests: mptcp: disable add_addr retrans in endpoint_tests

Matthieu Baerts (NGI0) (4):
      mptcp: pm: kernel: flush: do not reset ADD_ADDR limit
      selftests: mptcp: pm: check flush doesn't reset limits
      selftests: mptcp: connect: fix C23 extension warning
      selftests: mptcp: sockopt: fix C23 extension warning

 Documentation/networking/mptcp-sysctl.rst         |  2 ++
 net/mptcp/options.c                               |  6 ++++--
 net/mptcp/pm.c                                    | 18 ++++++++++++------
 net/mptcp/pm_kernel.c                             |  1 -
 tools/testing/selftests/net/mptcp/mptcp_connect.c |  5 +++--
 tools/testing/selftests/net/mptcp/mptcp_inq.c     |  5 +++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh   |  1 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c |  5 +++--
 tools/testing/selftests/net/mptcp/pm_netlink.sh   |  1 +
 9 files changed, 29 insertions(+), 15 deletions(-)
---
base-commit: 065c31f2c6915b38f45b1c817b31f41f62eaa774
change-id: 20250815-net-mptcp-misc-fixes-6-17-rc2-d18b2437e8d4

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


