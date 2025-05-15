Return-Path: <linux-kselftest+bounces-33130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3199BAB904F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CFD21BA64EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FBD298CA8;
	Thu, 15 May 2025 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hr4hFdA9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457A7266B66;
	Thu, 15 May 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339104; cv=none; b=L5rs4H1rr9UO3fyhTigLLuSPVeJ0USJIzjcCrb6mH7M1Wykh1GLBzStWig+1XOM8t8InJWL+dywhoPoQhLCEXFDDL0Ge1soCMi2Qhuq0P07fjF0XyELuRp6oGlBL82RB/ojsQr0/MCCfttEbEnc1044oerBTIWzOtmEP+z4eKFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339104; c=relaxed/simple;
	bh=Pv6heOT9UmeA55wMy+71ZBKnB9ucEogSTxcfgwAQDFE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FrJC5UT7AQeZB2Hl5wwA2+mteUUHweBo4OH4ypPxYQzEEGlRgjvEinThX8OY87mOGPIc2JTFeYGS02zzKn+aSWtHsyDUTEvUnuoKVJgeVr8MdtFG0wE/1t7TjH/4hibSYOJW+SlSZloML6acxdyN/orPWTH6SYp1DQR7po3KxeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hr4hFdA9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747339092;
	bh=Pv6heOT9UmeA55wMy+71ZBKnB9ucEogSTxcfgwAQDFE=;
	h=From:Subject:Date:To:Cc:From;
	b=hr4hFdA9Sea6WWrNOAcFqG8DVZ1l1kV+TqI6DokCiwFaSfyQk8vdP8Jsi7Xn2I2Q8
	 ALxXrQgo2g3Zy9vDvo+8SAdc0KIqCiWk/SEkqItbnkGMBRrcW617ypZTGlTYUhywr+
	 FwjSakednEV6Rz48b7vtITmicM0qhqSRjKciAsRo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/9] tools/nolibc: split out more headers
Date: Thu, 15 May 2025 21:57:46 +0200
Message-Id: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADpHJmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU0NT3bz8nMykZN3iymJdY8NEk7QUc7MUC0tzJaCGgqLUtMwKsGHRsbW
 1AJcEB3hcAAAA
X-Change-ID: 20250515-nolibc-sys-31a4fd76d897
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339091; l=1811;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Pv6heOT9UmeA55wMy+71ZBKnB9ucEogSTxcfgwAQDFE=;
 b=7d2d2iZYEdkfWC7w5wl8CXdtX2aHF8pwjmNqLKhd0yLSRnWQg+0NQJvQEmNSkLmKAwurFKMJ3
 9vW0VJfhxxYAFef4bWbmCuwotUwiC9o6xMunKhbWs2UNTNNrZOT2cxG
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Split out all headers which are used by nolibc-test.c.
This makes it easier to port existing applications to nolibc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (9):
      tools/nolibc: move ioctl() to sys/ioctl.h
      tools/nolibc: move mount() to sys/mount.h
      tools/nolibc: move prctl() to sys/prctl.h
      tools/nolibc: move reboot() to sys/reboot.h
      tools/nolibc: move getrlimit() and friends to sys/resource.h
      tools/nolibc: move makedev() and friends to sys/sysmacros.h
      tools/nolibc: move uname() and friends to sys/utsname.h
      tools/nolibc: move NULL and offsetof() to sys/stddef.h
      selftests/nolibc: drop include guards around standard headers

 tools/include/nolibc/Makefile                |   8 ++
 tools/include/nolibc/nolibc.h                |   7 ++
 tools/include/nolibc/std.h                   |   6 +-
 tools/include/nolibc/stddef.h                |  24 +++++
 tools/include/nolibc/sys.h                   | 136 ---------------------------
 tools/include/nolibc/sys/ioctl.h             |  29 ++++++
 tools/include/nolibc/sys/mount.h             |  37 ++++++++
 tools/include/nolibc/sys/prctl.h             |  36 +++++++
 tools/include/nolibc/sys/reboot.h            |  34 +++++++
 tools/include/nolibc/sys/resource.h          |  53 +++++++++++
 tools/include/nolibc/sys/sysmacros.h         |  20 ++++
 tools/include/nolibc/sys/utsname.h           |  42 +++++++++
 tools/include/nolibc/types.h                 |  11 ---
 tools/testing/selftests/nolibc/nolibc-test.c |   5 -
 14 files changed, 291 insertions(+), 157 deletions(-)
---
base-commit: 6a25f787912a73613f12e7eefbebd72ee3d43f85
change-id: 20250515-nolibc-sys-31a4fd76d897

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


