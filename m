Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F393EEC711
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2019 17:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfKAQuN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Nov 2019 12:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfKAQuN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Nov 2019 12:50:13 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15D052080F;
        Fri,  1 Nov 2019 16:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572627012;
        bh=BUpvPIgCiek5J4CeLj4ca43Fs+r3iHsHbPYrxAmt2wE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=psFXQRDbxkTKxYUj7eTf2Omjo3astwoXfflW1bYkNIZmTuZD+EtesRws9UOkeYe91
         IFZOcdy87wphXGkpuiDJs8rspxU3g4InAIWj8GjQJ6G/4herpdB9aV2dqStRjNlC9x
         ow6EgmD3OczIPTgaA4qoa5ZVWNCdPZpOmHt5oMAI=
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for the
 'list' doubly linked list
To:     Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20191024224631.118656-1-davidgow@google.com>
 <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
 <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
 <20191030104217.GA18421@kadam>
 <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
 <20191030191255.GD18421@kadam>
 <f665ec7b21527c7095a61dd5c2f48fd00df0d5c9.camel@perches.com>
From:   shuah <shuah@kernel.org>
Message-ID: <a127aeaa-e5ba-2d8d-0894-936e05637508@kernel.org>
Date:   Fri, 1 Nov 2019 10:49:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f665ec7b21527c7095a61dd5c2f48fd00df0d5c9.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/30/19 1:23 PM, Joe Perches wrote:
> On Wed, 2019-10-30 at 22:12 +0300, Dan Carpenter wrote:
>> On Wed, Oct 30, 2019 at 10:27:12AM -0600, shuah wrote:
>>>> It's better to ignore checkpatch and other scripts when they are wrong.
>>>> (unless the warning message inspires you to make the code more readable
>>>> for humans).
>>>>
>>>
>>> It gets confusing when to ignore and when not to. It takes work to
>>> figure out and it is subjective.
>>>
>>
>> In this case, it's not subjective because checkpatch is clearly not
>> working as intended.
> 
> checkpatch _is_ working as intended.
> It was never intended to be perfect.
> 
> checkpatch _always_ depended on a reviewer deciding
> whether its output was appropriate.
> 
>> I don't feel like "checkpatch clean" is a useful criteria for applying
>> patches.
> 
> Nor do I.
> 
>> The other things about warnings is that I always encourage people to
>> just ignore old warnings.  If you're running Smatch and you see a
>> warning in ancient code that means I saw it five years ago and didn't
>> fix it so it's a false positive.  Old warnings are always 100% false
>> positives.
> 
> That'd be not absolute either because it depended on your
> historical judgment as to whether an old warning was in fact
> a defect or not.
> 
> People make mistakes.
> Regex based scripts are by design stupid and untrustworthy.
> 
> Mistakes will be made.
> Just fix the actual defects in code as soon as possible.
> 
> 
> 


Thanks all for chiming in. I am taking v6 as is and adding an update
to commit log capture the spurious errors from checkpath.pl for this
specific case.

thanks,
-- Shuah
