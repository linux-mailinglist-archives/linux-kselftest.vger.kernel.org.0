Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CF1526FFF
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 May 2022 10:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiENI0e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 14 May 2022 04:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiENI03 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 14 May 2022 04:26:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F5121A
        for <linux-kselftest@vger.kernel.org>; Sat, 14 May 2022 01:26:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k30so1388255wrd.5
        for <linux-kselftest@vger.kernel.org>; Sat, 14 May 2022 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGSNjX7FWQgS0zAf5uzD98exN773UqLJMyTQST6/uq8=;
        b=kr+ZoQoZymx9R0c+QUc/iRMK7yM5RJMiYBaDp29vkbzqN7JsQvW7P8dRIHD0OC0Sgb
         9h/gegiLUJbI2vnd3FLgX/zT8QIDEDZvJUA5QItCnKwonX2DhnCre7aNN6WHzCDzmyt9
         I43ecBElIP+jlg58xhiDXPtcOBYbhytGBFnZvjsNIMRdASSJKRAZTUQGh0isW83j8WGg
         Sgo3kHAinNsrc10w18UGp+2+V3MWOlL6bdQIvB21UOUXeuHPZi5B9FJke2Ga09IJAWOf
         idRiJm/YgtYOTc9+JCdRb0RTl+6EiIAhcysqwgchztbk2NwBxnCWA8lFPS2WLVfqKrqn
         2JqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGSNjX7FWQgS0zAf5uzD98exN773UqLJMyTQST6/uq8=;
        b=l1BfNWP8btA1aah/Z2KrgrCfuk6kd/mpMQRu45Fg6o9ltAjU4CP+hkOWBG7ZavCY1Z
         k09U9T8FVnvKKXL5QmOORxD1KiR3m0Q8tf7ybgNoM8X+y6Z0Tc/uRdZWe60CcyQoVF9A
         Dng/oStsOE31+j06KK0kfl7BUtUoyAVWtI4+w079ULNtJA6ZJNHgYbZ3mVJVxjU+ECUm
         /WhMX0+sOG9scre60hTZef8kiGtbi2TYKvTuOiF7PVBbn01pIGKFNfUXK2YgwW5RwlBH
         sIoeWKIlO46UqTRimWjv9VL2DAAVpPxY6Z3ZDs401TifffqPdBUtMXxYEtsbOs042qZS
         24Iw==
X-Gm-Message-State: AOAM531CBDFznS6gl507Nb0mCrIz/nU/FwB6JZc6ag6dbx+OfncgFY3Z
        c+ggjpgek/SAKWPmqEe/1mtjFvOWEJ+8FZiDypyJtQ==
X-Google-Smtp-Source: ABdhPJxd2yAOrMDx1kyKIycTBHNDuUPoF3izxQpqfG9Ebu0UFmB15wKbKgzL/O8DbbD6u5O1U1bgna6lzZ1eJnpLVQs=
X-Received: by 2002:a5d:6651:0:b0:20a:df2f:8027 with SMTP id
 f17-20020a5d6651000000b0020adf2f8027mr6968835wrw.269.1652516785016; Sat, 14
 May 2022 01:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <bc6e9ed7-d98b-c4da-2a59-ee0915c18f10@gmail.com>
 <5ca35c47-6145-4ec1-6c05-3c46f436cb4d@gmail.com> <CAGS_qxpE9qGsS1LqaobVGFKFgV6TwvwNLR4e9PG5zsfPACSf_Q@mail.gmail.com>
 <5b2783a2-76bf-ce6f-89b1-d0fe05b80b82@gmail.com>
In-Reply-To: <5b2783a2-76bf-ce6f-89b1-d0fe05b80b82@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 14 May 2022 16:26:13 +0800
Message-ID: <CABVgOS=XcaheGrJ+n2DPUuE=MrJwDn5UWYcdQmfhZfHx2MDazg@mail.gmail.com>
Subject: Re: [RFC] KTAP spec v2: prefix to KTAP data
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Rae Moar <rmr167@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernelci@groups.io, KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, May 13, 2022 at 1:26 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 5/12/22 10:25, Daniel Latypov wrote:
> > On Wed, May 11, 2022 at 11:01 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >> ================================================================================
> >> #### discussion notes:
> >>
> >> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> >> PRO: minimally invasive to specification.
> >>
> >> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> >> CON:
> >>
> >> KTAP does not include any mechanism to describe the value of <prefix string>
> >> to test harnesses and test output processing programs.  The test output
> >> processing programs must infer the value of <prefix string> by detecting
> >> the <prefix string> in the "Version lines".
> >>
> >> The detection of a "Version lines" might be a match of the regex:
> >>
> >>    "^.*KTAP version 2$"
> >>
> >> This risks falsely detecting a "Version lines", but the risk is small???
> >
> > Agree this is a risk and also think it's probably small, but it's hard to say.
> > I think the $ anchoring the regex is probably safe enough.
> >
> > As noted earlier, this tracks with what kunit.py already does.
> > That was necessitated by dynamic prefixes such as timestamps, etc.f
>
> That is a good observation.  I nearly always have the prefix timestamp
> on my console output, and thus remove the timestamp with a regex when
> processing the data.
>

Yeah: the use of a prefix length for timestamps (and similar 'dynamic
prefixes') works really well as a way to automatically find KTAP
output in the kernel log.
It's definitely less useful as a way of disambiguating several
(potentially interleaved) KTAP streams, though.

Personally, my conception of KTAP is that the prefix is not a part of
the format, but a way (possibly one we should recommend in the spec)
to isolate KTAP output from (e.g.) the kernel log.
So, in theory, the processing pipeline for log -> result is:
[dmesg] ---<remove prefix>--> [KTAP] ---<parse>---> [results]

I wouldn't object to having the prefix be a part of KTAP if it were
particularly useful to anyone, though, and definitely agree we should
note ways to do it.

Either way, we do end up with two (slightly conflicting) uses of prefixes:
a) To isolate tests from a log.
b) To allow multiple concurrent tests.

For a), Alternative 1 seems obviously correct to me, since whatever
module is being used might not know what random prefixes are being
added to its log lines.
For b), either would work, but we do potentially get conflicts with a)
if we're trying to do both. So maybe alternative 2 makes sense for
that.

>
> > So I think this is probably a fine risk to take.
> >
> > I imagine we could add constraints of prefix string, e.g. must have []
> > around it, etc. if we want to try and minimize this risk.
> > But I don't know if it's necessarily worth it, given what we know right now.
> >
> > Along those lines, I think I like this approach (Alternative 1) more
> > than Alternative 2/2b.

I agree, though note that we might need both if we want two separate
types of prefix as mentioned above.

> > I'm not sure we need a structured way to specify metadata in KTAP yet?
> > The prefix seems like a reasonable candidate, but do others have ideas
> > of other bits of metadata we'd want to be able to declare?
> >

That's the important takeaway from Alternative 2: some generic way of
having metadata could be quite handy. (Of them, Alternative 2b feels a
little more like a hack than I'd prefer, albeit a clever one. I'd
prefer a cleaner "configuration info line" personally, though if
reusing the test results for test 0 makes parsing significantly easier
for others, it may nevertheless be worth doing.)

As for other pieces of metadata, there are all sorts of useful
information about the test which could be useful to store alongside
the results (what tool generated it, kernel version, etc), though
those might be more useful when saving results elsewhere than embedded
into the kernel output.

Equally, if we extended these configuration/info lines to individual
test/subtests, things like test size, originating module, etc could
potentially be stored. Suite/test init functions could potentially add
useful metadata, too (e.g., number of cores/threads for kcsan, etc).

None of those are, I think, quite compelling enough individually to
add a config system, though. If we already had one for the prefix, and
other things which are necessary for parsing, maybe...

-- David
