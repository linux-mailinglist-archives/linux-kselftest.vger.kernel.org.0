Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD883C2D4F
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jul 2021 04:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhGJCWY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jul 2021 22:22:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232666AbhGJCVz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jul 2021 22:21:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12BB6613E1;
        Sat, 10 Jul 2021 02:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625883550;
        bh=cWHiH12FvTJFDthkEwrs//hjGIjPEoNDcrBkmfawt0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uirJPthb8Gcvy5QGyQBfk2pLkyirJS4FVfdkqqGgN5YjqCiFInz1CBOX8CvYXH6+r
         jkc/PVxliCXcIuImGWzIRQvmn3Qw/HmyMj8uVpDPxyWf+Rjb8OdF0ivbXlwI/Qh+Nx
         +SP6vf8iQ/Cg/ekBNNttq2fuHQA1OAzfY4s2Zn9ts4b6mD1kCt4mgNzTXQllwfNzoY
         OTnKUp7HVPa9YBnPFn4royarG370XK8vId8Qgi2Lu4TrxUVfnGjVNqgRCLO/Cfotwx
         AZzid72kJFMJe+pDwdUhk5NPq29wf0kErSAIpi6eqn7OhWdbrXRTlsK9RRqTtB5zvc
         QFTnmJjXUXwfA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Po-Hsu Lin <po-hsu.lin@canonical.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 060/114] selftests: timers: rtcpie: skip test if default RTC device does not exist
Date:   Fri,  9 Jul 2021 22:16:54 -0400
Message-Id: <20210710021748.3167666-60-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710021748.3167666-1-sashal@kernel.org>
References: <20210710021748.3167666-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Po-Hsu Lin <po-hsu.lin@canonical.com>

[ Upstream commit 0d3e5a057992bdc66e4dca2ca50b77fa4a7bd90e ]

This test will require /dev/rtc0, the default RTC device, or one
specified by user to run. Since this default RTC is not guaranteed to
exist on all of the devices, so check its existence first, otherwise
skip this test with the kselftest skip code 4.

Without this patch this test will fail like this on a s390x zVM:
$ selftests: timers: rtcpie
$ /dev/rtc0: No such file or directory
not ok 1 selftests: timers: rtcpie # exit=22

With this patch:
$ selftests: timers: rtcpie
$ Default RTC /dev/rtc0 does not exist. Test Skipped!
not ok 9 selftests: timers: rtcpie # SKIP

Fixed up change log so "With this patch" text doesn't get dropped.
Shuah Khan <skhan@linuxfoundation.org>

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/timers/rtcpie.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/rtcpie.c b/tools/testing/selftests/timers/rtcpie.c
index 47b5bad1b393..4ef2184f1558 100644
--- a/tools/testing/selftests/timers/rtcpie.c
+++ b/tools/testing/selftests/timers/rtcpie.c
@@ -18,6 +18,8 @@
 #include <stdlib.h>
 #include <errno.h>
 
+#include "../kselftest.h"
+
 /*
  * This expects the new RTC class driver framework, working with
  * clocks that will often not be clones of what the PC-AT had.
@@ -35,8 +37,14 @@ int main(int argc, char **argv)
 	switch (argc) {
 	case 2:
 		rtc = argv[1];
-		/* FALLTHROUGH */
+		break;
 	case 1:
+		fd = open(default_rtc, O_RDONLY);
+		if (fd == -1) {
+			printf("Default RTC %s does not exist. Test Skipped!\n", default_rtc);
+			exit(KSFT_SKIP);
+		}
+		close(fd);
 		break;
 	default:
 		fprintf(stderr, "usage:  rtctest [rtcdev] [d]\n");
-- 
2.30.2

