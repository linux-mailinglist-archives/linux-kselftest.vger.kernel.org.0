Return-Path: <linux-kselftest+bounces-38117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67765B176EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 22:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3BE16208F
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 20:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4424169A;
	Thu, 31 Jul 2025 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qh2OlH6R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DD92F24
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753992623; cv=none; b=MQaY26yIMNrfF40rYqtk384Jew5+uOYFZ+BGHG4knZE9oza+pC51S44eGvcVCW5KcTsCm8VXgorlFmj14GS1sNgcNGiJOj4SD7X6x6WxlKq0SbPB3tOf72OwjqPZDVolj/y75rxyegH/sFgxuahqd86/+a+TlHXD5353xndV8dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753992623; c=relaxed/simple;
	bh=WxHeXqjT8Zn5BVhJpoljQ0LzCywOZf7PcfAXTNZ+ojE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rsEHyYKuOlGM/GQueXiSSlfnSctCHJk3ugqD5Hk3TuG3ycTqVkMHyZZklY5e6PrAhb7Mpnrx9W8/Kd7NzgZmfEP+PuI4wuTvasufFQoSQmcYW2mTQkOglhqzVBQUGerbxd/NmE4/VMXd8r0JbC4fONr8q+DQYfqYBv3if7xmKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sudarsanm.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qh2OlH6R; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sudarsanm.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748d96b974cso1398864b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753992621; x=1754597421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J09bJnyFyHUEqMAMcKAT+RUtJuszd341ngKo2pBlF9A=;
        b=qh2OlH6RA3WEFLqgdPIpXXXmlZXu9Ggt4zjXuR+U6ICybIavTyQaH1Bgm3p5uuJYca
         ysmDfqsa0E6YcGFb00ZPrHButkcWsMoKMc9DN124deKuc18ddi/a9Tc3w0IfK4tDK7Q/
         766YYct1AJ8GU0bqWopxodmSCpD7uczJmrBrLo6Jn7Lnc22SAXPsP5sBmeQTZMl8lUxM
         6kRa7aw6pzaWiuDdi/R58fbKl93GQKxWGfAIGz/hKkoJI4xRKh1GKUBzzyzuzIpIhpie
         U5Ucxg2395uK34ymxMDI3MxiqBW2wzgjUfMPJL8k9Pj7P1Nq5+5DU0kli5IDAcoEnBLt
         yJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753992621; x=1754597421;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J09bJnyFyHUEqMAMcKAT+RUtJuszd341ngKo2pBlF9A=;
        b=ndAS/wq95ShHkZrhH51xJY6qbUmMaGDypmK1ZWVOE4UPsngV9Yw8XdWN5yuOMBphxS
         zm8VRZme8SdJ6j5Cu7Zjn0NArfFe8nOd0c60dj7k/N/EbMC92HhfLwjnQLJCY3VTsmmy
         JcNdzlL//qC88B6NwDhpU4NGd1VWx8Vegtg9ugrFbEbpH1GquXmWEJS49rBNtcwtLJGE
         OPhj0fsukX8JesnFN1Up9dBSmlRav5wSGL6xceLTfTdBE4n025iiEbSm4T0ysK/hm+1u
         +9arBaZESbsZ1Xt+v+z9eao1VzcsG5DgkzMUYAbIQmHXu58GVjRjF6x70gCmxD1rnin2
         YTTg==
X-Gm-Message-State: AOJu0Yyyz2hYQftlU/G0CbAqjrzeU+4qEu/cw1eGu5Sh+Q/HY15mBpZU
	eGDsR0hL8j66sTmDX79ERdDeV4Ce0xBg3SSmvq46G4RJ+rdkpxctbP9XB54l7RebA8ut5WF3Rrb
	D0Xe68f/iqd/v4iAem8+MSe4s9mkJUIMZ6hzdKfFE6zXrXRFjHNIS5qHYioVT2gMhu/HwdVZdM/
	o8lS+7bV6mzs9neD+55dYupGTl/sBI7raoyuGJsxMaHZCN9tSXgIUluy3GLLQLCV4H
X-Google-Smtp-Source: AGHT+IHgx/cYgrYinezSkOTAmAfU/9csyQH9piPDnBU/wf7uG2ssY6nBUVDU1MMbLwCPMAV4sTmBpXU9mwzHGbM=
X-Received: from pgng29.prod.google.com ([2002:a63:375d:0:b0:b31:d832:f7b0])
 (user=sudarsanm job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:8095:b0:23d:dcb9:d50d with SMTP id adf61e73a8af0-23ddcb9f6dcmr3837708637.25.1753992621200;
 Thu, 31 Jul 2025 13:10:21 -0700 (PDT)
Date: Thu, 31 Jul 2025 13:10:09 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731201009.888945-1-sudarsanm@google.com>
Subject: [PATCH] selftests/mm: pass filename as input param to VM_PFNMAP tests
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

Pass random file name as input:
	pfnmap -- /dev/blah
	TAP version 13
	1..6
	# Starting 6 tests from 1 test cases.
	#  RUN           pfnmap.madvise_disallowed ...
	#      SKIP      Cannot open '/dev/blah'

Signed-off-by: Sudarsan Mahendran <sudarsanm@google.com>
---
 tools/testing/selftests/mm/pfnmap.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
index 866ac023baf5..2d4e8b165f91 100644
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
@@ -117,19 +119,19 @@ FIXTURE_SETUP(pfnmap)
 	if (find_ram_target(&self->phys_addr, self->pagesize))
 		SKIP(return, "Cannot find ram target in '/proc/iomem'\n");
 
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
 
 	/* ... and want to be able to read from them. */
 	if (test_read_access(self->addr1, self->size1, self->pagesize))
-		SKIP(return, "Cannot read-access mmap'ed '/dev/mem'\n");
+		SKIP(return, "Cannot read-access mmap'ed '%s'\n", file);
 
 	self->size2 = 0;
 	self->addr2 = MAP_FAILED;
@@ -246,4 +248,14 @@ TEST_F(pfnmap, fork)
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


