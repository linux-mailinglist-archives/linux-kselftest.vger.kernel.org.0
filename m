Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 141F9114506
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2019 17:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfLEQpE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Dec 2019 11:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfLEQpE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Dec 2019 11:45:04 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6148C22525;
        Thu,  5 Dec 2019 16:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575564303;
        bh=0GzTDoBdLY2bbfEGu+zYgBeHJui7THhwDhp74AzjIUw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GjhHrEVGH25V1XIDqR+ipuATeio+84sWGUfawJejo8Ptb0Wka9bbolWlARdbYCqmh
         8qCzVaDWj/V+STb2sDp6iD1Yejfk+oA8rjOYyDxenRnxXAUXjtJoITPdYgGcacYzPq
         oMoazsq4+7Rqf3M7G7mFUzI99mtkdy7QO1Ep5MzE=
Subject: Re: [BUGFIX PATCH v2 0/3] selftests: safesetid: Fix some bugs in
 safesetid test
To:     Micah Morton <mortonm@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jaswinder.singh@linaro.org, shuah <shuah@kernel.org>
References: <157554844882.11018.13436399905210284553.stgit@devnote2>
 <CAJ-EccNKk30b_wtvz=PUVmMVfF8YNagXMcy3Uhj53DzFbgmb6A@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <3bad79d5-eada-7e96-4210-c4888bfb710f@kernel.org>
Date:   Thu, 5 Dec 2019 09:44:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAJ-EccNKk30b_wtvz=PUVmMVfF8YNagXMcy3Uhj53DzFbgmb6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/5/19 9:40 AM, Micah Morton wrote:
> On Thu, Dec 5, 2019 at 4:20 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>
>> Hi,
>>
>> Here is the v2 series to fix build warnings and erorrs on
>> kselftest safesetid.
>> This version includes a fix for a runtime error.
>>
>> Thank you,
>>
>> ---
>>
>> Masami Hiramatsu (3):
>>        selftests: safesetid: Move link library to LDLIBS
>>        selftests: safesetid: Check the return value of setuid/setgid
>>        selftests: safesetid: Fix Makefile to set correct test program
> 
> These 3 fixes look good, thanks. Were you thinking they would go
> through my SafeSetID tree or is there a dedicated one for selftests? I
> guess if you're not sure someone else on here can chime in, or I can
> just take them through my tree if I don't hear anything.
> 

Yes. There is a linux-kselftest tree dedicated to selftests.
I can take them.


>>
>>
>>   tools/testing/selftests/safesetid/Makefile         |    5 +++--
>>   tools/testing/selftests/safesetid/safesetid-test.c |   15 ++++++++++-----
>>   2 files changed, 13 insertions(+), 7 deletions(-)
>>
>> --

thanks,
-- Shuah

