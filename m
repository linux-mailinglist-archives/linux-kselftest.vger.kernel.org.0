Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262136A0E3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 17:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjBWQwi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 11:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBWQwh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 11:52:37 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54684EFAD;
        Thu, 23 Feb 2023 08:52:35 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id d7so11446976qtr.12;
        Thu, 23 Feb 2023 08:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OmSVuAip9wO3Gha1ZZSovxIPIgEgsLE50VtSIFDnNA=;
        b=QEWVuELWX2lZN/h6cmnqGhG9MKNuQt9dufAjWqDDX1NEYjFg7QkH2WYV8h8eGatut2
         /gRSZHXSP7UcHx2tG6U7VbUhs40YRXT2sNNOw0sDw5a7zHsgIYB9BEzovsbXpz8D+sYz
         OJeNmsMfz7m3EDq+GlA0sIR4XDP8y5r/gJOeNTvkUGtldmMJS/I576UKVuApnH9F5yWF
         ldr4fb0Nx8QcM6XrY5K6y2FYxeaK3XfD/duda4AA0uSYTh0XSoPjujaNwtf9a7rLgT6d
         bCGZj7jeXTTGfIc9KM9JLhrl5JB4Wz2W3ieP5BdiOI6Zv19lr5P1DrIjkwmU0CTIhnif
         AEDQ==
X-Gm-Message-State: AO0yUKXFQWR2sRc1FZ+iGLlmZiZuyDoudfUn5kNu0XKnZ3wpeGHdy8WV
        nlSP5jubfm8hgtF0OY5zLWcoMEw6G1vYWA==
X-Google-Smtp-Source: AK7set+6v47knkpkuaI9NmXmWmrhSYqNdCUwlqphFO8IhAP6UtFmp7RPOLw8D8wxEHvtXZZLhIg3wQ==
X-Received: by 2002:a05:622a:13:b0:3b6:36a0:adbe with SMTP id x19-20020a05622a001300b003b636a0adbemr8661556qtw.6.1677171153631;
        Thu, 23 Feb 2023 08:52:33 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id d20-20020ac85454000000b003a530a32f67sm6833848qtq.65.2023.02.23.08.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 08:52:33 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-536c02eea4dso198121337b3.4;
        Thu, 23 Feb 2023 08:52:33 -0800 (PST)
X-Received: by 2002:a5b:68c:0:b0:9a0:d4d:5462 with SMTP id j12-20020a5b068c000000b009a00d4d5462mr2374659ybq.7.1677171152895;
 Thu, 23 Feb 2023 08:52:32 -0800 (PST)
MIME-Version: 1.0
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
 <b3e0b5e6-1d0-cdb2-186c-6b4f50e0a3aa@linux-m68k.org> <D5221DC2-2A9C-43DC-AC21-FA96E7F76E5B@oracle.com>
 <CAMuHMdVtsZ-jU5foR7V_4XeXT_0f3Nx5vfoJo5pH2jMga0SpWA@mail.gmail.com> <58CCF033-58C3-4AF0-B958-BE1AAF1695F3@oracle.com>
In-Reply-To: <58CCF033-58C3-4AF0-B958-BE1AAF1695F3@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Feb 2023 17:52:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUG5cthYp3u6GeYqTqMaNgW0Ernq_ce0AZ22rgFQ5J24A@mail.gmail.com>
Message-ID: <CAMuHMdUG5cthYp3u6GeYqTqMaNgW0Ernq_ce0AZ22rgFQ5J24A@mail.gmail.com>
Subject: Re: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "simo@redhat.com" <simo@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Chuck,

On Thu, Feb 23, 2023 at 5:19 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> > On Feb 23, 2023, at 10:16 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Feb 23, 2023 at 3:00 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>> On Feb 23, 2023, at 8:05 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>> On Sun, 15 Jan 2023, Chuck Lever wrote:
> >>>> The purpose of this series is to improve/harden the security
> >>>> provided by the Linux kernel's RPCSEC GSS Kerberos 5 mechanism.
> >>>> There are lots of clean-ups in this series, but the pertinent
> >>>> feature is the addition of a clean deprecation path for the DES-
> >>>> and SHA1-based encryption types in accordance with Internet BCPs.
> >>>>
> >>>> This series disables DES-based enctypes by default, provides a
> >>>> mechanism for disabling SHA1-based enctypes, and introduces two
> >>>> modern enctypes that do not use deprecated crypto algorithms.
> >>>>
> >>>> Not only does that improve security for Kerberos 5 users, but it
> >>>> also prepares SunRPC for eventually switching to a shared common
> >>>> kernel Kerberos 5 implementation, which surely will not implement
> >>>> any deprecated encryption types (in particular, DES-based ones).
> >>>>
> >>>> Today, MIT supports both of the newly-introduced enctypes, but
> >>>> Heimdal does not appear to. Thus distributions can enable and
> >>>> disable kernel enctype support to match the set of enctypes
> >>>> supported in their user space Kerberos libraries.
> >>>>
> >>>> Scott has been kicking the tires -- we've found no regressions with
> >>>> the current SHA1-based enctypes, while the new ones are disabled by
> >>>> default until we have an opportunity for interop testing. The KUnit
> >>>> tests for the new enctypes pass and this implementation successfully
> >>>> interoperates with itself using these enctypes. Therefore I believe
> >>>> it to be safe to merge.
> >>>>
> >>>> When this series gets merged, the Linux NFS community should select
> >>>> and announce a date-certain for removal of SunRPC's DES-based
> >>>> enctype code.
> >>>
> >>> As this is now upstream, I gave it a try on m68k (on the ARAnyM
> >>> emulator), using a config based on atari_defconfig:
> >>>
> >>>   KTAP version 1
> >>>   # Subtest: RFC 3961 tests
> >>>   1..3
> >>>       KTAP version 1
> >>>       # Subtest: RFC 3961 n-fold
> >>>       ok 1 64-fold("012345")
> >>>       ok 2 56-fold("password")
> >>>       ok 3 64-fold("Rough Consensus, and Running Code")
> >>>       ok 4 168-fold("password")
> >>>       ok 5 192-fold("MASSACHVSETTS INSTITVTE OF TECHNOLOGY")
> >>>       ok 6 168-fold("Q")
> >>>       ok 7 168-fold("ba")
> >>>       ok 8 64-fold("kerberos")
> >>>       ok 9 128-fold("kerberos")
> >>>       ok 10 168-fold("kerberos")
> >>>       ok 11 256-fold("kerberos")
> >>>   # RFC 3961 n-fold: pass:11 fail:0 skip:0 total:11
> >>>   ok 1 RFC 3961 n-fold
> >>>       KTAP version 1
> >>>       # Subtest: RFC 3961 key derivation
> >>>   # RFC 3961 key derivation: ASSERTION FAILED at net/sunrpc/auth_gss/gss_krb5_test.c:52
> >>>   Expected gk5e != ((void *)0), but
> >>>       gk5e == 00000000
> >>>       ((void *)0) == 00000000
> >>>       not ok 1 des3-hmac-sha1 key derivation case 1
> >>
> >> Geert, thanks for testing GSS on m68k.
> >>
> >> This assertion failure means that support for the encryption types
> >> specified in RFC 3961 is not built into your kernel.
> >>
> >> The new Kunit tests don't work unless everything is built in --
> >>
> >> there's a net/sunrpc/.kunitconfig that provides the supported
> >> build configuration for running them. I typically use a command
> >> line similar to this:
> >>
> >> ./tools/testing/kunit/kunit.py run --raw_output=all --kunitconfig ./net/sunrpc/.kunitconfig
> >
> > Aren't modular crypto algorithms auto-loaded when needed?
>
> The ciphers and digests are handled via the kernel's crypto
> manager. They will indeed get auto-loaded by SunRPC's GSS on
> demand, but of course, the set of algorithms used by GSS
> has to be enabled by Kconfig options first.
>
> SunRPC GSS has a set of Kerberos encryption types that make
> use of individual ciphers and digests. Those have never been
> modularized, and they are each enabled by Kconfig options,
> as explained below.
>
>
> > In general, it's a good idea to make the tests test only functionality
> > that is available, either through "depends on" in Kconfig, or "#if
> > IS_ENABLED(...)".
>
> An earlier version of this patch set did just that. It became
> quite a mess. That's why I chose the .kunitconfig approach.
>
>
> > Of course that does not preclude providing a
> > .kunitconfig to enable and test everything.
>
> The suite should test every Kerberos encryption type that
> SunRPC GSS has support for. There's no reason to disable a
> particular encryption type when running the unit tests...
> unless I'm missing something?

That depends: do you want to test everything, or do you want to test
(only) the functionality you enabled for your product?
I tend to enable all modular tests, so I can use insmod to run any
relevant test when needed.  If a test suddenly needs something that
is not enabled, you can not run the test without enabling extra
functionality (which you may not want to enable).

> > Note that net/sunrpc/.kunitconfig has
> >
> >    CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=y
> >
> > which needs KUNIT_ALL_TESTS=y, else it will still be modular.
> >
> > First, I tried getting my modular setup working.
> > After enabling:
> >    CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES=y
>
> And CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y ??

Sure, I had that enabled, thanks to "default y".

> > Third, with net/sunrpc/.kunitconfig, and
> > CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=y:

[...]

> > Unable to handle kernel access at virtual address af06da84

> > I.e. a slightly different crash.
> > As the difference between the two crashes is modular vs. builtin,
> > this looks like an out-of-bound access in the test.
>
> Why not run the test suite just as I suggested?

I don't think I can use tools/testing/kunit/kunit.py to run the tests
when cross-compiling my kernel?

My third case (adding options from net/sunrpc/.kunitconfig, and
setting CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST=y) should be equivalent to
that, right?

> Since I cannot reproduce this crash and do not have an m68k
> platform available to me, I will need you to continue to
> pursue the issue. I'll help as much as I can.
>
> I would very much like to see successful test results on
> non-x86 platforms.

Thanks, I'll give it a try on some other platforms, later...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
