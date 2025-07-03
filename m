Return-Path: <linux-kselftest+bounces-36468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E724CAF7DC6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 18:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721B854185F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818F624EAAB;
	Thu,  3 Jul 2025 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3sTY+eu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D8230D14;
	Thu,  3 Jul 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751559985; cv=none; b=DKfr1fPZ5JLRm4gr9rynPLRDLf4cRWdpyY4fYq3Tb2osG4+jyC+VQFTU3sH7zfCQvnfo+VRf1JDkJBl+nLjkl23Xb6haJiv4V7ZGPu5vmYvy6IFxKuBMvjlLFhMBevniyr842ea/dvBBok2pb6CcFA22BHy3EqO1AA08OIf9P70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751559985; c=relaxed/simple;
	bh=rSyt4WnF+qHRwEMJ5395X7EAvgdTWUY/zMhaiamm5RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVC2h1s7nUxxGwV0yn+xms37AYNIAzrpqHpuakdc+t66nGlgg2O0bS40KAHgiOkdqveNY380mM4Hy9alXOiqgHS9QCxZi+pcl+Ni7JuRDDSkfEQ0kXNdVC9WjMR0DPk5Q9VcVPkJJl8ud7M9GhG/EnkTZbu4VI1pckSX6gCPCh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3sTY+eu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2355360ea88so128595ad.2;
        Thu, 03 Jul 2025 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751559983; x=1752164783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSyt4WnF+qHRwEMJ5395X7EAvgdTWUY/zMhaiamm5RI=;
        b=g3sTY+euO3GvTdVZ8f0/AIpvIM3PPPLGpOLLt7qMJhCZpZx4qtwAj5qaV1C5j64VWd
         9GYqDMsg60tYlHvviG85u4Ww/WYvch3EaYPIe1Cb1PTqlIQOWglSixKljpSq3o0SsRYu
         zRkVVskX8i3S1b4J+MnUbpUqa3b3E6MWWMMgh033WQIVn/r2t2dhOl5UFZLf/C0CcTQu
         xbYMeISan4ioanBy6UtKgk8pqaCv4IYE3b5eiWxqueB9wuMKSusV7SGPT/iD1myxVfWL
         aWtjsZ8d+ptWhbxnPK2dnH7pG7vz3rZSMffgBeKOmg6p9qtd+ABVfb5JYI9ZnoYjEM5+
         OGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751559983; x=1752164783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSyt4WnF+qHRwEMJ5395X7EAvgdTWUY/zMhaiamm5RI=;
        b=cO0G34mIElQphWEBFCx5WPGW0ROHDJbu75a4s/BU8D94cKvCsGPsrwgen+o3RRoFw4
         69uIBr+Q8joxDpp/ziohQxDXa3KokH4GXtEZrcE48GwGz6xV5ED5mEGZlYf8TSxy6/hn
         tmWBoxqrYCvCygvwS0QmPyUoyBUo7ClaSKQKNuKPyX2DeOajLVhdW06hA6FOyTiVGF0N
         8k9aj/vg2cxw8E7ouRORWRadLSpDEtapPhN1+2g1t5vL1a8wC2qxLP3zkuGJMrYN8LSp
         1TA+GQFWb/ybbGBxl5pX2Mv43Vx+sDTkBn+yhrcwcpksXZcRuXB00IQoHOCB0lkDuLM8
         mfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+pHe6VHHgmmuUbhOimV5itDneHlMbEjFQfN6m6xztjScc+o8S6ficzTNlodpXjiD375pnCuBcDuk1REFlrY9a@vger.kernel.org, AJvYcCUtYvhmCzdO9PpoXeSD3XAunsCmNpuHJzCQBUchnDqpxJeGlr6PdspRhKCpNnfCkhhdIN2kF/1BQBhG@vger.kernel.org, AJvYcCVe+hgrz61eq1UlJSA2eykJk21xWwvUWlmrImepYeAiyYkNbMmn7vjkPtSB+mQyVF7K8BOlXzwcyffl@vger.kernel.org, AJvYcCVpitAWol/gOZfK6FfPHRS+n1aRWViDgJoD22OXyEnMYEd72vXXgz9SBWYFXYj40hVsIvprNWM4q92F5kE=@vger.kernel.org, AJvYcCWdBLcvOf7eL6EsyLOJ8i9qjJ3CxV9WZxz3jRTRmRVCWW4h+ibT+LgInauq05BzcNCXddyJmTGR@vger.kernel.org, AJvYcCWlDbzXekGXS3AOJieIdqkZdvsAnMkXlF0qWjv66aNFapouOYzRBDWQB9McZFy0e5L9Fh6Vud3vfSNB@vger.kernel.org, AJvYcCWlgSqyRp5WSRVv0+5W6c/pGqRekVJgYfeZd2z8qs+HIqdsHY0/JOo60PWEKS30u32JjQFXT6eGj1w8yq87@vger.kernel.org, AJvYcCWp7siMtuYNbrzpdRc1hKn6Wyu3fr09yNsmnulH8hBDdbVoetBs49KuXddg5f3QIl1TmVg988MPg1Ha0ZiF0eU=@vger.kernel.org, AJvYcCX08kByfDL5ec+P4zBbyQvNQ5ueSMKXswFTOy0pkd1CPMlrwkHWgz8j88Qb9lYqDIM23JjlzmXK/t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzofDK51ZYbATHuFb2uW/IRLi9TvLKi+CFTCD0hxxwjsCHl1pj0
	yl++iggY0A66EuTXW2XI7NV/7h9kQDrLxwlwLVi/Y0UZy4DQ5Gv8PKSmI2nW99sAeXJCNBjJ0Ru
	E7DFg27jHqAjwSpEwbysyL2qx8vHqd54=
X-Gm-Gg: ASbGncszFfX6DWMo1cZPqQL/Ylv8YZ8cbpazdK+JrI4gs4OhcG2oxXpbGfyukCek5w7
	uluCQONxpZQJzk2V8X57IATzIAtnBAQ4IGs/1Q2f/NbQkz5XCT7YWlrgAZmHSxdohohWP2Vkc0g
	KI4ukOhApuTwD5+8AOWYge5LVTOuksFqh796qfUdTOParaGoZ9zvbBNQ==
X-Google-Smtp-Source: AGHT+IE2AsrunGhRqAPTssN0vu1pH9T/puSPtq1EYmN/wZ3G149WG6FCC+weBXEH09090+WjrZpEYCR5WVBab3y8bBw=
X-Received: by 2002:a17:902:d50c:b0:234:cb4a:bc1c with SMTP id
 d9443c01a7336-23c7b2c48abmr14508535ad.6.1751559983011; Thu, 03 Jul 2025
 09:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-2-29f7d3eb97a6@gmail.com> <DB2BDSN1JH51.14ZZPETJORBC6@kernel.org>
 <CAJ-ks9nC=AyBPXRY3nJ0NuZvjFskzMcOkVNrBEfXD2hZ5uRntQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9nC=AyBPXRY3nJ0NuZvjFskzMcOkVNrBEfXD2hZ5uRntQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Jul 2025 18:26:09 +0200
X-Gm-Features: Ac12FXyK3yF1o66pvRj95wQBg--_tN8783HmS0ZULfxKl6rLdQ-EP0UVIzak-4s
Message-ID: <CANiq72=61JhEf97JTkineo+FX+JG+Q9x9x86MC_hukSa9YSX3g@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] rust: support formatting of foreign types
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, Michal Rostecki <vadorovsky@protonmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, llvm@lists.linux.dev, 
	linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org, 
	linux-block@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 3:56=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Can you help me understand why? The changes you ask to be separated
> would all be in different files, so why would separate commits make it
> easier to review?

By the way, if we are talking about splitting, it is easier to land
patches that can go independently into different subsystems and
avoiding flag day changes (or making those as small as possible), i.e.
ideally being able to land big changes across more than one kernel
cycle.

Cheers,
Miguel

