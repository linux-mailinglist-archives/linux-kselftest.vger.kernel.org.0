Return-Path: <linux-kselftest+bounces-4794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAED856C66
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FA71C21765
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83951384B0;
	Thu, 15 Feb 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXI8H0HU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B83132C37;
	Thu, 15 Feb 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021537; cv=none; b=IfUR48B9WCFAzPACPqxt12jB6JGsONhffiTuyAKg8I8Mrs15o6K5TFfRAvBXYVBGtIc9Qnzm1pPB6pbnu3SYfWs8280rzEvasUSqg5cNN3SGeO1gtMi+J5nINGbqclbSu1/7Nt/EBF3P99UT2i74TXbZBNf/t6YFdm/hrCcaqzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021537; c=relaxed/simple;
	bh=V2c9t1KLwlqoanTaNYTv58ugynfQZ/9FZ1F536Q19bw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H1u6JWr2Vtv3nqO07CdNG49PcTCb2G9DzuCUXTwyTQzycGvaf+XcZFekgTavHGdZFMEMz4TVuRgogXy0rpIR7iptjtfiOXpLbyU/ISAN2BY6r36DdYyCo1/KyYOudD0YqqZHkQXT//tzguuauWjn0HT6M+0J+6RU8pdv14Z6SvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXI8H0HU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1E2C433C7;
	Thu, 15 Feb 2024 18:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708021537;
	bh=V2c9t1KLwlqoanTaNYTv58ugynfQZ/9FZ1F536Q19bw=;
	h=From:Subject:Date:To:Cc:From;
	b=OXI8H0HUq6C4fPv/BHW3MRruti2nkdJgcI58RsbdE7Qw8tihAmPAt0cmlq8oDJgLb
	 QfGxuCRizH0Ab25wZlUNfEAv74GcGWaf2F9ayrGvlZb5C/1ovxiYbr/KsD7F14vObU
	 77WI4fRjze2qoE5Fa84bj37mIvY7UuydkDld2thtD6kQe+speKlfBim05mbyTGsXVr
	 SXRTrIgXPKSBwFuk5CQDWWqnRCRXpk9CVYuzHzacmscSepJTsJbHNVGaggInhkh0bc
	 y0dYiikeIMyy4MN5LccOGXlLDh80rnS5HKzpX/PAFobgkQp8SzC662yprQQ1TEm+b5
	 9PB//ZzLee6IA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 00/13] mptcp: misc. fixes for v6.8
Date: Thu, 15 Feb 2024 19:25:27 +0100
Message-Id: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABdXzmUC/z2MQQqEMBAEvyJzdiDJ6rLsV8SDxFbnYFYyKgvi3
 x08eKxuqg5SZIHStzgoYxeVXzLwZUFx6tIIlt6YgguVC77mbdE1o5s5YeVnnUUjD/KHsnt9fI3
 oqz6+yTJLxn1YpSGTqD3PC/pp6md3AAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>, stable@vger.kernel.org, 
 Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3423; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=V2c9t1KLwlqoanTaNYTv58ugynfQZ/9FZ1F536Q19bw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzlcczGT2qSuCiXg8+2y1DkJyC+bGPYCzu3w8u
 u5hA7gJi4OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc5XHAAKCRD2t4JPQmmg
 c6bID/9qAl1mKRGeujL3mhl8AXGWOhacO2h7L0yxImE8cZIQAPGrYBUm7colu0st9gsWdHaOnWY
 ueNyNAHjzv1vbYpH//tQMdpkzYzgpqpv74lrF+DmL2HGxBFka4qZ7H/Ktjvr/Ii+EwNDpQ8T+gS
 xNbWgpgCTj7kCwKJ/q5KV7ZX7MopaNSxAOljO41Oe44SCWnSvmNqRH7AjLVhni0scRCuXY1EvrQ
 Kl4EkyQOLIND5OxczK5LKlubAp1pDnrRn+I9SoPcY4qQEYCt5UXxp/HDgPjy6vmEVqfxPO2H6HO
 XARfVLIBXAS3PrgiJu8vUHkSqwg/5g9+saBESqRd1+S9O0bt3l2QdFfFz73aMP3gQtFyrSWr5m5
 1hB61reLNwC54pBpswXrhfEvjwol0bEGO17wCxzdDvRO9xhUXzULHhKufeaqwErLxTyVYWmUnNo
 fUy0coEI0pfASrd40ausKUiiXzPbqTAF7FcoWKyoAessR4RlkOiwboNvSqD+B7I0Wluyc6bMjSc
 At6yXonqs2b8MwNNGXeBSl68VzJgkZNrSg94gAmdPXfmDIiHdrsuJGTaeYyuBZrgq6wMNY1NdEp
 0H4oaPUzBAUyfCjMrl+K5SAPWr10G+y4AGbYruK3cu1O8tAZi3C/i1hqjWm+tZhDiu0Pgo3PrB6
 EqHxKxmBgntg4tg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series includes 4 types of fixes:

Patches 1 and 2 force the path-managers not to allocate a new address
entry when dealing with the "special" ID 0, reserved to the address of
the initial subflow. These patches can be backported up to v5.19 and
v5.12 respectively.

Patch 3 to 6 fix the in-kernel path-manager not to create duplicated
subflows. Patch 6 is the main fix, but patches 3 to 5 are some kind of
pre-requisities: they fix some data races that could also lead to the
creation of unexpected subflows. These patches can be backported up to
v5.7, v5.10, v6.0, and v5.15 respectively.

Note that patch 3 modifies the existing ULP API. No better solutions
have been found for -net, and there is some similar prior art, see
commit 0df48c26d841 ("tcp: add tcpi_bytes_acked to tcp_info"). Please
also note that TLS ULP Diag has likely the same issue.

Patches 7 to 9 fix issues in the selftests, when executing them on older
kernels, e.g. when testing the last version of these kselftests on the
v5.15.148 kernel as it is done by LKFT when validating stable kernels.
These patches only avoid printing expected errors the console and
marking some tests as "OK" while they have been skipped. Patches 7 and 8
can be backported up to v6.6.

Patches 10 to 13 make sure all MPTCP selftests subtests have a unique
name. It is important to have a unique (sub)test name in TAP, because
that's the test identifier. Some CI environments might drop tests with
duplicated names. Patches 10 to 12 can be backported up to v6.6.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (2):
      mptcp: add needs_id for userspace appending addr
      mptcp: add needs_id for netlink appending addr

Matthieu Baerts (NGI0) (7):
      selftests: mptcp: pm nl: also list skipped tests
      selftests: mptcp: pm nl: avoid error msg on older kernels
      selftests: mptcp: diag: fix bash warnings on older kernels
      selftests: mptcp: simult flows: fix some subtest names
      selftests: mptcp: userspace_pm: unique subtest names
      selftests: mptcp: diag: unique 'in use' subtest names
      selftests: mptcp: diag: unique 'cestab' subtest names

Paolo Abeni (4):
      mptcp: fix lockless access in subflow ULP diag
      mptcp: fix data races on local_id
      mptcp: fix data races on remote_id
      mptcp: fix duplicate subflow creation

 include/net/tcp.h                                 |  2 +-
 net/mptcp/diag.c                                  |  8 ++-
 net/mptcp/pm_netlink.c                            | 69 ++++++++++++++---------
 net/mptcp/pm_userspace.c                          | 15 ++---
 net/mptcp/protocol.c                              |  2 +-
 net/mptcp/protocol.h                              | 15 ++++-
 net/mptcp/subflow.c                               | 15 ++---
 net/tls/tls_main.c                                |  2 +-
 tools/testing/selftests/net/mptcp/diag.sh         | 41 ++++++++------
 tools/testing/selftests/net/mptcp/pm_netlink.sh   |  8 ++-
 tools/testing/selftests/net/mptcp/simult_flows.sh |  3 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh |  4 +-
 12 files changed, 116 insertions(+), 68 deletions(-)
---
base-commit: c40c0d3a768c78a023a72fb2ceea00743e3a695d
change-id: 20240215-upstream-net-20240215-misc-fixes-03815ec14dc6

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


