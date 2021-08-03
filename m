Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FCB3DF31F
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Aug 2021 18:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbhHCQrs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Aug 2021 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbhHCQrs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Aug 2021 12:47:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30951C06175F
        for <linux-kselftest@vger.kernel.org>; Tue,  3 Aug 2021 09:47:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u3so4721904ejz.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Aug 2021 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iY25rrglPS3Gh3oKWqjb0WQdwyn/C+G4a9t9iTacLA=;
        b=Rp1AHBn7mqvNUKwaNWCL5eeJRNv4Sj8iOJlnae2g/K2ya99iCDc2o8g3rV7yCAIPsP
         cLAX6nPbpaN5RNpAWr18gpUvpaWUEEiOMny7eME1xouUWAWDFJRMcNCFR5+tJlH1SQSb
         hshXkxWsXF/D2EQkVSU2LTkEzmCypIlZmzq8JkqR2fHd1+qcAVvmhdwXsZcBMt4yMW91
         IdU/HXVTyNfPEmKoJYxtz482h4IrsOz5313q/DY+gVsfZXuR8ae4+ZJxNacfBlRWwlN1
         GIKkczkk9RV60dZjUvQgQpBai7whjJv5tqTny5p8JAr5p1o49GZGNY8l97OcXyFGzcbk
         qYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iY25rrglPS3Gh3oKWqjb0WQdwyn/C+G4a9t9iTacLA=;
        b=I3TCW3VJUFChpBus6IBrbzvjkc+inDpSy1M90VDyzHUOqL017MX81D2Bsgd4MRPPE+
         a9xKuXDi5neCLL2IYhYiO7v+Erlsme6yeHlZ95Gc4l07xp+syV/a05J+oYSd989KFFrz
         5HcZRyjCi+CCednYaGloY4ySW4sHv2bsDYlMny5y5B0ee8gpTVQOc5Cc30YNSYuWov3K
         ZIusz1OUc4ut5bPzeDEU5H6m4AUZNiUgdsh8g72N8Ef9+fARrJ+jwsdDwV1LdbxaWQiz
         qgV11W4h8tzilGwHG+sYffuvaSqVh68/hTazJubqJPJQ3gIxoBO9EbWK2cJkj6UXoJjL
         Hhbw==
X-Gm-Message-State: AOAM533fefILJi/TFyVLHIKKrw1LbC/L9/qD73QFk4Q5W3Ve8s4ZMmPw
        ODwANBudovv6nHjow+sUdZrImwyd6aeiwp+kUYXs
X-Google-Smtp-Source: ABdhPJyeizlYtaT4m3WQejwy/YbdzzVZLtADNLtj71rZ3bIkcfPCEneSHNfWGUOmCbGIw0lOIuiQaYVVmXT3+5FbtTA=
X-Received: by 2002:a17:906:5fc7:: with SMTP id k7mr21088425ejv.377.1628009255659;
 Tue, 03 Aug 2021 09:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <74f7b4cf-926f-d8bd-19c2-375cfe7a12b2@collabora.com>
In-Reply-To: <74f7b4cf-926f-d8bd-19c2-375cfe7a12b2@collabora.com>
From:   Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date:   Wed, 4 Aug 2021 01:46:58 +0900
Message-ID: <CANgtXuPjD0rW-A=gMNUd7mdF1Bynz+QQmDHLy7vh9UODd8NtbA@mail.gmail.com>
Subject: Re: KernelCI Hackfest #2 - Sept 6-10 2021
To:     kernelci@groups.io, guillaume.tucker@collabora.com
Cc:     kernelci-members <kernelci-members@groups.io>,
        automated-testing@lists.yoctoproject.org,
        Collabora Kernel ML <kernel@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Summer Wang <wangsummer@google.com>,
        linux-kselftest@vger.kernel.org, workflows@vger.kernel.org,
        kunit-dev@googlegroups.com,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Mon, Aug 2, 2021 at 6:00 PM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> The first KernelCI hackfest[1] early June was successful in getting
> a number of kernel developers to work alongside the core KernelCI
> team.  Test coverage was increased in particular with kselftest,
> LTP, KUnit and a new test suite for libcamera.  We're now improving
> documentation and tooling to make it easier for anyone to get
> started.  Find out more about KernelCI on https://kernelci.org.
>
> The second hackfest is scheduled for the 6th-10th September.  It
> should be a good opportunity to start discussing and working on
> upstream kernel testing topics ahead of the Linux Plumbers
> Conference[2].
>
> Here's the project board where anyone can already add some ideas:
>
>   https://github.com/orgs/kernelci/projects/5

I cannot add topics to the project board.

Thanks,
Alice

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================
