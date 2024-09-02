Return-Path: <linux-kselftest+bounces-16949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AB19685E0
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 13:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4491F22F77
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 11:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53CE184538;
	Mon,  2 Sep 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFAGiXTn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9F185929;
	Mon,  2 Sep 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275598; cv=none; b=g6LavfjGr5TfD73pv8T8MVkQC9Y6ScfIAb04kafHe19S8ipk2bMby1YLEzKFQXn1zxR/vQn63zUxMke+wRW5HAKPheYnOj56enlF9gv6Lhy+K0V1hvj3p43gMl2mC3Ur3guMepdeiUpz2Qsn9iIzgnsVBqEYr5Wa0Cn05nQTPz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275598; c=relaxed/simple;
	bh=Lh10apkf8kKzdpkr8MnJP1w4KklbCDzyTrjepH0xCBc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gBfsELZxs0wfNrm2Ru5t8AnAI+GY19gmkJ8pnvHeD2H59vbb9X6wSg5aJADELtWWG+nu6yojRJmPW6/kgN848PIPjTR2HWdb1Uj6DXVod8MzDtXXfM6Xl4Y0Hb6u6dWFuknMH1+iYumeYYtTUHuobG2bONigVjMiblGzn3aCkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFAGiXTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB7AC4CEC2;
	Mon,  2 Sep 2024 11:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725275598;
	bh=Lh10apkf8kKzdpkr8MnJP1w4KklbCDzyTrjepH0xCBc=;
	h=From:Subject:Date:To:Cc:From;
	b=QFAGiXTn/NNTpRt4zGbQeQ3JyoCTCHZ6s0oxnBn7L2MM6oAHN+2fEDY2vyKi6wfJo
	 ArH2jhQfMfdxvgdCnfXiuD7SbCquUk466bBEV8hhxTtYp/a1DGL7iNk1UOQsDkbjZp
	 rtvr5CdnXu1dF9OzAnus0yvgL69YMH5Rpo3w8Lj2e8uqFlvQP5pD6bsbe0nad+LrmJ
	 /DGVRHIqDfydB+pu05zyXiGxuoCNsb6CxXWOndn1LxtOaShUVxtws95DmFSlgEAvth
	 PjDN/0fLbSWXvgURTkFsjGSeVrpTJwyvNRi2U48h9383Nv2CAHpL6//knu5Du9fq1l
	 DlS2JJUSX2kqQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/3] selftests: mptcp: add time per subtests in
 TAP output
Date: Mon, 02 Sep 2024 13:13:03 +0200
Message-Id: <20240902-net-next-mptcp-ksft-subtest-time-v1-0-f1ed499a11b1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL+d1WYC/zWNQQqDMBBFryKz7kAas9BepXRh47cdimnIjEUQ7
 24QuniLt3j/b6QoAqVbs1HBT1S+qcr10lB8D+kFlrE6eeeD653nBKusxnO2mPmjk7EuT4Mam8z
 goWsjYmjHrg9UZ3LBJOt5cad/TY99PwDf9PfSfAAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Lh10apkf8kKzdpkr8MnJP1w4KklbCDzyTrjepH0xCBc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1Z3LKF/RjUsOdcvtgHjuik5M1EbztS70EWsXC
 tuCgo73RBCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWdywAKCRD2t4JPQmmg
 cxQfD/9bZ1KZt0yyBwgtBjlmhddciMA9zWFIbzxSu268zQOI2k6WH77YLyXPF5rm62GQLQHXjfI
 j1vquOVkH8l3rurqe0I7jRnJu5ZMnSvG4WDv8yMehqefRg/anvehEkdmB8YRCUXEX3ukAMvx5vh
 JEfqpTKSVscVYugtS4RRUQqWGVDb5woZ9aXwMxm87BA/w+7qrzRC4LHvSBz+e3sYFhIOBnXQpF4
 5LJeW/jOz3lI9uoE1j+borPOK0+uECcQkrzrqSXa5a2epLbBpgZet2UzIZvboLmvIZUzZB7QWvN
 KX721PYz39IY7o7P2D8PjCmG/XpbhfHRQLVa/7iWvDW7yEoU/njCpB7tUJ5++9JCknyjZCXbbq2
 tAg76/v/Zae8bG9pOojcZVze7eo0fTJasi2GzK/m//WR6YfqVVYYKzZPZDZfGbeV6MQCDf7M9Ts
 bJYC4wMC/3n4HPVymI9VcGOrNWd/DLC3HD2LqGGxQv4uaqeV/CLdxrZuPsEDTKkjcktJpAiNX7B
 iIKAGcMsI8xdCKRDrKgySGqTiJ/V+lgoh2yjOk7hkinHUyk6pyrUt2kU58CJXl/ot3teWbHi3av
 DELmlg1UHPF3VxhftaLHpX/h0meh/UMe3mVXeEkvdeHOs9/daxWFRhL0mxi1d6yOLjJ7ptI8vM5
 e4uhP2hZpm2nhJg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Patches here add 'time=<N>ms' in the diagnostic data of the TAP output,
e.g.

  ok 1 - pm_netlink: defaults addr list # time=9ms

This addition is useful to quickly identify which subtests are taking a
longer time than the others, or more than expected.

Note that there are no specific formats to follow to show this time
according to the TAP 13, TAP 14 and KTAP specifications, but we follow
the format being parsed by NIPA [1].

Patch 1 modifies mptcp_lib.sh to add this support to all MPTCP
selftests.

Patch 2 removes the now duplicated info in mptcp_connect.sh

Patch 3 slightly improves the precision of the first subtests in all
MPTCP subtests.

Link: https://github.com/linux-netdev/nipa/pull/36
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      selftests: mptcp: lib: add time per subtests in TAP output
      sefltests: mptcp: connect: remote time in TAP output
      selftests: mptcp: reset the last TS before the first test

 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  3 ++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  3 ++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 17 ++++++++++++++++-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  1 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  2 ++
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  1 +
 7 files changed, 25 insertions(+), 3 deletions(-)
---
base-commit: 221f9cce949ac8042f65b71ed1fde13b99073256
change-id: 20240902-net-next-mptcp-ksft-subtest-time-a83cec43d894

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


