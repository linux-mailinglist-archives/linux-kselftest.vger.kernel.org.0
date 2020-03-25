Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEF0192F22
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 18:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgCYR0A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 13:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbgCYR0A (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 13:26:00 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABBB120772;
        Wed, 25 Mar 2020 17:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585157160;
        bh=D5O2CJoTiuJfdLrYvR2mjTQW0GHmak//e/GmdO9cvQo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ySj+c2th9HWiV2fXJqiJOATW6zw9WCMd3NugaLOGLYB3DuaBDUhjKud/KFVa4jPNv
         phnbnv8dEE3GERDnaMN0g2OFEzjgzfo/z3ovm/0znYDhkWy30seOftD3Hy/YmsmGUi
         2lUiqS7hc0V8DoKmSRBCyed2Qmu6Z72uHwz/RQpE=
Subject: Re: [PATCH kselftest/test] kunit: Always print actual pointer values
 in asserts
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20191121235058.21653-1-davidgow@google.com>
 <CAFd5g46Z_vVb92Y-sfWi68=HFy5+kukZXvT9usEEnhBUvPg3AQ@mail.gmail.com>
 <CABVgOSn1azUN4XujHLsc3NY9fOUPB4Vw6930zc4oR26kxqrwOg@mail.gmail.com>
 <CAFd5g44ZNv-BP_t6M1EWQjXbgBYsA0+oBZ_-nTAmZbE4GNWgpQ@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <2246e35f-b8c4-0152-91f5-5f01d52cd414@kernel.org>
Date:   Wed, 25 Mar 2020 11:25:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g44ZNv-BP_t6M1EWQjXbgBYsA0+oBZ_-nTAmZbE4GNWgpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/25/20 10:33 AM, Brendan Higgins wrote:
> On Tue, Mar 24, 2020 at 8:33 PM David Gow <davidgow@google.com> wrote:
>>
>> On Tue, Dec 3, 2019 at 3:44 PM Brendan Higgins
>> <brendanhiggins@google.com> wrote:
>>>
>>> On Thu, Nov 21, 2019 at 3:51 PM David Gow <davidgow@google.com> wrote:
>>>>
>>>> KUnit assertions and expectations will print the values being tested. If
>>>> these are pointers (e.g., KUNIT_EXPECT_PTR_EQ(test, a, b)), these
>>>> pointers are currently printed with the %pK format specifier, which -- to
>>>> prevent information leaks which may compromise, e.g., ASLR -- are often
>>>> either hashed or replaced with ____ptrval____ or similar, making debugging
>>>> tests difficult.
>>>>
>>>> By replacing %pK with %px as Documentation/core-api/printk-formats.rst
>>>> suggests, we disable this security feature for KUnit assertions and
>>>> expectations, allowing the actual pointer values to be printed. Given
>>>> that KUnit is not intended for use in production kernels, and the
>>>> pointers are only printed on failing tests, this seems like a worthwhile
>>>> tradeoff.
>>>
>>> I agree. However, I also remember that others in the past yelled at me
>>> for assuming that KUnit would not be built into production kernels.
>>>
>>> I feel like +Kees Cook would have a good opinion on this (or will at
>>> least CC the right people).
>>>
>>
>> I'm tempted to take the silence as a sign that no-one is upset by
>> this. Otherwise, consider this a gentle reminder to file any
>> objections you may have. :-)
>>
>> Otherwise, I've confirmed that this still applies cleanly to the
>> latest linux-kselftest/kunit branch, so -- assuming there are no
>> last-minute objections -- this ought to be ready to go.
> 
> Shuah, can you pick this up for 5.7?
> 

Yes. I will pick this up.

thanks,
-- Shuah
