Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D497F1649AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 17:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgBSQQP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 11:16:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgBSQQP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 11:16:15 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5409C20675;
        Wed, 19 Feb 2020 16:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582128974;
        bh=kqHfMWbFpLMNMJlqbLe6btMBQstN4WQELJB604MzXT0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ElXTuU5XaW82WEwNAyQ8fj263Qno9aeS2yUcYR193S1Ca01n90rW2xZvVj5+hWMPt
         WfpvakJgUcb3yL7cEru/nHW/Tky/TBt7YuaXsE7Ysa9MQKByCoM8M6tQGVSUTTDYd8
         4/qY0gd+20uCLv8N8g3IJCd8vCTnHw0WJlYiugp4=
Subject: Re: selftests: Linux Kernel Dump Test Module output
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>, ankita@in.ibm.com,
        Will Deacon <will@kernel.org>, ardb@kernel.org,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        shuah <shuah@kernel.org>
References: <CA+G9fYu3682XJ2Kw2ZvQdUT80epKc9DWWXgDT1-D_65ajSXNTw@mail.gmail.com>
 <fcb799d4-f316-60d6-9fd0-0bc1c174e63c@arm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <31b066c2-d1c9-1592-48cd-bccb4b3a624a@kernel.org>
Date:   Wed, 19 Feb 2020 09:16:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fcb799d4-f316-60d6-9fd0-0bc1c174e63c@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/17/20 8:36 AM, Cristian Marussi wrote:
> Hi
> 
> n 17/02/2020 11:09, Naresh Kamboju wrote:
>> The selftest lkdtm test failed on x86_64 and arm64.
>> am I missing any pre-requisite?
>>
>> Boot log:
>> [    3.297812] lkdtm: No crash points registered, enable through debugfs
>>
> 
> from your logs I cannot deduce anything useful, but in our CI I've got similar issues
> since the 10/12th of Feb...
> 
> TAP version 13
> 1..71
> # selftests: lkdtm: PANIC.sh
> # Cannot find /sys/kernel/debug/provoke-crash/DIRECT (missing CONFIG_LKDTM?)
> not ok 1 selftests: lkdtm: PANIC.sh # SKIP
> # selftests: lkdtm: BUG.sh
> # Cannot find /sys/kernel/debug/provoke-crash/DIRECT (missing CONFIG_LKDTM?)
> 
> so I suppose this and a bunch of other (probably new) tests are simply
> missing a bit of CONFIGs... (but I have still to look into this properly)
> (not sure if this also is your case either...)
> 
> Regards
> 
> Cristian
> 

Hi Kees,

Any ideas on what this is about? Missing config or something else?

thanks,
-- Shuah
