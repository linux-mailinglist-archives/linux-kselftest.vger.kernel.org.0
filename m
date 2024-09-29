Return-Path: <linux-kselftest+bounces-18553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA507989801
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 23:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619D91F213A6
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 21:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC78517DE1A;
	Sun, 29 Sep 2024 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IEx6r+98"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C60F5FDA7;
	Sun, 29 Sep 2024 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727646471; cv=none; b=KE5O+o2oH5liRq1gFzUE9VFsd7Xi+Nv8xjSjyn0wIMfZVGzqGG1RXoxzwgLiDJCARNiliG/+EeMk5OK9CMhMTOMxLVzhDh7KZZfEHSP/+YIVi/hiZnxVmV+O7JmtL2UiViFYt8dl/oyCygsTpYvyyS6Dh/bqIEkXuJvHEr7QWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727646471; c=relaxed/simple;
	bh=QdlZBa0RkbDHGXHRwfBzodC7B0WksXLt0gUgoIRDxcI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dg9pi+QhUYXYe4lZ3NJrSgO+7iWuC1In1ZIehnMP0372ttV9lh0hfwxQNOJaWUIhwRsEk9dFp0T9y/vFSNtp6Ooqe+QTGUVIFG4j9L5jsYXg+TRh6FldUuiaY2jq4nCiOZ4Sm8Shq+HIx4uysojf1yIKvb7YYVEEEv0umM5U6aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IEx6r+98; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1727646464;
	bh=QdlZBa0RkbDHGXHRwfBzodC7B0WksXLt0gUgoIRDxcI=;
	h=From:Subject:Date:To:Cc:From;
	b=IEx6r+98+MS9YiZUrGuRvDqGY9nsRS/x2pI0iaKmENL08sp/G6uRxZtGoK5eqA3si
	 ocwYEaPXqZuGd4SNklQjPhqvUWAPRbyc+OmdjAd+HL2jCux9bWOKCEZ6/F+afvkYJD
	 s7GaMEnERJYsG2PT9cac6dNsEHCp+YUksI0Snkjk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] csky: add shutdown and nolibc support
Date: Sun, 29 Sep 2024 23:47:35 +0200
Message-Id: <20240929-nolibc-csky-v1-0-bb28031a73b0@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPfK+WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSyML3bz8nMykZN3k4uxK3dS0NENDAxMLI9MUIyWgjoKi1LTMCrBp0bG
 1tQBvG6UkXQAAAA==
X-Change-ID: 20240928-nolibc-csky-eff1104825d2
To: Guo Ren <guoren@kernel.org>, Willy Tarreau <w@1wt.eu>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727646464; l=1470;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QdlZBa0RkbDHGXHRwfBzodC7B0WksXLt0gUgoIRDxcI=;
 b=8Xtziw6rjVTxDK3ArFAIxoJgvx9yshYqhu3ZlXPAzTf/fg3Zd/lEj93vxITqFAnAdH1Ex/2br
 yHxmBxBQHFbD+IRk5xhY1gTGKr8Id9daolYy1GKVsQcD4kz3b8nXDFH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This series adds support for the C-SKY architecture to nolibc.
It is hard to find a usable C-SKY userspace and compiler, so having
support in nolibc provides an easy way to perform tests there.

The nolibc test suite requires system power off support in QEMU,
so a driver for that is added, too.
I'm not sure who is responsible for drivers/virt/ and can take the
driver.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      drivers/virt: introduce csky_exit system poweroff driver
      tools/nolibc: provide a fallback for lseek through llseek
      selftests/nolibc: add support to use standalone kernels for tests
      tools/nolibc: add csky support
      selftests/nolibc: skip test for getppid() on csky

 drivers/virt/Kconfig                         |  11 ++
 drivers/virt/Makefile                        |   1 +
 drivers/virt/csky_exit.c                     |  57 ++++++++++
 tools/include/nolibc/arch-csky.h             | 161 +++++++++++++++++++++++++++
 tools/include/nolibc/arch.h                  |   2 +
 tools/include/nolibc/sys.h                   |   8 ++
 tools/testing/selftests/nolibc/Makefile      |  21 +++-
 tools/testing/selftests/nolibc/nolibc-test.c |   9 +-
 8 files changed, 265 insertions(+), 5 deletions(-)
---
base-commit: e7ed343658792771cf1b868df061661b7bcc5cef
change-id: 20240928-nolibc-csky-eff1104825d2

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


