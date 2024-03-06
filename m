Return-Path: <linux-kselftest+bounces-5978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2786D8732CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0851C2145E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 09:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE76E5DF34;
	Wed,  6 Mar 2024 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk5A19O3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB010433C5;
	Wed,  6 Mar 2024 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718186; cv=none; b=Yjv0OXKWUcH1p0KoRbptILFLH3AfkF5FQqZHvRjgp0YQElT6x1u1guHt2Lg/KYdJxaXVgsMUZQ3kQSTyGjbECxi8dQEqI5Dy0W2TvWzx6CKNexSkNIKgsUZG98kmolVVcZa7AErSTz5ppEVlOIvFbYnrLeKIqmSZnuy5deoRnJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718186; c=relaxed/simple;
	bh=Y6OeUIFhACV1w8LgiRWi1ucYYzz5y/Z3CdvHWuXr3tM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FVWrL06e51u2mWaybhbr5qI1YrGnH5iv4jqQOgO31838qkzfWfJpo1RnBineTN5xOvoY2cOfHpGTVSKj83vreyyjlS3GVoUbZix4+JNs0jWjGz5rjjTp7vhn+cPWomgI6kapKFTbEJ8SfA/PyLm+xYjkRqVh3qz+mld6aDQinfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk5A19O3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD53C433C7;
	Wed,  6 Mar 2024 09:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709718186;
	bh=Y6OeUIFhACV1w8LgiRWi1ucYYzz5y/Z3CdvHWuXr3tM=;
	h=From:Subject:Date:To:Cc:From;
	b=Rk5A19O3V7nk4YtyIQoPlY9Frr0CfHp6Sj89uJ0pGG3buLNhXLcWpM6MwA/fGKWow
	 JMOia1ZEzl48p9Jiush0eoDNAm+b3AATId/rs39HdCXNXJdw4NOOnKQheH/z4/SIlJ
	 2jVEY+VCsbsRhrVKRdxV2/pienzBukSCyDnsCt3v1Pa0GkAbWGvCdbjriV7EIeHjei
	 vbDfiIMACYmMFQSMaqhx2k1yfMtbM6NVX+gMaU8KO39eX8VNjEkPJK9U1Pi7Lb4lkP
	 pxaefT4fEW9NN08mULvMgG5uMlXH3Akzlcm7jF1wDmDzTfIrPSz9Digv7r4XFjKdDK
	 oBlqrvWHurHJQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v2 00/12] selftests: mptcp: share code and fix
 shellcheck warnings
Date: Wed, 06 Mar 2024 10:42:49 +0100
Message-Id: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJk66GUC/62OTQqDMBCFr1Jm3SnRRild9R7FhY1PDf6FTCoW8
 e4N0vYEXQzM44P3vpUE3kLoeljJY7ZipzGG9Hgg05ZjA7ZVzJSqVKuz0vx0EjzKgUeEeEvgHxL
 0dYAE4cEF41ja0qNiM1WIP/retDAdJ7mqDR6ZgdYUd5xHbZfd4U7fVioiaa2Eyb92uTnZ+Wcs+
 4PHnLDiPM+TC8osUxq3Dn5Ef5p8Q8W2bW+0HgrDHQEAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2528; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Y6OeUIFhACV1w8LgiRWi1ucYYzz5y/Z3CdvHWuXr3tM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl6DqmDh80NvIFkK0dyhBctExEu31+F6+md5WI+
 BUY0H5bE0iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeg6pgAKCRD2t4JPQmmg
 c8dDEADk/Wj5WzxLrbR8NXtfVTLBwEy9uIeUrN+Os3Heh5JplO9kA/vEq5YuLUubWN3yphFOIwJ
 Pn7gMrnFyv0GjCc6NaD+hGXcScoWYX3cKMDde3fAe3JePZACbOjishLu7EJd4lyZvuPXF2hSxdD
 FR9gm1TwiyRTz6vmxgEa6LOAXT7slFI1oqWIxfE2VcnF2w9QcvJl98YEpqJPDGFNtREm9VsmDHk
 AYR0B0RwgudAJkXmI88cbfROsWAlSJnjcXgCUeoi6PFd3fYiWhfbZheadiYcs1B3YzjnCJRpB0g
 nS80p/OlVbZdJsugfluqwChsjUZYlfnVwV+Omm4H/x+VHtodHCaXUDbyteKPNgce9gqhujBpAza
 EVnF8ijUxdCzYexTNZKXi/csNmvJaqM0x8MLHYTfnYhUvMZ5QzP/uyl1X/Q6ZGo7jdoPB7gXrOs
 spVCsK6S1CgLA94KooqauBVcLt+h6ofcNbRmHBWA7gDQsecHhJozQ6K88dC8QgIVgwg/7jh6RA5
 ede2Su9ItFELZTGpzEzFiiL6IQ+J6tgri5dH0iiwr+jEUYGdfTTNOvMGfv3x9keyb+FlywqgyiM
 0CI1DRHfim6pFeKgC2t2XLSERVZS8j1w64k5bxpwAXKMHNU4fQdKxp1i9p7t5Uh6FmOuTvCRkTr
 INd9JqWjxPVvMzw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series cleans MPTCP selftests code.

Patch 1 stops using 'iptables-legacy' if available, but uses 'iptables',
which is likely 'iptables-nft' behind.

Patches 2, 4 and 6 move duplicated code to mptcp_lib.sh. Patch 3 is a
preparation for patch 4, and patch 5 adds generic actions at the
creation and deletion of netns.

Patches 7 to 11 disable a few shellcheck warnings, and fix the rest, so
it is easy to spot real issues later. MPTCP CI is checking that now.

Patch 12 avoids redoing some actions at init time twice, e.g. restarting
the pm events tool.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- The former patch 3/13 ("selftests: mptcp: add mptcp_lib_check_output
  helper") has been dropped, it was not supposed to be sent.
- Link to v1: https://lore.kernel.org/r/20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org

---
Geliang Tang (5):
      selftests: mptcp: add mptcp_lib_check_tools helper
      selftests: mptcp: add local variables rndh
      selftests: mptcp: add mptcp_lib_ns_init/exit helpers
      selftests: mptcp: more operations in ns_init/exit
      selftests: mptcp: add mptcp_lib_events helper

Matthieu Baerts (NGI0) (7):
      selftests: mptcp: stop forcing iptables-legacy
      selftests: mptcp: diag: fix shellcheck warnings
      selftests: mptcp: connect: fix shellcheck warnings
      selftests: mptcp: sockopt: fix shellcheck warnings
      selftests: mptcp: pm netlink: fix shellcheck warnings
      selftests: mptcp: simult flows: fix shellcheck warnings
      selftests: userspace pm: avoid relaunching pm events

 tools/testing/selftests/net/mptcp/diag.sh          |  35 +++----
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 111 +++++++++++----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  60 ++---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  68 +++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  55 +++-------
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  31 +++---
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  38 +++----
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  56 +++--------
 8 files changed, 210 insertions(+), 244 deletions(-)
---
base-commit: 09fcde54776180a76e99cae7f6d51b33c4a06525
change-id: 20240304-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-160fceb5ce44

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


