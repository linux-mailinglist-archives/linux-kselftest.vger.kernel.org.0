Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165E6B3E60
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 18:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfIPQFU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 12:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389548AbfIPQFU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 12:05:20 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 040FC214D9;
        Mon, 16 Sep 2019 16:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568649919;
        bh=fEWf6Yzx9bizlJw8TJg/G1co/XhDPP7/G3s2N+J+Eps=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nn+qVDe8BW7YR4sRgIQEs+0oqSOOux8aZ5sWRevmi2UfYd+SCNTPntVuhNoGDzO6d
         QSucDw54e4xgD8bYniqrQWeJRTTdXzkQ22CSI+wQORbiPB4aj/+V/+54qH7CvNqE9L
         xVT8eR5JGWLaaaMGxhTzypMfib4TfE7jhOKbe4Ec=
Subject: Re: [PATCH 2/2] selftests: watchdog: Add command line option to show
 watchdog_info
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190907085833.21167-1-erosca@de.adit-jv.com>
 <20190907085833.21167-2-erosca@de.adit-jv.com>
 <2b08fa83-185b-4eb7-1217-37ed31d810b5@kernel.org>
 <20190916135756.GA24319@vmlxhi-102.adit-jv.com>
From:   shuah <shuah@kernel.org>
Message-ID: <24cc0dde-6df3-3ea2-3e1d-0bc166bb48ac@kernel.org>
Date:   Mon, 16 Sep 2019 10:05:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916135756.GA24319@vmlxhi-102.adit-jv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/16/19 7:57 AM, Eugeniu Rosca wrote:
> Hi Shuah,
> CC George
> 
> On Mon, Sep 16, 2019 at 07:26:41AM -0600, shuah wrote:
> [..]
>>>    		case 'f':
>>>    			/* Handled above */
>>>    			break;
>>> +		case 'i':
>>> +			/*
>>> +			 * watchdog_info was obtained as part of file open
>>> +			 * validation. So we just show it here.
>>> +			 */
>>> +			oneshot = 1;
>>> +			printf("watchdog_info:\n");
>>> +			printf(" identity:\t\t%s\n", info.identity);
>>> +			printf(" firmware_version:\t%u\n",
>>> +			       info.firmware_version);
>>> +			printf(" options:\t\t%08x\n", info.options);
>>> +			break;
>>>    		default:
>>>    			usage(argv[0]);
>>>
>>
>> I would like to see these combined. Please don't add another argument.
>> Combine patch and 1&2.
> 
> With all my appreciation for your comment, why do you think it is better
> to get rid of the new argument? I don't think it is user-friendly to
> always report the watchdog_info to the user. Just look at outputs [1-2]
> and imagine that the watchdog_info part would pop up unconditionally.
> It looks too busy to me.

Yes it does look busy. I am okay with adding a second options
based on what you both said.

I don't like the commit log.

Unfortunately this thread no longer contains the commit log.

I would like to see the commit log without any references to side
effects. It make it rather confusing.

"A side of affect of commit "selftests: watchdog: Add optional file
argument" is that arbitrary files may be opened for watchdog testing, e.g.
/dev/null. To prevent watchdog-test from operating on non-watchdog device
files, commit "selftests: watchdog: Validate optional file argument" was
added to validate that a file is indeed a watchdog device via an
ioctl(WDIOC_GETSUPPORT) call. Since the watchdog_info is available as a
result of the ioctl(WDIOC_GETSUPPORT) call, add a command line option to
show the watchdog_info."

I would drop all references to that.

thanks,
-- Shuah
