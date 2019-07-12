Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F65867401
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2019 19:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGLROL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jul 2019 13:14:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbfGLROL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jul 2019 13:14:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6B6C2300194A;
        Fri, 12 Jul 2019 17:14:11 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (ovpn-122-246.rdu2.redhat.com [10.10.122.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3FF860BFB;
        Fri, 12 Jul 2019 17:14:10 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org
Subject: [RFC PATCH] selftests/livepatch: only consider supported arches
Date:   Fri, 12 Jul 2019 13:14:02 -0400
Message-Id: <20190712171402.15930-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 12 Jul 2019 17:14:11 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Only run the livepatching self-tests on x86_64 and ppc64le arches.

Reported-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/testing/selftests/livepatch/Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index fd405402c3ff..9842fb473d42 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -1,5 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
 
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+
+ifeq ($(ARCH),x86_64)
+livepatch_supported := 1
+endif
+ifeq ($(ARCH),ppc64le)
+livepatch_supported := 1
+endif
+
+ifdef livepatch_supported
+
 TEST_PROGS_EXTENDED := functions.sh
 TEST_PROGS := \
 	test-livepatch.sh \
@@ -7,3 +18,5 @@ TEST_PROGS := \
 	test-shadow-vars.sh
 
 include ../lib.mk
+
+endif
-- 
2.21.0

