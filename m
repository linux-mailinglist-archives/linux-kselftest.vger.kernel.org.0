Return-Path: <linux-kselftest+bounces-5669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7555C86D42A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 21:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0891F23194
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 20:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED651420DB;
	Thu, 29 Feb 2024 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hvwdu0L8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80DA13F45F
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 20:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238494; cv=none; b=Ez2dYb/gi4yR0FJJiDH6Y41oruG0/jMHM/ms9UOWFmG0FwKQ6oMtF+c6HGdtuRZ5YMmbHLCSYvyVdDUft36qzWdr6xE47J6m+qVjZRO+5TNLj3tuLszixBXk89nML0URdqnXG2YnIXewa8RgdNrAicmryOygTtXLbyvDoafG+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238494; c=relaxed/simple;
	bh=uXWrJbshZP7CBnPLaekgrXuRiji+uddEtfNEXyijjLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKXoYl+p57SgI1uwB7XguNrYurOAIQr2mA4n6zDY2amvCWAXeGUha0Khj5GKu/WdaflGrft+znEcaqua2eiYBKRDTUwZ0Q2XF0ghiZaBydi673gwOKNSXO4az0tTXXRfrlGJ5nW4sUmPAMpDLHsHpaxfMNiMcp/vdivUO5kYTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hvwdu0L8; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d220e39907so18059561fa.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 12:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709238490; x=1709843290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k0i0PgDtVBoPSBAUnZ0cg1G8fT87ylUFojqmg8T1gpw=;
        b=hvwdu0L8zjQcP4Bntg2aF/NS89Pa5xcPO4cwhYB+I3G14NSsaalTM+0QxQHntUMyy3
         Nhe4LZcyIkDMg4/6wzXkxEl6K83N0JPnDZrQ94Kh4Q6GVemjQso+eM7a1pjQaubhp+Ec
         U20ddN2wzXYWbE8hEtqxzG/0Yap0romkROrdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709238490; x=1709843290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0i0PgDtVBoPSBAUnZ0cg1G8fT87ylUFojqmg8T1gpw=;
        b=HF9ctsnIbPfqXXzdrk6jTYxOBY38t3o1Is7XLEi9V6pgEs1y5UiJ+KEn2tf7qPfXXd
         AdQFgMjuTB8jKHL9g3IdXokU8honq64vjgVhUuX5RZXYVqCUH8vZpReRULABMIOFQAoY
         U7pc1WSokBYhgJVH+dxW64eGZm0LOD8UmiviVVsqLmpWGJwNCenveA0Gb6ZsyJLwla1W
         n8fQv/oR7oIJrrfriftVX8Os1gweAWD1NB1wKYyEBxOivusS66YeTNv7eAB/wtrNIHCM
         CeLVJhNqpMyPt8OGvwoPL2qFsUNxKxJqJcY1sxf44fbQ8p+wqyBZggukjzqxzs9lRPT8
         6V0g==
X-Forwarded-Encrypted: i=1; AJvYcCWjOdmc4TNkz0uCLVEU/gAvlKuUqULKtD/B840vGPw2Lu2LQk4iike8+J1jmAcX9uT0ADuzqUqRD10Ag4SMfh6W6FKQfrQtb7Rpf6btvG+n
X-Gm-Message-State: AOJu0YwxusbKgU+k3jhnfax8St8QQiwEJ1j2muEAWR2c5UZczImj6ATA
	/XO7ZUI/cyqoOHpEUUuvQpSnvbhLq1hwDZc3ZpvlodtfWvp93YqANHMAvYR/YpjcLQFZmzDP2Np
	rpZ3vcA==
X-Google-Smtp-Source: AGHT+IGcUWudBCqVEH/C1ohb0iG2QkPjzF522X5/utnA6nMrpHDXMPIhW55Q9J1x1NbBBN3Kt19Qvw==
X-Received: by 2002:a05:651c:238:b0:2d2:6227:d30b with SMTP id z24-20020a05651c023800b002d26227d30bmr2230228ljn.47.1709238489839;
        Thu, 29 Feb 2024 12:28:09 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id j5-20020a2eb705000000b002d27494c8c1sm326249ljo.25.2024.02.29.12.28.09
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 12:28:09 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d23114b19dso15829861fa.3
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 12:28:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcP1wnISq7LZObvRhBCRrMqRCJDhdfB0GWpS/vBKHktCd1oNzMMmQ79tG+TylV302w+HHolYk76f7UcEDJMZSp2N5vhLMMElYefCdI/gvH
X-Received: by 2002:a17:906:d9c9:b0:a3f:1cb6:fb00 with SMTP id
 qk9-20020a170906d9c900b00a3f1cb6fb00mr12394ejb.69.1709238077400; Thu, 29 Feb
 2024 12:21:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com> <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
In-Reply-To: <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 29 Feb 2024 12:21:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
Message-ID: <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, Helen Koike <helen.koike@collabora.com>, 
	linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, 
	pawiecz@collabora.com, tales.aparecida@gmail.com, workflows@vger.kernel.org, 
	kernelci@lists.linux.dev, skhan@linuxfoundation.org, 
	kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, 
	cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	ricardo.canuelo@collabora.com, kernel@collabora.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Feb 2024 at 01:23, Nikolai Kondrashov <spbnick@gmail.com> wrote:
>
> However, I think a better approach would be *not* to add the .gitlab-ci.yaml
> file in the root of the source tree, but instead change the very same repo
> setting to point to a particular entry YAML, *inside* the repo (somewhere
> under "ci" directory) instead.

I really don't want some kind of top-level CI for the base kernel project.

We already have the situation that the drm people have their own ci
model. II'm ok with that, partly because then at least the maintainers
of that subsystem can agree on the rules for that one subsystem.

I'm not at all interested in having something that people will then
either fight about, or - more likely - ignore, at the top level
because there isn't some global agreement about what the rules are.

For example, even just running checkpatch is often a stylistic thing,
and not everybody agrees about all the checkpatch warnings.

I would suggest the CI project be separate from the kernel.

And having that slack channel that is restricted to particular
companies is just another sign of this whole disease.

If you want to make a google/microsoft project to do kernel CI, then
more power to you, but don't expect it to be some kind of agreed-upon
kernel project when it's a closed system.

               Linus

