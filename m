Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5C4EE20B
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Mar 2022 21:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbiCaTpL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Mar 2022 15:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbiCaTpL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Mar 2022 15:45:11 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E2733A05
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Mar 2022 12:43:22 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 26096 invoked from network); 31 Mar 2022 21:43:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1648755799; bh=ANFnNcZYAyo91FPMKaSjfBlBSWbVw7srBMK+3LbVF+s=;
          h=Subject:To:Cc:From;
          b=CzWInqYZhALXsZe6XAaI8+Df1nEc77xMpf9ctU2NWGitQ68CkE49biF7szzD6k7Cg
           CjbuNnc5bmw5Vns38pdAwSgDaHhaT9kvIe/2I3Gh8Z+GnZet+MfPHXLgB6Z0nm/t5b
           2ZOvNLtITm1AAGJgeHwpycEZm58Ii0jyTatqhKL0=
Received: from aaew62.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.126.62])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <greg@kroah.com>; 31 Mar 2022 21:43:19 +0200
Message-ID: <d08fddc4-8da5-b95a-4b03-954c4edbf546@o2.pl>
Date:   Thu, 31 Mar 2022 21:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] [RFC] rtc: expose direct access to hardware alarm
 time in debugfs
Content-Language: en-GB
To:     Greg KH <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shuah Khan <shuah@kernel.org>
References: <20220331190612.22162-1-mat.jonczyk@o2.pl>
 <YkX/Mbrt/In1HR32@kroah.com>
From:   =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>
In-Reply-To: <YkX/Mbrt/In1HR32@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 459b623b7e94f9868dc828fe4e2d69be
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 000000A [YYOE]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

W dniu 31.03.2022 o 21:21, Greg KH pisze:
> On Thu, Mar 31, 2022 at 09:06:11PM +0200, Mateusz Jończyk wrote:
>> Before Linux 5.17, there was a problem with the CMOS RTC driver:
>> cmos_read_alarm() and cmos_set_alarm() did not check for the UIP (Update
>> in progress) bit, which could have caused it to sometimes fail silently
>> and read bogus values or do not set the alarm correctly.
>> Luckily, this issue was masked by cmos_read_time() invocations in core
>> RTC code - see https://marc.info/?l=linux-rtc&m=164858416511425&w=4
[snip]
>> diff --git a/drivers/rtc/debugfs.c b/drivers/rtc/debugfs.c
>> new file mode 100644
>> index 000000000000..5ceed5504033
>> --- /dev/null
>> +++ b/drivers/rtc/debugfs.c
>> @@ -0,0 +1,112 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +/*
>> + * Debugfs interface for testing RTC alarms.
>> + */
>> +#include <linux/debugfs.h>
>> +#include <linux/err.h>
>> +#include <linux/rtc.h>
>> +
>> +static struct dentry *rtc_main_debugfs_dir;
>> +
>> +void rtc_debugfs_init(void)
>> +{
>> +	struct dentry *ret = debugfs_create_dir("rtc", NULL);
>> +
>> +	// No error is critical here
> What do you mean by this?

I meant that even if debugfs_create_dir() fails, this does not matter here and the
caller of rtc_debugfs_init() may continue execution.

>> +	if (!IS_ERR(ret))
>> +		rtc_main_debugfs_dir = ret;
> This should not be needed.
>
> Just set the directory and away you go.
>
> But why even save it?  If you need it you can always look it up, right?
OK, I did not know about easy lookup of debugfs directories.
> And when are you removing this directory you created?
Never, as the RTC subsystem cannot be compiled as a module.
This is the main debugfs directory of RTC subsystem, directories for specific devices
(rtc0, etc.) are created below it.
Please correct me if I'm wrong, but I thought that empty debugfs directories do not hurt.


Thanks for reviewing,

Mateusz

