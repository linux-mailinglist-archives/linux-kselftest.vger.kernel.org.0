Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C304CEF5B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 01:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfJGXGS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 19:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbfJGXGS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 19:06:18 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28D8220835;
        Mon,  7 Oct 2019 23:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570489577;
        bh=7bMEka5pHwJt2nAcv9S9/A9NpGqy+zgg2XVYjqPnToM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=E5PEHebLlzo5gMfozaes03gIrd+tcH0T/VEQizR+m75/dUxJ7DEJDcV6TVgoXGMh+
         rKANVAxj0225BLpuDcA6PgH1lb/1w78R9389UMgefFnFQ92U+PbL/SZTbOpZa5RY12
         RoWWp4JJqe0TWyGfpqDxfqmR4rv1+1yTYdRe6yCY=
Subject: Re: [PATCH] Documentation: kunit: Fix verification command
To:     Brendan Higgins <brendanhiggins@google.com>,
        SeongJae Park <sj38.park@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <1567890091-9712-1-git-send-email-sj38.park@gmail.com>
 <CAFd5g46MNYcY-o8Z-1tSi0Kva02CjhcWC-xwkeNc6kfiDzLpLQ@mail.gmail.com>
 <CAFd5g47sUx6ZRxcH4KdKjftv=wo9HmWn+bZukd8gU-YcJv24zQ@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <6e4527d8-613a-9972-ee04-139a54915b67@kernel.org>
Date:   Mon, 7 Oct 2019 17:06:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g47sUx6ZRxcH4KdKjftv=wo9HmWn+bZukd8gU-YcJv24zQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/7/19 4:04 PM, Brendan Higgins wrote:
> On Sun, Sep 8, 2019 at 4:40 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
>>
>> On Sat, Sep 7, 2019 at 2:01 PM SeongJae Park <sj38.park@gmail.com> wrote:
>>>
>>> kunit wrapper script ('kunit.py') receives a sub-command (only 'run' for
>>> now) as its argument.  If no sub-command is given, it prints help
>>> message and just quit.  However, an example command in the kunit
>>> documentation for a verification of kunit is missing the sub-command.
>>> This commit fixes the example.
>>>
>>> Signed-off-by: SeongJae Park <sj38.park@gmail.com>
>>
>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 
> Shuah, can you apply this to the kselftest KUnit branch? This should
> not require a resend.
> 


Done. Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git 
test

thanks,
-- Shuah
