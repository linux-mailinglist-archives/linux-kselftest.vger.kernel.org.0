Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5543634564C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 04:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhCWDgT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 23:36:19 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:46140 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCWDgJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 23:36:09 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Mar 2021 23:36:08 EDT
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 0705A980641;
        Tue, 23 Mar 2021 11:30:25 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Shuah Khan <shuah@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] tools: testing: Remove duplicate include of string.h
Date:   Tue, 23 Mar 2021 11:29:56 +0800
Message-Id: <20210323033007.283521-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHk9OSB0aQ0NJShofVkpNSk1PTEtJT0hDT0hVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nzo6Dgw5IT8TPDo8IwMPPDQ6
        ITwKCjdVSlVKTUpNT0xLSU9OTUxMVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTElKNwY+
X-HM-Tid: 0a785d226d89d992kuws0705a980641
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

string.h has been included at line 15.So we remove the 
duplicate one at line 17.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 tools/testing/selftests/mincore/mincore_selftest.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index 5a1e85ff5d32..e54106643337 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -14,7 +14,6 @@
 #include <sys/mman.h>
 #include <string.h>
 #include <fcntl.h>
-#include <string.h>
 
 #include "../kselftest.h"
 #include "../kselftest_harness.h"
-- 
2.25.1

