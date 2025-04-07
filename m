Return-Path: <linux-kselftest+bounces-30179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3037CA7D28B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 05:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6BA3ADCAF
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 03:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BCF217F2E;
	Mon,  7 Apr 2025 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0/xjha2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED9217F27;
	Mon,  7 Apr 2025 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743997233; cv=none; b=I/M2hmmGgaJ/whDjl4N0w0/yhHOipoyAMaQx7m1QH8YIIDK88T9CVCR1RXQmVQX+ruSxsGpPahVFXE6rK8K2KstOXkPpM1OSph8Kf9gpjTyBi2+NAa71/RXWWIWB+zeBB/n//dIehxM+3pCAekOi2ViMLs/vX3+/euAPFB4QR88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743997233; c=relaxed/simple;
	bh=SdoG5YNAjCxpTafOFN7GwWzMdHLTICWuHEusYEHOpb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pr/DS0DmuRAq8/XYJrxvJeYrU6+w5LpJWqaFwOR6izYXo7jS3mXruZk/R23639VZE+iHMcJaCvEsEslR54v4UBcRVJF7AmvDASh05lVZOj2n+Kjqj55LX2FpZnH7JvubsCE/+YamRqJMiZVN5OQO9/AAROQMIO84uDWKpN96Dm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0/xjha2; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so7016384a12.0;
        Sun, 06 Apr 2025 20:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743997230; x=1744602030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWCbdplBrRTzOviOYcUnPBAjZP7jVF7GFhY7bPt8iew=;
        b=Q0/xjha2oZtBKGYxu8PXxQUIDm7aT8J3B6B00KPuy/GeOCOvild29Pdg0egN/5RX2W
         F3HW+ZRM7zSCrlc0FEyNWleisB8ohyMGrK4gSiKxUpz+tTo19Lv8SMmSyDCatNe5H8l5
         76ssPRBsVi0E6rVwOh107hRzG4HDcuU5b9DDt92fUIkv0a72a0yS+QbOGR1UAW+5smHD
         UMMilZDcssbVLWj9b7ljM2RNWlJQQ685y+EW1Bof1eg2hHPQcXU9MMzD3dn93QDt9mwP
         mOYckhTBrONov1DKJ6jqWLDmU4Qj6VfKuNa+UFfO4zJo6wTKaDY0HDkU7RbqZR+8UX8B
         UvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743997230; x=1744602030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWCbdplBrRTzOviOYcUnPBAjZP7jVF7GFhY7bPt8iew=;
        b=VsbhDqz6RlLo+KKimU6YJb7y3NjdNZUtiDPPdo7qGf8d/IQlmdVY1abP+ehPzXgmnA
         IQORmK1VYHr+rotSF76WxBs0dJen6uk/L17KXkhKUWm5isqksUGgp6YWED3mUUVQjZqG
         AUk6Z5VT79qROImCpL/6jL2kCvedN1vtG6GkJs+iBVv+ccGAfupXR4PG+l3f6+kOLPOR
         JY6T/L9ueBPEvciBEuVoZTGjI/zTH9bNCWZmpvX70XWhxxfATfTk95/+KpH77GISi/AU
         isLx2FAG08CQd1hhwUkLd2b7BllPJQa//yTJcw+jrJDG7ZO3UC5X9n5gfKmG+s1ou0MX
         g8vA==
X-Forwarded-Encrypted: i=1; AJvYcCWC32clL62KmPwN4j2dWSxMeweKz7qUJSxcbsYpG60kuE7TDLLuv0FqrN1EkRjoVLEuRMA=@vger.kernel.org, AJvYcCWiNpnHNiGKOo7ydCc7HmOpEQOzJ5XZz8iUdQzIWnwb/boAlur3B4OKM5jsi0coE3xQHts5R2vdQ3YcJxWUDA7b@vger.kernel.org, AJvYcCX/mj67HG7ikKA6P+k+wdBvJs+kq6qWuHvjpfrvbwvVhH95i31Kv4yHfYfX7j8L8vhGJf1loUVruSmMZIAJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsu2dxXXfDfHfu8jV6dBNx4W/zglA6b5wUalJpBvASvLzk8ucD
	w4R6E5/oEnr6xj6D0TR+uJBl6eSycmE7liqi+6P4I5r08N6DdwKTtRD4TE3J3tKUf6jZMzrcWj4
	LgRyFyMP3MkbXN+ak0lYIUy7FL0Q=
X-Gm-Gg: ASbGncv9AZ3SxUnJ6lGee8hy6kfOHd75jBlI7+a9tsHFqxLlCeF0JfDeStDPDkH+cgR
	jVILElTdfkH9KUpEbb7lWBibGuQMeG7xkjo1GlFyldnKB5Ahdp5Oss1RQomaR4lEXiK8eVB9GtX
	rzq68oW19lS7hd/36Y0nYkKJ3tekvy
X-Google-Smtp-Source: AGHT+IEEPNITxLvpL2EswjSjCquWWq6DhRueSEwahn5r7wFxZUYdPPng1ePscZSaHs0ndW/XkopHICpYNo5ccc1LV/E=
X-Received: by 2002:a17:907:a05:b0:ac7:322d:779c with SMTP id
 a640c23a62f3a-ac7d6ec2f2cmr844094266b.50.1743997229691; Sun, 06 Apr 2025
 20:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <malayarout91@gmail.com> <20250324064234.853591-1-malayarout91@gmail.com>
 <CAEf4BzagSxO-fNeeWfFPu2vpnbEUBnS7Y2P=ODGks_zVEg1mkg@mail.gmail.com>
 <CAE2+fR83Y8ZKk8fqM0WgZeK4Zm4PZjBzoPMyMptVHfk81eXEtw@mail.gmail.com> <e255897a-30d8-5745-b89b-eb801e0864a9@huaweicloud.com>
In-Reply-To: <e255897a-30d8-5745-b89b-eb801e0864a9@huaweicloud.com>
From: malaya kumar rout <malayarout91@gmail.com>
Date: Mon, 7 Apr 2025 09:10:18 +0530
X-Gm-Features: ATxdqUGULLoheNb0ptDa_1GMfr9lfLGY3rLDLZqgYYn38THywJlix-OS_VKP5z0
Message-ID: <CAE2+fR992BprqDXkZTqi3Mgtq9WErSFvOtxvc16ZT9ufiBLNNQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: close the file descriptor to avoid
 resource leaks
To: Hou Tao <houtao@huaweicloud.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 7:07=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 4/5/2025 1:59 PM, malaya kumar rout wrote:
> > On Fri, Apr 4, 2025 at 9:22=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >> On Sun, Mar 23, 2025 at 11:43=E2=80=AFPM Malaya Kumar Rout
> >> <malayarout91@gmail.com> wrote:
> >>> Static Analyis for bench_htab_mem.c with cppcheck:error
> >>> tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3:
> >>> error: Resource leak: fd [resourceLeak]
> >>> tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3:
> >>> error: Resource leak: tc [resourceLeak]
> >>>
> >>> fix the issue  by closing the file descriptor (fd & tc) when
> >>> read & fgets operation fails.
> >>>
> >>> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> >>> ---
> >>>  tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 1 +
> >>>  tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
> >>>  2 files changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/to=
ols/testing/selftests/bpf/benchs/bench_htab_mem.c
> >>> index 926ee822143e..59746fd2c23a 100644
> >>> --- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> >>> +++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> >>> @@ -281,6 +281,7 @@ static void htab_mem_read_mem_cgrp_file(const cha=
r *name, unsigned long *value)
> >>>         got =3D read(fd, buf, sizeof(buf) - 1);
> >> It could be a bit cleaner to add close(fd) here and drop the one we
> >> have at the end of the function.
> >>
> > Here, close(fd)  is now positioned within the error handling block,
> > guaranteeing that
> > the file descriptor will be closed prior to returning from the
> > function in the event of a read error.
> > Meanwhile, the final close(fd) at the end of the function is retained
> > for successful execution,
> > thereby avoiding any potential resource leaks.
> > Hence, It is essential to add the close(fd) in both locations to
> > prevent resource leakage.
>
> I think Andrii was proposing the following solution:
>
> {
>         /* ...... */
>         got =3D read(fd, buf, sizeof(buf) - 1);
>         close(fd);
>         if (got <=3D 0) {
>                 *value =3D 0;
>                 return;
>         }
>         buf[got] =3D 0;
>
>         *value =3D strtoull(buf, NULL, 0);
> }
>
> It only invokes close(fd) once to handle both the failed case and the
> successful case.
> >
I greatly appreciate your insightful feedback on the review.
I will proceed to share the updated patch that includes the modifications.
> >> pw-bot: cr
> >>
> >>>         if (got <=3D 0) {
> >>>                 *value =3D 0;
> >>> +               close(fd);
> >>>                 return;
> >>>         }
> >>>         buf[got] =3D 0;
> >>> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/too=
ls/testing/selftests/bpf/prog_tests/sk_assign.c
> >>> index 0b9bd1d6f7cc..10a0ab954b8a 100644
> >>> --- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> >>> +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> >>> @@ -37,8 +37,10 @@ configure_stack(void)
> >>>         tc =3D popen("tc -V", "r");
> >>>         if (CHECK_FAIL(!tc))
> >>>                 return false;
> >>> -       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
> >>> +       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
> >>> +               pclose(tc);
> >> this one looks good
> >>
> >>>                 return false;
> >>> +       }
> >>>         if (strstr(tc_version, ", libbpf "))
> >>>                 prog =3D "test_sk_assign_libbpf.bpf.o";
> >>>         else
> >>> --
> >>> 2.43.0
> >>>
> > .
>

