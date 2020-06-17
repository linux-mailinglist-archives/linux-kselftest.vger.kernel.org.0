Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB011FC7EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 09:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgFQHwz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 03:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgFQHwy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 03:52:54 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849E3C061573
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jun 2020 00:52:54 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id p187so346487vkf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jun 2020 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1mmzbhQaBjppthyO5/4hB8kd4wAzABfaQDbMfagdppM=;
        b=Id3V+ippz6+vczttEvEHLUhnDOn93uBGd8My8PC3gZrQRU7PBsbFK3OB4hlfU2cO0D
         TjAWDAG3Nxe8znmxZL4zWedbqZs1EGigWVvytSZagdFDdrPYNks7VeluGaTlhl1z/6NL
         6L2P1iPdoUB+y7ghO1EFSkd0i8J6SCicmg7tfI1bZihxQpqmCkbAkmJ6lAzClPDwOrmh
         Fk50L9quD8TZHdrQ2tR4PiuNHkzeE528Im1uuu64Y0nVjmF45yQEznKZw/y8FJdSNArK
         sWmWPwzLpoWMYozgnOMb2E4YVUSOl09OkDsni6myBmTHMxNbzoQy22evcWNLOis+Svn+
         YEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1mmzbhQaBjppthyO5/4hB8kd4wAzABfaQDbMfagdppM=;
        b=NpL6eMrCmVEX7lAUuICqO6iAwhrW9lWRDsxTvSYvLeoiSFrGkuVG+1Rk/lNfXVY/kk
         /Vqk5qdNQWkedb0S9p8W5Y5zwnmsX4qovX69XWXO4i2GY5/tp0Fiy7iJigMUsOPd8O3+
         g80zhQKYk48lv5c3FHcpEmzNPdF4w+IOc7XWUH7f7KUelMXdiWvV8ls8da6tJdaYyUbo
         IxszJ86/fGKyZeKscu5af13BeGPaVQFo4LtVnX1fNTGseTYoCCBCR4Gx6cj5vXjd0+f4
         zcxJc8iwyFi8mKgVdQNeybiJbBiX1Zs8frKUvkUu5fbHv+2lvEU0/cCcnNOa1z+UrAK6
         oeJQ==
X-Gm-Message-State: AOAM533KnsRE1QRhs1pCHf1BS83UeXQaoFfMPGznxOUJbbYPk+yvPowb
        MHzBGnAck01sbcxdozVm4Qp8X3yQig409stMQBAfx+4qXs8=
X-Google-Smtp-Source: ABdhPJyNSDiUm/IrqphNcAkdxzjCKQIqzx62Z32xcRz1XdyE7+kbrCFbjHukuu8rGXBiwT/nAQAxC9eMjQQoUZzPWGw=
X-Received: by 2002:a1f:1bd6:: with SMTP id b205mr4570872vkb.29.1592380373419;
 Wed, 17 Jun 2020 00:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAE84iWVZt1N=dRzKENeSsBP0V2ka+_gEyfkrVx_8pO9x2tnBFA@mail.gmail.com>
 <7e3802bd-ad41-23fb-4c3f-c3a8d31cfd63@linuxfoundation.org>
In-Reply-To: <7e3802bd-ad41-23fb-4c3f-c3a8d31cfd63@linuxfoundation.org>
From:   Akira Shibakawa <arabishi900@gmail.com>
Date:   Wed, 17 Jun 2020 16:52:38 +0900
Message-ID: <CAE84iWU5GhbwL5AA6vJDMY8=VBpfJYES8Y4tFqCy_BjnPbZNHg@mail.gmail.com>
Subject: Re: selftests: test stops at step_after_suspend_test
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Shuah.
Thank you for replying.
I tried as non-root, but step_after_suspend_test was skipped.
What should I do to pass step after suspend test ?
Is it need to resume the kernel from Qemu console after suspending?

thanks.

---------------------
TAP version 13
1..1
# selftests: android: run.sh
# ./run.sh: line 3: ./ion_test.sh: not found
not ok 1 selftests: android: run.sh # exit=3D127
TAP version 13
1..2
# selftests: breakpoints: step_after_suspend_test
# TAP version 13
# 1..186
# not ok 1 # SKIP Please run the test as root - Exiting.
not ok 1 selftests: breakpoints: step_after_suspend_test # SKIP
---------------------

2020=E5=B9=B46=E6=9C=8811=E6=97=A5(=E6=9C=A8) 21:02 Shuah Khan <skhan@linux=
foundation.org>:

>
> On 6/11/20 5:21 AM, Akira Shibakawa wrote:
> > Hi, I tried to run kselftest but it stops with logs below.
> >
> > ----------------------------
> > # ./run_kselftest.sh
> > [  126.214906] kselftest: Running tests in android
> > TAP version 13
> > # selftests: android: run.sh
> > 1..1
> > # ./run.sh: line 3: ./ion_test.sh: not found
> > not ok 1 selftests: android: run.sh # exit=3D127
> > [  126.351342] kselftest: Running tests in breakpoints
> > TAP version 13
> > # selftests: breakpoints: step_after_suspend_test
> > 1..2
> > [  126.464495] PM: suspend entry (s2idle)
> > [  126.496441] Filesystems sync: 0.031 seconds
> > [  126.499299] Freezing user space processes ... (elapsed 0.001 seconds=
) done.
> > [  126.501161] OOM killer disabled.
> > [  126.501293] Freezing remaining freezable tasks ... (elapsed 0.001
> > seconds) done.
> > [  126.503018] printk: Suspending console(s) (use no_console_suspend to=
 debug)
> > ----------------------------
>
> Looks like you are running as root. breakpoints has a suspend test and
> suspending the system. Try as non-root.
>
> thanks,
> -- Shuah
