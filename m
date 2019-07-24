Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E86736DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2019 20:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfGXSp4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jul 2019 14:45:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387665AbfGXSpz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jul 2019 14:45:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3D7CC05FBC0;
        Wed, 24 Jul 2019 18:45:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-104.rdu2.redhat.com [10.10.120.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3790F60BF7;
        Wed, 24 Jul 2019 18:45:55 +0000 (UTC)
Subject: Re: [PATCH v3] selftests/livepatch: add test skip handling
To:     shuah <shuah@kernel.org>, Petr Mladek <pmladek@suse.com>
Cc:     linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>
References: <20190722140544.29867-1-joe.lawrence@redhat.com>
 <20190724062730.xtutfqgpsr3pubv7@pathway.suse.cz>
 <0aae34cf-ae82-1f80-7bc9-27708c61287a@kernel.org>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <643f0d9f-ada1-da3d-7980-4f2df6a6e63f@redhat.com>
Date:   Wed, 24 Jul 2019 14:45:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0aae34cf-ae82-1f80-7bc9-27708c61287a@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 24 Jul 2019 18:45:55 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07/24/2019 12:45 PM, shuah wrote:
> On 7/24/19 12:27 AM, Petr Mladek wrote:
>> On Mon 2019-07-22 10:05:44, Joe Lawrence wrote:
>>> Add a skip() message function that stops the test, logs an explanation,
>>> and sets the "skip" return code (4).
>>>
>>> Before loading a livepatch self-test kernel module, first verify that
>>> we've built and installed it by running a 'modprobe --dry-run'.  This
>>> should catch a few environment issues, including !CONFIG_LIVEPATCH and
>>> !CONFIG_TEST_LIVEPATCH.  In these cases, exit gracefully with the new
>>> skip() function.
>>>
>>> Reported-by: Jiri Benc <jbenc@redhat.com>
>>> Suggested-by: Shuah Khan <shuah@kernel.org>
>>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>>
>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>>
>> Best Regards,
>> Petr
>>
>> PS: No need to send v4. The missing "to", suggested by Shuah, could
>>      get added when pushing the patch into the repo.
>>
> 
> I can't make changes to the patch. I can adjust the commit log at times
> and correct merge conflicts.
> 
> I would like to see v4 for this.
> 

We should clarify for which tree this and "[PATCH] selftests/livepatch: 
push and pop dynamic debug config​" would be merged.  I had assumed this 
would go to the livepatching tree, but Shuah, do you prefer that 
selftest-centric patches go through the selftests tree?

I'm okay with either and can send up a v4 if needed.  But also this 
would be good to know for future changesets like this, we can perhaps 
mark the destination branch in advance.

Thanks,

-- Joe

