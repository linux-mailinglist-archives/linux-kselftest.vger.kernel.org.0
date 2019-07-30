Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0D297B4FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2019 23:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbfG3V0V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jul 2019 17:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387515AbfG3V0V (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jul 2019 17:26:21 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F2242089E;
        Tue, 30 Jul 2019 21:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564521980;
        bh=PP0ubfiCNyxM2c+sT0yirSSx0j74Z0WiZBdUtnwhyM8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SS/IQ87bTiX2q21YeNXUKT7lyLq48YEJj7x/U/Kdp/wqq6eSWLsdMYhHFL37TvuPv
         3E95i0lGi1inKidbikhJTcTAFspctt/uvNJZSEU0jxLHx6wx0LgCXRDo3nH+WWVeqS
         oncu/3n4ps8j35RdvVmDsE2jOM+hh6rHeCLqJUNs=
Subject: Re: [PATCH] selftests/livepatch: push and pop dynamic debug config
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190718202948.3404-1-joe.lawrence@redhat.com>
 <e5027867-88db-fa45-6767-286f3b7b86ad@redhat.com>
 <20190719104625.5aigkzsm5wh3d5kn@pathway.suse.cz>
 <23dcfc4d-c741-bea1-06f4-6eae48d64d63@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <5568072f-1ba3-6f09-9558-8c857b6e0c3b@kernel.org>
Date:   Tue, 30 Jul 2019 15:26:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <23dcfc4d-c741-bea1-06f4-6eae48d64d63@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/30/19 11:31 AM, Joe Lawrence wrote:
> On 7/19/19 6:46 AM, Petr Mladek wrote:
>> On Thu 2019-07-18 16:42:25, Joe Lawrence wrote:
>>> On 7/18/19 4:29 PM, Joe Lawrence wrote:
>>>> The livepatching self-tests tweak the dynamic debug config to verify
>>>> the kernel log during the tests.  Enhance set_dynamic_debug() so that
>>>> the config changes are restored when the script exits.
>>>>
>>>> diff --git a/tools/testing/selftests/livepatch/functions.sh 
>>>> b/tools/testing/selftests/livepatch/functions.sh
>>>> index de5a504ffdbc..860f27665ebd 100644
>>>> --- a/tools/testing/selftests/livepatch/functions.sh
>>>> +++ b/tools/testing/selftests/livepatch/functions.sh
>>>> @@ -29,13 +29,27 @@ function die() {
>>>>        exit 1
>>>>    }
>>>> -# set_dynamic_debug() - setup kernel dynamic debug
>>>> -#    TODO - push and pop this config?
>>>> +function push_dynamic_debug() {
>>>> +        DYNAMIC_DEBUG=$(grep '^kernel/livepatch' 
>>>> /sys/kernel/debug/dynamic_debug/control | \
>>>> +                awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
>>>> +}
>>>
>>> It works for me, though I feel that the
>>> /sys/kernel/debug/dynamic_debug/control output to input translation is
>>> brittle.  It would be nice to have some kind of mass export/import
>>> capability for that interface.
>>
>> I believe that the format is pretty stable. We could always reconsider
>> it when it breaks.
>>
>> I could confirm that it restores the original state, so:
>>
>> Tested-by: Petr Mladek <pmladek@suse.com>
>>
>> Best Regards,
>> Petr
>>
> 
> Hi Shuah,
> 
> Can you review and route this patch through your tree as well?
> 

Looks good to me. Thanks for doing this. I will pick this up

thanks,
-- Shuah

