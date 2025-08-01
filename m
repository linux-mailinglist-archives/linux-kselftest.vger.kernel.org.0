Return-Path: <linux-kselftest+bounces-38195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D330B1898C
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 01:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29EA1C27B77
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 23:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5106E2288EA;
	Fri,  1 Aug 2025 23:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKM8Ryfu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6AF1DE8B2
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Aug 2025 23:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754091976; cv=none; b=gkZDeWB/Sa3IhLzLdebVIkolyqXx4TujW/SHGHGGHzORQK+ZrdXnX9PQZCbYFvoJNiDITVdU8I32is4152QQuxMAypi7h5z3j9lAfTORz7+1VD/8iOB92Pq2ZhCHpmrtFDqAJlOp4kPHOKPzwUJV48T9qpTVbmGDcJzaRefkPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754091976; c=relaxed/simple;
	bh=bS7rEVA6VOp5auQ9tUYDfAC51sfZnwTq9yGVyd0AaxY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G+ib/TXEV/D9TIdT3MCLd3C04tzbnNjNxiTfbwkEJ4+GMrvGuOSXfoazUPDbHigaIFTVh/LeR3u+J7XhcHDAWjnsUFuUroGK7k6/M/pzyKz96H+SXtLMJISmXuzJ+V1EKYZyvZn8aCEQYQqFAfyIhmo++hKc4uVXvKZJsXPZsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sudarsanm.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WKM8Ryfu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sudarsanm.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f65d519d3so3643940a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Aug 2025 16:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754091974; x=1754696774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RCbUWFNAiQIE2SEZGiipZa782xmKSM+6i2HHrci0QuA=;
        b=WKM8RyfuPoIe27BxE91ui438MbvRFFhzlj9VrF7XDMjXo51tTAslqU9NscDt4EMUsF
         6fP3BvA99B9iN9WMfA/x9SC9aMvp8FaPCnFRaU3WBPT5lonEaUwgOO+KgaI9QuTNd8wf
         I/ODbUKo7xX0GQU0oWKkBy7e/miWOSsHO2JoEDXQUSfLVwwVUO3yi7TbnnI9LxsP18cv
         iaWxBOc9xiTJb6PjqKoTIdjBbvf8SNSzsyod0WX21LgWsAF1eHSxbgU3bo5TjssCXuet
         aotqfFdevKTK1pHwnjAwg+iw0PujiLtYeQPaKUapdIFKsIh66S/zr1a3iqvBd3YnaSds
         RaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754091974; x=1754696774;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RCbUWFNAiQIE2SEZGiipZa782xmKSM+6i2HHrci0QuA=;
        b=nBF0+p15PrG+0OuS7/9UWaX5sFQaziT38XDTYzMJ2q1pyVTHoR1ASceAyidQe+TG1K
         ROwbmuzGw/TQsES6jkb1qd/Qxj0SwQpJYWfmaRtiSmjCR0Sys9RVHa5ZHxfdbOqf9Rih
         YvMGOz4NVQ4JCAKPVsICrcMHdMSYTpoLdK1MUuq54s4nqFBVfSL94CHVikVCh8cxRP1t
         Bv6DIFTJAA00idxb6CA2h3jOAea9vQmORvhMYSw1nVhYOFhUVUc2AA8hk/Udum3dC8xd
         9g+hI/4hKdyytOwSzHd5//kPSXyAsk3NDLUUzlwMcbaOq9RtEnnOKm4E9NbEdldNx8+/
         1AWg==
X-Gm-Message-State: AOJu0Yw49EScG6jmWhpAMnQfyXcjE6Pd0oLk9N0wR85PycA7UGU86bOd
	C4eNYZEaN2l9LHX/wii7WVUSUZrYskd0TmXZkSKuGB1HJJRFYFIJz56RxKEQrMVDKltyu9Yo2/U
	OEYhw8HhH5u5ZIdoG5HoqBuhGVP2eSpckZ2soI4FQtJ+Ue2zypwxQbc+a13NA33NMWXJ4xqMvQc
	lUc4H4iHkE867Ugu3ZeWdqyb5mM5wIJZq/zL7yRqWvWBLuszVHAP8FhravdYNgnlaZ
X-Google-Smtp-Source: AGHT+IFb+ysewxBs4h3pIvhDOB58xFs76O5xVyYH3xfpChybjlsHQtJ6CB+wmDZbgnZS7YoS4QbL24y0lzKb8BA=
X-Received: from pjvv13.prod.google.com ([2002:a17:90b:588d:b0:31e:cee1:4d04])
 (user=sudarsanm job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3e86:b0:31f:1a3e:fe31 with SMTP id 98e67ed59e1d1-321161ed89fmr1974835a91.11.1754091973873;
 Fri, 01 Aug 2025 16:46:13 -0700 (PDT)
Date: Fri,  1 Aug 2025 16:45:59 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250801234559.1178521-1-sudarsanm@google.com>
Subject: [PATCH v2] selftests/mm: pass filename as input param to VM_PFNMAP tests
From: Sudarsan Mahendran <sudarsanm@google.com>
To: linux-kselftest@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	trivial@kernel.org, Sudarsan Mahendran <sudarsanm@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable these tests to be run on other pfnmap'ed memory like
NVIDIA's EGM.

Add '--' as a separator to pass in file path. This allows
passing of cmd line arguments to kselftest_harness.
Use '/dev/mem' as default filename.

Existing test passes:
	pfnmap
	TAP version 13
	1..6
	# Starting 6 tests from 1 test cases.
	# PASSED: 6 / 6 tests passed.
	# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

Pass params to kselftest_harness:
	pfnmap -r pfnmap:mremap_fixed
	TAP version 13
	1..1
	# Starting 1 tests from 1 test cases.
	#  RUN           pfnmap.mremap_fixed ...
	#            OK  pfnmap.mremap_fixed
	ok 1 pfnmap.mremap_fixed
	# PASSED: 1 / 1 tests passed.
	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Pass non-existent file name as input:
	pfnmap -- /dev/blah
	TAP version 13
	1..6
	# Starting 6 tests from 1 test cases.
	#  RUN           pfnmap.madvise_disallowed ...
	#      SKIP      Cannot open '/dev/blah'

Pass non pfnmap'ed file as input:
	pfnmap -r pfnmap.madvise_disallowed -- randfile
	TAP version 13
	1..1
	# Starting 1 tests from 1 test cases.
	#  RUN           pfnmap.madvise_disallowed ...
	#      SKIP      Invalid file: 'randfile'. Not pfnmap'ed

Signed-off-by: Sudarsan Mahendran <sudarsanm@google.com>
---

v1 -> v2:
* Add verify_pfnmap func to sanity check the input param
* mmap with zero offset if filename != '/dev/mem'

---
 tools/testing/selftests/mm/pfnmap.c | 62 ++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
index 866ac023baf5..e078b961c333 100644
--- a/tools/testing/selftests/mm/pfnmap.c
+++ b/tools/testing/selftests/mm/pfnmap.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Basic VM_PFNMAP tests relying on mmap() of '/dev/mem'
+ * Basic VM_PFNMAP tests relying on mmap() of input file provided.
+ * Use '/dev/mem' as default.
  *
  * Copyright 2025, Red Hat, Inc.
  *
@@ -25,6 +26,7 @@
 #include "vm_util.h"
 
 static sigjmp_buf sigjmp_buf_env;
+static char *file = "/dev/mem";
 
 static void signal_handler(int sig)
 {
@@ -98,6 +100,30 @@ static int find_ram_target(off_t *phys_addr,
 	return -ENOENT;
 }
 
+static int verify_pfnmap(void)
+{
+	FILE *smaps_fp;
+	char line[512];
+	int found_mmap_entry = 0;
+
+	smaps_fp = fopen("/proc/self/smaps", "r");
+	if (!smaps_fp)
+		return -errno;
+	while (fgets(line, sizeof(line), smaps_fp) != NULL) {
+		if (strstr(line, file) && strstr(line, " r--s "))
+			found_mmap_entry = 1;
+
+		if (found_mmap_entry &&
+		    strncmp(line, "VmFlags:", strlen("VmFlags:")) == 0) {
+			if (strstr(line, " pf "))
+				return 0;
+			found_mmap_entry = 0;
+		}
+	}
+	fclose(smaps_fp);
+	return -ENOENT;
+}
+
 FIXTURE(pfnmap)
 {
 	off_t phys_addr;
@@ -113,23 +139,31 @@ FIXTURE_SETUP(pfnmap)
 {
 	self->pagesize = getpagesize();
 
-	/* We'll require two physical pages throughout our tests ... */
-	if (find_ram_target(&self->phys_addr, self->pagesize))
-		SKIP(return, "Cannot find ram target in '/proc/iomem'\n");
+	if (strncmp(file, "/dev/mem", strlen("/dev/mem")) == 0) {
+		/* We'll require two physical pages throughout our tests ... */
+		if (find_ram_target(&self->phys_addr, self->pagesize))
+			SKIP(return,
+				   "Cannot find ram target in '/proc/iomem'\n");
+	} else {
+		self->phys_addr = 0;
+	}
 
-	self->dev_mem_fd = open("/dev/mem", O_RDONLY);
+	self->dev_mem_fd = open(file, O_RDONLY);
 	if (self->dev_mem_fd < 0)
-		SKIP(return, "Cannot open '/dev/mem'\n");
+		SKIP(return, "Cannot open '%s'\n", file);
 
 	self->size1 = self->pagesize * 2;
 	self->addr1 = mmap(NULL, self->size1, PROT_READ, MAP_SHARED,
 			   self->dev_mem_fd, self->phys_addr);
 	if (self->addr1 == MAP_FAILED)
-		SKIP(return, "Cannot mmap '/dev/mem'\n");
+		SKIP(return, "Cannot mmap '%s'\n", file);
+
+	if (verify_pfnmap())
+		SKIP(return, "Invalid file: '%s'. Not pfnmap'ed\n", file);
 
 	/* ... and want to be able to read from them. */
 	if (test_read_access(self->addr1, self->size1, self->pagesize))
-		SKIP(return, "Cannot read-access mmap'ed '/dev/mem'\n");
+		SKIP(return, "Cannot read-access mmap'ed '%s'\n", file);
 
 	self->size2 = 0;
 	self->addr2 = MAP_FAILED;
@@ -246,4 +280,14 @@ TEST_F(pfnmap, fork)
 	ASSERT_EQ(ret, 0);
 }
 
-TEST_HARNESS_MAIN
+int main(int argc, char **argv)
+{
+	for (int i = 1; i < argc; i++) {
+		if (strcmp(argv[i], "--") == 0) {
+			if (i + 1 < argc && strlen(argv[i + 1]) > 0)
+				file = argv[i + 1];
+			return test_harness_run(i, argv);
+		}
+	}
+	return test_harness_run(argc, argv);
+}
-- 
2.50.1.565.gc32cd1483b-goog


