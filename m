Return-Path: <linux-kselftest+bounces-42810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC72BC019B
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 05:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F14189B6BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 03:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05832236E0;
	Tue,  7 Oct 2025 03:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="I3Ny6C9G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB519F115
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759807877; cv=none; b=YdQsFhDZZGLQM22RfIiXSu0S2yeLFkVHSSTOz/gSSgOHBl9My5ex4VAygyPAAsz3rbfZigaaFRkQUl0fYu440OXdL56XgogQKXWjqLRhJW1QDhwMAcWoYREgDtsbADcp6iya64BDlyJlU+5aAZeFimNtny1cGkZJloORovH/wg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759807877; c=relaxed/simple;
	bh=/drT+47PUHF+YSiTzIpGKzopMpsKtV8QOoOnRRft+BU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAZeOBv/gc5FEms4XIsxPf0LpQ7lzoxJm+poRBdAY8XWRxtUWKUlJ3KmQKQkDVGjdcdbz1Yjws4ffLDUJIRTY+e3KzYXrF7yg6yfZ/tVTubuLm4UyDam1WqdlVp85Wwd6yvL+XUj3vvitrfrBg4kWjKgtDm2sbN2hv5SWb4qY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=I3Ny6C9G; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-892196f0471so2118343241.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Oct 2025 20:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759807875; x=1760412675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VBEGNGPrHJLgeZc8OwSpyVwglko2eCUcGTlg3MZ+0E=;
        b=I3Ny6C9GAT7H9+IIQk958hQxvMob44/CThPUWbMSYbFTUhb0Z+ylVI59lJ6VgBY161
         6xtYxs5qS0mM0q8L+05vkrmGP+cridOwC6GYmTPQkgh0RWBcdvdnqT28xTyo+0sx2r1g
         5Slf6k5moAw4wGDKEwRgVz1nTaU8nbJUX0Rb35N0WV48eRLeJtgKd1s0U4WVXxx3OYiG
         AAoTzr6sQNfVs3+poRCXU8vwlrplDxIITFxwfP/Vfxm4TFeR0BLn/9ZkA0RY8ns6rvEA
         pEXdPCKMS5P+neIfNPA8RuSIBUgO0s0orGvG5MbAaMbZQ8jiOjiXV74PotKKXi5K43zJ
         1btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759807875; x=1760412675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VBEGNGPrHJLgeZc8OwSpyVwglko2eCUcGTlg3MZ+0E=;
        b=siLT+etYP1mPTqEFBjB2Pb9Bmh2Jdg6QlB4OESiG+IvLtwC09okBWm0zOLau3EK/xY
         jstV3FXPTrNFj/HSbLpJm7z7WUFjaLp7QnoJL5SHhNTFlZp1lftxVwo161U3dDw2zd3P
         HztezYkW4l3S1iF0Pgp2zGmrDC/zXR1aADRbjcgFYiZQTz+QxdK/bE9QQyXqMQN5XKfu
         W/NjyqQdZ/XIJYZyEXO5UyhhS4ICTIwBET3sDdr0Lhssx+MiDqzdVHDnsY6L+isUnCxC
         B7a0e+s3MRo2xwFA8c8XebWTRWzPyovuWew5/J4x+h0oXr+T6RLXPk9FL/7oFTIaS5Xy
         OL8w==
X-Forwarded-Encrypted: i=1; AJvYcCWryCU//t44eBvnVC8v3hBuYttZV9xjbf6wMD8bgtyN1uBPgzvr2lEad4mXeXSwKWD0CEqZhzhaUttOPYIJ0gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSh7xf50YEGU6iezrejs0W/xhwNZvp1J+PFIewcfBwVYDsXeAG
	Z/uYmbFSaSq6Zr4fLfh14QLNO74miFrzcbF1/xbo2bNviPvAtVNVUUtiQLH4xrImHO4=
X-Gm-Gg: ASbGnctTW0FakXOFwBW/RJR3JbCNTNGmiH8mCXSHZtLIEFvaYYu1IEoiq2SyDbZZuL1
	nkxThu+S2jGsFohTQj8dljPYAulujk0z6tO2185UWO9cuaXldBrieaSW2sB5VdSxeVhjjHnqxKX
	TZdkzR3A5KT+1kLCFlGUQoWZiOzgkyetAeXTAzJ7If5dpTKcUUpKiPAzcevWQm/al+zWIaAHzac
	xzBnOD76pFkzeDMWFO3xR1uPYLgx2nPlW00nftyJK/V9hrMT/6nWl7ygwA87n/0JYFre6RqBPRa
	2MntxWI2B1ucd5M5YOP9mqfQnjlTWnZLXGHKNhgDpPa1+EyPgteWxKEZbg22qW1JueN+l4DQdNL
	xlFe6XcBwcIjmth4W3gpqF+1616URkNbCfMHMyCKZqrlgCb3weN5uFMrA0bicuSy8jwPkUjuPH8
	EGDgsGyKTO2fF1N/7q3RG80nogo0JMMOXC49k++xL30g==
X-Google-Smtp-Source: AGHT+IEm4J6yFD10/rZ/XdNA9W6YeHZUIRIn81vHOvDBC4QHa+8Eq0vvy55tHiaoLOJh8X8oN4bNLg==
X-Received: by 2002:a05:6122:1781:b0:54a:9e47:7624 with SMTP id 71dfb90a1353d-5524ea910damr5388462e0c.14.1759807875038;
        Mon, 06 Oct 2025 20:31:15 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-552ea335f07sm2446030e0c.15.2025.10.06.20.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 20:31:14 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org
Subject: [PATCH v5 7/7] kho: move kho debugfs directory to liveupdate
Date: Tue,  7 Oct 2025 03:31:00 +0000
Message-ID: <20251007033100.836886-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
In-Reply-To: <20251007033100.836886-1-pasha.tatashin@soleen.com>
References: <20251007033100.836886-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, that LUO and KHO both live under kernel/liveupdate, it makes
sense to also move the kho debugfs files to liveupdate/

The old names:
/sys/kernel/debug/kho/out/
/sys/kernel/debug/kho/in/

The new names:
/sys/kernel/debug/liveupdate/kho_out/
/sys/kernel/debug/liveupdate/kho_in/

Also, export the liveupdate_debufs_root, so future LUO selftests could
use it as well.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover_debug.c    | 10 +++++-----
 kernel/liveupdate/kexec_handover_internal.h |  2 ++
 tools/testing/selftests/kho/init.c          |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
index d4ac78d53a39..eb47f000887d 100644
--- a/kernel/liveupdate/kexec_handover_debug.c
+++ b/kernel/liveupdate/kexec_handover_debug.c
@@ -15,7 +15,7 @@
 #include <linux/mm.h>
 #include "kexec_handover_internal.h"
 
-static struct dentry *debugfs_root;
+struct dentry *liveupdate_debugfs_root;
 
 struct fdt_debugfs {
 	struct list_head list;
@@ -115,7 +115,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("in", debugfs_root);
+	dir = debugfs_create_dir("kho_in", liveupdate_debugfs_root);
 	if (IS_ERR(dir)) {
 		err = PTR_ERR(dir);
 		goto err_out;
@@ -175,7 +175,7 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("out", debugfs_root);
+	dir = debugfs_create_dir("kho_out", liveupdate_debugfs_root);
 	if (IS_ERR(dir))
 		return -ENOMEM;
 
@@ -209,8 +209,8 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 __init int kho_debugfs_init(void)
 {
-	debugfs_root = debugfs_create_dir("kho", NULL);
-	if (IS_ERR(debugfs_root))
+	liveupdate_debugfs_root = debugfs_create_dir("liveupdate", NULL);
+	if (IS_ERR(liveupdate_debugfs_root))
 		return -ENOENT;
 	return 0;
 }
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index de90a678274d..b3fc1957affa 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -15,6 +15,8 @@ struct kho_debugfs {
 	struct list_head fdt_list;
 };
 
+extern struct dentry *liveupdate_debugfs_root;
+
 #else
 struct kho_debugfs {};
 #endif
diff --git a/tools/testing/selftests/kho/init.c b/tools/testing/selftests/kho/init.c
index 6d9e91d55d68..f0136a30ce8b 100644
--- a/tools/testing/selftests/kho/init.c
+++ b/tools/testing/selftests/kho/init.c
@@ -11,7 +11,7 @@
 /* from arch/x86/include/asm/setup.h */
 #define COMMAND_LINE_SIZE	2048
 
-#define KHO_FINALIZE "/debugfs/kho/out/finalize"
+#define KHO_FINALIZE "/debugfs/liveupdate/kho_out/finalize"
 #define KERNEL_IMAGE "/kernel"
 
 static int mount_filesystems(void)
-- 
2.51.0.618.g983fd99d29-goog


