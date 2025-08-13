Return-Path: <linux-kselftest+bounces-38817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDF2B23EE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 05:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F23173D8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 03:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8051C3F36;
	Wed, 13 Aug 2025 03:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW6WCeFw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9956322338
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755055025; cv=none; b=VnfLtXflSm7QAztAPPEwFqT3MSvvFJ7zcLBZwBVPZSxsR24oOsJkNAkEoYgGpE/GOgw5R1ZXTIOGWTcIwwo4cj+N+BgOvrs2pbGqUhE0UmCRF0vKEIG+o6ETvmkH8/40FjO1E4zPeJWc6XguuAldg0RxgU5Tcz3hYFRxcdp+O2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755055025; c=relaxed/simple;
	bh=uTrJfeDkHbzkbafxXk1hE4oaPU2zcvUMr5+nHxPmZKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZolFygQ70QohyXcUvnJPcuQWAl/uePTuKpAOMJLnKROFCR+ih7OzJMDR7aOcgtjRXHE6ssM1FOmvProPEBdmPYX7glcclkLDY+4riv/U61Na7M/8DWvNiIjkhTzSRa7XJcQgGPUzSHx7T1TKpAR+CNaq6/CRVd9BL7px0v921PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW6WCeFw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-242d8dff9deso36831495ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 20:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755055022; x=1755659822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tQa3l8r3oa0PDX126bI4xp97qaQrGRrc3t+K1gk7MLA=;
        b=hW6WCeFwcxBo8NQRRSAmd5jK5BLx9PimTZXQ2CUL5qzhwduruWra/VmJnDal3vQRn0
         zfN0ntuZUbYZyvqAZ+q9lPMakfwKzfpVBNSeuf2yQmpEmM7vCAGXyDRNQ4Iq5mpsnnK8
         pOy9AWVZkwzsfJhgIZpGVepe8ZuHyU5s7pifjN7/635bl4CFSALKDQV71aXtnNszhC2/
         QyMkfd/oIvL7wcBVzGCEMS8sYwlCAdPIYXL7BJ7f4FC8y/e5hEc+HmhsswF1y5q1I21k
         f4Dhon7LSpARW9ZzDG25/63OQyTevV10EogD3wNNHZ1CqM1s7FIaoH+uAxY+W418TqlH
         CJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755055022; x=1755659822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQa3l8r3oa0PDX126bI4xp97qaQrGRrc3t+K1gk7MLA=;
        b=jrOhRhTAmB+NBX1tsPX7+kq0wV+CV8AR0d3BejesugnO4usDSHuA/jJHjJWeTU3yL4
         k/JSp3L7ttYLxWzj3fllEwInXqMer0ldpQxg2Ua8n0yd28YUCuhIFPaACWh1Br3BIAW6
         fk/VLZ/V1MFNxkmVWI7axS9VmoH6FwxHeSCIH6pq2fQV8QfneIq8W9ap4llizpuqKxvW
         fFgfkF9uy0blUj8RtvrKU8NkP5+97Rj3fnxAh8RhdhVWaH7oibBnCmI1RmjCMppCHVol
         KxBTgsb6fcgnG8f4Q+r7ukw2Ssuaekg1i5dqB4iTfpuMd078BLY87hYhJn5iito72F8w
         sovw==
X-Gm-Message-State: AOJu0YwH54mIf9xZ+xaom62UaUkeVh4Np1SJBHir6AUvEchDKq1udBmO
	vEqWwFw2gLfYcYYxf0a68Y2WMB7phfJmcNC8lF7p8J/aWLJ49oC5rXH1IauOvkByxPBp7hBQ
X-Gm-Gg: ASbGncuUvlFuqt6mNfNC8zOotfEtykSrndsuQsiTHd+PJS43MGo9JC+fblzhdfNp/8N
	YNvf6JpEUsy2KbercUtayruSGoSpkSTgbxAXs9HLo/rRPNKhksF/V0RJWJY2W8VUsxMp0pcdirl
	sik4nhD2PkPHAiLN4OFRPkQPQPDFL7q4nQzCrw++TKSoVVLYnowXehE1cjuwmJ9FnexvwxG774/
	f8JLVJXD+4DdZR56wycphm6X8hA0g6a/aF073CDfXh3O3TPgIFn867HYGRp0fELIMmtxsTvEt1h
	XZr2fFlLxjTI5XDVh4Oer6GK3ldI6mXYj4Zjrqa4dHadtc5kscPR4L5QA6x7AKehWIZMwVdXpbR
	3xzhud/iA4FliaK/oCH+FUA9QodzYBI6MAZrnBqxgXtzx4JsWAPk=
X-Google-Smtp-Source: AGHT+IE5xSSxzu8ainRjaiZs7LlI2AEtyxMf06NiV+2BpREsDqyDjhflm2YrmewyeMnliXzwuzbTAg==
X-Received: by 2002:a17:902:e5c8:b0:234:d292:be7a with SMTP id d9443c01a7336-2430d0bcf03mr26601575ad.1.1755055022172;
        Tue, 12 Aug 2025 20:17:02 -0700 (PDT)
Received: from localhost ([192.19.38.250])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241e89a6ec2sm311252085ad.145.2025.08.12.20.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 20:17:01 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	jhubbard@nvidia.com,
	amir73il@gmail.com,
	Xing Guo <higuoxing@gmail.com>
Subject: [PATCH] selftests/fs/mount-notify: Fix compilation failure.
Date: Wed, 13 Aug 2025 11:16:47 +0800
Message-ID: <20250813031647.96411-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c6d9775c2066 ("selftests/fs/mount-notify: build with tools include
dir") introduces the struct __kernel_fsid_t to decouple dependency with
headers_install.  The commit forgets to define a macro for __kernel_fsid_t
and it will cause type re-definition issue.

Signed-off-by: Xing Guo <higuoxing@gmail.com>
---
 .../mount-notify/mount-notify_test.c           | 17 ++++++++---------
 .../mount-notify/mount-notify_test_ns.c        | 18 ++++++++----------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 63ce708d93ed..e4b7c2b457ee 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -2,6 +2,13 @@
 // Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
 
 #define _GNU_SOURCE
+
+// Needed for linux/fanotify.h
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+#define __kernel_fsid_t __kernel_fsid_t
+
 #include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
@@ -10,20 +17,12 @@
 #include <sys/mount.h>
 #include <unistd.h>
 #include <sys/syscall.h>
+#include <sys/fanotify.h>
 
 #include "../../kselftest_harness.h"
 #include "../statmount/statmount.h"
 #include "../utils.h"
 
-// Needed for linux/fanotify.h
-#ifndef __kernel_fsid_t
-typedef struct {
-	int	val[2];
-} __kernel_fsid_t;
-#endif
-
-#include <sys/fanotify.h>
-
 static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";
 
 static const int mark_cmds[] = {
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index 090a5ca65004..9f57ca46e3af 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -2,6 +2,13 @@
 // Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
 
 #define _GNU_SOURCE
+
+// Needed for linux/fanotify.h
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+#define __kernel_fsid_t __kernel_fsid_t
+
 #include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
@@ -10,21 +17,12 @@
 #include <sys/mount.h>
 #include <unistd.h>
 #include <sys/syscall.h>
+#include <sys/fanotify.h>
 
 #include "../../kselftest_harness.h"
-#include "../../pidfd/pidfd.h"
 #include "../statmount/statmount.h"
 #include "../utils.h"
 
-// Needed for linux/fanotify.h
-#ifndef __kernel_fsid_t
-typedef struct {
-	int	val[2];
-} __kernel_fsid_t;
-#endif
-
-#include <sys/fanotify.h>
-
 static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";
 
 static const int mark_types[] = {
-- 
2.50.1


