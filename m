Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9042B6E98
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2019 23:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387733AbfIRVFq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Sep 2019 17:05:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387661AbfIRVFp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Sep 2019 17:05:45 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39FC020665;
        Wed, 18 Sep 2019 21:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568840745;
        bh=8S3vx3u2VKiDDLEVuHlbz2yPV0iiD4FMZukr1aW2DL4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=T1r58jALxX7MEJEJgZT8tNCbextz61Tl9oQnUcup5o7dKpqDPlYnxSnGJJiX66cyg
         mjqMew8q+A2+TihEh8gpz2+XsJ4XnsUwO01TIctrCeOdjem7J3Oo8UHXtw1euInTWW
         i67fLnR4BNzHIOFXv8mxEYcSd76um34/aqcl1qfI=
Subject: Re: [PATCH v3 1/2] selftests: watchdog: Validate optional file
 argument
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190917184023.16701-1-erosca@de.adit-jv.com>
 <20190918113348.GA23977@vmlxhi-102.adit-jv.com>
From:   shuah <shuah@kernel.org>
Message-ID: <41ad241a-1c9d-7e20-3cb1-84bf42ec6989@kernel.org>
Date:   Wed, 18 Sep 2019 15:05:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918113348.GA23977@vmlxhi-102.adit-jv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/18/19 5:33 AM, Eugeniu Rosca wrote:
> Hi Shuah,
> 
> On Tue, Sep 17, 2019 at 08:40:22PM +0200, Eugeniu Rosca wrote:
>> From: "George G. Davis" <george_davis@mentor.com>
>>
>> The newly added optional file argument does not validate if the
>> file is indeed a watchdog, e.g.:
>>
>> ./watchdog-test  -f /dev/zero
>> Watchdog Ticking Away!
>>
>> Fix it by confirming that the WDIOC_GETSUPPORT ioctl succeeds.
>>
>> Fixes: c3f2490d6e9257 ("selftests: watchdog: Add optional file argument")
>> Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
>> Signed-off-by: George G. Davis <george_davis@mentor.com>
>> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
>> ---
>> v3:
>>   - Used v1 as starting point and simplified commit description
>>   - Added Fixes tag (WARNING: commit id is from linux-next!)
>>   - No change in the contents
>>   - Applied cleanly to the same base as used in [v1]
> 
> Can we have your confirmation the patches look fine now?
> 

Hi Eugeniu,

They both look good to me. I will apply these patches once the merge
window closes or when my first pull request to Linus clears.

You will see a notification when I apply them to kselftest tree.

thanks,
-- Shuah
