Return-Path: <linux-kselftest+bounces-181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6AD7ED5A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 22:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EE8280E17
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7D945BFC;
	Wed, 15 Nov 2023 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="koQhOm6G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2156D196;
	Wed, 15 Nov 2023 13:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1700082503;
	bh=CTsA5lI8lYA3WInzrUfmp2TktRtuX8KANJ9jWl+c2CI=;
	h=From:Subject:Date:To:Cc:From;
	b=koQhOm6G5G1RG9ZKWXvmByD+QGyClLiOMkJb9OOolK+2P9sJ74045B1QbpGr1WSgm
	 4Bp1UB6KmItqigfIb18Mi1SyHnFqcprm7rWoCz+UJawiiT6Y/funPD4fvi13KXA3B8
	 3k8poHJU1j6TAHBvLL/8ZtsatHm7xEFL7xyZTCq8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH RFC 0/3] selftests/nolibc: introduce new test harness
Date: Wed, 15 Nov 2023 22:08:18 +0100
Message-Id: <20231115-nolibc-harness-v1-0-4d61382d9bf3@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEIzVWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQwNT3bz8nMykZN2MxKK81OJiXSOLZFNLAyPLFPNEUyWgpoKi1LTMCrC
 B0UpBbs5KsbW1AJUtSMNlAAAA
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700082502; l=1050;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=CTsA5lI8lYA3WInzrUfmp2TktRtuX8KANJ9jWl+c2CI=;
 b=dNZ9JoznMaHKgGB6ViC2QV3bBhhy8b+gqTcUwfMSwdNBrwfj8egGjyvVpxskDj+9/Ut4raMbf
 LNm5lXAs4tWDIu3wAg2qMSfSd02rXVacSQGsOrtchXQRuqwUgkm6hYc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This series introduces a new test harness for nolibc.
It is similar to kselftest-harness and google test.
More information in patch 1.

This is an RFC to gather feedback, especially if it can be integrated
with the original kselftest-harness somehow.

Note:

When run under qemu-loongarch64 8.1.2 the test "mmap_munmap_good" fails.
This is a bug in qemu-user and already fixed there on master.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      selftests/nolibc: add custom test harness
      selftests/nolibc: migrate startup tests to new harness
      selftests/nolibc: migrate vfprintf tests to new harness

 tools/testing/selftests/nolibc/nolibc-harness.h | 269 ++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c    | 180 ++++++++--------
 2 files changed, 353 insertions(+), 96 deletions(-)
---
base-commit: d38d5366cb1c51f687b4720277adee97074b22e9
change-id: 20231105-nolibc-harness-28c59029d7a5

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


