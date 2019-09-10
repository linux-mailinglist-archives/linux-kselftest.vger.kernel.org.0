Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB9DBAE9EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2019 14:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfIJMER (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Sep 2019 08:04:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfIJMER (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Sep 2019 08:04:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 356438D65DB;
        Tue, 10 Sep 2019 12:04:17 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-63.ams2.redhat.com [10.36.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BFE43DE4;
        Tue, 10 Sep 2019 12:04:09 +0000 (UTC)
Date:   Tue, 10 Sep 2019 13:03:43 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>
Subject: [PATCH 5/6] selftests/clone3: enable clone3 self-tests on all
 architectures
Message-ID: <d1a101897be9ee31b11f13ec61384f004dafd40c.1568116761.git.esyr@redhat.com>
References: <cover.1568116761.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568116761.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Tue, 10 Sep 2019 12:04:17 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

clone3() is available on most architectures, so there's no reason to
restrict the respective self-tests to x86_64.

* tools/testing/selftests/clone3/Makefile (TEST_GEN_PROGS): Set always,
not only ifeq ($(ARCH),x86_64).

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 tools/testing/selftests/clone3/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
index 4efcf45..faa069c 100644
--- a/tools/testing/selftests/clone3/Makefile
+++ b/tools/testing/selftests/clone3/Makefile
@@ -4,8 +4,6 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
 
 CFLAGS += -I../../../../usr/include/
 
-ifeq ($(ARCH),x86_64)
-	TEST_GEN_PROGS := clone3 clone3_set_tid
-endif
+TEST_GEN_PROGS := clone3 clone3_set_tid
 
 include ../lib.mk
-- 
2.1.4

