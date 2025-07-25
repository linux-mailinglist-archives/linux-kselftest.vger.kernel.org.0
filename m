Return-Path: <linux-kselftest+bounces-37993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F90B12208
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 18:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65D31C82BA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB591E7C03;
	Fri, 25 Jul 2025 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=nixdorf.dev header.i=@nixdorf.dev header.b="AsYQsMT1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from shadowice.org (shadowice.org [95.216.8.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988394A3C;
	Fri, 25 Jul 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.8.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461113; cv=none; b=lGWDP5R/jq7XVEZ9TvjNO6JOtxxflkegAt1LjTZ6TnwWJV68UZgtch/6bVl8Kcuw44RpNQW30g2pWfu37ZxILjZLyt07BIlqZk7QcGPwYTxvynaMeehX0ZC2GC1gpQ8fB1IV8Ac0eS6znvei2AyaPrxxmm7u3xW8rzDInDA+gJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461113; c=relaxed/simple;
	bh=BYLMmfKdHqqqte66H+kkCpcGf5Bi4CVUPD0Q81YCp9w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KcA5pb/C7/6wuYv1RT9/cRkIlumd92aTpmt84z8ZDjaj/4kZCM2clJhjfWg3oUxnQx4fJ2SJKTgny6ZR4bfqqpteAT80ECpLyLuiUunrXDi/2H1tBxlIfCbHi5romPCWTlPcCoGN4BJLZ5hsxye5jN7gFl6XAGoJEfCQnBQBz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nixdorf.dev; spf=none smtp.mailfrom=nixdorf.dev; dkim=fail (0-bit key) header.d=nixdorf.dev header.i=@nixdorf.dev header.b=AsYQsMT1 reason="key not found in DNS"; arc=none smtp.client-ip=95.216.8.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nixdorf.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nixdorf.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=BYLMmfKdHqqq
	te66H+kkCpcGf5Bi4CVUPD0Q81YCp9w=; h=cc:to:date:subject:from;
	d=nixdorf.dev; b=AsYQsMT1rsydPNtSerIssGJhn97mafP4IoZRPZ7vePEeETaovDeN7
	93KAWO0YzdTtYWfsJiGgNYXTfu+Yazh72N/xfPzb8+VO8LzmqspwNPXkXwG1IEzxirh1tP
	GawJF4AFgS7ysQAWfs+Pga5FX+h10x55xjKhiWaUPNSrt62s=
Received: from [127.0.0.1] (p4fc61662.dip0.t-ipconnect.de [79.198.22.98])
	by shadowice.org (OpenSMTPD) with ESMTPSA id 4a911d07 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 25 Jul 2025 18:31:41 +0200 (CEST)
From: Johannes Nixdorf <johannes@nixdorf.dev>
Subject: [PATCH v2 0/2] seccomp: Fix a race with WAIT_KILLABLE_RECV if the
 tracer replies too fast
Date: Fri, 25 Jul 2025 18:31:17 +0200
Message-Id: <20250725-seccomp-races-v2-0-cf8b9d139596@nixdorf.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFWxg2gC/13MQQ6CMBCF4auQWTumLdIKK+9hWJR2kFlISWsaD
 OHuVhI3Lv+XvG+DRJEpQVdtEClz4jCXUKcK3GTnByH70qCEaoRREhM5F54LRusoIbXm2hqvfXs
 ZoHyWSCOvh3fvS0+cXiG+Dz7L7/qT6j8pS5Q40NhobRzVwt5mXn2I49lThn7f9w/onpRArAAAA
 A==
X-Change-ID: 20250721-seccomp-races-e97897d6d94b
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Sargun Dhillon <sargun@sargun.me>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ali Polatel <alip@chesswob.org>, 
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
 Johannes Nixdorf <johannes@nixdorf.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753461100; l=1116;
 i=johannes@nixdorf.dev; s=20250722; h=from:subject:message-id;
 bh=BYLMmfKdHqqqte66H+kkCpcGf5Bi4CVUPD0Q81YCp9w=;
 b=P55r56q3X8LbXz81/SOfoUrmqntdwwpp5+/04jojKTV0Wrf+bKOXSmYro+VpW0ZZxYEvg0+VR
 GL8szP9rx72C3VyiZJqW2TNr3fI+UfRuXzvbMZIOla8MtrCRGZ1kAIM
X-Developer-Key: i=johannes@nixdorf.dev; a=ed25519;
 pk=6Mv9a34ZxWm/f3K6MdzLRKgty83xawuXPS5bMkbLzWs=

If WAIT_KILLABLE_RECV was specified, and an event is received, the
tracee's syscall is not supposed to be interruptible. This was not properly
ensured if the reply was sent too fast, and an interrupting signal was
received before the reply was processed on the tracee side.

This series fixes the bug and adds a test case for it to the selftests.

Signed-off-by: Johannes Nixdorf <johannes@nixdorf.dev>
---
Changes in v2:
- Added a selftest for the bug.
- Link to v1: https://lore.kernel.org/r/20250723-seccomp-races-v1-1-bef5667ce30a@nixdorf.dev

---
Johannes Nixdorf (2):
      seccomp: Fix a race with WAIT_KILLABLE_RECV if the tracer replies too fast
      selftests/seccomp: Add a test for the WAIT_KILLABLE_RECV fast reply race

 kernel/seccomp.c                              |  13 ++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 130 ++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 7 deletions(-)
---
base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
change-id: 20250721-seccomp-races-e97897d6d94b

Best regards,
-- 
Johannes Nixdorf <johannes@nixdorf.dev>


