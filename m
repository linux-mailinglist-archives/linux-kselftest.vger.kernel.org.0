Return-Path: <linux-kselftest+bounces-14302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E89593DE82
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 12:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5472839AD
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 10:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19BF4594C;
	Sat, 27 Jul 2024 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok4AWHb4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AADB328B6;
	Sat, 27 Jul 2024 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722074602; cv=none; b=tURSkxlw2xw1zwkrUApuXGdEjz2mUMxfnTrMbEuOYuKAnzIh9/C7J0RNihAvMDVY2UyYzuXqpDRz4IkrfNPhN7zt+sFkEVA7XTTttjVONCu0dtD5UuwZ76PoYIsaZEloROAsvqoDnGoLD9Ged89jv+AQW5YYHMyRQDvhVCqeTWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722074602; c=relaxed/simple;
	bh=Z15GjYBZCh0HcGaZaCE/4VnIjxekyMTKY0iRxlGu1PA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MHVvu16xXim+eGK0vHZSxB7CKQybbCGq/QIBc2W9CQDnhgz4qa/R4L354gGj9KSLDzlu84pYGVjMmN0XIbjs3BzFMeLMVjli2mgEZAG29+JCxTL6UuPIQyfFacpPCczSgGhx+cCyWhZfKBHFbPvoxL1vK8N+CBAwu83ALqO84Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok4AWHb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77796C32781;
	Sat, 27 Jul 2024 10:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722074602;
	bh=Z15GjYBZCh0HcGaZaCE/4VnIjxekyMTKY0iRxlGu1PA=;
	h=From:Subject:Date:To:Cc:From;
	b=ok4AWHb4QaT3BZQStD15E36iUCU2UuDBcNPlFOIA/DhOH0azzybPlLfvzbSglEIbB
	 69WRkdqlckQBFasTxvqUJa3OkbGDLyCAYzTqouNn5NH5Ln0x7uBVIMP4/Ypi3+91nx
	 0VjFEPmwpT+iUvzd2Zyn6yueK+5ksV6vRv16s0UKhLycxD+W/gaXVfF2c92C82NslT
	 Q26gG7Dl+Vl8uofcKh3jrDQAevL5hut2L1xglpuin3UPu6p3iYhRZrQ34FF4xAyYrW
	 HeETB2+viF2VZZjKu4hPh/sPKNCN2gbDFEPeAA1Cl2DhidvXQr85y5p/0R3O/t2B8Q
	 SmfpxvOlAjorw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/7] mptcp: fix inconsistent backup usage
Date: Sat, 27 Jul 2024 12:01:22 +0200
Message-Id: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-0-f50b31604cf1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHLFpGYC/z2NQQrCQAxFr1KyNjDGSqtXERdxmtagHcNkKkLp3
 R1cuHwf3n8ruGQVh3OzQpa3ur5Shf2ugXjnNAnqUBkoUBs66nAxL1l4xiQF/+tsJRreOD4WQ9c
 p8RNPbU+H40g8hB7qn2UZ9fNrXaDacN22LxQ5gKyAAAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3260; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Z15GjYBZCh0HcGaZaCE/4VnIjxekyMTKY0iRxlGu1PA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMXlT5eTB1icmHhpv0jNQaUD+kXrTj7d4lnyU
 VRbbOKUdgaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTF5QAKCRD2t4JPQmmg
 c80rEAC4OrIKiaeZgNf9fW+ItbNT/z72+ZfFjWqCFiN4s0EIaTDtxXDJ1VSScHeg/YXeE9Cpqvi
 FmK0vhIK/5pYs9W3EJTPSr+VBxvvm67VhgrnnUixnIvrXhpWr8rqZAi6dPuGGSQvUSlmwH/TEN2
 gNFhOABr3/g6D9tzbKs5tn03v35sD0Fce6KjG9pnGQPc+hV+BBLbtHgEo/nKeXh3ZTJmFBAIWjm
 ZFDvHFM9455J3gg5uYtL7O26WTZNOhtUplm+q4K/mPqurrVFRSGU7DHYEyy+KbJPW7QjckqG3eP
 KEpqZGZqsPjIeBZZ/dH3pncnUHKSeX0fwkQAkKc+SxecsVxugNWr94s8Y98/cf4q9L8AW3H+iy8
 5YfTiveoY13H2k3ybT63Ah+7tYWaZm7oAYhcPwXFhHaeP3iGZg0WqGF1c7FDPXbJwAAtIcHTxCo
 Bral6iKRxAAqxTM4S6iHDYhL43T0Wl88I4xOXNbJTLtELT4UoKCHUpLIuINJWbfaOMhjYOJ8jJo
 ksWrPdeoTPVqRKMqWi8P8CJbOFuyNcuHpS4s4hUaiF0x728Eu9n9E0Zla0r4bVlrsOkRjyc/k4z
 vuA26TKI89vF2Y45qInICfadQs9OK4w6p0sYzZirm6oCr9ejCezbmIUK+GaTZ/I7dB1UFuCJqNS
 qGQnhhmzxn3VXuA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In all the MPTCP backup related tests, the backup flag was set on one
side, and the expected behaviour is to have both sides respecting this
decision. That's also the "natural" way, and what the users seem to
expect.

On the scheduler side, only the 'backup' field was checked, which is
supposed to be set only if the other peer flagged a subflow as backup.
But in various places, this flag was also set when the local host
flagged the subflow as backup, certainly to have the expected behaviour
mentioned above.

Patch 1 modifies the packet scheduler to check if the backup flag has
been set on both directions, not to change its behaviour after having
applied the following patches. That's what the default packet scheduler
should have done since the beginning in v5.7.

Patch 2 fixes the backup flag being mirrored on the MPJ+SYN+ACK by
accident since its introduction in v5.7. Instead, the received and sent
backup flags are properly distinguished in requests.

Patch 3 stops setting the received backup flag as well when sending an
MP_PRIO, something that was done since the MP_PRIO support in v5.12.

Patch 4 adds related and missing MIB counters to be able to easily check
if MP_JOIN are sent with a backup flag. Certainly because these counters
were not there, the behaviour that is fixed by patches here was not
properly verified.

Patch 5 validates the previous patch by extending the MPTCP Join
selftest.

Patch 6 fixes the backup support in signal endpoints: if a signal
endpoint had the backup flag, it was not set in the MPJ+SYN+ACK as
expected. It was only set for ongoing connections, but not future ones
as expected, since the introduction of the backup flag in endpoints in
v5.10.

Patch 7 validates the previous patch by extending the MPTCP Join
selftest as well.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (7):
      mptcp: sched: check both directions for backup
      mptcp: distinguish rcv vs sent backup flag in requests
      mptcp: pm: only set request_bkup flag when sending MP_PRIO
      mptcp: mib: count MPJ with backup flag
      selftests: mptcp: join: validate backup in MPJ
      mptcp: pm: fix backup support in signal endpoints
      selftests: mptcp: join: check backup support in signal endp

 include/trace/events/mptcp.h                    |  2 +-
 net/mptcp/mib.c                                 |  2 +
 net/mptcp/mib.h                                 |  2 +
 net/mptcp/options.c                             |  2 +-
 net/mptcp/pm.c                                  | 12 +++++
 net/mptcp/pm_netlink.c                          | 19 ++++++-
 net/mptcp/pm_userspace.c                        | 18 +++++++
 net/mptcp/protocol.c                            | 10 ++--
 net/mptcp/protocol.h                            |  4 ++
 net/mptcp/subflow.c                             | 10 ++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 72 ++++++++++++++++++++-----
 11 files changed, 132 insertions(+), 21 deletions(-)
---
base-commit: 301927d2d2eb8e541357ba850bc7a1a74dbbd670
change-id: 20240727-upstream-net-20240727-mptcp-backup-signal-948235f2ad08

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


