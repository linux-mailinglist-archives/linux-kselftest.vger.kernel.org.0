Return-Path: <linux-kselftest+bounces-22275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D119D2978
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 16:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE064B30C6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 15:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0941CEABA;
	Tue, 19 Nov 2024 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="WPDuP0GI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619CA1CC89A;
	Tue, 19 Nov 2024 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028494; cv=pass; b=KSxfD9M/sNxlNp1L3Hd0CMXu5Q0KMrlUqsX3GyyJvKNiq/n6IgOx4BnLj93a/d6Zl3u9XmuwyVfkr3ThuvPgSrZV1qkg2JQZgnXClY1bEbBGTtwNv/ThQ2a8ONziSxB0KBJb/yjXFpfczFW9yyeF7y2vvi0/JGGDZ3iof0EainA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028494; c=relaxed/simple;
	bh=WXFyOVmmvQEMtWRex0vVrA8e0PDnuJmVvBlF6A8VvOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JDvmuB17kTYVuHrUuYHdDfws4Y4fikn9kfoFWjB91+ZxdXejdf4NkXrcH3jR4z9KgLkgw+03q7xDJBfOq61Owutoy7LB7/vslHpA7/KMdZZOiPW3Z9nYt/kfmp0n07vag8welPqGnhDiLjdSyakPfS94Z8lN3L34otNAMig4K3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=WPDuP0GI; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732028484; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JXb8WoLR/N1Ey4oHo0Kdw9BkQ9hzwm9+8gnh8fJFs12z4eykgVrEyi3IettRQlHi7UjgM2+PDGlis5XU40HAjh+4+6rTbnqx3GTH0LFnuXNRtVV9eiUDov4/+CKupalOSMCxBXK0HpMw+fIzGB278heyYqcyZDqIXKYysccS0ms=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732028484; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kmU2GWdHHNbhdrlM2w2sQFuUhCX+M1v7E1rs7QrVS1A=; 
	b=R7mtBobyCD2ko8Xr2goRbNZC+CZ7MG6DQYzny9yGW/4kGI7PEpy8Dq1NxdKL7ThPry8SNlKVzZD0nkboyg177HZVLZ+sD2FScaXV3Sp0u3Ij2kRATTn+JaPt5orIa9Wu+fBTYzN8anRlse/6RS8Li2nufCyIRSZ9z4LrKreWdLI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732028484;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=kmU2GWdHHNbhdrlM2w2sQFuUhCX+M1v7E1rs7QrVS1A=;
	b=WPDuP0GIsFXuImZWyaYFSuaGRrXbi/8FxiptCaAz0EVL+dsmd4Wtn4Mo/D0vJQ/H
	5hIKUtpw9i6GbcCTFgwOwdo95PaTodvFfKRMc9X5B7dwL9xwUHr4SksECe9+wauMgWE
	FprbjstpyM1IAeTHlPXpHY91/p7ZTFMqtK1cS6LU=
Received: by mx.zohomail.com with SMTPS id 1732028482121716.6932825937525;
	Tue, 19 Nov 2024 07:01:22 -0800 (PST)
From: Laura Nao <laura.nao@collabora.com>
To: shuah@kernel.org
Cc: laura.nao@collabora.com,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/2] Modify the watchdog selftest for execution in non-interactive environments
Date: Tue, 19 Nov 2024 16:01:25 +0100
Message-Id: <20241119150127.152830-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This series is a follow-up to v1[1], aimed at making the watchdog selftest
more suitable for CI environments. Currently, in non-interactive setups,
the watchdog kselftest can only run with oneshot parameters, preventing the
testing of the WDIOC_KEEPALIVE ioctl since the ping loop is only
interrupted by SIGINT.

The first patch adds a new -c option to limit the number of watchdog pings,
allowing the test to be optionally finite. The second patch updates the
test output to conform to KTAP.

The default behavior remains unchanged: without the -c option, the
keep_alive() loop continues indefinitely until interrupted by SIGINT.

[1] https://lore.kernel.org/all/20240506111359.224579-1-laura.nao@collabora.com/

Changes in v2:
- The keep_alive() loop remains infinite by default
- Introduced keep_alive_res variable to track the WDIOC_KEEPALIVE ioctl return code for user reporting

Laura Nao (2):
  selftests/watchdog: add -c option to limit the ping loop
  selftests/watchdog: convert the test output to KTAP format

 .../selftests/watchdog/watchdog-test.c        | 169 +++++++++++-------
 1 file changed, 103 insertions(+), 66 deletions(-)

-- 
2.30.2


