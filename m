Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E113746C2A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 10:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjGDIk4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 04:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjGDIkz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 04:40:55 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D28A0;
        Tue,  4 Jul 2023 01:40:54 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-570114e1feaso66664757b3.3;
        Tue, 04 Jul 2023 01:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688460053; x=1691052053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BqhtSnI02gvi1wWQrAhDcGy8676tF2MY5Pe+CVYtcs=;
        b=R5gc2tOD631KoVjqf3EM/tUwI1mLUs/BxxoTVIFUchemKgdLdwplHvgLnaRNAUwsFT
         j0knRWArLj8OMqg7sctYRTy+I4gK2uxlctZpiR+mZ7M7FP5z+3Gj7o4jgNp0jENLH41+
         p+O2iqRKeTNv4bKEMnxRsZt57huRl9TrOj157BDiwQbDOojb7OxWFTXugvrHNbmbb7P0
         nfd6BKoU+7p5nQg5qy2KGdWYFDCELl0875R36rN2hgBfZQMiUuhwAFgN2Vst0wWmMRWX
         S4C0ZHMLftvpOOdkTQZAqiDr9MxNVAvhiJzQVoHfYZ0RqaPpSaIXD2adjWHOon8ACu+/
         6lQw==
X-Gm-Message-State: ABy/qLby89SDtGJP97K1y1lTSaSx3CJ5x+jUXUxsWlYq7/eUjqY4dsMw
        5sF5vdr1IuVXlDSgJitQYWmU2gpFrdWJ9A==
X-Google-Smtp-Source: APBJJlEJ3tHQbiGsFPUg00a0JSoEuo8MZEv/6/tSrT7X4WfrFD8OXWsG4GKBfllBhikRiQxVULGDNg==
X-Received: by 2002:a81:840f:0:b0:576:9e6a:67f9 with SMTP id u15-20020a81840f000000b005769e6a67f9mr12575647ywf.48.1688460052956;
        Tue, 04 Jul 2023 01:40:52 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id s66-20020a817745000000b00577637434e3sm2197896ywc.73.2023.07.04.01.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 01:40:52 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-570114e1feaso66664487b3.3;
        Tue, 04 Jul 2023 01:40:52 -0700 (PDT)
X-Received: by 2002:a25:4182:0:b0:c5c:616:39cb with SMTP id
 o124-20020a254182000000b00c5c061639cbmr1561887yba.14.1688460052140; Tue, 04
 Jul 2023 01:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <168503771547.404.3649540312110626967.tip-bot2@tip-bot2> <CAMuHMdWs5zXW8xRQCgNHJSeFbJTE6JMjO-T1fi9dgP3ugnWhfQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWs5zXW8xRQCgNHJSeFbJTE6JMjO-T1fi9dgP3ugnWhfQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jul 2023 10:40:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWyMU9x0rgoWxhu4-qH=QmgjnE1DfrVVYAcKOaN3Cc1wg@mail.gmail.com>
Message-ID: <CAMuHMdWyMU9x0rgoWxhu4-qH=QmgjnE1DfrVVYAcKOaN3Cc1wg@mail.gmail.com>
Subject: Re: [tip: x86/misc] x86/csum: Improve performance of `csum_partial`
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CC linux-m68k

On Sun, Jul 2, 2023 at 5:19 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, May 25, 2023 at 8:04 PM tip-bot2 for Noah Goldstein
> <tip-bot2@linutronix.de> wrote:
> > The following commit has been merged into the x86/misc branch of tip:
> >
> > Commit-ID:     688eb8191b475db5acfd48634600b04fd3dda9ad
> > Gitweb:        https://git.kernel.org/tip/688eb8191b475db5acfd48634600b04fd3dda9ad
> > Author:        Noah Goldstein <goldstein.w.n@gmail.com>
> > AuthorDate:    Wed, 10 May 2023 20:10:02 -05:00
> > Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> > CommitterDate: Thu, 25 May 2023 10:55:18 -07:00
> >
> > x86/csum: Improve performance of `csum_partial`
> >
> > 1) Add special case for len == 40 as that is the hottest value. The
> >    nets a ~8-9% latency improvement and a ~30% throughput improvement
> >    in the len == 40 case.
> >
> > 2) Use multiple accumulators in the 64-byte loop. This dramatically
> >    improves ILP and results in up to a 40% latency/throughput
> >    improvement (better for more iterations).
> >
> > Results from benchmarking on Icelake. Times measured with rdtsc()
> >  len   lat_new   lat_old      r    tput_new  tput_old      r
> >    8      3.58      3.47  1.032        3.58      3.51  1.021
> >   16      4.14      4.02  1.028        3.96      3.78  1.046
> >   24      4.99      5.03  0.992        4.23      4.03  1.050
> >   32      5.09      5.08  1.001        4.68      4.47  1.048
> >   40      5.57      6.08  0.916        3.05      4.43  0.690
> >   48      6.65      6.63  1.003        4.97      4.69  1.059
> >   56      7.74      7.72  1.003        5.22      4.95  1.055
> >   64      6.65      7.22  0.921        6.38      6.42  0.994
> >   96      9.43      9.96  0.946        7.46      7.54  0.990
> >  128      9.39     12.15  0.773        8.90      8.79  1.012
> >  200     12.65     18.08  0.699       11.63     11.60  1.002
> >  272     15.82     23.37  0.677       14.43     14.35  1.005
> >  440     24.12     36.43  0.662       21.57     22.69  0.951
> >  952     46.20     74.01  0.624       42.98     53.12  0.809
> > 1024     47.12     78.24  0.602       46.36     58.83  0.788
> > 1552     72.01    117.30  0.614       71.92     96.78  0.743
> > 2048     93.07    153.25  0.607       93.28    137.20  0.680
> > 2600    114.73    194.30  0.590      114.28    179.32  0.637
> > 3608    156.34    268.41  0.582      154.97    254.02  0.610
> > 4096    175.01    304.03  0.576      175.89    292.08  0.602
> >
> > There is no such thing as a free lunch, however, and the special case
> > for len == 40 does add overhead to the len != 40 cases. This seems to
> > amount to be ~5% throughput and slightly less in terms of latency.
> >
> > Testing:
> > Part of this change is a new kunit test. The tests check all
> > alignment X length pairs in [0, 64) X [0, 512).
> > There are three cases.
> >     1) Precomputed random inputs/seed. The expected results where
> >        generated use the generic implementation (which is assumed to be
> >        non-buggy).
> >     2) An input of all 1s. The goal of this test is to catch any case
> >        a carry is missing.
> >     3) An input that never carries. The goal of this test si to catch
> >        any case of incorrectly carrying.
> >
> > More exhaustive tests that test all alignment X length pairs in
> > [0, 8192) X [0, 8192] on random data are also available here:
> > https://github.com/goldsteinn/csum-reproduction
> >
> > The reposity also has the code for reproducing the above benchmark
> > numbers.
> >
> > Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>
> Thanks for your patch, which is now commit 688eb8191b475db5 ("x86/csum:
> Improve performance of `csum_partial`") in linus/master stable/master
>
> > Link: https://lore.kernel.org/all/20230511011002.935690-1-goldstein.w.n%40gmail.com
>
> This does not seem to be a message sent to a public mailing list
> archived at lore (yet).
>
> On m68k (ARAnyM):
>
>     KTAP version 1
>     # Subtest: checksum
>     1..3
>     # test_csum_fixed_random_inputs: ASSERTION FAILED at
> lib/checksum_kunit.c:243
>     Expected result == expec, but
>         result == 54991 (0xd6cf)
>         expec == 33316 (0x8224)
>     not ok 1 test_csum_fixed_random_inputs
>     # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:267
>     Expected result == expec, but
>         result == 255 (0xff)
>         expec == 65280 (0xff00)
>
> Endianness issue in the test?
>
>     not ok 2 test_csum_all_carry_inputs
>     # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:306
>     Expected result == expec, but
>         result == 64515 (0xfc03)
>         expec == 0 (0x0)
>     not ok 3 test_csum_no_carry_inputs
> # checksum: pass:0 fail:3 skip:0 total:3
> # Totals: pass:0 fail:3 skip:0 total:3
> not ok 1 checksum

As this test already exposed bugs on x86 and UML:

https://lore.kernel.org/all/20230704083206.693155-2-davidgow@google.com
https://lore.kernel.org/linux-um/20230704083022.692368-2-davidgow@google.com

there's probably a real bug in the m68k csumming code.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
