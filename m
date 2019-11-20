Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9616E103450
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2019 07:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfKTGdB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Nov 2019 01:33:01 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34265 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfKTGdA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Nov 2019 01:33:00 -0500
Received: by mail-lf1-f66.google.com with SMTP id l28so9710911lfj.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2019 22:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0IDyZkbtbPsofExaZyTr8bo/i/DLYlCIy4Kxh6/p4mo=;
        b=tfNz7klYGx3/T8c/sG3BjN25uSxe9r0/EiM8wWNnfr0XrpRrPVflDF7GX21w1R5Rcb
         seQ0VJ3+VODqSed608N/TyIVMsp/wPpgQai7Gk58ncg+kkfjVKPQznBExpdD73Qslv1c
         O+oh0On/RETmcjQgkeWTCjJMKBTewfUMwFIAIO9OuRHjevxDYN98rcTBwQjXVMf/T86t
         Ea4E2vw3fN6iH+2fv2QsmT+GFNpCW1hpp2qhOTsZ6J9PyPmQ7mOWsA4Z89fB149Htpnj
         HjGNIe5fuKJhfQIPZPj3U+Cw5WeRV2CjvnaPD/adgHoKH7nm2uaeC3ZYciGzdfKJI/NY
         Q7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IDyZkbtbPsofExaZyTr8bo/i/DLYlCIy4Kxh6/p4mo=;
        b=I2ZLEkiQZ05YnQoB/ULQn3GX8tNo7RMtYAJ1EGRuyxRc3uTRrA/SF8YWLfh6PFGNHd
         vrEvhn38g6TBMaam0RmStlB6V8YMf8dzANh3mm5Rkeghuq/rYGgnACCH5ZYMKb87SaV1
         kOV82dysoBPoaLJTT9pbsV38b/MT27N9zHUw0BvJcVddIDVref4zYCWMSXQBCwRQVfEU
         AwEPfojojmHdLlWlHTN9KPthn8h7+DCvX2wUipStIlb/rOLWAfwzG0wcEaHWpfGNS1Rp
         qUfcd7lihsioFaOwq1iidQZTvhPlK0jx+KUCrZR6P40SejCmF92pURBpItNag+/pTxqd
         xNJQ==
X-Gm-Message-State: APjAAAVgUFGhcmizmTZBRMxczc3mXcGcp6FFTQmgdcjQ9qvlFHldVU5V
        6IAO4MpGwFCF+thpKUHsWryJIpKIaaiW5jEfkQe2zA==
X-Google-Smtp-Source: APXvYqz+AxPaUH+ftNhZvRr23V9kyQUIFJmZ7VGaL5adTq+g4kgW6LhOkHBcQsm6DP9hz+9mmT3nRpJLhMOX4KYgza0=
X-Received: by 2002:ac2:4831:: with SMTP id 17mr1310851lft.67.1574231577791;
 Tue, 19 Nov 2019 22:32:57 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsmZOf9zgo5dy2_HfPPK-0tBYfCXpZy2DneFOeiJfN=_g@mail.gmail.com>
 <CA+FuTSd3t9fju3seZQ0OMTxSkPtysG88stMoqMAV4G1Mj3wsVA@mail.gmail.com>
In-Reply-To: <CA+FuTSd3t9fju3seZQ0OMTxSkPtysG88stMoqMAV4G1Mj3wsVA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 20 Nov 2019 12:02:45 +0530
Message-ID: <CA+G9fYu=GXCZTQHU2kX0yoUxPgWkKVF44NJhadTP07uHF9St3g@mail.gmail.com>
Subject: Re: selftest/net: so_txtime.sh fails intermittently - read Resource
 temporarily unavailable
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
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

On Fri, 15 Nov 2019 at 21:52, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Nov 14, 2019 at 3:47 AM Naresh Kamboju

> This appears to have been flaky from the start, particularly on qemu_arm.

This is because of emulating 2 CPU.
I am gonna change this to emulate 4 CPU for qemu_arm.

>
> Looking at a few runs..
>
> failing runs exceeds bounds:
> https://lkft.validation.linaro.org/scheduler/job/1006586
...
> delay29722: expected20000_(us) #
> # ./so_txtime exceeds variance (2000 us)
> "
> These are easy to suppress, by just increasing cfg_variance_us and
> optionally also increasing the delivery time scale.

Alright !
The variance is 2000.
static int cfg_variance_us = 2000

> Naresh, when you mention "multiple boards" are there specific
> microarchitectural details of the hosts that I should take into
> account aside from the qemu-arm virtualized environment itself?

The easy to reproduce way is running 32-bit kernel and rootfs on
x86_64 machine.

arm32 bit beagleboard x15 device.

qemu-arm command line,
qemu-system-aarch64 -cpu host,aarch64=off -machine virt-2.10,accel=kvm
-nographic -net nic,model=virtio,macaddr=BA:DD:AD:CC:09:02 -net tap -m
2048 -monitor none -kernel zImage --append "console=ttyAMA0
root=/dev/vda rw" -drive
format=raw,file=rpb-console-image-lkft-am57xx-evm-20191112073604-644.rootfs.ext4,if=virtio
-m 4096 -smp 2 -nographic

> Very nice dashboard, btw!

Thanks for your valuable feedback. Great to hear this :-)

- Naresh
