Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA79E73424
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2019 18:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbfGXQpS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jul 2019 12:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387555AbfGXQpS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jul 2019 12:45:18 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 956ED2189F;
        Wed, 24 Jul 2019 16:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563986716;
        bh=k5s66pEgEBv+nR9tMAZXt6QiRx8uZOUa/8yBMLysUjw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n3Yky+YTRGgs66Y/xnADc+NfLsjRajh3fGCCqD2l2hlcUqLBKcTEgDYori4bPBGbK
         YMr67AaPU7n3f+y/DR9kDv9iKCSACSw0/NbgWgXT696BFsZsohYsvHdamp5dRH40wr
         uuwMBFW1Oep3t9+PDs341olSQti/DkfCa4X/G/Iw=
Subject: Re: [PATCH v3] selftests/livepatch: add test skip handling
To:     Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>, shuah <shuah@kernel.org>
References: <20190722140544.29867-1-joe.lawrence@redhat.com>
 <20190724062730.xtutfqgpsr3pubv7@pathway.suse.cz>
From:   shuah <shuah@kernel.org>
Message-ID: <0aae34cf-ae82-1f80-7bc9-27708c61287a@kernel.org>
Date:   Wed, 24 Jul 2019 10:45:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724062730.xtutfqgpsr3pubv7@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/24/19 12:27 AM, Petr Mladek wrote:
> On Mon 2019-07-22 10:05:44, Joe Lawrence wrote:
>> Add a skip() message function that stops the test, logs an explanation,
>> and sets the "skip" return code (4).
>>
>> Before loading a livepatch self-test kernel module, first verify that
>> we've built and installed it by running a 'modprobe --dry-run'.  This
>> should catch a few environment issues, including !CONFIG_LIVEPATCH and
>> !CONFIG_TEST_LIVEPATCH.  In these cases, exit gracefully with the new
>> skip() function.
>>
>> Reported-by: Jiri Benc <jbenc@redhat.com>
>> Suggested-by: Shuah Khan <shuah@kernel.org>
>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr
> 
> PS: No need to send v4. The missing "to", suggested by Shuah, could
>      get added when pushing the patch into the repo.
> 

I can't make changes to the patch. I can adjust the commit log at times
and correct merge conflicts.

I would like to see v4 for this.

thanks,
-- Shuah
