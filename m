Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC344EE220
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Mar 2022 21:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiCaTyF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Mar 2022 15:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbiCaTyE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Mar 2022 15:54:04 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B1E51586
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Mar 2022 12:52:16 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 7760 invoked from network); 31 Mar 2022 21:52:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1648756333; bh=9DW+eSPUjcl4P7CH+RNH4XhlOlBnvOKNXj68YTnQ38U=;
          h=Subject:To:Cc:From;
          b=Ut2O/BMD03xK94n/BRPNygjHuhHC22WkujejJKrnvIX7AH9mHmxvgpBNaYYGx3W7k
           DGdrOQYHrPkn7ecXTg5ttN3j+KepXE7ttl6PZcx6fTF7Mlocn6L2jBI3zw5BI/XXdR
           qDQQbawSJIGnDUlagNYtVj5fvbXEc6khbBBj3Dco=
Received: from aaew62.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.126.62])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <alexandre.belloni@bootlin.com>; 31 Mar 2022 21:52:13 +0200
Message-ID: <2d139619-455d-412f-d60b-e8d9259ed7e7@o2.pl>
Date:   Thu, 31 Mar 2022 21:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] [RFC] rtc: expose direct access to hardware alarm
 time in debugfs
Content-Language: en-GB
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Shuah Khan <shuah@kernel.org>
References: <20220331190612.22162-1-mat.jonczyk@o2.pl>
 <YkYCqI0HEJvi2VjV@piout.net>
From:   =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>
In-Reply-To: <YkYCqI0HEJvi2VjV@piout.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: a15a250fb30b6f30de58fc64e21921f2
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [0SMU]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

W dniu 31.03.2022 o 21:36, Alexandre Belloni pisze:
> Hello,
>
> On 31/03/2022 21:06:11+0200, Mateusz Jończyk wrote:
>> Before Linux 5.17, there was a problem with the CMOS RTC driver:
>> cmos_read_alarm() and cmos_set_alarm() did not check for the UIP (Update
>> in progress) bit, which could have caused it to sometimes fail silently
>> and read bogus values or do not set the alarm correctly.
>> Luckily, this issue was masked by cmos_read_time() invocations in core
>> RTC code - see https://marc.info/?l=linux-rtc&m=164858416511425&w=4
>>
>> To avoid such a problem in the future in some other driver, I wrote a
>> test unit that reads the alarm time many times in a row. As the alarm
>> time is usually read once and cached by the RTC core, this requires a
>> way for userspace to trigger direct alarm time read from hardware. I
>> think that debugfs is the natural choice for this.
>>
>> So, introduce /sys/kernel/debug/rtc/rtcX/wakealarm_raw. This interface
>> as implemented here does not seem to be that useful to userspace, so
>> there is little risk that it will become kernel ABI.
>>
>> Is this approach correct and worth it?
>>
> I'm not really in favor of adding another interface for very little
> gain, you want to use this interface to exercise the API in a way that
> will never happen in the real world, especially since __rtc_read_alarm
> is only called once, at registration time.
>
> I'm not sure the selftest is worth it then. You should better improve
> the existing unit tests by exercising the ioctls a bit more. syzbot did
> report interesting race conditions that were more severe.

OK, I did not know if other RTC drivers are likely to suffer from this kind of bugs.
I also thought that the bugs in cmos_read_alarm() / cmos_set_alarm() were more severe and
likely to affect existing users.

I had doubts if it's worth it, so I didn't finish the patches and sent it as RFC. It was a nice project, though.

Would you point to these race conditions reported by syzbot? I cannot find them.

Greetings,

Mateusz

