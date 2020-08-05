Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EA823C580
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Aug 2020 08:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHEGAz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Aug 2020 02:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgHEGAy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Aug 2020 02:00:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD0C061756
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Aug 2020 23:00:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v9so11794059ljk.6
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Aug 2020 23:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4amqNobMnQskrRNh+ZQN5FQ7A/kozEUHT++fPm020d8=;
        b=E0lc3CXjKOyhFJ8W5SEzXm17LIcj0Xxh/4gZmYN6Fezg6JlIZ9gTkiO10Hu6Y8A5Fl
         jlT/crgqUtTel97HkTyRgKllCCY+pt6rFE4bdSoDo+TFnWyGyu/i+DiKDUsLgpECvr52
         sZfUtg5J0QJEbFGMKhvT9jbLdvhnmouDo5bdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4amqNobMnQskrRNh+ZQN5FQ7A/kozEUHT++fPm020d8=;
        b=qSHh3/SgrQYga70+xju991W7jx6mIzo5hKvFI0KJUPsimM7W0c2Qeuauu2Y0KOF9HK
         bvyNYxej2eKaEQYom1NSXhIaWsoVmp2JRrg+NVwx9k3jG1XF8NVC/u0tiSpuv/LIN02Y
         0B6FUQSXUmJf6X290TU+Z6BexkYnQZa02kT01bWTRHdCBenpp2Ixn5+8cHoW2F8ZEoh/
         gclwWgRAFnkQT94/R4MVx8ahNbRmbrltSZwxPdmDVHm8a0UPrmuo+NjaLZoNa4KjAyYd
         7DDlAYB+4sDvekz+0DN9wzEm7a7yQ282LwrpJ/3WRAZyjxZjhG8cENdv2SP7K8LxWlY4
         epgA==
X-Gm-Message-State: AOAM5311mErYCoXO+7Ju4DNr7s/mH4RHmHpIX5fsf1Pwtt8chK9RzH2b
        m2MxaxZPi0lzLmgyqKBVqFX+I0tlT6Y=
X-Google-Smtp-Source: ABdhPJxAaVOFHhSCui3dGwbZ68wbiDmsKQgJ8CRP1WROHefOazwr4wnv9NIOoXrstUEPH0ztHue7CQ==
X-Received: by 2002:a2e:b5b7:: with SMTP id f23mr586286ljn.380.1596607252168;
        Tue, 04 Aug 2020 23:00:52 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 203sm610121lfk.49.2020.08.04.23.00.49
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 23:00:50 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id i10so11508560ljn.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Aug 2020 23:00:49 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr593746ljc.371.1596607249414;
 Tue, 04 Aug 2020 23:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <0e3a9c1f-7ac6-33e2-ed11-5a56659fc5f7@linuxfoundation.org>
In-Reply-To: <0e3a9c1f-7ac6-33e2-ed11-5a56659fc5f7@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Aug 2020 23:00:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4iDwuazgXQ-1yvM_JMTBepi9rc-zfSMeyjfDgSS2fgA@mail.gmail.com>
Message-ID: <CAHk-=wi4iDwuazgXQ-1yvM_JMTBepi9rc-zfSMeyjfDgSS2fgA@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.9-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 4, 2020 at 2:56 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Please pull the following Kselftest update for Linux 5.9-rc1.

Shortlog? diffstat? And the actual git address to pull from?

I see the attached diff, and I'm sure I could guess what branch you
want me to pull from, but please do a proper pull request.

            Linus
