Return-Path: <linux-kselftest+bounces-5300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F399885FF82
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 18:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3391B283B9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6D115531B;
	Thu, 22 Feb 2024 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ESR0p+cS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D891552E8
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623377; cv=none; b=jV4gERVz4Ezc+tiI3zy8F/dwJq3euO5RMApK6Uit9mNFacOKbqtmrAsYD/QuSLF916/ZHwutVBg9iCvwiv3ww68uLsSFBL5sLzN+UlcGjNvQ1dzE37EhwDgtmtfRpmbtGyp6XLJUpRChPquJxoROpMe/2yMDC8CN8Sf5P64DcHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623377; c=relaxed/simple;
	bh=d65n5xxTD0/aMcmzOPHCt3iAilOWcSe0SlSiiwYdBzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpUAvga6f2Hbp3JyjzIIg73IezigoDvCBK6xqL73vzVDEAlnIdUNY/CwxfTZhf3AthwKCkMYroQAahnywLiX6Al2KtiyqvGLWrxcbuCQqR0YgYlG/OlgW3AcBOfZ084TTeLyYSx3Crvq3LIQqAueBzfzZwYYKrt6xMAhlZw4vls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ESR0p+cS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so14789a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 09:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708623374; x=1709228174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmEKVyetFL548x1phH+vDmo2g1KI7fqBu5h2gLzPo5M=;
        b=ESR0p+cSLbdxqzoHOZabd9oYJwWEocaERPdJJs4ITL6QBBGaaJMHK4fVfg+ZvRsQyi
         EYORRqjXcYZlZZXs74sZMngIj4N+C6OmIzT9oO+S9mGwDejeyphXxyevGC+91dCUldJO
         rhmPzkAbE/aALEtx0qRCEcfl5oe/vQVDclbLqJXoXqdyKTjuMyCYqpziKiMh4UMWmA1V
         An/H5izoWpgYF8AT0hsN37q32SxvCluK+P5LB63hDrOcwGgghKcLdNBBzrxtU8ySWqEu
         u5akKAqWLRhfH4feiw2SrT4nLBSE6aCW7XU5FDe436WCTE5Q2dJ/BhjCpUo2UhQ1YUkD
         D4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623374; x=1709228174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmEKVyetFL548x1phH+vDmo2g1KI7fqBu5h2gLzPo5M=;
        b=nemz+AUKzAZ7tvreT5MQAzwaoyO+BV7PrPaSDEuA/W5UEMS4w9uPvp+z9JtGBKnzEP
         FLEbCDsoTjWqL1YTtJiyhWyzrp5gG7RJuJtKYvD9kXbKhN7VlHVCAob9EpPu911u0+iK
         AiEA6EErAw3/u0TuJmDvexXp5omYDKyNnKBQfK0F9v5dgXi+Iqum+DQozeRIHMnYCx9w
         +AorNCGZQX7s9Oied/4F+cFn/1H99xYFy6KVbwz5BrrTRC6qGW0YlJI7Kb9S3l530QXc
         PsHY71eMNVQPvRoMYT+iD7RvuPnB/3SzCy5xbVGdW6B68Uzo0KuOHw5yonbMyUwTW+nz
         aUiw==
X-Forwarded-Encrypted: i=1; AJvYcCVTIJ7O9JK+M7hXD6xOp/BXu/fXc+WSFVDY/wO7O3dVnddctf7CpA5lHyMo02jLvJw5BzZijWQq0NiYclVY8mCzUJmX93ApJOFYC9577VA4
X-Gm-Message-State: AOJu0Yxni8XxslKTMjOWqATqQevquJvHB8DUBtjtrusJ3E0EC1pqOxIM
	mbLhEFO7qZs/2Bry43qunPlmtpjG8O6GA76lxsIGAk7cpQtYvxI8ZzPL2ysuCxFE65kcc5i0gRt
	Gwnk+KVThZ+tfeBZHSY18rzNCRRVMY1n15+1l
X-Google-Smtp-Source: AGHT+IH+4QsAKS6v2wz/3Ohm5UGixFC1Is/yek5Qgz+ij5+wrc7QXl4sCi0AbqHTx6nwjSX1cBP+z7ipSxtuApYMC+k=
X-Received: by 2002:a50:c309:0:b0:565:4b98:758c with SMTP id
 a9-20020a50c309000000b005654b98758cmr128301edb.4.1708623373891; Thu, 22 Feb
 2024 09:36:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com> <20240221092728.1281499-3-davidgow@google.com>
 <20240221201008.ez5tu7xvkedtln3o@google.com> <CABVgOSn+VxTb5TOmZd82HN04j_ZG9J2G-AoJmdxWG8QDh9xGxg@mail.gmail.com>
In-Reply-To: <CABVgOSn+VxTb5TOmZd82HN04j_ZG9J2G-AoJmdxWG8QDh9xGxg@mail.gmail.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Thu, 22 Feb 2024 09:36:01 -0800
Message-ID: <CAGS_qxoW0v0eM646zLu=SWL1O5UUp5k08SZsQO51gCDx_LnhcQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] lib/cmdline: Fix an invalid format specifier in an
 assertion msg
To: David Gow <davidgow@google.com>
Cc: Justin Stitt <justinstitt@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rae Moar <rmoar@google.com>, Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Kees Cook <keescook@chromium.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Stephen Boyd <sboyd@kernel.org>, 
	David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:22=E2=80=AFPM David Gow <davidgow@google.com> wr=
ote:
>
> On Thu, 22 Feb 2024 at 04:10, 'Justin Stitt' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > Hi,
> >
> > On Wed, Feb 21, 2024 at 05:27:15PM +0800, David Gow wrote:
> > > The correct format specifier for p - n (both p and n are pointers) is
> > > %td, as the type should be ptrdiff_t.
> >
> > I think %tu is better. d specifies a signed type. I don't doubt that th=
e
> > warning is fixed but I think %tu represents the type semantics here.
> >
>
> While I agree that this should never be negative, I'd still lean on
> this being a signed type, for two reasons:
> - I think, if there's a bug in this code, it's easier to debug this if
> a 'negative' value were to appear as such.
> - While, as I understand it, the C spec does provide for a
> ptrdiff_t-sized unsigned printf specifier in '%tu', the difference
> between two pointers is always signed:
>
> "When two pointers are subtracted, both shall point to elements of the
> same array object,
> or one past the last element of the array object; the result is the
> difference of the
> subscripts of the two array elements. The size of the result is
> implementation-defined,
> and its type (a signed integer type) is ptrdiff_t defined in the
> <stddef.h> header"
>
> (Technically, the kernel's ptrdiff_t type isn't defined in stddef.h,
> so a bit of deviation from the spec is happening anyway, though.)
>
> If there's a particularly good reason to make this unsigned in this
> case, I'd be happy to change it, of course. But I'd otherwise prefer
> to keep it as-is.

Copying the line for context, it's about `p-r` where
  p =3D memchr_inv(&r[1], 0, sizeof(r) - sizeof(r[0]));
`p-r` should never be negative unless something has gone horribly
horribly wrong.

So in this particular case, either %tu or %td would be fine.

(sorta bikeshedding warning)
But, I'd personally lean towards using the signed %td in tests to
guard against typos in test code as _a guiding principle._

This is especially true given that the failure messages aren't
verified since they are mostly "dead code."
You can have crazy incorrect things going on in the format arguments,
see patch 1/9 in this series [1]. One of kunit's own tests would do a
read from a ~random memory region if that specific assertion failed.
Not a good look ;)
We never noticed until this series enabled the format string checks.
You also can't expect reviewers to go through and modify every
assertion to fail to see what the failure mode looks like, so these
kinds of errors will continue to slip through.

*So IMO, we should generally adopt a more defensive stance when it
comes to these.*

Also consider the user experience if there is a failure and I
accidentally wrote `r-p` here.
Someone else sees an error report from this test and needs to investigate.

What message is easier to deal with?
>  in test 18 at -5 out of bound
or
> in test 18 at 18446744073709551611 out of bound

Sure, I can eventually figure out what both messages mean, but it's a
immediately obvious from the first that there's a
a) real error: something is wrong at index 5
b) test code error: there's a flipped sign somewhere

So I'd strongly prefer the current version of the patch over one with %tu.
Reviewed-by: Daniel Latypov <dlatypov@google.com>

[1] https://lore.kernel.org/linux-kselftest/20240221092728.1281499-2-davidg=
ow@google.com/

Thanks,
Daniel

