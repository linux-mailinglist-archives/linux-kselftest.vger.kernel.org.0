Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9485FE2A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2019 17:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfKOQWG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Nov 2019 11:22:06 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35940 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfKOQWF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Nov 2019 11:22:05 -0500
Received: by mail-yb1-f195.google.com with SMTP id v2so4076354ybo.3
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2019 08:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79MdZ76OL/77YdcyMQUGONs/F+BMctNttv4BAu+k8mw=;
        b=DHEyADxYcWxDvNAdwskuseMzfBXxd2yOwsjGNfCoTqKcQJDXYZQjTgKOS0WBDJMtvW
         lnjk/MtFABDplMU+kLYdQu+EZleEWtC1zjXvVSm4+Ywmm28r1Q3hb5+eBVKlXwqyzh7/
         bBHOhuic1Do2SyEk/BTwrERVUyABSkoPw6gmZBzL+KLADTIB1+DRqS+k0lib0BHsPc9N
         GADdGVyHe9MYdXVKew91i8gBYkwc50Mm6f9DmRQ3+AQ66E0XoewbuBSxkgTdt8R1mpK4
         /jA3MWtIjAvm7CWmpi7ZfAwLSRT6PqaCPZRqZeX4ufhAdeJ7+HXw+A+odfhYtJKTO3pl
         OI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79MdZ76OL/77YdcyMQUGONs/F+BMctNttv4BAu+k8mw=;
        b=VXsuvif+JkV0sdgDDVsmUWOSNrd+Ab5i93yIogG68hV4cOdfHKmM7eHoQ4wLK88IqE
         i5AWbf5YihInn7ykKGR7p3kea7yyngc7R5q56uXfVfLQ+7LrjRze8oSLqltx/JbWdx9U
         DRZtLn2LJ7ojWpDG2Xs3tupRZ7SSvi8Jgog0FFDx3AlpHCor97ExmO1J3c1oQZoSQzB/
         wXVj4/sysXOePqNDnB5OXYNbRfRRWheFakcyM/OE0TngUcf36p0Ge00vfV/OBLqwVUAm
         zXqTY7OzN5tvURPwCbfxrzev3lx+Z4ifrb8l4z2DjUI8ESmzkPHWdn/gYDC1prWBOGoP
         5r1w==
X-Gm-Message-State: APjAAAXg20gf2p+yUQK8MoCXZrjW0LcEmUOEP0yntGsXZztNzgG/R7p4
        FQKZYakbEqXZ96u1swSGlu0PoHpS
X-Google-Smtp-Source: APXvYqzKzXHlAHHweYTnMrDhAZcF/etsmmxTgFVouSwW7hnHMglYST8YAU2HyGiR9Kdmsg95IgNDvg==
X-Received: by 2002:a25:7105:: with SMTP id m5mr12108619ybc.167.1573834922269;
        Fri, 15 Nov 2019 08:22:02 -0800 (PST)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id j79sm3445171ywa.100.2019.11.15.08.22.00
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 08:22:01 -0800 (PST)
Received: by mail-yw1-f47.google.com with SMTP id q140so3275853ywg.0
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2019 08:22:00 -0800 (PST)
X-Received: by 2002:a0d:e808:: with SMTP id r8mr9795877ywe.275.1573834919811;
 Fri, 15 Nov 2019 08:21:59 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsmZOf9zgo5dy2_HfPPK-0tBYfCXpZy2DneFOeiJfN=_g@mail.gmail.com>
In-Reply-To: <CA+G9fYsmZOf9zgo5dy2_HfPPK-0tBYfCXpZy2DneFOeiJfN=_g@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 15 Nov 2019 11:21:23 -0500
X-Gmail-Original-Message-ID: <CA+FuTSd3t9fju3seZQ0OMTxSkPtysG88stMoqMAV4G1Mj3wsVA@mail.gmail.com>
Message-ID: <CA+FuTSd3t9fju3seZQ0OMTxSkPtysG88stMoqMAV4G1Mj3wsVA@mail.gmail.com>
Subject: Re: selftest/net: so_txtime.sh fails intermittently - read Resource
 temporarily unavailable
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 14, 2019 at 3:47 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> selftests net so_txtime.sh fails intermittently on multiple boards and
> linux next and mainline.

This is a time based test, so that is definitely possible. I had to
trade off sensitivity to variance against total running time.

Current tests schedule delivery in the future at 10 msec timescale. It
succeeds if dequeue happens at programmed departure time += 2 msec of
variance (cfg_variance_us).

Note that statements of this kind are not errors and are printed every time:

> # SO_TXTIME ipv6 clock monotonic
> ipv6: clock_monotonic #
> # payloada delay452 expected0 (us)
> delay452: expected0_(us) #

This seems like an error with clockid CLOCK_TAI, which means with qdisc ETF.

> # SO_TXTIME ipv6 clock tai
> ipv6: clock_tai #
> # ./so_txtime read Resource temporarily unavailable
> read: Resource_temporarily #
> #
> : _ #
> # SO_TXTIME ipv6 clock tai
> ipv6: clock_tai #
> # ./so_txtime read Resource temporarily unavailable
> read: Resource_temporarily #

Let me check a few other runs on the dashboard, too.

> [FAIL] 24 selftests net so_txtime.sh # exit=1
> selftests: net_so_txtime.sh [FAIL]
>
> Test run full log,
> https://lkft.validation.linaro.org/scheduler/job/1010545#L1234
>
> Test results comparison link,
> https://qa-reports.linaro.org/lkft/linux-next-oe/tests/kselftest/net_so_txtime.sh
> https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/kselftest/net_so_txtime.sh

This appears to have been flaky from the start, particularly on qemu_arm.

Looking at a few runs..

failing runs exceeds bounds:
https://lkft.validation.linaro.org/scheduler/job/1006586
https://lkft.validation.linaro.org/scheduler/job/1010686
https://lkft.validation.linaro.org/scheduler/job/1010630

"
delay22049: expected20000_(us) #
# ./so_txtime exceeds variance (2000 us)
"

"
delay13700: expected10000_(us) #
# ./so_txtime exceeds variance (2000 us)
"
"
delay29722: expected20000_(us) #
# ./so_txtime exceeds variance (2000 us)
"

These are easy to suppress, by just increasing cfg_variance_us and
optionally also increasing the delivery time scale.

failing run hit the "read: Resource temporarily unavailable" on TAI,
like this report
https://lkft.validation.linaro.org/scheduler/job/1008681

It is not absence of CONFIG_NET_SCH_ETF. That is compiled in (as
module) in these runs, according to the kernel config linked in the
dashboard.

The recv call must return EAGAIN because it reaches the SO_RCVTIMEO
timeout, set to 100 msec. So the packet was lost. I don't immediately
have an explanation for this. Will try to run my own qemu-arm
instance.

Naresh, when you mention "multiple boards" are there specific
microarchitectural details of the hosts that I should take into
account aside from the qemu-arm virtualized environment itself?

passing run detects missing ETF and skips those:
https://lkft.validation.linaro.org/scheduler/job/1006511

That is peculiar, as the dashboard for that run also shows it as available.

Very nice dashboard, btw!
