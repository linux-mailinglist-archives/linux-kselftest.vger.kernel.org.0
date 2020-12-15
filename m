Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E57F2DB6D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Dec 2020 00:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgLOXDg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Dec 2020 18:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730553AbgLOXDc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Dec 2020 18:03:32 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D66C0613D3
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 15:02:52 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id c22so806522pgg.13
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 15:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Bk5fGUf8OoBWTVA3v0ryGGi+6Q5v4pjP4r2z0t/1CSc=;
        b=FZitHSTscvf0XOWi95QhoS1q7wcndpNbD5L5DVunu+JeJcXf9Kf64yPrgAYZfhRsB4
         n3SY3LWyqSc3GtG8XkptkfRg46fzP8NZ6c7Deoh1bGs7wRPDDmc0d9XGzvK4FAT1sQbi
         BahsT6Vaju1NQmbgGEiVn5r2sHYdg389YUWC7mr5Ex0FHepQ8fyBsSUAQrAlDYyPxahV
         X+u+5tMtDqc0Xqq4tNRd1FGrB+9aohXMzASfI0WjrcmosLDdFjXVp78oWFMEv5nA2La1
         tSyWI8j5b6ammTgeJ9KRh/FWChoQ4u8SCv1Hjigj7jMIDPh9LczIXH1KyJCVAPYU0tLD
         5mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Bk5fGUf8OoBWTVA3v0ryGGi+6Q5v4pjP4r2z0t/1CSc=;
        b=YjbZHor1PJTqEwS+zP9jJ99J6uGF7M8QXDG1JiebJ5aOe1PCB2MrXCtk0RpY1Ixr87
         KEQDgaBFD5mzoPPm05hF3VOBjR4bOhAmG1aC482ZpKAx1oCbl6BNTIKy7EsI4C3Lav+U
         8xdonjx2nJ9VggCZ17/NvHXyR4xe2sonZjBoPykcz1fzhWbnt4afhifGRHbwwj0SoFwf
         9SNER1c5U9APCR4ww0ci9fvmOMvKxRzBkmcReNoEPsgJljhzCd8mSb3GGqbu/s9n7MxD
         Q4uqluJwTyBgE20UE3Aw+IJ5IeIOIdkUsef9QoV2dqZG+Ym0nT4G1K/lEaWKUbekKXa2
         50eQ==
X-Gm-Message-State: AOAM53176Ipa+hGJvbfjrXkKn2sXJ2vOsOvFgJpMKv7FunE7B+1KL/Jf
        jetL5CWjdd/4qOZC7TnBVZAB7Q==
X-Google-Smtp-Source: ABdhPJx2JozHFm59QOFfO3MK+J+lixOcghnUrRXNfRUUUf+1bpmh4FRuJMBHSR8p4wguFEatBYgMkQ==
X-Received: by 2002:a62:c504:0:b029:1a5:b198:18dc with SMTP id j4-20020a62c5040000b02901a5b19818dcmr1155779pfg.79.1608073372173;
        Tue, 15 Dec 2020 15:02:52 -0800 (PST)
Received: from [192.168.1.9] ([122.174.165.16])
        by smtp.gmail.com with ESMTPSA id x6sm32077pfq.57.2020.12.15.15.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:02:51 -0800 (PST)
Message-ID: <0dda43447eaa332396f3442dfc439d5a3adc8d34.camel@rajagiritech.edu.in>
Subject: Re: related to fixing depreciated api
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Wed, 16 Dec 2020 04:32:48 +0530
In-Reply-To: <86388240-57df-977f-d0ac-47c2ed7df7a5@linuxfoundation.org>
References: <e479c654b6ca08057bf18a4e1c1d1ed3cdf8fdc8.camel@rajagiritech.edu.in>
         <291555f8-ed17-5ed6-8ca4-42c8d5e13be9@linuxfoundation.org>
         <86388240-57df-977f-d0ac-47c2ed7df7a5@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2020-12-15 at 12:52 -0700, Shuah Khan wrote:
> On 12/15/20 9:12 AM, Shuah Khan wrote:
> > On 12/14/20 9:42 AM, Jeffrin Jose T wrote:
> > > hello,
> > > 
> > > i have worked on to  fix  depreciated api issue from
> > > tools/testing/selftests/intel_pstate/aerf.c
> > > 
> > > i met with the following error related...
> > > 
> > > --------------x------------------x----------------->
> > > $pwd
> > > /home/jeffrin/UP/linux-
> > > kselftest/tools/testing/selftests/intel_pstate
> > > $make
> > > gcc  -Wall -D_GNU_SOURCE    aperf.c /home/jeffrin/UP/linux-
> > > kselftest/tools/testing/selftests/kselftest_harness.h
> > > /home/jeffrin/UP/linux-
> > > kselftest/tools/testing/selftests/kselftest.h -
> > > lm -o /home/jeffrin/UP/linux-
> > > kselftest/tools/testing/selftests/intel_pstate/aperf
> > > aperf.c: In function ‘main’:
> > > aperf.c:58:2: warning: ‘ftime’ is deprecated [-Wdeprecated-
> > > declarations]
> > >     58 |  ftime(&before);
> > >        |  ^~~~~
> > > In file included from aperf.c:9:
> > > /usr/include/x86_64-linux-gnu/sys/timeb.h:39:12: note: declared
> > > here
> > >     39 | extern int ftime (struct timeb *__timebuf)
> > >        |            ^~~~~
> > > aperf.c:67:2: warning: ‘ftime’ is deprecated [-Wdeprecated-
> > > declarations]
> > >     67 |  ftime(&after);
> > >        |  ^~~~~
> > > In file included from aperf.c:9:
> > > /usr/include/x86_64-linux-gnu/sys/timeb.h:39:12: note: declared
> > > here
> > >     39 | extern int ftime (struct timeb *__timebuf)
> > >        |            ^~~~~
> > > $
> > > ----------------x---------------x---------------------->
> > > 
> > > 
> > > from ftime manual  i found that it is depreciated...
> > > 
> > > This  function is deprecated, and will be removed in a future
> > > version
> > > of the GNU C library.  Use clock_gettime(2) instead.
> > > 
> > > 
> > > now clock_gettime  gives  new data structure.
> > > 
> > >   struct timespec {
> > >                 time_t   tv_sec;        /* seconds */
> > >                 long     tv_nsec;       /* nanoseconds */
> > >             };
> > > 
> > > 
> > > i worked on with the new data structure and some errors that came
> > > along.
> > > typical final output looks good but  values of runtime and
> > > typical
> > > frequency
> > > does not look normal during "sudo bash run.sh".
> > > 
> > > output of "git diff" and  a  portion of output of   "sudo bash
> > > run.sh".
> > > is attached.
> > > 
> > 
> > Please send a proper patch to fix intel_pstate to use
> > clock_gettime.
> > 
> 
> The fix for this is already in next - no need to send patch.
> 
> thanks,
> -- Shuah
> 
anyway thanks .


-- 
software engineer
rajagiri school of engineering and technology - autonomous


