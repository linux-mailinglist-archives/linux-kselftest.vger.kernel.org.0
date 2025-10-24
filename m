Return-Path: <linux-kselftest+bounces-44001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11735C0738A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47C4C5616A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD0133B967;
	Fri, 24 Oct 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VR+DuFIE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF23385B1
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322216; cv=none; b=QPTF4VwqDwjTFkUB5Og98y1FIzmsMyudPL1Jvx8CUDgJoXqR7V4nQ1mi3wb9BI8O+PXolgKjquCBLnUnvjMC1PvfTBXgJ2qeeDkCOFAoVPG7wVTY8zo9CAUgQ1TkRK5HM+vMqLZtrXRVIz0xU+/YuMu6zzyGn5k7BWs2zOTUARQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322216; c=relaxed/simple;
	bh=47nCxyU4kXn+xfRtbLcXpCvIUy2KTrw5bnGeJZgJkWw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VI28Ej6rPg9l6bqC1dVFIS0Q86DuzhxeblYvXNp1Yo2vDOMd+WU1YaknRXon0d227GNyL3gsNAsvXRdd6iuz5PFTsM//N9zXPILa7AT6/vlO3rvK1Jh4dN5yKdvdnjssG0RfROk81Wg0+4XZJQCdWWtx38h6GIhEjwExKg1z0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=VR+DuFIE; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-781421f5be6so25760077b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761322212; x=1761927012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0Chij7I5YmPbNPLJtF290sPw75eaI56z9Bpyk1lLtA=;
        b=VR+DuFIE80cOY2YsniD2DX3xG0XoFuioW9AwWzsYivw9JAoDE4e3fVnhyoBIiUAMV7
         kkX6qhuSX1cepInZRg4SbmWEc5605xT51vXKlfHIYygBreCXF8JwcjEyCuGYTeND7zy2
         jBBzCulxBiZZ3q0mLTsk5lnlYQDORdKXG7pOBp+Ba9OmPwQwpvtwA2VPkjJPPHXZZz10
         ARnAqSY67HL7/pDZhKLTKIY2AZm0pvYlYtEpruUQA7eTDeP7ngX5SzB5u/OgbpxyNRGP
         LVRpmGm/tFU3E/Q8HuflZYPTkhsZ3BIxGfT4I3zx9fylgLXKROBVe6b1a1HdwgXh6Jez
         wLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322212; x=1761927012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0Chij7I5YmPbNPLJtF290sPw75eaI56z9Bpyk1lLtA=;
        b=we0HF1hZz9OE2ntATRhDz0aq/1FRkNZXiLFkeyC6gyEDINVhmeyf5/eh7aBpmug8lm
         ibiug/uKqAs+DaUpZpXqGrzChszs5njTCT38scGJVhGwZZxvBMcMyXTGyAfIi2XqIRtD
         u0wxY3sYFbtrbEQubIVL/DuSTa0dIns/nHlWK9x7cufuSZeaE/N8jbKVjqI/At5C30cD
         Pk3imqHdPs7NqNUzXwlKNvm+42nxrRusGHyBYgynXEK2Xr7GaX4bXwq+CytIrjs22h1w
         OD+ClFb2UJt5bc3VIUp69/TTpG9QcZmgY1owLRoYMnfmcKkQRuJFZ+meGln9poZTK4sF
         e3Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXyNeycRHiwS+VAE3havBvycr9zqaSelnEaqgmpSbp7gpUju6e7UC1bMyefBiLm8aYmb1bJ9f4yVjNY6ZPb2Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+BOl03MPYIM5Doi14hFLvqH7o4wIvCSzSeYiyPcSqHVXBINx
	bH0Kn0PI1HarccG3qcgt0ZlLLmeXZ04kmlskFnVuQ4UEyUnODh+73AEUy5BKq7WZZ74=
X-Gm-Gg: ASbGnctLeS8oUv1M+OTEswbnPLEQyCIX2imZw6W1NzthkQnf21oZSYNVUIFcNIxodfK
	r9KbnAvIDJT3Hm8FpfgJNhZRnAnnr9/T2JlpCdND8yEAPO7aImUnNvCoqrWkA3uge5yzLdOWmuU
	AQBaMrw49nTnKi4b74crmXuCqhRVncDGKbR2srmPl1nQOp3r/K+n+E/J/wGKB7Sln7fEw3iR51+
	PhLCTDCndxPvrVyyhdA3T3A6kq6umLx8Kg8jAlPIDNwm4QS0Jjg7PhFb6FEcREn8D7BvIiiZOqi
	6Ir3uh7bEr/HOb1q8Wz/1Zq8hmkAN+rV1Te0xMJvwW5ztt96dItEw6MR/r9tZyuhJ2CQlsnhlaZ
	O2iw22xJ2y3hnjc1RE0wdjcRlGBZh0uBmlIHKzT2GC+LIwYnaWIarvoVdWoBf+efqX3NPFb6Awe
	Q8lYiCIFpmLPzh0OcKdKngITov3nLwMiLA9UEKpBHl2sq5IUOwabWVqDWJ2TQoO6LgDxlQydGsT
	tgLplxOiloQTtFZiiysLd4=
X-Google-Smtp-Source: AGHT+IGrHktoB2+zSyNVNIoeQp5HcQOC7JtCZnm9h30tzfcmrjcwbTqgqHhgYQabiysiaKaamJl5yw==
X-Received: by 2002:a05:690c:dd3:b0:780:fe72:934b with SMTP id 00721157ae682-785e0231474mr22622787b3.48.1761322211974;
        Fri, 24 Oct 2025 09:10:11 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6edd87sm14099197b3.51.2025.10.24.09.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:10:11 -0700 (PDT)
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
Subject: [PATCH v8 7/8] liveupdate: kho: move kho debugfs directory to liveupdate
Date: Fri, 24 Oct 2025 12:10:01 -0400
Message-ID: <20251024161002.747372-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
In-Reply-To: <20251024161002.747372-1-pasha.tatashin@soleen.com>
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, that LUO and KHO both live under kernel/liveupdate, it makes
sense to also move the kho debugfs files to liveupdate/ in order to
keep current and upcoming LUO/KHO features organized.

The old names:
/sys/kernel/debug/kho/out/
/sys/kernel/debug/kho/in/

The new names:
/sys/kernel/debug/liveupdate/kho_out/
/sys/kernel/debug/liveupdate/kho_in/

Also, export the liveupdate_debufs_root, so future LUO selftests,
kexec telemtry, and other users could use it as well.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover_debugfs.c  | 10 +++++-----
 kernel/liveupdate/kexec_handover_internal.h |  2 ++
 tools/testing/selftests/kho/init.c          |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index 46e9e6c0791f..454b7d34ddc3 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -15,7 +15,7 @@
 #include <linux/mm.h>
 #include "kexec_handover_internal.h"
 
-static struct dentry *debugfs_root;
+struct dentry *liveupdate_debugfs_root;
 
 struct fdt_debugfs {
 	struct list_head list;
@@ -118,7 +118,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("in", debugfs_root);
+	dir = debugfs_create_dir("kho_in", liveupdate_debugfs_root);
 	if (IS_ERR(dir)) {
 		err = PTR_ERR(dir);
 		goto err_out;
@@ -178,7 +178,7 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
-	dir = debugfs_create_dir("out", debugfs_root);
+	dir = debugfs_create_dir("kho_out", liveupdate_debugfs_root);
 	if (IS_ERR(dir))
 		return -ENOMEM;
 
@@ -212,8 +212,8 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 
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
index 17ae101dc6ae..92798346fa5a 100644
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
2.51.1.821.gb6fe4d2222-goog


