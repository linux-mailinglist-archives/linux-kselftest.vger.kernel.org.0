Return-Path: <linux-kselftest+bounces-31204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30434A942F0
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 12:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC11189E720
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F89E1D5CD7;
	Sat, 19 Apr 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="I9fBV/VO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73EC1172A;
	Sat, 19 Apr 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745059592; cv=none; b=OrqssgdRgeFFTx+n8WoSrTH9/hAIrVU6Lzhs+SqwcN/jEpyWj5AiormuIcrYGctQXhGsiFggupsuUrAuFBLd+j44aMB5KLXFab1GlD2Pu+zIQmS/8ktaeA8hJ4r2g+qr2hNstWaLekT3QP1AfqeV0RsCHoApLvNOt096smG01N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745059592; c=relaxed/simple;
	bh=KAFPiA8S84/bPm1QFKKgkOwRMGPztmna1HAr0tGBIK4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n1LR9j378zjoBU9LSgYorJE6dBBNUYjsIXABMN9f0PaKx1egPYLwWwBeEU53cUQ/aPVEfOu37Sg/C0bxKHXFu7jsG6q1c6RdFPb+5CVlqqTN0ME0EZ9SkpFw5YcjdhfjUbh1qAEuVr4AfCI4eozxWlgeBxpHOsTZGyt5jX4XfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=I9fBV/VO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745059587;
	bh=KAFPiA8S84/bPm1QFKKgkOwRMGPztmna1HAr0tGBIK4=;
	h=From:Subject:Date:To:Cc:From;
	b=I9fBV/VOw3+22QIO1yRIcpTssGeYAPJD75L2NtHXF9lrzQiAkfU6wo/gye/PkTyXm
	 fkYrZiukITa2vKPUhlNkFYtVWZipRF4iPSsrEN49a76Y2Ijl8JKEh4zmg36418vXSE
	 tlWONJpRg5/aoRBrLdTDlOxCyorwXEpiEyyD2nqs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/7] tools/nolibc: fix some undefined behaviour and
 enable UBSAN
Date: Sat, 19 Apr 2025 12:46:17 +0200
Message-Id: <20250419-nolibc-ubsan-v2-0-060b8a016917@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPl+A2gC/3XMQQ6CMBCF4auQWVvT1lLQlfcwLGgZ7SSmJR1AD
 eHuVvYu/5e8bwXGTMhwqVbIuBBTiiX0oQIf+vhAQUNp0FLX0igrYnqS82J23EchdWuksufW1gb
 KZcx4p/fO3brSgXhK+bPri/qtf6BFCSm8aaRxTp+Gvrm+kJjZhzkcI07Qbdv2BcFgvM+tAAAA
X-Change-ID: 20250416-nolibc-ubsan-028401698654
To: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745059587; l=1347;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=KAFPiA8S84/bPm1QFKKgkOwRMGPztmna1HAr0tGBIK4=;
 b=RHwXfgvaLiBHh01N2zhVXYeHdqYIcGVcwF91eq6IS4TdUbK+vz7qBzlC+6iyYkjDJiH92Z/7W
 lreIOmAnP5KCYHiEiJM5uXnwZV42yc502NVUdYu81HDU1v5QhJznA39
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Fix some issues uncovered by UBSAN and enable UBSAN for nolibc-test to
avoid regressions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Introduce and use __nolibc_aligned_as()
- Reduce size of fixes to i{64,}toa_r()
- Link to v1: https://lore.kernel.org/r/20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net

---
Thomas Weißschuh (7):
      tools/nolibc: add __nolibc_has_feature()
      tools/nolibc: add __nolibc_aligned() and __nolibc_aligned_as()
      tools/nolibc: disable function sanitizer for _start_c()
      tools/nolibc: properly align dirent buffer
      tools/nolibc: fix integer overflow in i{64,}toa_r() and
      selftests/nolibc: disable ubsan for smash_stack()
      selftests/nolibc: enable UBSAN if available

 tools/include/nolibc/compiler.h              | 9 +++++++++
 tools/include/nolibc/crt.h                   | 5 +++++
 tools/include/nolibc/dirent.h                | 3 ++-
 tools/include/nolibc/stdlib.h                | 4 ++--
 tools/testing/selftests/nolibc/Makefile      | 3 ++-
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 6 files changed, 21 insertions(+), 4 deletions(-)
---
base-commit: 7c73c10b906778384843b9d3ac6c2224727bbf5c
change-id: 20250416-nolibc-ubsan-028401698654

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


