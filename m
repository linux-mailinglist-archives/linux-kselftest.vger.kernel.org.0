Return-Path: <linux-kselftest+bounces-36604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6194AAF9B3B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 21:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C2F188FC48
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 19:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952CF1F03D5;
	Fri,  4 Jul 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9UO33Ch"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F6F1DE4DC;
	Fri,  4 Jul 2025 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751657973; cv=none; b=pF3dCC/1IBrfPjXQ7MWrsStrquO41pEvy0lULOvHuOavYrXC6hnkupNLImQWJbiYl3/Q/FW/r1sMg4xEK+NWB7L/UZgoZuo5sNCZAWQKkZZOzfQZ3TEJAofM7yDRuVHNrHD7X6k86yJ3epQiwKuFFR3Gtn4uVVtsZDK4ZMB5btk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751657973; c=relaxed/simple;
	bh=ty9V8JMAdvvmDv0P0k4PGgC/jV1j8pI2d1WXBXRtpJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZ/IV4rgiavEdPXn/WiOxNcdii4rhQAQRTOnUeG51Pmce/PiJNm8a2f8Tc1ILrQF+Qg37bWBgiP9N7VmS1O17fl7HlnOKvdQeShHGTstME/zZhayJNROYQo65NC6FlR3+8x6xpxLo4fWFiUSZgrCQcTRxoAsgdWEwhr7m7Ph64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9UO33Ch; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32f1763673cso2319421fa.3;
        Fri, 04 Jul 2025 12:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751657969; x=1752262769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaN1iXlsiktU/ZIaAdJUYYtsPKiTgtwWPQpDE5mPO2Y=;
        b=I9UO33Ch8Q9mrOD/M7pYrNP/6yXwnGYuiISlMxIx+fEgmO7W7xKxBWu7VE7BMhNeVz
         B5VDHSNZ0a4SOXmult/S2ys6kOcY5rtYGnarXdjmrKCdIegLMN0dFgr96dmfJyIoclPv
         VzKZ+qxH6H/Rn7XQvOJ0spguCYfsH6/87wnDHywwc1IKBh8VMFlPhPjxZjr1Taz9Icp1
         O+qVNi/gO4mE6s0WggvOcnmjrzo1UJH9tYlwvqwEGf5+DqJOX18EEfs+bC8Q8MftxS9A
         lNoKLhbAn72+T7w47bXi+ymPlA5QrFMNoo1a1i3sLaPpUZLIjzhBDrrdv23BVAcJMweQ
         bp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751657969; x=1752262769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaN1iXlsiktU/ZIaAdJUYYtsPKiTgtwWPQpDE5mPO2Y=;
        b=qTAByDLsFTL5NJ+cgfyLtSRfQo1qqF+UkUPANt/aycwHPGnwbVsnonZqr32K4BJiXn
         Q0aAvyEGFIY6hLkRRa33PMIeXZSiBvdUXjoPSu2k990VZkUEzFXfqPQUHu9NYJAblUG2
         mGbv7Qq0gn1gwoW6y+/OMUW2tv2y5gM94WFWhjJKc351wTgq5ps2MiiXfQHY2lK8nTqK
         /JGOY+MYIDjWxP+3Lzn3N3v+Irx+BI2YO06U8qkYX9mzimAWGH9pffSWS5OJ04Upbhhs
         WxbkAJJZzixP+qv8b6Ly5rlr0Uv50TlqRC21VP4DPbJJlrXCjcOTWDAIq++FU1x1JcDr
         yJtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5bE6gYhBjtGijKZvpSP1iwBGuBpiQUIgB6x4PJES8xlC7qE5eu9rw/oI7/62+seyG4h1A9302nGXk2cykGxpn@vger.kernel.org, AJvYcCUH+S1fFbCXyJIcUE2m0Sw+ZqNlxjqGVqZzLCLzpKCH4AlxHT5nLGkg8QpCyXrNmfD0Qt2wNq300m2SpVxOFzs=@vger.kernel.org, AJvYcCUtq7h4qLLJy3OVh9VMg54/leVmm//v1hh9TZ0ubEcR7yp5bY7kHdGk6rq/uU/7goVAart/Wc/SqN4=@vger.kernel.org, AJvYcCUuFc2YE+0eazNbwlNd+IF0kqr1pvK7SmvyBikZDHrROy2/r6YsVcUFuNf3g8r3anS52XVC3GSY1uEmmvMe@vger.kernel.org, AJvYcCWXYlyFJPoY3pBbVB+1gio1tzfiSPEAT5XLiaHkYobZM0vgc+LSnorvyPRVxm0ZC5kyvMmMteTMPCyl@vger.kernel.org, AJvYcCWsFQoldrMHxuaS7QYxNIkzPi0sDNsG/fOrinWYaYh8mU+Y2vMmjtALRYYWD1YQGrdDUR/Sp4HXVCPM@vger.kernel.org, AJvYcCWxI4E0lc9vhXcYhgMvOpDHc1+rP6YRR4dPMFoKcOQ+WvagZXaXuLRCa4E1wQvxjTYDImIzbrhO2Lpz@vger.kernel.org, AJvYcCX7W5ocIKModOBVt5zie92WusYsn+u+PaitpMlcsAhtBlH+eEfzbYf0DWkgjKb3gQPXpJQQ7CW/@vger.kernel.org, AJvYcCXbnBEJEoyS5AUyxlWnxTPGTNghA2zsrfxjVAcwxxEZQgn08S4YwmwvTsez+T8qjkzVDagg4hbsQCq+osM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYk0xN29p7aRys9tiPnFLhnZMPtKzM8lg22NNojhzUdstDfiGY
	EKKXDm7j31NRcxjUS+8Xug0NSdCE7xynQTVRv5yzzXh3Ajbk6d0WIIz978/40qHXVzxr2QlxEbk
	2ei273M1We1fHE3+1BOWSu+0HbHHGw8M=
X-Gm-Gg: ASbGncvlYShZkkURrkUg43I1M1XWZTlTiQ5ygjIqM5Feus3x/wo+J6M3OycGwtvxBCB
	LYrPwATqM1K80/vAecVzgdBtAoBtqccUJbipLBelwksYf6n4mX7H+lJ8I/1DpoNxDJowLKqfBno
	ffazwGFf3Z6yDgDc6QEZO6zH02D6Kjf2lDbCbmsbCFup+iPEC/heekMxX1RESQRzWWEJOrqCRM6
	tdv9g==
X-Google-Smtp-Source: AGHT+IEUCasNpOjrLiPTdba+G1DzRMt5tyZu55jlQh+AX9oNhtSkPC1M27OuhbpRgJbummxXICHmkFV1J91gViP7ObU=
X-Received: by 2002:a2e:b88f:0:b0:32a:6c63:92a with SMTP id
 38308e7fff4ca-32f03639f57mr13413521fa.22.1751657968994; Fri, 04 Jul 2025
 12:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-3-29f7d3eb97a6@gmail.com> <DB3AFTUC22W1.39C4DMWSENZGB@kernel.org>
In-Reply-To: <DB3AFTUC22W1.39C4DMWSENZGB@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 4 Jul 2025 15:38:53 -0400
X-Gm-Features: Ac12FXzIFREDgXqCwrv6XJgEObqPEvHKICa5en-HTCiFL74MHyUAIu3tq-_u52g
Message-ID: <CAJ-ks9=Q2+zmBzq36aYnePmRm2b5NL3buMXP36FpmnJ+UU3FWQ@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] rust: replace `CStr` with `core::ffi::CStr`
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

On Fri, Jul 4, 2025 at 9:00=E2=80=AFAM Benno Lossin <lossin@kernel.org> wro=
te:
>
> On Tue Jul 1, 2025 at 6:49 PM CEST, Tamir Duberstein wrote:
> > `kernel::ffi::CStr` was introduced in commit d126d2380131 ("rust: str:
> > add `CStr` type") in November 2022 as an upstreaming of earlier work
> > that was done in May 2021[0]. That earlier work, having predated the
> > inclusion of `CStr` in `core`, largely duplicated the implementation of
> > `std::ffi::CStr`.
> >
> > `std::ffi::CStr` was moved to `core::ffi::CStr` in Rust 1.64 in
> > September 2022. Hence replace `kernel::str::CStr` with `core::ffi::CStr=
`
> > to reduce our custom code footprint, and retain needed custom
> > functionality through an extension trait.
> >
> > C-String literals were added in Rust 1.77, while our MSRV is 1.78. Thus
> > opportunistically replace instances of `kernel::c_str!` with C-String
> > literals where other code changes were already necessary or where
> > existing code triggered clippy lints; the rest will be done in a later
> > commit.
> >
> > Link: https://github.com/Rust-for-Linux/linux/commit/faa3cbcca03d0dec8f=
8e43f1d8d5c0860d98a23f [0]
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_panic_qr.rs |   2 +-
> >  rust/kernel/auxiliary.rs        |   4 +-
> >  rust/kernel/configfs.rs         |   4 +-
> >  rust/kernel/cpufreq.rs          |   2 +-
> >  rust/kernel/device.rs           |   4 +-
> >  rust/kernel/drm/device.rs       |   4 +-
> >  rust/kernel/error.rs            |   4 +-
> >  rust/kernel/firmware.rs         |  11 +-
> >  rust/kernel/kunit.rs            |   6 +-
> >  rust/kernel/miscdevice.rs       |   2 +-
> >  rust/kernel/net/phy.rs          |   2 +-
> >  rust/kernel/of.rs               |   2 +-
> >  rust/kernel/prelude.rs          |   5 +-
> >  rust/kernel/seq_file.rs         |   4 +-
> >  rust/kernel/str.rs              | 394 +++++++++++---------------------=
--------
> >  rust/kernel/sync/condvar.rs     |   2 +-
> >  rust/kernel/sync/lock.rs        |   2 +-
> >  rust/kernel/sync/lock/global.rs |   2 +-
> >  samples/rust/rust_configfs.rs   |   2 +-
> >  19 files changed, 140 insertions(+), 318 deletions(-)
>
> Is it also possible to split this? First rename the existing functions
> on our CStr to match upstream & then you don't need to do the rename &
> removal of our CStr in the same patch?

Yes.

