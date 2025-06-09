Return-Path: <linux-kselftest+bounces-34451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 903EFAD1A90
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 11:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9512D188D064
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 09:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C051025178E;
	Mon,  9 Jun 2025 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="O46bqCM3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA8165F1A;
	Mon,  9 Jun 2025 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461346; cv=none; b=bL4h787s1cCmgSlbRV2W4IFBtFaA6ePDbV4Ndif6oWZJz4uyXXS3OR41jhUjRtOGEFBF0p2fCXuYp3/j7AHQWXP7laCZ/ipkK7XPzSfTK9A8AWb6sW4XefYrCwESjMyrCs/lRkMBd7OM8EtltDRaeHrPfKlbqLhpPt1IkgeZde8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461346; c=relaxed/simple;
	bh=v4ezPEZovuA0iUYK/5IU5vDj4sw+aQC7K3OLjjVnTGo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GSim0Iu3W8Ox1I4NO4i3YKmAAF6wfhKsqaL7WxVWp2C1Yu7REuKryDLSK4N2tjdJ6Xxpp+4MXwFxrQipRa8EugX6uK9lRwsYaRqrwu9+VvLwvkXohaxtSGhXW7jI/ss3tVtaiqMygpSLQEzsTk2ADk+xtkQPJYMU+4I2ZmM1XQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=O46bqCM3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749461342;
	bh=v4ezPEZovuA0iUYK/5IU5vDj4sw+aQC7K3OLjjVnTGo=;
	h=From:Subject:Date:To:Cc:From;
	b=O46bqCM3CTXZqGsFuRc14dHUTvYYPUL5O0Hp7uRANgLLYBKTsCTpprXIY8XNeflNp
	 uOd/rjet1trtr89nqVR6U3rcCnfjMfge/AbECpQ32VwLrsi6yQBSjmrr+yNsFeEUBE
	 FCHJOgj2I4CDGH0mI/DUlwQG5G76lSgBlzpTKOAY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] tools/nolibc: add support for SuperH
Date: Mon, 09 Jun 2025 11:28:56 +0200
Message-Id: <20250609-nolibc-sh-v1-0-9dcdb1b66bb5@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFipRmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyML3bz8nMykZN3iDF2LJJNU46Qki9S05CQloPqCotS0zAqwWdGxtbU
 AW9k7kFsAAAA=
X-Change-ID: 20250528-nolibc-sh-8b4e3bb8efcb
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749461342; l=869;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=v4ezPEZovuA0iUYK/5IU5vDj4sw+aQC7K3OLjjVnTGo=;
 b=QkGw2Q/V4exjx3XeAYhT3LnWSt3TScPga8Ev4W7m2VJKE9wR14eUZSHbfpaM3InI/W0/3xx3V
 z9mOroqTsYvBCiHlgsbsADgVy47IANbFJXcu/TFwt7SNZSHei+a1Ycm
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add support for SuperH/"sh" to nolibc.
Only sh4 is tested for now.

This is only tested on QEMU so far.
Additional testing would be very welcome.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      selftests/nolibc: fix EXTRACONFIG variables ordering
      selftests/nolibc: use file driver for QEMU serial
      tools/nolibc: add support for SuperH

 tools/include/nolibc/arch-sh.h              | 162 ++++++++++++++++++++++++++++
 tools/include/nolibc/arch.h                 |   2 +
 tools/testing/selftests/nolibc/Makefile     |  15 ++-
 tools/testing/selftests/nolibc/run-tests.sh |   3 +-
 4 files changed, 177 insertions(+), 5 deletions(-)
---
base-commit: 6275a61db2f0586b8a5d651dfc7b4aacf9d0b2d6
change-id: 20250528-nolibc-sh-8b4e3bb8efcb

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


