Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73916BD7A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 18:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjCPR7L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 13:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjCPR7F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 13:59:05 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926BF6EBB4
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 10:58:55 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q189so1421327pga.9
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678989534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV3s4LWd6yBp667Ey97AEi8y92XCYe54yn3M9Ys8WNc=;
        b=a7TkTIZfbpNTfeiJvcq8VxwHF743T7QtZvLcUA9Vq1jkMBHMNcEo65b/9kV0q4jH5D
         He0EcK9BeuP0CcMEqPpqGA0ylICvveWCSCqF16JaDN6A+e0mKKp7FFGD76FARVwq+DWi
         oy/jTPF0CnL09CNYt1RIuqd5qv/MkSyMvG0SdGDffJcg08Wm+IckNsQdmr6iRNl/Ddgl
         TZfsC4KTsftouh9VGmz59MhilH7rujFP05raDHUAZH5Xi5EWlFCynT1HTskQqqedn9rB
         bNZLOVzrIjX7CMthsOLeuEnX54UzIvTPO94RYEscESrC8Gl9lD87mbvFuYZVrKEwtaOg
         zvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678989534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xV3s4LWd6yBp667Ey97AEi8y92XCYe54yn3M9Ys8WNc=;
        b=fjeo/fElxe1U1Kw7c8yUZ5+Pbqz3jG7DaD55ClNi4eFVSaqz8IZ+TrxOQf6iOgQdMN
         RvggB31/+TAsNmDPs9vhFZm4lsXj9F9HkIAa6T86g73Q+s1GdOA6vW7hLo/btrJSYNL+
         IFSqgOCLD6PhHsTTT8wIVzMupRFPhFkcobytyCbzYokDUgiT63kN9RCerlBNn8f1dFRP
         ltRZ5t/jnaE+EN1hJUacqyv6nlGJhnbAupto7Pk18kLcTcYdMiNPDgnvSwMKJjtEbHoF
         7b5oJmgH96nfSEcRrVt6ScQncOHYg8sLmIHyNsd2edfUbOY4pDxQgV+pnrnOlNFPQ590
         PTFg==
X-Gm-Message-State: AO0yUKUhWHoUa447MYv0hdSogCUBYF+j39OPH+ZkAW36y9ofqhnA228B
        +JPxBOX9Avm4NHnK/pgumsaa9Vlh0ZMpJKJoHy5q7caaInGYSanHrqQPbXiC
X-Google-Smtp-Source: AK7set+qMoiYFC/W9oxY3TW8A1Tb4Hyr5dxRBtWl5PU6ZOumIAziNMwzl3m4ftI9mO4ctedFCMJMeS9vgEO5I31NEMo=
X-Received: by 2002:a63:7519:0:b0:4fc:27db:45c2 with SMTP id
 q25-20020a637519000000b004fc27db45c2mr1176285pgc.2.1678989533933; Thu, 16 Mar
 2023 10:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230315105055.9b2be0153625.I7a2cb99b95dff216c0feed4604255275e0b156a7@changeid>
 <CAGS_qxrJ53EyQaf5WqfSBYhOF0+LvWgvKL4gExu9vCPxRb7ipw@mail.gmail.com>
 <e028d27b3e998eaba2d71b6e224eb707015f8edf.camel@sipsolutions.net>
 <CAGS_qxpYEnzWM=nPXDAbebuQERN4ijb0FKFbtmX5hK9qwVn12A@mail.gmail.com> <9a172b50457f4074af41fe1dc8e55dcaf4795d7e.camel@sipsolutions.net>
In-Reply-To: <9a172b50457f4074af41fe1dc8e55dcaf4795d7e.camel@sipsolutions.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 16 Mar 2023 10:58:42 -0700
Message-ID: <CAGS_qxoEOW+FN33czFOhJ7xgPeKjGsj=BMc4iF-aP53TfyiyEQ@mail.gmail.com>
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

On Thu, Mar 16, 2023 at 10:43=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Thu, 2023-03-16 at 10:35 -0700, Daniel Latypov wrote:
> > On Thu, Mar 16, 2023 at 12:42=E2=80=AFAM Johannes Berg
> > <johannes@sipsolutions.net> wrote:
> > >
> > > On Wed, 2023-03-15 at 23:02 -0700, Daniel Latypov wrote:
> > > > This is a good catch, thanks.
> > > > But we also have a few more bare generic types that warrant attenti=
on.
> > >
> > > Oh, that might well be true. I was using kunit_parser in a script, an=
d
> > > that imports kunit_printer, and then tried to check *my* script for t=
ype
> > > annotations with mypy. This led it to go check through the dependenci=
es
> > > too, and since it was just one small thing there I decided to just fi=
x
> > > it rather than figure out how to tell mypy that I don't care about th=
ose
> > > dependencies :-)
> >
> > There's --exclude=3D'<regex>', if you ever end up needing to ignore oth=
er files.
> > But yeah, we should try and make sure that mpyy is happy w/ kunit.py co=
de.
>
> Yes, but that has other complexities I think? Anyway, I didn't even
> really read much into it since it was so easy.
>
> > > Now for everything else? I didn't even look.
> >
> > Oh, does mypy complain about this now?
> > That'd be nice.
> >
> > Hmm, I don't see it even after upgrading my local version.
> > $ pip install --upgrade mypy pytype
> > $ ../tools/testing/kunit/run_checks.py
> > <no errors>
> > # Checking if it doesn't report error but logs a warning:
> > $ mypy ./tools/testing/kunit/*.py
> > Success: no issues found in 9 source files
>
> Oh, I use --strict, and
>
> $ mypy --version
> mypy 0.941
>
> right now. Probably old.
>
> And
>
> $ mypy --strict tools/testing/kunit/*.py
>
> has a _lot_ of complaints.

Yikes.
I either forgot or never knew about --strict, thanks for pointing it out.

Looking into it, I don't think it's worth using for kunit.py, details below=
.

With mypy 1.1.1, I get
  Found 172 errors in 5 files (checked 9 source files)

Counting the different types
... | grep -Po '\[[a-z-]+\]$' | sort | uniq -c | sort -nr
    108 [no-untyped-def]
     61 [no-untyped-call]
      1 [attr-defined]
      1 [assignment]

Hmm, the untyped stuff is not too important since we also use pytype,
which is a lot smarter in that it infers types where not specified.

The other two though warrant some attention
* attr-defined: we don't care about this. We have a directive to
squash this "error" for pytype. Ugh, do we need another one for
pytype?
* assignment: not actually a real error, it points to our type
annotations being a bit sloppy
  tools/testing/kunit/kunit.py:459: error: Incompatible types in
assignment (expression has type "List[str]", variable has type
"TextIO")  [assignment]

So it doesn't like that we assign a list[str] or a IO[str] to `kunit_output=
`.
But we're passing it in as Iterable[str], which both work as.

Even explicitly annotating it as an Iterable[str] doesn't make it happy [1]=
.
I'll ignore this, then.

Daniel

[1]
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 52853634ba23..a9f1146bcdce 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -453,10 +453,10 @@ def exec_handler(cli_args):
 def parse_handler(cli_args):
        if cli_args.file is None:
                sys.stdin.reconfigure(errors=3D'backslashreplace')  #
pytype: disable=3Dattribute-error
-               kunit_output =3D sys.stdin
+               kunit_output =3D sys.stdin  # type[Iterable[str]]
        else:
                with open(cli_args.file, 'r', errors=3D'backslashreplace') =
as f:
-                       kunit_output =3D f.read().splitlines()
+                       kunit_output =3D f.read().splitlines()  #
type[Iterable[str]]
        # We know nothing about how the result was created!
        metadata =3D kunit_json.Metadata()
        request =3D KunitParseRequest(raw_output=3Dcli_args.raw_output,
