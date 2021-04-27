Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5F136C753
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Apr 2021 15:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbhD0Nyb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Apr 2021 09:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbhD0NyZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Apr 2021 09:54:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104F1C061574;
        Tue, 27 Apr 2021 06:53:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 783161F424AA
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        shuah@kernel.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 1/2] selftests: futex: Correctly include headers dirs
Date:   Tue, 27 Apr 2021 10:53:27 -0300
Message-Id: <20210427135328.11013-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427135328.11013-1-andrealmeid@collabora.com>
References: <20210427135328.11013-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When building selftests, the build system will install uapi linux
headers at usr/include in kernel source's root directory. When building
with a different output folder, the headers will be installed at
kselftests/usr/include. Add both paths so we can build the tests using
up-to-date headers. Currently, this is uncommon to happen since it's
rare to find a build system with an outdated futex header, but it
happens when testing new futex operations.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 tools/testing/selftests/futex/functional/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 23207829ec75..1d2b3b2a5b86 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-INCLUDES := -I../include -I../../
+INCLUDES := -I../include -I../../ -I../../../../../usr/include/ \
+	-I$(KBUILD_OUTPUT)/kselftest/usr/include
 CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES)
 LDLIBS := -lpthread -lrt
 
-- 
2.31.1

