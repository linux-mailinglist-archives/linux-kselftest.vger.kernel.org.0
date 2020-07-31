Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34AB2343DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jul 2020 12:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbgGaKCr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jul 2020 06:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732080AbgGaKCr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jul 2020 06:02:47 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CE6C061574;
        Fri, 31 Jul 2020 03:02:47 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k1so6913559pjt.5;
        Fri, 31 Jul 2020 03:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YU2YU11NcpqAnb5BnC0Bw1oS+Y3NACnLXP9l9d7nU8o=;
        b=GzhGLmt9WCFC+8A67PIckUK/e+i3LY4XZqkhzFjXVGTEo2vHV87lte/KN81O63v/dc
         NsnUHhYx4eC041lzXmkd1Ok9Wo3iMdVDEAcG8l/qzRLHwuBASmpBkF4b7S4RdeAs2Lk4
         Ztlg7Ns8qaX1mXakicU0V5QUjrYtsxGevZNSPRi+nj6zgT1Ln4XtgEOLmeOwpQ7qWC4V
         IogmK6oqwsTZfwtiXFgoOK7TPLNy+ZlzU/ZzLGktlAgJF7TjBENklHq1F1P+NgLqqqLK
         onOjsCsGbosS1eh1tuvZ+MPRBHFzq1WgfHF88Vs80eG4zcyHXMo7UUzUj6LV3kWf0Xpc
         rLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YU2YU11NcpqAnb5BnC0Bw1oS+Y3NACnLXP9l9d7nU8o=;
        b=oIlsAjms0d4duiNl2M044CZCYHwpLS4r0Tb67gX4Z7y4pci+fRYFPAuzQrlIvGxWES
         yIK8xCynBeZQ02LfOXDm0ptkGgV8pbwd697VBeovBu2YHZRyjp8vfEamI0WKbavmOI8y
         xN021SzlpVlySF7CDNJVTi1FEQM/kYlBgiNJonJ7AN5hbvYxBIWpzFou4pja3BgSijsR
         4Ie8mFxi55tbaVwwCBeFwsD85XbQX67qZIVWaXD2pk2QLnXOkNZYuEIoHGzONnUVqoKH
         iWD0fQfAahyzEFVOgWNE/hRoPWkaHDrVm0QJjyeIgIL8b3VPWp++xidRlPwmJ+H2BUde
         E2kQ==
X-Gm-Message-State: AOAM530VH/CQ810sWC5EdmzNMh88ZJh5Oc14pE7vjDN2LK9wC/YQrmk8
        W5QfObH8ESe7weaM4PfTtptxf38DjfYxJw==
X-Google-Smtp-Source: ABdhPJwLQyaxvLsQABdV5E9Y7urq4jyaMU3+KOb6FiTJ4OR/0Daa00b9QChobxuBLLHVvnqs+Tvssg==
X-Received: by 2002:a63:fc52:: with SMTP id r18mr3090503pgk.334.1596189766470;
        Fri, 31 Jul 2020 03:02:46 -0700 (PDT)
Received: from [192.168.86.81] ([49.206.12.123])
        by smtp.gmail.com with ESMTPSA id u14sm9247222pgf.51.2020.07.31.03.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 03:02:45 -0700 (PDT)
Subject: Re: [PATCH] lib: Convert test_uuid.c to KUnit
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20200730121656.45302-1-98.arpi@gmail.com>
 <CAFd5g46wpYxF1=bs3LvXeVg6mPHrT6Ggp=QxScaf87O=yqcpBA@mail.gmail.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <3aae0ade-1a61-5d28-94ee-6b0eee7c7be6@gmail.com>
Date:   Fri, 31 Jul 2020 15:32:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g46wpYxF1=bs3LvXeVg6mPHrT6Ggp=QxScaf87O=yqcpBA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 31/07/20 11:20 am, Brendan Higgins wrote:
> On Thu, Jul 30, 2020 at 5:18 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>>
>> Converts test lib/test_uuid.c to KUnit
> 
> Can you add some more detail to the commit message? Maybe link to
> KUnit and say something about why this change is beneficial.
> 
Sure, I will make this change.
>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> 
> Change mostly looks good to me.
> Thank you for the review.

On failure, the original test calls another function which prints a detailed error. I removed it when converting to KUnit. Is this required?
