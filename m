Return-Path: <linux-kselftest+bounces-20333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D429A938F
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A781C214F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 22:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61451E2840;
	Mon, 21 Oct 2024 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFYSbHJD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E61E04AB
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551284; cv=none; b=nxIFzaJT3LGbcf5LkXw3TJ7gWOdOqz7LelHXKwBEXUId7Y1CKA0UaDfAKcU2Ve+WJ8TVbRRxAU3ZboElbsD/N5c/mWQe6G+g7Ji6xaJindgsK/12EyuVE1qhzPaBuNdnWV0BHhUzOHXCXWR1HzTfHjFG4DxEBkITNcXVWPlTdpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551284; c=relaxed/simple;
	bh=Q/XIsVGE4Q/EJpJlLfeLROiJ8qy+ZKFe94yK4mxX9Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvZ0ONCnGrvqhah1/yqpE7sElv1qBeYspY+nInHVzgLoWYJcFjLFVBN/fNcoLYfM7QA9zLzIF1ymyeoZW0SS5gF1IUy0TVoiZ7j9cr62MPLxVRfGPNxx8PjUEigKBqf71YIj+8G6XY4PYfQzLyNdjz6HCVwqJapZyqHe9WVJlZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FFYSbHJD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c8ac50b79so86295ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 15:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729551282; x=1730156082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYWm8qPtDHK7Ptrp4+QU3serWZnnV9n3j6iMIME5OTo=;
        b=FFYSbHJD3ic36X7ekgPQL5qmH6pGYkxMmwfFDPDONeUx9bghHoLRE1KO3dMbco4M9/
         hFop4sCyvNxGO+bGUyqQEpz+dBAXaonaNa35qgEAU/9QnoP2pJGRBg39r5C608gXaEAu
         E2PlVkaI57aziCqohPLl8emyZ+4fsCrLwA8Uyoxpvutu84FRSheLY5f/2Pde9g46X84V
         UcXhTw3EPutgkvLjZGDprftKDsQETc3fmwk12W+eCSKwuK2qFiqXxB7qTsrZG/utEaeA
         kaxFaWEP0FLJ1hZt3ozIh+IrcY72iJUBNMoCLcMguUJIA/psb2y+T6l0cGDPLKJA2NSG
         Xm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729551282; x=1730156082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYWm8qPtDHK7Ptrp4+QU3serWZnnV9n3j6iMIME5OTo=;
        b=afgeztYFl0bsxmXVAxTyOEHbqzqibik5dKkDIryI++PB+mjjyx7uyC7o8/yL4ZpOih
         q9b/lOHbYpVAaw868NMO4xoldWZ1t9JDSbtbLyKjHqhOFLAK6V0zr7Yav2FGhj5pSeTr
         ThcmtKOzhnKP6An+0TQEsAHFgKM8dFaiTIubkqmu1itHmxExpFX4Y7QdYQqAb47LIFTg
         YFX+Iiqhzyx4ZqBRYr0Pn8d9gFqD89qiCVdvBF3Sa7k9vRVXYgAGrwb31NOzlHpMrTmE
         xjPBkiXM5GA0NkJpb0TvuuEYNnS4aOvtAxsiF1hnTzrEgWN1ZXyiHMXFmz1jKvuNl2/a
         qKYg==
X-Forwarded-Encrypted: i=1; AJvYcCWwoyaGl3AmQubLwSVEr3cFAFn9z86bEplOmSfd9xb4LlGLIE0cH4MqHJVBf3OWplvdqaBZpAWPUDZsdPiEY5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMzzL57QioZrgbAmBUEQfLbeyaBFro460oyxg6WA6wcswsHQ2
	4meEp4JBcxA2BBbck/pkk2OB61XYGhtufs4DCyrjDsq2i2q0WFLVncfgRgTRHJzN2zLo5Dnhr2V
	XP2H0AD1PLZilaA25BViZoK0pMf5oU44VPB4b
X-Google-Smtp-Source: AGHT+IF2QkQLH/jexBZQwaUOU9+BOJypjphzTBtnfLoXWmAxPffUJk9u40roRuw2Fw3F57A4PtclyRxhoo9XerM3FKQ=
X-Received: by 2002:a17:903:18d:b0:206:ae0b:bfcb with SMTP id
 d9443c01a7336-20e9806cf6cmr1181895ad.28.1729551281280; Mon, 21 Oct 2024
 15:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017225031.2448426-1-jrife@google.com> <20241017225031.2448426-2-jrife@google.com>
 <fb910573-41d8-47b5-8ab9-ecbc8df7a56b@linux.dev>
In-Reply-To: <fb910573-41d8-47b5-8ab9-ecbc8df7a56b@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Mon, 21 Oct 2024 15:54:28 -0700
Message-ID: <CADKFtnSgnPMOM5Fz8t-HMSkHOp+8VwuB76GJa4JCrKUVL1aTzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] selftests/bpf: Migrate *_POST_BIND test
 cases to prog_tests
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	"Daniel T. Lee" <danieltimlee@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> How is verbose used and is it still needed?

It probably isn't needed here, so I will remove it. sock_create.c,
whose structure I emulated for sock_post_bind.c, has something
similar, but it seems superfluous there as well.

> nit. ASSERT_OK_FD().
> Since the test binds to a specific ip/port, please run it in its own netn=
s

Sure, will do.

-Jordan

On Mon, Oct 21, 2024 at 2:28=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/17/24 3:49 PM, Jordan Rife wrote:
> > Move all BPF_CGROUP_INET6_POST_BIND and BPF_CGROUP_INET4_POST_BIND test
> > cases to a new prog_test, prog_tests/sock_post_bind.c, except for
> > LOAD_REJECT test cases.
> >
> > Signed-off-by: Jordan Rife <jrife@google.com>
> > ---
> >   .../selftests/bpf/prog_tests/sock_post_bind.c | 417 +++++++++++++++++=
+
> >   tools/testing/selftests/bpf/test_sock.c       | 245 ----------
> >   2 files changed, 417 insertions(+), 245 deletions(-)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_post_b=
ind.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sock_post_bind.c b/=
tools/testing/selftests/bpf/prog_tests/sock_post_bind.c
> > new file mode 100644
> > index 000000000000..c46537e3b9d4
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/sock_post_bind.c
> > @@ -0,0 +1,417 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/bpf.h>
> > +#include <test_progs.h>
> > +#include "cgroup_helpers.h"
> > +
> > +static char bpf_log_buf[4096];
> > +static bool verbose;
>
> How is verbose used and is it still needed?
>
> [ ... ]
>
> > +     if (bind(sockfd, (const struct sockaddr *)&addr, len) =3D=3D -1) =
{
> > +             /* sys_bind() may fail for different reasons, errno has t=
o be
> > +              * checked to confirm that BPF program rejected it.
> > +              */
> > +             if (errno !=3D EPERM)
> > +                     goto err;
> > +             if (port_retry)
> > +                     goto retry;
> > +             res =3D BIND_REJECT;
> > +             goto out;
> > +     }
>
> [ ... ]
>
> > +void test_sock_post_bind(void)
> > +{
> > +     int cgroup_fd, i;
> > +
> > +     cgroup_fd =3D test__join_cgroup("/post_bind");
> > +     if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
>
> nit. ASSERT_OK_FD().
>
> Since the test binds to a specific ip/port, please run it in its own netn=
s. It
> is easy to do with netns_new and netns_free, a recent example:
>
> https://lore.kernel.org/bpf/20241020-syncookie-v2-1-2db240225fed@bootlin.=
com/
>
> The same netns can be reused for different subtests of this "sock_post_bi=
nd" test.
>
> Others look good. Thanks for moving the test to test_progs.
>
> pw-bot: cr
>

