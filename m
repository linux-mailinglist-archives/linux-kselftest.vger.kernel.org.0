Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABBC2A87AF
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Nov 2020 21:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgKEUDD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 15:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEUDD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 15:03:03 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04DEC0613D2
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Nov 2020 12:03:02 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id k25so2874792lji.9
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Nov 2020 12:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzlZsvxvnDbAB4V5qU3abNgbE7nVhIrLCKkbyuyi8ec=;
        b=bkU4Dkg48kCAPRFxnDmmJTKxQMN6YO7q5zZS1V8OAV2Ak27P6TVMjRXr2LRZ6c5dZR
         u5UkK3C3VGr/J/mVug2e1iFOqrxktkVQIX9iXVx4bKJ51YhPjy2wQmq5oX6Rmzf89Fqm
         n+eyy9zpL6oBOqWFwaujYmGaujnjXJZ/wNE+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzlZsvxvnDbAB4V5qU3abNgbE7nVhIrLCKkbyuyi8ec=;
        b=aG1SzxXu6H/tHukOHdwcIRUzLVcmGRUQwBZxOexvXMLcaHElSx1Pqt0lGzIjjBw5MR
         PYVemgdj+LWV/P9pIJNDKB8uSZHuwyTZUT00N6iBHylSw2NSgq0q5wFNzAamBZkOtHHN
         gTnRXH3g7yGCS85Am1OVIB4w7WWFhmXb4u58E58KpEKOxdNAoH0mUxqBwKU3yLH7/jq5
         nA6ZquZjmdHaiE35HqPumaGwCoT87IFd28GBuwVpmnud4sx/hNlYI52xGpOtRhJ2661P
         bjg5RiCokvy0HqIRyBQZCEBKk0g/yWDbQrWM95USGR0R8as71yaUTfJVJ7WeFqDHYeWQ
         TBcQ==
X-Gm-Message-State: AOAM530tZ22FzkfUMo461A3Jjywv3qB/62mBdaX6SsmnIWiENhenmrLo
        FPaBHOwfyp492HGo1gAsCqWOEk+VSquMgw==
X-Google-Smtp-Source: ABdhPJw8x4sUBscmxdLQGc0i1TtJW9hnhSQ81DFo1J3+x9Dqc4J95HXryBbhHMx0h0dNM+To1dRaGA==
X-Received: by 2002:a05:651c:3d1:: with SMTP id f17mr1652215ljp.80.1604606580237;
        Thu, 05 Nov 2020 12:03:00 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 15sm228487ljw.37.2020.11.05.12.02.58
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 12:02:58 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id u18so4067487lfd.9
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Nov 2020 12:02:58 -0800 (PST)
X-Received: by 2002:a19:c703:: with SMTP id x3mr1531696lff.105.1604606577657;
 Thu, 05 Nov 2020 12:02:57 -0800 (PST)
MIME-Version: 1.0
References: <6b9e77b0-7272-221e-d475-41b266b22496@linuxfoundation.org>
In-Reply-To: <6b9e77b0-7272-221e-d475-41b266b22496@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Nov 2020 12:02:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiscEwD+a4M2mns1kf2S+yE6gcPp0sn4znVt0ZUxaP3Wg@mail.gmail.com>
Message-ID: <CAHk-=wiscEwD+a4M2mns1kf2S+yE6gcPp0sn4znVt0ZUxaP3Wg@mail.gmail.com>
Subject: Re: Kunit fixes update for Linux 5.10-rc3
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 5, 2020 at 8:55 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
>   .../kunit/test_data/test_config_printk_time.log    | Bin 1584 -> 1605 bytes
>   .../test_data/test_interrupted_tap_output.log      | Bin 1982 -> 2003 bytes
>   .../test_data/test_kernel_panic_interrupt.log      | Bin 1321 -> 1342 bytes
>   .../kunit/test_data/test_multiple_prefixes.log     | Bin 1832 -> 1861

This diffstat is a bit annoying.

And the reason is that we have

    [torvalds@ryzen linux]$ cat tools/testing/kunit/.gitattributes
    test_data/* binary

iow, you're telling git that everything in that test_data directory is
binary blobs. Which isn't actually true.

This isn't new, but it was just more noticeable this time around.

That binary marker comes from commit afc63da64f1e ("kunit:
kunit_parser: make parser more robust") and I'm not really seeing the
reason for it.

                 Linus
