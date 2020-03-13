Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D61E5184B65
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 16:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCMPp4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 11:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgCMPpz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 11:45:55 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF5E920724;
        Fri, 13 Mar 2020 15:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584114355;
        bh=/N1wgZESVKWP6KVjaSbiwILH85i8xFK95LFFyo4x1rE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D3DD6qqKms7TlPEM19TNtCICsddIc5yjc0fPsOHqZPjCg6WKD+DgYgCS+1XRBAmNN
         HRdVgTJlHagJl727dl3lDQQCGQCu+X/vcpwxqYa4CLMoICBWruIilp8v/zykq3TZOk
         P6HBO+KYOjJVSOegcXgBT3z1N69A4EK2S0T4M3T4=
Subject: Re: [PATCH] kunit/kunit_kernel: Rebuild .config if .kunitconfig is
 modified
To:     Russell Currey <ruscur@russell.cc>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Bjorn Helgaas <bhelgaas@google.com>, shuah <shuah@kernel.org>
References: <CAFd5g448555=dKFQMbjJ6G=tvtfF5oJgTtTgGx+38Ls3VqHo5g@mail.gmail.com>
 <20200205021428.8007-1-sj38.park@gmail.com>
 <CABVgOSmFAZN3KRYkHVg5bb-m-UorB7+9=f9vAqW2ECABzpa9zQ@mail.gmail.com>
 <CAFd5g45eys-JoaW-sgnkjwysehe4oxUL1THNifc7+v1xkgSRww@mail.gmail.com>
 <009fe3f5-7b27-46c4-90a7-ff97cbd8c931@www.fastmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <b13a1268-1542-ec1c-3316-c194597f7849@kernel.org>
Date:   Fri, 13 Mar 2020 09:45:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <009fe3f5-7b27-46c4-90a7-ff97cbd8c931@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/5/20 3:09 PM, Russell Currey wrote:
> On Thu, Feb 6, 2020, at 7:00 AM, Brendan Higgins wrote:
>> On Wed, Feb 5, 2020 at 9:58 AM David Gow <davidgow@google.com> wrote:
>>>
>>> One thing we'd like to do with kunit_tool is to make its functionality
>>> a bit more independent: in particular, allowing the configuration,
>>> running the kernel, and parsing the results to be done independently.
>>>
>>> If that's the case, it may make sense for "kunit.py run" or similar to
>>> not do anything with the .config, and to relegate that to a separate
>>> "configuration" step, which would allow someone to modify the
>>> configuration themselves (e.g., using make menuconfig) and re-run the
>>> tests, but also allow the config to be explicitly regenerated when
>>> helpful.
>>>
>>> Exactly what that'd end up looking like (and to what extent we'd still
>>> want to support a single command that'd do both) are still up in the
>>> air: but I think a general "separation of concerns" like this is
>>> probably the right path forward for kunit_tool.
>>
>> You and I have talked about splitting up kunit_tool's functionality
>> before. I agree with the idea.
>>
>> I imagine it that we would have
>>
>> - configuration
>> - running tests
>> - dmesg/TAP parsing
>>
>> as separate runnable scripts. I think that would make it a lot easier
>> for people with various test bed setups to reuse our code in their
>> test harness.
>>
>> Nevertheless, I think it would also be nice to have, as Ted has
>> previously suggested, a short easy to remember one line command that
>> just works; it is easily said, and much harder to do, but I think it
>> is at odds with the separation of functionality. I guess one solution
>> might just be to have these three separate tools, and then the classic
>> kunit.py script that combines the functionalities in a single step, or
>> as Ted suggested we could have some sort of default "make kunit"
>> command or something like that. I am not really sure what is best
>> here.
>>
>> It doesn't address the problem of separation of functionality in
>> anyway, but one way we could achieve the idea of having a command that
>> just works, is by putting a line in MAINTAINERS file entries that have
>> a command that a maintainer expects a submitter to run before sending
>> a patch to LKML. That might at least make it possible to hack together
>> a single line KUnit command for every relevant MAINTAINERS entry.
>> (Obviously there is no reason we have to do this particular idea just
>> for KUnit. We could do this for other tests as well.) Russel, I think
>> this was your idea at LCA?
> 
> Hi Brendan, it wasn't me, it was someone in the audience during questions in my
> testing talk.  I don't recall who.
> 
> They were suggesting a script like get_maintainers - i.e. get_tests - that for a
> given file/patch/commit it gives you a suggested set of tests, whether that's
> KUnit you can run there and then, or selftests you can run once it's booted,
> or maybe external test suites that are relevant.
> 

I like this idea of get_tests type script that could be run separately
as well as part of check_patch or get_maintainers will serve as a
reminder or hint to patch submitter.

We have some pieces in the MAINTAINERS file now. Selftest files are
usually listed under subsystem entries. get_tests could leverage
that and we will definitely more information to for a complete set
of tests for a subsystem.

thanks,
-- Shuah
