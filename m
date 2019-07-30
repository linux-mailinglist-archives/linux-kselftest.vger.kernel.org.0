Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD63A7B001
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2019 19:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfG3RbM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jul 2019 13:31:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfG3RbM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jul 2019 13:31:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47EDA3082B15;
        Tue, 30 Jul 2019 17:31:12 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBD565D9D3;
        Tue, 30 Jul 2019 17:31:11 +0000 (UTC)
Subject: Re: [PATCH] selftests/livepatch: push and pop dynamic debug config
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org
References: <20190718202948.3404-1-joe.lawrence@redhat.com>
 <e5027867-88db-fa45-6767-286f3b7b86ad@redhat.com>
 <20190719104625.5aigkzsm5wh3d5kn@pathway.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <23dcfc4d-c741-bea1-06f4-6eae48d64d63@redhat.com>
Date:   Tue, 30 Jul 2019 13:31:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719104625.5aigkzsm5wh3d5kn@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 30 Jul 2019 17:31:12 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/19/19 6:46 AM, Petr Mladek wrote:
> On Thu 2019-07-18 16:42:25, Joe Lawrence wrote:
>> On 7/18/19 4:29 PM, Joe Lawrence wrote:
>>> The livepatching self-tests tweak the dynamic debug config to verify
>>> the kernel log during the tests.  Enhance set_dynamic_debug() so that
>>> the config changes are restored when the script exits.
>>>
>>> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
>>> index de5a504ffdbc..860f27665ebd 100644
>>> --- a/tools/testing/selftests/livepatch/functions.sh
>>> +++ b/tools/testing/selftests/livepatch/functions.sh
>>> @@ -29,13 +29,27 @@ function die() {
>>>    	exit 1
>>>    }
>>> -# set_dynamic_debug() - setup kernel dynamic debug
>>> -#	TODO - push and pop this config?
>>> +function push_dynamic_debug() {
>>> +        DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
>>> +                awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
>>> +}
>>
>> It works for me, though I feel that the
>> /sys/kernel/debug/dynamic_debug/control output to input translation is
>> brittle.  It would be nice to have some kind of mass export/import
>> capability for that interface.
> 
> I believe that the format is pretty stable. We could always reconsider
> it when it breaks.
> 
> I could confirm that it restores the original state, so:
> 
> Tested-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr
> 

Hi Shuah,

Can you review and route this patch through your tree as well?

Thanks,

-- Joe
