Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2A66BDAFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 22:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCPVai (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 17:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCPVad (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 17:30:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9839D14EBE
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 14:30:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u20so1526079pfk.12
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 14:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679002231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVBfZk9IhLyojr7S0cW3MDKZWKdpa05ifTd+H5zbJ5Y=;
        b=Z1c7P/j70nM2A/22YusO9NiDAoakIAZ8ygAFRnzb6XslgwHrxGav3kt18LCmB/XL9/
         pUFM3bDWk2TyBUy4qgNsQLzk4rL8z9ZnjiguVCWOp8Adqp3Wyiogdxq0P/b1brHv+YRu
         VLZE1BTX1u1cesGha4Sr3d/zXzYcBrCQ1ic2YchzchC3QzhuH15WIiLv5lievz5XeTOI
         zJiaWIqDdxKbFvd7yuClBJ73EiPVN8WdP6LbGGyu80xHq49xyWFls/E7kpumuiSH5POE
         lzP3ZuVdt/v3zfNctJDpokbhKYhQ0P3ifTm2FKtkg410oLPQCFzoWYm0xY0HN42owBvI
         8vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679002231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVBfZk9IhLyojr7S0cW3MDKZWKdpa05ifTd+H5zbJ5Y=;
        b=wobwiRVcSAvTTxMdXi0ipJUwFuLBsFuxP1o4dwB5hmR82LvTzsdbduSgc1Ys4ig8Wc
         1jaHophw71tYc/5XjwRAGaHUtXuwir4IMT/PhCj1nVHPkBZxbASE7u8UQWdql7h08iso
         Vqd53iWgionhH+LqoPD1mLpXx27WCHGxu1AuSaBzfnPH7vQR+aXYERu8JsYEukITQjUl
         D+NdITs45/rzU6aUg86oMeK7jkpjNYguG/XPI62n6oJHdn3bXUo3lBTpaJgzT/DtB8Zx
         fFtR0R0SG71AQ6MEcKUQUIJw9wfOz0LLxrH8X79EPd/sGcLyEf7Mtp8BTkB4VhJXez+r
         3E6g==
X-Gm-Message-State: AO0yUKWESO8DnH5GbO5KpPJd9VWaWbUQSRFEEbmwQdsm9/waPg1351Rm
        NntT269BrS7A3BAsUBVLnG8SFOmkbyLEG0afsbZ5vA==
X-Google-Smtp-Source: AK7set/SrWaBUicV0CRLoFlGM8zMV4zGW5bFicYMSRgglWLkA4PDkwpXDdoUiNq/FmBF9uocvqohg2sGJfuSna4fDog=
X-Received: by 2002:a63:bd41:0:b0:50c:6cd:cac8 with SMTP id
 d1-20020a63bd41000000b0050c06cdcac8mr359482pgp.2.1679002230795; Thu, 16 Mar
 2023 14:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230315105055.9b2be0153625.I7a2cb99b95dff216c0feed4604255275e0b156a7@changeid>
 <CAGS_qxrJ53EyQaf5WqfSBYhOF0+LvWgvKL4gExu9vCPxRb7ipw@mail.gmail.com>
 <e028d27b3e998eaba2d71b6e224eb707015f8edf.camel@sipsolutions.net>
 <CAGS_qxpYEnzWM=nPXDAbebuQERN4ijb0FKFbtmX5hK9qwVn12A@mail.gmail.com>
 <9a172b50457f4074af41fe1dc8e55dcaf4795d7e.camel@sipsolutions.net>
 <CAGS_qxoEOW+FN33czFOhJ7xgPeKjGsj=BMc4iF-aP53TfyiyEQ@mail.gmail.com> <e4d5d03d37335e7e9ceb0333749a7fac1545f7e6.camel@sipsolutions.net>
In-Reply-To: <e4d5d03d37335e7e9ceb0333749a7fac1545f7e6.camel@sipsolutions.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 16 Mar 2023 14:30:19 -0700
Message-ID: <CAGS_qxqQd5t1gB4PZCBBYBG2fy8977i5_CcA2aCTyp7x4DKUvw@mail.gmail.com>
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

On Thu, Mar 16, 2023 at 2:03=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Thu, 2023-03-16 at 10:58 -0700, Daniel Latypov wrote:
> > Yikes.
> > I either forgot or never knew about --strict, thanks for pointing it ou=
t.
> >
> > Looking into it, I don't think it's worth using for kunit.py, details b=
elow.
>
> Oh, no argument, whatever works for you. I don't really even remember
> why I/we settled on mypy vs. pytypes, I don't remember really doing any
> comparison.
>
> I do find the whole type-checking, if occasionally a bit painful, to be
> of benefit though, at least for larger code bases (and by larger I think
> I probably would say "more than a single file that you can keep in your
> head entirely" :-)

100% agree, just the concern is about trying to keep two different
checkers happy when they might have conflicting demands.
Pytype has been able to catch some relatively subtle errors, so I've
prioritized it.

But since commit b7e0b983ff13 ("kunit: tool: fix pre-existing python
type annotation errors") onwards, I've been trying to fix up all the
issues we've had with either.

>
> > Hmm, the untyped stuff is not too important since we also use pytype,
> > which is a lot smarter in that it infers types where not specified.
>
> Hmm, mypy normally does a bunch of inference too, but yeah might be less
> smart here, or maybe --strict just insists on more precision.

One footgun I ran into was that mypy seemed like it wasn't even
touching functions if they didn't have an argument or the return type
annotated.
See 09641f7c7d8f ("kunit: tool: surface and address more typing issues")
Maybe --strict is better.

Pytype takes a lot longer and caught issues that normal `mypy` didn't.
I haven't compared them w/ strict --strict. But given pytype is still
a lot slower, I assume (hope) it's doing more work.

>
> > The other two though warrant some attention
> > * attr-defined: we don't care about this. We have a directive to
> > squash this "error" for pytype. Ugh, do we need another one for
> > pytype?
>
> You mean mypy? I guess yes, you'd need "# type: ignore". But funnily, I

Ah yes, I meant mypy.

> think both tools will insist that you place the comment on the same line
> as the error, and that doesn't really work since you can only have one
> comment on that line :-) However, it looks like pytype would also accept
> "# type: ignore" according to the docs.

That's true, but `type: ignore` disables all type checking on the line.

In this case, I think it's moot given the whole line is just
  sys.stdin.reconfigure(errors=3D'backslashreplace')
so I'd basically turned off all type-checking already.

>
>
> > * assignment: not actually a real error, it points to our type
> > annotations being a bit sloppy
>
> Not sure what you meant by this, but maybe I just don't see it with my
> version of mypy.
>
> >   tools/testing/kunit/kunit.py:459: error: Incompatible types in
> > assignment (expression has type "List[str]", variable has type
> > "TextIO")  [assignment]
> >
> > So it doesn't like that we assign a list[str] or a IO[str] to `kunit_ou=
tput`.
> > But we're passing it in as Iterable[str], which both work as.
> >
> > Even explicitly annotating it as an Iterable[str] doesn't make it happy=
 [1].
> > I'll ignore this, then.
>
> I think you got that annotation wrong, at least as far as mypy is
> concerned?
>
> >                 sys.stdin.reconfigure(errors=3D'backslashreplace')  #py=
type: disable=3Dattribute-error
> > -               kunit_output =3D sys.stdin
> > +               kunit_output =3D sys.stdin  # type[Iterable[str]]
>
> Doing
>
>  kunit_output: Iterable[str] =3D sys.stdin
>
> actually fixes it for me, and you don't even need the second one:

D'oh, I forgot the ": "  Ugh, magic comments :)
Doing "# type: Iterable[str]` on just the first one works for me.

Thanks!

Note: we'd been avoiding the `var: T =3D 42` syntax to try and be more
compatible with old versions of python.
But since we formally added a check that it's running python>3.7, I
guess we can switch to that syntax now too.

>
> >         else:
> >                 with open(cli_args.file, 'r', errors=3D'backslashreplac=
e') as f:
> > -                       kunit_output =3D f.read().splitlines()
> > +                       kunit_output =3D f.read().splitlines()  #type[I=
terable[str]]
> >
>
> which I think is because it assigned the type as Iterable[str] after the
> first one, and then was happy since splitlines() is Iterable[str] after
> all. So maybe pytypes is smarter about finding the best common type.
>
>
>
> Anyway ... I don't really care so much. I just noticed this, and had it
> been any more complex I'd probably have gone and just ignored kunit from
> my project.
>
> Oh, another unrelated thing: it kind of bothered me that even with
> kunit_parser.py you automatically get some output on stdout, it felt
> like kunit_parser.py was or should be more of a library, but in the end
> I don't really care so much since I needed to write a JSON file for our
> internal system and could just suppress the stdout entirely :)

Ack, yeah, the fact it dumps anything directly to stdout is annoying.

The argument is that
* it wants to print in real time
* it needs access to the tty to know if it should include colors or not

This patch might be of interest to you:
https://kunit-review.git.corp.google.com/c/linux/+/5730/1
With that, you could pass in a kunit_printer.BufferPrinter to
parse_tests() and keep stdout pristine.

I could split out the concurrency support from that patch and try to
get submitted.
There just wasn't motivation to do so since there was no use case for
suppressing output yet.
Given you're using it, that might be sufficient.

Daniel
