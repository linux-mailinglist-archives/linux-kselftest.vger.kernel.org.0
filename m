Return-Path: <linux-kselftest+bounces-34927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D4FAD943F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 20:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC431E3E69
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB56C22DF83;
	Fri, 13 Jun 2025 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc/SufIb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DD42E11AE;
	Fri, 13 Jun 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749838496; cv=none; b=hZpy1UqtiNA9PbJnsQ5GbbY+nlDxcFGq+GkZpB64snhGt0JTaRoHTEzv+aZvcswDf7LDdzdYP+5WYZy8i35V3hLYrAnavNhb2jlIpQ8r37wakvT43V5O11/iOce/A8jVZlTEJ5+t/lqQylB3ASDhe0FqzVxPVY9NtO1zbR1tK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749838496; c=relaxed/simple;
	bh=KjYY4bsTZUm05TpfR2l4YdrK8TqDiMRSIg8azQwn+r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+0tKsyQuv/00ta0/2TInysyq5G2CgcwIj3etfFSF+IczCuuZ1H++h1oA9SWGTY9mrRu888y50JAomGCPGbJw3/VjGL7YVvLgAhhgU69guF1kJLLdQIH5ekqea8cORi3QjO4B/JFDLBgm0gMI5QUJed/zJu+x0n7hZjihbc39Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc/SufIb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235a6b89dfaso3343005ad.3;
        Fri, 13 Jun 2025 11:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749838494; x=1750443294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wF4gp/2m+krKdbuHM8VFo8aUcpegmRfbsaqd6bWd3zs=;
        b=Rc/SufIbtuMmpD6Mno48+Skl8X3xzck1mg4EWxe6804WHz7pH+EKgPkswvbcEreSu5
         55oqAjn/WPxKlODXvgqYjSkFBCqL1PKYy600xyIsvMHPH1REnw8Ojtr/BDShRpubjeJN
         ChUiAy3pCMUuKVUJof1Md+byZ9whV3SJxm7JwR/1509jvdE1gjBNJHIdSLnFdoRJ9/LO
         9gEr1lBKgiqaa9Jp+3R/RP+TjyjPzLG6jSJXMRfcZPUlO3V3d3vCyyDb5fRGHECh5BQj
         8ItRs+1gNF+br83shz+NqLHQiRChLMODrK1bmne9LMXgfjFawxW454wsP6mutWOOOI86
         XPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749838494; x=1750443294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wF4gp/2m+krKdbuHM8VFo8aUcpegmRfbsaqd6bWd3zs=;
        b=a1nh24khltTWa4mq05V0VzYI57drDu/r8guM0wAOrPkxvvSoLE69Rj4ChrKjmLdVyR
         //hLa/Efx2F1Qmr1HIwOBV/5RxTD8bA7dHmGLiNs6D+Xld3gMC3iLkd0keR0f5wTchVP
         damEV7SwcZhLOQPWvvq14wZyF4AolRuSx7nhOdElbEabZBs7yPGxJziNsa6Gwlng1Rzl
         qBvTOkWOZFgZiuSQhgi1zpmvALOrXafvyxQME7CBzNNAY25Wrd9zRSNk7LpWDnxBOxxH
         2gyTDSZ7GUpOXTib6lJfR7ScPsF1MOJM7Lkc5g/X5vzERBI5QkFO4UzV69GW+QYN/xgv
         IldA==
X-Forwarded-Encrypted: i=1; AJvYcCU3LN9yfgUSWIJHmnl8PNaFAmvjXZk3bcW457RiAKzEBiQ68wmU5SzrBjQA73MBBbv4xgrlVXaSZMGe@vger.kernel.org, AJvYcCUHdPdao90MhiLwLKsAwfVqHpmXqGlgVTMFtmSNd+eL93lbVdR24OLce0dymDr3LqcjwNYcVLgO@vger.kernel.org, AJvYcCUPaoZiGpnoKO4M72G3wLUM28MVs/1Fnrbfduv+rnqymyOhIXeO5It7dUOHpWAp1D3jH68pxI16SfK5wZQ=@vger.kernel.org, AJvYcCUzM1y4jq8dbckYTzfQgVanNb98jKiF7T4PB9AAHhmpfalKuY6gsjeWD+a4RHXyplrZ7IW/yv2kW7MixE4S@vger.kernel.org, AJvYcCVhXaiv16f12Fl5+p9ZAuu/cBk/u2Ndk90zp6hmkclL09yM5xwTUwgKQVKQtsb/Cc7WXm/Jmh1cD6LPVEDJiSY=@vger.kernel.org, AJvYcCW/6sPwSn0aJXdOaSH9OOT5wp3BYbITyCZgVDn/VB3qQMOfe+STW3AyL99n2SraDQBNQeDok7v5rUl9Tjh0@vger.kernel.org, AJvYcCWb2K0JENWU1RB1FxUR/0SMZ9RfuULepOHJUw5IimNlklWCiR2eTZiAm3tjMQfgXnWtaShyimVgwshb@vger.kernel.org, AJvYcCXZhCj3LEzW4HlFMEEA3xlCJmf1p5VezLoZGJuwb6hZ5nInK7KF0MMlKoQ8NktyIO1jcC43gIUgSrHGLb67BwKv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqd+YBtiMxx7BsSJ/M5sHvCtilN4OrfwatALPNxn3Ygy5Efjz4
	qIHmkoLMatb55QfBME9BxxU/x66CVXSxxPVYAQiqldGEq8ZAxZyZm1kWZeYhbT92R+NgFnKqG5q
	aadVQaRdXX52b3AlwbnXma/9VwLbUJUY=
X-Gm-Gg: ASbGnctTTRR7XYh0Ygs0sWzTsWBS55j+naRltlgMTgeBbp7l20bOQ972SXXRs15/tUv
	Ib9FkNxMiUp+eOsk9vjFK8dZ7mLKHtVoaspcQyXqnzljU3tcovx7+DN9qSopHuRxK7BiSMGBP3T
	5RTBQZwqOTHOs/LKZrSQcoOWQ6LcONv6QLdo8km5vUGxQ=
X-Google-Smtp-Source: AGHT+IFYalb1OTW7qnfDKSlOci9VWDAXekpMbN5b2vtf3GW8ZUpuOTwRiHQFxL1wuWQtjgsw7eVkO7CajlLxN6YkM2A=
X-Received: by 2002:a17:902:d48d:b0:234:d14c:50ff with SMTP id
 d9443c01a7336-2366b00ba59mr2634725ad.6.1749838494222; Fri, 13 Jun 2025
 11:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-ptr-as-ptr-v11-0-ce5b41c6e9c6@gmail.com>
In-Reply-To: <20250611-ptr-as-ptr-v11-0-ce5b41c6e9c6@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 13 Jun 2025 20:14:41 +0200
X-Gm-Features: AX0GCFtsUq0DPj-o5G6erQ-PfWcX7A0QtacSDQOlDe1Lx8EsxSkeObOaFNw6_Co
Message-ID: <CANiq72m1ZWxPgCda1C-8X5XOvEq9Z9JfJZqhU4ZUzZ64=N+2fQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/6] rust: reduce `as` casts, enable related lints
To: Tamir Duberstein <tamird@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Benno Lossin <lossin@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 12:23=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> This series depends on "rust: retain pointer mut-ness in
> `container_of!`"[1].

Not anymore! :)

> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Thanks for rebasing, Tamir, I appreciate it.

This has a bunch of hits in configfs, cpufreq and Nova [1]. I guess
you built without those enabled.

Could you please fix those? Since this affects other maintainers that
we need to ask the Acked-by to, let's try to at least give them the
final state.

Thanks!

Cheers,
Miguel

[1]

warning: reference as raw pointer
   --> rust/kernel/configfs.rs:429:9

warning: reference as raw pointer
   --> rust/kernel/configfs.rs:467:9

warning: reference as raw pointer
   --> rust/kernel/configfs.rs:479:9

warning: `as` casting between raw pointers without changing their constness
   --> rust/kernel/configfs.rs:564:48

warning: reference as raw pointer
   --> rust/kernel/configfs.rs:721:39

warning: reference as raw pointer
   --> rust/kernel/configfs.rs:764:35

warning: reference as raw pointer
   --> rust/kernel/configfs.rs:783:35

warning: reference as raw pointer
   --> rust/kernel/configfs.rs:764:35

warning: reference as raw pointer
   --> rust/kernel/configfs.rs:783:35

warning: using `as _` conversion
   --> rust/kernel/cpufreq.rs:650:45

warning: `as` casting between raw pointers without changing their constness
   --> rust/kernel/cpufreq.rs:650:45

warning: using `as _` conversion
  --> drivers/gpu/nova-core/driver.rs:22:64

warning: casts from `u8` to `u32` can be expressed infallibly using `From`
   --> drivers/gpu/nova-core/regs/macros.rs:267:26

warning: casts from `u8` to `u32` can be expressed infallibly using `From`
   --> drivers/gpu/nova-core/regs/macros.rs:267:26

warning: casts from `u8` to `u32` can be expressed infallibly using `From`
   --> drivers/gpu/nova-core/regs/macros.rs:267:26

warning: casts from `u8` to `u32` can be expressed infallibly using `From`
   --> drivers/gpu/nova-core/regs/macros.rs:267:26

warning: casts from `u8` to `u32` can be expressed infallibly using `From`
   --> drivers/gpu/nova-core/regs/macros.rs:267:26

warning: casts from `u8` to `u32` can be expressed infallibly using `From`
  --> drivers/gpu/nova-core/regs.rs:35:65

