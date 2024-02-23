Return-Path: <linux-kselftest+bounces-5347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E783A86175C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D28B24FFC
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30C0126F3B;
	Fri, 23 Feb 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc4/2YyG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCFE84A33;
	Fri, 23 Feb 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704879; cv=none; b=hA69EWozCAMQ0OEEymYDjAkGVSOrdt5OYlVWGHr4tYzLdQnrPUlB1bzAkyyazW1b70G+tLHpvSoNXOMFXpt4afiUTo5SYsZL44JzBw39+bdOOm3i8ar3sUu0pPtthJ24ZGshQXsHAzRrdNwdrnNtzdybsFjUDcw0VM3vrMV8RW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704879; c=relaxed/simple;
	bh=7DVxqDB8uewp//XF8YJru8VTzsz0mpG0zYO9Y23VmHM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l9m5agouUkW/yBkV0owJriOKAtYR3yp6An+7ZmHAIwPzh4EuG9JSGcM3cArOuh9dqUlMfB5KQgWFSco0cL5/+8oQQN7ia2Yfn9Up5z5nDGZoqtJi2ZcLtf5EWGoMzZmWeCWStXEFlFjMTPQaSlfacDbPZtxFbl29GEcDIOdWyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc4/2YyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1A2C433C7;
	Fri, 23 Feb 2024 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704878;
	bh=7DVxqDB8uewp//XF8YJru8VTzsz0mpG0zYO9Y23VmHM=;
	h=From:Subject:Date:To:Cc:From;
	b=Yc4/2YyGTes8mFZtIggimGKzLlEXLqjvHSMpcbSBatdiuG4c2YEJ3aDonblQB/tPG
	 B7mUxSEoSpPGT+uZ+XyGA+uoLDEMBCniuK5va2Ta9zSa54EFz+c30cR8mEG493k/BZ
	 kAmjyWjDMo9WFVbX/EqqczKw2mcCxqOAfvzgwOqghR6sauQT/DcvFj3Ft55PlVFxaz
	 X0CDZlKNYt2kjmYEHahdknCsVRYU/T0OXBAmzwIaJRHnkAvItdOvWHOToZnn5WDYhP
	 zOPEG3C9uW2fxV+rrpLHmOGA+lFsN/gjilGaBWJDWLnkjh9vnHS1pn+t4EjmhZMfWs
	 BQJf4jzfA+4nw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 00/10] mptcp: more misc. fixes for v6.8
Date: Fri, 23 Feb 2024 17:14:10 +0100
Message-Id: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFPE2GUC/z2MMQqAMAxFryKZDdRWHLyKONQaNYNVGhWheHeDg
 +P7n/cyCCUmgbbIkOhi4S0qVGUBYfFxJuRRGayxtbHW4bnLkcivGOnAf11ZAk58k2DVOBPGZnC
 D8aCZPdF3aKUDlaB/nhffgTyddwAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>, Shuah Khan <shuah@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>, stable@vger.kernel.org, 
 Davide Caratti <dcaratti@redhat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2895; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7DVxqDB8uewp//XF8YJru8VTzsz0mpG0zYO9Y23VmHM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2MRqF4nBD0UH9ACvTixOZlO/DUTXXCQBGWQyY
 zBQPYkgRgCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdjEagAKCRD2t4JPQmmg
 c/WGEADEIi/qT4lghTbjp7V4HEaaMYXbFsTmGI6otb9GH5BFgxWceGSwQ4kca4H23jujCGBoRbp
 KBasrw5HPIyX47T7LyUWKyOJa9yR882cwOokEb5SY1ALZ81whj8K9cYqHu9Ocgjczb1aWN3EtQR
 4+gjUo5evxyRt7Y+n4lYK6Je1Gjs2FAUY89qO8U0hPZmQ0PJZegFY/+n9NdOQobvelGobCQREaU
 y27FPgyf3a+ERCN8dUpaEJdAbD1LTeq10cVT2s3UAWWjqQQY0vw1MEiPRb1+pU1WVwxOPBYPBmh
 XawR+hbiK/9P68nDK3nmi5HONDiuSwkUXb3S/eWm4l9XJpPvdinh3v/OKKrQj+sn8c/sbqYtJWk
 OS0HO/8P192AGG24TiEupWa2wqrnGNUAfbbAL2E73LrdMUGNIu7k//oeCjvRaPPPVOljyrAqcHZ
 vdMTxeH5WJzVO5GfdvmHrDnEciJSyRQOmGdFT/D5GZTw70+fXWhf99FfCOFWgMyiqeni0pHBOG0
 TIUBOsNaurxXWrY45QheJsSo2gvVjC80dw1i0v39cpveJl4aDdNC9C3DBz02DMnCDf5RuZzRReh
 jMlZBUwPE4QMl59SWJy9Mm1gM3/K1eFgJqF0YWV+B2+/HjleZKQGfL+LK2dAd1JBJAYNe7UkfK5
 TkcsrHqqOQ/WWFw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series includes 6 types of fixes:

- Patch 1 fixes v4 mapped in v6 addresses support for the userspace PM,
  when asking to delete a subflow. It was done everywhere else, but not
  there. Patch 2 validates the modification, thanks to a subtest in
  mptcp_join.sh. These patches can be backported up to v5.19.

- Patch 3 is a small fix for a recent bug-fix patch, just to avoid
  printing an irrelevant warning (pr_warn()) once. It can be backported
  up to v5.6, alongside the bug-fix that has been introduced in the
  v6.8-rc5.

- Patches 4 to 6 are fixes for bugs found by Paolo while working on
  TCP_NOTSENT_LOWAT support for MPTCP. These fixes can improve the
  performances in some cases. Patches can be backported up to v5.6,
  v5.11 and v6.7 respectively.

- Patch 7 makes sure 'ss -M' is available when starting MPTCP Join
  selftest as it is required for some subtests since v5.18.

- Patch 8 fixes a possible double-free on socket dismantle. The issue
  always existed, but was unnoticed because it was not causing any
  problem so far. This fix can be backported up to v5.6.

- Patch 9 is a fix for a very recent patch causing lockdep warnings in
  subflow diag. The patch causing the regression -- which fixes another
  issue present since v5.7 -- should be part of the future v6.8-rc6.
  Patch 10 validates the modification, thanks to a new subtest in
  diag.sh.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Davide Caratti (1):
      mptcp: fix double-free on socket dismantle

Geliang Tang (3):
      mptcp: map v4 address to v6 when destroying subflow
      selftests: mptcp: rm subflow with v4/v4mapped addr
      selftests: mptcp: join: add ss mptcp support check

Matthieu Baerts (NGI0) (1):
      mptcp: avoid printing warning once on client side

Paolo Abeni (5):
      mptcp: push at DSS boundaries
      mptcp: fix snd_wnd initialization for passive socket
      mptcp: fix potential wake-up event loss
      mptcp: fix possible deadlock in subflow diag
      selftests: mptcp: explicitly trigger the listener diag code-path

 net/mptcp/diag.c                                |  3 ++
 net/mptcp/options.c                             |  2 +-
 net/mptcp/pm_userspace.c                        | 10 +++++
 net/mptcp/protocol.c                            | 52 ++++++++++++++++++++++++-
 net/mptcp/protocol.h                            | 21 +++++-----
 tools/testing/selftests/net/mptcp/diag.sh       | 30 +++++++++++++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 33 ++++++++++------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  4 +-
 8 files changed, 128 insertions(+), 27 deletions(-)
---
base-commit: b0b1210bc150fbd741b4b9fce8a24541306b40fc
change-id: 20240223-upstream-net-20240223-misc-fixes-1630cd6b3b0a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


