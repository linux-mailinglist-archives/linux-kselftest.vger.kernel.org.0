Return-Path: <linux-kselftest+bounces-11719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9937F904773
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 01:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204E11F23126
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 23:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D569F155C9F;
	Tue, 11 Jun 2024 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dV8inZA8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09167152DF1
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147081; cv=none; b=ufBf7xVmIXrAg8rmiTeBfZK9reMEodgeIM592TCcGhBWzN+h38I68ONRr17zLY3KXdA0gECgBDW8ONltoC1yVRv3qttghnvguD9pkxNqOYAQsUUgESsn4rKqj6AxTez2cVxZN4LOMFkrE9VZ1nkudykmlxnO0wunZbO5wwdKHR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147081; c=relaxed/simple;
	bh=T8OozrZR+1vkIaOz0Hl0kOkEndiy3BvvGmc+cmCPeVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRJC/zoU1gJOlr1O6Iyckme2jwO8mYizQzlQ7i7sCFPLRJoCsUIx6nNl0LR1GH2J6gHbun5sBCHV3d5HtAOOn5xiU6HD9k6GjLnU0Y+z1Ku5vcnvcxB2XRBMz1po4AVZhdWxMucVcwBbIiyBkpW/KH5/kDhufKxJfCATG+1JMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dV8inZA8; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c6cb1a76fso2521a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 16:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718147078; x=1718751878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtbvaoMsCJ9k1mz6SgmK+4gae6eOunhj2wDuCSNJ/mk=;
        b=dV8inZA8xZ+OgxS/PP01e20PzIQLxf8kRj9bwvOqjfkyoDpJgB+If+6BuxHxu0CVOy
         fF+lw5MSX9CHfPIL7LOaYEDx1LjkIv+5jW2KpkcIu175GQ5gKnMJoqEx7xxOCPh2PAzh
         FAb3JwYWuffTX1Da5lL8ZxuBK3HgJ1rY605iD3lmQuONjjVZ4oWkUz+DE9OkhQHZc8lY
         TMk4roAsXOMo6MXGXBQsl0/svpp7XpMwGqW93q2oVdhNsNqcNraWoUFVLsCpSaAmqgAR
         v63aWPXjJIrVXOgx9ZtYFoYv5Rxae5OTGGiJ2UuBXnK9vfTYPxukWTza7vzJkrG3SEzT
         Bf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718147078; x=1718751878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtbvaoMsCJ9k1mz6SgmK+4gae6eOunhj2wDuCSNJ/mk=;
        b=oq8hG0LCd0Qw9woGI3pjhcTzP+7aQ8leIpf2RNdnYhLCb6/i+6cZ+lQrY6ZOJ47xSB
         dWyz55KKHoNr2IOCe8n8Vp9DuAkkeJk/R0/vAJG+zFXzNrIyYp34a6MF1AfMXqvakF7y
         ljqWVvnaD/4N8tO6RZs0NDcVA5u5ffv2yHW8pp+S5llOxta8Z/xv4aZmOKR2utRvLJmr
         p30/dKrPPu5b/i5qMOxTA/3lrVg1flhW0t8/uF1TTS41+n2nuRCTJW7nrAP/awiFZy8P
         jQp9PvXx+oE5uc1Y58n7nt4aCSsf7kryG7GYub+lms5kBejiVGtppijLjkE9h/PAjAZm
         olew==
X-Forwarded-Encrypted: i=1; AJvYcCXMRGorY6t+JcrIw81gIioKJg/WLG5MeF3pXnoKfsDzSTUDu5OnstyNrk1YHrOEjlmmEYCBMKy0h3ff6zKOwMYiXFZQpzPMqCdJME/xtuGa
X-Gm-Message-State: AOJu0Yz1PQhmLWWvCfO4fVU9rE3lHgZm8z1t5Q/h4Jwe+qdFvHTtgHiE
	reXUcDwhtsZPg54r2rfrGuUznaOnjOizsD4yDPBLTb73TZji7FJ7Hm20GeG6P/XXOd99yqM9QNM
	6DDMT46lYi1mbuWBHy+/wxRVlDcDhGtlNhxGn
X-Google-Smtp-Source: AGHT+IGIJEs3b4nVQ+XCokKeptQYXIP66wVTDYCQxFkmqQBnlc+C3z0gcSGRO9hqtyBT+VZVapa4wwHBMpUt3Pry/L8=
X-Received: by 2002:a05:6402:38a:b0:57c:ab3f:d200 with SMTP id
 4fb4d7f45d1cf-57cab3fd29amr7343a12.0.1718147075504; Tue, 11 Jun 2024 16:04:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611034903.3456796-1-jeffxu@chromium.org> <20240611034903.3456796-2-jeffxu@chromium.org>
 <595b6353-6da6-432b-96b4-42c4e3ec1146@infradead.org>
In-Reply-To: <595b6353-6da6-432b-96b4-42c4e3ec1146@infradead.org>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 11 Jun 2024 16:03:56 -0700
Message-ID: <CALmYWFvxAvG1ZmbmZf=VedTdwEq8Yz36Xp8o9rhw=Wfae1ei8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC
To: Randy Dunlap <rdunlap@infradead.org>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, cyphar@cyphar.com, 
	david@readahead.eu, dmitry.torokhov@gmail.com, dverkamp@chromium.org, 
	hughd@google.com, jorgelo@chromium.org, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pobrn@protonmail.com, skhan@linuxfoundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 3:41=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 6/10/24 8:49 PM, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add documentation for memfd_create flags: MFD_NOEXEC_SEAL
> > and MFD_EXEC
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> >
> > ---
> >  Documentation/userspace-api/index.rst      |  1 +
> >  Documentation/userspace-api/mfd_noexec.rst | 86 ++++++++++++++++++++++
> >  2 files changed, 87 insertions(+)
> >  create mode 100644 Documentation/userspace-api/mfd_noexec.rst
> >
> > diff --git a/Documentation/userspace-api/index.rst b/Documentation/user=
space-api/index.rst
> > index 5926115ec0ed..8a251d71fa6e 100644
> > --- a/Documentation/userspace-api/index.rst
> > +++ b/Documentation/userspace-api/index.rst
> > @@ -32,6 +32,7 @@ Security-related interfaces
> >     seccomp_filter
> >     landlock
> >     lsm
> > +   mfd_noexec
> >     spec_ctrl
> >     tee
> >
> > diff --git a/Documentation/userspace-api/mfd_noexec.rst b/Documentation=
/userspace-api/mfd_noexec.rst
> > new file mode 100644
> > index 000000000000..ec6e3560fbff
> > --- /dev/null
> > +++ b/Documentation/userspace-api/mfd_noexec.rst
> > @@ -0,0 +1,86 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Introduction of non executable mfd
>
> Missed:
>                    non-executable
>
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +:Author:
> > +    Daniel Verkamp <dverkamp@chromium.org>
> > +    Jeff Xu <jeffxu@chromium.org>
> > +
> > +:Contributor:
> > +     Aleksa Sarai <cyphar@cyphar.com>
> > +
> > +Since Linux introduced the memfd feature, memfds have always had their
> > +execute bit set, and the memfd_create() syscall doesn't allow setting
> > +it differently.
> > +
> > +However, in a secure-by-default system, such as ChromeOS, (where all
> > +executables should come from the rootfs, which is protected by verifie=
d
> > +boot), this executable nature of memfd opens a door for NoExec bypass
> > +and enables =E2=80=9Cconfused deputy attack=E2=80=9D.  E.g, in VRP bug=
 [1]: cros_vm
> > +process created a memfd to share the content with an external process,
> > +however the memfd is overwritten and used for executing arbitrary code
> > +and root escalation. [2] lists more VRP of this kind.
> > +
> > +On the other hand, executable memfd has its legit use: runc uses memfd=
=E2=80=99s
> > +seal and executable feature to copy the contents of the binary then
> > +execute them. For such a system, we need a solution to differentiate r=
unc's
> > +use of executable memfds and an attacker's [3].
> > +
> > +To address those above:
> > + - Let memfd_create() set X bit at creation time.
> > + - Let memfd be sealed for modifying X bit when NX is set.
> > + - Add a new pid namespace sysctl: vm.memfd_noexec to help application=
s to
>
>                                                          help application=
s in
>
> > +   migrating and enforcing non-executable MFD.
> > +
> > +User API
> > +=3D=3D=3D=3D=3D=3D=3D=3D
>
> The rest looks good. Thanks.
>
Thanks for your review!

> --
> ~Randy

