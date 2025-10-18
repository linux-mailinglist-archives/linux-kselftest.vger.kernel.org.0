Return-Path: <linux-kselftest+bounces-43497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE2DBED4BA
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 19:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC965E72A3
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 17:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B272638BF;
	Sat, 18 Oct 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TfmjLqBp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4536125E451
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807890; cv=none; b=Daf7bhlX2mff3m3+3e/KaXjHnpjgqw40q7gRstTbtvrM5WadfttPUNGVhJ2U3oXtq6U0N9qAQoSB5txI312TE9j6m3emjMcodMCSO2EHeaMArlo1YEureZVzT/fGODRoOacPR5XiyD8b0frLmDtGtufvOVyzdVyDzwjNsCej+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807890; c=relaxed/simple;
	bh=BgJDaSS37AfTWmdC+Ced4iT0wmfV6rKUobcozTNQ4QM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7CkOwedjZ66dvwb3eu3fVAyaoL96Hqhi+fI5zFVbX9+YF0xhXI8av/SP0PYor6eFhHjOKCiPQespKtWEgLJwvF4wKK9JJqcbMdQa3PBGkFsMqtvX8w9KUUoKjkFWCGVWEqGycoUsEBsAPq9k55yuoTmvu72JKGOJRmAVsAeVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=TfmjLqBp; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78e4056623fso38714906d6.2
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760807887; x=1761412687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2rPu3rJk61NsUDORe6hfrEPNayKm6hvJ8nWbKNdE/g=;
        b=TfmjLqBpedvNsbuDQW857+8qakFh01u3qpDjNE64rIPulwsCwZZTf/jcBNpxNtZP+R
         6YSophr+QGwMrkl1etOf7CWGimqtmB75hf8i71riI1Eo4Medjb/cdxNYiGOeMv00Dro9
         O960OH942J3z+HwPPFfQRqsyIyWDIX1WZdgB9V+dJC/tebuSpGmm7U3OvP5/FGoAkAlQ
         lkwz1eBULSwdtLJ/8cJXDFOR6yWKwlMBGw/kAyb7Ew4mpVPMgIyNG9vDqMTq3ODGpMsA
         nC7MS7yri3b2nz3EEH5rasEWPs6lE/3jhpHweehnzbLsUZvo6f/h2P9r9KWZkII9I/q6
         dyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807887; x=1761412687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2rPu3rJk61NsUDORe6hfrEPNayKm6hvJ8nWbKNdE/g=;
        b=CasajWaJprUq1wsjZMK5AzrqGUv4UM63Yd7tei+50D1BiKgqSIvYBmG0eqnXJDQmJO
         yaOKisRuUxRnGmKG+znynztbqTsdcjFK+rIgdLZY9Qy2zceXpUuBrlilL9PRM32MpxgS
         HniWih76WK12NSJJDLX4VImA5Zq7hk9AuW1sTNWnqxMZ4SND4TSEPSIztivhaxnpfClm
         oWc0ytJJe3UEhXfp7ATCrmGEU5dM1B9iQwmPtUPXYfQvj+9BFpSxrIqcG3H6FnZIyyFE
         7DWa1fQAIiMt+2hhBhMB8GH5WjkpvmR5ZMVZY4cBpYy3tmYeOQUwnNutrQ1l5SXEX5sy
         BzfA==
X-Forwarded-Encrypted: i=1; AJvYcCUgfubWrhiBlLdYV37JqXCZjbvTQDFzD4OyuhjbrO0OMPwa3yjxRu3nk3ZJDZL9iHh3k4CZsBVuUEBzfNJWncE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywiI8/zpk0/1FYEHl2RtwFL3tk+m5jsi2rb0SG9E2uDUoTArTw
	ZPiqEjkYuMPTSN5iAEAIOlPkp7KBPFwa9i919lr2kv1uFd83C/cawCiQ3i0fPUJHRXI=
X-Gm-Gg: ASbGnctUHe4qdji60sGVhWJqhv2x8J0rhaO4hG0kRWd4P17R9dDomJUx/TQFGURGBhp
	Nkn0RavVj18KCVeRWXeE79+kK1xRyl7EeBHoK1nbj3GvMjubcB38OkNRhjaT4u0RR5zcoE50YWL
	w+PWjWQGEEIhwHeDdk6irz9QP1Ip11trqgZXjYDVVcFsYMwTHkUyvdzclyGdtSwN1pdC2mn+Qzj
	X/pD5O9K822BD4VvciW8+Kw1uEUnfS5f55o2h031sIqwxmVTA0t3P6ezW1ruBlze9bnq4mdfTGD
	NUK8B7SeKYmArHUCBoxnxHoF7gCKZp8rJfssBdGxKwiy32eMaUek624PJ+vrzrmYzf8g+heHKXM
	Fhvla2E3Jcu1wEOvJBzsysKVYbaE9QCA24qtqtP9onwVcLtW0qkPGQE7Xv7BpHOBvsxcSjUcCqJ
	BK5AvOlH+01/Ua9VcLTPZcpiZLYYApG6RScQkxD4UjaVLZd6K4hwOyqCUJq0VRlpVpliSd2jEdK
	ACzqjk6DiZDCyV4TxMIeS45lUDMJkg6
X-Google-Smtp-Source: AGHT+IFVF7YTAGmDUxpNHm20v159jaCZkyWRtFxoFzlU1BR8eeX69kBkAQ/hkjYMJqzT0Bo97bEDpg==
X-Received: by 2002:a05:622a:1a18:b0:4e8:b889:5c3c with SMTP id d75a77b69052e-4e8b8895f08mr10843041cf.33.1760807887246;
        Sat, 18 Oct 2025 10:18:07 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8e909sm18478116d6.62.2025.10.18.10.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:18:06 -0700 (PDT)
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
	tj@kernel.org,
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH v6 07/10] kho: move kho debugfs directory to liveupdate
Date: Sat, 18 Oct 2025 13:17:53 -0400
Message-ID: <20251018171756.1724191-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
In-Reply-To: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
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
 kernel/liveupdate/kexec_handover_debugfs.c  | 10 +++++-----
 kernel/liveupdate/kexec_handover_internal.h |  2 ++
 tools/testing/selftests/kho/init.c          |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index 6ddcd17fac3c..63447564dbe8 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
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
2.51.0.915.g61a8936c21-goog


