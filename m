Return-Path: <linux-kselftest+bounces-29883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5966CA74C9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 15:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A46188C16D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 14:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF821C2443;
	Fri, 28 Mar 2025 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIeXO3bl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAF21B6D08;
	Fri, 28 Mar 2025 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172083; cv=none; b=Bc/nFTsfSgNIhi171sKPGBn/qlJ0mUMfktT0Qcqwk37qOHQS83CzSGqRfiGzGZ6XV5J9l2BdZWvOmeTnRPN4uCR3ZUsBYT6/iVfeKe5ZeQ2WKG1LG2pZPOeoJ5ftexv/zQD2CfSTBD72jilXBdhnyx9exWWBC3m7HNiKwAqXXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172083; c=relaxed/simple;
	bh=clM9I6OK9mXDPYO14TspyxkuWz1ABgmp58wwq/6vUVM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QPo7ycB0MT+Q1J2BYpUWoBDDAMT3pGdajVtHSvV54mmQvwY51yMqURQs6VDFtgz6+C9Ktr7Fzx1TtxWAKoloNZWJR8vfqrJtSKce72jL4+eKLhn45mfVyqloIon5sqc01XGRDozfCpBR2E7bTM6obeg8nqgBHMjZ6JOa1EwWpcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIeXO3bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A6CC4CEE4;
	Fri, 28 Mar 2025 14:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743172083;
	bh=clM9I6OK9mXDPYO14TspyxkuWz1ABgmp58wwq/6vUVM=;
	h=From:Subject:Date:To:Cc:From;
	b=NIeXO3blCft9XJOIS6YVuQh5B2/d9L0flAN7WmkfFC5gkPfnGBIOC2M2S+xI4d40W
	 Sw5WREAsesc+Ql1uEQ/6HHwV4/FYpA8cVOGvU947VFGaOb8LEZCz2jFYoT2JghRVcu
	 9p/Sw06hPt6FYFg5KoZyM8CrsWyBbxzFzD2ZOwjx9hQy1vHDfCid8WHVZNoDfvUcV8
	 DziP7EvE5LlOaIbR9M3teKy4umbHe5tnqBvC7n2zTLjV6ceRZDzI6T0p61AVgrPaAw
	 MBLtPzzxTO1ncZYybjoZfyYMQ44/c9l6CcRuL6yfnrZhfrtxVVNi7gRNXb3WJ6aoDQ
	 bSBFnvN/7ZWEw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/4] mptcp: misc. fixes for 6.15-rc0
Date: Fri, 28 Mar 2025 15:27:15 +0100
Message-Id: <20250328-net-mptcp-misc-fixes-6-15-v1-0-34161a482a7f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMSx5mcC/x3LMQqAMAxA0atIZgO2UlGvIg61Rs1gLY2IIN7d4
 Pj5vAeEMpNAXzyQ6WLhI2qYsoCw+bgS8qwNtrKuqm2LkU7c0xkS7iwBF75JsEHjsGunZSLvjfM
 B1KdM/1U+gDIY3/cDom9iF3AAAAA=
X-Change-ID: 20250328-net-mptcp-misc-fixes-6-15-98bfbeaa15ac
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>, Shuah Khan <shuah@kernel.org>, 
 Dmytro Shytyi <dmytro@shytyi.net>, Gang Yan <yangang@kylinos.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Cong Liu <liucong2@kylinos.cn>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=clM9I6OK9mXDPYO14TspyxkuWz1ABgmp58wwq/6vUVM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn5rHs7SLo8NX0+19wacYjzypN568Dj3YSsLyNC
 iF6K7v3qniJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ+ax7AAKCRD2t4JPQmmg
 cw0rD/0U0U7Z+jbrpFnfVfb3sPOlzLoKvNtN35t48NSQIzrLRLx9yaNnlb5yXS7jXSy1p0OsqGx
 nwcgqVY/mluQrKWmRXmzkdCnsgzCQMP8QJrj80HjkEaOz0hi+Kj1FHvTycziRJovHTiLw6O8Dg2
 qO8bliHNkNDt6rK45n066WMTliFevmW7Mk7pLwlfbSYx/oWisZRKjtD6Co0QmCzFz3fIBBTDkPF
 erYi9rhl78eUS1VbNqtvx0zIS8277eSi0MmCMljKz1QERXRT525um5D7hw09zZC+3KoeMZvpG9h
 QNa898hkQUh/u76PPdjFgZIKgxoEEDGePMCGXimT7RKUpSVb2sQtcEfQZ9MSExTEsdr9BxK2Pef
 O2a/SL4JUGVGC+JvajGc6yW8+Vfyy8JNZOP1V+C8BCeUcZZRbdSb6nfeo2n5+ExyCP/si5fQBnQ
 r0uzZeV9CsQ0FzwBvFOkVhKOp8ZzqFc0l6+AH+UG1gZmFPOL+Cq0k6I0h7i2+UNZxe7ix02i8K5
 r/Z0ImOTe00kCwIIqJOrCRmrkoIUBaSePtX9WE6LbrQG0jXD/ZQw0qh0vTExiQgUuKcD9ASxPgD
 6EEP800KvNRFBG+NLeNOEOXgZc0jFX8jD38arrELCOdHw3Bt9fy8/07h8wY1j/dRmNvgNQH9gBA
 0KgZIY9SEnZf18A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are 4 unrelated patches:

- Patch 1: fix a NULL pointer when two SYN-ACK for the same request are
  handled in parallel. A fix for up to v5.9.

- Patch 2: selftests: fix check for the wrong FD. A fix for up to v5.17.

- Patch 3: selftests: close all FDs in case of error. A fix for up to
  v5.17.

- Patch 4: selftests: ignore a new generated file. A fix for 6.15-rc0.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cong Liu (1):
      selftests: mptcp: fix incorrect fd checks in main_loop

Gang Yan (1):
      mptcp: fix NULL pointer in can_accept_new_subflow

Geliang Tang (1):
      selftests: mptcp: close fd_in before returning in main_loop

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: ignore mptcp_diag binary

 net/mptcp/subflow.c                               | 15 ++++++++-------
 tools/testing/selftests/net/mptcp/.gitignore      |  1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 11 +++++++----
 3 files changed, 16 insertions(+), 11 deletions(-)
---
base-commit: 2ea396448f26d0d7d66224cb56500a6789c7ed07
change-id: 20250328-net-mptcp-misc-fixes-6-15-98bfbeaa15ac

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


