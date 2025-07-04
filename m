Return-Path: <linux-kselftest+bounces-36546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41997AF91FA
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3CF1C41102
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0922D5C6F;
	Fri,  4 Jul 2025 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8Q8TmlB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0657F2D46B7;
	Fri,  4 Jul 2025 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751630347; cv=none; b=TYSykJYeVJWIWVSk99WEGlSOGaOMfL+s8TPxMgKRaQ7FRpz4SyJJ1OJ6vykP2qjYOcS+KnEyIO590mXJLeASOYSf3qamT+i68PKHVKq6I6rzFbuGKgMRQsqNSkwbhlg7eeAKxS5z1yMbZZzOLUrQ1Z9qqi927X6OVE1ZQMOhAdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751630347; c=relaxed/simple;
	bh=mKUAfa6GAdUfi2Bvssbgn4xEiZsMisIFcKKgtP5vijk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+6pSwIttWZtlm/vyngKdt/aKt0MwvdJ2Wcg53iWJLfa2XFkvt8lO6HpkgJ3CNnBXqID5w3NqVkUhHer8cajBPioozc/FlfH0XBnMT6OD/rIxjEpsLSauWYw1/gUvDRDPAiASKmUCNcZmXug18AWPOsTMKacFXHWihwD1bh0x5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8Q8TmlB; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553d771435fso789019e87.3;
        Fri, 04 Jul 2025 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751630344; x=1752235144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX2ezheHMTwCnwKIKFQeSSolcoT52guQ9m4zT7OdyqQ=;
        b=J8Q8TmlBsCAnNvuLXd+nap/CgBFWqpDBEP+BQFK8kfJVt/SG7pq54DDshk6MoHesgU
         rS9VfbAkXbDt2N7xXhU38UoN7BO0ZBek9f7XZUIGzwuYf5Di2jNfuHSDAAnT4TfWIhcs
         2gWA1XrcA/6r7UB9qmojI2uJnr9j9R90j3PxqWshV7utJVFDgpMQuyJ6amiTfPYxun3D
         Pe1XP3CbCC63EVN5mBL1/fCOVJY8hKcRrbWBz4upM3yPtwO9KVt+8AhnshRN2CfHrxvs
         Lbt5CX0sOKU7CedjMBu2KTqXc3F0cz8RdqYzFrzaKGd5+OcOiLSzMCAJAl4AZwkGll63
         lrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751630344; x=1752235144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AX2ezheHMTwCnwKIKFQeSSolcoT52guQ9m4zT7OdyqQ=;
        b=GrJOHzdRUuwodT5uwbxzJvv5XmFBA/HZVmjpxEDOnCMLqq9KVYs5HbXkXsSTeAPQSs
         qDugqM2DVtrQikleNpJSiMah825CoBpbdeRd5y+FziesbMa4isQmbUSpm8CDqn5qJPlJ
         fS/ng2Bw0jP9iNlatvreupVKCOVgX0LfJ+1lDHfi5BMGNNF9MeuqllpZgGXZnuKR2w4c
         YYKaWU4GPTi7RVuqWjnZEjhPdloNMPazIA9IPktAw9ni2LQE56vMXBAdJicTV1OBq3lf
         QwS6XyTyK/E4f4yP+Lq1+cURwhrGgCgRyRQ4hlI7M75XyZKrJUs0bOzRFwsHYegWwirg
         EiYg==
X-Forwarded-Encrypted: i=1; AJvYcCU/xd6Mz7mx8bF8/3Cqqb+nKuh57hu3c9Hf23AfawPmfSH525LGqIBNffzCDkPCPlwvUHvJbfMXvF5a4L9QHrrz@vger.kernel.org, AJvYcCU3tdV2S/RiI759OTqYBhQdPn/oHXoqB7iYzCsVpVLLza9cYkiGRSHTStFNyD7thhwJTwtQ4M+p@vger.kernel.org, AJvYcCUUsCf88rrXXnKhvyymItrsyROOl65AZr9g3+freHphQDkR4Hb45h5EeI/8NFkQIFZUiV4zr+aJ2ahazovR@vger.kernel.org, AJvYcCW3Uc2/96AgEBtZYlgBj/bFFhpclOB/1jMIgMJlUDt1NrMTW+HzVwtWPohbyYygUbH+HVAArHyge8QQ@vger.kernel.org, AJvYcCWGzo5Io1lAy2bZ0A4l1hzEMkQkC80kB7n3Oorrsq5kEzu5w5J1H8TmGHCK88CFluxZfDUdhVU2bF5l@vger.kernel.org, AJvYcCX4h36/cAOeUvtqEGw7G5upkRJF13s70pmQgbinL7T0dyTLrMFCzC0c2aBfTrQkXgoD4sCEoQEf6kS7@vger.kernel.org, AJvYcCXC/vZdZJTQRJz3DQl3LDcAeJ7pI5grAtBxFuxEcKlv0eCynBvi+jX9E7c2MaRBpy0jTfqQCwcZ/1I=@vger.kernel.org, AJvYcCXYz+s26BOgYVlQis0ehY0FFS9hJ7LhdFueciGkGH7Pl76HGlMwZOXfm5zVfNDMwbRMGsMZwhHxEFdTOM11uL8=@vger.kernel.org, AJvYcCXcdmdE8a7w/Q6NGLNH5phgPPn7iviKvvfA+ss/LXbBIGeZMyjVXhSai2AmirG0i8O2xAbhm3lA7FawWnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBaT7HMo3b2Zg56BiRTlg8Fbx6vpMkv5BTlDXnH2C5X6Jn3M2x
	dmm248BcHVItzCWnDz6eHyWCIG6I5fdQpo8Q8Eluh0Q01ROco7fQ8FSDx5A5HWpztCZCO4tqrkB
	zVC+OhCTna7HHdYJam4DBK0cwl+XP5+w=
X-Gm-Gg: ASbGnctTj8nlyefRwWrRTsIgz3JYgQlXaXHk46wVBVv3NFAFwox9JrMC5eQTDi7s6nt
	8jWCcTUwyrlevDFa+YiUgTRkSRlyU+JgDgIQzIGpMITLpkwa+6QsTjSC/wF/m4FNo6BGw4d2Xyp
	qlLpgvnqy30G+2Nv67ZNogi7BGASEHkcCKNpM/oN5mX+4a2LN88YCdh3DAaSGGQvQKurG/J9msX
	IQwfA==
X-Google-Smtp-Source: AGHT+IFprJqElpi5vcjeJ23fLLN3WMzZLZ0CrkVny13pfXY112X2yXfPm/SOjbYZcibT+i59JoBTBmJ65qELc434iFo=
X-Received: by 2002:a05:6512:2528:b0:553:2868:635c with SMTP id
 2adb3069b0e04-556e60879d0mr712367e87.48.1751630343665; Fri, 04 Jul 2025
 04:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-2-29f7d3eb97a6@gmail.com> <DB2BDSN1JH51.14ZZPETJORBC6@kernel.org>
 <CAJ-ks9nC=AyBPXRY3nJ0NuZvjFskzMcOkVNrBEfXD2hZ5uRntQ@mail.gmail.com>
 <DB2IJ9HBIM0W.3N0JVGKX558QI@kernel.org> <CAJ-ks9nF5+m+_bn0Pzi9yU0pw0TyN7Fs4x--mQ4ygyHz4A6hzg@mail.gmail.com>
 <DB2PIGAQHCJR.3BF8ZHECYH3KB@kernel.org> <CAJ-ks9=WmuXLJ6KkMEOP2jTvM_YBJO10SNsq0DU2J+_d4jp7qw@mail.gmail.com>
 <CAJ-ks9kNiOgPO7FF3cAbaSNtTWs0_PzQ4k4W0AxjHNFuMJnDcQ@mail.gmail.com> <DB36T5JWBL10.2F56EDJ1XKAD0@kernel.org>
In-Reply-To: <DB36T5JWBL10.2F56EDJ1XKAD0@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 4 Jul 2025 07:58:27 -0400
X-Gm-Features: Ac12FXwwR0QTbVNjts9p85kYh4knK1uvCt11R29enEo0nBiKI492OfZj839T-II
Message-ID: <CAJ-ks9=Jutg+UAwCVER_X91BGxWzmVq=OdStDgLZjTyMQSEX6Q@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] rust: support formatting of foreign types
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

On Fri, Jul 4, 2025 at 6:09=E2=80=AFAM Benno Lossin <lossin@kernel.org> wro=
te:
>
> On Fri Jul 4, 2025 at 1:23 AM CEST, Tamir Duberstein wrote:
> > On Thu, Jul 3, 2025 at 6:41=E2=80=AFPM Tamir Duberstein <tamird@gmail.c=
om> wrote:
> >> On Thu, Jul 3, 2025 at 4:36=E2=80=AFPM Benno Lossin <lossin@kernel.org=
> wrote:
> >> >
> >> > I don't understand, can't you just do:
> >> >
> >> > * add `rust/kernel/fmt.rs`,
> >> > * add `rust/macros/fmt.rs`,
> >> > * change all occurrences of `core::fmt` to `kernel::fmt` and
> >> >   `format_args!` to `fmt!`.
> >>
> >> Yes, such a split could be done - I will do so in the next spin
> >>
> >>
> >> > The last one could be split by subsystem, no? Some subsystems might
> >> > interact and thus need simultaneous splitting, but there should be s=
ome
> >> > independent ones.
> >>
> >> Yes, it probably can. As you say, some subsystems might interact - the
> >> claimed benefit of doing this subsystem-by-subsystem split is that it
> >> avoids conflicts with ongoing work that will conflict with a large
> >> patch, but this is also the downside; if ongoing work changes the set
> >> of interactions between subsystems then a maintainer may find
> >> themselves unable to emit the log message they want (because one
> >> subsystem is using kernel::fmt while another is still on core::fmt).
> >
> > I gave this a try. I ran into the problem that `format_args!` (and,
> > after this patch, `fmt!`) is at the center of `print_macro!`, which
> > itself underpins various other formatting macros. This means we'd have
> > to bifurcate the formatting infrastructure to support an incremental
> > migration. That's quite a bit of code, and likely quite a mess in the
> > resulting git history -- and that's setting aside the toil required to
> > figure out the correct combinations of subsystems that must migrate
> > together.
>
> So here is what we can do without duplicating the logic, though it
> requires multiple cycles:
>
> 1. We merge the two `fmt.rs` files & each subsystem merges an
>    implementation of `kernel::fmt::Display` for their types, but keeps
>    the `core::fmt::Display` impl around.
> 2. After all subsystems have merged the previous step, we change the
>    implementations of `print_macro!` to use `fmt!` instead of
>    `format_args!`.
> 3. We remove all occurrences of `core::fmt` (& replace them with
>    `kernel::fmt`), removing the `core::fmt::Display` impls.

That would probably work. We will probably see regressions because we
can't just replace `core::fmt` imports with `kernel::fmt`, so new code
may appear that uses the former.

I think this discussion would be productive on the next spin. The
changes in other subsystems are now almost entirely changing of import
paths -- perhaps that would be sufficiently uncontroversial for folks
to give their Acked-bys.

