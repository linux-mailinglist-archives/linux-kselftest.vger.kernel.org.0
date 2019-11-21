Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74629104792
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2019 01:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfKUAev (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Nov 2019 19:34:51 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36530 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfKUAev (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Nov 2019 19:34:51 -0500
Received: by mail-yb1-f193.google.com with SMTP id v2so796669ybo.3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2019 16:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWaEHl8kXnc/ilBwIC0fKVOLGYT5m0zyjw0M9xnnzec=;
        b=Az2PFRJ8EoqwtO1bnQ8JGV3VAc56DAnemflFAP0xrpuL2abK/J9DufsGpYWK58Lqdj
         GkjIXEiU0StKTI/wK4U9PrC3pqu2Nrmfo33rpm9q0s9Rb2Su9DGJGsJ72BvJaOJNuA9l
         tpJgRQaLUMJZ/cEkMCXd/1iwXYEj5GdV4lXAOOI3CwARuABYLPAmLGg2WPM8H1sbGjv9
         60E50LFMpIe2eE7yqTXwUABDYhEBQzTvlR8HgTSXwg7ocCDMWQK2nyFMF8h4yBm/Jokz
         jd+RcqIV09Yp9KwZ/31o4tpeDK+WZRLUJel0vbFmIJIzVVxdlL7NxrHrygzf7r/xJl6T
         GVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWaEHl8kXnc/ilBwIC0fKVOLGYT5m0zyjw0M9xnnzec=;
        b=Kdoh20c5LBZzUB2Ut7v8M+in0t7PJvAE4M80tLv2MbDshRPv6OxXHkjir+nbQ1z1Xf
         rtVsf0eLqA4PW7dqilU5tJt5hxO8oQgxq26EuEgFuyyie+DisaWHfdIG96kedCT0/Fzh
         ubXeSbnD2JP6WpdO8rcALa79oynIqd1qzx4VTL3E58GRDvcX9/cGhgdFYWGj0Ug6Q04L
         glKMFnncEHEqz9cdz93QNNxbv8ndL68ZrluCYMmU8dGtExhKxcX8alCx+AoFuQ8ugtZI
         yFWvmHD5u6rHS5PMOI6N3V3fqAtfjJSVe5euZ1aH2JPaOGM14z9oS5ahXHFdDOmEMkDv
         IvVg==
X-Gm-Message-State: APjAAAVIQaWiweANKreEzcRZaJVQsrSAHP+PltNrdOt7tDAZyE/flxmI
        Vi/cSQaO4KOXm9xNiRE3zxAFg62F
X-Google-Smtp-Source: APXvYqzqH2qXFR6bTBbv8dkcDTFCC69ivRfy6cHDkH+4Rd6oq0uMnXXuEqHOM7in2sc8RyHlYPJlDQ==
X-Received: by 2002:a25:46d5:: with SMTP id t204mr4104650yba.460.1574296487388;
        Wed, 20 Nov 2019 16:34:47 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 17sm538808ywb.13.2019.11.20.16.34.45
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 16:34:46 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id q7so791338ybk.4
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2019 16:34:45 -0800 (PST)
X-Received: by 2002:a25:dd04:: with SMTP id u4mr4257316ybg.419.1574296485124;
 Wed, 20 Nov 2019 16:34:45 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsmZOf9zgo5dy2_HfPPK-0tBYfCXpZy2DneFOeiJfN=_g@mail.gmail.com>
 <CA+FuTSd3t9fju3seZQ0OMTxSkPtysG88stMoqMAV4G1Mj3wsVA@mail.gmail.com> <CA+G9fYu=GXCZTQHU2kX0yoUxPgWkKVF44NJhadTP07uHF9St3g@mail.gmail.com>
In-Reply-To: <CA+G9fYu=GXCZTQHU2kX0yoUxPgWkKVF44NJhadTP07uHF9St3g@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 20 Nov 2019 19:34:08 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdYOnJCsGuj43xwV1jxvYsaoa_LzHQF9qMyhrkLrivxKw@mail.gmail.com>
Message-ID: <CA+FuTSdYOnJCsGuj43xwV1jxvYsaoa_LzHQF9qMyhrkLrivxKw@mail.gmail.com>
Subject: Re: selftest/net: so_txtime.sh fails intermittently - read Resource
 temporarily unavailable
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        jesus.sanchez-palencia@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 20, 2019 at 1:33 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> On Fri, 15 Nov 2019 at 21:52, Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Thu, Nov 14, 2019 at 3:47 AM Naresh Kamboju
>
> > This appears to have been flaky from the start, particularly on qemu_arm.
>
> This is because of emulating 2 CPU.
> I am gonna change this to emulate 4 CPU for qemu_arm.
>
> >
> > Looking at a few runs..
> >
> > failing runs exceeds bounds:
> > https://lkft.validation.linaro.org/scheduler/job/1006586
> ...
> > delay29722: expected20000_(us) #
> > # ./so_txtime exceeds variance (2000 us)
> > "
> > These are easy to suppress, by just increasing cfg_variance_us and
> > optionally also increasing the delivery time scale.
>
> Alright !
> The variance is 2000.
> static int cfg_variance_us = 2000
>
> > Naresh, when you mention "multiple boards" are there specific
> > microarchitectural details of the hosts that I should take into
> > account aside from the qemu-arm virtualized environment itself?
>
> The easy to reproduce way is running 32-bit kernel and rootfs on
> x86_64 machine.

Thanks. As soon as I disabled kvm acceleration, it proved also easy to
reproduce on an x86_64 guest inside an x86_64 host.

> # ./so_txtime read Resource temporarily unavailable
> read: Resource_temporarily #

This occurs due to sch_etf dropping the packet on dequeue in
etf_dequeue_timesortedlist because of dequeue time is after the
scheduled delivery time.

There is some inevitable delay and jitter in scheduling the dequeue
timer. The q->delta argument to ETF enables scheduling ahead of the
deadline. Unfortunately, in this virtualized environment even the
current setting in so_txtime.sh of 200 us is proves too short. It
already seemed high to me at the time.

Doubling to 400 usec and also doubling cfg_variance_us to 4000 greatly
reduces -if not fully solves- the failure rate for me.

This type of drop is also reported through the socket error queue. To
avoid ending up with wholly meaningless time bounds, we can retry on
these known failures as long as failure rate is already low.
