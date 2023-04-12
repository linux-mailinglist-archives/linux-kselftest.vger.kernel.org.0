Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B195C6DFE46
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 21:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDLTCj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 15:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjDLTCf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 15:02:35 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558DDDB;
        Wed, 12 Apr 2023 12:02:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 3ACF7604FC;
        Wed, 12 Apr 2023 21:02:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1681326150; bh=MZrLrA0qphSQiqVNIwMPkkaJza5Q/YB9iEUPTytNJwo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m93S4u+0ur1U5e8B+NMv6Q+cNvJ1RLhTNKyiXPY5DU6T1Uqek9xwPQrzVaewiAuXm
         XC5PUW6lWKqKuQLfcY+I3kcFTSYA6xqTyuSXPol/NsfC8440b3bXupA7KYobqvJ8NY
         Aga9XH6KJCYNGUsGae56fwNBFgOrrkTGLMAzjNhcliI7Kk5NL4TfVq4oiy+JdbOxMg
         sfwSIMvcjW/y2T46I3wL98fNk2/BeIKhgfqCH2MkSK6gKdvB4X25hX0Vk5I7eJ3SdN
         f3MbYsCYNGkYJiUbMM1D4Nuwp4ut7ss3twW+9xaq8NbINmqxmuBQHqKD7/RwAW6nnz
         VZYQ2kbK1Dj1A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X7cJsdD_NngQ; Wed, 12 Apr 2023 21:02:27 +0200 (CEST)
Received: from [192.168.1.4] (unknown [94.250.188.177])
        by domac.alu.hr (Postfix) with ESMTPSA id 24195604FB;
        Wed, 12 Apr 2023 21:02:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1681326147; bh=MZrLrA0qphSQiqVNIwMPkkaJza5Q/YB9iEUPTytNJwo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BK2E8c8QoF+0uLjs8cD9T8y/HToYn44onk2U12Jt6G3n+P/QlEDsV4/m+ga9yIraA
         M6A7H8QQu6rdAfmbfpgtqkhFpPSK/otg4RBRaFAMPx/cYiwpis4+C1MhyvH6Afogbp
         dFSaPTyL+MHrUXMVUgyEwMDOuI8nsSow/i8m9ZrbJAsgxzsAxE2eqPsbZvc00eld06
         nuQ6eguYPlWmGnm8gtLX/TjiPGUc20vW/+AVxAblXNLsOW0psiJwYE0se2Z2Tp99gs
         sEQjMyhrMxNi6j5Dn8XPv5EwM+uiyahAWwLZOFbYwASx8iMDxEYoUJanzjiGro2rt8
         SzwcfUnYZ8/2Q==
Message-ID: <835f81b3-1810-1d1f-a5b4-a040cd7ec9a9@alu.unizg.hr>
Date:   Wed, 12 Apr 2023 21:02:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/2] selftests: gpio: gpio-sim: Fix BUG: test FAILED
 due to recent change
Content-Language: en-US, hr
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
References: <20230411171521.29678-1-andriy.shevchenko@linux.intel.com>
 <ZDWdRQmKryGjJcFD@smile.fi.intel.com>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZDWdRQmKryGjJcFD@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11. 04. 2023. 19:47, Andy Shevchenko wrote:
> On Tue, Apr 11, 2023 at 08:15:20PM +0300, Andy Shevchenko wrote:
>> From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> 
> Ah, Mirsad, I need your SoB, if you are okay with the change.
> Otherwise I have to drop your authorship
Hi, Andy,

Sorry I needed to vent my beer before doing this test:

[root@pc-mtodorov linux_torvalds]# uname -rms
Linux 6.2.0-mglru-kmlk-andy-09238-gd2980d8d8265 x86_64
[root@pc-mtodorov linux_torvalds]# tools/testing/selftests/gpio/gpio-sim.sh
1. chip_name and dev_name attributes
1.1. Chip name is communicated to user
1.2. chip_name returns 'none' if the chip is still pending
1.3. Device name is communicated to user
2. Creating and configuring simulated chips
2.1. Default number of lines is 1
2.2. Number of lines can be specified
2.3. Label can be set
2.4. Label can be left empty
2.5. Line names can be configured
2.6. Line config can remain unused if offset is greater than number of lines
2.7. Line configfs directory names are sanitized
2.8. Multiple chips can be created
2.9. Can't modify settings when chip is live
2.10. Can't create line items when chip is live
2.11. Probe errors are propagated to user-space
2.12. Cannot enable a chip without any GPIO banks
2.13. Duplicate chip labels are not allowed
2.14. Lines can be hogged
3. Controlling simulated chips
3.1. Pull can be set over sysfs
3.2. Pull can be read from sysfs
3.3. Incorrect input in sysfs is rejected
3.4. Can't write to value
4. Simulated GPIO chips are functional
4.1. Values can be read from sysfs
4.2. Bias settings work correctly
cat: /sys/devices/platform/gpio-sim.0/gpiochip18/sim_gpio0/value: No such file or directory
tools/testing/selftests/gpio/gpio-sim.sh: line 393: test: =: unary operator expected
bias setting does not work
GPIO gpio-sim test FAIL
[root@pc-mtodorov linux_torvalds]# git apply ../gpio-sim-andy2.patch
[root@pc-mtodorov linux_torvalds]# tools/testing/selftests/gpio/gpio-sim.sh
1. chip_name and dev_name attributes
1.1. Chip name is communicated to user
1.2. chip_name returns 'none' if the chip is still pending
1.3. Device name is communicated to user
2. Creating and configuring simulated chips
2.1. Default number of lines is 1
2.2. Number of lines can be specified
2.3. Label can be set
2.4. Label can be left empty
2.5. Line names can be configured
2.6. Line config can remain unused if offset is greater than number of lines
2.7. Line configfs directory names are sanitized
2.8. Multiple chips can be created
2.9. Can't modify settings when chip is live
2.10. Can't create line items when chip is live
2.11. Probe errors are propagated to user-space
2.12. Cannot enable a chip without any GPIO banks
2.13. Duplicate chip labels are not allowed
2.14. Lines can be hogged
3. Controlling simulated chips
3.1. Pull can be set over sysfs
3.2. Pull can be read from sysfs
3.3. Incorrect input in sysfs is rejected
3.4. Can't write to value
4. Simulated GPIO chips are functional
4.1. Values can be read from sysfs
4.2. Bias settings work correctly
GPIO gpio-sim test PASS
[root@pc-mtodorov linux_torvalds]# 

So the issue was reproduced again on the above mentioned kernel, and the patch fixes it.
I will never trust an unexecuted line again, so help me the Lord Above.

Yes, you have both:

Tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

Thank you for considering my bug report. It is great to assist your professional team.

This issue wasn't triggered by the 6.1.15 mglru kernel, and I am wondering what could
be the difference? (With the same gpio-sim.sh and patch.)

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"

