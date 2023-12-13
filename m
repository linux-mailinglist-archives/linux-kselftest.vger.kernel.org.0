Return-Path: <linux-kselftest+bounces-1846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5846B8115D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 16:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6361F2122F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CD72FC57;
	Wed, 13 Dec 2023 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BimPnpda"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E7C93;
	Wed, 13 Dec 2023 07:08:38 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5e25d1d189eso12141507b3.0;
        Wed, 13 Dec 2023 07:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702480117; x=1703084917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEPH+eGb7fInmyjspViQgARNCBB0nvNmZOxruBaRhvo=;
        b=BimPnpdaCkKjDBvk3uTHztLC3ubFE0Zhz3tNWxp4ag27TMQ/2lZrjTg/snQaKK0Khq
         2vjrad3JIC9DCgLOajyHtnq0NncAbeSYs4y5n8d/PYGZ3ulrEQfDMejs1YYm4o4gJpKg
         CHQb5HEl0bepnAVvTSQWm7TZpiNIk23uIQ2EZV8lVAPPyL+w/CUy+XACOWCNWVa+T7AS
         FR90rKbDwgKLclz6ZGChnCTpHwuQ/gqWJNrozxDsN8UvEGrZ3L63HdsiW2CZYGorZW03
         Z8R8M0XyMQe3q+Fak8h6/HS2//kCNqp++ifa3QYjJUb+R/wWPuA2XwoJXlyfWz04eU1V
         nqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480117; x=1703084917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEPH+eGb7fInmyjspViQgARNCBB0nvNmZOxruBaRhvo=;
        b=eCgLPihZC95RnOvHWTFUo0/HU5GrrBBw7PvVVdZmeM1zV3VFEjfp4R+wcaFV51+m1X
         SQisWEg7gAzXJtzvE84IsgOdA2XpQb0GYv6KRREdXpHO30URS/PExTApbk02k0K7ZvX1
         /HGFvIz4ZoPKF1QC3+r91oX47a09fmJPKjmK1yRra7ao7cR/JwrGt/Xg/gHDtO6BGTCP
         qpmy0d7tvO69U6Xotnt9IuGijNCiSc1cVkT2Zwjm2vYXgtIkMO8yWeqB2LO1HKkh4eIR
         tKvUlLpyASwT0uMOTol4ZTxTXoVycv5MMpilNuWRnDYTydP3UgSAA7BDIx07lmwSOHZ0
         Gl2A==
X-Gm-Message-State: AOJu0YybDVJQLGOEt8YcrwbXWAdqkWuqDrCxjClgpZEZVfy4skaBcnTX
	cPkuPTiRA1jJP+EAkt2NB4v1p9prKeDBNe0VtUo=
X-Google-Smtp-Source: AGHT+IHZ1nfNR9vXmBz+sH0sXLqiasSHG8T5FbDCZM8w257s2tr3nxL3sXCgYMyl1ZNOSVwYaT+cf10XYgtSPrBacP4=
X-Received: by 2002:a81:df03:0:b0:5cb:1b6e:da89 with SMTP id
 c3-20020a81df03000000b005cb1b6eda89mr6487759ywn.12.1702480117084; Wed, 13 Dec
 2023 07:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212192317.0fb6b101@gandalf.local.home> <CAJ1xhMXuxGHfD8oRfbna_drpHmNv0RUXFrvuVv6rtt-KeCM9fQ@mail.gmail.com>
 <20231213095749.5ff64569@gandalf.local.home>
In-Reply-To: <20231213095749.5ff64569@gandalf.local.home>
From: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date: Wed, 13 Dec 2023 17:08:00 +0200
Message-ID: <CAJ1xhMX-gH+WgQnXd-bAQLEoipjZ_Fcbj=PRnpY64Kth1iFryg@mail.gmail.com>
Subject: Re: [PATCH v3] tracing/selftests: Add test to test the trace_marker
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 4:57=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 13 Dec 2023 10:09:50 +0200
> Alexander Kapshuk <alexander.kapshuk@gmail.com> wrote:
>
> > The REs used in the sed commands below may be simplified as shown if de=
sired.
> >
> > On Wed, Dec 13, 2023 at 2:22=E2=80=AFAM Steven Rostedt <rostedt@goodmis=
.org> wrote:
> > >
> > > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > >
> > > Add a test that writes longs strings, some over the size of the sub b=
uffer
> > > and make sure that the entire content is there.
> > >
> > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > ---
> > > Changes since v2: https://lore.kernel.org/linux-trace-kernel/20231212=
151632.25c9b67d@gandalf.local.home
> > >
> > > - Realized with the upcoming change of the dynamic subbuffer sizes, t=
hat
> > >   this test will fail if the subbuffer is bigger than what the trace_=
seq
> > >   can hold. Now the trace_marker does not always utilize the full sub=
buffer
> > >   but the size of the trace_seq instead. As that size isn't available=
 to
> > >   user space, we can only just make sure all content is there.
> > >
> > >  .../ftrace/test.d/00basic/trace_marker.tc     | 82 +++++++++++++++++=
++
> > >  1 file changed, 82 insertions(+)
> > >  create mode 100755 tools/testing/selftests/ftrace/test.d/00basic/tra=
ce_marker.tc
> > >
> > > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_mark=
er.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
> > > new file mode 100755
> > > index 000000000000..b24aff5807df
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
> > > @@ -0,0 +1,82 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# description: Basic tests on writing to trace_marker
> > > +# requires: trace_marker
> > > +# flags: instance
> > > +
> > > +get_buffer_data_size() {
> > > +       sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/heade=
r_page
> >             sed -n 's!.*data.*size:\([^;]*\).*!\1!p' events/header_page
>
> Not sure the above change can be considered simpler, but it also loses ou=
t
> showing what exactly is being done.
>
> With the original, I have:
>
>        sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_pag=
e
>
> Which is obvious that I'm grabbing a number for the size field.
>
>        sed -n 's!.*data.*size:\([^;]*\).*!\1!p' events/header_page
>
> Shows that I'm grabbing something after size.
>
>
>
> > > +}
> > > +
> > > +get_buffer_data_offset() {
> > > +       sed -ne 's/^.*data.*offset:\([0-9][0-9]*\).*/\1/p' events/hea=
der_page
> >             sed -n 's!.*data.*offset:\([^;]*\).*!\1!p' events/header_pa=
ge
>
> Same here.
>
> > > +}
> > > +
> > > +get_event_header_size() {
> > > +       type_len=3D`sed -ne 's/^.*type_len.*:[^0-9]*\([0-9][0-9]*\).*=
/\1/p' events/header_event`
> >             type_len=3D`sed -n '/type_len.*bits/s![^0-9]*!!gp'
> > events/header_event`
>
> Honestly, the above may be "simplier" but I can't make out what exactly
> that line is doing without going back and looking at the text that's in t=
he
> format field.
>
> >
> > > +       time_len=3D`sed -ne 's/^.*time_delta.*:[^0-9]*\([0-9][0-9]*\)=
.*/\1/p' events/header_event`
> >             time_len=3D`sed -n '/time_delta/s![^0-9]*!!gp' events/heade=
r_event`
> >
> > > +       array_len=3D`sed -ne 's/^.*array.*:[^0-9]*\([0-9][0-9]*\).*/\=
1/p' events/header_event`
> >             array_len=3D`sed -n '/array/s![^0-9]*!!gp' events/header_ev=
ent`
> >
> > > +       total_bits=3D$((type_len+time_len+array_len))
> > > +       total_bits=3D$((total_bits+7))
> > > +       echo $((total_bits/8))
> > > +}
> > > +
> > > +get_print_event_buf_offset() {
> > > +       sed -ne 's/^.*buf.*offset:\([0-9][0-9]*\).*/\1/p' events/ftra=
ce/print/format
> >             sed -n 's!.*buf.*offset:\([^;]*\).*!\1!p' events/ftrace/pri=
nt/format
> > > +}
> > > +
>
> Yeah, thanks for the suggestions, but I rather have it be more readable
> than "simplified". I write perl code the same way. I do not write it like
> any perl developer would, because I write it like C code. I want my code =
to
> be easily understandable.
>
> RE can become extremely obfuscated. So, even though my REs are not the
> simplest, they tend to be rather easy to understand what they are doing,
> and why.
>
> Cheers,
>
> -- Steve

Fair enough.
Thanks.

