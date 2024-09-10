Return-Path: <linux-kselftest+bounces-17647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A82C974303
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 21:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8E91C2533E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 19:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE9A1A3BCA;
	Tue, 10 Sep 2024 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8VeGU5w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F6A194C77;
	Tue, 10 Sep 2024 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995221; cv=none; b=WUgbSPsSF8xDJyjmlpLwo16m2tb7qlLWRX+WWq81euQb4Mt/gLJ4ymLM07ujeEENnp6L/F6X9hPV7/fckm0bOdkV5GNbyBJbtTcz7K5dz7WVu2LaM6WDTL6CzxW0lugs5o91QabetXAehIrp7e4nndMCFOsccS85A0Lji0hr62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995221; c=relaxed/simple;
	bh=AEl+XWnBo7uqP/QHSL4Rbk+JcONDvvX5zrFxYRMYfeo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aTYAls7OsVp1OiRHaI3LkPTTxbhvHoPWOAE82L9vFH16diGvdSxjzEM3lcErz+wIY6QK/fdjTJEi3TpeQz/kx7fOrZcElzzEwijXyzqHC4lep92SLs2OyEmfCpl6upQ+9Ibv0mr8Bio4UVk5PykrbPOoRe1+hwWWPsOQ0eMzcAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8VeGU5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F61C4CEC3;
	Tue, 10 Sep 2024 19:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725995220;
	bh=AEl+XWnBo7uqP/QHSL4Rbk+JcONDvvX5zrFxYRMYfeo=;
	h=From:Subject:Date:To:Cc:From;
	b=o8VeGU5wxKTFKDHd/Zq79lxv2WqJV+ph2ocHko5wrdxdyrKDoQSPkS5PvawEigqIK
	 Apqxdez3s7U7IxEgmlajeEspvhXno8wBFH3WDod8XBr5MFBgN/6cWpBtc3RddDcpy0
	 VhPwNEH19Gpt9lO23s7HbeDANsaQNO08J5Mh44UJcjFIDWuncmNPNgDZviDJRF2TJI
	 NRGMhnvdkJpq7U3sjF4H22HvsyDlg9H73SQkMj9+GvnpXgj7dJK8msMoEvkCHQxRVK
	 x3Rl1dzmgYhY8QSAfLSrbSWgpq0I2u2JRtHCRtXZVCPmstjZWnR6jDhQNETIkQ2Dh+
	 OBqsMSTkSdFvw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/3] selftests: mptcp: misc. small fixes
Date: Tue, 10 Sep 2024 21:06:35 +0200
Message-Id: <20240910-net-selftests-mptcp-fix-install-v1-0-8f124aa9156d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALuY4GYC/x2NQQoCMRAEv7LM2YFsUNj4FfEQY68OxBgygwjL/
 t3BY9FU10aKIVA6TxsNfETl3Rzmw0TlmdsDLHdniiEeQ5oDNxgr6mpQU351K51X+bI0tVwrx9s
 SM045pbKQv/QBn/+FC7lM133/AaH2ish2AAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=936; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=AEl+XWnBo7uqP/QHSL4Rbk+JcONDvvX5zrFxYRMYfeo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4JjQO/OcS2v+crSTacELJ2iXNcYW5NhoqD9aN
 UNtPPUlW4qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuCY0AAKCRD2t4JPQmmg
 cxD3EACNvE1PFEfPnkuhoFb/wF6TQtY/EuUxYLg8PzHSGh2wgTfH2Lj27XAx/VdmcdmRE0eoHYj
 tOLGKFa5PDakgjHOpkOhgJoQnCaa1eF3IDUUbD9xUdt3NiywFyGJjaogymocsMKW7FTZNyFQTlp
 R7Tfv43nGW/xuS4rQAKKprtqnw8nZsRRQXj54jKdxljbRqGVQyvnodLpmHXiwoBaUirmbPY6iSJ
 rCXmV/5Q0WBRXZ1NP3P8+7vGYjSzLkewJw0/Ye0kCpZrkbmkb/i0IfddBaflJ9H9zAc2gWupwNd
 mQgQdJIbLFXJNyCoeLJf+2/M/H7xDxxSqvpJUd6jLNZBWkKw1ULwNzf95b7q2HxZOrJEb7CtEB5
 TCLIwr8FLe0EgmYPYv0/EY8lhvwD+CUgsQBpn0PJaeMF2gRVwUReAVx+wqWkhYLVYLsWHWXdfhP
 ZIIY3qWM53y06bBgDLuD6DtptobCoVaxttWwNOyZe9/lf2ZUHWpoJSUaSXaC5VMJ6Qm+oTGHTH5
 PcC+JcNE9DjEV3mbIUKQK5xrHuaQMEXEHd96u+1geZWFpX427Qx/Jsrg3QrpbClnjzCkx1YBqxA
 oI5Tb5QmrgInvyutZM9fnw1tThfYnUuQ96RpbH7aH+HKgJwyckHRYV1fgDsdGBIpx9L5mSNFrGE
 TzjhKUCmzPDvMiQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are some various fixes for the MPTCP selftests.

Patch 1 fixes a recently modified test to continue to work as expected
on older kernels. This is a fix for a recent fix that can be backported
up to v5.15.

Patch 2 and 3 include dependences when exporting or installing the
tests. Two fixes for v6.11-rc1.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      selftests: mptcp: join: restrict fullmesh endp on 1st sf
      selftests: mptcp: include lib.sh file
      selftests: mptcp: include net_helper.sh file

 tools/testing/selftests/net/mptcp/Makefile      | 2 ++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)
---
base-commit: 48aa361c5db0b380c2b75c24984c0d3e7c1e8c09
change-id: 20240910-net-selftests-mptcp-fix-install-2b82ae5a99c8

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


