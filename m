Return-Path: <linux-kselftest+bounces-14530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CD5942CB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 13:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338991C215AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 11:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED731AD3FD;
	Wed, 31 Jul 2024 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qF7LA2TX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F691AD3E0;
	Wed, 31 Jul 2024 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423974; cv=none; b=ZkPpkxOwWdYb377cxHNyuFQJYggyJi5EPgsVWwI5N7jyYfwf0yB0gfzoci/WUUgbLeUciO8tqDefP9CnaefNg9kFcIWvBMyZajYHX0286/Qi8Uif8S1tLd3FFcqUjlQoYZ8dhGbtC0cPUYPltBJNlji7OMas1F2GVCmZ3ShN4Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423974; c=relaxed/simple;
	bh=/rfAcMxmb9Inbh+7ExU4M83JIezLRz9H62MSXp9vrNo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tDGzAYoOk6cXBqVuhaUjUlwlMuMxE+lj+/kuFIBgEvJJRX/lWl1sPSDBYM4zWE4w5agR/CEkT83iIm3jmPPvHF38T+eG5lmmtYlAnCAGbecgYkuHixVQjrAUOL7cI9jZvvE5jlSC0k+nvjbZL3ZNKVbxUaBBFitU3OQ8+OeWiHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qF7LA2TX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21661C116B1;
	Wed, 31 Jul 2024 11:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423973;
	bh=/rfAcMxmb9Inbh+7ExU4M83JIezLRz9H62MSXp9vrNo=;
	h=From:Subject:Date:To:Cc:From;
	b=qF7LA2TXrhtxHz0qspjrfYX0o76b0TLfCxZ1BeLRgJ9RURp5+BUXm3nDornSLbPnM
	 sJF2LyRn4bgB8gmDsbBtkZU2qCmOxDlzQg97V5hFZGBySFA2uBmW/eovCMH8jftrB6
	 n3XtTwLxaxl3Ft+U6zwBnY2iFCezA68b/eTFKhxdgDpsRTOz4AOaWCeuq/YziGOARp
	 TCPu09ZYSnpi/BCfD7w+5MwDi9+ciB341xNPPc0GM0Lk9AytBprMGcExzzL1dTBs1Q
	 DGTVGNpyp65/Sazlg8x+bup5uJmHDntFiPiedh1piJk3t8AWObSxlu6x3EgikBskz5
	 RXbmfv+IlzgSw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/7] mptcp: fix endpoints with 'signal' and 'subflow'
 flags
Date: Wed, 31 Jul 2024 13:05:52 +0200
Message-Id: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-0-c8a9b036493b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJAaqmYC/z2NQQ6CMBAAv0L27CYtohK/YjyUdoubwNJ0i5IQ/
 m7jwePMYWYHpcykcG92yPRm5UUq2FMD/uVkJORQGVrTduZ2trgmLZncjEIF/3ZOxSckCQl1HeK
 0fFB5FDeh7W24dsbHC/VQqylT5O13fEBtwPM4vt5JEOuGAAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2643; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/rfAcMxmb9Inbh+7ExU4M83JIezLRz9H62MSXp9vrNo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmqhqizHzJ45FoScJiCMQ7UFLVRlOv2AdAuCj+x
 vdgEnTPdlCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqoaogAKCRD2t4JPQmmg
 cwO9D/9jqHN2oEdo0gttmKyD1a4kT3fCPO1IKQNDrfNuky/PjBx6gIYpyHNeAKHVs3GzN2anlyF
 pKzYHhOyK0s5hQaOoBraWzCJJ+xE0ChUOUt8K/R8zvUn2PdNocuPGGeXEfrnAe4eaVZLKIPtfwy
 U5dsNzWpQKHEFNwTwy+6dcwtQXPzYKpEZF2tRXoQl39cLrw6aMryHvJn2Zn5moRnEcsXFtnyOxz
 dI9G+9XKPwzbGFfz+8Ujru1KJNFkhPwkXh8c7pUE/zH6ZhtFnSXcfjhxKPR0dPizZQWQiMRTX8D
 7KfiyiDK1qxkz1CsJIgiHH///JyWUjuiLqvoCQZ8w0Mogr9Dxss+NU3TLSFnskWRa0vaVXq0iX2
 3/2BrqLbfafS32XeQ7biX8un0kxORRm82N2gYZdL4n/5c2m6WiRuaLQZcOKM4rh5gbhmc0cYO2E
 cCQNf1wdqd0o97/3YIIXpiSnq0Yys6zTKSRUQ3VPXSrVuK7Wccp65adYdt36/d1YWEKdFVdIHfs
 VdYxc86G118tVf5zczzx9nK4BDwF270KUxoljII7P3IotkyUZhWmlRVy9jqL13VZjks/7Kl1cWP
 JHOfBT9InfKaB1U3+n7f8qJsgPGtdBQDI4tGk4A4zEuN0IDOnXI2qg9KLnhVZFdZMN6kw4aOJSB
 8sgTIweTqNIj+bA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When looking at improving the user experience around the MPTCP endpoints
setup, I noticed that setting an endpoint with both the 'signal' and the
'subflow' flags -- as it has been done in the past by users according to
bug reports we got -- was resulting on only announcing the endpoint, but
not using it to create subflows: the 'subflow' flag was then ignored.

My initial thought was to modify IPRoute2 to warn the user when the two
flags were set, but it doesn't sound normal to ignore one of them. I
then looked at modifying the kernel not to allow having the two flags
set, but when discussing about that with Mat, we thought it was maybe
not ideal to do that, as there might be use-cases, we might break some
configs. Then I saw it was working before v5.17. So instead, I fixed the
support on the kernel side (patch 5) using Paolo's suggestion. This also
includes a fix on the options side (patch 1: for v5.11+), an explicit
deny of some options combinations (patch 2: for v5.18+), and some
refactoring (patches 3 and 4) to ease the inclusion of the patch 5.

While at it, I added a new selftest (patch 7) to validate this case --
including a modification of the chk_add_nr helper to inverse the sides
were the counters are checked (patch 6) -- and allowed ADD_ADDR echo
just after the MP_JOIN 3WHS.

The selftests modification have the same Fixes tag as the previous
commit, but no 'Cc: Stable': if the backport can work, that's good --
but it still need to be verified by running the selftests -- if not, no
need to worry, many CIs will use the selftests from the last stable
version to validate previous stable releases.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (7):
      mptcp: fully established after ADD_ADDR echo on MPJ
      mptcp: pm: deny endp with signal + subflow + port
      mptcp: pm: reduce indentation blocks
      mptcp: pm: don't try to create sf if alloc failed
      mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
      selftests: mptcp: join: ability to invert ADD_ADDR check
      selftests: mptcp: join: test both signal & subflow

 net/mptcp/options.c                             |  3 +-
 net/mptcp/pm_netlink.c                          | 47 +++++++++++++--------
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 55 ++++++++++++++++++-------
 3 files changed, 73 insertions(+), 32 deletions(-)
---
base-commit: 0bf50cead4c4710d9f704778c32ab8af47ddf070
change-id: 20240731-upstream-net-20240731-mptcp-endp-subflow-signal-181d640cf5e8

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


