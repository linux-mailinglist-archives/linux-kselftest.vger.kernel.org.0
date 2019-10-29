Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDADE88F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2019 14:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbfJ2NAx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Oct 2019 09:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387868AbfJ2NAx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Oct 2019 09:00:53 -0400
Received: from [172.20.52.151] (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB3F20874;
        Tue, 29 Oct 2019 13:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572354051;
        bh=BL0YD5+tRHbynt6BJTKvBePK+6HtQvxjqI2aXHq3Gec=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=v30jJeTCJsuncSbEuYtAnradgkCzhzlSQFOOFej8hmIKBkTUkZaQ268wWgIy8kuvR
         nBM02GbqRiQyZoL6rf9ta930E4gi5UffaACWuPUdpeXyrW0QuDLnloBJTeGrSX7h2Y
         ASAI/ss1h/cI4qhbpUfz05LA5h2+QY0A/O+5A5Vc=
From:   shuah <shuah@kernel.org>
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for the
 'list' doubly linked list
To:     David Gow <davidgow@google.com>, brendanhiggins@google.com,
        akpm@linux-foundation.org, keescook@chromium.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com,
        shuah <shuah@kernel.org>
References: <20191024224631.118656-1-davidgow@google.com>
Message-ID: <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
Date:   Tue, 29 Oct 2019 07:00:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024224631.118656-1-davidgow@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On 10/24/19 4:46 PM, David Gow wrote:
> Add a KUnit test for the kernel doubly linked list implementation in
> include/linux/list.h
> 
> Each test case (list_test_x) is focused on testing the behaviour of the
> list function/macro 'x'. None of the tests pass invalid lists to these
> macros, and so should behave identically with DEBUG_LIST enabled and
> disabled.
> 
> Note that, at present, it only tests the list_ types (not the
> singly-linked hlist_), and does not yet test all of the
> list_for_each_entry* macros (and some related things like
> list_prepare_entry).
> 
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> 
> This revision addresses Brendan's comments in
> https://lore.kernel.org/linux-kselftest/20191023220248.GA55483@google.com/
> 
> Specifically:
> - Brendan's Reviewed-by/Tested-by being included in the description.
> - A couple of trailing tabs in Kconfig.debug & list-test.c
> - Reformatting of previously >80 character lines.
> 
> 
> Earlier versions of this patchset can be found:
> 
> v5:
> https://lore.kernel.org/linux-kselftest/20191022221322.122788-1-davidgow@google.com/
> v4:
> https://lore.kernel.org/linux-kselftest/20191018215549.65000-1-davidgow@google.com/
> v3:
> https://lore.kernel.org/linux-kselftest/20191016215707.95317-1-davidgow@google.com/
> v2:
> https://lore.kernel.org/linux-kselftest/20191010185631.26541-1-davidgow@google.com/
> v1:
> https://lore.kernel.org/linux-kselftest/20191007213633.92565-1-davidgow@google.com/
> 

CHECK: Unnecessary parentheses around test_struct.list
#699: FILE: lib/list-test.c:510:
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct, list_entry(&(test_struct.list),

CHECK: Alignment should match open parenthesis
#700: FILE: lib/list-test.c:511:
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct, list_entry(&(test_struct.list),
+				struct list_test_struct, list));

CHECK: Please don't use multiple blank lines
#711: FILE: lib/list-test.c:522:
+
+

CHECK: Alignment should match open parenthesis
#713: FILE: lib/list-test.c:524:
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_first_entry(&list,
+				struct list_test_struct, list));

CHECK: Please don't use multiple blank lines
#724: FILE: lib/list-test.c:535:
+
+

CHECK: Alignment should match open parenthesis
#726: FILE: lib/list-test.c:537:
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct2, list_last_entry(&list,
+				struct list_test_struct, list));

CHECK: Alignment should match open parenthesis
#735: FILE: lib/list-test.c:546:
+	KUNIT_EXPECT_FALSE(test, list_first_entry_or_null(&list,
+				struct list_test_struct, list));

CHECK: Alignment should match open parenthesis
#741: FILE: lib/list-test.c:552:
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct1,
+			list_first_entry_or_null(&list,

CHECK: Alignment should match open parenthesis
#742: FILE: lib/list-test.c:553:
+			list_first_entry_or_null(&list,
+				struct list_test_struct, list));

CHECK: Please don't use multiple blank lines
#753: FILE: lib/list-test.c:564:
+
+

CHECK: Alignment should match open parenthesis
#755: FILE: lib/list-test.c:566:
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct2, list_next_entry(&test_struct1,
+				list));

CHECK: Please don't use multiple blank lines
#766: FILE: lib/list-test.c:577:
+
+

CHECK: Alignment should match open parenthesis
#768: FILE: lib/list-test.c:579:
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_prev_entry(&test_struct2,
+				list));

ERROR: that open brace { should be on the previous line
#789: FILE: lib/list-test.c:600:
+static void list_test_list_for_each_prev(struct kunit *test)
+{

ERROR: that open brace { should be on the previous line
#807: FILE: lib/list-test.c:618:
+static void list_test_list_for_each_safe(struct kunit *test)
+{

CHECK: Please don't use multiple blank lines
#813: FILE: lib/list-test.c:624:
+
+

ERROR: that open brace { should be on the previous line
#828: FILE: lib/list-test.c:639:
+static void list_test_list_for_each_prev_safe(struct kunit *test)
+{

ERROR: that open brace { should be on the previous line
#848: FILE: lib/list-test.c:659:
+static void list_test_list_for_each_entry(struct kunit *test)
+{

ERROR: that open brace { should be on the previous line
#869: FILE: lib/list-test.c:680:
+static void list_test_list_for_each_entry_reverse(struct kunit *test)
+{


I am seeing these error and warns. As per our hallway conversation, the
"for_each*" in the test naming is tripping up checkpatch.pl

For now you can change the name a bit to not trip checkpatch and maybe
explore fixing checkpatch to differentiate between function names
with "for_each" in them vs. the actual for_each usages in the code.

thanks,
-- Shuah
