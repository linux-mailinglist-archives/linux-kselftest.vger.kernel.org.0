Return-Path: <linux-kselftest+bounces-36603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91DAF9B34
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 21:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2590C6E08CD
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 19:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDCF223704;
	Fri,  4 Jul 2025 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAjRjh7j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEEC29A2;
	Fri,  4 Jul 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751657950; cv=none; b=YvITq0GhmxCmz2YjxRiqD8msv8gD2t0z8nQ8OH0Mrv31A9Cbm0sOmjOBkuGJxRGCnqfONhOIytgA20oOPdQecOZ8eKQtZSiDguEyg3rvPQpANpShOF7V+TfRt/KKhlBz6D5gLXFtzQtFvxynq2D4x3nEhEtZnes9ZxipAnbeLj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751657950; c=relaxed/simple;
	bh=q6BEyCDqiSgiBGBJ1ZkhyuwdBxeuGxHXg+GwZGubRJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dn+m5rqJZqyMcWYlzBMAzGQbbHi1qQ581TufEyw9ntmcbgmnfGuO365k3EzAE1YQQrh8kCg1Ub97XAZSkt0WG6xSrquPN+Y9S9pGj5odYpzx4c7NIG8FzUJskaAxumtVd4qR1q1hrdP5z/sxvaNk39qC+H5Ei536L86tW86SuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAjRjh7j; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32f1763673cso2316651fa.3;
        Fri, 04 Jul 2025 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751657947; x=1752262747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6BEyCDqiSgiBGBJ1ZkhyuwdBxeuGxHXg+GwZGubRJQ=;
        b=BAjRjh7jTxKEoLjNB7YkhK6JOHUiR4yOAnewAG1iTIdaTi/J7aeXGbYdIpZkCItNVk
         H9HulQ96lxlhUmUGfBTNQkK++CEQVjDthN88nM5KHpwLD//Ka1dq7m6ejfGpnQTbY5hN
         lDpx4Nrx2y3BO5jm9i7vRZoJ0QcQSn5dDEbbMkTnQZoihJM9TIASkPkxqYDG93e5qk1+
         cI3hHs6QIrhD0sOGLoJ/nbaRumY2qt3u09iAFvwRpnm0gN81h4xKTaTxfyyMk4hJxYcR
         qF/2L59gVc9Ne2ngC0B/TthIZU1VLfGtjfD3Vlp4FB/qS0nt9gfkGGETN8nVHlFcGZ6H
         lDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751657947; x=1752262747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6BEyCDqiSgiBGBJ1ZkhyuwdBxeuGxHXg+GwZGubRJQ=;
        b=IaqpVJohbnDCOnP88IHSYnX7ZTnJIoegh7XcbTji56aAmzDRpBj83vBr2TFLMPXFaq
         xMoTWGZ33DjOs6P9V/VVC1HMH9a9iwVNH/aWWXJ8UiWRaHrike0sv3SMyD/P582BT6dh
         cU27egH8PjguSYHGK0OWPWr7HcmuOJTWRty+in+n9jSquLg+PIWZGS6JXJFt7uwaRq4c
         zAkinS9Cv9ixQ22DovMgxBKgk4ZOs1r9MR49tKYJRHYgqBi6eDvbjVfWXoobbIf8kfXW
         kwkGF+r3Tb7e2LExYdTaGAJ2fO2Fpd01oMSp5dslHYDX05f4nFwZmGJzTUbhpnmt3rXW
         JudA==
X-Forwarded-Encrypted: i=1; AJvYcCUFX1yQR5Gy0D2vn8A7oX6GPP/ZoJLtWQV0Mkc6YB6Qy4sjVo8m97bXaxdIJPmtUvecgDlp39vbeegZh+Y9@vger.kernel.org, AJvYcCUeun0WHfxLTRgwCCEuuermHz3kaZhIuFmnWOrbJS/B+E9o7fnTMzdhf8odKrxFdF/a6dSTugt+3Osh@vger.kernel.org, AJvYcCV67WaFXOfXlINeCDqsuFEUVZZ3QDQfv/cc27sn8aynfwnRCkQjDb3rOaFeu4djB4p8gHsAfpurGto=@vger.kernel.org, AJvYcCVL6qUMiKwANjyZkOGDFsKbUoV5+pShAOss0mMEctxin84QBcDvjf9zzyp92NUYghk5tQPa+qMKYrqSPgmFj5g=@vger.kernel.org, AJvYcCVm3oi71RWSx2vCpaLghA+H1GakJpWU+SK+PVOdonfc2GiBGIEhPRXGBxIbnURvda7M/34+W208sL82DEGCY9uy@vger.kernel.org, AJvYcCVxIz8+T7b83BBbcpsbmZdhfOviJlazOdGwi6NpHGzug2DA/rGbCHRGh1DSW29J960nETNaf+fD@vger.kernel.org, AJvYcCW+zRlnvQ0fNPAntXP9d2kky5PrpL3PAFSuK1UXt4yNDgxK8l3h8HscIygSVDfbgiCK85xMyjlLH1RK@vger.kernel.org, AJvYcCX1GyUdSv8EZZNODwoO1/xHNsY1MsuF6BAF92INiQj1UdNqo4d0KOL7S5GJbi+psf7+vnHFtbF/xrhT@vger.kernel.org, AJvYcCXRaVdLRaeSHf9Q3/fHevNInNdg2tQbyhoICcpJxGGx/DCjZBlVSdNzCK+CTS31y5vwyIkbU0ZQ+n6fsmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgN0mLzyn2NkpQ4+Pt0B675Nz1DQ6556IRcojifBSe5JEYv9EJ
	xz8NKtMcpiavc2oU9nPcXOImUl2TiNSsujBmOpSrh/6GKJBRu3ukeu5CBNWrLQ47vhAr2RDOrOa
	WtXmjRNKDhwI2d3xt5Xo+HgEQXszKUAg=
X-Gm-Gg: ASbGncu2fW9300SCJo0yssn3RRZvzhqjJsEuCHLVSiAXpvMwoyNDyTz7QrP8keGDCVL
	7koAubqo+hZlzTnTX6h8ssvITInLEZ1dgrt2N95haaliYNt21Xe61IYPhbxUS6J0GtfG+ZNsPC+
	4RbiEytX288bFgYtKB0h7dahX77mdEcXF486CeeymBauO7j+6j0g9vpoO8KQg9iSgThO8Yvzs92
	9S5Hw==
X-Google-Smtp-Source: AGHT+IELI7uW8JvZwN3QEoftXB7GsVNoqVv/ET67tZt2kJkg2u9kQKOlY5/6R0W6vFvmdwe3YBxK7+LcpnDSocUkLi4=
X-Received: by 2002:a2e:a554:0:b0:32b:43a3:68a1 with SMTP id
 38308e7fff4ca-32efb0afa55mr11642311fa.0.1751657946651; Fri, 04 Jul 2025
 12:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-4-29f7d3eb97a6@gmail.com> <DB3AGL1QO4M4.2HANWHX9TF9WN@kernel.org>
In-Reply-To: <DB3AGL1QO4M4.2HANWHX9TF9WN@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 4 Jul 2025 15:38:30 -0400
X-Gm-Features: Ac12FXwvxhLPYgvBPM4F9xT26zkuHTZMocL5-5BvcjZhSL1NesztAaUplyK7LaY
Message-ID: <CAJ-ks9kcW8PzUWPmwo-WQ1dJTgoXTvY6G8UppsLKehf9O0bUqQ@mail.gmail.com>
Subject: Re: [PATCH v13 4/5] rust: replace `kernel::c_str!` with C-Strings
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

On Fri, Jul 4, 2025 at 9:01=E2=80=AFAM Benno Lossin <lossin@kernel.org> wro=
te:
>
> On Tue Jul 1, 2025 at 6:49 PM CEST, Tamir Duberstein wrote:
> > C-String literals were added in Rust 1.77. Replace instances of
> > `kernel::c_str!` with C-String literals where possible and rename
> > `kernel::c_str!` to `str_to_cstr!` to clarify its intended use.
>
> These two things can also be split? And it should also be possible to do
> this by-subsystem, right?

Yes.

