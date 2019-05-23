Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44CAD28D70
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 00:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbfEWWw2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 18:52:28 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:45991 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbfEWWw2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 18:52:28 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 0173CC0002;
        Thu, 23 May 2019 22:52:19 +0000 (UTC)
Date:   Fri, 24 May 2019 00:52:19 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc:     a.zummo@towertech.it, Shuah Khan <shuah@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: about selftests/rtc test related stuff
Message-ID: <20190523225219.GZ3274@piout.net>
References: <CAG=yYwk+g28_dnOcN--w-PLbGtA2oM5tq14W4X5bBjdurnF2iA@mail.gmail.com>
 <20190523174739.GY3274@piout.net>
 <CAG=yYwmrE30nROqn63oAkXN9BCqfmo4T7+QPN-H3mSGG9dLU4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=yYwmrE30nROqn63oAkXN9BCqfmo4T7+QPN-H3mSGG9dLU4A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 24/05/2019 02:36:42+0530, Jeffrin Thalakkottoor wrote:
> On Thu, May 23, 2019 at 11:17 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > Your user probably doesn't have access to the rtc device file.
> anyway thanks related
> Following is the result with sudo....
> ------------------------x--------------------------------------x----------------------------
> $sudo ./rtctest
> [sudo] password for jeffrin:
> [==========] Running 7 tests from 2 test cases.
> [ RUN      ] rtc.date_read
> rtctest.c:49:rtc.date_read:Current RTC date/time is 23/05/2019 20:49:49.
> [       OK ] rtc.date_read
> [ RUN      ] rtc.uie_read
> [       OK ] rtc.uie_read
> [ RUN      ] rtc.uie_select
> [       OK ] rtc.uie_select
> [ RUN      ] rtc.alarm_alm_set
> rtctest.c:137:rtc.alarm_alm_set:Alarm time now set to 20:49:58.
> rtctest.c:156:rtc.alarm_alm_set:data: 1a0
> [       OK ] rtc.alarm_alm_set
> [ RUN      ] rtc.alarm_wkalm_set
> rtctest.c:195:rtc.alarm_wkalm_set:Alarm time now set to 23/05/2019 20:50:01.
> [       OK ] rtc.alarm_wkalm_set
> [ RUN      ] rtc.alarm_alm_set_minute
> rtctest.c:239:rtc.alarm_alm_set_minute:Alarm time now set to 20:51:00.
> Alarm clock
> $rtctest.c:258:rtc.alarm_alm_set_minute:data: 1a0
> 

I just sent a fix for that timeout issue.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
