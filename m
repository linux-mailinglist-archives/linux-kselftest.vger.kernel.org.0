Return-Path: <linux-kselftest+bounces-9577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C5B8BDBA3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 08:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071B4282B26
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 06:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E7578274;
	Tue,  7 May 2024 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcQvIL6y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AEA74267;
	Tue,  7 May 2024 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063888; cv=none; b=ilaes5hP+JPTyTM3riSDfOK4R06O78mMLy5DqJLyGycNFfRmdUv2AmqNYhXyI9CtDpfW6WCzBIDD/l7D+Tciyr7nCcFTWMJF9Y3DccozL356OAe2Bci1JzxZvnrcTojVZmx/g1EvE7IdVTQ+21zGgUere1k+HqDWZYqNEzth/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063888; c=relaxed/simple;
	bh=al2uTCbUkaO+YN6iS/CsFF1oIj/GnxrR8GTTZRDImpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=m1q59kGR3dpkG7TvmKQKatHUciC/m7i2/TMMfo4uju+MTEooYd0pOHgpygWx/h7nv6Q2krAzitY22W18eVj+93PJbQnHaXb3FQZh3kfAv0pjqkoWo+GKWxTkpUV6I9Q5BrKqv4SNNVI3FOqlKeXfnYtCVjf3LhgBftLrGkpG6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcQvIL6y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715063887; x=1746599887;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=al2uTCbUkaO+YN6iS/CsFF1oIj/GnxrR8GTTZRDImpY=;
  b=BcQvIL6yQcsTT3xBivU+wKVFTzJGuB/n0/87nk5kf4Srm7vRn4kpqWx2
   T0sb8OOg7vPWyRu4wpKwa/4uflLF+Iq879gRJlXoBl2f/dop+3skUH6J7
   jlRT9w08ol9Qkh0N6R1XdC/LtHfFeGyIeREGWVcNerlk4+gO6JUmsCKl7
   CUqYuy6/thrjQRAw85ay2lGvB02ONtG4nEReeI30jSqm2Sj1+I3A3ncM+
   85ADFyhJYj7WPy5nxQa5xhbJYB+0tU8IiUQvmyL0J9CZLfq01ldR68aFj
   thTqp6CcEWzS1goEvlqf+v0cvmUc3grqqntOjtyLG57DiKd6/oudWM/Ab
   g==;
X-CSE-ConnectionGUID: ytcKcyc+Q5SmMDe+NMFAZQ==
X-CSE-MsgGUID: 7RdM4LPVSzCnnBv5DrS6lA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="28360753"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="28360753"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 23:38:06 -0700
X-CSE-ConnectionGUID: 0rO5EyK9SOGK0zZ0OrTZ8w==
X-CSE-MsgGUID: d7fc7jBVRbqxLmJn3Qedww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="65861231"
Received: from unknown (HELO st-server.bj.intel.com) ([10.240.193.102])
  by orviesa001.jf.intel.com with ESMTP; 06 May 2024 23:38:00 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-sgx@vger.kernel.org
Cc: akpm@linux-foundation.org,
	edliaw@google.com,
	ivan.orlov0322@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shuah@kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	bongsu.jeon@samsung.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexandre.belloni@bootlin.com,
	jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	tao1.su@linux.intel.com
Subject: [PATCH] selftests: Add _GNU_SOURCE definition when including kselftest_harness.h
Date: Tue,  7 May 2024 14:35:34 +0800
Message-Id: <20240507063534.4191447-1-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

asprintf() is declared in stdio.h when defining _GNU_SOURCE, but stdio.h
is so common that many files don’t define _GNU_SOURCE before including
stdio.h, and defining _GNU_SOURCE after including stdio.h will no longer
take effect.

Since kselftest_harness.h introduces asprintf(), it is necessary to add
_GNU_SOURCE definition in all selftests including kselftest_harness.h,
otherwise, there will be warnings or even errors during compilation.
There are already many selftests that define _GNU_SOURCE or put the
include of kselftest_harness.h at the very beginning of the .c file, just
add the _GNU_SOURCE definition in the tests that have compilation warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 tools/testing/selftests/alsa/test-pcmtest-driver.c      | 1 +
 tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c | 1 +
 tools/testing/selftests/nci/nci_dev.c                   | 1 +
 tools/testing/selftests/net/bind_wildcard.c             | 1 +
 tools/testing/selftests/net/ip_local_port_range.c       | 1 +
 tools/testing/selftests/net/reuseaddr_ports_exhausted.c | 1 +
 tools/testing/selftests/prctl/set-anon-vma-name-test.c  | 1 +
 tools/testing/selftests/prctl/set-process-name.c        | 1 +
 tools/testing/selftests/rtc/rtctest.c                   | 1 +
 tools/testing/selftests/sgx/main.c                      | 1 +
 tools/testing/selftests/tdx/tdx_guest_test.c            | 1 +
 tools/testing/selftests/user_events/dyn_test.c          | 1 +
 tools/testing/selftests/user_events/ftrace_test.c       | 1 +
 tools/testing/selftests/user_events/perf_test.c         | 1 +
 14 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/alsa/test-pcmtest-driver.c b/tools/testing/selftests/alsa/test-pcmtest-driver.c
index ca81afa4ee90..5a01100d459d 100644
--- a/tools/testing/selftests/alsa/test-pcmtest-driver.c
+++ b/tools/testing/selftests/alsa/test-pcmtest-driver.c
@@ -5,6 +5,7 @@
  *
  * Copyright 2023 Ivan Orlov <ivan.orlov0322@gmail.com>
  */
+#define _GNU_SOURCE
 #include <string.h>
 #include <alsa/asoundlib.h>
 #include "../kselftest_harness.h"
diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
index f3c2239228b1..40f3e81b1a6c 100644
--- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
@@ -4,6 +4,7 @@
  *
  * Tests for KVM paravirtual feature disablement
  */
+#define _GNU_SOURCE
 #include <asm/kvm_para.h>
 #include <linux/kvm_para.h>
 #include <linux/stringify.h>
diff --git a/tools/testing/selftests/nci/nci_dev.c b/tools/testing/selftests/nci/nci_dev.c
index 1562aa7d60b0..7cf18aced644 100644
--- a/tools/testing/selftests/nci/nci_dev.c
+++ b/tools/testing/selftests/nci/nci_dev.c
@@ -6,6 +6,7 @@
  * Test code for nci
  */
 
+#define _GNU_SOURCE
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/tools/testing/selftests/net/bind_wildcard.c b/tools/testing/selftests/net/bind_wildcard.c
index b7b54d646b93..f271e2ee6c7a 100644
--- a/tools/testing/selftests/net/bind_wildcard.c
+++ b/tools/testing/selftests/net/bind_wildcard.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright Amazon.com Inc. or its affiliates. */
 
+#define _GNU_SOURCE
 #include <sys/socket.h>
 #include <netinet/in.h>
 
diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
index 193b82745fd8..fadefb0ab147 100644
--- a/tools/testing/selftests/net/ip_local_port_range.c
+++ b/tools/testing/selftests/net/ip_local_port_range.c
@@ -7,6 +7,7 @@
  * Don't run these directly but with ip_local_port_range.sh script.
  */
 
+#define _GNU_SOURCE
 #include <fcntl.h>
 #include <netinet/ip.h>
 
diff --git a/tools/testing/selftests/net/reuseaddr_ports_exhausted.c b/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
index 066efd30e294..4f6fb2fbb96d 100644
--- a/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
+++ b/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
@@ -17,6 +17,7 @@
  *
  * Author: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
  */
+#define _GNU_SOURCE
 #include <arpa/inet.h>
 #include <netinet/in.h>
 #include <sys/socket.h>
diff --git a/tools/testing/selftests/prctl/set-anon-vma-name-test.c b/tools/testing/selftests/prctl/set-anon-vma-name-test.c
index 4275cb256dce..e5ea821be241 100644
--- a/tools/testing/selftests/prctl/set-anon-vma-name-test.c
+++ b/tools/testing/selftests/prctl/set-anon-vma-name-test.c
@@ -3,6 +3,7 @@
  * This test covers the anonymous VMA naming functionality through prctl calls
  */
 
+#define _GNU_SOURCE
 #include <errno.h>
 #include <sys/prctl.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/testing/selftests/prctl/set-process-name.c
index 562f707ba771..9cbfe9d38d72 100644
--- a/tools/testing/selftests/prctl/set-process-name.c
+++ b/tools/testing/selftests/prctl/set-process-name.c
@@ -3,6 +3,7 @@
  * This test covers the PR_SET_NAME functionality of prctl calls
  */
 
+#define _GNU_SOURCE
 #include <errno.h>
 #include <sys/prctl.h>
 #include <string.h>
diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 63ce02d1d5cc..2ace7a75c638 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2018 Alexandre Belloni <alexandre.belloni@bootlin.com>
  */
 
+#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/rtc.h>
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 9820b3809c69..bb6e795d06e2 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*  Copyright(c) 2016-20 Intel Corporation. */
 
+#define _GNU_SOURCE
 #include <cpuid.h>
 #include <elf.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/tdx/tdx_guest_test.c b/tools/testing/selftests/tdx/tdx_guest_test.c
index 81d8cb88ea1a..f966467d1ef1 100644
--- a/tools/testing/selftests/tdx/tdx_guest_test.c
+++ b/tools/testing/selftests/tdx/tdx_guest_test.c
@@ -7,6 +7,7 @@
  * Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
  */
 
+#define _GNU_SOURCE
 #include <sys/ioctl.h>
 
 #include <errno.h>
diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
index bdf9ab127488..9d090ba3bfc3 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2021 Beau Belgrave <beaub@linux.microsoft.com>
  */
 
+#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/user_events.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index dcd7509fe2e0..25adef590a94 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2021 Beau Belgrave <beaub@linux.microsoft.com>
  */
 
+#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/user_events.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index 5288e768b207..176740a0fc02 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2021 Beau Belgrave <beaub@linux.microsoft.com>
  */
 
+#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/user_events.h>
 #include <linux/perf_event.h>

base-commit: dccb07f2914cdab2ac3a5b6c98406f765acab803
-- 
2.34.1


