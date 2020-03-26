Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90EC3194896
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 21:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgCZURC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 16:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgCZURC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 16:17:02 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B1352070A;
        Thu, 26 Mar 2020 20:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585253821;
        bh=gjdhbmH2QaYiDn8/j5vQaISgUmsqEDdrXvfY7uAJWc0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=koGo9Lz4CXJCY0y8wLdk3XvEDjTOqDEL/26t2CTEstAlsZ1Z8NcURi5OfmCZgHywV
         x2InR0PnUjGa9o0YCvV96D6FKOV7949BfhPlohR6b9BWmr9Ciaapq0pEHmL9T0uX7k
         4gLPGSVqPknjBfJvxFt9rcKnSCVrUgLllYaNVKik=
Subject: Re: [PATCH v2] kunit: tool: add missing test data file content
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Heidi Fahim <heidifahim@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20200323192236.70152-1-brendanhiggins@google.com>
 <CABVgOSkf58zMRhpqoZY3cZuAfujnTwVe14xOMcS6VBC4S2+vEw@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <75c33274-68e6-6ad4-c4a8-0dc9b14a9af6@kernel.org>
Date:   Thu, 26 Mar 2020 14:17:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CABVgOSkf58zMRhpqoZY3cZuAfujnTwVe14xOMcS6VBC4S2+vEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/23/20 8:56 PM, David Gow wrote:
> On Mon, Mar 23, 2020 at 12:22 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
>>
>> Add a missing raw dmesg test log to test the kunit_tool's dmesg parser.
>> test_prefix_poundsign and test_output_with_prefix_isolated_correctly
>> fail without this test log.
>>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> 
> Tested-by: David Gow <davidgow@google.com>
> 
> This patch does indeed fix the kunit_tool's unit tests (run with
> ./tools/testing/kunit/kunit_tool_test.py).
> 
> Beforehand, it failed with the errors below:
> ======================================================================
> ERROR: test_prefix_poundsign (__main__.KUnitParserTest)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "./tools/testing/kunit/kunit_tool_test.py", line 208, in
> test_prefix_poundsign
>     self.assertEqual('kunit-resource-test', result.suites[0].name)
> IndexError: list index out of range
> 
> ======================================================================
> FAIL: test_output_with_prefix_isolated_correctly
> (__main__.KUnitParserTest)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "./tools/testing/kunit/kunit_tool_test.py", line 116, in
> test_output_with_prefix_isolated_correctly
>     self.assertContains('TAP version 14\n', result)
>   File "./tools/testing/kunit/kunit_tool_test.py", line 96, in
> assertContains
>     str(needle) + '" not found in "' + str(haystack) + '"!')
> AssertionError: "TAP version 14
> " not found in "<generator object isolate_kunit_output at 0x7f4e88d85ed0>"!
> 
> ----------------------------------------------------------------------
> Ran 20 tests in 0.022s
> 
> FAILED (failures=1, errors=1)
> 

Applied to linux-kselftest kunit for Linux 5.7-rc1.

thanks,
-- Shuah
