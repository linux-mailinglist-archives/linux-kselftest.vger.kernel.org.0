Return-Path: <linux-kselftest+bounces-33823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B852DAC453F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 00:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EA41899B22
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 22:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9912241679;
	Mon, 26 May 2025 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcAgsPHj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628F84D13;
	Mon, 26 May 2025 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748298696; cv=none; b=n9C8PIxtOgRlwHBblT6xlaasLcKIUbzzJI1uVwX2RUU+AbqWXI3/pXRhK1DCzaisC2Z6agJMyVd1bXUtMb20sUjnxu7fVUGMEzNxFQ2tiWzh7CB4xj+E7XTsgQk6sFfLfpsmFKxirjUYwDL5sYOiSSJ9X6eR6jUY4NZ3I5kaIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748298696; c=relaxed/simple;
	bh=P4mDwunV/VK6ZdqBCM8ixj0ovsAxRm+C2bbqZqX2aJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yfb5zkfnj9Gw+zpJhS09Djz9pMTHYiaCc2qp3gwRTzXYVP7yrKXbYd3EB4VJTiX8ZxOpQfTVn3ylq1HUr3FNo7WuCDHljLgBnncRty2Wn7ZemRuX8Ltmgoj/ezBDKQMRa9UT79YEuEWUIAb7/f/atkaabpenn+aZuVmVU1auTFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcAgsPHj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32a6b34acd9so2923251fa.1;
        Mon, 26 May 2025 15:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748298692; x=1748903492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvLHYVJDLL1tRu00kxb4TV63RHH86AdnGIzbeTcCyBM=;
        b=AcAgsPHj7WP76AIqzvXSp6uRTWeh7NPFbmeKMMKeLuWmxHiyDa5+dbhf+M6UcaLim/
         hj53dMETzpAuyUDEJzI6TE2J8A/2UV6huxDEhpp1bsY5lTZYurfXpFNJJal4nRJDEqPj
         jMnH+YA9YcRaFMKZx4oSotzPdCV90C/0VqftOfK883os6Q9cHothq5Zkc6RsjVSkMjRU
         5xewyPpdVoJuE/YhKxiDW+l1ORFz5gzzpUrnCCBdapJOSGpzvQqqML7k8ViuWXgRQCp8
         lgyubdoDQGStJliX88dzLdt4Ad6bmtwIvT9F9NYE0vA9tk+PR5UyFt0o6LSaZDP+yS/S
         kZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748298692; x=1748903492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvLHYVJDLL1tRu00kxb4TV63RHH86AdnGIzbeTcCyBM=;
        b=tcE0IVBMV8pSHETOSW3NB+IZybTsWReuH334zZXTzEGkamuZcBii9YYg4nyFECOUcl
         DABZhiC1B+epV7COaHjWU7CzI990W8UbGNpcOBpi8CLykIgK8vChSiRwSu3QKedamwHI
         G4EKPiBQ6Fs+M/2V2VMXDaO2nCxPTYc75hSEFc1CJcyf74PNSN4xBig60Sb7qh8gdYnn
         llRO5DpWLuZW9yPc14DezWdER/7rzWnNfT0ep87gqu0ufLwWxmZX44q66E2UF+ENHu3l
         aCKlvW+yIdzzx+l60QZak0rpdAFm19Wun2ndXy0LUSHbQAece4U+pIIwEO8qEh37eWZd
         qImw==
X-Forwarded-Encrypted: i=1; AJvYcCUeSY8OyXvRCasiezCs/U9ZU/JcDqoW9IRsRCxJh86+IE84fuNvt9amilkfckQyF3QRFhYBMmHN1+ukLEG+@vger.kernel.org, AJvYcCV/1GJYMqO0GeJzYTqc+PGocFztV/ntvtlvGaA5WZZZnwro5ewu33vxYJ5ZFPTZPDuYBxY/XcXG9wLOS0ID4Q7V@vger.kernel.org, AJvYcCVRUb2lq6LOX9Ax8eiMEy14LtSt2pyt3GBMIVwVDD2I9NkNvcaMy6Sg4qszyVJmlbcUlrVpykKGMUTV@vger.kernel.org, AJvYcCWE0ywH+0A2EqrYDTdmUJq9CyTjwmi9Dw5WarLv4S5mowkIjtuRX9rLEenqeFoB9qIozFQ1KQ0qcLbliOU=@vger.kernel.org, AJvYcCWQcSNs4uhL75v/KhIC9jUAHO3icBGc9maJaYMlH/msGAmVN/BhZRk4MlNUIm6zqhM4R9PbPqmjMwm0HQAGYmw=@vger.kernel.org, AJvYcCWh/5nW/Km/FlGS61HVyt8Lj2zwmYK5hTfN+q7D5Jwkn9aHrvFAZxLO1v6DgLpg78jqvG5XVs7ug6KG@vger.kernel.org, AJvYcCXu/478++46yTY51naKwSQu133M5keYOrrL7hLQ+1ioc0lQakZki+FQpIi3oJQpuQXa7iHx9j5d@vger.kernel.org
X-Gm-Message-State: AOJu0YzUoumvWkyesBhZwc22yUNIp3WvxU3UQDuYwboFC6Y7KUOsG54x
	SFC1o63Gb1MR1nT2/YmEEZZ/mAR8HOVxwcyWlnT+9xA341p/1rkJb+bEiXhZ//00jBoTM9G31f0
	kNhNcz2H47rNpEmtery5aD89D20JkLKY=
X-Gm-Gg: ASbGncvoiPWGbGzKrK4qPQAtzeyeYhc3i4+2MJ2K60uozvCMVfo/loLDntPwPyPPLuP
	rcySQNwojswBGiZKkY0ciYV+hSjBnke2wQu773/G3Q4RgujxU5HQEfn2JEPNXy94RZvCvTMEPzG
	D3RBygZAseA1+U7w07szrxQcdu1AONKS6alZ4tma/fZ0BOK9c410KdNPrqUnzwL9bH2i8=
X-Google-Smtp-Source: AGHT+IEJfWzc6VPUDuyUq0aTn+WE4sTfnbgvmOYP1K86Po8lb+CyhSBKVylPu7Ej7IoVB3uFqztWGvTQz/dCfNqAd+Q=
X-Received: by 2002:a05:651c:f01:b0:32a:664e:a923 with SMTP id
 38308e7fff4ca-32a664ea9e0mr10313091fa.22.1748298691742; Mon, 26 May 2025
 15:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-5-6412a94d9d75@gmail.com> <DA66OFXQCWUK.31LM78DIVABZV@kernel.org>
In-Reply-To: <DA66OFXQCWUK.31LM78DIVABZV@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 26 May 2025 18:30:55 -0400
X-Gm-Features: AX0GCFuHGuPmwsi9tWeeUypjxRW1UrvRCX_LVo0C-ggOVzUmGabC1z1bBuoaiZU
Message-ID: <CAJ-ks9m=okC9_K2MJU80xbnO+3+Z0hvC_FYzCtzW9pD=WA_xqQ@mail.gmail.com>
Subject: Re: [PATCH v10 5/5] rust: remove core::ffi::CStr reexport
To: Benno Lossin <lossin@kernel.org>
Cc: Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
	nouveau@lists.freedesktop.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 11:05=E2=80=AFAM Benno Lossin <lossin@kernel.org> w=
rote:
>
> On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
> > Clean up references to `kernel::str::CStr`.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_panic_qr.rs   |  3 ++-
> >  drivers/gpu/nova-core/firmware.rs |  2 +-
> >  drivers/net/phy/ax88796b_rust.rs  |  1 +
> >  drivers/net/phy/qt2025.rs         |  1 +
> >  rust/kernel/device.rs             |  3 +--
> >  rust/kernel/driver.rs             |  4 ++--
> >  rust/kernel/error.rs              |  6 ++----
> >  rust/kernel/faux.rs               |  5 ++++-
> >  rust/kernel/firmware.rs           | 15 ++++-----------
> >  rust/kernel/kunit.rs              |  6 +++---
> >  rust/kernel/lib.rs                |  2 +-
> >  rust/kernel/miscdevice.rs         |  3 +--
> >  rust/kernel/net/phy.rs            |  4 +++-
> >  rust/kernel/of.rs                 |  3 ++-
> >  rust/kernel/pci.rs                |  2 +-
> >  rust/kernel/platform.rs           |  2 +-
> >  rust/kernel/prelude.rs            |  5 +----
> >  rust/kernel/str.rs                | 22 ++++++++++------------
> >  rust/kernel/sync/condvar.rs       |  4 ++--
> >  rust/kernel/sync/lock.rs          |  4 ++--
> >  rust/kernel/sync/lock/global.rs   |  5 +++--
> >  rust/kernel/sync/poll.rs          |  1 +
> >  rust/kernel/workqueue.rs          |  1 +
> >  rust/macros/module.rs             |  2 +-
> >  24 files changed, 51 insertions(+), 55 deletions(-)
>
> Haven't compile tested this series yet, but this commit seems to suggest
> to me that some of the previous commits introduced code that doesn't
> compile or emits warnings? If so that needs to be fixed.

That's not the case. There are no warnings and no compilation failures
in prior commits.

