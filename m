Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD0840FF88
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Sep 2021 20:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbhIQSmQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Sep 2021 14:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240462AbhIQSmP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Sep 2021 14:42:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F025C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Sep 2021 11:40:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bq5so36823577lfb.9
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Sep 2021 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cpak71tpwGIH8sDgLDrdJbMzVDQHoqt6rJZasCMwdzc=;
        b=PPZqYKySWRBXLCmQqLignaVRzeemkJWbOSVm4Nk3LB3/dwYqxZT99gFitFC859Cqmo
         5dHLqIWjBbL09xTf3eNTCSAzEfwW62QnHoObFrYVOWn0PPzzY6lksRvKhahbrO9bPfvT
         /jfwN2l8iu/pKIRl254LqCHUDuwZMUECiAh00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cpak71tpwGIH8sDgLDrdJbMzVDQHoqt6rJZasCMwdzc=;
        b=ufsZHJayJXjZiPiSTZUvn/tCzvfFagfY9L2P5iw3MaE+xOSNvZX/K6opU8cJUDzJaq
         qxKvzc+bTo6sZRyOvwoYyni87B1aUjyemp4n90TmPMtNusCLw+Tj2bxcpcqHfKDxwg2Y
         NQDvkIh2FrNAxYR6jlBRqbwJlj/XaVuXk81GEaVcAvAW/Moq5K04nLcjWXIcSyQbdwSV
         oj8VNcHBUKD2IyQ4Instz7gnsyAoR5TcsVMUGBAH9K2VjnsyFK4AVMZKcrtaTvJ7G+jZ
         xPBX9ml/l2nnoHV/DBL1huyYqEJlKVH6TGinh1QLBJwCIj6Hm2tyF8+17m4aTM/Xx2bZ
         6uNA==
X-Gm-Message-State: AOAM532bnRZmYE9tGBbgZySa17NAWoI/g2Vas8lhMPO7hrAHNEJGN5VP
        vrRiJ2sopdhq7U7w98SagrtjWIbmoU5RaG8jcGM=
X-Google-Smtp-Source: ABdhPJwzdpMY+83Oo4lsmiZ8JuMmUyX1rmJU3nHcPlka8Z8LwlqOEGCdiLi2SsBnWsrbqQpb/i+0zQ==
X-Received: by 2002:a05:6512:3587:: with SMTP id m7mr2835756lfr.157.1631904051180;
        Fri, 17 Sep 2021 11:40:51 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id k16sm582972lfj.231.2021.09.17.11.40.49
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 11:40:49 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id i25so37120385lfg.6
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Sep 2021 11:40:49 -0700 (PDT)
X-Received: by 2002:a19:ae15:: with SMTP id f21mr9099719lfc.402.1631904049054;
 Fri, 17 Sep 2021 11:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061104.2680133-1-brendanhiggins@google.com>
 <20210917061104.2680133-6-brendanhiggins@google.com> <202109170856.8DDB49112D@keescook>
In-Reply-To: <202109170856.8DDB49112D@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Sep 2021 11:40:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whck4RtO7yp-jKK8QQc0bCDZBkdHc=3pGiFsFjwnQ+-mw@mail.gmail.com>
Message-ID: <CAHk-=whck4RtO7yp-jKK8QQc0bCDZBkdHc=3pGiFsFjwnQ+-mw@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] mmc: sdhci-of-aspeed: build kunit tests without
 structleak plugin
To:     Kees Cook <keescook@chromium.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <shuah@kernel.org>, David Gow <davidgow@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rafael Wysocki <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>, andreas.noever@gmail.com,
        michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YehezkelShB@gmail.com, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 17, 2021 at 8:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> This isn't a stand-alone test object, so I'm less excited about
> disabling STRUCTLEAK here.

Yeah, please don't do this for things that aren't pure tests. You're
now disabling security measures (even if I hate the gcc plugins and
hope they will go away).

             Linus
