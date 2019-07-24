Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10BF873D48
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2019 22:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391705AbfGXTvx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jul 2019 15:51:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391704AbfGXTvv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jul 2019 15:51:51 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C14C20665;
        Wed, 24 Jul 2019 19:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997910;
        bh=ISWxT6p+NddUmAArY9ckryLACtHpGP32ni4oaiZj1Zs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ojiWp6Y6aR+YD/j82Hm8//Or0CGYug54qQkfGFpOdF9O2r/rYTFIgTR2t9NwAl9C9
         dUwqO4wgx5ZlU0kBvQdEYtxa5CBsgn9SeNji3Axj5ZBXkxcYv+aiXOu/cErbJCdxNB
         O02onCOoSY46pR7EvkYH/gRrVhPuSqkzCt8m3i4g=
Subject: Re: [PATCH v3] selftests/livepatch: add test skip handling
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>, shuah <shuah@kernel.org>
References: <20190722140544.29867-1-joe.lawrence@redhat.com>
 <20190724062730.xtutfqgpsr3pubv7@pathway.suse.cz>
 <0aae34cf-ae82-1f80-7bc9-27708c61287a@kernel.org>
 <643f0d9f-ada1-da3d-7980-4f2df6a6e63f@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <f2009a18-3521-1bf3-657e-d898a34dd973@kernel.org>
Date:   Wed, 24 Jul 2019 13:51:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <643f0d9f-ada1-da3d-7980-4f2df6a6e63f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/24/19 12:45 PM, Joe Lawrence wrote:
> On 07/24/2019 12:45 PM, shuah wrote:
>> On 7/24/19 12:27 AM, Petr Mladek wrote:
>>> On Mon 2019-07-22 10:05:44, Joe Lawrence wrote:
>>>> Add a skip() message function that stops the test, logs an explanation,
>>>> and sets the "skip" return code (4).
>>>>
>>>> Before loading a livepatch self-test kernel module, first verify that
>>>> we've built and installed it by running a 'modprobe --dry-run'.  This
>>>> should catch a few environment issues, including !CONFIG_LIVEPATCH and
>>>> !CONFIG_TEST_LIVEPATCH.  In these cases, exit gracefully with the new
>>>> skip() function.
>>>>
>>>> Reported-by: Jiri Benc <jbenc@redhat.com>
>>>> Suggested-by: Shuah Khan <shuah@kernel.org>
>>>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>>>
>>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>>>
>>> Best Regards,
>>> Petr
>>>
>>> PS: No need to send v4. The missing "to", suggested by Shuah, could
>>>      get added when pushing the patch into the repo.
>>>
>>
>> I can't make changes to the patch. I can adjust the commit log at times
>> and correct merge conflicts.
>>
>> I would like to see v4 for this.
>>
> 
> We should clarify for which tree this and "[PATCH] selftests/livepatch: 
> push and pop dynamic debug config​" would be merged.  I had assumed this 
> would go to the livepatching tree, but Shuah, do you prefer that 
> selftest-centric patches go through the selftests tree?
> 
> I'm okay with either and can send up a v4 if needed.  But also this 
> would be good to know for future changesets like this, we can perhaps 
> mark the destination branch in advance.
> 

I prefer to take these through kselftest tree unless there is a
dependency on other trees. It is the case for some feature
dependent tests that might have dependency on the feature.

This doesn't appear to have any dependency.

thanks,
-- Shuah

