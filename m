Return-Path: <linux-kselftest+bounces-5792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFDB86F2AB
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 23:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EF21C20CE6
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 22:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3ED4501B;
	Sat,  2 Mar 2024 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RsU+kwd1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2E541202
	for <linux-kselftest@vger.kernel.org>; Sat,  2 Mar 2024 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709417466; cv=none; b=IMtCn2tsXpeIM6GDC10R5Z0CoL7RBNgyXlxY3M1hWFCSfU+6xUFUea/d1gK2eFMCcdDScBoVB8lJVXXQUHWU+0bLmxrSSXxZ9vr0+Ku0f8VKuh85+yufFlu0A33Q/NUVsE9FT8vQXlphdYGXzdkhUIByVdfpfeJWrZqgtZxb6uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709417466; c=relaxed/simple;
	bh=0ALp7TDIJwRAUZcjpLYIfdcASuV8IswcwZ6HVohQkd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1U38vNgwKSIV5BKIROoiin4S+K55UMbRmXoR+s7MO+PRug6+9ba4C69DQW7e+4hto4U3Xpn35hfKVAOkNjv87Cv4aRKMCVc3VuCqefQOvkOUkA5L3DMRgPU/0PGPriSQs39cbdt210S2u1kSd4SgSUq/BfzvNT0YIDsVeUTSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RsU+kwd1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-428405a0205so553551cf.1
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Mar 2024 14:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709417464; x=1710022264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTM56c3VIZxbBTne5xJnHplyY03OBsavmsip+EQ4Ouw=;
        b=RsU+kwd1G4XsANOtVcaBKq5gPGdyLSAai33oYbVuOKOjwu+0LsRnsL1GV0CCHxzWr6
         kgX2FREDlXF0YaOhBaVe5prpOBZWlN5W9YoAHdf4tVW0/kwXPoxEVY93s6BR88JpuYwf
         I67mwRZAft5W7VOzEU8V/NxBstPJjTaarhUTquNZEhi381f3btYi/mHyVWSngPyoVW98
         Kzc9pb5Eisk3LRWbwCLj+zP4plXml3/0sKQTUP5wdqn8cDWumXLENSwmh3x8yIy52qBu
         2eFo4E2K3Ix3L2UxMsGOyIfxQhBa67YdXcqZ1XyXmltLWnwEa5lqi0aheGGs/C0JwLlv
         wzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709417464; x=1710022264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTM56c3VIZxbBTne5xJnHplyY03OBsavmsip+EQ4Ouw=;
        b=Ik7xgzIDiROetTPSfEiHIWLWikLxCpRsr3sQSznvceytzU6kGoa2ffM7i+3GbzOu6O
         t9Ohnx8v7E56TQ6Q7AhQf+PoaIppm1HZ1AAJslpFcvpgNUV73xcOUz5Mgcskwouyk8j8
         H9fS/BSFKh3OF+H0OBX6Y78I+eIilfaFrEbovzHbdJcupl0MchDqUi80M6cVggDq4EkK
         oOCv0elhLy7O+6dr2CswYkulqW+hS48YW8I9RGwxL8dZpX1yInJfu/5SH8PAMxXdQK9M
         TQHcbOZ1hxc6msStr9VXfHOOKXwVq4u4+VYbuMU4rEZ5I2x2GKx7LEAPfuTFOMK/nsd2
         qWuw==
X-Forwarded-Encrypted: i=1; AJvYcCVHNcQc9tS7RN6X6RLoa8n6WL4wX9RVBXz8sPPvQZzfns+X2tRCmckeM76QCrHaomzq1SyVikPHijmkBfc/1lXTYPIOQyaOgRe0KZ+COBs6
X-Gm-Message-State: AOJu0YxU00Uy8OTtDWHbRQlBTY5JRPQoPJBcFDM6jyeE4fDkuJqGx98Z
	zP6QSCnhqZUVLJFznxg2d1kjdwLPPI4nXrrX6fW1rbV3Eng9lqNMmJ/6D7lQClQBj1ETaca8R22
	cZRhQFgnrPe1g4MtuqCfwpEXYt2XKm92ygZGl
X-Google-Smtp-Source: AGHT+IH9sc7BkUOA/MoUZBJgDctjPHOF2trLohxTQjAjH4xi/HZsF8GyNQXPUzk/gDR+MwNciAkndO1CuKQxBDT3R0k=
X-Received: by 2002:a05:622a:1989:b0:42e:e1d9:6df8 with SMTP id
 u9-20020a05622a198900b0042ee1d96df8mr52100qtc.23.1709417463845; Sat, 02 Mar
 2024 14:11:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com> <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com> <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
In-Reply-To: <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
From: Guenter Roeck <groeck@google.com>
Date: Sat, 2 Mar 2024 14:10:51 -0800
Message-ID: <CABXOdTeT2ip1uS2EG2w8pW7254Tnd=ZDNz-KC61-G-yqDTVgJA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org, 
	dave.pigott@collabora.com, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, 
	gustavo.padovan@collabora.com, pawiecz@collabora.com, 
	tales.aparecida@gmail.com, workflows@vger.kernel.org, 
	kernelci@lists.linux.dev, skhan@linuxfoundation.org, 
	kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, 
	cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	ricardo.canuelo@collabora.com, kernel@collabora.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 12:21=E2=80=AFPM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> On Thu, 29 Feb 2024 at 01:23, Nikolai Kondrashov <spbnick@gmail.com> wrot=
e:
> >
> > However, I think a better approach would be *not* to add the .gitlab-ci=
.yaml
> > file in the root of the source tree, but instead change the very same r=
epo
> > setting to point to a particular entry YAML, *inside* the repo (somewhe=
re
> > under "ci" directory) instead.
>
> I really don't want some kind of top-level CI for the base kernel project=
.
>
> We already have the situation that the drm people have their own ci
> model. II'm ok with that, partly because then at least the maintainers
> of that subsystem can agree on the rules for that one subsystem.
>
> I'm not at all interested in having something that people will then
> either fight about, or - more likely - ignore, at the top level
> because there isn't some global agreement about what the rules are.
>
> For example, even just running checkpatch is often a stylistic thing,
> and not everybody agrees about all the checkpatch warnings.
>

While checkpatch is indeed of arguable value, I think it would help a
lot not having to bother about the persistent _build_ failures on
32-bit systems. You mentioned the fancy drm CI system above, but they
don't run tests and not even test builds on 32-bit targets, which has
repeatedly caused (and currently does cause) build failures in drm
code when trying to build, say, arm:allmodconfig in linux-next. Most
trivial build failures in linux-next (and, yes, sometimes mainline)
could be prevented with a simple generic CI.

Sure, argue against checkpatch as much as you like, but the code
should at least _build_, and it should not be necessary for random
people to report build failures to the submitters.

Guenter

> I would suggest the CI project be separate from the kernel.
>
> And having that slack channel that is restricted to particular
> companies is just another sign of this whole disease.
>
> If you want to make a google/microsoft project to do kernel CI, then
> more power to you, but don't expect it to be some kind of agreed-upon
> kernel project when it's a closed system.
>
>                Linus
>

