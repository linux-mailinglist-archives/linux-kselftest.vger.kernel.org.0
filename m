Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21BD219DC70
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Apr 2020 19:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgDCRLW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Apr 2020 13:11:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36918 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgDCRLW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Apr 2020 13:11:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id u65so3798362pfb.4
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Apr 2020 10:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Do8qIdF6vQT1e9Pt11DpfMfF7NFSyvJ9YAoinVPJ4B0=;
        b=DyKteckeKbLQOHNxRvjiNlOfjdsr1jQqgBETM8ffw0t5LACA/f7nbtTlfVqAU361A8
         TlhaFiJ62NeeuXaXLHZ22PCfK5Na6gFRwfsFj3geWBmfSR6IcUDb04e9bmoJ3GU0DfmI
         FFadDtjoTTt/2L2Fk/QMV7ygzbBXCmepfSUGHdywPKQgCzg+01p8LqL4yb8DTyq6RnNJ
         grjPD3zunmVFy8bwFXFqR/qFoBCdaJbK8gOk65d+iOVPDODB+N7IJxBXBqUhlbSvZ96T
         vzzDATVU1QI0gcBgjfciFIGSJdyeKX8s42+L9gvQkEuvIg7/B0/LB8InfQDg630DiPtG
         358Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Do8qIdF6vQT1e9Pt11DpfMfF7NFSyvJ9YAoinVPJ4B0=;
        b=YWhC/Kei1+JolacH9/azPRvbwaFpp0Y+uRxJpk7mhz9HTFnBXaDWPaHXhNQIKnV+Bu
         N7nTcwa56cRCQ/yV2Ids+auM0uWTGeeQQJsF0mqS0g19zlxsmXH8Kz8rf7O+94JyIqTK
         0l1osa8WPrNx5qAMcrfEJqxbKOolYvzyOZu45Klr3gd3h539RBifu3aX4AehLiZOlFp2
         R2zBbikZJQjhAqdBF55pFLygxlh7+Pb1AfSPSLXiouLCFOaSTEGaEgtaL8c6WGsvz2QI
         LSKrs1LE9f2M3H1Zy00v9uUs4gfROQseCPdLN3XZNW7X2fgoaUYf+cSf/Od9uxAwqQwZ
         bTBA==
X-Gm-Message-State: AGi0PuZSjwbHcM0xxObs4tnOJpk8LOyWujzyIHc5F8rR4odhozHFrj6J
        Ov9DBfNuNgVf71ueoVsKUFmwKE8bHh6tFqYZqvTIUg==
X-Google-Smtp-Source: APiQypI7UauSw1zmt3GWDSv0euHCVWL7ySGTXKz+bk1VaTUXvcO5W9wbt8hwUVo/DiAbuh0tRYCoyUszY50nCC6+t00=
X-Received: by 2002:a63:d049:: with SMTP id s9mr8754031pgi.384.1585933881177;
 Fri, 03 Apr 2020 10:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200402204639.161637-1-trishalfonso@google.com> <20200402204639.161637-4-trishalfonso@google.com>
In-Reply-To: <20200402204639.161637-4-trishalfonso@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 3 Apr 2020 10:11:10 -0700
Message-ID: <CAFd5g45owC+D+K4RuppmyTJ+d+NGRL1CpuciXwXYvmtBfXnXYg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] Add KUnit Struct to Current Task
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     David Gow <davidgow@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 2, 2020 at 1:46 PM 'Patricia Alfonso' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> In order to integrate debugging tools like KASAN into the KUnit
> framework, add KUnit struct to the current task to keep track of the
> current KUnit test.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
