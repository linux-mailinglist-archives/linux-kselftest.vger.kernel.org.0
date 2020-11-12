Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3960E2B0C4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 19:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgKLSHk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 13:07:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:40522 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgKLSHk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 13:07:40 -0500
IronPort-SDR: 3qd+5FI9bzlVs+uCZkiFFEyL35UZK2faTTJI8WIFc1Gp9lh5XNH/QGqIaj13meHPDMOjVKeW5j
 cYSbnMyeiXnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="170524783"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="170524783"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 10:07:37 -0800
IronPort-SDR: iFuFOn8H/stQv53GzlVyi/3O3vSdoPmWQoCI73P8XFSx2m+JNQaD9Vrp9Y7m06xEfw9nJTPVOh
 XxzdIuJURJZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="542350031"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 12 Nov 2020 10:07:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B067E1CB; Thu, 12 Nov 2020 20:07:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 5/6] lib/cmdline: Allow NULL to be an output for get_option()
Date:   Thu, 12 Nov 2020 20:07:31 +0200
Message-Id: <20201112180732.75589-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
References: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In the future we would like to use get_option() to only validate
the string and parse it separately. To achieve this, allow
NULL to be an output for get_option().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: new patch
 lib/cmdline.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index ca89846ee0bb..9e186234edc0 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -35,11 +35,14 @@ static int get_range(char **str, int *pint, int n)
 /**
  *	get_option - Parse integer from an option string
  *	@str: option string
- *	@pint: (output) integer value parsed from @str
+ *	@pint: (optional output) integer value parsed from @str
  *
  *	Read an int from an option string; if available accept a subsequent
  *	comma as well.
  *
+ *	When @pint is NULL the function can be used as a validator of
+ *	the current option in the string.
+ *
  *	Return values:
  *	0 - no int in string
  *	1 - int found, no subsequent comma
@@ -53,13 +56,16 @@ static int get_range(char **str, int *pint, int n)
 int get_option(char **str, int *pint)
 {
 	char *cur = *str;
+	int value;
 
 	if (!cur || !(*cur))
 		return 0;
 	if (*cur == '-')
-		*pint = -simple_strtoull(++cur, str, 0);
+		value = -simple_strtoull(++cur, str, 0);
 	else
-		*pint = simple_strtoull(cur, str, 0);
+		value = simple_strtoull(cur, str, 0);
+	if (pint)
+		*pint = value;
 	if (cur == *str)
 		return 0;
 	if (**str == ',') {
-- 
2.28.0

