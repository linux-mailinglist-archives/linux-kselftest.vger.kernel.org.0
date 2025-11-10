Return-Path: <linux-kselftest+bounces-45245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AFAC48862
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 19:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F5B34EA082
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 18:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B56732A3FE;
	Mon, 10 Nov 2025 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfmALfXQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542313218B2;
	Mon, 10 Nov 2025 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799048; cv=none; b=g9CIn/RtX8SU63OSHyDaNQP6L7htf6eB0pNTLajLE/nphpMLEJGGjWt7MPfeJQ5b+XegW92dnXuvmSAQ5gJUI0BNqquFZjbICy5A5IRzV1NwIX23NXCzmtq8p2Mobivc//uluMborKPkF7x3qt6xsRWdMwavrMFPi23rwvmFwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799048; c=relaxed/simple;
	bh=QcmGZgGER1WlXItZoFVk7+ynEwglcHKP6PhNd97EWUE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j9nDYX358rQ3j88ajCJTb3TWUzm6SFQUGUqvjxdxIX3eydYkCdLc5GfTjM/Xh83uPiyZPZY8WtjTQg0bBoq7v5hLVEG4iEBkZ1NSwhraTvzv7tGV5Ay9aqsV9xkL7gUjSxwEID6PZMmmXjBEnsk30by8r4ucnM3GZHXhCsCjiPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfmALfXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74819C116B1;
	Mon, 10 Nov 2025 18:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799047;
	bh=QcmGZgGER1WlXItZoFVk7+ynEwglcHKP6PhNd97EWUE=;
	h=From:Subject:Date:To:Cc:From;
	b=NfmALfXQnMY1e1gphmkgHCGJX2FyaE3AQpzFkPx8ZuKsEE0lYZFtTUWDsAFji4iLz
	 nYIgxoId+qggpDtBM+7E3hFrNWhhKm3BLcpY0D9OKUnv6TS05xoI7i7ai6pXw0DvTV
	 OQEO6h8kDcM8nIatGfkG2TwZYK9c5v56s3EDxmnORNEPn1KdYJ47YNDnbuxpJmht+G
	 jfLSzwGefMlu471CSSUkMd6FpPLnXzL7BcFGIy1Vsr99QW6teTkd+jmVJYQdkqxYpp
	 ywAplWyYBYbq2kM1mzuoFKgNzFAUv+3YNTsN4+Q/Bk4pAVjbQXLty9YsxD6GkVGGU+
	 7LD+BaIiToeyQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/6] selftests: mptcp: join: fix some flaky tests
Date: Mon, 10 Nov 2025 19:23:39 +0100
Message-Id: <20251110-net-mptcp-sft-join-unstable-v1-0-a4332c714e10@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKstEmkC/x3MQQqDMBBA0avIrB0woSnSqxQXSRzrSDuGTJSCe
 HeDy7f4/wClzKTwag7ItLPyKhWmbSDOXj6EPFaD7awzputRqOAvlZhQp4LLyoKbaPHhS+i87eM
 YnuTdA+ohZZr4f9/fUEMYzvMCytfIqXIAAAA=
X-Change-ID: 20251108-net-mptcp-sft-join-unstable-5a28cdb6ea54
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QcmGZgGER1WlXItZoFVk7+ynEwglcHKP6PhNd97EWUE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKFdPdmM1285CYsLx54W3PC6frJZ/t3ONzNehEye7v6v
 ZyztjNXd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEykx57hn3Wr7ve3lYlWiywK
 rFzfFZ9TWzR57rzzh8OSn50LPHza+hbDP/WVd30Wqf21/C51Osx38/Z9K8otT24y4Zsnxzp7lgG
 vBzMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When looking at the recent CI results on NIPA and MPTCP CIs, a few MPTCP
Join tests are marked as unstable. Here are some fixes for that.

- Patch 1: a small fix for mptcp_connect.sh, printing a note as
  initially intended. For >=v5.13.

- Patch 2: avoid unexpected reset when closing subflows. For >= 5.13.

- Patches 3-4: longer transfer when not waiting for the end. For >=5.18.

- Patch 5: read all received data when expecting a reset. For >= v6.1.

- Patch 6: a fix to properly kill background tasks. For >= v6.5.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (6):
      selftests: mptcp: connect: fix fallback note due to OoO
      selftests: mptcp: join: rm: set backup flag
      selftests: mptcp: join: endpoints: longer transfer
      selftests: mptcp: join: userspace: longer transfer
      selftests: mptcp: connect: trunc: read all recv data
      selftests: mptcp: join: properly kill background tasks

 tools/testing/selftests/net/mptcp/mptcp_connect.c  | 18 +++--
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 90 +++++++++++-----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 21 +++++
 4 files changed, 80 insertions(+), 51 deletions(-)
---
base-commit: 96a9178a29a6b84bb632ebeb4e84cf61191c73d5
change-id: 20251108-net-mptcp-sft-join-unstable-5a28cdb6ea54

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


