Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E94EA1BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 17:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfJ3Q1o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Oct 2019 12:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfJ3Q1o (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Oct 2019 12:27:44 -0400
Received: from [172.20.52.151] (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A5E120717;
        Wed, 30 Oct 2019 16:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572452863;
        bh=SNeRKTTlIPVnDUCxC0bSPsIHj4Io4ehDm7wcAEYJjtk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OpBHO7ouoTeY0DhFV/9oJyVVEW4ok/e2kh/S/DlErORuYtBL2PonN7fC+EJQw0IcR
         9PqqMkFDhj+eSzB+LqXckqjXLJh0R4adehDhmwWqf2tt9kkdfNS3EM0oqGSa7PVmbl
         /lfqcDbiawl2Xiu2I+wIKSAxBafBjIltvN6+DPAI=
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for the
 'list' doubly linked list
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20191024224631.118656-1-davidgow@google.com>
 <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
 <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
 <20191030104217.GA18421@kadam>
From:   shuah <shuah@kernel.org>
Message-ID: <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
Date:   Wed, 30 Oct 2019 10:27:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030104217.GA18421@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/30/19 4:42 AM, Dan Carpenter wrote:
> On Wed, Oct 30, 2019 at 01:02:11AM -0700, David Gow wrote:
>>> ERROR: that open brace { should be on the previous line
>>> #869: FILE: lib/list-test.c:680:
>>> +static void list_test_list_for_each_entry_reverse(struct kunit *test)
>>> +{
>>>
>>>
>>> I am seeing these error and warns. As per our hallway conversation, the
>>> "for_each*" in the test naming is tripping up checkpatch.pl
>>>
>>> For now you can change the name a bit to not trip checkpatch and maybe
>>> explore fixing checkpatch to differentiate between function names
>>> with "for_each" in them vs. the actual for_each usages in the code.
>>
>> Thanks, Shuah.
>>
>> Yes, the problem here is that checkpatch.pl believes that anything
>> with "for_each" in its name must be a loop, so expects that the open
>> brace is placed on the same line as for a for loop.
>>
>> Longer term, I think it'd be nicer, naming-wise, to fix or work around
>> this issue in checkpatch.pl itself, as that'd allow the tests to
>> continue to follow a naming pattern of "list_test_[x]", where [x] is
>> the name of the function/macro being tested. Of course, short of
>> trying to fit a whole C parser in checkpatch.pl, that's going to
>> involve some compromises as well.
> 
> Just make it a black list of the 5 most common for_each macros.
> 

How does black listing work in the context of checkpatch.pl?

>>
>> In the meantime, I'm sending out v7 which replaces "for_each" with
>> "for__each" (adding the extra underscore), so that checkpatch is
>> happy.

This change is required just to quiet checkpatch and I am not happy
about asking for this change. At the same time, I am concerned about
git hooks failing on this patch.

> 
> It's better to ignore checkpatch and other scripts when they are wrong.
> (unless the warning message inspires you to make the code more readable
> for humans).
> 

It gets confusing when to ignore and when not to. It takes work to
figure out and it is subjective.

It would be great if we can consistently rely on a tool that is used as
a criteria for patches to accept patches.

thanks,
-- Shuah


