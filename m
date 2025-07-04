Return-Path: <linux-kselftest+bounces-36514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E970AF8C5A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 10:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0197C16F61A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 08:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528ED289E1B;
	Fri,  4 Jul 2025 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bzeq9P50"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF422877F6;
	Fri,  4 Jul 2025 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618459; cv=none; b=RBAUJl3svz6cNDxWHQ1UnkyQelNSstprG61XKduS/L3pDD4qV73oQG9zRSiZWDKsOnVFtl2L+VRSAn9IyAA5OoEf9gYnGUjFzwMuY3Gu4ZkNnB07br3zGkrdrxXx+BlQi5DjNui0Jhh0wD254KCiAokiJIl7FRnbuclDsK94xjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618459; c=relaxed/simple;
	bh=pMXtGRROxYPlLPH4DHRGNMDWd5KHAZVN6SCVZ3OapRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiPan4aDiXnC1JMj6vB8OFug2du3/P6h+eUpegUV2BJHkPd/qjQkhTgq8IGGNegnlsjjI87/ts5NjCHQPON1sBzL4nGfFC/QX9dsCSo9T0WIgOkBStKTDBf5s8Zr9wpYkllZd5X0wvL8Ij/SGfAwY9wybMr0B4aSDVtdOeAA89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bzeq9P50; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234ae2bf851so1167885ad.1;
        Fri, 04 Jul 2025 01:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751618456; x=1752223256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHSEKYsU05H6zm689vQoHx3pYIDxa35XkhfzWTQQ1co=;
        b=Bzeq9P50kol2ZeLr6FIr9eK3alv5iuod5raycUWSg6VlQHOpVZCnmt464cL5O0eUbM
         aITpLB2HRDEPXf1BOg+lkdiegrSvvi1MH+OMrPgxF7yY8eayaXFa1FDeYxNlx9RldYYr
         9qINIempwG+/I21P62sSi666k9u+j5jDR/K1jgbuHTJ8HpPYb41A6pAQRYMDmu2tL56q
         H15VndfwCiyRwXld+HwPfgAcYxDCXO7K086+NDhQo98OUPoCXrGxK6g9wmgD3+iv47Hv
         QfKJrsU2dHYdd0yr3azRH1OEdRisx69E8sAcXm4rbjVzBIzPAhUUymS+AKlESsty3aZs
         qUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751618456; x=1752223256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHSEKYsU05H6zm689vQoHx3pYIDxa35XkhfzWTQQ1co=;
        b=m6SHLv2te55bJDD2svThCxYTAbiWwzXJpGLDXM30LYPtWDQHdWpJviArf8OgMOxM50
         OX0uPS952mIoqwCOfUHdkD9wyXUEO1G6SArbi/ouxHsJ2NuKEmcUf0EZgcrj5eBLBher
         H20B8u0eiNf0jMDR/CKw1mHE/M+d+Q3iyJpOY5WCVoofh2AqPfAesuK2ge5MccSgd45c
         k7Ih9dqJAwLThpSEv9TW9iNJDBtIZc7NpBQX2kPQtBN9D9PaeST0+PLypGGLOljnminE
         f1/y5cVQ3YZco7m9iqms/Wmhv66x7VCz/vFIxnvVjmX1Za7Zl6uUMwnGfs/qj/U5VqVq
         X2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU3cCOZmUVuhG1fyHAcyGmi73KgJTB3445+D2vobUrp0ycO/EEpAo6gxlaEC4ZpzN1zUkN0bGG/Gmjn@vger.kernel.org, AJvYcCUAMwb3VWMCUAiexM3KKUr9cGxigbyri7C9z3Xq/thq6WXhz9EHcp/gTFsYTZzYpN0DrInrU1U54He8YHs=@vger.kernel.org, AJvYcCUW//ZZEMYHK9OljczbHJ2dCrPpY8rch1f2aVsCHsuDg/RVYN6sTxMvAjPgQaaV8VtFuD2kFCm5BItD@vger.kernel.org, AJvYcCV4CIaFouKsa/iNSlBD+6dAXIoJIBghGYya71AJYtAxQWoS+0WdoeT3/totlWGcFAJICRIOWA7Y6FNeBzeceyI=@vger.kernel.org, AJvYcCVESNr/NymRCfNdEBfBcqc+6gWtjRvYc+w1+nBnqN2iNkvSZGoiaMRMKaFfO/NXIbBnOk2SlyuhMMA=@vger.kernel.org, AJvYcCWDzDmr0AJAWhfT2dt6DpqIaSvaNbpyFeWEzmrk4wqldFukrxB46lyCxWVcLzPlg33/dUW/AxvPVNEcpycp@vger.kernel.org, AJvYcCWRb6q1DCxqxueFaQXDGZt0BWP6bfgJn6zRSMSsIjzniGDyVcCmUQ/qOLCUkLph0mRXFKLocwZh6c5FsVDbNWv8@vger.kernel.org, AJvYcCX/9hq8OaS4xAlL8LDugjNIjVPWCDGIEjopWKLJhUFg8W8n9G3kEK6n7EU84k3FPHRJICYP1e93KUmr@vger.kernel.org, AJvYcCXB5DrWLhl/FGz56m6717kgCDzuVn0dhELU0zuXws1sMstJ6t17mgjjUhGAUkse13EUs++OY12W@vger.kernel.org
X-Gm-Message-State: AOJu0Yx796ck+apW87+Uji9q2JYCzen2qRUKajt/2JF4bV0fJfC8inU/
	jvamyOYa3c3tMHBsGXDU9p4nqPEjPqEACuXlm59LzWNv54YgYM7EDMDFwfBs41zi0RPMX/bLPal
	Rc+uLEJKm5Jl+jd0owBLLsEIMVALyeo0=
X-Gm-Gg: ASbGncsbqEeJXO+BFa7iMzxLPc/K8fQH3yCZnpLBhz3YuOh9wkfcpT6mdLsbxfHrDp+
	x9dPVlgqHee9pFeCQzYYts2mbw7e3gswfd9wnHJ4y45lH0aamnJYRR9aKnIdiliFgbIN+DPpq62
	rM/Wiq1Aq/ShI6df2W5PgLutXL/j/W6koDc1Vda9TqVN4=
X-Google-Smtp-Source: AGHT+IFMfEXuJ43kSXsdtdWY5bcekIDLYN3gAjscsQDNZrtLRLqrsSS7+psigrvCXRqkKZzl+hRlwyHYKmZ9GwWepBk=
X-Received: by 2002:a17:90b:1dcc:b0:311:c1da:3858 with SMTP id
 98e67ed59e1d1-31aaca78c4dmr1037960a91.0.1751618456422; Fri, 04 Jul 2025
 01:40:56 -0700 (PDT)
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
 <34c00dfa-8302-45ee-8d80-58b97a08e52e@lunn.ch> <CANiq72ksOG10vc36UDdBytsM-LT7PdgjcZ9B0dkqSETH6a0ezA@mail.gmail.com>
 <CAJ-ks9mkC3ncTeTiJo54p2nAgoBgTKdRsAwEEwZE2CtwbAS7BA@mail.gmail.com>
In-Reply-To: <CAJ-ks9mkC3ncTeTiJo54p2nAgoBgTKdRsAwEEwZE2CtwbAS7BA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 4 Jul 2025 10:40:43 +0200
X-Gm-Features: Ac12FXwGbZyrddKNNViyoD8x6yBVbP3kVI8pI2AlPxz0BjAZk4Lec5cu34XzXTU
Message-ID: <CANiq72kta=Wk=3764A5SzxB6Mq=sJfm9DyMZXFC91ojUSj1TeQ@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] rust: support formatting of foreign types
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Benno Lossin <lossin@kernel.org>, 
	Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
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
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
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

On Fri, Jul 4, 2025 at 12:46=E2=80=AFAM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> There's also a tactical question about splitting by subsystem: are
> there any tools that would assist in doing this, or is it a matter of
> manually consulting MAINTAINERS to figure out file groupings?

As Andrew mentioned, you can use that script, though I recommend not
fully/blindly trusting it.

Sometimes you will want to adjust things, e.g. sometimes things may be
related even if in a couple different `MAINTAINERS` entries, or you
may want to adjust the flags the script provides to filter, or you may
want to check `git log --no-merges` to see who is recently applying
patches related to that area, etc.

It is essentially the same process as when you send patches.

For instance, taking the diffstat above, and ignoring contents (i.e.
assuming all lines could just be freely split and without considering
other splits discussed to make the patches smaller first and reducing
the flag day changes), I could have done something like this:

    drivers/block/rnull.rs       |  2 +-
    rust/kernel/block/mq.rs      |  2 +-

    drivers/gpu/nova-core/gpu.rs |  4 +-

    rust/kernel/device.rs        |  2 +-

    rust/kernel/kunit.rs         |  6 +--

    rust/kernel/seq_file.rs      |  2 +-

    rust/kernel/fmt.rs           | 89 +++++++++++++++++++++++++++++++++++++=
++
    rust/kernel/lib.rs           |  1 +
    rust/kernel/prelude.rs       |  3 +-
    rust/kernel/print.rs         |  4 +-
    rust/kernel/str.rs           | 22 ++++------
    rust/macros/fmt.rs           | 99
++++++++++++++++++++++++++++++++++++++++++++
    rust/macros/lib.rs           | 19 +++++++++
    rust/macros/quote.rs         |  7 ++++
    scripts/rustdoc_test_gen.rs  |  2 +-

And then those long lines may hint that it may make sense to split the
smaller tweaks in the last group into their own patch, so that it
mirrors what is done for the other smaller groups. Thus possibly
leaving the feature being added into its own patch, which would be the
biggest and the one that would take some discussion. And the others
would be the small ones that are easy to Acked-by or Reviewed-by or
simply take (if independently possible) by other maintainers.

And so on -- again, this is speaking generally, and it is just a dummy
example, not intended to say anything about the current patch. And
sometimes things may not make sense to split too far, and it can be
more annoying than it is worth for everyone involved, e.g. when we are
talking about trivial conversions that could take 50+ patches that
could be automated instead and then applied by a single maintainer.

So it is a balance.

Cheers,
Miguel

