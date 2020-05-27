Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02CC1E50A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 23:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgE0VqO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 17:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgE0VqN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 17:46:13 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 168622075A;
        Wed, 27 May 2020 21:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590615973;
        bh=o/19GIssmexZ2dq1VzI9u5wRihhIkIqyBJzab36Gty4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TPuQfDUJ7N4BGc2epf1p/AgWw208vbe+698oJ0WKbimrTDS5uM7qcc7AZYktiMlF3
         6OsEB56g8ZaM2gt6R/Yq3w7YCKfvCNDm9vr52gZPYIqBVHh2OUglvFz39CAhzQxcT+
         zi0dhy/+jyLwqldZOdc5JghdB69QqwmivEHS8ioU=
Subject: Re: kselftest OOT run_tests
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <xunyblmcqfuu.fsf@redhat.com>
 <ad5ee014-759c-d0fb-5dc1-f1f25481a453@kernel.org>
 <xunytv01omwj.fsf@redhat.com>
 <07bb723f-8174-5373-6715-65b61942080c@kernel.org>
 <CANoWswn-onWmBG4KVzqNj3mtmRcUw1Fp5HD9Od05wYqTYYcPcg@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <788d61a2-8471-a6b2-8ab6-d4af386c2884@kernel.org>
Date:   Wed, 27 May 2020 15:46:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CANoWswn-onWmBG4KVzqNj3mtmRcUw1Fp5HD9Od05wYqTYYcPcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/27/20 12:40 PM, Yauheni Kaliuta wrote:
> On Wed, May 27, 2020 at 9:22 PM shuah <shuah@kernel.org> wrote:
>>
>> On 5/27/20 1:30 AM, Yauheni Kaliuta wrote:
>>> Hi, shuah!
>>>
>>>>>>>> On Tue, 26 May 2020 11:13:29 -0600, shuah   wrote:
>>>
>>>    > On 5/25/20 7:55 AM, Yauheni Kaliuta wrote:
>>>    >> Hi!
>>>    >>
>>>    >> I'm wondering how out of tree check is supposed to work for make
>>>    >> O=dir run_tests from selftests (or make -C ...) directory?
>>>    >>
>>>    >> (both with 051f278e9d81 ("kbuild: replace KBUILD_SRCTREE with
>>>    >> boolean building_out_of_srctree") and without)
>>>    >>
>>>    >> make M= ... does not work with run_tests.
>>>    >>
>>>
>>>    > Kselftests run_tests target isn't intended for building and
>>>    > running tests OOT.
>>>
>>> But there is code there trying to handle it. All that OUTPUT
>>> related things must be removed if it's broken, right? Can I post
>>> a patch?
>>>
>>>    > Also make M= doesn't make sense for them.
>>>
>>> Well, M=... at least includes all the makefiles.
>>>
>>>    > There is no support to build OOT at the moment. I would like
>>>    > to get a better understanding of your use-case. Can you
>>>    > elaborate?
>>>
>>> I care about make install actually. But fixing it I had to deal
>>> with OUTPUT. Looking a proper for that I found that it's a bit
>>> broken.
>>>
>>>
>>
>> kselftest supports install of all all tests and a sub-set of tests
>> both native and cross-builds.
>>
>> Simple case:
>> If you want to build all tests and install to $HOME/install/
>> This has a dependency on kernel being built in the source repo
>> you are running the following install command from:
>>
>> In Kernel source root dir run:
>> make kselftest-install O=$HOME/install
>>
>> You will find installed tests with run script to run them all
>> under $HOME/install/kselftest/kselftest_install/
>>
>> If you run run_kselftest.sh under kselftest_install, it will run
>> all the tests.
>>
>> You can use TARGETS var to build a sub-set of tests.
>>
>> In Kernel source root dir run:
>> make kselftest-install TARGETS=bpf O=$HOME/install
>>
> 
> Have you tried it with the recent bpf tree? ;)
>  > (BTW, it is a bit misleading, it's building there, not installing).
> 

It doesn't build for me on Linux 5.7-rc7 - install is another story

bpf install through kselftest-install hasn't been working for a
while.

bpf test has dependency bpftool and its Makefile is more complex
as a result.


thanks,
-- Shuah






