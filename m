Return-Path: <linux-kselftest+bounces-47764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD61FCD3016
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 14:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2465D300E80F
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38347302773;
	Sat, 20 Dec 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KsgUSNh3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC022571C7;
	Sat, 20 Dec 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766238968; cv=none; b=gNaYVLlPt4c0YldruZdqWU9JZ9ZEQZWAAklrsZPpbsnYyJR8cx+1fnguIKGK+R6qAmskIAWzYr1PLFZHi9qxWxOrec6kxlS8wjUJCsI7oXVdKCxJ9l+O0IiIcmsua0wLgyyYD+jjMLqK81BvQ5A4jKcEaUvCS3AHOha+o38VcI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766238968; c=relaxed/simple;
	bh=z/etifu9gRwBfcl+7sIe7IxoZbSmxOnrm1WccmCjPwQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jQ0mF/sDM9DbrTuMLShPUx4a6t3FRIstZCu7jutU466WwNn25VQHd5FSnWorBq0k94Lqp7L8j5/CfqraEU2+UihbaCAjo4mzjdjS0ahtKhGWvCJpeJKe/9hi3f7cvLilruW4m1lXHHL9DZ+akxSwG/usxCIxrwRUqCDIfZ1h5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KsgUSNh3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766238957;
	bh=z/etifu9gRwBfcl+7sIe7IxoZbSmxOnrm1WccmCjPwQ=;
	h=From:Subject:Date:To:Cc:From;
	b=KsgUSNh37nZSlWnqlomPPME/x0wGDuzk08hNRw2LBortI2IVPBfF5wdVf8/FaRVMB
	 qn6Jur2E96Ea8p4JEPhcyT8Wirbn/WRIt1n4n2PDmsIr1GLyekdwEJetDw4sNcWdYq
	 bkGSw1bq5M5wdPIK6SDnEi1/QDsvNuHeRFiku+qY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 00/14] tools/nolibc: always use 64-bit time-related
 types
Date: Sat, 20 Dec 2025 14:55:44 +0100
Message-Id: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOGqRmkC/23NwQ6CMAzG8VcxOzuzFibgyfcwHmAUaWKAUJgSw
 rs7iIkHOf6/pL/OSqhnEnU5zKonz8JtEyI6HpSr8+ZBmsvQCg1aMAZ00z65cHrMO9bD1JFocCb
 BEkzlXKLCXddTxe/NvN1D1yxD20/bCw/r+tUw29E8aKMpyUqKCgRbptcXsYi4eqxPDQ1qJT3+G
 EDcYzAwRQpxHkdnG1f2j1mW5QOhe5tw/gAAAA==
X-Change-ID: 20251001-nolibc-uapi-types-1c072d10fcc7
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766238956; l=2419;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=z/etifu9gRwBfcl+7sIe7IxoZbSmxOnrm1WccmCjPwQ=;
 b=iwIswsskSkTXVcsimaq7ejZ+S5zjBd3uArgelksiHCksmF3RrMuYfreYhw4FV5I5yexUdJ5zY
 3KFAOKTMQJXA4mVcpsQFlP4TG1WwSkimZUWjltxJbwB1hZ0e8rl552e
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

nolibc currently uses 32-bit types for various APIs. These are
problematic as their reduced value range can lead to truncated values.

Intended for 6.19.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Only use _Static_assert() where available
- Link to v2: https://lore.kernel.org/r/20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net

Changes in v2:
- Drop already applied ino_t and off_t patches.
- Also handle 'struct timeval'.
- Make the progression of the series a bit clearer.
- Add compatibility assertions.
- Link to v1: https://lore.kernel.org/r/20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net

---
Thomas Weißschuh (14):
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
      tools/nolibc: add compiler version detection macros
      tools/nolibc: add __nolibc_static_assert()
      selftests/nolibc: add static assertions around time types handling

 tools/include/nolibc/arch-s390.h             |   3 +
 tools/include/nolibc/compiler.h              |  24 +++++++
 tools/include/nolibc/poll.h                  |  14 ++--
 tools/include/nolibc/std.h                   |   2 +-
 tools/include/nolibc/sys/select.h            |  25 ++-----
 tools/include/nolibc/sys/time.h              |   6 +-
 tools/include/nolibc/sys/timerfd.h           |  32 +++------
 tools/include/nolibc/time.h                  | 102 +++++++++------------------
 tools/include/nolibc/types.h                 |  17 ++++-
 tools/testing/selftests/nolibc/nolibc-test.c |  27 +++++++
 10 files changed, 129 insertions(+), 123 deletions(-)
---
base-commit: 351ec197a66e47bea17c3d803c5472473640dd0d
change-id: 20251001-nolibc-uapi-types-1c072d10fcc7

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


