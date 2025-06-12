Return-Path: <linux-kselftest+bounces-34820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFBFAD74FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 17:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AD9189BB66
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058D326D4F7;
	Thu, 12 Jun 2025 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v01xndwn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z3l0ZEVL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6662842048;
	Thu, 12 Jun 2025 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740053; cv=none; b=KaWp9gcncOAUrrODarmFeIflhsLgEZef+b1VHvGnWwUD2LuW6jBq/Zlj13ybY+PI01iBhjvSHtzuZqepaD4YZjlT5A7Fj2/tIQsnMhFfDHmEkYkmjXZljt7fefomV1WHj7bZE+bWthYGNrtgpClRz49TXCmE+/4GhykWLZD1sPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740053; c=relaxed/simple;
	bh=JLpyd2g/Xe7Snc8TZSz2U73JR+zRBfDYm2l2i1X5yzQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KwRkUKH2Cjyxvjipfo0AQSaJ54B6ODdr8rzFJBz0CfIuyyJgfwcDtoUynTXB7AMkjxHagcgVTy3FfDzdPvZxg97RdC12abZHvNO/0K5Q2d4v76P+9yeH4eXJaOuEJBaQsP2igxgINTUuPgCr0keRBCEqIPg8DdXf5/NYr1esD9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v01xndwn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z3l0ZEVL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749740050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fjwRLX2hmKU2M12T6FDQVTqpIRNQy8PjR1/oqRxiAuE=;
	b=v01xndwn5kle1gJ1WXpR+eVWH9xR6k3hd9zUVmVFQY5M3ZZKcS0c9v+BJ81BpCiBmjci6N
	WhJT6ONx/K4adk7NKGktPQ1mtHpSh7t0+LtFUEznSVH2+qo6PriILKAQRwS9si1BJaxXRT
	zZkZ4NJJNfVy7b2s5hqc/u7T3xyTE0NZoRnnZNXqQNQex3jOQjbgE4V5NuI7dlUAzpOpZh
	CfcqvUXgqXqPmFW9z/0yu5kqEGziJ4hXAPIP3F/CryyX5Ag7nCuh4dvUMoOr9UNb2jUBdl
	fV2HtBLZucMJJ53J+HX/2Jcn99Xu+O3pgNsLgQ+z0hXdiSK9sIekRWfWwsHwkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749740050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fjwRLX2hmKU2M12T6FDQVTqpIRNQy8PjR1/oqRxiAuE=;
	b=z3l0ZEVLqs494vuwhRCC0AaGkmClNHH1GPTRWwPaNjgLw32+8aA4HOCM937JRU6lsBanMG
	uXOGy5rmwF4lnCDg==
Subject: [PATCH 0/3] module: make structure definitions always visible
Date: Thu, 12 Jun 2025 16:53:53 +0200
Message-Id: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAALqSmgC/x3MQQqDMBBG4avIrB3IKHbhVaSLYP5pBzWRpEpBv
 HtDl9/ivYsKsqHQ2FyUcVqxFCukbWh++/gCW6imznWDe4jwckT7sGmA8pbCsaKwU2iQ3kOGnmq
 5Z6h9/9fped8/RgDNVmUAAAA=
X-Change-ID: 20250611-kunit-ifdef-modules-0fefd13ae153
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749740050; l=828;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=JLpyd2g/Xe7Snc8TZSz2U73JR+zRBfDYm2l2i1X5yzQ=;
 b=XWVHF8VTdoJM/mSgo4aVnOylh7DnsaPHQ6m/W9id/IzvZjlna/thD6sw9RK/dlNajeAj1CSjS
 BermlnFdJ+yBemtIP2L8WVwRdD3Z9sXScrW5+34Z0JkngBs9V4d4jwi
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Code using IS_ENABLED(CONFIG_MODULES) as a C expression may need access
to the module structure definitions to compile.
Make sure these structure definitions are always visible.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (3):
      module: move 'struct module_use' to internal.h
      module: make structure definitions always visible
      kunit: test: Drop CONFIG_MODULE ifdeffery

 include/linux/module.h   | 30 ++++++++++++------------------
 kernel/module/internal.h |  7 +++++++
 lib/kunit/test.c         |  8 --------
 3 files changed, 19 insertions(+), 26 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250611-kunit-ifdef-modules-0fefd13ae153

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


