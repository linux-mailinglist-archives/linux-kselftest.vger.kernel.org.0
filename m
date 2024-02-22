Return-Path: <linux-kselftest+bounces-5321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4655860711
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 00:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D901D1F2340F
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 23:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879611C680;
	Thu, 22 Feb 2024 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4C5sN+/w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370F14B815
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 23:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708645071; cv=none; b=UzlE9UtlAnh+g/JKVQ3T5NK66CKXxdqnb8Obrby9WUwAI5Bao+y5NDEF9FeH3RWSnZuzozCEAuzb5hkcGlgHFedE/xtdU9Jl7erIDqee6ohEmQWPQOxDWgl/M1ajHMRMgitywaPp47Z3r3elBI7RjNgZDgnzyr8uDDqpR4/Ik2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708645071; c=relaxed/simple;
	bh=f/lgEVxAapn9LU5P4MSUpHzwUuNz+DzPlQ8crsjgIUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=la/U7A83SjuNMQRLPdm6Go4dmQW8/zKwnOuyWhbbisR3Cd4OMlHV7EveCK5R2A6Ixyu/QYS1EmJpC267VDX0jKfRI6M7cmRfQZuH8vagemPk6wlX8HLtUnLvFbXmvfpFOrG99Q2MFFtVNoxlrI6O4jaQWHPNuWYu+OfmLy3SbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4C5sN+/w; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so2159a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 15:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708645068; x=1709249868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIMJ44zSEPY3QuIze2cPVqSa+denNNP9zamzlju/GhU=;
        b=4C5sN+/wGgh9srSUvjhFkuakajf1MJh34jR2AxlKIXPKiHQVBMUdV/H8U9K8oNY7+Y
         MIxDV/122pR6WMKMliTja6i1VwQlOKgz07mJObVUGCzAUNsWRxd470tM5Y+oA0DvgNxb
         kDgdfS45LWRq4GYBJLlWl+F2jJ7B8gTm3FIU855XAZB61WzCVS+83HpJJ8lXGpVjtgup
         LKDvEdAhl9Ol4ppmJrsKAx6RYv+ksWQGCKA5yB71XTa+Gw6ZBAH4C2kQEL66bp5gVsoC
         H0E9EyzZb8Atw43obkR2JpYGK6NE4tvb7y9CvMqtM1WoFGnooISZXKJiQhVg9+G/g3YO
         9Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708645068; x=1709249868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIMJ44zSEPY3QuIze2cPVqSa+denNNP9zamzlju/GhU=;
        b=cn04VAgULYnuvrzBEGi3VZK5ZZT0Q6mhVu8MeI4lJedXKrC8m3NTL6BjRywgwHyMnk
         vyDBPXPSVG+ThJfsje4dlzt/dPA/KqPkjiJX+l9Opgm1BPQE02QOruZX/DgSGHyXqY+n
         XnzdLxE+BxaSu4J9vOjfluwdVOtMBtXDh9+X28Ymc7wq5uOYsvzya1upX4minzk9ijDB
         dI6Ha+vOKdvTWUt0PqwitdLqokfAS9oL8jiCniVCt7W2Y57R1rIaOW8u/lvKFY2coOP+
         AVtdY5OFjKHOvXFa5uFHwGo1NqO/UI4dNmPEAavGayCmdPX7XopPxpcqwhZAoFqKdOI8
         EOyg==
X-Forwarded-Encrypted: i=1; AJvYcCWEJQGJVgdYetolrKcEcTlG2p0uftBtJ/f+A92W2nLbAm3egpa+QfJJNBGs9AjVShF/E9KCIiY0VlentAQm2QMjqbL/k7uLS/Dhd/eu8Ytp
X-Gm-Message-State: AOJu0YzeUwsvFQzFkhSP1rLyqL6uiLu7fTTDJ+PdiHfAU0sQDX6hrnjG
	LuSWZ+Rt3EfdPp6xomjFeK5RpkMLlrbiRtWadqyZJL8B3+cIy10kK1wbhljnoGl7y49rA7OntOJ
	qfIS9yJDbFUovlAKL0PJqBsQBARfqUaufiQbJ
X-Google-Smtp-Source: AGHT+IFoD52gYH3sO6MerCtxOu2jS63yBmcWTPfXTimkdoS6Epy8Tt3BcnhUR1l2Ln1NpSh+MBAbvvPwpkxrBi0gQtc=
X-Received: by 2002:a50:9f04:0:b0:562:9d2:8857 with SMTP id
 b4-20020a509f04000000b0056209d28857mr584121edf.6.1708645067849; Thu, 22 Feb
 2024 15:37:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222221814.3572215-1-rmoar@google.com>
In-Reply-To: <20240222221814.3572215-1-rmoar@google.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Thu, 22 Feb 2024 15:37:35 -0800
Message-ID: <CAGS_qxqQ09wUppF9s1BgNoj5T2yo8+Yd0RLRBisj5th7Yw97eQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: add parsing of all files in directory
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, davidgow@google.com, brendan.higgins@linux.dev, 
	kevko@google.com, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 2:18=E2=80=AFPM Rae Moar <rmoar@google.com> wrote:
>
> Add ability to parse all files within a directory. Additionally add the
> ability to parse all results in the KUnit debugfs repository.

Nice, I'd been hoping for this.
It's enough to pull me back in for a bit :)

<snip>

>  tools/testing/kunit/kunit.py | 45 ++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index bc74088c458a..827e6dac40ae 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -511,19 +511,40 @@ def exec_handler(cli_args: argparse.Namespace) -> N=
one:
>
>
>  def parse_handler(cli_args: argparse.Namespace) -> None:
> -       if cli_args.file is None:
> +       parsed_files =3D []

optional: can we annotate the type?
  parsed_files =3D []  # type: List[str]

> +       total_test =3D kunit_parser.Test()
> +       total_test.status =3D kunit_parser.TestStatus.SUCCESS
> +       if cli_args.file_path is None:
>                 sys.stdin.reconfigure(errors=3D'backslashreplace')  # typ=
e: ignore
>                 kunit_output =3D sys.stdin  # type: Iterable[str]

This branch no longer does anything, since we only parse what's in
`parsed_files`

E.g. if you try
$ kunit.py parse $FILENAME
it'll work whereas
$ kunit.py parse < $FILENAME
will do nothing

We'll need to rework the control flow somehow

> -       else:
> -               with open(cli_args.file, 'r', errors=3D'backslashreplace'=
) as f:
> +       elif cli_args.file_path =3D=3D "debugfs":
> +               for (root, _, files) in os.walk("/sys/kernel/debug/kunit"=
):
> +                       for file in files:
> +                               if file =3D=3D "results":
> +                                       parsed_files.append(os.path.join(=
root, file))
> +       elif os.path.isdir(cli_args.file_path):
> +               for (root, _, files) in os.walk(cli_args.file_path):
> +                       for file in files:
> +                               parsed_files.append(os.path.join(root, fi=
le))

just a note here, we could make this a bit terser via
  parsed_files.extend(os.path.join(root, f) for f in files)

and the debugfs branch could be rendered as
  parsed_files.extend(os.path.join(root, f) for f in files if f =3D=3D "res=
ults")

> +       elif os.path.isfile(cli_args.file_path):
> +               parsed_files.append(cli_args.file_path)

nit: should there be an `else` here that prints a warning?

Example that would trigger this case and silently do nothing
$ mkfifo /tmp/example_fifo
$ ./tools/testing/kunit/kunit.py parse /tmp/example_fifo
<no output>


<snip>

> @@ -569,8 +590,8 @@ def main(argv: Sequence[str]) -> None:
>                                             help=3D'Parses KUnit results =
from a file, '
>                                             'and parses formatted results=
.')
>         add_parse_opts(parse_parser)
> -       parse_parser.add_argument('file',
> -                                 help=3D'Specifies the file to read resu=
lts from.',
> +       parse_parser.add_argument('file_path',
> +                                 help=3D'Specifies the file path to read=
 results from.',

Should this mention that the make `debugfs` string works?

>                                   type=3Dstr, nargs=3D'?', metavar=3D'inp=
ut_file')

Tangent: would it be useful to allow the user to pass in multiple
files now and set this to nargs=3D'*'?

E.g.
$ kunit.py parse /my/dir/some_prefix*

It would also let people implement their own version of the debugfs logic v=
ia
$ find /other/debugfs/dir -name 'results' | xargs kunit.py parse

That could be useful if the user has recursively copied off the
debugfs from a test machine and wants to inspect it elsewhere, for
example.

Thanks,
Daniel

