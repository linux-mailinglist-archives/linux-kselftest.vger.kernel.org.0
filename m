Return-Path: <linux-kselftest+bounces-24580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4280A12694
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 15:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FEF3A91CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 14:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABD08633D;
	Wed, 15 Jan 2025 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="EcwzGoE6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6542136E37
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952867; cv=none; b=SVaghp9kdmrRgIAfnshVMa3UZgP6nH0iQg4M4ARSK1t0XnRDmCAJa4xG+z/v+Xv2m51rJ6SxWvAY4mB6HfW0CpSSZ1paNczXLWjaJHzcHSCmDZLHyA7wNqf0C9DyGeOuYPa1uPmJYsXD7sv50ufFERlmivc2LumblnCB21Mmz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952867; c=relaxed/simple;
	bh=SL5MVsK1XmCnLH1EcD2ZksK86SXEJOhX56LincCzx6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ORjZceK0t5GHj8tiBvSB5hJ8t5+nD7qsrXfi5ejqxLg6fucd58W6fe5RyhDdyqyJ9QAabVtRp69QMq00B2MfL2QPRM5N5lxcpG7Q3Qa/FtnGt6M0bPOCPIy1nywviI8RiuYP5a9YN2B1z/s2Cj5A7huTgrBqMWwxuaFQJxBs4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=EcwzGoE6; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YY8CW6690zX2V;
	Wed, 15 Jan 2025 15:54:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736952855;
	bh=k8Fi1MaMn/YCYoXT2YTlhmpK9IYqOUl7lGoOnB560gU=;
	h=From:To:Cc:Subject:Date:From;
	b=EcwzGoE66LsdBaWwYUEYS5DWWjpu/Nt0TuC/Lp6jPFUkAGpLyoLYlxjWAl4tf88EF
	 ShnZr7KtLHJxJx2UrByLppaZ+CQ7aHwTn2/3ha+oaoJ5VSz2CckOYvWBo4HSkiXNr2
	 f1uepa3nA/TQifFdJ+DNJRurh4irQhxCt674fI/4=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YY8CW2WrszjHh;
	Wed, 15 Jan 2025 15:54:15 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v1] selftests/landlock: Fix build with non-default pthread linking
Date: Wed, 15 Jan 2025 15:54:07 +0100
Message-ID: <20250115145409.312226-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Old toolchains require explicit -lpthread (e.g. on Debian 11).

Cc: Günther Noack <gnoack@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Fixes: c8994965013e ("selftests/landlock: Test signal scoping for threads")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
index 348e2dbdb4e0..480f13e77fcc 100644
--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -13,11 +13,11 @@ TEST_GEN_PROGS := $(src_test:.c=)
 TEST_GEN_PROGS_EXTENDED := true
 
 # Short targets:
-$(TEST_GEN_PROGS): LDLIBS += -lcap
+$(TEST_GEN_PROGS): LDLIBS += -lcap -lpthread
 $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
 
 include ../lib.mk
 
 # Targets with $(OUTPUT)/ prefix:
-$(TEST_GEN_PROGS): LDLIBS += -lcap
+$(TEST_GEN_PROGS): LDLIBS += -lcap -lpthread
 $(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
-- 
2.48.1


