Return-Path: <linux-kselftest+bounces-41378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D3FB54E76
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389B116863C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073762FC897;
	Fri, 12 Sep 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8e4//tJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E432DC77B;
	Fri, 12 Sep 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681582; cv=none; b=WdMyDV1bTcA4kErplrKmz8ovqI2AzldccduAxqrw+O1izhOj+cVNLgpyPW5+Z0efakANfpk0kGrq01hEtct97Bd7F877TyzmfGEOqxOs3SQlJLz95xMp6x8yeBfaVgRqhz2Y5UYNJELyUvicFRKWOZ91m6jZJQnZJqLCdHSuZzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681582; c=relaxed/simple;
	bh=NGxKhhEloQU8COYKikABNFMJLKvvfp4lYF0nzeADhJo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J8S2NPgWRlRjkT6qZ/8b7pq8y/k0sLkxinTwM2bPSP8mqUO5hnbxbTGB22oyFHiXzgMDmpWsTL6gF8SSlE+rL78oB6sWXsJfuFHmI7cKasZ2mGBMv4gBoIhc0tBzOxjW/9JIOzHCRgQaIZSHKWp0rIKpi7/5CSJn9nbLRzvdDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8e4//tJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D012C4CEF1;
	Fri, 12 Sep 2025 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757681582;
	bh=NGxKhhEloQU8COYKikABNFMJLKvvfp4lYF0nzeADhJo=;
	h=From:Subject:Date:To:Cc:From;
	b=A8e4//tJPo3e5U3dfhQ356z1qAl2n89OKcvFW5d5DAc6tl0w9nKLek5k/wpM+XqaY
	 rd7EQwDIyeDcqxKqHchCwE0eWprnS/yAqsmK6S2jO3a+SkcfsCjJP0AvaHGKyduMHJ
	 pqRZWx0KLyQAnPT/bEg94zm52uWXATa4IKHFnQg4He1Q+OkJv8opyYxNpyFBQklvA2
	 aPQAOqMp/53QjD8uguA9dNA3cQqzt13Ccu8gK4WGYVAysGB8wVWzOlbfp/fuwDD6i5
	 +eYVimDFGKaM7ThuEzhwnj0CsLpuD/CgQnSInzLe+JfFoUX/YFPLkInELRoErNyXTA
	 vUWLUzvJlPNcQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/5] mptcp: pm: nl: announce deny-join-id0 flag
Date: Fri, 12 Sep 2025 14:52:19 +0200
Message-Id: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-0-40171884ade8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIMXxGgC/x2NwQrCMBAFf6Xs2YVs0Er9FZHSJk9doemSVLGU/
 rvB4xxmZqOCrCh0aTbK+GjROVWQQ0PhOaQHWGNl8s6fXCeeExaebAnGNvG72BDAEWntX7OmXqP
 jsRURHHFG21HtWMZdv//HlapOt33/AdqkWpp4AAAA
X-Change-ID: 20250912-net-mptcp-pm-uspace-deny_join_id0-b6111e4e7e69
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Kishen Maloor <kishen.maloor@intel.com>, 
 Shuah Khan <shuah@kernel.org>, Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Marek Majkowski <marek@cloudflare.com>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2449; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NGxKhhEloQU8COYKikABNFMJLKvvfp4lYF0nzeADhJo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOiC8+1r5ItuHx/9LTM5aGfnr9IOfk+9pjhywOVXjvl
 3E490LMpKOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiOfcYGd6c+PRFIP6Fu63C
 q0mzflzdqR3ffID77ZtNkbMzrx47dP4Wwz/zIH0D4dnMx8I+JnMuDOnq9w6Xmmr5/+PCR1G1CpP
 S41gA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

During the connection establishment, a peer can tell the other one that
it cannot establish new subflows to the initial IP address and port by
setting the 'C' flag [1]. Doing so makes sense when the sender is behind
a strict NAT, operating behind a legacy Layer 4 load balancer, or using
anycast IP address for example.

When this 'C' flag is set, the path-managers must then not try to
establish new subflows to the other peer's initial IP address and port.
The in-kernel PM has access to this info, but the userspace PM didn't,
not letting the userspace daemon able to respect the RFC8684.

Here are a few fixes related to this 'C' flag (aka 'deny-join-id0'):

- Patch 1: add remote_deny_join_id0 info on passive connections. A fix
  for v5.14.

- Patch 2: let the userspace PM daemon know about the deny_join_id0
  attribute, so when set, it can avoid creating new subflows to the
  initial IP address and port. A fix for v5.19.

- Patch 3: a validation for the previous commit.

- Patch 4: record the deny_join_id0 info when TFO is used. A fix for
  v6.2.

- Patch 5: not related to deny-join-id0, but it fixes errors messages in
  the sockopt selftests, not to create confusions. A fix for v6.5.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (1):
      selftests: mptcp: sockopt: fix error messages

Matthieu Baerts (NGI0) (4):
      mptcp: set remote_deny_join_id0 on SYN recv
      mptcp: pm: nl: announce deny-join-id0 flag
      selftests: mptcp: userspace pm: validate deny-join-id0 flag
      mptcp: tfo: record 'deny join id0' info

 Documentation/netlink/specs/mptcp_pm.yaml         |  4 ++--
 include/uapi/linux/mptcp.h                        |  2 ++
 include/uapi/linux/mptcp_pm.h                     |  4 ++--
 net/mptcp/options.c                               |  6 +++---
 net/mptcp/pm_netlink.c                            |  7 +++++++
 net/mptcp/subflow.c                               |  4 ++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 16 ++++++++++------
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  7 +++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 14 +++++++++++---
 9 files changed, 48 insertions(+), 16 deletions(-)
---
base-commit: 2690cb089502b80b905f2abdafd1bf2d54e1abef
change-id: 20250912-net-mptcp-pm-uspace-deny_join_id0-b6111e4e7e69

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


