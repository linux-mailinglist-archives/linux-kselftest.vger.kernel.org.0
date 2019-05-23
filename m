Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBB228DD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 01:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbfEWXci (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 19:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387693AbfEWXch (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 19:32:37 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5A752133D;
        Thu, 23 May 2019 23:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558654356;
        bh=+JimfnIpUnSEIOM6CLyzapNUCy/6hiOiN5D8CMQg81c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kWJqIeGNO5wQh3sWxJ7Dxs6DOEvsb3gqTrFkUFVAGCz6OgmJZ9cxcGo3Yo5wOcpI9
         3T23ckG+CPhAmhwkbXHy+izIxJMSE68O176FBBwUjVowkkSn7hHP2wbUiE7enuZOKj
         YB6rU9mH7lJelPJ4CeSpkypQqR1G9J66YLnO62q8=
Subject: Re: [PATCH 0/2] kselftest: fix rtctest timeout
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190523224223.11054-1-alexandre.belloni@bootlin.com>
 <9c94c2b7-153d-ef75-c474-9bae49d6a039@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <3846d273-7b8e-8bb8-a3d4-04fd382d8324@kernel.org>
Date:   Thu, 23 May 2019 17:32:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9c94c2b7-153d-ef75-c474-9bae49d6a039@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/23/19 4:57 PM, shuah wrote:
> On 5/23/19 4:42 PM, Alexandre Belloni wrote:
>> Hi,
>>
>> Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per
>> test") wrongly assumed that no individual test would run for more than
>> 30 seconds and this silently broke rtctest.
>>
>> Please consider the following patches as fixes for v5.2 to avoid having
>> any non working release.
>>
>> Thanks,
>>
>> Alexandre Belloni (2):
>>    selftests/harness: Allow test to configure timeout
>>    selftests: rtc: rtctest: specify timeouts
>>
>>   tools/testing/selftests/kselftest_harness.h | 17 ++++++++++++-----
>>   tools/testing/selftests/rtc/rtctest.c       |  6 +++---
>>   2 files changed, 15 insertions(+), 8 deletions(-)
>>
> 
> Thanks for fixing them quickly.
> 
> I will pull these in. I have one more fix from Kees already queued
> up.
> 
> Jeffrin! Would you like to test these to see if they work for you
> and send Tested-by tag.
> 
> I don't see 1/2 in my Inbox. I have Kees's reply to it. Odd.
> 

It showed up late. I have 1/2 in my Inbox now. Must have taken a scenic
route. :)

thanks,
-- Shuah

