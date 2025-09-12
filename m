Return-Path: <linux-kselftest+bounces-41405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CA9B554BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 18:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150801D65193
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E800931AF3F;
	Fri, 12 Sep 2025 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCNI+kgL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58C030BBBD;
	Fri, 12 Sep 2025 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695026; cv=none; b=bGPJswGttXMX6i2HgrLB1mtRp1pV3rX3aIXwU4kaADVI9b0SXNh0iXZ+SBqoMfBv9CLESjS7Vv9FIqjuQwZzbTw/BWRdoGv5D8X4rnyLfX+ihQnEU57uKqZI2htIBCGoOQaKYkjyebwX9HqB5hh44OpYS526K211fcSHr/bkFdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695026; c=relaxed/simple;
	bh=yh4xLWlcA8OHLdyLklXOk+519lgoO0D5wxn1LsqBYRc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mavJhHJ0X+NkMd122V4vs2PiDuMxHTmcm+Hcx+JGXGRL45RAv4s2FGDzjxICWwfebRffeyhKs6RDuq8oHVdx4TPl1+YSR9uU5VuaOMqeepYxbkJilBT1SwdsHAakgczdEBb7EmcqVmq10DgwYLm3j9XpClqSZPfkoK6CI/vfYnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCNI+kgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA3FC4CEF1;
	Fri, 12 Sep 2025 16:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757695026;
	bh=yh4xLWlcA8OHLdyLklXOk+519lgoO0D5wxn1LsqBYRc=;
	h=From:Subject:Date:To:Cc:From;
	b=CCNI+kgLbeQQz1G550kyMApK1z1n+nAFuJ7lxKjjqpeYRZxRilmoURC6OeaingmUA
	 XaAHaAaKYuBqI7ngwAGYqv7dfy5b1ZqmTbHmRCtXCs2qv8Ns9Tvr+aWylrY9HEW6h7
	 oRZ6A7oPQuwZB0kZCUr0Ay3BH0r38i81PepTEbKzejX8PGOest520rGPn3bf6xaUmD
	 5SptnNVm7dlzo+WDM5q4nf3R1Wt9H1rBVCTsH6vtvu8D8oeyzQk63MCdY5tXnxJt7r
	 VF9MwL8y3/GlD7E8BlNOGrm9tac4KKy6Jsi8CZ4HcIOZKp+TN4QAdqfKVxDgs+Gvo7
	 TLW0MxKKHk5Wg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/3] mptcp: misc minor cleanups
Date: Fri, 12 Sep 2025 18:36:46 +0200
Message-Id: <20250912-net-next-mptcp-minor-fixes-6-18-v1-0-99d179b483ad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB5MxGgC/zWMywqDMBBFf0Vm3YFMau3jV0oXwV51FsaQBBHEf
 +8gdHEXh8s5OxVkRaFXs1PGqkWXaCCXhvopxBGsX2Pyzt/cUzxHVNtWeU61TzxrXDIPuqFwx/L
 gIA7SSsAVd7JKyjhfi7zpL9PnOH4PiDfaewAAAA==
X-Change-ID: 20250912-net-next-mptcp-minor-fixes-6-18-a10e141ae3e7
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=945; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yh4xLWlcA8OHLdyLklXOk+519lgoO0D5wxn1LsqBYRc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKO+Gj37O8LPZu3a43K8g3nvavexLqUl+yLfud60D/gI
 5dwsv/3jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIm4rmFkmJrNmrfb/drur9+Y
 Pm7cJ25q3SrYFqxeZRnQHFGpzy9qyfA/Xq7f5/knmWz73bzhc42m1D089fpgCeeBM+W+LPUzcuU
 4AA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are some small unrelated cleanups collected when working on some
fixes recently.

- Patches 1 & 2: close file descriptors in exit paths in the selftests.

- Patch 3: fix a wrong type (int i/o u32) when parsing netlink message.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (2):
      selftests: mptcp: close server file descriptors
      selftests: mptcp: close server IPC descriptors

Matthieu Baerts (NGI0) (1):
      mptcp: pm: netlink: fix if-idx type

 net/mptcp/pm_netlink.c                            | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 9 +++++++--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 9 +++++++--
 3 files changed, 15 insertions(+), 5 deletions(-)
---
base-commit: dc2f650f7e6857bf384069c1a56b2937a1ee370d
change-id: 20250912-net-next-mptcp-minor-fixes-6-18-a10e141ae3e7

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


