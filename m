Return-Path: <linux-kselftest+bounces-1254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD6806B4A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 11:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498031C209AA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 10:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C2028DA9;
	Wed,  6 Dec 2023 10:07:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7211B120;
	Wed,  6 Dec 2023 02:07:35 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5d95a3562faso27027327b3.2;
        Wed, 06 Dec 2023 02:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857254; x=1702462054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IhAaCIC+sv1cl9rAPh8wEgKbrg1+NsxhvGfL72SUfo=;
        b=BvP5Zf8lhD+Qseh4HLcVThmHyO0g5zv2rgGhxLNMUlsB9ThVKqqrYqRngZV5IY93ar
         lGqL6r3c7mOUs1dRM2iWeQcl1R9SsNXplBdX6DwMZxICxj76++CqEymu9Ekv0CHC98FV
         GBXN6i7U8P/k9ehEtLkpEerC/XUaJg0x2TifeszReDNzWxLEK3Qmqeojsgnfu7N4hMls
         XAQX5Zz0jehO09becYECvgfg6nyAFkkSfGdeU6KZ9o0+JmIliilQH8S+l4b07OmEdqrJ
         ckAsuIw5UH42UmQFpGmIuODFiEiT+zUrq2nmYXqrdYwyZI32ra1VqkIt/uCX9vTpHXXR
         DkOg==
X-Gm-Message-State: AOJu0YyOQNga5YmOJ4gjthYWMXopgTYRHnofzez+K7A92duVX8KuPVHV
	d+12SVap3YIT6SsDbVTnXaAHqEb7SCWEZw==
X-Google-Smtp-Source: AGHT+IGOTVFmeip2EoeB4dqYEtyzgZVoQgZrAm8/zct3EpvC2k2C0YAtnC/tcDnIuhXD4uCAhvn3jw==
X-Received: by 2002:a0d:d903:0:b0:5d3:4ef0:8be with SMTP id b3-20020a0dd903000000b005d34ef008bemr430303ywe.37.1701857254471;
        Wed, 06 Dec 2023 02:07:34 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id g193-20020a8152ca000000b005d878b0c26fsm2387469ywb.3.2023.12.06.02.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 02:07:34 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5d95a3562faso27027237b3.2;
        Wed, 06 Dec 2023 02:07:34 -0800 (PST)
X-Received: by 2002:a05:690c:c8a:b0:5d7:5dff:9e08 with SMTP id
 cm10-20020a05690c0c8a00b005d75dff9e08mr471487ywb.93.1701857254030; Wed, 06
 Dec 2023 02:07:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com> <20231205184503.79769-5-Nikolai.Kondrashov@redhat.com>
 <87zfyomq5k.fsf@meer.lwn.net> <fcc8a2d856dda4afbc85e70a36fc9ea903adc922.camel@perches.com>
In-Reply-To: <fcc8a2d856dda4afbc85e70a36fc9ea903adc922.camel@perches.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Dec 2023 11:07:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXxE4TjHFotaf1-JgnSibikk-xk1_W1e6F0o217-vq3Mg@mail.gmail.com>
Message-ID: <CAMuHMdXxE4TjHFotaf1-JgnSibikk-xk1_W1e6F0o217-vq3Mg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/10] docs: submitting-patches: Introduce Tested-with:
To: Joe Perches <joe@perches.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>, 
	workflows@vger.kernel.org, Andy Whitcroft <apw@canonical.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	Veronika Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>, kernelci@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 8:07=E2=80=AFPM Joe Perches <joe@perches.com> wrote:
> On Tue, 2023-12-05 at 11:59 -0700, Jonathan Corbet wrote:
> > Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com> writes:
> >
> > > Introduce a new tag, 'Tested-with:', documented in the
> > > Documentation/process/submitting-patches.rst file.
> []
> > I have to ask whether we *really* need to introduce yet another tag for
> > this.  How are we going to use this information?  Are we going to try t=
o
> > make a tag for every way in which somebody might test a patch?
>
> In general, I think
>         Link: <to some url test result>
> would be good enough.

Exactly.  And if you put the test results (or a link) in your patch
below the "---", or in your cover letter, the "Link:" tag pointing to
lore (or something else, unfortunately) that most (but unfortunately
not all) maintainers already add when committing patches allows
anyone to find it.

> And remember that all this goes stale after awhile
> and that includes old test suites.

Yeah...

Isn't the purpose of a "Tested-with:" tag just for the maintainer to
know which patches have been tested with the test suite already, and
which haven't?  I expect reviewers/maintainers to scrutinize (extra)
patches that lack such a tag (or lack the same under the "---"),
and/or run the test suite theirselves.
I.e. does this serve any purpose _after_ the patch has been applied?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

