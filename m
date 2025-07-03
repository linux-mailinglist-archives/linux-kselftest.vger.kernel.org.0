Return-Path: <linux-kselftest+bounces-36490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDC0AF8437
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 01:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF93189618E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 23:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF52DBF52;
	Thu,  3 Jul 2025 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB9tu05g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5322D94B6;
	Thu,  3 Jul 2025 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751585045; cv=none; b=me1G+SuI97piT1PixwaDwSumdWD3pR/Huv8e5ysO9ypsFR9qwtNRU2CfKGkJ/9btlw343Zxkjnsqj2xVDXwFAjqPpPEskcbvDXGhlYBgW/4awV2iwBwG6fxmAprUKKF8Y+CPiEbomgfXKF/d6tpM3WIqXyO5KwM3Gc4z5eDS2Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751585045; c=relaxed/simple;
	bh=nJsInj/KQx9EGZtnfCPTimlBjeCBkdNYOhqpDUWoVDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBxl8owFfTYp252jN9lEq182f4ZnQvcgBNTYAGsFe1D/WnmpHOVof2UUQ5zceV/fmZ1+GHCFrJzgn1yH+07br1Ll7g/AhdEZQpLP7ZBf6ybbPgf9AeKEWapsbnKk91YT8YWlxVSQLcG2EULEtU6ZR0hkSV5fOiX5EOLLXcnhMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB9tu05g; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32cd0dfbd66so3274591fa.3;
        Thu, 03 Jul 2025 16:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751585042; x=1752189842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtvbM0ZJbl7PRtVkId0uy2JLD6jAbUhYMSmm1BPeVlY=;
        b=gB9tu05guwikixpb2+OLLd5FSD0A3Zqv1vIOWC+LySdSdvlJhhRAJsp8A/E2fu34vj
         YYe9wR4Un8P+Dj4EAwgGgSb2K3ixFG8qAys/DrSHFbRUvrHtF8LpiCePigrx8NvGwIMG
         1rpdurTzh0eB1LyvrDdgsyW9ovRyP43xdIFY6LsGTab/0TQZUG4r+yNx1RRah62nz9wC
         gn/aWy7Hg1+cX0W4POjtgsEsAirs/ili44VQWFmvOzpffMRGPVKMlyH8gGVhQ1OUgrzx
         LMAoxV8ygpjkuwK1lDo0J44+eIcVx/GAIREJpbbZLfZuNJGWgEc3e/cJGp2gV4YmMww+
         //bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751585042; x=1752189842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtvbM0ZJbl7PRtVkId0uy2JLD6jAbUhYMSmm1BPeVlY=;
        b=UdbXuAMhIvtW+S5FnD5h/58wNpzEQ0zEhYOGlQcbo0JadRDWc8ltsf9zJGVr3mlOLB
         xF5Ly1ThDTVEW7wsQzjIcyOHJhLyj25Kuw5Ey0kWSZ2awjLocd6DW8H9ZxSWJAvb1w2z
         k9WJ4E+2O9UZF+KydRRBZ2iIcBiA26uPezhwwv0UBUoJ1aiMujy3Pfj5xb0LGXjonsTq
         EWv2zdg5HhCbtw/x04zMhFkIkfXYoffjvGzj6413qOUHgrzp4t+iuT4Nr3SikFOoZWm4
         2X4MMdgJjOB+JaQhO5l50v4uDWvQazJWzl8zyqKidRPZwjRbYjigIuENse5swesMMcQu
         hTOA==
X-Forwarded-Encrypted: i=1; AJvYcCUBVfZJu+yCKUCc1DhccOSaqCp/o2KmIS+qQ/LO1LjXHK7LdXSuZnvbDofHtVZDcw1ZoxcLwVu3W3RW@vger.kernel.org, AJvYcCUInYjqaTCCYziykyiMasmPG5GXxvNt+ALwX1IJM4mMub3CZ0XKRdKTFiJLFC8nJcnBR4FXYcmw9/fsOePSGJk=@vger.kernel.org, AJvYcCUhvzmLPpOwL7FPWRib3ngiLvPVNhcGG8oFi4uHmMEmuNo+pfGMkWn2RuMOCRYiCWX4nX7mB+Y2rIU=@vger.kernel.org, AJvYcCVGOKaezMtDqqgtE0XrNrAf3oZ4wGoh1z7HmVRO++oB2qTAz5axjQhkeyAg5y0/mL8hkKhYa3l41QCB@vger.kernel.org, AJvYcCVS9CPlPD3HL1p8BTA6CtvDTSlm9vK13cUPE96iONBbKxrpwg2gIdM98Mr5I64tOz7Q6AoBMqotvJwC@vger.kernel.org, AJvYcCVdLg79700bRZTxo6TkDpK4SfM4+j8SftpRhPv0WO9NYr8YvhrIN/cKoafbcm9cDF3kMgWA4XOp6QwPcTA=@vger.kernel.org, AJvYcCW5jmhSOXPjFaK2sVIV8OIHqXXZqvD9tZCtVxqKc27Uoq8wl3RhyAG8J5yOe9Ora/m56bnGnao79F8iZZVW3ztQ@vger.kernel.org, AJvYcCWqPd/m8Vhdij+EBRz3TpsqKebZGWeyvZ9PQyG8nMrNk/JxIlvngTQKhID/jzP36EWCbKsX4uBr@vger.kernel.org, AJvYcCXptT5Umji3Ip6YnPn3KI44APAkEuBfvKXv1NHw7K+ilzsVU57fGKroMb/wH0blAW4UfnSWPmwKkLc7GD3Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6tjsPMGIax4sWTIup1ofsiA/1PgXpM9rYjiZWmV9paWUzCZA5
	ImLBjpfMgnT8XhLLsAp7Mm7AoTj4FwmuxwFIEbYbcqCI/apB+ORVK3Rr380pDx0xX3hUIBMbWQI
	Ox7Ux165VHDPSWs4zkHaP9/fSmgpCRNg=
X-Gm-Gg: ASbGncsCOmtdACNbfcZal+qJ74g7+iNrss48iYO8Vz2WeXZxndTeVVyZcAAHg/Z5JYY
	QHpRgPJmLmyK5jBVVsaZS4hQqfyg1wudZEOzMCLx2Fzj6hPe3wY0S72W4GVaq9wwkrML+oot+rH
	Y+okwBhOlxGZPq/QU0SkskGb4L0dk7XcZDgKPZY1NlpW48/oVc6SGODAUlpt2YsfccRqEuVmvnd
	IXQ6zNcQ2cy1yGe
X-Google-Smtp-Source: AGHT+IGEPG+g+OxH8rOfSaGvbFyeTmDB+1fQ7xPcfMGDOeGLeCcig+uAF9z9wcJ3Z5LOomVIJicrX6bQd17nnYWnOI4=
X-Received: by 2002:a05:651c:2155:b0:32a:604c:504e with SMTP id
 38308e7fff4ca-32e5f62cdfcmr641231fa.38.1751585041586; Thu, 03 Jul 2025
 16:24:01 -0700 (PDT)
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
In-Reply-To: <CAJ-ks9=WmuXLJ6KkMEOP2jTvM_YBJO10SNsq0DU2J+_d4jp7qw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 3 Jul 2025 19:23:25 -0400
X-Gm-Features: Ac12FXySgZtzHdWG_UZyVlFR27yExYl4PiFasz3P6nXfOoJ_ZKfjtj833w6aTPo
Message-ID: <CAJ-ks9kNiOgPO7FF3cAbaSNtTWs0_PzQ4k4W0AxjHNFuMJnDcQ@mail.gmail.com>
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

On Thu, Jul 3, 2025 at 6:41=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> On Thu, Jul 3, 2025 at 4:36=E2=80=AFPM Benno Lossin <lossin@kernel.org> w=
rote:
> >
> > On Thu Jul 3, 2025 at 8:55 PM CEST, Tamir Duberstein wrote:
> > > On Thu, Jul 3, 2025 at 11:08=E2=80=AFAM Benno Lossin <lossin@kernel.o=
rg> wrote:
> > >> On Thu Jul 3, 2025 at 3:55 PM CEST, Tamir Duberstein wrote:
> > >> > On Thu, Jul 3, 2025 at 5:32=E2=80=AFAM Benno Lossin <lossin@kernel=
.org> wrote:
> > >> >> On Tue Jul 1, 2025 at 6:49 PM CEST, Tamir Duberstein wrote:
> > >> >> > Introduce a `fmt!` macro which wraps all arguments in
> > >> >> > `kernel::fmt::Adapter` and a `kernel::fmt::Display` trait. This=
 enables
> > >> >> > formatting of foreign types (like `core::ffi::CStr`) that do no=
t
> > >> >> > implement `core::fmt::Display` due to concerns around lossy con=
versions which
> > >> >> > do not apply in the kernel.
> > >> >> >
> > >> >> > Replace all direct calls to `format_args!` with `fmt!`.
> > >> >> >
> > >> >> > Replace all implementations of `core::fmt::Display` with implem=
entations
> > >> >> > of `kernel::fmt::Display`.
> > >> >> >
> > >> >> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > >> >> > Link: https://rust-for-linux.zulipchat.com/#narrow/channel/2880=
89-General/topic/Custom.20formatting/with/516476467
> > >> >> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >> >> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > >> >> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > >> >> > ---
> > >> >> >  drivers/block/rnull.rs       |  2 +-
> > >> >> >  drivers/gpu/nova-core/gpu.rs |  4 +-
> > >> >> >  rust/kernel/block/mq.rs      |  2 +-
> > >> >> >  rust/kernel/device.rs        |  2 +-
> > >> >> >  rust/kernel/fmt.rs           | 89 ++++++++++++++++++++++++++++=
+++++++++++
> > >> >> >  rust/kernel/kunit.rs         |  6 +--
> > >> >> >  rust/kernel/lib.rs           |  1 +
> > >> >> >  rust/kernel/prelude.rs       |  3 +-
> > >> >> >  rust/kernel/print.rs         |  4 +-
> > >> >> >  rust/kernel/seq_file.rs      |  2 +-
> > >> >> >  rust/kernel/str.rs           | 22 ++++------
> > >> >> >  rust/macros/fmt.rs           | 99 ++++++++++++++++++++++++++++=
++++++++++++++++
> > >> >> >  rust/macros/lib.rs           | 19 +++++++++
> > >> >> >  rust/macros/quote.rs         |  7 ++++
> > >> >> >  scripts/rustdoc_test_gen.rs  |  2 +-
> > >> >> >  15 files changed, 236 insertions(+), 28 deletions(-)
> > >> >>
> > >> >> This would be a lot easier to review if he proc-macro and the cal=
l
> > >> >> replacement were different patches.
> > >> >>
> > >> >> Also the `kernel/fmt.rs` file should be a different commit.
> > >> >
> > >> > Can you help me understand why? The changes you ask to be separate=
d
> > >> > would all be in different files, so why would separate commits mak=
e it
> > >> > easier to review?
> > >>
> > >> It takes less time to go through the entire patch and give a RB. I c=
an
> > >> take smaller time chunks and don't have to get back into the entire
> > >> context of the patch when I don't have 30-60min available.
> > >
> > > Ah, I see what you mean. Yeah, the requirement to RB the entire patch
> > > does mean there's a benefit to smaller patches.
> > >
> > >> In this patch the biggest problem is the rename & addition of new
> > >> things, maybe just adding 200 lines in those files could be okay to =
go
> > >> together, see below for more.
> > >
> > > After implementing your suggestion of re-exporting things from
> > > `kernel::fmt` the diffstat is
> > >
> > > 26 files changed, 253 insertions(+), 51 deletions(-)
> > >
> > > so I guess I could do all the additions in one patch, but then
> > > *everything* else has to go in a single patch together because the
> > > formatting macros either want core::fmt::Display or
> > > kernel::fmt::Display; they can't work in a halfway state.
> >
> > I don't understand, can't you just do:
> >
> > * add `rust/kernel/fmt.rs`,
> > * add `rust/macros/fmt.rs`,
> > * change all occurrences of `core::fmt` to `kernel::fmt` and
> >   `format_args!` to `fmt!`.
>
> Yes, such a split could be done - I will do so in the next spin
>
>
> > The last one could be split by subsystem, no? Some subsystems might
> > interact and thus need simultaneous splitting, but there should be some
> > independent ones.
>
> Yes, it probably can. As you say, some subsystems might interact - the
> claimed benefit of doing this subsystem-by-subsystem split is that it
> avoids conflicts with ongoing work that will conflict with a large
> patch, but this is also the downside; if ongoing work changes the set
> of interactions between subsystems then a maintainer may find
> themselves unable to emit the log message they want (because one
> subsystem is using kernel::fmt while another is still on core::fmt).

I gave this a try. I ran into the problem that `format_args!` (and,
after this patch, `fmt!`) is at the center of `print_macro!`, which
itself underpins various other formatting macros. This means we'd have
to bifurcate the formatting infrastructure to support an incremental
migration. That's quite a bit of code, and likely quite a mess in the
resulting git history -- and that's setting aside the toil required to
figure out the correct combinations of subsystems that must migrate
together.

