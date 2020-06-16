Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5C21FB0CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 14:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgFPMem (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 08:34:42 -0400
Received: from u164.east.ru ([195.170.63.164]:64002 "EHLO u164.east.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgFPMel (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 08:34:41 -0400
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2020 08:34:41 EDT
Received: by u164.east.ru (Postfix, from userid 1001)
        id D6B43512807; Tue, 16 Jun 2020 15:26:18 +0300 (MSK)
Date:   Tue, 16 Jun 2020 15:26:18 +0300
From:   Anatoly Pugachev <matorola@gmail.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Jiri Kosina <trivial@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH] selftests: vm: add fragment CONFIG_GUP_BENCHMARK
Message-ID: <20200616122618.GA24819@yogzotot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running gup_benchmark test the following output states that
the config options is missing.

$ sudo ./gup_benchmark
open: No such file or directory

$ sudo strace -e trace=file ./gup_benchmark 2>&1 | tail -3
openat(AT_FDCWD, "/sys/kernel/debug/gup_benchmark", O_RDWR) = -1 ENOENT
(No such file or directory)
open: No such file or directory
+++ exited with 1 +++

Fix it by adding config option fragment.

Fixes: 64c349f4ae78 ("mm: add infrastructure for get_user_pages_fast() benchmarking")
Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
CC: Jiri Kosina <trivial@kernel.org>
CC: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/vm/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vm/config b/tools/testing/selftests/vm/config
index 3ba674b64fa9..69dd0d1aa30b 100644
--- a/tools/testing/selftests/vm/config
+++ b/tools/testing/selftests/vm/config
@@ -3,3 +3,4 @@ CONFIG_USERFAULTFD=y
 CONFIG_TEST_VMALLOC=m
 CONFIG_DEVICE_PRIVATE=y
 CONFIG_TEST_HMM=m
+CONFIG_GUP_BENCHMARK=y
-- 
2.27.0

