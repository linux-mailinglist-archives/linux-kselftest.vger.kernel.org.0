Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E995520B548
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 17:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgFZPv4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jun 2020 11:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbgFZPvz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jun 2020 11:51:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6B9C03E97A
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 08:51:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i3so10869709ljg.3
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+yupIHVEaUHp73cP5u6LnV/onGU7SFzXKN5zVmkGo+I=;
        b=zxJAPt+Bo7TqbvoBsBFLqKt4FY+2bwmP64zownTOMXf2auVPTSSkEBJY+4CQjQQXRb
         4HfDTEymX2IFUu+djhQVPJnRDcrshLS1fwcN4uf227PbkFmsrQMfxQdRAIGEbY/LH5Rf
         eJWPDh+7PyXvPyCaHfTotY+q26ZlrIlvKy2ZmqQyRNyBsFjfjHA59TL7E8WUNgJCAbGs
         ZBW3QanS7AONurGOwIeJu/owe9ftPyqY0a+X04KfI9gHvrKgTT8nKRvX+29VTthCDBXd
         cR5pCbhuaCX7NkJKNA+HP9/ZSkIICrjNrh5nxZPr4WRkBprfHMEpsVmwlJszwZhOgFbv
         Pw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+yupIHVEaUHp73cP5u6LnV/onGU7SFzXKN5zVmkGo+I=;
        b=YE47ZFf2hEe0Qsh5chnSKyiiPEi/1RwO7bAkUif9S4aHanwsH48pOHhMrYSXDvRVzM
         PKaoBIQ8gFSjlVQfk8T15/hnlwxO/jsm03qX8azwLLK0gxfO7kE/QZj65CzZgnT3OpTj
         kUSBK6X7p7vX0TjuWC9fi/eP9e4VhD87Nj8yjdCbRTpNzbxdnR4dMGoASaO3ivlBTU7k
         u/Q0qnKZoGP+j3uAndu5AffbnG0G4fVpvb+WfOKccAJhLVbcBwOTyp+T0zMKm4Q0ziyQ
         8ytKvlh4tgkSXRmdwSlxFxxk9C/Dl4/YeFWI5BFANBhGupZhpBF+tZRD5HFXbjOtPGVR
         hfTQ==
X-Gm-Message-State: AOAM531c8kh806Qtu+Sl/7na8NVXatQ4sx5ROTUe9O4WGcq1NufKpfR8
        xUq59+2S7nkgIAm94NL+GSR7J00naXNM9nZS/LWFGw==
X-Google-Smtp-Source: ABdhPJxmkkp3usLIm5u4dle+yZV5eFkwmahS1cqkdQ0mKaBAD+cHmI1d8UneTI4Bokhft+LY8vPWRH/p+HH4IB2yzYM=
X-Received: by 2002:a2e:9ed0:: with SMTP id h16mr1901309ljk.366.1593186714266;
 Fri, 26 Jun 2020 08:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200508065356.2493343-1-mpe@ellerman.id.au> <CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com>
 <c5b77970-ecaf-24ad-c34d-134acc1a6063@redhat.com> <20200624083955.GF8444@alley>
 <20200624201247.GA25319@redhat.com> <20200626080252.GL8444@alley> <762d9ca5-82f3-588c-b147-b0954a764ea7@redhat.com>
In-Reply-To: <762d9ca5-82f3-588c-b147-b0954a764ea7@redhat.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 26 Jun 2020 21:21:42 +0530
Message-ID: <CA+G9fYt8XEWDTrUJX6hpEGiTwHuYFv3UmMw-ND8KRCxu18fznA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/lkdtm: Don't clear dmesg when running tests
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        lkft-triage@lists.linaro.org, Miroslav Benes <mbenes@suse.cz>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> > Well, what about using "comm" as proposed by Michael in the other
> > mail? It seems to be part of coreutils and should be everywhere.
> >
> > I guess that many people, including me, are not fluent in awk.
> > So, I am slightly in favor of the "comm" approach ;-)
> >
>
> comm is definitely simpler and for some reason I forgot about the
> leading timestamps (again!) dismissing it thinking that the inputs
> weren't sorted.  But luckily they are and if Naresh or anyone can
> confirm that comm is well supported in the BusyBox testing environment,
> then using that is fine w/me.

"comm" works in our environment.

- Naresh
