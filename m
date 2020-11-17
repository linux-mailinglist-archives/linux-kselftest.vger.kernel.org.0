Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FC32B5CB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 11:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgKQKQh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 05:16:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42665 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQKQh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 05:16:37 -0500
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1key2N-0003xA-I2
        for linux-kselftest@vger.kernel.org; Tue, 17 Nov 2020 10:16:35 +0000
Received: by mail-lj1-f199.google.com with SMTP id g19so9966687ljn.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Nov 2020 02:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEdsHRGTcFavudpXhNXpa2iKk6bFAMTvjLBIV8dbsko=;
        b=FifEXMuBMwHU0rPbZP7MTjjuSEp33fWChoFkTvwHn7lWT0vwOOVEQr6P17bQHx85aY
         E9RhaI6FJnVDZq4HD/JqQmkuh/FPGPSykwDj0kyf7SFdGKTHTwGjtYvyhzJURpHic7Qn
         Yx71+H+AF5g21/h4eoHdjxJ4QiTcayhxRvsdnuwWmn+gxaDdbgAlJmUD+boM4nNm19Vt
         OZ7L5TA9tYAxPy0QswEp+XLsIQtAQmVBYSPg9K7nTgNpIcyKUiQ8Tbn42lILdr1sDaZU
         8HZq6APdQm4EPIi3/YVGPVQMqUcOgQ7Xd6eAl/fECA/9km/dIGv0sjIY5VvUjWvZaRX+
         8CJQ==
X-Gm-Message-State: AOAM530WtoN0yJhf6hNbsB7K1f6Oltk7yZaQMXB8F278wiqADSBJnwcR
        T/QYtJ8sdsjY987Kp5Qhh0dln914OogmYK6cb9MJ+idAO2ZiHlYTNj0r7gaJEeYjm7WUtIzCPz3
        m1kAhYt5ut5YELnkyNAPDkSeg3yKWxGZqa56R1GXG+FQUyhLjMP0odiMclibX
X-Received: by 2002:a19:3ce:: with SMTP id 197mr1726606lfd.364.1605608194834;
        Tue, 17 Nov 2020 02:16:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGKNQl8F+w9d73yJM5THTTlbfEgwgYYrzLhz1BoumzV9CXFZOZwDEB9lFaKd0BVNBiA2vGw9Gr5K3Xs8pfgq4=
X-Received: by 2002:a19:3ce:: with SMTP id 197mr1726593lfd.364.1605608194484;
 Tue, 17 Nov 2020 02:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20201023024539.9512-1-po-hsu.lin@canonical.com>
In-Reply-To: <20201023024539.9512-1-po-hsu.lin@canonical.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Tue, 17 Nov 2020 18:16:23 +0800
Message-ID: <CAMy_GT-FNXa+fUjD4wM_8WAgLN7V8O=-E6n5jFULon74ejm=aQ@mail.gmail.com>
Subject: Re: [PATCHv2] selftests/powerpc/eeh: disable kselftest timeout
 setting for eeh-basic
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     benh@kernel.crashing.org, shuah <shuah@kernel.org>, mbenes@suse.cz,
        joe.lawrence@redhat.com, mathieu.desnoyers@efficios.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,
any update on this patch?
Or do we want to increase the timeout here?
Thanks!

On Fri, Oct 23, 2020 at 10:45 AM Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
>
> The eeh-basic test got its own 60 seconds timeout (defined in commit
> 414f50434aa2 "selftests/eeh: Bump EEH wait time to 60s") per breakable
> device.
>
> And we have discovered that the number of breakable devices varies
> on different hardware. The device recovery time ranges from 0 to 35
> seconds. In our test pool it will take about 30 seconds to run on a
> Power8 system that with 5 breakable devices, 60 seconds to run on a
> Power9 system that with 4 breakable devices.
>
> Extend the timeout setting in the kselftest framework to 5 minutes
> to give it a chance to finish.
>
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  tools/testing/selftests/powerpc/eeh/Makefile | 2 +-
>  tools/testing/selftests/powerpc/eeh/settings | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/eeh/settings
>
> diff --git a/tools/testing/selftests/powerpc/eeh/Makefile b/tools/testing/selftests/powerpc/eeh/Makefile
> index b397bab..ae963eb 100644
> --- a/tools/testing/selftests/powerpc/eeh/Makefile
> +++ b/tools/testing/selftests/powerpc/eeh/Makefile
> @@ -3,7 +3,7 @@ noarg:
>         $(MAKE) -C ../
>
>  TEST_PROGS := eeh-basic.sh
> -TEST_FILES := eeh-functions.sh
> +TEST_FILES := eeh-functions.sh settings
>
>  top_srcdir = ../../../../..
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/powerpc/eeh/settings b/tools/testing/selftests/powerpc/eeh/settings
> new file mode 100644
> index 0000000..694d707
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/eeh/settings
> @@ -0,0 +1 @@
> +timeout=300
> --
> 2.7.4
>
