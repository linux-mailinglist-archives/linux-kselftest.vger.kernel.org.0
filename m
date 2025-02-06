Return-Path: <linux-kselftest+bounces-25892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2572A2A1CE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 08:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C141888460
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 07:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A884E2248AD;
	Thu,  6 Feb 2025 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TlrEM4dO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83331FF617;
	Thu,  6 Feb 2025 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825841; cv=none; b=TEAyUnQDx1p3oSQL9YLIcY1ZP5mNHCk3lsZpkFbRoGViJuURhgkMyFhly/ao4tUAmsC0w9ROzm9MoMYFv3VP7QbqlS4xxsYBBFml3zsGJT+5/MfyugcL38gOxBp5o38H6QYftAvoay3NjB2lOZe6gyvXNuJrosvVityw5yBP6UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825841; c=relaxed/simple;
	bh=FXce6V+eSi0dDma3szqM0V+Hvtc+EDKv8FPIkeCi8jA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SruEJhEzmJvUWdIyaY5wVtT5pb+tESzB8ik/V9ul7tcUObhMLSf8v4c9ROyPtUalFdM6W7UUoxxXP5gR5WruFSejHXrvAik/P3MOjkftcU+oU0yD8KapnGbBhXKG0a2vQGoSeU6IkntcPPHv0ZMvaNOlQWHHMkQBGnTSzPX19B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TlrEM4dO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1738825829;
	bh=FXce6V+eSi0dDma3szqM0V+Hvtc+EDKv8FPIkeCi8jA=;
	h=From:Subject:Date:To:Cc:From;
	b=TlrEM4dO6VwO4kWaG5xEasmuuLyXs4fv4TsIp3Rk8fBxoq2vdQuZF4tkN9/uB8Po5
	 6/ii4ZprvJ3D4hhmCo+WbZqIEprM9f4a95jnfNlE1RNxQ3BvYlV/1y6ZzY2q3N3dqF
	 911H5XiqaeTJZL/jiybDlRtv16FUUUsPApNOTs18=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/2] tools/nolibc: support for 32-bit s390
Date: Thu, 06 Feb 2025 08:10:25 +0100
Message-Id: <20250206-nolibc-s390-v2-0-991ad97e3d58@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGFgpGcC/23MQQ7CIBCF4as0sxYDKAVdeQ/TheJUJjHQMBU1D
 XcXu3b5v+R9CzBmQoZjt0DGQkwpttCbDny4xDsKurUGLbWRSmsR04OuXvDuIAUaq/aqd9o7B+0
 xZRzpvWrnoXUgnlP+rHhRv/W/U5SQwnnbm1FKdFadXkjM7MMzbCPOMNRav1cV7e2rAAAA
X-Change-ID: 20250122-nolibc-s390-e57141682c88
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738825829; l=1178;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FXce6V+eSi0dDma3szqM0V+Hvtc+EDKv8FPIkeCi8jA=;
 b=DRgFUdheXst8uBPTRD9P+CR7lFDmDAkh8cYAFempEA3fhICdhiJlUyEcpB4z2698JbIfFxwDd
 o+chpmvKF4jBkBN/X75T98yU97dYtNBFU3GhF16Gv+1i6kEfoqnneJc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Support for 32-bit s390 is very easy to implement and useful for
testing. For example I used to test some generic compat_ptr() logic,
which is only testable on 32-bit s390.

The series depends on my other series
"selftests/nolibc: test kernel configuration cleanups".
(It's not a hard dependency, only a minor diff conflict)

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Rebase unto nolibc-next
- Use 96 bytes of stack frame size
- Pick up Ack from Willy
- Link to v1: https://lore.kernel.org/r/20250122-nolibc-s390-v1-0-8c765f00e871@weissschuh.net

---
Thomas Weißschuh (2):
      selftests/nolibc: rename s390 to s390x
      tools/nolibc: add support for 32-bit s390

 tools/include/nolibc/arch-s390.h            |  5 +++++
 tools/include/nolibc/arch.h                 |  2 +-
 tools/testing/selftests/nolibc/Makefile     | 10 ++++++++--
 tools/testing/selftests/nolibc/run-tests.sh |  7 ++++++-
 4 files changed, 20 insertions(+), 4 deletions(-)
---
base-commit: c1f4a7a84037249d086a4114c0c4332a260e9091
change-id: 20250122-nolibc-s390-e57141682c88

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


