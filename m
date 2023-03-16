Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810666BD736
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 18:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCPRf5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCPRf4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 13:35:56 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ACFE20DA
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 10:35:38 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h14so1170828pgj.7
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678988138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByX505HlNkwJK5+/kak1KArBh7/meY/jvrVK4FksOig=;
        b=mFb8cj/zscXfxjWGDmaxqfe1eAAAoegL70+LTFBGvK8DSg38aewmvp0e6pOEYuCurD
         hkkVWZGWyT6TX2aH7kJqfsCTFWV/0S2psZGfFHTvXkwg6K3z7sH0AQawYDdbwrfRMw7o
         tyCdj9wKB4ZN/JwnnNameaa8OrbHL5sk69f7sBTdZkiTINhu9e/FF0vG7cMVXwJpvsU1
         4d+Iadaj0bALEWNk+zuiAVggBeloUfmvcOwg7/UdeHM6epSZRscbzJRzPtAtK7qCiGsm
         HDy+Vgq1StMuVtFohbWzxYLfpm5PlNlMW29JiNEIYb06/ll4cWXZXdUzAcG2ZPY0uH93
         fCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByX505HlNkwJK5+/kak1KArBh7/meY/jvrVK4FksOig=;
        b=eQiZjefs5L4QRaNXBWLV4QisU0yGybj8QpC4eekTYnFPz7fvFs0LUpw/P6mfhAZAs4
         8aSjurJIunQM1gPD6FaBT+jxtPJ+5k6LVGY1N4F1HL7xy9se2/wmfVi4HvCnW9Z1kTYr
         lu6WuwHs/bWydnfUn+Lqqa4x/EVXMm7bx4kWSH72auDPiQXpOqo1pPe2Kk9xSSwGL0rB
         Voww9vJGOtYKNXhXi2/EF+Nn2KtelRB2hSCj5Uq9H7SbUWKYBM3APyOfcJp+HU55lEM0
         GY3RWly3fy8kSur8pC3ry/BNPqJMQwBUdq5umr/qA7HDTAd2Wjv5qJgX3IUqji77sX4D
         M/Dg==
X-Gm-Message-State: AO0yUKWPUlCHptHXdmxZE8Zr8qd4sLEjoMK1nk+KvZ9ySuAKHdv90D31
        /1rVJsXp4GvEJu2J6PWTM/N/JNFCUL07vW+gm2T0Sw==
X-Google-Smtp-Source: AK7set9GF4jj5QwwP+UHYVQ0+j0fG8AR39K9XHDsZ13ZDiLpxHNAAOVCkztCyYdRZ3RKJiHyEEimfIgJoFXqu8KQzsE=
X-Received: by 2002:a65:5303:0:b0:503:25f0:9cc5 with SMTP id
 m3-20020a655303000000b0050325f09cc5mr1112133pgq.2.1678988138183; Thu, 16 Mar
 2023 10:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230315105055.9b2be0153625.I7a2cb99b95dff216c0feed4604255275e0b156a7@changeid>
 <CAGS_qxrJ53EyQaf5WqfSBYhOF0+LvWgvKL4gExu9vCPxRb7ipw@mail.gmail.com> <e028d27b3e998eaba2d71b6e224eb707015f8edf.camel@sipsolutions.net>
In-Reply-To: <e028d27b3e998eaba2d71b6e224eb707015f8edf.camel@sipsolutions.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 16 Mar 2023 10:35:26 -0700
Message-ID: <CAGS_qxpYEnzWM=nPXDAbebuQERN4ijb0FKFbtmX5hK9qwVn12A@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix type annotation for IO
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 16, 2023 at 12:42=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Wed, 2023-03-15 at 23:02 -0700, Daniel Latypov wrote:
> > This is a good catch, thanks.
> > But we also have a few more bare generic types that warrant attention.
>
> Oh, that might well be true. I was using kunit_parser in a script, and
> that imports kunit_printer, and then tried to check *my* script for type
> annotations with mypy. This led it to go check through the dependencies
> too, and since it was just one small thing there I decided to just fix
> it rather than figure out how to tell mypy that I don't care about those
> dependencies :-)

There's --exclude=3D'<regex>', if you ever end up needing to ignore other f=
iles.
But yeah, we should try and make sure that mpyy is happy w/ kunit.py code.

Thanks for doing this!

>
> Now for everything else? I didn't even look.

Oh, does mypy complain about this now?
That'd be nice.

Hmm, I don't see it even after upgrading my local version.
$ pip install --upgrade mypy pytype
$ ../tools/testing/kunit/run_checks.py
<no errors>
# Checking if it doesn't report error but logs a warning:
$ mypy ./tools/testing/kunit/*.py
Success: no issues found in 9 source files

How I found the rest is Google has a wrapper around pylint, which has
a number of custom checks. "g-bare-generic" is one of them, which
complains about these.

I don't think there's a publicly accessible version of those checks,
even though the base pylintrc file is...

Note: I'd like it if kunit/run_checks.py could run pylint.
But the default python style contrasts with kernel style (mainly
around whitespace), so there's a lot of checks we'd need to disable to
get a clean signal.

>
> > I think the diff below [1] should fix the others as well.
> > I can send it out as a formal patch and add your name for the Reported-=
by?
>
> Sure!

https://lore.kernel.org/linux-kselftest/20230316172900.755430-1-dlatypov@go=
ogle.com

Daniel
