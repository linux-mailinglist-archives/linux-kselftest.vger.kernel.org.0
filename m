Return-Path: <linux-kselftest+bounces-46320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6B3C7D441
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 18:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 543633533C8
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012D429C35A;
	Sat, 22 Nov 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JzadCfym"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42352258ECB;
	Sat, 22 Nov 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830794; cv=none; b=CoqTd7tJ5izVq/flW+oJlIUEwDV+1RJijtuYOb0SlzhYGZbLB6gxIILC6e6ISKqXxVM2CeXv2HdOE2ycUAYvPdLJxG/IoT0bE+WR2I/QJamjh0Jf9USF/LcRTnd55elMalTwn5NzsXj9pe74W4PA0mNWLsdp5oRq9umlRW1Lgkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830794; c=relaxed/simple;
	bh=ZmtfbtyjNDgtbmIvBGb+Np3Mlgt4QgxOENZ/McTOZZE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rfE0e8Ghhvr0teCDy2IIOLMLDeqYemwQfJA6yxOlrUsqx/e8+NsDE5/o0U04Ecu27OaYlok6cn0VWpjar+K2qn0/1vrabAgSsKDHAg81U1K6tPVu9PL1v2kAJvMVXOII6/w42y3Z5nPwC6CYn7NrRHFyGNNNiDpSZ1F3idnYYzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JzadCfym; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763830790;
	bh=ZmtfbtyjNDgtbmIvBGb+Np3Mlgt4QgxOENZ/McTOZZE=;
	h=From:Subject:Date:To:Cc:From;
	b=JzadCfymoQ8uhFcTk1DfcBCRNu1k5YIM61LX7CIwaa8D+ZxpGdbpJ167Vrcybeb4V
	 NuR23Z0k772WWCl2i/XbsJOXxpxmifonhWPdXon9E7e9m7Sndk/2Z5JZ6JZwBN7QUa
	 f9pOoP+E9nH+yyx+SgIyKoI31NiL1AD5I/Gyf54s=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 00/13] tools/nolibc: always use 64-bit time-related
 types
Date: Sat, 22 Nov 2025 17:59:06 +0100
Message-Id: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANrrIWkC/22NQQ6CMBBFr2Jm7ZhODUFceQ/DAtrBTmIK6QBKC
 He3Epcu30v++ysoJ2GF62GFxLOo9DGDPR7AhSY+GMVnBmtsQcYQxv4prcOpGQTHZWBFcqa0nkz
 nXAl5NyTu5L0373XmIDr2adkvZvraX81Wf2ozoUEuK8/n1lLhL7cXi6q6MIVT5BHqbds+mVDBe
 7cAAAA=
X-Change-ID: 20251001-nolibc-uapi-types-1c072d10fcc7
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763830790; l=2190;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ZmtfbtyjNDgtbmIvBGb+Np3Mlgt4QgxOENZ/McTOZZE=;
 b=9htbGnh+/jUr+ZfqPBwreP/Y8eawN2XqokQlTU/soujFjUhAgGamEPdX/tVg9ni2EPO/1/jJQ
 Ua+f0Rp2YfHAwgWzmsl1Ob79tPIF7z2EEDHNH9osEAz38O7iZ91tqDD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

nolibc currently uses 32-bit types for various APIs. These are
problematic as their reduced value range can lead to truncated values.

Intended for 6.19.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Drop already applied ino_t and off_t patches.
- Also handle 'struct timeval'.
- Make the progression of the series a bit clearer.
- Add compatibility assertions.
- Link to v1: https://lore.kernel.org/r/20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net

---
Thomas Weißschuh (13):
      tools/nolibc/poll: use kernel types for system call invocations
      tools/nolibc/poll: drop __NR_poll fallback
      tools/nolibc/select: drop non-pselect based implementations
      tools/nolibc/time: drop invocation of gettimeofday system call
      tools/nolibc: prefer explicit 64-bit time-related system calls
      tools/nolibc/gettimeofday: avoid libgcc 64-bit divisions
      tools/nolibc/select: avoid libgcc 64-bit multiplications
      tools/nolibc: use custom structs timespec and timeval
      tools/nolibc: always use 64-bit time types
      selftests/nolibc: test compatibility of nolibc and kernel time types
      tools/nolibc: remove time conversions
      tools/nolibc: add __nolibc_static_assert()
      selftests/nolibc: add static assertions around time types handling

 tools/include/nolibc/arch-s390.h             |   3 +
 tools/include/nolibc/compiler.h              |   2 +
 tools/include/nolibc/poll.h                  |  14 ++--
 tools/include/nolibc/std.h                   |   2 +-
 tools/include/nolibc/sys/select.h            |  25 ++-----
 tools/include/nolibc/sys/time.h              |   6 +-
 tools/include/nolibc/sys/timerfd.h           |  32 +++------
 tools/include/nolibc/time.h                  | 102 +++++++++------------------
 tools/include/nolibc/types.h                 |  17 ++++-
 tools/testing/selftests/nolibc/nolibc-test.c |  27 +++++++
 10 files changed, 107 insertions(+), 123 deletions(-)
---
base-commit: 586e8d5137dfcddfccca44c3b992b92d2be79347
change-id: 20251001-nolibc-uapi-types-1c072d10fcc7

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


