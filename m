Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CCE29688B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 04:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374707AbgJWChT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 22:37:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50016 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2902339AbgJWChT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 22:37:19 -0400
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kVmxB-00069c-9k
        for linux-kselftest@vger.kernel.org; Fri, 23 Oct 2020 02:37:17 +0000
Received: by mail-lf1-f71.google.com with SMTP id q24so16504lfc.9
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Oct 2020 19:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kL6r0YME8JPJ77vl3uRAXuFWZJrygKvOlR68AHYrrHU=;
        b=amIpPucD0Z+7wiibzW2Omf0CLdQ7ZeFV0stMVPtiB1jkJt7lDqcVI53jrHjsdV7Cwz
         X7IlISX3ZdUCYyO+sqmjSmPuZYsUjBHKisrhzdmxSvHVSxTrUUH2acQjRN50liLmnzsz
         azvwI3UYVyd5Y6Bfa5AN9y7NhIqYHnPmprnoPxl7ZdKbqsayM8aTVTZDdjZ/Xgags7SF
         Lb12QASphbArD9r117yyI+OO2U7RUjKxhDex03ekhExm3kc46/M/SsUtUoF1c8Jzf1+a
         Vb4i3TZ3IrZ4j586vO+2JdGsLAwtQklBAOWuxsLoPBCX97syJmCuq70zoXKMWWUp2DQT
         ZrtA==
X-Gm-Message-State: AOAM531wVsgNj8+D6kl20z4vZ9YHeQQ/FL3mhq9c0bNfTTbnulGTV9OV
        B5m9iOKMJO7oBO4nBWq5j+xOStsDyb3CTeySxPX7EAgyfJPGmO7KwY/EpPIeLoc4mKnaMtrgEw9
        w8Fn7LDt6NOcvyOhuAqewZDhYMI63yDo1ALDRJ3dwJT5A3HyRkpmf7zefns37
X-Received: by 2002:a2e:b610:: with SMTP id r16mr2009852ljn.145.1603420636642;
        Thu, 22 Oct 2020 19:37:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRfCpmV1tRBi4tQH9ePl5vBE3c7CunlQdQpCfkUSbLWC4WSzKxov2iLonbzZOeUBfANDvUahwOcsIODRjVAck=
X-Received: by 2002:a2e:b610:: with SMTP id r16mr2009846ljn.145.1603420636341;
 Thu, 22 Oct 2020 19:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201022083616.41666-1-po-hsu.lin@canonical.com> <87a6wdy9si.fsf@mpe.ellerman.id.au>
In-Reply-To: <87a6wdy9si.fsf@mpe.ellerman.id.au>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Fri, 23 Oct 2020 10:37:05 +0800
Message-ID: <CAMy_GT8pMJ4So3zHLLUR8EeL8MfUbv2zTv48p8GXUW3Dm_bFOA@mail.gmail.com>
Subject: Re: [PATCH] selftests/powerpc/eeh: disable kselftest timeout setting
 for eeh-basic
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, benh@kernel.crashing.org,
        shuah <shuah@kernel.org>, mbenes@suse.cz,
        joe.lawrence@redhat.com, mathieu.desnoyers@efficios.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 23, 2020 at 10:07 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Po-Hsu Lin <po-hsu.lin@canonical.com> writes:
> > The eeh-basic test got its own 60 seconds timeout (defined in commit
> > 414f50434aa2 "selftests/eeh: Bump EEH wait time to 60s") per breakable
> > device.
> >
> > And we have discovered that the number of breakable devices varies
> > on different hardware. The device recovery time ranges from 0 to 35
> > seconds. In our test pool it will take about 30 seconds to run on a
> > Power8 system that with 5 breakable devices, 60 seconds to run on a
> > Power9 system that with 4 breakable devices.
> >
> > Thus it's better to disable the default 45 seconds timeout setting in
> > the kselftest framework to give it a chance to finish. And let the
> > test to take care of the timeout control.
>
> I'd prefer if we still had some timeout, maybe 5 or 10 minutes? Just in
> case the test goes completely bonkers.
>
OK, let's go for 5 minutes.
Will send V2 later.
Thanks for your suggestion!

> cheers
>
> > diff --git a/tools/testing/selftests/powerpc/eeh/Makefile b/tools/testing/selftests/powerpc/eeh/Makefile
> > index b397bab..ae963eb 100644
> > --- a/tools/testing/selftests/powerpc/eeh/Makefile
> > +++ b/tools/testing/selftests/powerpc/eeh/Makefile
> > @@ -3,7 +3,7 @@ noarg:
> >       $(MAKE) -C ../
> >
> >  TEST_PROGS := eeh-basic.sh
> > -TEST_FILES := eeh-functions.sh
> > +TEST_FILES := eeh-functions.sh settings
> >
> >  top_srcdir = ../../../../..
> >  include ../../lib.mk
> > diff --git a/tools/testing/selftests/powerpc/eeh/settings b/tools/testing/selftests/powerpc/eeh/settings
> > new file mode 100644
> > index 0000000..e7b9417
> > --- /dev/null
> > +++ b/tools/testing/selftests/powerpc/eeh/settings
> > @@ -0,0 +1 @@
> > +timeout=0
> > --
> > 2.7.4
