Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A372B0C4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 19:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKLSHk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 13:07:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:40522 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgKLSHj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 13:07:39 -0500
IronPort-SDR: IDZ96mduK2p0uBUEqXw4kfGvgKhsVoIUwOXMFrACNPUo5ENSFWrcM15oAKEU20qk7ecGanr69N
 Na9DX8gv/7YQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="170524782"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="170524782"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 10:07:37 -0800
IronPort-SDR: hMJ2a3+SFUZKl4pwv4qbrTIdtjX0/ebj5XUwS+Qocuz913GYuJR5xtiULbLvodmOZU31upRNgK
 VEYqj8TtkKDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="530764292"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 12 Nov 2020 10:07:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A59AA1C8; Thu, 12 Nov 2020 20:07:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 4/6] lib/cmdline: Fix get_option() for strings starting with hyphen
Date:   Thu, 12 Nov 2020 20:07:30 +0200
Message-Id: <20201112180732.75589-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
References: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When string doesn't have an integer and starts from hyphen get_option()
may return interesting results. Fix it to return 0.

The simple_strtoull() is used due to absence of simple_strtoul()
in a boot code on some architectures.

Note, the Fixes tag below is rather for anthropological curiosity.

Fixes: f68565831e72 ("Import 2.4.0-test2pre3")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: new patch
 lib/cmdline.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index fbb9981a04a4..ca89846ee0bb 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -45,6 +45,9 @@ static int get_range(char **str, int *pint, int n)
  *	1 - int found, no subsequent comma
  *	2 - int found including a subsequent comma
  *	3 - hyphen found to denote a range
+ *
+ *	Leading hyphen without integer is no integer case, but we consume it
+ *	for the sake of simplification.
  */
 
 int get_option(char **str, int *pint)
@@ -53,7 +56,10 @@ int get_option(char **str, int *pint)
 
 	if (!cur || !(*cur))
 		return 0;
-	*pint = simple_strtol(cur, str, 0);
+	if (*cur == '-')
+		*pint = -simple_strtoull(++cur, str, 0);
+	else
+		*pint = simple_strtoull(cur, str, 0);
 	if (cur == *str)
 		return 0;
 	if (**str == ',') {
-- 
2.28.0

