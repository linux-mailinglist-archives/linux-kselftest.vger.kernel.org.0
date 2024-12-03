Return-Path: <linux-kselftest+bounces-22764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166769E28BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 18:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBA9284068
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 17:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E42A1FA177;
	Tue,  3 Dec 2024 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs/LjBkc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF8D1F76CF;
	Tue,  3 Dec 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245764; cv=none; b=BO5PDySbEkMtUfTkbzQJQBr1R1Y74jr6yCH/cSqcEG7uCrrWw64g+uF5dKQKjPUJav5eUKTm/P7hmJWKDJMCPdt3XnlIEb6qgvBEgchc02s9vMN+eUmGJGGVC3WipeGnOXvxvAzTTW+PyZsN3x6sGhGHZ+bu3SiaYjIMoIojGso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245764; c=relaxed/simple;
	bh=m1AFTk+2y4ye/cKZJ8VyNtBFMtplF4PAovqBsExuifg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDuToTHgVB5MdW3wiGlMlr0DZfc75r/HqXu9cUlsRit/IuNDBh8ORvCyqB8ogGSYQo2+fGJq6MrA3a3huo5+/Q1u55uMKxav5YGjTsExA6SFbEEEOvJFXv+T4gGEU+TtAPAvGmhIo/dVnqgmCNYBhPlqrA7JrMhgP+87O4s+f5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rs/LjBkc; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffa974b2b0so58712611fa.3;
        Tue, 03 Dec 2024 09:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733245761; x=1733850561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1AFTk+2y4ye/cKZJ8VyNtBFMtplF4PAovqBsExuifg=;
        b=Rs/LjBkcjEOEwy2A/qhRbjTpQ/FrCQXnSYtyXXkMHuOfl/1MeVlTPJV5qXm9f2Faes
         FguadlALJ2qt4Uc+Usr2snYewtPuFi+r6Ia/s/OaluS5CsrDD4WjinAQERedx3muMBXR
         nmQmb5niBGa++LRhuGhsVIXAEUHKlBBW0k6W9OHdLKwcJrygRXsa0Bn6Oi78IMyJMwNz
         BmlwUdHht+Mzzp60heSEWOHcgISqXiqOWpu46TugM5EwmOkMkbgFLiHyQeeviw6xruQ6
         r5pN/3AAkX3DaHTz3GkE6iPJuBXC2xVhYhq23qjw29zH5nvDj3DZEKqjEqBo7Zu433uc
         2ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733245761; x=1733850561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1AFTk+2y4ye/cKZJ8VyNtBFMtplF4PAovqBsExuifg=;
        b=LVV+EfHezzOWoKaaXm/QE2jJVSgswxYposqU+x7TUT3GsM2Z1pSh6SrcHQTJvRIiNF
         gqeso2l90wdJ7eqoyX95T7zd6Pm+XpJE05Tw/aJSiEs2Mh38gq/l2yqGbgLbFttlRib0
         8XSgAii4BMl5EbibfitYcC3V5RoHnzhUjbeod68Oi92nxBI8Q8152UtPThXNvoFSSVrr
         vgSIG48ed2gKZ5VxjYCARdpIlGHmK3r19++VG26NoF3f4O4dya0bEFtR4Kbwa8N2maAl
         nsrTTvMml0wwU/yW2cuvmPek/EupenoZPMWft9TVhDb2gEJjglWJsDMkrDqiDD62KjPj
         vlfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZJV5m5epxVZ5Dbeuc3nibv5W15ExrwyJZkeyIqHKlkKfTqK21NYpj5Xc4Bt4dVrhmSXc17pIq8N7P6FQ=@vger.kernel.org, AJvYcCXwHd339oqmLBqNuKdTl8lBfmpC7OyApRPqq2C42NpKR/vJXt8nzdVU8VTdWmXy1AIrYiAC02KrNrlbryVeUvsz@vger.kernel.org
X-Gm-Message-State: AOJu0Yznw3l4oSjP8by7DB27ko7A91DhJCmZkWnqJviPkrtrL7r+edNH
	t44vihupws/ymJvHTeJbTboseztxegQS0TV6bIJwSGTCqjCIs9Lg00WXLhe+39wPR9qUoKb8NIL
	T27CeURo5yRIF7eOgfroFpViBE+k=
X-Gm-Gg: ASbGnctKVtCBLbOssePaRy8GZfwPQX/xWBqmNynxDdHfsWIn5vIr+bhGozaz2U9h8Bh
	/wua+LzO79EP3qL4+vzM3mrPCavnVK1kwoPd7a3KsVHLCieE=
X-Google-Smtp-Source: AGHT+IEH4Iaouq4+dAnOhajlW/R/3YVdFVDZxit2HYfn9KIbYSg6cxVjypd9qHd/NsEzinpP15f9mru5X3fszcSg5EM=
X-Received: by 2002:a2e:bd12:0:b0:2ff:a7c1:8c31 with SMTP id
 38308e7fff4ca-30009c6e485mr26925511fa.26.1733245760541; Tue, 03 Dec 2024
 09:09:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102-kunit-qemu-accel-macos-v2-0-9d4579fddd20@gmail.com>
 <20241102-kunit-qemu-accel-macos-v2-2-9d4579fddd20@gmail.com>
 <4e57a6e6-f10c-4a35-88e7-ab4749f7e329@arm.com> <CAJ-ks9kEM2NkS4i9D+R=gsqSRpQSWSPFwFsVuzfQ+6CaX2LJNg@mail.gmail.com>
In-Reply-To: <CAJ-ks9kEM2NkS4i9D+R=gsqSRpQSWSPFwFsVuzfQ+6CaX2LJNg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 3 Dec 2024 12:08:44 -0500
Message-ID: <CAJ-ks9nwP5SPzGVFEk0W=6WCn=gnpRofdB+-NYvC1r5G8KLNFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: enable hardware acceleration when available
To: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 2:51=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> This behavior is at least somewhat intentional[0]. I have filed a bug
> with qemu[1]. If someone can conceive of a way to achieve this, I'd be
> delighted to send a v3.
>
> [cut]
>
> Link: https://gitlab.com/qemu-project/qemu/-/issues/2656 [1]

There hasn't been movement on this matter here or on the upstream bug.
We can either proceed with this patch as-is or restore the manual
feature detection that was present in v1
(https://lore.kernel.org/all/20241025-kunit-qemu-accel-macos-v1-2-2f30c2619=
2d4@gmail.com/)
in order to retain `pauth-impdef` for TCG. Could I get some guidance
from maintainers please?

Tamir

