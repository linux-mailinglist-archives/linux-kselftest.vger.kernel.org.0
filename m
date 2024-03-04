Return-Path: <linux-kselftest+bounces-5854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E90870ADC
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 20:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3C2284A6F
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 19:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C2678664;
	Mon,  4 Mar 2024 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrioYmlW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88279957
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Mar 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581479; cv=none; b=kgtUNrtxCcA+KC/qjxqUhKVyD42R+l1Y6rIl9KDS32D3gJ9TWNbGjq6tCW0z5zi7cUtZ1EOYiLN1O6PgJ7Bri/HIoTgQOMZZRc9WNDEND6E9NFGCILTmrk/OuCm0t1VZXdDKv/NgROiJrRBS1jsGQL03jFPFVhrWPjSl3JRAo80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581479; c=relaxed/simple;
	bh=aJziShSE5N9NFf9GEp25onUfKHjDILdb8pau9PDQq4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0kNWUX4a5Pc0TqdXSNAJoae9LpIZX4t5MmFzF+D/4scEtZPQ9RUioMcczN4D+6fiaumZjCYvvPEnHJE8NSShUyKq2GiN+zHQ16AEt1gTDzlbp3tu635BIhnjFvA5RTbFWaKnyqUQBFjc5ItUy7pLa0RStB8nVeKtrt0jgSQVqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZrioYmlW; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42e6939d34fso69291cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Mar 2024 11:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709581476; x=1710186276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJziShSE5N9NFf9GEp25onUfKHjDILdb8pau9PDQq4s=;
        b=ZrioYmlW+GykYqhLrDIIgV5gOSzsE7sBQcJ9rOhHYjUpSYtCr/KxE4rrjknPIlp2ki
         rUuDOTzIPySpWZanxAh/z5yukqWP5HDz2apo8J3D4kgx+pzj/dD6l9+IvSVA/4S+MVbr
         nO094A9wWgpZUz2p4Caoa9bdfQTNj47i6ulidlbKU1PWsacrZd9X+lWHYEdODs0Z24dK
         wRXnYXYnmckpGV5E8kpgqIWQhJMs9mhgFNCZj5DQeQtUIYjC2NpscwDGBYpKo32+lkuk
         v6qP7DRdoDvrke0eIffJUdDDFORCielI1iIfJNM3Y03TCuTK7uPtpWXyqavSgRRepIoN
         qTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581476; x=1710186276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJziShSE5N9NFf9GEp25onUfKHjDILdb8pau9PDQq4s=;
        b=so2yYm65Bm3qNOnRXdHiz0BBBaHwAeZWbIpsfCNKISMl5W4Nyou6lKs/EZ+Me03vcx
         9F84t/YNvPodbFb0SRh0rXQocBGwqNVZ+LL7EhzoE0PitDlTtk88uM4yAQeUGylM0+Fj
         J/z1Sq6n3HtNcTo+0C1N8ara4b6eTyPYKcyfohaKauWXpO9UVmQirv3Gx66JelKPeSuu
         cvTn8bJFGrYzePdm3I80sJZGtS/J8AccXHgQBvzw6GlIvG3wV03LjJsNoa61FcrtyQze
         gUhbOGh1zgifpiyUindrvOFO00U4895xL814kfBC/5MKwhfLmH9sy22ep9QlkWrDUTNg
         RUEg==
X-Forwarded-Encrypted: i=1; AJvYcCXvezqDgnGFkaJjHlquu3UABcMWNkRlCysm6Z9WgYRemC6f42S6WoNCiDuz0Z2+fDT1axW/bgvLwCm8hfhdew3p7mVi0maVGpXrHlcDlmCQ
X-Gm-Message-State: AOJu0YwjYrHuYLmB/HO2uogdr8woLcvC5jFFaamAJnU5qnMQ9w+5J6D0
	5jQ65i6oB27r1nDlVnDsdPsN9s00IRWHow+sCqFXQfq4zCrIjN8s//SLeDG2A2AWyJj3UbQ9bWb
	qZMcwoh3DYsf0bq9EBEz4x8kUSge8rcrHIB0b
X-Google-Smtp-Source: AGHT+IHCoxbqlkbvC40r/0Ghlkohpq677Z5qku5s52QYJ8GDMhK8thtW4dw5bCp5PdHftTKp8r3OdR4wiI1Sy39wTq4=
X-Received: by 2002:ac8:7f56:0:b0:42e:f958:ea67 with SMTP id
 g22-20020ac87f56000000b0042ef958ea67mr5712qtk.7.1709581476100; Mon, 04 Mar
 2024 11:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com> <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com> <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <CABXOdTeT2ip1uS2EG2w8pW7254Tnd=ZDNz-KC61-G-yqDTVgJA@mail.gmail.com>
 <20240304-rigorous-silkworm-of-awe-4eee8f@houat> <CABXOdTc4MXcjwgGuJb4_69-4OFELD37x0B6oMr=4z=nxZ2HPXQ@mail.gmail.com>
 <20240304-ludicrous-grinning-goldfish-090aac@houat> <CABXOdTeDydWO9mf2yxWjjebHZ1bE=R2HPs1P4XYwNhzznNKxmw@mail.gmail.com>
 <20240304-benevolent-brawny-urchin-0af0ad@houat>
In-Reply-To: <20240304-benevolent-brawny-urchin-0af0ad@houat>
From: Guenter Roeck <groeck@google.com>
Date: Mon, 4 Mar 2024 11:44:23 -0800
Message-ID: <CABXOdTcT+szLRMfx=3WFoXDirOmWCY7T+8Q+zZJ=B5GscpDNnQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel Testing
To: Maxime Ripard <mripard@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Nikolai Kondrashov <spbnick@gmail.com>, 
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

On Mon, Mar 4, 2024 at 9:09=E2=80=AFAM Maxime Ripard <mripard@kernel.org> w=
rote:

[ ...]

>
> And singling out DRM because it regularly allegedly breaks things on
> xtensa or m68k and claiming we're not taking CI seriously because of it
> is completely ridiculous. If the all the subsystems were taking CI as
> seriously as DRM, we would be in a much better place.
>

FWIW:

$ git grep CONFIG_DRM arch/xtensa/ arch/m68k/
arch/m68k/configs/virt_defconfig:CONFIG_DRM=3Dy
arch/m68k/configs/virt_defconfig:CONFIG_DRM_FBDEV_EMULATION=3Dy
arch/m68k/configs/virt_defconfig:CONFIG_DRM_VIRTIO_GPU=3Dy
arch/xtensa/configs/virt_defconfig:CONFIG_DRM=3Dy
arch/xtensa/configs/virt_defconfig:CONFIG_DRM_VGEM=3Dy
arch/xtensa/configs/virt_defconfig:CONFIG_DRM_VIRTIO_GPU=3Dy

If that isn't supported, it might really make sense to declare that
CONFIG_DRM depends on !xtensa and !m68k.

Guenter

