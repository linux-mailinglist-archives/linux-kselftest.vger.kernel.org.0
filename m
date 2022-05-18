Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D055852BF2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 18:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbiERPv0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 11:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239627AbiERPvD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 11:51:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB9690CEE
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 08:51:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c10so3600343edr.2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 08:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqJvUd681sz/Rpj3bROR5w8jszwa8bJSwwyEmSegot4=;
        b=cPb1tJ1h/ExxwGcfPisCk9cYxVkxu4zTnNyhm8MU3HLzkkedyyXQHCZcS+39qSREQW
         bZQblEk4puk1CLb2hzJKwRCkaqKnSkOZhhO9SsNZwlh4fSWbl2yIL4PeyF/w48jOyDVb
         sJan6jKTe8TlxVRFkIrZ62DO3vNuYmkk+32E1Do9LyRqkO/ws+tYsD0PxWGzCzT1Yfv+
         d1nRUuirNV3+t0eF2vwIgKY1izNmGxkJiTPA/4/TOAbCMKd/7gUj02TQvyNm7xhMGOQP
         ACm7bA4BBpmmam8X+adli4IzDzD3AjeKxNzRue4T9B/2PJC/mByNGKw9EBAuh2EC/ONI
         zkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqJvUd681sz/Rpj3bROR5w8jszwa8bJSwwyEmSegot4=;
        b=C6MDFRtQVyrtuW3QLNwdQ288TjI9aw7wvw7BjzdofFhPzElJc7LqPx5u4b+BscP2pl
         ounOTlU+YLFG3aPTIzAI0FBkNP7ahjdLkKN3GEPuVWw0a45iVriCe1DsU0erg6cmsw8U
         4M4PkRDJ2HPbnnbJZItrJJKr5zYxxnQBOHr7q49VEimYoLEBNWfJ+eplfroKTcyTSuvI
         jzsjLCisDqbHSykuadpK3pKsb4Brt64moTt+75BQ8fNbbHxuI/lPU7N03Ls8VcITXSit
         DbqsPLKusMQaotrcOlBqWvl388owQ9httnNcEdmD8UAlCI+Di8EsHK7GzFbvp80RFEh+
         o9cA==
X-Gm-Message-State: AOAM531RYGbUmmxAbXKzp5muvGn/K9HKd0E/28Z+4TtJ8ypKTrpHqf5G
        29weGrcKanfN8prho/HYULZGpLVFQ4PY3UyLJoh24A==
X-Google-Smtp-Source: ABdhPJz9BjdO5Rzu/CX+M/2TdhMlwR3/Hv2vNRt9DPqIBxsRJeE1O37QbIGWPl+oOoM0PQiWjNO7ghXa3Ggvq6LCJUk=
X-Received: by 2002:aa7:cb48:0:b0:42a:addf:4bf1 with SMTP id
 w8-20020aa7cb48000000b0042aaddf4bf1mr392612edt.283.1652889059935; Wed, 18 May
 2022 08:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220516194730.1546328-1-dlatypov@google.com> <20220516194730.1546328-3-dlatypov@google.com>
 <CABVgOSn1Hq6AX-+=+m_uLwKne3wuUadrsE=uPRsgYH3+TFBEuA@mail.gmail.com>
In-Reply-To: <CABVgOSn1Hq6AX-+=+m_uLwKne3wuUadrsE=uPRsgYH3+TFBEuA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 18 May 2022 08:50:48 -0700
Message-ID: <CAGS_qxqJNpoZkv0==q_yMTuWzATTtUsXw3o1ZOR=n+fjVS+ghA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: tool: refactoring printing logic into kunit_printer.py
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 18, 2022 at 12:48 AM David Gow <davidgow@google.com> wrote:
>
> On Tue, May 17, 2022 at 3:48 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Context:
> > * kunit_kernel.py is importing kunit_parser.py just to use the
> >   print_with_timestamp() function
> > * the parser is directly printing to stdout, which will become an issue
> >   if we ever try to run multiple kernels in parallel
> >
> > This patch introduces a kunit_printer.py file and migrates callers of
> > kunit_parser.print_with_timestamp() to call
> > kunit_printer.stdout.print_with_timestamp() instead.
> >
> > Future changes:
> > If we want to support showing results for parallel runs, we could then
> > create new Printer's that don't directly write to stdout and refactor
> > the code to pass around these Printer objects.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> I agree that this will be useful down the line, as running multiple
> kernels in parallel is definitely something which could be useful. I
> know the original idea for that was to have multiple parsers, and just
> to combine the results they gave after the fact, but given that
> incremental output is so useful, I agree that this is the better path.
>
> My only super-minor gripe (which I can live with) is that importing
> 'stdout' and using it as 'stdout.print_with_timestamp()' is a little
> confusing: I'd've assumed an stdout variable imported into the global
> namespace was sys.stdout, not a wrapper. Explicitly using
> kunit_printer.stdout would be a little clearer, IMO. Up to you,
> though.

I was initially writing it that way, but then the following pattern
got super long

Old:
print_with_timestamp(red("[ERROR]") + " some error")

New options:
stdout.print_with_timestamp(stdout.red("[ERROR]") + " some error")
kunit_printer.stdout.print_with_timestamp(kunit_printer.stdout.red("[ERROR]")
+ " some error")

But yeah, I see what you mean about potential confusion with sys.stdout.
I couldn't think of a better (while still short name) for it.
E.g. "default_printer", "stdout_printer", etc.

FWIW, I have a local patch that drops 99% of the direct uses of
kunit_printer.stdout in the parser and passes around buffered
printers.
And in that case, the use of stdout becomes small enough that we could
do `kunit_printer.stdout` w/o as much pain/noise.

But I have no plans of sending that out until we need it, since it
muddies up the code quite a bit.
And I don't have a clear idea of what the interface to parallel
testing should look like, so that day is still far off.
