Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446A9C929C
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2019 21:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfJBTtA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Oct 2019 15:49:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbfJBTtA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Oct 2019 15:49:00 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7270A2133F;
        Wed,  2 Oct 2019 19:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570045739;
        bh=7PVCAuEsgrCe442h9KQ9kdWMLRPwweKypkL7yGEgWA4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vtizw4ru0jGMqtXcWX97sP+JdmuHPnyTNdkd6Mv1daHMDVSbeZQWIfPrw16SIZG0F
         pU3P4Fad0j/wJNHxFMfuUnlycfCUr12VcliY6XiBYSKWhyrnXZSc0tisAwo5C/G4NS
         X3MXCPgFhZkNnKvOrv1kPveLyGvVqpWW24l06Pqw=
Subject: Re: [PATCH v3 1/2] selftests: watchdog: Validate optional file
 argument
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     "George G. Davis" <george_davis@mentor.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        shuah <shuah@kernel.org>
References: <20190917184023.16701-1-erosca@de.adit-jv.com>
 <156996250317.31379.1299334144215961607.git-patchwork-notify@kernel.org>
 <20191002104101.GA6855@vmlxhi-102.adit-jv.com>
From:   shuah <shuah@kernel.org>
Message-ID: <2f1d360f-ee56-8d68-c66a-53604baf8907@kernel.org>
Date:   Wed, 2 Oct 2019 13:48:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002104101.GA6855@vmlxhi-102.adit-jv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/2/19 4:41 AM, Eugeniu Rosca wrote:
> Hi Shuah,
> 
> On Tue, Oct 01, 2019 at 08:41:43PM +0000, patchwork-bot+linux-kselftest@kernel.org wrote:
>> Hello:
>>
>> This series was applied to shuah/linux-kselftest.git (refs/heads/fixes).
>>
>> On Tue, 17 Sep 2019 20:40:22 +0200 you wrote:
>>> From: "George G. Davis" <george_davis@mentor.com>
>>>
>>> The newly added optional file argument does not validate if the
>>> file is indeed a watchdog, e.g.:
>>>
>>> ./watchdog-test  -f /dev/zero
>>> Watchdog Ticking Away!
>>>
>>> [...]
>>
>> Here is a summary with links:
>>    - [v3,1/2] selftests: watchdog: Validate optional file argument
>>      https://git.kernel.org/shuah/linux-kselftest/c/93c384f5d553bc4fdfb252b89ff378363ee05cee
> 
> Could you please update the 'Fixes:' tag in the above commit to:
> Fixes: a4864a33f56caa ("selftests: watchdog: Add optional file argument")
> 
> The warning in https://patchwork.kernel.org/patch/11149287/ clearly says
> that the fixed commit is from linux-next and it seems to have been
> updated before landing in mainline. TIA.
> 

Thanks. My scripts didn't catch it for some reason. Fixed now.

-- Shuah
