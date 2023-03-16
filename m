Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0499A6BDA87
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 22:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCPVD1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 17:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCPVD0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 17:03:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2FBC17F
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=n1kN+k7LI7KLIVcbZMyo20mGw3CkM+7K/Z2zv0lcJ3U=;
        t=1679000604; x=1680210204; b=TYThEI1XxdKbMEVD3TjOlrwQdUe4QQq75N1Ol6EsuX6egWf
        2G2vSj/R6qznW5pAkygHIZRb1uJe4v/G4wctzYn7h7jLDsYb8wWrxxsf8dKl3MQU6bWRA9Z/EFjY4
        ijD04TPxEyf75791fyfB8r6jdOJgaz2xRFzmudu6zy4JcKrkZXS/KgIUK3IjPtTYO9fWl/eFnQuhY
        xCXe+sVbAhAck7qkPMY3WOY2esCGozkoFL6D1ioH4mEiWhL9OMW5vM4Cgrgy/GxU61e9NJGaJq4OE
        zBotbiyGgvqrM6blPoJ1UUQ0P5Si1aV1oQnXffANylqH3y3H0sl3dyu74Jo1pLJA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pcuks-005NAr-0e;
        Thu, 16 Mar 2023 22:03:22 +0100
Message-ID: <e4d5d03d37335e7e9ceb0333749a7fac1545f7e6.camel@sipsolutions.net>
Subject: Re: [PATCH] kunit: tool: fix type annotation for IO
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Date:   Thu, 16 Mar 2023 22:03:21 +0100
In-Reply-To: <CAGS_qxoEOW+FN33czFOhJ7xgPeKjGsj=BMc4iF-aP53TfyiyEQ@mail.gmail.com>
References: <20230315105055.9b2be0153625.I7a2cb99b95dff216c0feed4604255275e0b156a7@changeid>
         <CAGS_qxrJ53EyQaf5WqfSBYhOF0+LvWgvKL4gExu9vCPxRb7ipw@mail.gmail.com>
         <e028d27b3e998eaba2d71b6e224eb707015f8edf.camel@sipsolutions.net>
         <CAGS_qxpYEnzWM=nPXDAbebuQERN4ijb0FKFbtmX5hK9qwVn12A@mail.gmail.com>
         <9a172b50457f4074af41fe1dc8e55dcaf4795d7e.camel@sipsolutions.net>
         <CAGS_qxoEOW+FN33czFOhJ7xgPeKjGsj=BMc4iF-aP53TfyiyEQ@mail.gmail.com>
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

On Thu, 2023-03-16 at 10:58 -0700, Daniel Latypov wrote:
> Yikes.
> I either forgot or never knew about --strict, thanks for pointing it out.
>=20
> Looking into it, I don't think it's worth using for kunit.py, details bel=
ow.

Oh, no argument, whatever works for you. I don't really even remember
why I/we settled on mypy vs. pytypes, I don't remember really doing any
comparison.

I do find the whole type-checking, if occasionally a bit painful, to be
of benefit though, at least for larger code bases (and by larger I think
I probably would say "more than a single file that you can keep in your
head entirely" :-)

> Hmm, the untyped stuff is not too important since we also use pytype,
> which is a lot smarter in that it infers types where not specified.

Hmm, mypy normally does a bunch of inference too, but yeah might be less
smart here, or maybe --strict just insists on more precision.

> The other two though warrant some attention
> * attr-defined: we don't care about this. We have a directive to
> squash this "error" for pytype. Ugh, do we need another one for
> pytype?

You mean mypy? I guess yes, you'd need "# type: ignore". But funnily, I
think both tools will insist that you place the comment on the same line
as the error, and that doesn't really work since you can only have one
comment on that line :-) However, it looks like pytype would also accept
"# type: ignore" according to the docs.


> * assignment: not actually a real error, it points to our type
> annotations being a bit sloppy

Not sure what you meant by this, but maybe I just don't see it with my
version of mypy.

>   tools/testing/kunit/kunit.py:459: error: Incompatible types in
> assignment (expression has type "List[str]", variable has type
> "TextIO")  [assignment]
>=20
> So it doesn't like that we assign a list[str] or a IO[str] to `kunit_outp=
ut`.
> But we're passing it in as Iterable[str], which both work as.
>=20
> Even explicitly annotating it as an Iterable[str] doesn't make it happy [=
1].
> I'll ignore this, then.

I think you got that annotation wrong, at least as far as mypy is
concerned?

>                 sys.stdin.reconfigure(errors=3D'backslashreplace')  #pyty=
pe: disable=3Dattribute-error
> -               kunit_output =3D sys.stdin
> +               kunit_output =3D sys.stdin  # type[Iterable[str]]

Doing

 kunit_output: Iterable[str] =3D sys.stdin

actually fixes it for me, and you don't even need the second one:

>         else:
>                 with open(cli_args.file, 'r', errors=3D'backslashreplace'=
) as f:
> -                       kunit_output =3D f.read().splitlines()
> +                       kunit_output =3D f.read().splitlines()  #type[Ite=
rable[str]]
>=20

which I think is because it assigned the type as Iterable[str] after the
first one, and then was happy since splitlines() is Iterable[str] after
all. So maybe pytypes is smarter about finding the best common type.



Anyway ... I don't really care so much. I just noticed this, and had it
been any more complex I'd probably have gone and just ignored kunit from
my project.

Oh, another unrelated thing: it kind of bothered me that even with
kunit_parser.py you automatically get some output on stdout, it felt
like kunit_parser.py was or should be more of a library, but in the end
I don't really care so much since I needed to write a JSON file for our
internal system and could just suppress the stdout entirely :)

johannes
