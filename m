Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF9A2DD55D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 17:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgLQQmX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 11:42:23 -0500
Received: from sym2.noone.org ([178.63.92.236]:38674 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbgLQQmW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 11:42:22 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4Cxcvc60hHzvjkw; Thu, 17 Dec 2020 17:31:40 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/vDSO: add additional binaries to .gitignore
Date:   Thu, 17 Dec 2020 17:31:40 +0100
Message-Id: <20201217163140.22635-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the test binaries introduced by commit 693f5ca08ca0 ("kselftest:
Extend vDSO selftest"), commit 03f55c7952c9 ("kselftest: Extend vDSO
selftest to clock_getres") and commit c7e5789b24d3 ("kselftest: Move
test_vdso to the vDSO test suite") to .gitignore.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/testing/selftests/vDSO/.gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/vDSO/.gitignore b/tools/testing/selftests/vDSO/.gitignore
index 5eb64d41e541..a8dc51af5a9c 100644
--- a/tools/testing/selftests/vDSO/.gitignore
+++ b/tools/testing/selftests/vDSO/.gitignore
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 vdso_test
+vdso_test_abi
+vdso_test_clock_getres
+vdso_test_correctness
 vdso_test_gettimeofday
 vdso_test_getcpu
 vdso_standalone_test_x86
-- 
2.29.0

