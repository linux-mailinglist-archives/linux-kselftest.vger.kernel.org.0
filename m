Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21B22B2AF5
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Nov 2020 04:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgKNDRw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Nov 2020 22:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgKNDRv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Nov 2020 22:17:51 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BDFC0613D1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Nov 2020 19:17:51 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so16081519lfh.2
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Nov 2020 19:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=toERlzzL8WsCdEJfo/3bQq0LwXblt9dO26uWe3e3YTc=;
        b=V7otNblMuyZJjoIlSQV8V3el9jARxmNTrT4RNaPNgCDMAs6a8ZyF72bmMx/Puc7Z4B
         fTlnLfxV+9FVrwnZTwLcBybPWeVSZid1maToFquae9JPCw+wLluljYJWKP0aFiHbKQ+a
         C7UpxYgvZORZD8n0v8Ad5ZTGd8NYrz9W4r5EUDeltqDSuoIhDJT2ZZ3wtq62iCaYQgkw
         uGmjfgCLmoirVbHly8G9MdrrjFWCr2LBQUiWPxfaX+zBUEguGmVOpw8Z6HYyGdad67MC
         4i3mDgKKMnweBfOtBTVpeeSAgrLlGbhOY6BX9KMwPwrGxlGmX6Iz1cdceIL0DXQVChXf
         618A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=toERlzzL8WsCdEJfo/3bQq0LwXblt9dO26uWe3e3YTc=;
        b=jnXtU3xQ2AAIaEvFnsPaK+Q6tgO9+YA3uD/jgong8bEFWotn7F40OzRVY0g3gkdGN3
         tl1Tzrq6fQF1Gk+N4XY+ezw1IsDEIjGV87i+Ls+e51JN3DkofZ9FBkTH+HCEIV8f7VlL
         GlAcv8Ioz6L/xE7BMTn5TNZ56rWDFU7PZB5qvkkFObBB5FAFGk4AZez9HOheme6MFqQK
         5iRi6c+oao47qtnIKAvvq0Cu8s5igyDChgOZmLTh53FUFk8Q6O2buaLuYIqwiVvqqTCl
         bA6G8x43XNaAeYy6PnVMXPK5O5N6dKy1hlQMQv8VKuubyTWzKAGtfbxalyywnc4H6eNn
         0eZg==
X-Gm-Message-State: AOAM530e92za//QvAQVEkt69J3ISyZRG2t6hXnkh21tcnXNj96JZSlYa
        cIMN8a6Ar+DNXCmat7Ls/wYRsK736ZaVtJw2gxhJWw==
X-Google-Smtp-Source: ABdhPJzbOz34I7Z/noAxv/VgqHN/KtzJ/v+YY+qrROjrv3c/EYOpfeZxrDMfk5BeKnwQG9XwDsNMt8EnbVtsDL0qJGE=
X-Received: by 2002:a19:5e5e:: with SMTP id z30mr1879264lfi.277.1605323869521;
 Fri, 13 Nov 2020 19:17:49 -0800 (PST)
MIME-Version: 1.0
References: <CABVgOSkQ6+y7OGw2494cJa2b60EkSjncLNAgc9cJDbS=X9J3WA@mail.gmail.com>
 <CANpmjNNp2RUCE_ypp2R4MznikTYRYeCDuF7VMp+Hbh=55KWa3A@mail.gmail.com>
 <47a05c5a-485d-026b-c1c3-476ed1a97856@gmail.com> <CABVgOSkZ9k6bHPp=LVATWfokMSrEuD87jOfE5MiVYAEbZMmaQQ@mail.gmail.com>
 <BY5PR13MB29336C5BE374D69939DCADABFDE90@BY5PR13MB2933.namprd13.prod.outlook.com>
 <CABVgOSnJAgWvTTABaF082LuYjAoAWzrBsyu9sT7x4GGMVsOD6Q@mail.gmail.com>
 <BY5PR13MB293305FE7ED35EC2B2C81AF1FDE80@BY5PR13MB2933.namprd13.prod.outlook.com>
 <CABVgOSn0vUvHFTPPnFGCmg0pEotwr6TQXQieRV=EMqs1QmFYUw@mail.gmail.com>
 <20201112123706.GA2457520@elver.google.com> <CABVgOSkjExNtGny=CDT1WVaXUVgSEaf7hwx8=VY4atN5ot10KQ@mail.gmail.com>
 <20201113103056.GA1568882@elver.google.com> <CABVgOS=0Qm-Aa5qgh3PRxbcV0-2ZZaQCm-4HY0dx8597oY+yXw@mail.gmail.com>
 <CANpmjNNmzzuHpJOVV2JAKdgA48fxmqtXjDDOUg0e4+08kfQEXg@mail.gmail.com> <9c20815b-40df-d1c8-112f-e8d9732333eb@gmail.com>
In-Reply-To: <9c20815b-40df-d1c8-112f-e8d9732333eb@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 14 Nov 2020 11:17:38 +0800
Message-ID: <CABVgOSnkZ2f8JaXEUnCBS=7d7bgnCbKtp8QM1AUdVAuwQ9t69A@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Marco Elver <elver@google.com>, "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 14, 2020 at 9:38 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> On 14/11/20 5:44 am, Marco Elver wrote:
> >
> > Arpitha: Do you want to send v7, but with the following modifications
> > from what I proposed? Assuming nobody objects.
> >
> > 1. Remove the num_params counter and don't print the number of params
> > anymore, nor do validation that generators are deterministic.
> > 2. Remove the [].
> > [ I'm happy to send as well, just let me know what you prefer. ]
> >
> > Thanks,
> > -- Marco
> >
>
> If no objections I will send the v7 with the above changes.
> Thanks!

This sounds good to me!

Cheers,
-- David
