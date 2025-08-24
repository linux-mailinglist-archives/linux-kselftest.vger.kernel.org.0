Return-Path: <linux-kselftest+bounces-39803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0597B32DFC
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 09:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD193B7912
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 07:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F9A1DE8A0;
	Sun, 24 Aug 2025 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUTc6lW4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420C920322;
	Sun, 24 Aug 2025 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756020695; cv=none; b=HHsrSiR9Dro4hLF1P/4CGlBTO8msfeX/uuBccd1uSpYBv0fFJZysYjrBkOkxGHmS9sn/Ju/lGVNAZVxOF4PcF1l0LKu1+ZHVzKy7EoKw0wbU4BEgvxn+99FbyyUWgYtS+7+pEW+bR7lOlCNvSc0WDrMt9q1VpLplY0xvMdjKfKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756020695; c=relaxed/simple;
	bh=0FUPSO0qR44avpaz4C6AVxCRIskHwHX/YehWeEq2yCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RHB3oFwWbTu+HbHtglAhI/SvvA2vJSB3uZpGth/tsDyxhFIIEC6k4NmK2Mt+//Qe0ivcTVJN9jb+zlKcjZGY+WRHePc6/NsndkxtTTv0iB5s9MuG9MDz0+q8sZVTHzj+lMNK26KPxo83BIrigXsTTvcsNzq1UjCTXDBROn6uZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUTc6lW4; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b471737b347so2209719a12.1;
        Sun, 24 Aug 2025 00:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756020693; x=1756625493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0tdSDrOuU0meqKe0q/eLK4pqoW3RHPCcxHyv0i5CmVw=;
        b=mUTc6lW4ze7G4z2MFkN8WVc3/rh9shxMjjcvd3GEazNA3hqRPwEk140SIt+TyQUYm+
         zF/xjOci8nljOX937Y4nPZASDVoVioSSe/KGpmodlfthje6HKAfr34hX5c5kLfYwd1nK
         U+gTmVCuTYT8sXQYxd3d3IM3XcDwv/8aHr9RK84Xo5v6xJ3umVHaI3ZFFgsrMesGpIR9
         PRqzvx5iVLQx8Wqzn301sG75F6UnVYOmgwHQ0Dc4zExfRkjuzIrLDfKIaZJ0OpnKTzVQ
         n7GVjtfibosBODzzYGeQYVLwL+uBMnViQr/ln69YGd02Oopczem68ZTTp0UhqM9u5Uw5
         Z/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756020693; x=1756625493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tdSDrOuU0meqKe0q/eLK4pqoW3RHPCcxHyv0i5CmVw=;
        b=ookS8V50XD70lTGo6Vy+P/oHDhI7zezDWcobOFAnzirKJkvv3da4eVMZSI/5FUkhdd
         2CCWip4auPVRF+Sov96ZSg68QebLR9+j6Y6L4lpqtk8A71rtPABZ1T7vWS/on2dum+NP
         O4gxVa2bAhsyagQyG1vEjAm7EHcSkBD9oHtcxQd5lz5SFr1vy6TqIRqDOdz+ZF0qP6JY
         Q4Qb1Ugyg2H38h4e6tUYbtod3v/EJy+XgapPpdND/K+/vjda/gOUHMgbHuz4VrIvnHbM
         WiDqiFP3K8cWZorH0MThKipPBTtExqpX3McLruKhxzxZJX0coREzVwKN7llEao7zWbEp
         Mcdg==
X-Forwarded-Encrypted: i=1; AJvYcCUn4wAeS7GD0tmmr0Cu8zRXVhKbrqthM4Jx9k8PVyZEtvlYFkizMLuSGL2jael2/UIxcbMWHlZB2BN8zIU=@vger.kernel.org, AJvYcCXr7uuv0PCvS2MWuHGCqNVj1WEunDwNk9TwuIKw2SyGQxJJ0V97Ttj1zeUwBmPn42sJpLNGbcGMbyYl3Wl1sk0K@vger.kernel.org
X-Gm-Message-State: AOJu0YyB10uWuczQNbFHcw+xuOSLiIFbQBgPxpxDsojvPMGYqXu/DEtG
	CalKAo2qmEx4nRl0Oj1UL2cgjkxaZ2SSC/lLHczSGqJ5OuJIeRK2vmu4
X-Gm-Gg: ASbGncttYBEvl3kqI66+A5zG3KVnhkh9dTWY8BZIkRh3VyDK0pdr/anc/h8iZ4YtdIK
	+VVyt1ivPjMbFomWwW60n7Frz2lUxaQqawBOY7rmag3HwVSC/gQ+16KobE1O7zXiYMyCa2j5vFv
	Z4RcNfukvc3xw0sIAzLDPuDmhJYZuqHjjIVzJezx9XEVooyMgvdjPc3M/LLLQdBRaRfh6VRtvlc
	Cid8lNHHvb8JaFGwv0MhFppcScZZApdfGZ9J/cqgagjrchF4g2+ubxiDZMsCgl4mg4WJP3tXeW/
	598XPKXS4/TE/Ie4LtRHi0dvcht4B8UaC0UGdy/eJS1VK7IbbBps45+/OEuvZcsXt0WnseA7+aN
	ukFi4JhV9sKl978lxr7R8PZe7F4aDL8hyOKCyhFVoN/dYqYHl4gilwTHJ
X-Google-Smtp-Source: AGHT+IEgj6wETq3v5OCQpeOF7zm/iygPZGg9CfdvpRPZ0RTu/9vsDClKOZva1F3JsIev0p+CupJ/Kg==
X-Received: by 2002:a17:903:2bcb:b0:242:9bc5:31a0 with SMTP id d9443c01a7336-2462efcd016mr121069395ad.56.1756020693472;
        Sun, 24 Aug 2025 00:31:33 -0700 (PDT)
Received: from chandna-HP-Laptop-15s-fq2xxx.. ([2401:4900:1c27:426:4f67:4c5d:adb5:a45d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466885ed72sm37307095ad.92.2025.08.24.00.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 00:31:32 -0700 (PDT)
From: Sahil Chandna <chandna.sahil@gmail.com>
To: shuah@kernel.org,
	brauner@kernel.org,
	namcao@linutronix.de,
	alexander@mihalicyn.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sahil Chandna <chandna.sahil@gmail.com>
Subject: [PATCH] selftests: coredump: Fix compilation issue
Date: Sun, 24 Aug 2025 12:54:48 +0530
Message-Id: <20250824072448.7387-1-chandna.sahil@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Building coredump selftests fails on x86 due to following issues:

1./usr/include/x86_64-linux-gnu/sys/mount.h:35:3: error: expected identifier before numeric constant
   35 |   MS_RDONLY = 1,                /* Mount read-only.  */
      |

<linux/fs.h> pulls in kernel-internal headers that conflict with
   glibc's <sys/mount.h>, causing this error.

2.stackdump_test.c:25:1: note: ‘offsetof’ is defined in header ‘<stddef.h>’; did you forget to ‘#include <stddef.h>’?

Missing <stddef.h> causes unresolved use of offsetof().

Fix this by:
  - dropping <linux/fs.h> and including <sys/mount.h>
  - including <stddef.h> for offsetof()

Signed-off-by: Sahil Chandna <chandna.sahil@gmail.com>
---
 tools/testing/selftests/coredump/stackdump_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
index a4ac80bb1003..881565d28fa9 100644
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -6,7 +6,7 @@
 #include <libgen.h>
 #include <limits.h>
 #include <linux/coredump.h>
-#include <linux/fs.h>
+#include <sys/mount.h>
 #include <linux/limits.h>
 #include <pthread.h>
 #include <string.h>
@@ -18,6 +18,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <unistd.h>
+#include <stddef.h>
 
 #include "../kselftest_harness.h"
 #include "../filesystems/wrappers.h"
-- 
2.34.1


