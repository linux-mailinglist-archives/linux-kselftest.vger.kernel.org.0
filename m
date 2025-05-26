Return-Path: <linux-kselftest+bounces-33821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14850AC452E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 00:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA070175745
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 22:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBBB24166E;
	Mon, 26 May 2025 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gM9wGPRW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EC184D13;
	Mon, 26 May 2025 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748298331; cv=none; b=KX5v0/UuZi+0lcR6bWkCsP5VTAhNiDE7D9az97RmFWK27nONW6cE+MDkKEu91PxftwQxc4K9p8+1oA/rONLOEl/VuD43cALL2fmGaysGw4BdFti3+VGTuJ4E7vyFNdlscTwaYEbunSuKTXlZgqFT9xeSGSA0PSeV1FucTQCkVFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748298331; c=relaxed/simple;
	bh=521R875tW8UiEALWHaEvdiVj6S1u+v1teNklmrhzE/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0n3iZF52jVB09TVMM5ru9lYc0FtWaiceu1TIC6+RvyNhoOWPbRa+DYTJdcJirassZ7Hcxk5OxkcsoVcC4y4Jq+lU3Q4f1EsdfhlgAIviR1KL730LZ7hM3ewRmwRnWJHvrOND9siwdY8xFX2GDaX6keeb+RKRx6Fs7zt6bV+w60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gM9wGPRW; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-551efcb745eso3319897e87.2;
        Mon, 26 May 2025 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748298328; x=1748903128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaenIVV6sgmeMP/e9IFhljAikGtRfCzZk1k/VfHMXwI=;
        b=gM9wGPRWvmgoa9duFnTqxDAUyMpyjvigpCvEasYJ5fdpSRxY5vKSM/g+Dvbl7ISSt6
         ZHzcZp+C16S+46ims8SkVYuLYn45XlNKrDxv0uIgZDqGTPLDktNKIM1C5MdX09h394j2
         vXElXn+98cvKHJ0Re0DaaGeKMCnux4q/G2eUG0noRTLln6/sLZsYegkkPyyu+ZyDX0p7
         EmIq1JzvRgmo3FLEScTnogAQWfG9doX/gC2LTm5qsWeh4fk0AlWn5zKCTIaVx8QIx5Z/
         nxP3QQFytZZRTs9j+F8I7o0qu3KnD/qUxDFzqbNk2fEHNAJPhZQml1e/xRvDj1kPEypM
         otog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748298328; x=1748903128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaenIVV6sgmeMP/e9IFhljAikGtRfCzZk1k/VfHMXwI=;
        b=EM6zZt94nftMRU9UEwXZMiCdvieMrWe2W8vGMeXODcKEhu9yxK9XlhnqzYBUFuCRw4
         yN+0/h8H8nnyi18fJ+PbnFB28ibz2gxdozaMNNzKdwsMFJpmnZMduP0vZnQhzVHb/rZr
         D/AqX3p0wu2oDJDH8cX4QWC82pq1U8ioKDqF+ghnNG4Q4bIF3Uxy6lRmDKN9BHAlW11m
         8y2+ljxc9IjoentxgCTfONI6aFrZ2Mgbgn0Z0+dkSPAVconpnZj+hqmV25NqozPZnAFA
         zaqHzLjuvVUwV/pAZ+cLa32u2DBJSQGJu2LufXvNcmtS2E8ZEbRfO0us2O4FChnjj3hi
         pAJg==
X-Forwarded-Encrypted: i=1; AJvYcCU27KcN+Vw9JLGECEgrUiuKon94YIBLKXPTqkCybAApj5gPv9Ga8Kl1aHSm/SUNHQWXNgAEzPiz@vger.kernel.org, AJvYcCUPCtnO6hHbbI9RsLYtEI4z2o4tbs9XSJapToNn03bgHTxpRbNX9gPy2KO5MVkGiCDl5svmzd2I1INK1Kg=@vger.kernel.org, AJvYcCUpXTGtw6c4JPtxYTEUMIrXn5X8cH56BG0QlPILM9uB6m1nFrzw6oXXR2BY8AxpwWa9k2giCxr5OzjN@vger.kernel.org, AJvYcCV6mkknpt11RURITmW7ucbqOXqzpcIry+DKEb998NDTSjjsKNzZtbUFzsADCPk/UaGJyCwAtQlXPBC7gXJL9sg=@vger.kernel.org, AJvYcCVWFe8qr2jo6h+4qxfUamaHaZCyit25wOw3PKED7eiplC9uhQx04AUdAuI3/Q4SiczBxK+GOB11JVNwW7xHqGe7@vger.kernel.org, AJvYcCVyDH7tt5kYv+kWV57yXh8Tv8+EjFOAsbi5FSqIokmjICKJ95jZmgOw1izLIIeR9ahz9lGWFDUItLWM@vger.kernel.org, AJvYcCXIv9Qj1gxriR9+laLdMM4Y0GuRULvj45sfk0BqY4J+rTNDXo2gfZyo5x5PuCYLSKUmUQDMNlkq3uEJiVJ9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8axnyGMfGy7qfPwXD+HtS48VwGQZzrs0KUzIcXTDLfuZ8P7Y0
	NyTAyI7NRSZA/MuiYkUJfEslF01cPyVOUzkLIQfVFoyN/ss3kQNtGl0jzRo22e/queAWJCSgFO+
	5YYe1zmCGpX2po2hMoG1aeZpfo6ayNKg=
X-Gm-Gg: ASbGnct/e3zyEZoTJNcULGJWCrGH5PBk6epeHwl0nKpugBh12vDtKe+gp1I030L2snC
	jbXYZJIfvuAo6JSpQcGHYVRj7F+CA17SiJV66463gYPtg2wEkzrS5UPRR8gvJDe+yntlB0m31jl
	q8/d0LZGszgeHWLWp2k6IWwQ9CAzTgv19HvWlnXLjRZXSw00OujG0Y9dKgABn/TTJojyhPRbD6+
	cu5pg==
X-Google-Smtp-Source: AGHT+IHcv7V2oazwv060W33dscTDl7PPQ1f7noMTAF+hm0IKskzHzh7MX/ZbURWbHci8ZixnjxyyZuMa+2GYUXijkPI=
X-Received: by 2002:a05:651c:1603:b0:30c:719:1145 with SMTP id
 38308e7fff4ca-3295b9f1d37mr26288281fa.17.1748298327492; Mon, 26 May 2025
 15:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-3-6412a94d9d75@gmail.com> <DA66HHUA8ANF.BI2FH7POFSRJ@kernel.org>
In-Reply-To: <DA66HHUA8ANF.BI2FH7POFSRJ@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 26 May 2025 18:24:51 -0400
X-Gm-Features: AX0GCFv_2H01vKjFOD3wQrlp_6f3fi8nlSDpIGif86GknHm_bqABvjuTuytW9u0
Message-ID: <CAJ-ks9kmDiOV_qH_s-r4Z4iQf2k6H7ZnqOf5okaQxWWxrj5Deg@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] rust: replace `CStr` with `core::ffi::CStr`
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

On Mon, May 26, 2025 at 10:56=E2=80=AFAM Benno Lossin <lossin@kernel.org> w=
rote:
>
> On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
> > `std::ffi::CStr` was moved to `core::ffi::CStr` in Rust 1.64. Replace
> > `kernel::str::CStr` with `core::ffi::CStr` now that we can.
>
> What's this supposed to mean?

It means that kernel::str::CStr was introduced before core::ffi:CStr
was available. I didn't check this before, but it is indeed true - see
https://github.com/Rust-for-Linux/linux/commit/faa3cbcca03d0dec8f8e43f1d8d5=
c0860d98a23f.

>
> > C-String literals were added in Rust 1.77. Opportunistically replace
> > instances of `kernel::c_str!` with C-String literals where other code
> > changes were already necessary; the rest will be done in a later commit=
.
>
> Similarly this, the message should explain the motivation for the
> change, the change itself and can include additional information.

The motivation is implied (that using standard types is preferable to
having custom ones; this is also implicit rather than explicit in
https://github.com/Rust-for-Linux/linux/issues/1075), but I can
sharpen it.


>
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_panic_qr.rs |   2 +-
> >  rust/kernel/device.rs           |   4 +-
> >  rust/kernel/error.rs            |   4 +-
> >  rust/kernel/firmware.rs         |  11 +-
> >  rust/kernel/kunit.rs            |   6 +-
> >  rust/kernel/miscdevice.rs       |   2 +-
> >  rust/kernel/net/phy.rs          |   2 +-
> >  rust/kernel/of.rs               |   2 +-
> >  rust/kernel/prelude.rs          |   5 +-
> >  rust/kernel/seq_file.rs         |   4 +-
> >  rust/kernel/str.rs              | 358 +++++++++-----------------------=
--------
> >  rust/kernel/sync/condvar.rs     |   2 +-
> >  rust/kernel/sync/lock.rs        |   2 +-
> >  rust/kernel/sync/lock/global.rs |   2 +-
> >  14 files changed, 112 insertions(+), 294 deletions(-)
>
> I'm a bit confused by some of the diffs here, they seem pretty messy,
> any chance that they can be improved?

I'm open to suggestions. I think the confusion arises from git trying
to keep code from moving; fundamentally much of the change is moving
methods to an extension trait, which means git has to choose between
keeping the documentation where it is, or keeping the implementation
where it is. If I use `--patience` then everything moves together, but
then the diffstat swells. Thoughts?

