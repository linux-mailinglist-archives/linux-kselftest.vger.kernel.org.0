Return-Path: <linux-kselftest+bounces-1840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E3281155D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 15:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631DD1C20F61
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8B12EB1E;
	Wed, 13 Dec 2023 14:57:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92512D780;
	Wed, 13 Dec 2023 14:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E630C433C8;
	Wed, 13 Dec 2023 14:57:06 +0000 (UTC)
Date: Wed, 13 Dec 2023 09:57:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] tracing/selftests: Add test to test the trace_marker
Message-ID: <20231213095749.5ff64569@gandalf.local.home>
In-Reply-To: <CAJ1xhMXuxGHfD8oRfbna_drpHmNv0RUXFrvuVv6rtt-KeCM9fQ@mail.gmail.com>
References: <20231212192317.0fb6b101@gandalf.local.home>
	<CAJ1xhMXuxGHfD8oRfbna_drpHmNv0RUXFrvuVv6rtt-KeCM9fQ@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Dec 2023 10:09:50 +0200
Alexander Kapshuk <alexander.kapshuk@gmail.com> wrote:

> The REs used in the sed commands below may be simplified as shown if desi=
red.
>=20
> On Wed, Dec 13, 2023 at 2:22=E2=80=AFAM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >
> > Add a test that writes longs strings, some over the size of the sub buf=
fer
> > and make sure that the entire content is there.
> >
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> > Changes since v2: https://lore.kernel.org/linux-trace-kernel/2023121215=
1632.25c9b67d@gandalf.local.home
> >
> > - Realized with the upcoming change of the dynamic subbuffer sizes, that
> >   this test will fail if the subbuffer is bigger than what the trace_seq
> >   can hold. Now the trace_marker does not always utilize the full subbu=
ffer
> >   but the size of the trace_seq instead. As that size isn't available to
> >   user space, we can only just make sure all content is there.
> >
> >  .../ftrace/test.d/00basic/trace_marker.tc     | 82 +++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >  create mode 100755 tools/testing/selftests/ftrace/test.d/00basic/trace=
_marker.tc
> >
> > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker=
.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
> > new file mode 100755
> > index 000000000000..b24aff5807df
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
> > @@ -0,0 +1,82 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: Basic tests on writing to trace_marker
> > +# requires: trace_marker
> > +# flags: instance
> > +
> > +get_buffer_data_size() {
> > +       sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_=
page =20
>             sed -n 's!.*data.*size:\([^;]*\).*!\1!p' events/header_page

Not sure the above change can be considered simpler, but it also loses out
showing what exactly is being done.

With the original, I have:

       sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_page

Which is obvious that I'm grabbing a number for the size field.

       sed -n 's!.*data.*size:\([^;]*\).*!\1!p' events/header_page

Shows that I'm grabbing something after size.



> > +}
> > +
> > +get_buffer_data_offset() {
> > +       sed -ne 's/^.*data.*offset:\([0-9][0-9]*\).*/\1/p' events/heade=
r_page =20
>             sed -n 's!.*data.*offset:\([^;]*\).*!\1!p' events/header_page

Same here.

> > +}
> > +
> > +get_event_header_size() {
> > +       type_len=3D`sed -ne 's/^.*type_len.*:[^0-9]*\([0-9][0-9]*\).*/\=
1/p' events/header_event` =20
>             type_len=3D`sed -n '/type_len.*bits/s![^0-9]*!!gp'
> events/header_event`

Honestly, the above may be "simplier" but I can't make out what exactly
that line is doing without going back and looking at the text that's in the
format field.

>=20
> > +       time_len=3D`sed -ne 's/^.*time_delta.*:[^0-9]*\([0-9][0-9]*\).*=
/\1/p' events/header_event` =20
>             time_len=3D`sed -n '/time_delta/s![^0-9]*!!gp' events/header_=
event`
>=20
> > +       array_len=3D`sed -ne 's/^.*array.*:[^0-9]*\([0-9][0-9]*\).*/\1/=
p' events/header_event` =20
>             array_len=3D`sed -n '/array/s![^0-9]*!!gp' events/header_even=
t`
>=20
> > +       total_bits=3D$((type_len+time_len+array_len))
> > +       total_bits=3D$((total_bits+7))
> > +       echo $((total_bits/8))
> > +}
> > +
> > +get_print_event_buf_offset() {
> > +       sed -ne 's/^.*buf.*offset:\([0-9][0-9]*\).*/\1/p' events/ftrace=
/print/format =20
>             sed -n 's!.*buf.*offset:\([^;]*\).*!\1!p' events/ftrace/print=
/format
> > +}
> > +

Yeah, thanks for the suggestions, but I rather have it be more readable
than "simplified". I write perl code the same way. I do not write it like
any perl developer would, because I write it like C code. I want my code to
be easily understandable.

RE can become extremely obfuscated. So, even though my REs are not the
simplest, they tend to be rather easy to understand what they are doing,
and why.

Cheers,

-- Steve

