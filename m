Return-Path: <linux-kselftest+bounces-48287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4AACF81F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 12:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61AD0301CD10
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 11:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD2C328B44;
	Tue,  6 Jan 2026 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="muXVy9J0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2AA327C13;
	Tue,  6 Jan 2026 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699904; cv=none; b=S4/yLHGM7TR39c6vzBDmmqrkrRtk+z7AxAy5FiKu35y2iYN0pf+/SFV8CM5gZg52JGE4165TCNtQoAswkA5wSn2hmQbtMyM0P0+AnUm5Ee5WgFmpBIXtCMVTSZpTrPrIYrq/HoPk/HS1SzfLHuiKVPT8BOxzDwNwSD7QUmg+aFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699904; c=relaxed/simple;
	bh=GfkiYEmYKq3XEjcrKrhUJtMEUBxN59aigTlg7h4MNio=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RO3Oac4YEH+Pwun1A3lR/SaRZPAAKnvMx818v8JW+YRY5vTuxGpds8cG9zzDGFa5bOMx3UoPp3gjcySKz4+xuTDEphAi6BuuCUks5MOKq396R6ZpWlqtuD2qItt4rCh4gfsDUixS0o/CeiGAMoMOO4ZLGnSyZIMOBO+Ic5O4P3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=muXVy9J0; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1767699898;
	bh=GfkiYEmYKq3XEjcrKrhUJtMEUBxN59aigTlg7h4MNio=;
	h=From:Subject:Date:To:Cc:From;
	b=muXVy9J0nScCtInjzGrTOa0nZzZzGEsMx5W88BbIbYRcLxI8nt0yXLC18KVFCLES7
	 baPbsJcseb02S97nb5ofq4NuUSg7PNjbGyfyeYHjF6TV7xAWFL7I6h0ypyqX8UQT5S
	 g7qbbR7I4xPTT0sgVTsXKV6ipSTW6k2ezplBTegs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] selftests/nolibc: improvements to the kselftest runner
 integration
Date: Tue, 06 Jan 2026 12:44:56 +0100
Message-Id: <20260106-nolibc-selftests-v1-0-f82101c2c505@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALj1XGkC/x3MQQqAIBBG4avErBPM0kVXiRZlfzUgFk5EIN09a
 fkt3sskSAyhvsqUcLPwEQuauiK/T3GD4qWYjDZON9qpeASevRKE9YJcojrrp9Y4B3hLJTsTVn7
 +5TC+7wf0DghjYgAAAA==
X-Change-ID: 20260106-nolibc-selftests-45ca3266eec5
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767699897; l=722;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=GfkiYEmYKq3XEjcrKrhUJtMEUBxN59aigTlg7h4MNio=;
 b=mcE06Qukx0dwF5Z0abQy3dKsjhd7CDZ6Fj3IcMjz5DsEvWrFjqkZaEm4/kDoeO6Yizr15wNy/
 0t932A2OoyOCgYhXIkkAGtsyTmDzocBzUnO0+WOApzGDYL/auoauJ02
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Fix the execution of 'make run_tests' and also wire up libc-test.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      selftests/nolibc: try to read from stdin in readv_zero test
      selftests/nolibc: scope custom flags to the nolibc-test target
      selftests/nolibc: also test libc-test through regular selftest framework

 tools/testing/selftests/nolibc/Makefile      | 14 +++++++-------
 tools/testing/selftests/nolibc/nolibc-test.c |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)
---
base-commit: 6b6dbf3e4ecfd7d1086bd7cd8b31ca8e45d4dc1f
change-id: 20260106-nolibc-selftests-45ca3266eec5

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


