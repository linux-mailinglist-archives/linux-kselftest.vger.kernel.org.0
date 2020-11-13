Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A79F2B148E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Nov 2020 04:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgKMDKe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 22:10:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgKMDKe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 22:10:34 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A8920A8B;
        Fri, 13 Nov 2020 03:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605237026;
        bh=w0PIqQIa2g7JdZPE2RKMaUN0XJR1QVbsiBJg6lSBI5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=se34b0jejXYPpghg4e/bnhMjI1lvWpe2BkuB7TrzsoaBD+RwQV7bR1HKBSWgcxDn+
         oZrDox0mOpdTttk1rlGj56WH/zB7R5KH84xHWsMvhEOuUH02k/KLddVJ5FvXpm7mDt
         rxfqH+w/ZphNX5P2uBSBcKxjl0lqcjszW6j9Bk2M=
Date:   Thu, 12 Nov 2020 19:10:25 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Mark Brown <broonie@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Subject: Re: [PATCH v4 6/6] lib/cmdline_kunit: Add a new test suite for
 cmdline API
Message-Id: <20201112191025.bd5df6a1f1f6b0419980da1a@linux-foundation.org>
In-Reply-To: <20201112180732.75589-6-andriy.shevchenko@linux.intel.com>
References: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
        <20201112180732.75589-6-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 12 Nov 2020 20:07:32 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Test get_option() for a starter which is provided by cmdline.c.
> 
> ...
>
>  lib/cmdline_kunit.c | 98 +++++++++++++++++++++++++++++++++++++++++++++

The spectacular warning storm which this produces makes me wonder if
you sent the correct version?  I mean, the cmdline_test_values[]
definition wasn't even close.

This fixes it all for me:


--- a/lib/cmdline_kunit.c~lib-cmdline_kunit-add-a-new-test-suite-for-cmdline-api-fix
+++ a/lib/cmdline_kunit.c
@@ -13,19 +13,19 @@ static const char *cmdline_test_strings[
 	"+,"  , "--", ",,", "''" , "\"\",", "\",\"", "-\"\"", "\"",
 };
 
-static const char *cmdline_test_values[] = {
+static const char cmdline_test_values[] = {
 	1, 1, 1, 1, 2, 3, 2, 3,
 	1, 3, 2, 1, 1, 1, 3, 1,
 };
 
-static void cmdline_do_one_test(struct kunit *test, char *in, int rc, int offset)
+static void cmdline_do_one_test(struct kunit *test, const char *in, int rc, int offset)
 {
 	const char *fmt = "Pattern: %s";
-	char *out = in;
+	const char *out = in;
 	int dummy;
 	int ret;
 
-	ret = get_option(&out, &dummy);
+	ret = get_option((char **)&out, &dummy);
 
 	KUNIT_EXPECT_EQ_MSG(test, ret, rc, fmt, in);
 	KUNIT_EXPECT_PTR_EQ_MSG(test, out, in + offset, fmt, in);
_

but it sucks that get_option()'s first arg isn't `const char **str'.  I
was too lazy to look at addressing that.



lib/cmdline_kunit.c:17:2: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 1, 1, 1, 2, 3, 2, 3,
  ^
lib/cmdline_kunit.c:17:2: note: (near initialization for ‘cmdline_test_values[0]’)
lib/cmdline_kunit.c:17:5: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 1, 1, 1, 2, 3, 2, 3,
     ^
lib/cmdline_kunit.c:17:5: note: (near initialization for ‘cmdline_test_values[1]’)
lib/cmdline_kunit.c:17:8: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 1, 1, 1, 2, 3, 2, 3,
        ^
lib/cmdline_kunit.c:17:8: note: (near initialization for ‘cmdline_test_values[2]’)
lib/cmdline_kunit.c:17:11: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 1, 1, 1, 2, 3, 2, 3,
           ^
lib/cmdline_kunit.c:17:11: note: (near initialization for ‘cmdline_test_values[3]’)
lib/cmdline_kunit.c:17:14: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 1, 1, 1, 2, 3, 2, 3,
              ^
lib/cmdline_kunit.c:17:14: note: (near initialization for ‘cmdline_test_values[4]’)
lib/cmdline_kunit.c:17:17: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 1, 1, 1, 2, 3, 2, 3,
                 ^
lib/cmdline_kunit.c:17:17: note: (near initialization for ‘cmdline_test_values[5]’)
lib/cmdline_kunit.c:17:20: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 1, 1, 1, 2, 3, 2, 3,
                    ^
lib/cmdline_kunit.c:17:20: note: (near initialization for ‘cmdline_test_values[6]’)
lib/cmdline_kunit.c:17:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 1, 1, 1, 2, 3, 2, 3,
                       ^
lib/cmdline_kunit.c:17:23: note: (near initialization for ‘cmdline_test_values[7]’)
lib/cmdline_kunit.c:18:2: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 3, 2, 1, 1, 1, 3, 1,
  ^
lib/cmdline_kunit.c:18:2: note: (near initialization for ‘cmdline_test_values[8]’)
lib/cmdline_kunit.c:18:5: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 3, 2, 1, 1, 1, 3, 1,
     ^
lib/cmdline_kunit.c:18:5: note: (near initialization for ‘cmdline_test_values[9]’)
lib/cmdline_kunit.c:18:8: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 3, 2, 1, 1, 1, 3, 1,
        ^
lib/cmdline_kunit.c:18:8: note: (near initialization for ‘cmdline_test_values[10]’)
lib/cmdline_kunit.c:18:11: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 3, 2, 1, 1, 1, 3, 1,
           ^
lib/cmdline_kunit.c:18:11: note: (near initialization for ‘cmdline_test_values[11]’)
lib/cmdline_kunit.c:18:14: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 3, 2, 1, 1, 1, 3, 1,
              ^
lib/cmdline_kunit.c:18:14: note: (near initialization for ‘cmdline_test_values[12]’)
lib/cmdline_kunit.c:18:17: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 3, 2, 1, 1, 1, 3, 1,
                 ^
lib/cmdline_kunit.c:18:17: note: (near initialization for ‘cmdline_test_values[13]’)
lib/cmdline_kunit.c:18:20: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 3, 2, 1, 1, 1, 3, 1,
                    ^
lib/cmdline_kunit.c:18:20: note: (near initialization for ‘cmdline_test_values[14]’)
lib/cmdline_kunit.c:18:23: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
  1, 3, 2, 1, 1, 1, 3, 1,
                       ^
lib/cmdline_kunit.c:18:23: note: (near initialization for ‘cmdline_test_values[15]’)
lib/cmdline_kunit.c: In function ‘cmdline_test_noint’:
lib/cmdline_kunit.c:45:29: warning: passing argument 2 of ‘cmdline_do_one_test’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
   cmdline_do_one_test(test, str, rc, offset);
                             ^~~
lib/cmdline_kunit.c:21:13: note: expected ‘char *’ but argument is of type ‘const char *’
 static void cmdline_do_one_test(struct kunit *test, char *in, int rc, int offset)
             ^~~~~~~~~~~~~~~~~~~
lib/cmdline_kunit.c: In function ‘cmdline_test_lead_int’:
lib/cmdline_kunit.c:56:12: warning: initialization makes integer from pointer without a cast [-Wint-conversion]
   int rc = cmdline_test_values[i];
            ^~~~~~~~~~~~~~~~~~~

