Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33AE3185034
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 21:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCMUWN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 16:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgCMUWN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 16:22:13 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 851472074D;
        Fri, 13 Mar 2020 20:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584130932;
        bh=H+FHiu5LeQLomYOQnyUDjawefKb1s84kHWofbZe/vO8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A/GfMUp5yVhkxaqCnB4roSCiMSzNGIeviJvl81OxxvITqnF5NB8vv2fYIZ+1/gd73
         qcyTruHofRExTtWou6mfRmzviF+3DXRGuvpcYMdjgB7IYcf8I0LfPcwNkVomB/k8p+
         unwTQAqlziKurwjBO1+seHDied5ozItFZTW8KVJk=
Subject: Re: [PATCH v2 1/2] kunit: kunit_parser: make parser more robust
To:     Brendan Higgins <brendanhiggins@google.com>,
        Heidi Fahim <heidifahim@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        shuah <shuah@kernel.org>
References: <20200305200409.239406-1-heidifahim@google.com>
 <CAFd5g45HSuxcP8_-yaJY4M=Acy14L=FTwY3GT_m-eTVtP6NJhQ@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <b8777872-189b-b361-6ff4-c7cd51772dfd@kernel.org>
Date:   Fri, 13 Mar 2020 14:22:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g45HSuxcP8_-yaJY4M=Acy14L=FTwY3GT_m-eTVtP6NJhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/5/20 2:25 PM, Brendan Higgins wrote:
> On Thu, Mar 5, 2020 at 12:04 PM Heidi Fahim <heidifahim@google.com> wrote:
>>
>> Previously, kunit_parser did not properly handle kunit TAP output that
>> - had any prefixes (generated from different configs e.g.
>> CONFIG_PRINTK_TIME)
>> - had unrelated kernel output mixed in the middle of
>> it, which has shown up when testing with allyesconfig
>> To remove prefixes, the parser looks for the first line that includes
>> TAP output, "TAP version 14".  It then determines the length of the
>> string before this sequence, and strips that number of characters off
>> the beginning of the following lines until the last KUnit output line is
>> reached.
>> These fixes have been tested with additional tests in the
>> KUnitParseTest and their associated logs have also been added.
>>
>> Signed-off-by: Heidi Fahim <heidifahim@google.com>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 

Heidi and Brendan,

git apply is throwing away formatting in

tools/testing/kunit/test_data/test_config_printk_time.log


Applying: kunit: kunit_parser: make parser more robust
.git/rebase-apply/patch:396: space before tab in indent.
  	# Subtest: kunit-resource-test
.git/rebase-apply/patch:397: space before tab in indent.
  	1..5
.git/rebase-apply/patch:398: space before tab in indent.
  	ok 1 - kunit_resource_test_init_resources
.git/rebase-apply/patch:399: space before tab in indent.
  	ok 2 - kunit_resource_test_alloc_resource
.git/rebase-apply/patch:400: space before tab in indent.
  	ok 3 - kunit_resource_test_destroy_resource
warning: squelched 11 whitespace errors
warning: 16 lines add whitespace errors.

Can you fix this and resend patches. If apply this as is,
all the formatting you have in there goes away.

This is what gets applied.

[    0.060000] TAP version 14
[    0.060000] 	# Subtest: kunit-resource-test
[    0.060000] 	1..5
[    0.060000] 	ok 1 - kunit_resource_test_init_resources
[    0.060000] 	ok 2 - kunit_resource_test_alloc_resource
[    0.060000] 	ok 3 - kunit_resource_test_destroy_resource
[    0.060000] 	ok 4 - kunit_resource_test_cleanup_resources
[    0.060000] 	ok 5 - kunit_resource_test_proper_free_ordering
[    0.060000] ok 1 - kunit-resource-test
[    0.060000] 	# Subtest: kunit-try-catch-test
[    0.060000] 	1..2
[    0.060000] 	ok 1 - kunit_test_try_catch_successful_try_no_catch
[    0.060000] 	ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch
[    0.060000] ok 2 - kunit-try-catch-test
[    0.060000] 	# Subtest: string-stream-test
[    0.060000] 	1..3
[    0.060000] 	ok 1 - string_stream_test_empty_on_creation
[    0.060000] 	ok 2 - string_stream_test_not_empty_after_add
[    0.060000] 	ok 3 - string_stream_test_get_string
[    0.060000] ok 3 - string-stream-test
[    0.060000] List of all partitions:
[    0.060000] No filesystem could mount root, tried:

thanks,
-- Shuah
