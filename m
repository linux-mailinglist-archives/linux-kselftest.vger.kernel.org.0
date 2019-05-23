Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D821B28D86
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 00:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbfEWW5Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 18:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388006AbfEWW5Q (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 18:57:16 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F98B20863;
        Thu, 23 May 2019 22:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558652235;
        bh=WFHx5fEpakFET6xE99iCq+IHCGjIpUrxMJE09DB+6tw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D5+ZXtMX69SZtQ3RHb+/n6c/6ZB4HUNdQkYRnT3WAiMa7EvJPUBS0FhOlVVt8c5BR
         7pagjqt/Wax8FLqNuDeZCAVm0WRD9qiWIOdJS7T9KL/NHDxXuLO/EjScQJhHIpOs94
         ntEyQsgYt8yC34FPc2D5jvWNznH74wHuAHD49pd4=
Subject: Re: [PATCH 0/2] kselftest: fix rtctest timeout
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190523224223.11054-1-alexandre.belloni@bootlin.com>
From:   shuah <shuah@kernel.org>
Message-ID: <9c94c2b7-153d-ef75-c474-9bae49d6a039@kernel.org>
Date:   Thu, 23 May 2019 16:57:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523224223.11054-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/23/19 4:42 PM, Alexandre Belloni wrote:
> Hi,
> 
> Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per
> test") wrongly assumed that no individual test would run for more than
> 30 seconds and this silently broke rtctest.
> 
> Please consider the following patches as fixes for v5.2 to avoid having
> any non working release.
> 
> Thanks,
> 
> Alexandre Belloni (2):
>    selftests/harness: Allow test to configure timeout
>    selftests: rtc: rtctest: specify timeouts
> 
>   tools/testing/selftests/kselftest_harness.h | 17 ++++++++++++-----
>   tools/testing/selftests/rtc/rtctest.c       |  6 +++---
>   2 files changed, 15 insertions(+), 8 deletions(-)
> 

Thanks for fixing them quickly.

I will pull these in. I have one more fix from Kees already queued
up.

Jeffrin! Would you like to test these to see if they work for you
and send Tested-by tag.

I don't see 1/2 in my Inbox. I have Kees's reply to it. Odd.

thanks,
-- Shuah
