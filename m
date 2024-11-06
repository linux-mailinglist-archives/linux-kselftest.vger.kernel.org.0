Return-Path: <linux-kselftest+bounces-21548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEE69BF46F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 18:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2386F1C2152E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 17:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C9C206E8E;
	Wed,  6 Nov 2024 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkGQ8JLj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52176645;
	Wed,  6 Nov 2024 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730914917; cv=none; b=PXtOw2MMhOjiyY98TIv6i5RBcciOPVDNuuoUcktf6Y2OWQRiN8VhFNPAtjjN8IGz25CxZNGRJzsI06XKZHbrEgRaNC8hfgG2YQWwja+Gxr3kTGV1RlXC/sr6nJq1xTYS5lApUxh0wY0tcNucFj3MwnDx/jh4mbJVpNp0iN1Lf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730914917; c=relaxed/simple;
	bh=sIrAmIJ4TorY1A1s2YwJ051nt+86a8G/2pKO0f9HgmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TOLSQmJcF7oMoDGxAtRE7rvDteYTbIYCe9dyOpxWINRfAdAA96heYjUW0MNGWkAQb5wcchW4Et2SSgiVRUt0B+OgvOL9UFfcZYrnJR5llX0i+OdO6OqszZ5RMJ57CkVTtSOexfy6Ec5rb+48w3pGff7LEL1Tfc2o9RwBHBHyVQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkGQ8JLj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so103100a12.0;
        Wed, 06 Nov 2024 09:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730914915; x=1731519715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bm3BtEti0bBgX9dhuIDWg9VG8nhnA6KHMWpcip8W1Lc=;
        b=MkGQ8JLj1kwvrXsLaeXTZfibmw7kcQe4osGrWadPcwfo2IA7vhHGacBvx8hdxreQOb
         HbtQPQJ3CWPmDTA3GgYFXXuxIK8NF1AwdXhlWF4pelfT14HPnxkMvdu3sOdn8FjskkB7
         T1zctPCtRijZAmWL2XHNa83fps3yCUVRBOkFkldQqVj7rOmUmH/FUYwDNZ9WWWFLmq8/
         +fffW40soIcaBg7nq2JK6U92myRrQkYMr1rybk3WuCN0u5B49LT/okmpLYAn9bxUMvG9
         bSE+AU7gb0sBbzNNlPxRCQ4BMF2YmCm2DiUJgUkgPd55ZC1Qtkbx2T1YPLq8nwvgLm7R
         jV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730914915; x=1731519715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bm3BtEti0bBgX9dhuIDWg9VG8nhnA6KHMWpcip8W1Lc=;
        b=peMYgTLe6m5c1pG7XTL2uPo9tGZ5fr8fgj0GwPq5iz9zHqASe50uzDwvaPG/UHeCVF
         IZ+fIaCJsw5BeR6TRlueANTm0ldULTBC79LGkMUZjUrW2QP3INbqNYxXnQYGRtgfSnpX
         GERYJ/oGuRKSQB13fzkdaTVLfkwPv/olKVpO8m8ivkxF9KmOl4PlevnZPL+7+uNjpXzR
         CEWMEHbz1zCO+Ri1MxSKoxHtUiDJfHFB3qVrzr7/no45xxAI3An1x0yzCJ+0mvoQM0f4
         JdiyHPdGaXE/eqod2fY43XV0K6NcndNpJoBrIrJCSzpRpX8wsw8ZpM8acx3ZD5yo2QgZ
         l+Yg==
X-Forwarded-Encrypted: i=1; AJvYcCV4Pclfre6FCHNejjS4YtCjlTubRHGbokNkYlWdOLCvBbeBQyKbhTWe9wC7Ve3fk8OVGvAW/EK6u89aWZ95lg==@vger.kernel.org, AJvYcCXy0aDkaC8gmWwYjwQPoDleko82+2N5cpO/CnySe4I5zv+feTwY37bgiLIPH4N8wU6N/xN57cRrjO3vbQsbgXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzkBgnrU13bK6zqo9j9DJRTdUpEzVdRqW4yDq7ZhF/E+ljST5g
	k/IOeM4ibK22W36/A4cXpNB7iyXjRddD2IZPPYrb6TKIjL487vc1
X-Google-Smtp-Source: AGHT+IE/Q9qbNqnJklGog/4T2SZLIgY8UPzGyaHikSI4++792sigksVQKwo4PcRRBGFE19HOTVDl0A==
X-Received: by 2002:a17:902:fc45:b0:20b:9f8c:e9d3 with SMTP id d9443c01a7336-210c6ccfa73mr584037495ad.55.1730914915417;
        Wed, 06 Nov 2024 09:41:55 -0800 (PST)
Received: from BiscuitBobby.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105706933sm98949335ad.83.2024.11.06.09.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 09:41:55 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: shuah@kernel.org,
	jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com
Cc: Siddharth Menon <simeddon@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/livepatch: Check if CONFIG_LIVEPATCH is enabled
Date: Wed,  6 Nov 2024 23:11:20 +0530
Message-Id: <20241106174120.5602-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_LIVEPATCH is disabled, compilation fails due to the
required structs from the livepatch header file being undefined.
This checks for CONFIG_LIVEPATCH in order to verify that
it is enabled before compiling livepatch self-tests.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 tools/testing/selftests/livepatch/test_modules/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
index e6e638c4bcba..b34b80544709 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -1,5 +1,6 @@
 TESTMODS_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
 KDIR ?= /lib/modules/$(shell uname -r)/build
+CONFIG_LIVEPATCH := $(shell cd $(KDIR) && scripts/config --state CONFIG_LIVEPATCH)
 
 obj-m += test_klp_atomic_replace.o \
 	test_klp_callbacks_busy.o \
@@ -13,10 +14,15 @@ obj-m += test_klp_atomic_replace.o \
 	test_klp_shadow_vars.o \
 	test_klp_syscall.o
 
-# Ensure that KDIR exists, otherwise skip the compilation
+
+# Ensure that KDIR exists and CONFIG_LIVEPATCH is enabled, else skip compilation
 modules:
 ifneq ("$(wildcard $(KDIR))", "")
+ifneq ($(filter y m,$(CONFIG_LIVEPATCH)),)
 	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
+else
+    $(warning CONFIG_LIVEPATCH is not enabled in the kernel config file.)
+endif
 endif
 
 # Ensure that KDIR exists, otherwise skip the clean target
-- 
2.39.5


