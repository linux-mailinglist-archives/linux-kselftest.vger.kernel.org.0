Return-Path: <linux-kselftest+bounces-31257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119D1A95506
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 19:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C04168BE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 17:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EDA1E32D6;
	Mon, 21 Apr 2025 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJumR7wQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE219CD1D;
	Mon, 21 Apr 2025 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745255290; cv=none; b=e5kiIQq71bxTZ1YKO6e6WY3w7vKomaYD6+R7rfb3b2skjAzImIwczqhYDKYhnGZVkDRAzw6iIZENqUEv8oRW0zt1Z757rYPLB3d7XVJ0XHcLpDxOFwZWzkVNyCktX3zo1+dbXYynTWkH4jaCmMxDoVPDFExQBRbvKZejU99zN1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745255290; c=relaxed/simple;
	bh=J14MkTd+JCXpakqM03SaDXb7lljFMGaebEw96oEYtv0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CdWhYV6OXLt/s6iLUasAcWpv8Br4Si3GgwBgDb3T2fn0MqGWOLCJIpJ/M51cfpst1Hzb+E7PQLMYpn4YM7PgeMq7LUnqwX/yQTPMNE75+T+Srgq7kkmTaqQhA5q0LReUrVwx/Gup3JjtpAU6CVElr0Nw7HOqHQgILle45v8IshE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJumR7wQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC17C4CEE4;
	Mon, 21 Apr 2025 17:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745255289;
	bh=J14MkTd+JCXpakqM03SaDXb7lljFMGaebEw96oEYtv0=;
	h=From:Subject:Date:To:Cc:From;
	b=SJumR7wQOpw+4UwBkNc60AHPKTl6mqeKvuvHCGaFwKry8ltbVCxkB+VRA96KsEH9t
	 q9wyCaV8JFf/Wtt3LDSWiuHsxFOpBj01PdyBU2smzYATo4QZYfXECPSM29wQxSzOSo
	 iLawDFDHoYMyokqFMfCZEj5zeSSICQIHrc0K50wyYlmhatwWU8ofUdDjDmlFcVSOCd
	 0+lylRs65uu9IIs6yVMw/iGxlDZOJp99KlNRdksSTzLO57vA0vVirwwT+HgOP0KawP
	 fgk2Pw8KJ4wtBYZrQH3gdMzV5uRsOrfJfTdJ2iye992gu07cyvKLD5rluVi3cspi20
	 2myPAdbhnyW9Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/2] mptcp: pm: Defer freeing userspace pm entries
Date: Mon, 21 Apr 2025 19:07:12 +0200
Message-Id: <20250421-net-mptcp-pm-defer-freeing-v1-0-e731dc6e86b9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEB7BmgC/x3MQQqDMBBG4avIrDswiZZir1K60OSPnYUxTKQUx
 LsbuvwW7x1UYYpKz+4gw1erbrnB3ToKnykvYI3N5MXfZfCOM3Zeyx4Kl5UjEoyTAZoXTmOI4ua
 HyNBTGxRD0t9//qLW0fs8L6QXdENxAAAA
X-Change-ID: 20250421-net-mptcp-pm-defer-freeing-f9cd01b70043
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Gang Yan <yangang@kylinos.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=789; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=J14MkTd+JCXpakqM03SaDXb7lljFMGaebEw96oEYtv0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLYqkukJQt+aaxsard9y772Z2bNV2GzteaOkxavPDPD9
 GFfcuKtjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkcO8vwT9Vzx6OQpTzdl3Kf
 aadUThYKzhaLPfxReqGAimzv34zjvQz/1LyOzvOeHbf7fWb0WYsrfinxV/Zpc4dLeHp5Pt4wJeQ
 4GwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are two unrelated fixes for MPTCP:

- Patch 1: free userspace PM entry with RCU helpers. A fix for v6.14.

- Patch 2: avoid a warning when running diag.sh selftest. A fix for
  v6.15-rc1.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (1):
      selftests: mptcp: diag: use mptcp_lib_get_info_value

Mat Martineau (1):
      mptcp: pm: Defer freeing of MPTCP userspace path manager entries

 net/mptcp/pm_userspace.c                  | 6 +++++-
 tools/testing/selftests/net/mptcp/diag.sh | 5 ++---
 2 files changed, 7 insertions(+), 4 deletions(-)
---
base-commit: 750d0ac001e85b754404178ee8ce01cbc76a03be
change-id: 20250421-net-mptcp-pm-defer-freeing-f9cd01b70043

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


