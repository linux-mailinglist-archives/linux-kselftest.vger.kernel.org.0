Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB8CD28C10
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 23:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbfEWVHV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 17:07:21 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:33036 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfEWVHU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 17:07:20 -0400
Received: by mail-pf1-f174.google.com with SMTP id z28so3938749pfk.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2019 14:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZTioGuKOgNO6SwugnrEDEktz7xGxS3YWSFmCmowDiZ8=;
        b=IxyjS7QI/iWlVolD7qMxHAsrVnEz6vYW71ld0uA+5lDEvFXgNW5y/+Hovb10dtf0fk
         Pg6Q1W5Z978oA4Q50rBxaWG9aZoy1bha2AtsABYeJSCXvM8bvkBZe/H7yebqDH4tZPmb
         e3KCf7zt3QR2PwmHVAlWsefxzk/UkrygDd1Uaw5e8miN15gBHL6N1BLt2cSjBeE8pV9v
         0yEEQxhqQpHE+4rX9vVQHwlzDvEily5DxK5axwiUyupU/tLG3xoW/cechfBnsByTQiuO
         mLRIdBQbbuT12JKswtN7ln/DniAJ2Wb+AFrXu6zhCVMik0qJAZtehXqlyAZ0Ssage/4R
         /RDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTioGuKOgNO6SwugnrEDEktz7xGxS3YWSFmCmowDiZ8=;
        b=tGsbo/zXz90PIH2Lvp4fxaZH7upTpG+SK+UUBCN5lmWy/9houBUT9PkCQLQ/0FwOwW
         9KI5zXvsCkE+WUdN5iE4t7wunn6mdAIEnfS+XZBb7nq4H3WgKJ3TH6kgYfkDAL6xhGME
         NwDEx7XAXwCMfoVrWJtaW6RFKq/kxF/emxUzVDQj4tIDSzGGqciGSiB7PUaxls3qhEJd
         zHmxY8YReIjsIVwFXcIrbXq7YucVcxiWBbgaEXVqZ8p2uDyKte7mFyA0P6KA5ZEBQrp/
         mz2VDJOxsNWnCso9mlJMYAWKVuF74s3a6HvcsV+lnY/jNxiFbu9Jp74/m1rrIS2LfGvi
         lNCg==
X-Gm-Message-State: APjAAAVdeCx1b3ClhIA6TgdmZH0Vq229amrngHZY/kO7hxF/nFpMceRc
        5Uv00zKC0bQZAYfK8qvn6oNElJGzeNUNJ1tdeV87pA==
X-Google-Smtp-Source: APXvYqzuzYiOYVO1qbzCh4Aabm6AuxyJ016kEM0zJSXu1CU6EAU3utELN2tXg74h76qjcEGbSDT5iAY80582D/hn8Oc=
X-Received: by 2002:a63:550c:: with SMTP id j12mr5619579pgb.450.1558645640095;
 Thu, 23 May 2019 14:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=yYwk+g28_dnOcN--w-PLbGtA2oM5tq14W4X5bBjdurnF2iA@mail.gmail.com>
 <20190523174739.GY3274@piout.net>
In-Reply-To: <20190523174739.GY3274@piout.net>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Fri, 24 May 2019 02:36:42 +0530
Message-ID: <CAG=yYwmrE30nROqn63oAkXN9BCqfmo4T7+QPN-H3mSGG9dLU4A@mail.gmail.com>
Subject: Re: about selftests/rtc test related stuff
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, Shuah Khan <shuah@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 23, 2019 at 11:17 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Your user probably doesn't have access to the rtc device file.
anyway thanks related
Following is the result with sudo....
------------------------x--------------------------------------x----------------------------
$sudo ./rtctest
[sudo] password for jeffrin:
[==========] Running 7 tests from 2 test cases.
[ RUN      ] rtc.date_read
rtctest.c:49:rtc.date_read:Current RTC date/time is 23/05/2019 20:49:49.
[       OK ] rtc.date_read
[ RUN      ] rtc.uie_read
[       OK ] rtc.uie_read
[ RUN      ] rtc.uie_select
[       OK ] rtc.uie_select
[ RUN      ] rtc.alarm_alm_set
rtctest.c:137:rtc.alarm_alm_set:Alarm time now set to 20:49:58.
rtctest.c:156:rtc.alarm_alm_set:data: 1a0
[       OK ] rtc.alarm_alm_set
[ RUN      ] rtc.alarm_wkalm_set
rtctest.c:195:rtc.alarm_wkalm_set:Alarm time now set to 23/05/2019 20:50:01.
[       OK ] rtc.alarm_wkalm_set
[ RUN      ] rtc.alarm_alm_set_minute
rtctest.c:239:rtc.alarm_alm_set_minute:Alarm time now set to 20:51:00.
Alarm clock
$rtctest.c:258:rtc.alarm_alm_set_minute:data: 1a0

$

------------------------x--------------------------------------x----------------------------


-- 
software engineer
rajagiri school of engineering and technology
