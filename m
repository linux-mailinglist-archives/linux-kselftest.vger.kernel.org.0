Return-Path: <linux-kselftest+bounces-26386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89865A31045
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAF61687CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCF71F9A90;
	Tue, 11 Feb 2025 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMgm/+CA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB38253F0A;
	Tue, 11 Feb 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289074; cv=none; b=mtHhTAXnVLtFgZZGNsCsuxUfrefbnr9xZsiaxvHjtrcn6bWYvUTL1v77xfWHwQ/i4cJVzHHYvWzT3HEfqJaliO3TwWi6+9ScOZFlLns08oRsMqn4y2RzusI2gxFFzUPReFNMFuLP76FMXJiNtNBbVXO5WfWKVV0jq1bo17f4wn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289074; c=relaxed/simple;
	bh=9+BTG59xNBgxsmbjYSO3ekhbooFv8R61BfLe2SiobyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZdgdJP9FmbZckQQRRUvdRvJNtba0hvG/Nw8wHBXMidRlJ/h8mQfdSQV0RhHUdmSev/s3A1bhrXGZRwZg1n4lE8GQa3D5jytpbM32aK4LaZuALEzdEE6ENo3T+GsNSFZUDI4gk5jpNQF1n85dafypfJK0ZXLzGFqppwyMtxu/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMgm/+CA; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-308edbc368cso23601411fa.1;
        Tue, 11 Feb 2025 07:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739289070; x=1739893870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyT/fzJvCNJRfnP0OzE1ixLddKVGkFH+rre9ilcTHpw=;
        b=OMgm/+CADe3mhdY8Ea5OgC/vYPkyztynt4m28yCnJ3ax9VUi0j7o8qMAfLMAIEAgne
         a4sse0jwDbuR33lXwcJAczYyL0msPOpgMakidzrhIRmTBk3zX/1S2UU2wle7ri83ACVG
         08NzFxasysYj7/gEG5RnOdaTrOMMPT9/pIKfvia8T5ym0MHMmD6G/MFQLr4HdgvucJ9X
         n+kcUM0TUXIFv4CLgDPI7o85T3Grf716kuoQi1K8TA10wKS5kJo/pzr8xHstC002kwJo
         jE7ZroahFD0HtxOwRSzP7V1+mR2Ho4J96SSP8SEKUm5w1bHsQ4NCH6jTJK59sZ8cpksd
         auHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739289070; x=1739893870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyT/fzJvCNJRfnP0OzE1ixLddKVGkFH+rre9ilcTHpw=;
        b=Ei2JdvzoOZSdtblmi+hW/YTdixndXDuICtig3t133feNWSMRBKc2Wl0zepxKdmgTQm
         2xxkOcCrwqEGhtfEI6Vlta9WG0iGV4o/VHWtcb+MOUg0YLdpWnzS0VKLj23wN4Ps2vh/
         HKgOZ1EPXJsPRZrXpft37Tjj0NYSidnpD66hd9Z9ZqKySHbL4btCnrf/SlYWY33TEfMp
         RZloL4sNS7Y8v+szgV0mr88nJlQNvKBc+G0N+USW2ImtInwBvjBT6yBfRKC4/XJukkdD
         pbWzMIRXBF+Jccy8amiaL+H3Yo3k1n4h5oMtJkFXBBKwwiER/7sSb6ThnLS6u+MAiPwe
         GZfw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Twv5kJ4qMsAT1nMZF712jsUVphghCPROpEYqX2msV+uM3dXIh5pplc99Jh3W9+nxg2t0PBeYes3x462wubkA@vger.kernel.org, AJvYcCWfl0xK+lxNnzm+HcuqyIXdikeiPpk0P4SkECQfyqSDZxWpcbmmiPU54mQXw1l6HveKC6YDmktzPkb8EbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdV4Lzjx/H/h6YcrLS0Q6xRm2wvEAH+RL40DtgCcecfUcbPcfz
	LnouKol/93w5C2Pp5wAalF3ouyCOjbfDs4EP80x3TkzaHZ/Z3qHLDDRfdIPTOFnD6qvKDYs9iCB
	90t/xKk51aeeLKzMH+Od0vcZjc/o=
X-Gm-Gg: ASbGncu9ZhG2qXZOabTs3V/QkESbdkibaC7pqzo3qGL5WQZiAGzM/VA5DPHO+57C9ry
	S1ldIc16rhR1/7s2o6HrmnKWhc7c48+N5z+jS4WFcBab5kyUi5MYgOv/HuUgiTLCSg0T22imL6f
	aKaai9YeB+xG6K
X-Google-Smtp-Source: AGHT+IFRZxhbg/+RfmvoA6FMMqgByNardOW4ze1OQ/eZb9rILgw2kxdYln54C1w9Ai0dBos7sBKoSFwUvsCxxG/iFy4=
X-Received: by 2002:a2e:a5c8:0:b0:307:e498:1269 with SMTP id
 38308e7fff4ca-308f83eafa5mr17168611fa.37.1739289070236; Tue, 11 Feb 2025
 07:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
 <20250211-scanf-kunit-convert-v7-1-c057f0a3d9d8@gmail.com> <Z6tvzhZIMVKWH8kK@smile.fi.intel.com>
In-Reply-To: <Z6tvzhZIMVKWH8kK@smile.fi.intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 10:50:33 -0500
X-Gm-Features: AWEUYZndyWReLL6ahdZpnCQZqQNzd_O15gnmVq35KHOms0Vbxdy4RUmDQf-9urc
Message-ID: <CAJ-ks9=Bf42eojROr1X+BnmeQLa=zF7EAr4Y3n2exwZXum+rbQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] scanf: remove redundant debug logs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 10:42=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 11, 2025 at 10:13:37AM -0500, Tamir Duberstein wrote:
> > The test already prints the same information on failure; remove
> > redundant pr_debug() logs.
>
> ...
>
> >  #define _check_numbers_template(arg_fmt, expect, str, fmt, n_args, ap)=
               \
> >  do {                                                                  =
       \
> > -     pr_debug("\"%s\", \"%s\" ->\n", str, fmt);                       =
       \
>
> What *if* the n_args =3D=3D 0 here?

Then there's no assertion in this block, so the test cannot possibly fail h=
ere.

> >       for (; n_args > 0; n_args--, expect++) {                         =
       \
> >               typeof(*expect) got =3D *va_arg(ap, typeof(expect));     =
         \
> > -             pr_debug("\t" arg_fmt "\n", got);                        =
       \
> >               if (got !=3D *expect) {                                  =
         \
> >                       pr_warn("vsscanf(\"%s\", \"%s\", ...) expected " =
arg_fmt " got " arg_fmt "\n", \
> >                               str, fmt, *expect, got);                 =
       \
> > @@ -689,7 +687,6 @@ do {                                               =
                               \
> >       total_tests++;                                                   =
       \
> >       len =3D snprintf(test_buffer, BUF_SIZE, gen_fmt, expect);        =
         \
> >       got =3D (fn)(test_buffer, &endp, base);                          =
         \
> > -     pr_debug(#fn "(\"%s\", %d) -> " gen_fmt "\n", test_buffer, base, =
got);  \
> >       if (got !=3D (expect)) {                                         =
         \
> >               fail =3D true;                                           =
         \
> >               pr_warn(#fn "(\"%s\", %d): got " gen_fmt " expected " gen=
_fmt "\n", \
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

