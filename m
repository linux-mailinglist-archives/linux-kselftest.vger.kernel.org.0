Return-Path: <linux-kselftest+bounces-14295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74FB93DDEE
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 11:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBABB1C214A6
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 09:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB4F3CF58;
	Sat, 27 Jul 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/Sk8GaY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D682E851;
	Sat, 27 Jul 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722071070; cv=none; b=XrwsZg2l6yjY2GphT6EiJfedy6kc9imEzglnwBMql3CRS6rFcWlcJKbYkYeytLxbe6w96IrXdgzXRkfqp+0Ej3Sso0uzHRcEkiHmsI9SLS/n2vG5+rNSk4nt4oG+qC4aioIsYN8k58akY11j4Xc7MbNQirRWRxrGqKSuohdlSoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722071070; c=relaxed/simple;
	bh=/WInVHz5/5nRA9OxCUOUNLKXu8jpoFq68RMMSbHKe5E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u5sBNPm2rIm3VsNpcPYGHS37WtoM4tcXTLUefusT7Q+ZIQ5cuzfB1LCN0olFR7EvkfjN/cY0KgY8O4Gro9wNc1HLV9FKDMPSUCC34ZQ64FDniL/uGaXYgYG3yNRLCZZ0s7rQwIi3WI885YBxPcDPkQxfjylTawE8WVEtUlA3eXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/Sk8GaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9AFC32781;
	Sat, 27 Jul 2024 09:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722071070;
	bh=/WInVHz5/5nRA9OxCUOUNLKXu8jpoFq68RMMSbHKe5E=;
	h=From:Subject:Date:To:Cc:From;
	b=i/Sk8GaYSHLmG6xaru9tAb1cXQ0Yhp6rlJxa+yZlVjkDJRdcPJTxuueQf9jqpAS1+
	 bQfYYt7dA7f05m1yY6PfKiY7z9EOk8cza8texrdD0RUvYxPD5iqAmsQp6TnUyyGW2C
	 nsWnjFtJNsioJE08dODQATkLd/CmBCbzj6fvN1wpVeaTjt86t4bbybOQVar5KoCiMH
	 19ekswhA7fkFeVYwwl5hKOgcndVX5BDCu3jX/otlBz76ggBqChP1ubNfNJHmd6kJaG
	 V5CKVPnyK74KBOXc61yXVTpfSy6p6vJZOlLkdVHKm/xcTUpL0oYqvP8uYYBvVCchXr
	 hMD0hmqCdL0FA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/5] mptcp: fix signal endpoint readd
Date: Sat, 27 Jul 2024 11:03:58 +0200
Message-Id: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-0-1e7d25a23362@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP63pGYC/z2NQQqDMBBFryKz7oBNpUKvUrpIJqMOaBoyUQTx7
 h1cdPk+j/cPUC7CCq/mgMKbqHyTwf3WAE0+jYwSjcG1rmt798Q1ay3sF0xc8b8uuVLGQXZUGZO
 f0ZQYcXhQ70KgQBzAkrmwOdfdGywAn/P8AZb+Ik2DAAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Liu Jing <liujing@cmss.chinamobile.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/WInVHz5/5nRA9OxCUOUNLKXu8jpoFq68RMMSbHKe5E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpLgaBDm+3i6X4MsqXmUeEy7qTiBIm9QanpXIW
 fP6uG6a68SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqS4GgAKCRD2t4JPQmmg
 c9tkD/95oI0gsFL0AZCjhsBoaM4P0cWBz8nY8uTAVquxZyNe688ZZxp124XHZrFzRBhQzhDm6u0
 ZR+zXx/gtbubfeDbmuSrYrLeD439KiZpfKsIwVq06u7ngI+UpfbgD5TN/zYCM3SiONV0Mnz8SSz
 AaTl0qk87C4lCfpEU3OYOYYxonY82NrClJIG4GgW7Gegid4TfKUtxvk0inMMX3BcT23rdUFxGkX
 hdM0jkq2g3R/4knwrK3+fIgFzAD5+3Bsy4NaZN4iwCIB8JOGOXcWbHXSKBDEck83U0DVJn5AE0m
 GOMv+G/ozdBYpFdX9m546Yx/JMjdUTf92fsMwQx34SOwWlFCZZA9Kos1A5rt0sOV9Ny5m9Po9Ec
 v5aUZIcrc4/BlWNjiRGNKIlO6atwNsgTPL/E9u8Dc0W0O9RoFm6kGV2nqqNUY/iO7rn5+Jesdxp
 rGr/DG+LzwgoXEESD0JoqcoV3iRzkTKOA+W2AZ8d2fjC33SDZK1wGAcu2OiNPz/MKVUQRjDsdXg
 DdXVTM4SBQPdK5VF1hw+NljhpgWweU/7l8lLVYqpJLQ6t0mWPkb/odiBhn1dn5OD2E1TOGdT/Sc
 ldX8AbHZAOERl9V7vZs8EGq+GT7iDwmDL9Hn93oDJs9WOMEOsDlojaogwOVX4H0TBkbf2pV8GTs
 +OYf6C1+hsfiOpA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Issue #501 [1] showed that the Netlink PM currently doesn't correctly
support removal and re-add of signal endpoints.

Patches 1 and 2 address the issue: the first one in the userspace path-
manager, introduced in v5.19 ; and the second one in the in-kernel path-
manager, introduced in v5.7.

Patch 3 introduces a related selftest. There is no 'Fixes' tag, because
it might be hard to backport it automatically, as missing helpers in
Bash will not be caught when compiling the kernel or the selftests.

The last two patches address two small issues in the MPTCP selftests,
one introduced in v6.6., and the other one in v5.17.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/501 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Liu Jing (1):
      selftests: mptcp: always close input's FD if opened

Paolo Abeni (4):
      mptcp: fix user-space PM announced address accounting
      mptcp: fix NL PM announced address accounting
      selftests: mptcp: add explicit test case for remove/readd
      selftests: mptcp: fix error path

 net/mptcp/pm_netlink.c                            | 27 ++++++++++++++------
 tools/testing/selftests/net/mptcp/mptcp_connect.c |  8 +++---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 31 ++++++++++++++++++++++-
 3 files changed, 53 insertions(+), 13 deletions(-)
---
base-commit: 301927d2d2eb8e541357ba850bc7a1a74dbbd670
change-id: 20240726-upstream-net-20240726-mptcp-fix-signal-readd-f3c72bbcbceb

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


