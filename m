Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E175569279
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 21:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiGFTQC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 15:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiGFTQB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 15:16:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EC6248CD
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 12:16:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id fd6so20471096edb.5
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DaD3IQOOIYs922HyFPt3gDuoj5LcEWxvvwoxeXt8fJI=;
        b=ZeMq41JUS362BA1pO+hs1g2s3LKOhlzv1jrk65JQSknyJksYY+pxTiKeIET5RZQJVf
         FK/VdDQZj/Up11J0mvYVWS3uVPxXDvB0D4JJHSbJz4J4cu/dOcPZmwqkjrv0BSyXHNgD
         Z1nmWVoA/X0QrsJG7l6gPcmWiGNa3CRKF8AdAspTGM46JtQiAflLEkKM3WwhKd0C2BEP
         AFmrQ7oLwyo8CFCFzNyKtUzsNUzavZGVATpXGfdikHQDIDXl9dAKWkpMQzOmrK+PN2Yr
         7yCXnKnSLgptGiXgNa4EhubV4krJ6TU1oL40NRaWTo3fzZ2hizJbS0Z41hkm6ZZCYDJV
         WIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaD3IQOOIYs922HyFPt3gDuoj5LcEWxvvwoxeXt8fJI=;
        b=J6R3em5X7YOLyNYH/QNWUubJT91EKLKiQRZKQ35sjhNAD5FNlt6/GU2I+b5pBb/kxv
         omoZiNl6GELcJXv8PSP3kjojkwvR1GWJhrJrF+GpTwc2vvcifUKkJxv00ushAJvhYbch
         7yeZjDtOQKWKTgasSsShwJeOhfwBWxqlG4IS0Lc4E81P/l/LXZ8uPhkR6coRyjGhn/A5
         LGvXLzmAz/TmOX7yi7ec8LjNy23KMCJg7tOhEpAY7eNHisu2VmBjagnesu9IPMY2ttLf
         zW7GtRUF32D3bF+iqJuwGDit749eEK1z+5eetE1JA38RoY5D6R6KayzOehhfSuueaUkz
         kYgg==
X-Gm-Message-State: AJIora8wSYCGm1tCoF6vF+DVt7ddgIcibnY1VoVicLuu9jcurAzzu6gH
        N9ZsroanDxRMultjlodQ/0bzvjFIqxdWbRvq5V3Lkg==
X-Google-Smtp-Source: AGRyM1sOey+POJ+Y5USlhkWKMWJsVPhoCEdbACkBANOF7Hi0zw3wy4fWP4WiuCsaJTBBnj0TsyDNQryCVOXBic+/9KE=
X-Received: by 2002:a05:6402:4488:b0:43a:7b6e:4b04 with SMTP id
 er8-20020a056402448800b0043a7b6e4b04mr12750837edb.202.1657134959282; Wed, 06
 Jul 2022 12:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220516194730.1546328-1-dlatypov@google.com> <20220516194730.1546328-3-dlatypov@google.com>
 <CABVgOSn1Hq6AX-+=+m_uLwKne3wuUadrsE=uPRsgYH3+TFBEuA@mail.gmail.com> <CAGS_qxqJNpoZkv0==q_yMTuWzATTtUsXw3o1ZOR=n+fjVS+ghA@mail.gmail.com>
In-Reply-To: <CAGS_qxqJNpoZkv0==q_yMTuWzATTtUsXw3o1ZOR=n+fjVS+ghA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 15:15:47 -0400
Message-ID: <CAFd5g44=q40gbcbRTpfCEWVPAjU442=4c17pj4C3as5fmfg45w@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: tool: refactoring printing logic into kunit_printer.py
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 18, 2022 at 11:51 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Wed, May 18, 2022 at 12:48 AM David Gow <davidgow@google.com> wrote:
> >
> > On Tue, May 17, 2022 at 3:48 AM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > Context:
> > > * kunit_kernel.py is importing kunit_parser.py just to use the
> > >   print_with_timestamp() function
> > > * the parser is directly printing to stdout, which will become an issue
> > >   if we ever try to run multiple kernels in parallel
> > >
> > > This patch introduces a kunit_printer.py file and migrates callers of
> > > kunit_parser.print_with_timestamp() to call
> > > kunit_printer.stdout.print_with_timestamp() instead.
> > >
> > > Future changes:
> > > If we want to support showing results for parallel runs, we could then
> > > create new Printer's that don't directly write to stdout and refactor
> > > the code to pass around these Printer objects.
> > >
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > ---
> >
> > I agree that this will be useful down the line, as running multiple
> > kernels in parallel is definitely something which could be useful. I
> > know the original idea for that was to have multiple parsers, and just
> > to combine the results they gave after the fact, but given that
> > incremental output is so useful, I agree that this is the better path.
> >
> > My only super-minor gripe (which I can live with) is that importing
> > 'stdout' and using it as 'stdout.print_with_timestamp()' is a little
> > confusing: I'd've assumed an stdout variable imported into the global
> > namespace was sys.stdout, not a wrapper. Explicitly using
> > kunit_printer.stdout would be a little clearer, IMO. Up to you,
> > though.
>
> I was initially writing it that way, but then the following pattern
> got super long
>
> Old:
> print_with_timestamp(red("[ERROR]") + " some error")
>
> New options:
> stdout.print_with_timestamp(stdout.red("[ERROR]") + " some error")

Kind of late to mention this (and we might have already talked about
this offline), but I am fine with what you have done here with the
stdout.

My initial reaction was similar to David's, but after thinking about
it, I don't think it is prone to misuse, and I think it is clear - and
allows for easy refactoring in the future.

> kunit_printer.stdout.print_with_timestamp(kunit_printer.stdout.red("[ERROR]")
> + " some error")
>
> But yeah, I see what you mean about potential confusion with sys.stdout.
> I couldn't think of a better (while still short name) for it.
> E.g. "default_printer", "stdout_printer", etc.
>
> FWIW, I have a local patch that drops 99% of the direct uses of
> kunit_printer.stdout in the parser and passes around buffered
> printers.
> And in that case, the use of stdout becomes small enough that we could
> do `kunit_printer.stdout` w/o as much pain/noise.
>
> But I have no plans of sending that out until we need it, since it
> muddies up the code quite a bit.
> And I don't have a clear idea of what the interface to parallel
> testing should look like, so that day is still far off.
