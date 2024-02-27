Return-Path: <linux-kselftest+bounces-5497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F0286A05F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 20:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990FD288CB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA7A524D4;
	Tue, 27 Feb 2024 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOZ8xGJZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD56376
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062879; cv=none; b=pkdZvINx6CCbudtqbq9X/Ro2577NaZb4qVhNi2LshBwSIL/sbT5V/4TXPUSmxVf47Awf54DKW5coMF9BrGi2ESTVcx0A+0+ZksfsKLFd4XvcFPy3RRqXVkNmxedpGojSL8+RgA7NBBOQ78B0pyYjuHquQazzwbtnZPyp7C+9bFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062879; c=relaxed/simple;
	bh=zbekMlrn7vcZ2XA2kYLqU8YdKEnzZ3RU12A9vKAe1qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5fXLGJPwwmCpLsUw54pjGhJRXh2dRGfyVy5ZFOtLYrVXtYDS0zEOmpVXKAOxVDSLZK+EVqRdZNdLIf0uCP9PYH73/ZRvkm6OXnFAdOnUYPu5H/Sz4KY9Y27SubQL0MxOzhTOYlsVyyY44X8NIfyLkSQ81CneWI/mYrXdGxHTmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOZ8xGJZ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-428405a0205so51541cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 11:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709062877; x=1709667677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kmy0Y9ggXPQX3ZKJXTwDEXzgywyH4ISUr8AQOAMPX0=;
        b=hOZ8xGJZIf2pQyWCxLS8GWaZOX9gkNTQVIq/5b2Y4UhMp8V6YRHNTangeooNNtnLwQ
         nPueZ/re0XyaojSqYlU8NhdR8+58Pa5cm3OpHwGwj7/P9toXmTvs/tYmooXQtBxdT7BZ
         kSIBbjI2jM9quTzPimguy5JyUX/q42yqYMhLnJRT/sElK74sQpcCzKmaO4KqIbPIHyNa
         NGcEu8m5QZUcGGvYdprnG2F+W/9TuDB4lkMTvgUYMTxNoa8CJxSBd3VE8whPiLsA1oEy
         NYk8KIc1+FfN1e1ERn/9F5I0qZfKixeNu3DByz6gtFgelT0QXYslyNB0DAwgKAls43Ro
         UYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062877; x=1709667677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kmy0Y9ggXPQX3ZKJXTwDEXzgywyH4ISUr8AQOAMPX0=;
        b=B8aFcx+FTdzQZEhnKsGlT6uJDB8ot0TIPPx4Yp33/ppvrB6yt45OVjf7RFNn3ZKr33
         B7hOHzIdanvMPvXTryopDKbXp/b6Ct7g2B9O2xCjvC1ywJEaBmfIm5n9JPgGkS6KmFrq
         S9+H8LPsGw3yXtrNMtdDbRKq1LPdmDahk1pxBs+jwQMKtO+t1TqreHHX7LcHEmKELT/Y
         WPK8h7LIzFnPrQCYQZnaxOIR5CP/cY2km5fsH/+7XzniS0mKeYnu9u6+Fy9ONHYTwngr
         10Xt2MT46I1Jg3tPc2/7JX+44MiKuumv5KbDlUMl6CO/YYwJpzgyr5XXaqdNyU6gzZkC
         USpA==
X-Forwarded-Encrypted: i=1; AJvYcCW8gm4eUW+YJ+qGuDZ6GNUhdp+3XUJrv8S6v/knJdmeKxe8O9WuK2oJxhPR7nUXgOoMeE0z9gZuUHOGjXSfyMhBFErjO2jNO5R9nyp3I5SU
X-Gm-Message-State: AOJu0Ywwg8gtLfHyJ7R5OR/dTqF97IgD9DjAc4zwPgpXrmrUgaZaaGf8
	g3qPfq5OnftLdcueXX4zY80gPzLTGYZiLhmSFV3X9OIgmG9nLEpp0/T6QkcjDWmXGec5dWS+iKe
	Ij4QitEESAzLtCbkxPJD08rW+D13GTYF94GSd
X-Google-Smtp-Source: AGHT+IG7+ANsowzp3aWo73JCwNd8g0AmTtzpnG9zTdwCzKeHLM+IZv7SMU7lKTBBWEII2yLupK5gzTpOUK4mJ3aKW1o=
X-Received: by 2002:a05:622a:d:b0:42e:a2a0:959c with SMTP id
 x13-20020a05622a000d00b0042ea2a0959cmr223695qtw.14.1709062877135; Tue, 27 Feb
 2024 11:41:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222221814.3572215-1-rmoar@google.com> <CAGS_qxqQ09wUppF9s1BgNoj5T2yo8+Yd0RLRBisj5th7Yw97eQ@mail.gmail.com>
In-Reply-To: <CAGS_qxqQ09wUppF9s1BgNoj5T2yo8+Yd0RLRBisj5th7Yw97eQ@mail.gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 27 Feb 2024 14:41:05 -0500
Message-ID: <CA+GJov5hCde3JAuwdZayzQ0HUkexbtgAVFrXbDeqpufV6OdC3g@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: add parsing of all files in directory
To: Daniel Latypov <dlatypov@google.com>
Cc: shuah@kernel.org, davidgow@google.com, brendan.higgins@linux.dev, 
	kevko@google.com, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 6:37=E2=80=AFPM Daniel Latypov <dlatypov@google.com=
> wrote:
>
> On Thu, Feb 22, 2024 at 2:18=E2=80=AFPM Rae Moar <rmoar@google.com> wrote=
:
> >
> > Add ability to parse all files within a directory. Additionally add the
> > ability to parse all results in the KUnit debugfs repository.
>
> Nice, I'd been hoping for this.
> It's enough to pull me back in for a bit :)
>
> <snip>
>
> >  tools/testing/kunit/kunit.py | 45 ++++++++++++++++++++++++++----------
> >  1 file changed, 33 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.p=
y
> > index bc74088c458a..827e6dac40ae 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -511,19 +511,40 @@ def exec_handler(cli_args: argparse.Namespace) ->=
 None:
> >
> >
> >  def parse_handler(cli_args: argparse.Namespace) -> None:
> > -       if cli_args.file is None:
> > +       parsed_files =3D []
>
> optional: can we annotate the type?
>   parsed_files =3D []  # type: List[str]

Hi Daniel!

Yes, happy to make this change for the next version.

>
> > +       total_test =3D kunit_parser.Test()
> > +       total_test.status =3D kunit_parser.TestStatus.SUCCESS
> > +       if cli_args.file_path is None:
> >                 sys.stdin.reconfigure(errors=3D'backslashreplace')  # t=
ype: ignore
> >                 kunit_output =3D sys.stdin  # type: Iterable[str]
>
> This branch no longer does anything, since we only parse what's in
> `parsed_files`
>
> E.g. if you try
> $ kunit.py parse $FILENAME
> it'll work whereas
> $ kunit.py parse < $FILENAME
> will do nothing
>
> We'll need to rework the control flow somehow

Ahh I see. Thanks for bringing this to my attention! I will change
this for the next version.

>
> > -       else:
> > -               with open(cli_args.file, 'r', errors=3D'backslashreplac=
e') as f:
> > +       elif cli_args.file_path =3D=3D "debugfs":
> > +               for (root, _, files) in os.walk("/sys/kernel/debug/kuni=
t"):
> > +                       for file in files:
> > +                               if file =3D=3D "results":
> > +                                       parsed_files.append(os.path.joi=
n(root, file))
> > +       elif os.path.isdir(cli_args.file_path):
> > +               for (root, _, files) in os.walk(cli_args.file_path):
> > +                       for file in files:
> > +                               parsed_files.append(os.path.join(root, =
file))
>
> just a note here, we could make this a bit terser via
>   parsed_files.extend(os.path.join(root, f) for f in files)
>
> and the debugfs branch could be rendered as
>   parsed_files.extend(os.path.join(root, f) for f in files if f =3D=3D "r=
esults")
>

Will do.

> > +       elif os.path.isfile(cli_args.file_path):
> > +               parsed_files.append(cli_args.file_path)
>
> nit: should there be an `else` here that prints a warning?
>
> Example that would trigger this case and silently do nothing
> $ mkfifo /tmp/example_fifo
> $ ./tools/testing/kunit/kunit.py parse /tmp/example_fifo
> <no output>
>

Yep you are definitely right I will add one here.

>
> <snip>
>
> > @@ -569,8 +590,8 @@ def main(argv: Sequence[str]) -> None:
> >                                             help=3D'Parses KUnit result=
s from a file, '
> >                                             'and parses formatted resul=
ts.')
> >         add_parse_opts(parse_parser)
> > -       parse_parser.add_argument('file',
> > -                                 help=3D'Specifies the file to read re=
sults from.',
> > +       parse_parser.add_argument('file_path',
> > +                                 help=3D'Specifies the file path to re=
ad results from.',
>
> Should this mention that the make `debugfs` string works?
>
> >                                   type=3Dstr, nargs=3D'?', metavar=3D'i=
nput_file')
>
> Tangent: would it be useful to allow the user to pass in multiple
> files now and set this to nargs=3D'*'?
>
> E.g.
> $ kunit.py parse /my/dir/some_prefix*
>
> It would also let people implement their own version of the debugfs logic=
 via
> $ find /other/debugfs/dir -name 'results' | xargs kunit.py parse
>
> That could be useful if the user has recursively copied off the
> debugfs from a test machine and wants to inspect it elsewhere, for
> example.
>

Oh this is an interesting idea. I will play around with it!

Thanks for looking this patch over!
-Rae

> Thanks,
> Daniel

