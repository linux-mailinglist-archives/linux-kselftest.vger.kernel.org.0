Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871514EE2FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Mar 2022 23:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbiCaVBu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Mar 2022 17:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241546AbiCaVBt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Mar 2022 17:01:49 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C220E2F02C;
        Thu, 31 Mar 2022 14:00:00 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A6174FF804;
        Thu, 31 Mar 2022 20:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648760399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=au3yBAhLX+0F7+pryapHmT5qYPX7aFBG6FOt2FTCeKY=;
        b=Vsa0WrbboBwPFVKPsBTc7wQVKNDku5SauZ0LxU+A5kOKqFs3Cqx6BYgT0cpyZWwthK4aIP
        2724VS5/LPVvAtp2YUC7ZCwpa0Q6vYnFxHJdvsrFb5Z1vrZhLmYn8oMYHVaf5tMlsXnuPR
        jrWrO+1XxsaSb1s3MXYIkBmZEAb6F50ADVwdPO2a6oKIYF/Db8bTHQRdHkdrL3sTI+YDfi
        /sU0biKKn69OHuDk9gQwarNCzCYrW6zGcfx0oRmB7ujFOc1+xx7j3YNItTgyC5+0bVe8K4
        nMdHhKPoXmLyP3Lc36om+IubXdfKuWY9Qu0bFlIUifASpKTIxyLowlxCriEi+Q==
Date:   Thu, 31 Mar 2022 22:59:58 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] [RFC] rtc: expose direct access to hardware alarm
 time in debugfs
Message-ID: <YkYWTqOuSTHa4cMS@piout.net>
References: <20220331190612.22162-1-mat.jonczyk@o2.pl>
 <YkYCqI0HEJvi2VjV@piout.net>
 <2d139619-455d-412f-d60b-e8d9259ed7e7@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d139619-455d-412f-d60b-e8d9259ed7e7@o2.pl>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 31/03/2022 21:52:09+0200, Mateusz Jończyk wrote:
> W dniu 31.03.2022 o 21:36, Alexandre Belloni pisze:
> > Hello,
> >
> > On 31/03/2022 21:06:11+0200, Mateusz Jończyk wrote:
> >> Before Linux 5.17, there was a problem with the CMOS RTC driver:
> >> cmos_read_alarm() and cmos_set_alarm() did not check for the UIP (Update
> >> in progress) bit, which could have caused it to sometimes fail silently
> >> and read bogus values or do not set the alarm correctly.
> >> Luckily, this issue was masked by cmos_read_time() invocations in core
> >> RTC code - see https://marc.info/?l=linux-rtc&m=164858416511425&w=4
> >>
> >> To avoid such a problem in the future in some other driver, I wrote a
> >> test unit that reads the alarm time many times in a row. As the alarm
> >> time is usually read once and cached by the RTC core, this requires a
> >> way for userspace to trigger direct alarm time read from hardware. I
> >> think that debugfs is the natural choice for this.
> >>
> >> So, introduce /sys/kernel/debug/rtc/rtcX/wakealarm_raw. This interface
> >> as implemented here does not seem to be that useful to userspace, so
> >> there is little risk that it will become kernel ABI.
> >>
> >> Is this approach correct and worth it?
> >>
> > I'm not really in favor of adding another interface for very little
> > gain, you want to use this interface to exercise the API in a way that
> > will never happen in the real world, especially since __rtc_read_alarm
> > is only called once, at registration time.
> >
> > I'm not sure the selftest is worth it then. You should better improve
> > the existing unit tests by exercising the ioctls a bit more. syzbot did
> > report interesting race conditions that were more severe.
> 
> OK, I did not know if other RTC drivers are likely to suffer from this kind of bugs.
> I also thought that the bugs in cmos_read_alarm() / cmos_set_alarm() were more severe and
> likely to affect existing users.
> 
> I had doubts if it's worth it, so I didn't finish the patches and sent it as RFC. It was a nice project, though.
> 

Really, it is nice to see someone wanting to improve testing but I
really believe that we would benefit more from unit tests for the
actually userspace API.

> Would you point to these race conditions reported by syzbot? I cannot find them.
> 

It was that one:
https://groups.google.com/g/syzkaller-bugs/c/K1FV5LBwSgM/m/hhC_DciwBAAJ?pli=1

> Greetings,
> 
> Mateusz
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
