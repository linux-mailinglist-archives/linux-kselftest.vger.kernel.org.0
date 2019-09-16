Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B884B3B64
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 15:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbfIPN3t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 09:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387436AbfIPN3t (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 09:29:49 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 040B7216C8;
        Mon, 16 Sep 2019 13:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568640588;
        bh=E65PZqenNtF0gwkez503dpgyYEbXy6y2IHG2wRELbqk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P/RYsjgWM7yMJG8sh0pPTj1nWZ0qkyd6pPQrm7E98aPcp+zyeFFdkXVeXdix1URGw
         rj6Wf39bV26ZrEu6vSiok3JE1slVZFXLgTKO0i63TVvsHiIyipRJtwIR2Xien5Vy1q
         LEqZR++Kh+BK6tbBD1tcOjaYGVJRdHuJ60bZbd8I=
Subject: Re: [PATCH 1/2] selftests: watchdog: Validate optional file argument
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        shuah <shuah@kernel.org>
References: <20190907085833.21167-1-erosca@de.adit-jv.com>
 <20190916120816.GA30453@vmlxhi-102.adit-jv.com>
From:   shuah <shuah@kernel.org>
Message-ID: <f07c0dac-4d01-f661-25ea-9d077e96e9e7@kernel.org>
Date:   Mon, 16 Sep 2019 07:29:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916120816.GA30453@vmlxhi-102.adit-jv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/16/19 6:08 AM, Eugeniu Rosca wrote:
> Hi Shuah,
> 
> On Sat, Sep 07, 2019 at 10:58:32AM +0200, Eugeniu Rosca wrote:
>> From: "George G. Davis" <george_davis@mentor.com>
>>
>> As reported by Eugeniu Rosca, the newly added optional file
>> argument does not validate if the file is indeed a watchdog, e.g.:
>>
>> ./watchdog-test  -f /dev/zero
>> Watchdog Ticking Away!
>>
>> Fix it by confirming that the WDIOC_GETSUPPORT ioctl succeeds.
>>
>> Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
>> Signed-off-by: George G. Davis <george_davis@mentor.com>
>> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
>> ---
>> v1: Applied/tested on commit ce54eab71e210f ("kunit: fix failure to build without printk") of
>>      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next
> 
> Any concerns about the two patches?
I responded to the patches as well.

> Can you please confirm they are in your queue?
> 

I just sent response. Please collapse the two patches. They will go in
for 5.4-rc1 second update.

thanks,
-- Shuah
