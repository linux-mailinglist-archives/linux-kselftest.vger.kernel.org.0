Return-Path: <linux-kselftest+bounces-1817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316B5810C0F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 09:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA232819DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 08:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505731D6A1;
	Wed, 13 Dec 2023 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El4NDQuG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DA1B2;
	Wed, 13 Dec 2023 00:10:27 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db4422fff15so5468537276.1;
        Wed, 13 Dec 2023 00:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702455026; x=1703059826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUkMcrhywTTNY4STrYR47RlN3P1eamS17VyWAZKRyOk=;
        b=El4NDQuGxT1pSeNmGDq4bNA5jnYOjjTs3bKViinEU/Fo6iCDWYY2a2yWtpNK9Ri8WN
         JAq1cIK04wvy5yLCPK5MBXQjGXJbxZ3pz3qJStt612w2C5GOO807OypzavHHbbZkqNhK
         e8jZm/neKPscNRDE8kW6lqN+nR5g7P+ma9L5H2WchqY3zsBa8hVGVbzAq0AwDi+04pB8
         uZq0Ly/Wbh+JtYtpZnHDq2AOd0qd+kJ9+s62skHyAgbqB8el4qPilU66QbjAStlEVanm
         2GCBycoQDfZdPqcCrrE8kfpYVbQu8zxhFM38n6EG2DotKaDmeRfkQ3UuxXE0K8iu5bWU
         iASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702455026; x=1703059826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUkMcrhywTTNY4STrYR47RlN3P1eamS17VyWAZKRyOk=;
        b=nO6BZODLgU7ijIPmj95YceuwGWLRbyJRFNOGCSNcl2XU0baIiNDKCiF8m4hG3IR3+/
         F1CGn+pfBVanzcA7RSFRqrGb18qKgz5GV+onZZ6+pqzS6JBNDfIrnKxFKUz6lcEDptAM
         iVDwiPu8NDNcz0qPE7jVuxJea6oMk0CoBuFw1qYeNdh+PkeWQGHc2r1lPXUxMbzuMyuv
         eHf9ydvxklo4kR8wF1XH9YYZIZpFqq/oxwhrdP28LiUjrRgHMltscY/YgxLjs5zDShV4
         dtlxMAjfIqKs9fzOE08PJBF6WcHlBwT5AVq/W/c7wDybAPRSmA+fw2VEGIclQL17YQNs
         rIcg==
X-Gm-Message-State: AOJu0Yzrdy9NGt0ez8oOu4i4h9SfHM00H8l+pG6DDfqm2EJV5ZRAGQl2
	Sm8vWNOKCCiZDSLpBpATQ8Tmr/LW4vqmfFbgmTaXcIQaKqA=
X-Google-Smtp-Source: AGHT+IG0KG2PWQfUyp+qm9XnN8+mADRLGM9Lneo7CHAvt+CzxmHLJcyOXhmnLVqPaHhyr3dP3xJPPdpd0WFZR94TsuA=
X-Received: by 2002:a25:7797:0:b0:dbc:d349:5625 with SMTP id
 s145-20020a257797000000b00dbcd3495625mr136624ybc.82.1702455026353; Wed, 13
 Dec 2023 00:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212192317.0fb6b101@gandalf.local.home>
In-Reply-To: <20231212192317.0fb6b101@gandalf.local.home>
From: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date: Wed, 13 Dec 2023 10:09:50 +0200
Message-ID: <CAJ1xhMXuxGHfD8oRfbna_drpHmNv0RUXFrvuVv6rtt-KeCM9fQ@mail.gmail.com>
Subject: Re: [PATCH v3] tracing/selftests: Add test to test the trace_marker
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The REs used in the sed commands below may be simplified as shown if desire=
d.

On Wed, Dec 13, 2023 at 2:22=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> Add a test that writes longs strings, some over the size of the sub buffe=
r
> and make sure that the entire content is there.
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v2: https://lore.kernel.org/linux-trace-kernel/202312121516=
32.25c9b67d@gandalf.local.home
>
> - Realized with the upcoming change of the dynamic subbuffer sizes, that
>   this test will fail if the subbuffer is bigger than what the trace_seq
>   can hold. Now the trace_marker does not always utilize the full subbuff=
er
>   but the size of the trace_seq instead. As that size isn't available to
>   user space, we can only just make sure all content is there.
>
>  .../ftrace/test.d/00basic/trace_marker.tc     | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100755 tools/testing/selftests/ftrace/test.d/00basic/trace_m=
arker.tc
>
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.t=
c b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
> new file mode 100755
> index 000000000000..b24aff5807df
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
> @@ -0,0 +1,82 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Basic tests on writing to trace_marker
> +# requires: trace_marker
> +# flags: instance
> +
> +get_buffer_data_size() {
> +       sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_pa=
ge
            sed -n 's!.*data.*size:\([^;]*\).*!\1!p' events/header_page
> +}
> +
> +get_buffer_data_offset() {
> +       sed -ne 's/^.*data.*offset:\([0-9][0-9]*\).*/\1/p' events/header_=
page
            sed -n 's!.*data.*offset:\([^;]*\).*!\1!p' events/header_page
> +}
> +
> +get_event_header_size() {
> +       type_len=3D`sed -ne 's/^.*type_len.*:[^0-9]*\([0-9][0-9]*\).*/\1/=
p' events/header_event`
            type_len=3D`sed -n '/type_len.*bits/s![^0-9]*!!gp'
events/header_event`

> +       time_len=3D`sed -ne 's/^.*time_delta.*:[^0-9]*\([0-9][0-9]*\).*/\=
1/p' events/header_event`
            time_len=3D`sed -n '/time_delta/s![^0-9]*!!gp' events/header_ev=
ent`

> +       array_len=3D`sed -ne 's/^.*array.*:[^0-9]*\([0-9][0-9]*\).*/\1/p'=
 events/header_event`
            array_len=3D`sed -n '/array/s![^0-9]*!!gp' events/header_event`

> +       total_bits=3D$((type_len+time_len+array_len))
> +       total_bits=3D$((total_bits+7))
> +       echo $((total_bits/8))
> +}
> +
> +get_print_event_buf_offset() {
> +       sed -ne 's/^.*buf.*offset:\([0-9][0-9]*\).*/\1/p' events/ftrace/p=
rint/format
            sed -n 's!.*buf.*offset:\([^;]*\).*!\1!p' events/ftrace/print/f=
ormat
> +}
> +
> +event_header_size=3D`get_event_header_size`
> +print_header_size=3D`get_print_event_buf_offset`
> +
> +data_offset=3D`get_buffer_data_offset`
> +
> +marker_meta=3D$((event_header_size+print_header_size))
> +
> +make_str() {
> +        cnt=3D$1
> +       # subtract two for \n\0 as marker adds these
> +       cnt=3D$((cnt-2))
> +       printf -- 'X%.0s' $(seq $cnt)
> +}
> +
> +write_buffer() {
> +       size=3D$1
> +
> +       str=3D`make_str $size`
> +
> +       # clear the buffer
> +       echo > trace
> +
> +       # write the string into the marker
> +       echo -n $str > trace_marker
> +
> +       echo $str
> +}
> +
> +test_buffer() {
> +
> +       size=3D`get_buffer_data_size`
> +       oneline_size=3D$((size-marker_meta))
> +       echo size =3D $size
> +       echo meta size =3D $marker_meta
> +
> +       # Now add a little more the meta data overhead will overflow
> +
> +       str=3D`write_buffer $size`
> +
> +       # Make sure the line was broken
> +       new_str=3D`awk ' /tracing_mark_write:/ { sub(/^.*tracing_mark_wri=
te: /,"");printf "%s", $0; exit}' trace`
> +
> +       if [ "$new_str" =3D "$str" ]; then
> +               exit fail;
> +       fi
> +
> +       # Make sure the entire line can be found
> +       new_str=3D`awk ' /tracing_mark_write:/ { sub(/^.*tracing_mark_wri=
te: */,"");printf "%s", $0; }' trace`
> +
> +       if [ "$new_str" !=3D "$str" ]; then
> +               exit fail;
> +       fi
> +}
> +
> +test_buffer
> --
> 2.42.0
>

