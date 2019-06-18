Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368B94A0E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2019 14:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfFRMdi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jun 2019 08:33:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41296 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRMdi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jun 2019 08:33:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id 136so9123667lfa.8;
        Tue, 18 Jun 2019 05:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uu5fsfeSKBLjAO6CcaXJptLAJKKL+GmQf7S6qdJonrA=;
        b=dMnwzE9hOEmLTA8AGGWp8pfV4wOkSzwD0oixmCa5AoKUYc+64XQZ49d7GSs00x7sFb
         h7ZOqktF1AjraOXDq2Zknq7DayzydwH5dYOicy4NzIyn80AZ989ngnmDku0Vi1AGWAq5
         eohbW7IZXgprDScXNpknqADwTAQ7zntFhdvwVmCgt5/KMyWbAASR/Pn6es2F3leLlAXf
         TLdk+31xlsdaSztbuT8MDoH0ULCmPtO7kh4zWXk6Qpe0qmCmJvkXnzx52w4V4WyQblGv
         F7kv5j9mnKCjOz+ImuzU3C1aNcVtZkmnYEAFbLEFCrsfIPlhtXRBcvQjiqKOxyFlyZZf
         lwdw==
X-Gm-Message-State: APjAAAUqU2uhddCFI8DOdHG8lSbTDgZURkt1pM1MdDr7beMLWrSxgO/a
        GOGj6Pr0wD6BXdasLVS7Gow9eBfWDQ8wBzuy+eOXLA==
X-Google-Smtp-Source: APXvYqy3CG/KMiJNVvQajIRjle46rTcfCVT6YO7+mcJZq39Lg6zJSQkAHqPqU9bU+uF/n6qUszu159aqvOeo8pX1hpE=
X-Received: by 2002:a19:6e41:: with SMTP id q1mr51131788lfk.20.1560861216107;
 Tue, 18 Jun 2019 05:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190617145204.6810-1-geert+renesas@glider.be> <87muifozfd.fsf@concordia.ellerman.id.au>
In-Reply-To: <87muifozfd.fsf@concordia.ellerman.id.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Jun 2019 14:33:23 +0200
Message-ID: <CAMuHMdUXcT_pNmfwjt5-eWoNJY4vKeH245k2sFFJG=JavUzc-w@mail.gmail.com>
Subject: Re: [PATCH] selftests/powerpc: Add missing newline at end of file
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Michael,

On Tue, Jun 18, 2019 at 2:23 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Geert Uytterhoeven <geert+renesas@glider.be> writes:
> > "git diff" says:
> >
> >     \ No newline at end of file
> >
> > after modifying the file.
>
> Is that a problem?
>
> Just curious because it was presumably me that broke it :)

It looks messy ;-)

> > diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
> > index ba919308fe3052f3..16861ab840f57e90 100644
> > --- a/tools/testing/selftests/powerpc/mm/.gitignore
> > +++ b/tools/testing/selftests/powerpc/mm/.gitignore
> > @@ -3,4 +3,4 @@ subpage_prot
> >  tempfile
> >  prot_sao
> >  segv_errors
> > -wild_bctr
> > \ No newline at end of file
> > +wild_bctr

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
