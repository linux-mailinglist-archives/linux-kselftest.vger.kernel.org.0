Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F81A3BD1
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfH3QU0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 12:20:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfH3QU0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 12:20:26 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 063132341B;
        Fri, 30 Aug 2019 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567182025;
        bh=7MOipqKt2Wmhp8etEhAUF9iImbxmzYm8rI9O4cKGm/c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GOjHZLU8Epe54Oc+cpo+LHgMFF42/oSRz1S3EhcKAnb5S8ffa8d0DWdVVIdCHQv46
         iusD8tsuBtfNUpvwo6sHzgX+noKayeaZY9sIyXqhaVkIsL5gfvhRjb6nW7EvQQ/fDS
         XJgPwxCKgfKqJHniuvLRgw/9hDmZyMRQ1gMNljVY=
Subject: Re: [PATCH v2] selftests: watchdog: Add optional file argument
To:     "George G. Davis" <george_davis@mentor.com>
Cc:     Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>, shuah <shuah@kernel.org>
References: <1567169597-10330-1-git-send-email-george_davis@mentor.com>
 <197ee603-6ea7-a3c8-6b62-e3ba95433053@kernel.org>
 <20190830161320.GD23419@mam-gdavis-lt>
From:   shuah <shuah@kernel.org>
Message-ID: <ff4527a1-3b94-9b4a-b785-507eb861379c@kernel.org>
Date:   Fri, 30 Aug 2019 10:20:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830161320.GD23419@mam-gdavis-lt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/30/19 10:13 AM, George G. Davis wrote:
> On Fri, Aug 30, 2019 at 09:12:10AM -0600, shuah wrote:
>> On 8/30/19 6:53 AM, George G. Davis wrote:
>>> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
>>> @@ -69,6 +70,7 @@ static void term(int sig)
>>>   static void usage(char *progname)
>>>   {
>>>   	printf("Usage: %s [options]\n", progname);
>>> +	printf(" -f, --file          Open watchdog device file (default is /dev/watchdog)\n");
>>
>> Can you split this line into two printf's. Checkpatch doesn't like
>> it.
>>
>> printf(" -f, --file          Open watchdog device file\n");
>> A second one below for default.
> 
> Sure, I'll add the following interdiff in v3:
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index 9f17cae61007..6a68b486dd61 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -70,7 +70,8 @@ static void term(int sig)
>   static void usage(char *progname)
>   {
>   	printf("Usage: %s [options]\n", progname);
> -	printf(" -f, --file          Open watchdog device file (default is /dev/watchdog)\n");
> +	printf(" -f, --file          Open watchdog device file\n");
> +	printf("                     Default is /dev/watchdog\n");

Thanks. This is what I am looking for. Please send v3 with thsi change.

>   	printf(" -b, --bootstatus    Get last boot status (Watchdog/POR)\n");
>   	printf(" -d, --disable       Turn off the watchdog timer\n");
>   	printf(" -e, --enable        Turn on the watchdog timer\n");
> 
>> On a separate note, I wish this usage block uses \t instead of spacing
>> things out.
> 
> I noticed that most of those lines are hard spaced with only one using tabs.
> To remain consistent with existing CodingStyle, I used hard spaces.
> 

yes. My comment about using "\t" can be done later and if you would like
to send for that patch, I will be happy to take it.

thanks,
-- Shuah
