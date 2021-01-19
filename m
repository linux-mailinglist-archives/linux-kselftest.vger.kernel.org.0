Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757482FBDF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 18:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390431AbhASOua (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 09:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731704AbhASKij (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 05:38:39 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F055C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 02:37:58 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gx5so8543928ejb.7
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 02:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LtpYS3fE2cC5QgHZMy5lDBgkuvmbGBZXc8oUExaRobg=;
        b=AVEAcv6erHpJS5IUR9N16OaW5mbpHSuKwXHB016yFyMXO8JGzwgihACuRmGR47q51n
         EMHHMxJmnNtY5a3NtfFcauTpTOH0ANADTCmwYaemis6q7sTvHnBYaoHH+uYZswjsuO/B
         UWmQ4vmYlfJK0lD44U35ZUM03AfHYAonkYRQQlw4bK6zSqGs8zWq+4nx3680wXx+gB9y
         ekiyqIjewfmdo4Rgteu/klRNDwKVLtaQ4IppW7xFexWFFHzEfY8dyBfRtSUNPcLnN03N
         vhhLIFqpra1Dp4KxKDyMOyKv6M9BvEJ6CzGh2Fwi9fXrfVZksEs17VACkAEuX3oxFDN2
         DyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LtpYS3fE2cC5QgHZMy5lDBgkuvmbGBZXc8oUExaRobg=;
        b=j4ehkha5ADaiabXLAKruin3WHecc2I7/L9z6tIVCJ0Qlri5S/Om5QxN8FZOXOGN4ip
         5KLXmTOBJ20Im0kASQqC5BB1NeFjHWvhVR0vsJ/mRC5SOSfvIhmgV5TdmR04Bkh4kyCY
         Fycxr40ZiwmQg0ne0mHqXYj8yOWXZoqoSGy+P8+NZKPbgUKyHpndwcRHWbVXbrIII0yK
         3oFOi/eNkwwWfKsiDQb7Q9yh1j26pzj73KupLSYW0kh3921CQe3HB+2GwuVFt+nq/Vlj
         R5T5ez3l43PQzvUWvNSt5PK+7FLobVYT8u/IYLN2qIvtLBBq9uph4GC2jKbNtY8IGhhT
         M3rQ==
X-Gm-Message-State: AOAM532JHvMQJNnNmDieDKZEa4g9fOBAq65boL4ZppMpW8A+wAdpeTIU
        rhPORqwhVRGkbnCxQfhsTHYUiZ4/1f2U0rvg3gstHw==
X-Google-Smtp-Source: ABdhPJyAozB1lFwLmI79KJn1esgyufm62vTBA3EAVda+QYKmeD4MJINnKWS/8L9U70HoqJJRoGWTHTTlM9s5jgA+QNM=
X-Received: by 2002:a17:906:19c3:: with SMTP id h3mr2521301ejd.429.1611052676821;
 Tue, 19 Jan 2021 02:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20210107025731.226017-1-warthog618@gmail.com> <CACRpkdZf2GhScg=sUG35nA5P6jXH93uuK0Fq_uhz29wBQLHOKQ@mail.gmail.com>
 <20210119003455.GB5169@sol>
In-Reply-To: <20210119003455.GB5169@sol>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 19 Jan 2021 11:37:46 +0100
Message-ID: <CAMpxmJUkFL+w7afS2NKF-xiMR==HVR1Mk8uQm3782DBoG0qneA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] selftests: gpio: rework and port to GPIO uAPI v2
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 19, 2021 at 1:35 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Mon, Jan 18, 2021 at 04:04:51PM +0100, Linus Walleij wrote:
> > On Thu, Jan 7, 2021 at 3:58 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > >   selftests: gpio: rework and simplify test implementation
> > >   selftests: gpio: remove obsolete gpio-mockup-chardev.c
> > >   selftests: remove obsolete build restriction for gpio
> > >   selftests: remove obsolete gpio references from kselftest_deps.sh
> > >   tools: gpio: remove uAPI v1 code no longer used by selftests
> > >   selftests: gpio: port to GPIO uAPI v2
> > >   selftests: gpio: add CONFIG_GPIO_CDEV to config
> >
> > Bartosz I think you can just merge these patches into the GPIO tree, at least
> > I think that is what I have done in the past.
> >
>
> Could you touch up that Fixes tag in patch 1 if you merge v2?
>
> Thanks,
> Kent.

Kent,

This doesn't apply to my for-next branch - there's a conflict in
tools/testing/selftests/gpio/Makefile, could you take a look?

Bartosz
