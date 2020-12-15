Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEA92DB107
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Dec 2020 17:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgLOQM4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Dec 2020 11:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730624AbgLOQMx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Dec 2020 11:12:53 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00140C0617A6
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 08:12:12 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n4so21018385iow.12
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 08:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QhmvISH3RhqLy0sRhM87D2JxNop7NLF9/+aZn3veZTQ=;
        b=AC+Zkdpv84wFo84wfo3TYDHsaO0C7PpqnsxAuvX9wBkVqKrg0I7h1Sj8u//yVOWbwa
         huj5P1rtFjETXTh9bEFqO0Gdq1V22rAnHDv1GjZA1RA0rpgulPb3s4YLN0oDCuw/9bYQ
         qrV8MD44N96xYUGsokv0kPIHfo8GilMG0zQS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QhmvISH3RhqLy0sRhM87D2JxNop7NLF9/+aZn3veZTQ=;
        b=NYBDcRdQgUyVJDAd+95H3HD+JWA87VScpUKRsNZz9PfXFG5NwqtJoJ+XLREY96vmIu
         iAwHsKUa8eX6sugjD1OE5v5HuYV8RsJ3TZY44Ln9JW3XAT5TlF/V30iJKstOzqhQKPGr
         EmkRduw1SglU1ZyVG6P4/3wjKwHimbQSOG03zmSvduweeN7gQ1joqcJfvnsXZTDV5Bnp
         Uex23L1Eshgp20XLtPAfNrNI4cWDb1fS1VPSHd9aprktufHhCKXZ9xnwU+nXxrFO4/ch
         GEwMGK2rtxLwOZRC0kGj8gwu74YOr/AgcDSybUuCkuPoKsvZwXTNoZXEzrw0/WkVZPFl
         tjZg==
X-Gm-Message-State: AOAM531j1gU29WBfxGxoOYCZQr9KfX88uOmJqXQcQC1CpxzHRcMAyoFg
        i9r/NzsYYT0/uaACoCmMdeTCbQ==
X-Google-Smtp-Source: ABdhPJy0fBUADBT+e4wnn9htUjE1wXC64//qtCKtv6YNcCeFtmx4rLl55N/aBacc0D3mdMl2w6gM/w==
X-Received: by 2002:a6b:b205:: with SMTP id b5mr37081694iof.190.1608048732136;
        Tue, 15 Dec 2020 08:12:12 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v23sm11092816iol.21.2020.12.15.08.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 08:12:11 -0800 (PST)
Subject: Re: related to fixing depreciated api
To:     Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <e479c654b6ca08057bf18a4e1c1d1ed3cdf8fdc8.camel@rajagiritech.edu.in>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <291555f8-ed17-5ed6-8ca4-42c8d5e13be9@linuxfoundation.org>
Date:   Tue, 15 Dec 2020 09:12:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <e479c654b6ca08057bf18a4e1c1d1ed3cdf8fdc8.camel@rajagiritech.edu.in>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/14/20 9:42 AM, Jeffrin Jose T wrote:
> hello,
> 
> i have worked on to  fix  depreciated api issue from
> tools/testing/selftests/intel_pstate/aerf.c
> 
> i met with the following error related...
> 
> --------------x------------------x----------------->
> $pwd
> /home/jeffrin/UP/linux-kselftest/tools/testing/selftests/intel_pstate
> $make
> gcc  -Wall -D_GNU_SOURCE    aperf.c /home/jeffrin/UP/linux-
> kselftest/tools/testing/selftests/kselftest_harness.h
> /home/jeffrin/UP/linux-kselftest/tools/testing/selftests/kselftest.h -
> lm -o /home/jeffrin/UP/linux-
> kselftest/tools/testing/selftests/intel_pstate/aperf
> aperf.c: In function ‘main’:
> aperf.c:58:2: warning: ‘ftime’ is deprecated [-Wdeprecated-
> declarations]
>     58 |  ftime(&before);
>        |  ^~~~~
> In file included from aperf.c:9:
> /usr/include/x86_64-linux-gnu/sys/timeb.h:39:12: note: declared here
>     39 | extern int ftime (struct timeb *__timebuf)
>        |            ^~~~~
> aperf.c:67:2: warning: ‘ftime’ is deprecated [-Wdeprecated-
> declarations]
>     67 |  ftime(&after);
>        |  ^~~~~
> In file included from aperf.c:9:
> /usr/include/x86_64-linux-gnu/sys/timeb.h:39:12: note: declared here
>     39 | extern int ftime (struct timeb *__timebuf)
>        |            ^~~~~
> $
> ----------------x---------------x---------------------->
> 
> 
> from ftime manual  i found that it is depreciated...
> 
> This  function is deprecated, and will be removed in a future version
> of the GNU C library.  Use clock_gettime(2) instead.
> 
> 
> now clock_gettime  gives  new data structure.
> 
>   struct timespec {
>                 time_t   tv_sec;        /* seconds */
>                 long     tv_nsec;       /* nanoseconds */
>             };
> 
> 
> i worked on with the new data structure and some errors that came
> along.
> typical final output looks good but  values of runtime and typical
> frequency
> does not look normal during "sudo bash run.sh".
> 
> output of "git diff" and  a  portion of output of   "sudo bash run.sh".
> is attached.
> 

Please send a proper patch to fix intel_pstate to use clock_gettime.

thanks,
-- Shuah

