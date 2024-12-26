Return-Path: <linux-kselftest+bounces-23755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E1E9FCC90
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 19:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29669161894
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 18:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CB6145335;
	Thu, 26 Dec 2024 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="WssSvYF3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A93B145A11
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Dec 2024 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735236742; cv=none; b=TqRLQwQgKx4l5P14x70GxfO/LZpKnU7fuoZD9eO2njX/xNfM52eKHLPuhCWrKzNbnZzj4m8aQcXXe1hmTjyDYUoPYLlvyMtUEbacJF03b1+DICK4fCLdZRp25lAZWuq24q+OiQo43PweiwL/AO4kpSg8Wx1yPXC9vRTP2VWwAmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735236742; c=relaxed/simple;
	bh=nzG1DzuJnea5g6X5o1vjigq8qEV2BSXYKeLXVo9tUuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKjXOoVhPGuvruoeJnISte0TuDvv22zTufZ/bgTdilhMJPz6AfJeqyOHFkIJZp/zPwdstW0nOx6Hnm6LR+VWnU87cG+GdNGnizZXXsnej6FrwgiH6ZHdNqsBbzMON6YO7FGxeaEhjluC7ZjP5swEbep/ch39Gp0Pr625hBHK1cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=WssSvYF3; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1735236739; x=1766772739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nzG1DzuJnea5g6X5o1vjigq8qEV2BSXYKeLXVo9tUuI=;
  b=WssSvYF3oyd0cnRtgNoBDvfJc8JSEMYgZ5o17+Ge44iuGqpFJQTmtjbg
   g1N68OuNep6FrZU9hGES4Qzk+15dBAZ0pcEM+67JbWLaKrZb14qP0Lym9
   YPdnjx/agu69Rr6+BJGGdzlj/wsXxszluc5H8RtYm77RuqQKK1laG4OUe
   c=;
X-CSE-ConnectionGUID: CO6kCXVHQN69+vrx+oCIgQ==
X-CSE-MsgGUID: AQZNUrUyT7KyQs1p26BKSA==
X-IronPort-AV: E=Sophos;i="6.12,267,1728943200"; 
   d="scan'208";a="28325975"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 26 Dec 2024 19:12:10 +0100
Received: from ntu.. (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id AA2D62DB3;
	Thu, 26 Dec 2024 19:12:10 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-kselftest@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	kernel test robot <lkp@intel.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 1/1] selftests: Clear -Wimplicit-function-declaration warnings
Date: Thu, 26 Dec 2024 19:09:33 +0100
Message-ID: <20241226181203.527121-2-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241226181203.527121-1-ariel.otilibili-anieli@eurecom.fr>
References: <20241226181203.527121-1-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Seen while compiling tests,

```
$ make -C tools/testing/selftests/ TARGET=bpf 2>&1 | grep implicit

pidfd_fdinfo_test.c:230:13: warning: implicit declaration of function ‘mount’ [-Wimplicit-function-declaration]
pidfd_fdinfo_test.c:236:15: warning: implicit declaration of function ‘umount2’; did you mean ‘SYS_umount2’? [-Wimplicit-function-declaration]
pid_max.c:42:15: warning: implicit declaration of function ‘mount’ [-Wimplicit-function-declaration]
pid_max.c:48:9: warning: implicit declaration of function ‘umount2’; did you mean ‘SYS_umount2’? [-Wimplicit-function-declaration]
```

Adding sys/mount in the header clears out the warnings

```
$ make -C tools/testing/selftests/ TARGET=bpf 2>&1 | grep implicit; echo $?
1
```

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412222015.lMBH62zB-lkp@intel.com/
Cc: Christian Brauner <brauner@kernel.org>
Cs: Shuah Khan <shuah@kernel.org>
Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
---
 tools/testing/selftests/pid_namespace/pid_max.c   | 1 +
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
index 51c414faabb0..96f274f0582b 100644
--- a/tools/testing/selftests/pid_namespace/pid_max.c
+++ b/tools/testing/selftests/pid_namespace/pid_max.c
@@ -10,6 +10,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <syscall.h>
+#include <sys/mount.h>
 #include <sys/wait.h>
 
 #include "../kselftest_harness.h"
diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index f062a986e382..f718aac75068 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -13,6 +13,7 @@
 #include <syscall.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
 
 #include "pidfd.h"
 #include "../kselftest.h"
-- 
2.43.0


