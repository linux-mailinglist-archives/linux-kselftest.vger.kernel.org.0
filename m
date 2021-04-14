Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8EA35EBB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Apr 2021 06:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbhDNEWt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Apr 2021 00:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhDNEWp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Apr 2021 00:22:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC2EC061756
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Apr 2021 21:22:24 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a25so8534831ljm.11
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Apr 2021 21:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ed47Zap+Jm6v6LkB17Gtao1csFaOpRgN07gt7qnUJFs=;
        b=aZ03d0rLRWSZ5+99OAhdQg0cUYtUxyoyybB5+jqI/KlDHMssOtMZDLCYjXWC8CVAFT
         yPJhKktbHXo1vb2Sz3/aWgOm6vSO6ZfBJlp6fh7pPQEdtm94XBqBwJhHuDpvBMjKaAR/
         0kO1Hn6BZWr/MHyoFno6xXW9eW/JXF3ORSsb0gqSwBWSjirsZ44LMLiEurExACh5w5VA
         GGLD/vDoFUKdUlo3xKh0sAicAV6cyhWnb0MLOjahDD94dqz4ajPKEKahKjOTKhg1R9NS
         JYyfl0ogtQjzeNeTkGMncJnomIRUdFi0ZUkWlTgd6uZ56Sk5+F+Z7Lt0wguzJeiHfmHH
         RjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ed47Zap+Jm6v6LkB17Gtao1csFaOpRgN07gt7qnUJFs=;
        b=sbSQCaowLeLdKReL1q+Hiwchb80+bzCMt1FADp78iqQ4pw+voy1WNG2rOtWjov3R3N
         YKQuZTbiP82KJ4Eg0DcTewxFNJEqXwYGqAa16gcb7Hxcog+V5ypuUUVOPSRGZZBCIiLY
         aJV4xuESZfZOB4udG03PcfAYq0XFlpMbXOJ7AgUjSg4ISqHYTpsIC1PwteeG77MJ6Uhy
         kMcTdaTPSfBeJXdWIaThxq5LdimSSjM9bWmscCX6N6EGRMngwrGm0OLtYqrh28UBufcV
         vN61lrUDaXcoiZ1dcwsi2d6fUYnatTbwKQyu8xA89Id3r/UhTU3u3bXO6y5bcC81KiBb
         REAQ==
X-Gm-Message-State: AOAM531GEUQdAlqVuH+zO1MoESTL2v3vglI1LTnLSOlAPyNspKJz0qKd
        2GXUXi3kZN/ilLBnEavM8TFVIUOv0D+nSrxSHVErTQ==
X-Google-Smtp-Source: ABdhPJxTX3cikTX/eKxutfvDFFK8lRHmedOT93WY406+DV4r4wz+hxULKlxHSrC312/0Bz/cprPVHNdImzdTdcYPXjo=
X-Received: by 2002:a2e:9cc2:: with SMTP id g2mr6473922ljj.245.1618374137046;
 Tue, 13 Apr 2021 21:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210414004518.1116248-1-dlatypov@google.com>
In-Reply-To: <20210414004518.1116248-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 14 Apr 2021 12:22:05 +0800
Message-ID: <CABVgOSm6VY_vVvjryYc8eAvw7QcNuisP1iesdw4s3Td4Dxo1aw@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: kunit: add tips for running KUnit
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 14, 2021 at 8:45 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This is long overdue.
>
> There are several things that aren't nailed down (in-tree
> .kunitconfig's), or partially broken (GCOV on UML), but having them
> documented, warts and all, is better than having nothing.
>
> This covers a bunch of the more recent features
> * kunit_filter_glob
> * kunit.py run --kunitconfig
> * slightly more detail on building tests as modules
> * CONFIG_KUNIT_DEBUGFS
>
> By my count, the only headline features now not mentioned are the KASAN
> integration and KernelCI json output support (kunit.py run --json).
>
> And then it also discusses how to get code coverage reports under UML
> and non-UML since this is a question people have repeatedly asked.
>
> Non-UML coverage collection is no different from normal, but we should
> probably explicitly call this out.
>
> As for UML, I was able to get it working again with two small hacks.*
> E.g. with CONFIG_KUNIT=y && CONFIG_KUNIT_ALL_TESTS=y
>   Overall coverage rate:
>     lines......: 15.1% (18294 of 120776 lines)
>     functions..: 16.8% (1860 of 11050 functions)
>
> Note: this doesn't document --alltests since this is not stable yet.
> Hopefully being run more frequently as part of KernelCI will help...
>
> *Using gcc/gcov-6 and not using uml_abort() in os_dump_core().
> I've documented these hacks in "Notes" but left TODOs for
> brendanhiggins@google.com who tracked down the runtime issue in GCC.
> To be clear: these are not issues specific to KUnit, but rather to UML.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I'm very happy with this now: all my issues with the previous versions
are addressed. I'm particularly excited to have code coverage
documented somewhere.

Assuming Brendan's happy with the TODOs being there, I think this is
ready to go.

I also built this with Sphinx and gave it a quick look, and it all
looks good there as well.

Therefore, this is:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
