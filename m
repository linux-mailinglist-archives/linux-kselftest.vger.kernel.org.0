Return-Path: <linux-kselftest+bounces-46313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2649FC7CD94
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 12:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E1B3A9E4C
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 11:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6862FD661;
	Sat, 22 Nov 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jKdFx6hW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDB22FD1D5;
	Sat, 22 Nov 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763809324; cv=none; b=fNmHDvs7c4CVxwOqVHG4mO4Ii3u0k4O/mgR872Lv8MtFYFiofy0SSNS1uMtLjb8pV2/4+eibEqtKklQlSKdk8oa5Xv3oPjSZv4weLtFnL/vfISiLChodlrzrTf+YOmx0LUBUUOZQS90gwePE924KRyQYwvai0MY9wU8T4A7hfv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763809324; c=relaxed/simple;
	bh=cHQnNqT0OW/Joaf1+Mut9M/5JozEhuDWeDOBPFPOirg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kU2ql/3wYsQwb0g03MCfbrvAcmzIEAmo9vv4ry+6uulyH5sIlcKGkeuxd7sVjWEJ1yvCIVIf7DDhYextANIC8DvG/bvgafADIr4CrGJNAHuYK71CuCfBuY2V9S/cTwVmsxEiaM6rg1RDE/cWdUy+N/BZUOqClcqwKHSm6JDF9eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jKdFx6hW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763809320;
	bh=cHQnNqT0OW/Joaf1+Mut9M/5JozEhuDWeDOBPFPOirg=;
	h=From:Subject:Date:To:Cc:From;
	b=jKdFx6hWae5/eNNYqjRzNa/42lFaYkXYLe0ATb5nHlc3jXEQssk3v8s68tpXv5Vyh
	 wkaEawZd8zo5ARW9pkx3pIsrljSBV2sCJWu4o931s+oyeLiUPp7znhNqJhdV8Zu0Sj
	 sgqQ5IsoOiJHO/jVYBNOSEiA/NmfC3Jg6PObgQn4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] selftests/nolibc: fix loongarch build with recent
 versions of clang
Date: Sat, 22 Nov 2025 12:01:56 +0100
Message-Id: <20251122-nolibc-lld-v1-0-5e181e228c6a@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACSYIWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQyND3bz8nMykZN2cnBTdNGOjxDQTSwvj5GQDJaCGgqLUtMwKsGHRsbW
 1ABRL7yNcAAAA
X-Change-ID: 20251121-nolibc-lld-f32af4983cc0
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763809320; l=735;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=cHQnNqT0OW/Joaf1+Mut9M/5JozEhuDWeDOBPFPOirg=;
 b=ISKSrLSYezym3cw4nf2d/ybV8Rqyei5pDa6YbhDZPfK2RpTn8O33UGChCDTxs3zM31dOTxsn5
 riAIksXuBwoCFKUUwO1bzb4GnXg3H/1J4p7K6Ye0xG89lukbLxadXcw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

LLVM 21 switched to -mcmodel=medium for LoongArch64 compilations.
This code model uses R_LARCH_ECALL36 relocations which might not be
supported by GNU ld which the nolibc testsuite uses by default.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      selftests/nolibc: use lld to link loongarch binaries
      selftests/nolibc: error out on linker warnings

 tools/testing/selftests/nolibc/Makefile.nolibc | 1 +
 tools/testing/selftests/nolibc/run-tests.sh    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 6059e06967aaac9bf736c6cec75b9bccaf5bbe18
change-id: 20251121-nolibc-lld-f32af4983cc0

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


