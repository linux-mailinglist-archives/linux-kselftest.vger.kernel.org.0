Return-Path: <linux-kselftest+bounces-31538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37307A9AC56
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 13:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631CA1B66108
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 11:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F6920C47A;
	Thu, 24 Apr 2025 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qk07Z7wo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hQxERNe/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E73502B1;
	Thu, 24 Apr 2025 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495298; cv=none; b=jP/0Li2KFEM2sed375mStNYdpM34DVvG4+5N/AMi1KG7WPvtkv2Vh1SyUell/IUTU+owJ5umJPt1AGfQa9O1FQkZhPC/sk8CVHzigujgbak7PtWBtKf56l4qeVViEMB3fBdHa+EJrEw2qT6h2NfyFtzR80wSZ1FEU0eQbG4SsmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495298; c=relaxed/simple;
	bh=ZQBALqcbdeREoKk1JQ9L1sEsRqptJTO64uFdnLlIiFs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mBhsva9iH6FiFx/Vvl+7rr1NVZMZxGlCs5IWXd4SUNcSgW++DaY8wHfkGshDxOHV76P/Y004uZrz3kOA5nedrX/HMohdYVOirIvCqaaJJrc5BgbVXMqoEaXozWmZ2mWMWXYZS8Sx7EB6vIoZMyXCSd/z+gS/dwxG7d8tBJot6Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qk07Z7wo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hQxERNe/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745495294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b4gqK3XvgtjmsABAsUHFkSB1bzoa416jgmsA1Oq32MM=;
	b=qk07Z7wo9NwdWzenmH5aospwRenWTmltc8eUZOqPGjfk4yn54XxW4wUT1Pz4nGJLOuUP+X
	aolpjuFRjhlzQsSOH3GuIEPpUInYjpM4JZgZDSrk0I/uhSJQIGnX8b81kiIVKio44y3VCE
	UBiWAq+iTIK5S9LJkb/enU1rnPm4lJY5CmKIYN2sGt02tKsRFgB6FlvdzrPX/qOUAwCXa7
	u12cKwnrbNIG+iUZtPGI96hbbXiq/KBqkSpKKb2pwk3Vofq4+SCh9MLaJrDse5+Di8InZr
	je2GKNYFDbWG4QhykYngg8JtlHCXoSRdDxkv0ZFOgF7cQasmjkfco1/LWY2DzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745495294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b4gqK3XvgtjmsABAsUHFkSB1bzoa416jgmsA1Oq32MM=;
	b=hQxERNe/G8SGTpTm4YydL1KnEmZZYoSO0AVNlUpRgoZ9qHL6p/0gwUtl3aJZ88Jm/t5ES9
	04SFNZVDelI2iTDg==
Subject: [PATCH 0/3] tools/nolibc: make all headers usable directly
Date: Thu, 24 Apr 2025 13:48:10 +0200
Message-Id: <20250424-nolibc-header-check-v1-0-011576b6ed6f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPokCmgC/x3MQQqAIBBA0avErBswS6iuEi1sHHMoLBQiiO6et
 HyL/x/InIQzjNUDiS/JcsSCpq6Ago0ro7hi0Eob1ekW47HLQhjYOk5IgWnDnganm94o13oo5Zn
 Yy/1fp/l9P9hDOONlAAAA
X-Change-ID: 20250423-nolibc-header-check-8c9d21850d3f
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745495292; l=2016;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ZQBALqcbdeREoKk1JQ9L1sEsRqptJTO64uFdnLlIiFs=;
 b=Frwy+6b5tCTYqwrjK0QcsNRRIG2NzeuPoiyWVuL22OCb8X7niNOLzGi62F0lGAoEfFGvVn5SZ
 KinpA5iekLVBbObC5tVmxb+OycTLEbsivQL6+MxCSO8sFgXNrx6RcX/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Make sure that any nolibc header can be included in any order.
Even if nolibc.h was not pre-included already.

This conflicts indirectly with "tools/nolibc: various new functions" [0].
I'll resolve those conflicts when applying.

[0] https://lore.kernel.org/lkml/20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (3):
      tools/nolibc: add target to check header usability
      tools/nolibc: include nolibc.h early from all header files
      selftests/nolibc: always run nolibc header check

 tools/include/nolibc/Makefile           | 9 +++++++++
 tools/include/nolibc/ctype.h            | 6 +++---
 tools/include/nolibc/dirent.h           | 6 +++---
 tools/include/nolibc/elf.h              | 6 +++---
 tools/include/nolibc/errno.h            | 6 +++---
 tools/include/nolibc/fcntl.h            | 6 +++---
 tools/include/nolibc/getopt.h           | 6 +++---
 tools/include/nolibc/signal.h           | 6 +++---
 tools/include/nolibc/stdio.h            | 6 +++---
 tools/include/nolibc/stdlib.h           | 6 +++---
 tools/include/nolibc/string.h           | 7 +++----
 tools/include/nolibc/sys.h              | 6 +++---
 tools/include/nolibc/sys/auxv.h         | 6 +++---
 tools/include/nolibc/sys/mman.h         | 6 +++---
 tools/include/nolibc/sys/stat.h         | 7 +++----
 tools/include/nolibc/sys/syscall.h      | 6 +++---
 tools/include/nolibc/sys/time.h         | 6 +++---
 tools/include/nolibc/sys/wait.h         | 7 +++----
 tools/include/nolibc/time.h             | 6 +++---
 tools/include/nolibc/types.h            | 6 +++---
 tools/include/nolibc/unistd.h           | 6 +++---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 22 files changed, 70 insertions(+), 64 deletions(-)
---
base-commit: e90ce42e81381665dbcedc5fa12e74759ee89639
change-id: 20250423-nolibc-header-check-8c9d21850d3f

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


