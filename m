Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F636BDB18
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 22:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCPVnw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 17:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjCPVnv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 17:43:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2D012CE6
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 14:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=SKNoYFirFCOXZA7Jn7GJ5f5e7Q1W7w5Fgg2sBk/EQZE=;
        t=1679003026; x=1680212626; b=JEWDARjq3ek7gw3hJYo6v6lrIUnChpDUyBw4nx3YcpFG0FR
        6kfVtIvcCUK/059xwCH3F9lGvkzP9fYigcBIwOAWQK+4/MpWBRZsr3WiRuHpYm6kZapjlw9FCM00F
        yyC+aOZYOf1HD6zFdor8s4ScrXtZrpExeJZhCFA5ZA+YNs1Zz1MwaT5SKrycf28K2L7twiQ8jjFUH
        aLfOToGBEAJF90uhrCzVfaUPgUB7KTJF4bjpvU6GlmDjW96mhh0X8VrfhUqT6VYHHOqse1GNUaY3P
        KjiXM6YTWtpPs2l5eb8hBFQ4RJZbtDyGemIDrpq4mkdPY20RLlc3NRS3yXf/pDcg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pcvNw-005Nn2-25;
        Thu, 16 Mar 2023 22:43:44 +0100
Message-ID: <2d5004a0bb1c5737652b54a9d072957281e08796.camel@sipsolutions.net>
Subject: Re: [PATCH] kunit: tool: fix type annotation for IO
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Date:   Thu, 16 Mar 2023 22:43:43 +0100
In-Reply-To: <CAGS_qxqQd5t1gB4PZCBBYBG2fy8977i5_CcA2aCTyp7x4DKUvw@mail.gmail.com>
References: <20230315105055.9b2be0153625.I7a2cb99b95dff216c0feed4604255275e0b156a7@changeid>
         <CAGS_qxrJ53EyQaf5WqfSBYhOF0+LvWgvKL4gExu9vCPxRb7ipw@mail.gmail.com>
         <e028d27b3e998eaba2d71b6e224eb707015f8edf.camel@sipsolutions.net>
         <CAGS_qxpYEnzWM=nPXDAbebuQERN4ijb0FKFbtmX5hK9qwVn12A@mail.gmail.com>
         <9a172b50457f4074af41fe1dc8e55dcaf4795d7e.camel@sipsolutions.net>
         <CAGS_qxoEOW+FN33czFOhJ7xgPeKjGsj=BMc4iF-aP53TfyiyEQ@mail.gmail.com>
         <e4d5d03d37335e7e9ceb0333749a7fac1545f7e6.camel@sipsolutions.net>
         <CAGS_qxqQd5t1gB4PZCBBYBG2fy8977i5_CcA2aCTyp7x4DKUvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2023-03-16 at 14:30 -0700, Daniel Latypov wrote:
>=20
> 100% agree, just the concern is about trying to keep two different
> checkers happy when they might have conflicting demands.
> Pytype has been able to catch some relatively subtle errors, so I've
> prioritized it.

Sure. Maybe I'll just switch to pytype too ;-)


> But since commit b7e0b983ff13 ("kunit: tool: fix pre-existing python
> type annotation errors") onwards, I've been trying to fix up all the
> issues we've had with either.

OK.

> One footgun I ran into was that mypy seemed like it wasn't even
> touching functions if they didn't have an argument or the return type
> annotated.
> See 09641f7c7d8f ("kunit: tool: surface and address more typing issues")
> Maybe --strict is better.

It might not be, I have no idea.

> Pytype takes a lot longer and caught issues that normal `mypy` didn't.
> I haven't compared them w/ strict --strict. But given pytype is still
> a lot slower, I assume (hope) it's doing more work.

Hehe :-)

> > think both tools will insist that you place the comment on the same lin=
e
> > as the error, and that doesn't really work since you can only have one
> > comment on that line :-) However, it looks like pytype would also accep=
t
> > "# type: ignore" according to the docs.
>=20
> That's true, but `type: ignore` disables all type checking on the line.
>=20
> In this case, I think it's moot given the whole line is just
>   sys.stdin.reconfigure(errors=3D'backslashreplace')
> so I'd basically turned off all type-checking already.

Right, pytype looks a bit more controlled there.

> > I think you got that annotation wrong, at least as far as mypy is
> > concerned?
> >=20
> > >                 sys.stdin.reconfigure(errors=3D'backslashreplace')  #=
pytype: disable=3Dattribute-error
> > > -               kunit_output =3D sys.stdin
> > > +               kunit_output =3D sys.stdin  # type[Iterable[str]]
> >=20
> > Doing
> >=20
> >  kunit_output: Iterable[str] =3D sys.stdin
> >=20
> > actually fixes it for me, and you don't even need the second one:
>=20
> D'oh, I forgot the ": "  Ugh, magic comments :)
> Doing "# type: Iterable[str]` on just the first one works for me.

Right, not sure I like the magic comments better than the inline type in
the code, but YMMV.

> Note: we'd been avoiding the `var: T =3D 42` syntax to try and be more
> compatible with old versions of python.

Well, OK, I gave up on non-controlled versions of python long ago. In my
case it's all running in a nix-shell environment so I control it very
precisely :-)

> Ack, yeah, the fact it dumps anything directly to stdout is annoying.
>=20
> The argument is that
> * it wants to print in real time
> * it needs access to the tty to know if it should include colors or not

Right.

> This patch might be of interest to you:
> https://kunit-review.git.corp.google.com/c/linux/+/5730/1
> With that, you could pass in a kunit_printer.BufferPrinter to
> parse_tests() and keep stdout pristine.

Heh. Sounds like a useful patch but I can't see that link given the lack
of corp.google.com login :P

> I could split out the concurrency support from that patch and try to
> get submitted.
> There just wasn't motivation to do so since there was no use case for
> suppressing output yet.
> Given you're using it, that might be sufficient.

I honestly don't care much now. Basically decided that redirecting
stdout to /dev/null was sufficient, since anyway the real output I need
happens to a file. I might've designed it to print the JSON on stdout
instead if it wasn't getting all that output from kunit, but it really
doesn't matter now.

Anyway, thanks for the discussion! I've been playing with kunit only for
like 48 hours now, so we'll see where I can go from here :-)

johannes
