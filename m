Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAB24D46C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 19:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfJKRiZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 13:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbfJKRiZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 13:38:25 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 935112084C;
        Fri, 11 Oct 2019 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570815503;
        bh=FhFKD5bAw+84ONEspFkWiihYtAtQ5FUUCvMVJ3P9gVY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qalFBZ4O0c7ta497kl96FZi3IwhvVoEjZxK93A3IxYC8uXYyHwhfYBM1PPjT2SL0b
         19m7SE9c8XcA9wZzmrOv55AbOUOAnBrhobsFtq8KyLudBrgmVwYBxjIePyuaAXH17H
         OVeeWWPjP3X/tkdJHDih6xyjlY+ZWglHyEdo/wwM=
Subject: Re: syzkaller reproducers
To:     Dmitry Vyukov <dvyukov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io,
        George Kennedy <george.kennedy@oracle.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>
Cc:     syzkaller <syzkaller@googlegroups.com>, shuah <shuah@kernel.org>
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
 <CACT4Y+ZaN900gwx=PHS10hrKofZib7HA7JFxE_DkwChyttYW+A@mail.gmail.com>
 <876a2abe-41ab-5819-4ae8-ad26186d0d1c@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <226099bc-9763-3a73-e26a-b292f601494c@kernel.org>
Date:   Fri, 11 Oct 2019 11:38:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <876a2abe-41ab-5819-4ae8-ad26186d0d1c@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/8/19 9:00 AM, shuah wrote:
> On 10/8/19 6:16 AM, Dmitry Vyukov wrote:
>> On Tue, Oct 8, 2019 at 1:46 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>>>
>>> Hi Shuah,
>>>
>>> We discussed collecting and uploading all syzkaller reproducers
>>> somewhere. You wanted to see how they look. I've uploaded all current
>>> reproducers here:
>>> https://github.com/dvyukov/syzkaller-repros
>>> Minimalistic build/run scripts are included.
>>> +some testing mailing lists too as this can be used as a test suite
>>> If you have any potential uses for this, you are welcome to use it.
>>> But then we probably need to find some more official and shared place
>>> for them than my private github.
>>> The test programs can also be bulk updated if necessary, because all
>>> of this is auto-generated.
>>>
>>> Thanks
>>
>> +more people who expressed interest in the test suite before
>>
> 
> Thanks for putting this together. I am going to create a repo on
> kernel.org t host these and pull your private git content in.
> 
> I will work on it this week and set things up.
> 

Playing with the git getting ready to host it on kernel.org git repo.
Build worked fine and I can't get the run.sh to work.

I expected it to run what is in

syzkaller-repros/bin

It doesn't seem to do that. Looks like it wants to build. Here is what
I see. What am I doing wrong? I did a build which worked. There are some
errors due to sys/cdefs.h missing.

++ for f in *
+++ pwd
++ bin=/mnt/data/lkml/syzkaller-repros/bin
+++ mktemp -d
++ dir=/tmp/tmp.S8CjM8muRj
++ cd /tmp/tmp.S8CjM8muRj
++ timeout -s KILL 3 /mnt/data/lkml/syzkaller-repros/bin
timeout: failed to run command ‘/mnt/data/lkml/syzkaller-repros/bin’: 
Permission denied
++ rm -rf /tmp/tmp.S8CjM8muRj
++ for f in *
+++ pwd
++ bin=/mnt/data/lkml/syzkaller-repros/build.sh
+++ mktemp -d
++ dir=/tmp/tmp.zAVygWdpkt
++ cd /tmp/tmp.zAVygWdpkt
++ timeout -s KILL 3 /mnt/data/lkml/syzkaller-repros/build.sh
linux/*.c
grep: linux/*.c: No such file or directory
gcc: error: linux/*.c: No such file or directory
gcc: fatal error: no input files
compilation terminated.
++ rm -rf /tmp/tmp.zAVygWdpkt
++ for f in *
+++ pwd
++ bin=/mnt/data/lkml/syzkaller-repros/LICENSE
+++ mktemp -d
++ dir=/tmp/tmp.hhcvgOc8RA
++ cd /tmp/tmp.hhcvgOc8RA
++ timeout -s KILL 3 /mnt/data/lkml/syzkaller-repros/LICENSE
timeout: failed to run command 
‘/mnt/data/lkml/syzkaller-repros/LICENSE’: Permission denied
++ rm -rf /tmp/tmp.hhcvgOc8RA
++ for f in *
+++ pwd
++ bin=/mnt/data/lkml/syzkaller-repros/linux
+++ mktemp -d
++ dir=/tmp/tmp.sM5UO7BHRB
++ cd /tmp/tmp.sM5UO7BHRB
++ timeout -s KILL 3 /mnt/data/lkml/syzkaller-repros/linux
timeout: failed to run command ‘/mnt/data/lkml/syzkaller-repros/linux’: 
Permission denied
++ rm -rf /tmp/tmp.sM5UO7BHRB
++ for f in *
+++ pwd
++ bin=/mnt/data/lkml/syzkaller-repros/README.md
+++ mktemp -d
++ dir=/tmp/tmp.4Kkrs6iLP5
++ cd /tmp/tmp.4Kkrs6iLP5
++ timeout -s KILL 3 /mnt/data/lkml/syzkaller-repros/README.md
timeout: failed to run command 
‘/mnt/data/lkml/syzkaller-repros/README.md’: Permission denied
++ rm -rf /tmp/tmp.4Kkrs6iLP5
++ for f in *
+++ pwd
++ bin=/mnt/data/lkml/syzkaller-repros/run.sh
+++ mktemp -d
++ dir=/tmp/tmp.YFx5WEOvJn
++ cd /tmp/tmp.YFx5WEOvJn
++ timeout -s KILL 3 /mnt/data/lkml/syzkaller-repros/run.sh
+ pwd
+ bin=/tmp/tmp.YFx5WEOvJn/*
+ mktemp -d
+ dir=/tmp/tmp.qD4i4g9qYR
+ cd /tmp/tmp.qD4i4g9qYR
+ timeout -s KILL 3 /tmp/tmp.YFx5WEOvJn/*
timeout: failed to run command ‘/tmp/tmp.YFx5WEOvJn/*’: No such file or 
directory
+ rm -rf /tmp/tmp.qD4i4g9qYR
++ rm -rf /tmp/tmp.YFx5WEOvJn

thanks,
-- Shuah
