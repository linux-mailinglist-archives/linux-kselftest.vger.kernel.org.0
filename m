Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE642A880B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Nov 2020 21:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgKEUZZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 15:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKEUZZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 15:25:25 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0109CC0613CF
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Nov 2020 12:25:25 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id v19so2954205lji.5
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Nov 2020 12:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MrnvvLHekW4TYcEWv1cXv+8uSn/ZuDUMwq3/3GN4sq0=;
        b=SjMwLyhqhzhQvXym8/7mnvZtsLe5vr0EVe2f8tTUdqIVC84JD3Sj8hqfv8VZm/20Sc
         lI5KTiHBI0MjWyuwa/+hDCUsIEuTv+Q68OXNk3gkvqWnFB5iqW6XMyQR0WS6uAgd1aO9
         UHYBC4SgSZP4Pnc3FFblf4fJfmcHT9zrlKr5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrnvvLHekW4TYcEWv1cXv+8uSn/ZuDUMwq3/3GN4sq0=;
        b=KgnCWV27SE1h8awsZ9Qh6mdSyOfhhSC9dDEE7HJQ8WJgJqBV8JBi5G+fKXDkRi2lY1
         geM1+8ldG6+J/7lh8WAQYVrdHezLI5PCVlMyMtgVSiHXo/uFU539u6SQAeTR5YUYFtGf
         A4NVltt7U5ODIBz7YDYuVkzuHCi/Ir+gb0Fx7flNlqGodvu5Vm9L8XyUseE4LVLkM6+m
         xf9l9mKTUfSHNrA0+J+b3EpapeR0JwKqLU4+He9hm2CqoEpnQkyV8yFJy1gJiBAJIotA
         662BjM+eb9uF7gH6AzgP/lNfPsLXeaKtzF3zo6KxY8TmCL653HkXYtqDTPlD+sWg4XDZ
         Udnw==
X-Gm-Message-State: AOAM5315UVpYjmeT6bmLtSP7GKHpOfpRS9vmpiPIZSMYO6DMadyTm4nT
        gzYLjzuwXpEAcdQ6XqBi8qGOuoATM0kr2w==
X-Google-Smtp-Source: ABdhPJz9h3CyYZD3DaQVncQiQ9coTcZjhVpubJgPTKqWFTY7RrD6do9Ei7m4DdynYFUcv7Paqz3J1Q==
X-Received: by 2002:a05:651c:95:: with SMTP id 21mr1432652ljq.307.1604607923168;
        Thu, 05 Nov 2020 12:25:23 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id q4sm282261lfn.44.2020.11.05.12.25.22
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 12:25:22 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id b1so4167492lfp.11
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Nov 2020 12:25:22 -0800 (PST)
X-Received: by 2002:ac2:5c02:: with SMTP id r2mr1838888lfp.133.1604607921846;
 Thu, 05 Nov 2020 12:25:21 -0800 (PST)
MIME-Version: 1.0
References: <6b9e77b0-7272-221e-d475-41b266b22496@linuxfoundation.org> <CAHk-=wiscEwD+a4M2mns1kf2S+yE6gcPp0sn4znVt0ZUxaP3Wg@mail.gmail.com>
In-Reply-To: <CAHk-=wiscEwD+a4M2mns1kf2S+yE6gcPp0sn4znVt0ZUxaP3Wg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Nov 2020 12:25:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whPe8hpnMw9UpXyL2s+tyWX3VaG1yL57_zzwFLjP5pw5A@mail.gmail.com>
Message-ID: <CAHk-=whPe8hpnMw9UpXyL2s+tyWX3VaG1yL57_zzwFLjP5pw5A@mail.gmail.com>
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

On Thu, Nov 5, 2020 at 12:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Nov 5, 2020 at 8:55 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >
> >   .../kunit/test_data/test_config_printk_time.log    | Bin 1584 -> 1605 bytes
> >   .../test_data/test_interrupted_tap_output.log      | Bin 1982 -> 2003 bytes
> >   .../test_data/test_kernel_panic_interrupt.log      | Bin 1321 -> 1342 bytes
> >   .../kunit/test_data/test_multiple_prefixes.log     | Bin 1832 -> 1861
>
> This diffstat is a bit annoying.

Oh, and another note: because you don't have the "[GIT PULL}" marker
on the subject line, the pr-tracker-bot doesn't react to the pull
requests, and you didn't get notified that it's been pulled.

Just FYI - I personally don't care, as your pull requests do show up
in _my_ queue, because you have "git" and "pull" in the body of the
message. But the automation doesn't see them.

                 Linus
