Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73BEC6ED60
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2019 04:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfGTCvM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jul 2019 22:51:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbfGTCvM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jul 2019 22:51:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 548AE821CB;
        Sat, 20 Jul 2019 02:51:12 +0000 (UTC)
Received: from [10.10.124.112] (ovpn-124-112.rdu2.redhat.com [10.10.124.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D40FF608A4;
        Sat, 20 Jul 2019 02:51:11 +0000 (UTC)
Subject: Re: [PATCH] selftests/livepatch: add test skip handling
To:     shuah <shuah@kernel.org>, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20190714142829.29458-1-joe.lawrence@redhat.com>
 <20190714143306.GA29501@redhat.com>
 <5535ff5e-0f75-9185-11bb-400465f09f5c@kernel.org>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <42feff41-8a92-e252-0e90-5c0335547de1@redhat.com>
Date:   Fri, 19 Jul 2019 22:51:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5535ff5e-0f75-9185-11bb-400465f09f5c@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 20 Jul 2019 02:51:12 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/19/19 6:11 PM, shuah wrote:
> On 7/14/19 8:33 AM, Joe Lawrence wrote:
>> On Sun, Jul 14, 2019 at 10:28:29AM -0400, Joe Lawrence wrote:
>> 
 >> [ ... snip ... ]
>>
>> Testing:
>>
>> Here's the output if modprobe --dry-run doesn't like the modules (not
>> built, etc.):
>>
>>     TAP version 13
>>     selftests: livepatch: test-livepatch.sh
>>     ========================================
>>     SKIP: Failed modprobe --dry-run of module: test_klp_livepatch
>>     not ok 1..1 selftests: livepatch: test-livepatch.sh [SKIP]
>>     selftests: livepatch: test-callbacks.sh
>>     ========================================
>>     SKIP: Failed modprobe --dry-run of module: test_klp_callbacks_demo
>>     not ok 1..2 selftests: livepatch: test-callbacks.sh [SKIP]
>>     selftests: livepatch: test-shadow-vars.sh
>>     ========================================
>>     SKIP: Failed modprobe --dry-run of module: test_klp_shadow_vars
>>     not ok 1..3 selftests: livepatch: test-shadow-vars.sh [SKIP]
>> 
> 
> Please refine these messages to say what users should do. In addition
> to what failed, also add what is missing - enable config option etc.
> 

Hi Shuah,

Note that v2 was posted [1], but the output remains basically the same, 
so your comments still apply.

Off the top of my head, modprobe can fail for many reasons: unprivileged 
user, missing .ko files, missing modules.dep entry, kernel vermagic, 
interface versions, etc.

What would you think about modifying our skip() function to provide a 
catch-all list of CONFIG, environment, etc. requirements?  Something 
like, "Please ensure that the kernel was build with CONFIG_XYZ and that 
the tests are run with foo privileges"?  That would let us avoid trying 
to figure out exactly why the modprobe failed, but still help out the user.

Alternatively, are there existing modprobe callers in the selftests that 
already do a better job?

[1] 
https://lore.kernel.org/linux-kselftest/eac825ab-04c2-77cf-671e-1a2a576109b0@linux.vnet.ibm.com/T/#mc2f70095215738cb6a539e2c2e6a415c78a8add6

Thanks,

-- Joe
