Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB4E6BD75B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 18:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCPRoA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 13:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCPRn6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 13:43:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B57BE275E
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 10:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OqQ4Q9RBWUWmI6FcsOmvbp2hFFkMFGmLvUOTpcGoIDE=;
        t=1678988613; x=1680198213; b=tQtb7zD0UXbvGt+lfCQ+lli/XxLMtY4LzOOD+LmlKvGObTy
        38DFLzcF2L5oIX2Q19jHiP9hLphN0+dBjYhUUh8Q/hu3qiRAsjpRF+5I09LG1z6vc78ePHUDueBoL
        cp9QxubyTPg8wl1isV/fuNCuUkDeHCAXRAVG05Qj8afvnq2eLS3j3r6wW3HUUoPi8TJmVMCw2DFDV
        kufA1x4DCjYuzNWAm7mEZwWy/K7UYyX29iLwe6C0ZjaaSewmqKC5Ij2AZ8wqFhqm766dTSxM1lmIw
        2R/HOerXMP9vADks9bnIfM5B/odf2q5ZLn2SThKN2OwQOYHLI+pQjy5/xBY/7Apg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pcrdS-005K2v-2K;
        Thu, 16 Mar 2023 18:43:30 +0100
Message-ID: <9a172b50457f4074af41fe1dc8e55dcaf4795d7e.camel@sipsolutions.net>
Subject: Re: [PATCH] kunit: tool: fix type annotation for IO
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Date:   Thu, 16 Mar 2023 18:43:24 +0100
In-Reply-To: <CAGS_qxpYEnzWM=nPXDAbebuQERN4ijb0FKFbtmX5hK9qwVn12A@mail.gmail.com>
References: <20230315105055.9b2be0153625.I7a2cb99b95dff216c0feed4604255275e0b156a7@changeid>
         <CAGS_qxrJ53EyQaf5WqfSBYhOF0+LvWgvKL4gExu9vCPxRb7ipw@mail.gmail.com>
         <e028d27b3e998eaba2d71b6e224eb707015f8edf.camel@sipsolutions.net>
         <CAGS_qxpYEnzWM=nPXDAbebuQERN4ijb0FKFbtmX5hK9qwVn12A@mail.gmail.com>
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

On Thu, 2023-03-16 at 10:35 -0700, Daniel Latypov wrote:
> On Thu, Mar 16, 2023 at 12:42=E2=80=AFAM Johannes Berg
> <johannes@sipsolutions.net> wrote:
> >=20
> > On Wed, 2023-03-15 at 23:02 -0700, Daniel Latypov wrote:
> > > This is a good catch, thanks.
> > > But we also have a few more bare generic types that warrant attention=
.
> >=20
> > Oh, that might well be true. I was using kunit_parser in a script, and
> > that imports kunit_printer, and then tried to check *my* script for typ=
e
> > annotations with mypy. This led it to go check through the dependencies
> > too, and since it was just one small thing there I decided to just fix
> > it rather than figure out how to tell mypy that I don't care about thos=
e
> > dependencies :-)
>=20
> There's --exclude=3D'<regex>', if you ever end up needing to ignore other=
 files.
> But yeah, we should try and make sure that mpyy is happy w/ kunit.py code=
.

Yes, but that has other complexities I think? Anyway, I didn't even
really read much into it since it was so easy.

> > Now for everything else? I didn't even look.
>=20
> Oh, does mypy complain about this now?
> That'd be nice.
>=20
> Hmm, I don't see it even after upgrading my local version.
> $ pip install --upgrade mypy pytype
> $ ../tools/testing/kunit/run_checks.py
> <no errors>
> # Checking if it doesn't report error but logs a warning:
> $ mypy ./tools/testing/kunit/*.py
> Success: no issues found in 9 source files

Oh, I use --strict, and

$ mypy --version
mypy 0.941

right now. Probably old.

And

$ mypy --strict tools/testing/kunit/*.py

has a _lot_ of complaints.

> How I found the rest is Google has a wrapper around pylint, which has
> a number of custom checks. "g-bare-generic" is one of them, which
> complains about these.
>=20
> I don't think there's a publicly accessible version of those checks,
> even though the base pylintrc file is...

:)

> https://lore.kernel.org/linux-kselftest/20230316172900.755430-1-dlatypov@=
google.com
>=20

Great, thanks!

johannes
