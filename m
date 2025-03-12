Return-Path: <linux-kselftest+bounces-28871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529B8A5E755
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 23:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B75B7A50FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 22:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1111E5714;
	Wed, 12 Mar 2025 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDbJAAe1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1219E96D;
	Wed, 12 Mar 2025 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818329; cv=none; b=XwTFqlLzfd6raBAaZqu1oohwJRNjpok6HTptAQYaxwQs6aiykyXVvw7mbejoreG/0AkQMxMGUE3ijh4HuA95wn+00Q7L0PcOXFIAqbt+aKortnhNE71yVvjI31L+E1KLG3zLzCGdLHl5syfpruulOB3YdxkQSg59aw9YJq+TkMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818329; c=relaxed/simple;
	bh=VXAHyoi6S/bte6WaCD/Pn5Ote/xnR2EBUMQ/zji8uZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMt1cuM0r69V48l1ofAtFoAdxBhrsh9UWPUZTbqPdJRxtM0EN9zNm6Q4qy7Iit4v/NNsI2A1HH+Ll4nkvsIR7nNH6Xb41osTAZvbB10715p3Ao6GfKfg5e5hWIEHwoX8Sfti828SbMDilf30Q9qoaWD40zFF21uK8EIGn4SbSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDbJAAe1; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so3672191fa.2;
        Wed, 12 Mar 2025 15:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741818325; x=1742423125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQpIKnFqQqjnZqrWUgK5hmSZufspTpLTGHs2PYXqx+A=;
        b=FDbJAAe1V8P31C6+Cb2eoC2aljsxNHsCQEezO/155K2uUla9org+AbbK8vTw30ysGt
         UGXSHmu4C8MBQBFD8S2lHvfoaoHcirqPnua4tD9b1bquu4q8CTkEz2uW4/A3RnLjRf8P
         lE+2la9n/y94lhiQHAilEwTkD7OMIctNixk35o8PdgDM75VkyuGMM+3xwvdvMHwZ0ptv
         vJDB31L+eM1E4VUQNmUHd4aZmU1O+ChpJpofOmNN8tazohLIAVuSkD374i1RZCop4I2l
         W5GKeujmJcna0i6wYLzizSrNbt9eiyO2ErZLEuPjmqMnrMX9oeK6n9tRy8QcF/tfTK3j
         OtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741818325; x=1742423125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQpIKnFqQqjnZqrWUgK5hmSZufspTpLTGHs2PYXqx+A=;
        b=d/gZAszQhliEEk8OpockAdxgEmDT8HbQ8DExpZMFbePlyHMzfmyFzvsfjByN5bxhmc
         Fs16xzYuVNtYBBNfR+HRzf1UpQrtcMP3WTMokddV05bpC8M+Vm3U04/oPnMZP0b53E/+
         KR9cJeKMIJQl0gEbbAWokrAi8VrZO/aQI0ECFklsquTYtZQzMjLdyE9LOIqY2+aTM8g3
         h2HBDqtDERAPOmCPTsR1WGTlzfaQ0Ab8LSAm4dK4TFV/3HGhilxKYfseWmCEt3CKCbCx
         e0WBI46qyJoqOiWFu4JJz197bhezFI02oeSl0r0y7hKqjqksUgnFttW+0lKxI2P0bcWG
         FSEA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Tna6cEVTRlGmOzOrR9/oIQCNM6edoldKS9TZQThvSYmaNyAF1vlmolhCm1hVQVtktBKO8tKKwaR8@vger.kernel.org, AJvYcCV4RIW7k5Xm0DIcK6YrBU7aAaFYXEeOqKphoes15iFFIu4fKn+Rzt8TEPEK/3OcJ6YcNl/p0as4UwjG@vger.kernel.org, AJvYcCVjdxCWSkTSgzRUnmJVkn67MxvlWo6f0yGgg6tO2FzcxOVFVYqeWdRLD9DqrZgyj7FkVlzqy/O2Bp+eSSXA@vger.kernel.org, AJvYcCVtDbS3DGvFTYR1Zz+UArbG2jXH1dezgd1xNNb9VD7A0znDfkPJ0U+iw7DilIHHfVRTGUKWu27Enr5UU1Y=@vger.kernel.org, AJvYcCW+OvXYOWXERNgnMAS4tB0qbjgPYOxCTaeLfMf50OOE1ReBRkIIFqqEkM9md17z6XTT9SfednIZVZR22v19Yq/s@vger.kernel.org, AJvYcCWcgrmaX2P/L/14kPM5rn8eHsViaRB5GXM8CnV7go6RZH/XdDoATqAchlnPzAk4oEoe6ooXduLZ2KTu9Fb7@vger.kernel.org, AJvYcCXdqCmRhc3lZybjtYCQxJ4yE/M7f4VISYOZVC392avc7DrTGr1u7ADQK2nF24VvYen97sWPM3G20I9Ef868psE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2olGBkxolvZk6CM9/9j7TN713ciS7p+vM/fa1jYfpgyusiMKv
	w6mtixBQMmLlf5590FwuHeXevBkdef9abfe9ar5GGIT85MiGH0zlp422QOpvMFWemA0sakSVM5r
	wWnHe1BWEbxT34YdvbCdmZ4ohL68=
X-Gm-Gg: ASbGncvfDWaCJ4V2YeBh4bs7Xir90E1z1ZVRN3un+E/EfgimQhPwh7FXbr+Pr7wblRK
	NvR3ldJpSyRWKSFSHX7Zk9yfds7XmafYpWZBtWMPFxMj2beQg6AS31f8ddpVfUurN2ze8CQjJ6k
	jy3VbOHKKp2l4cxNPjHE8k90tj4PoRxZ/Ur84/AlifXg==
X-Google-Smtp-Source: AGHT+IGKQgI9mHdQYDXn8YP8O+oMMjkLyXMRIC+V9diumKcyagJmgjCx2MUOMGSE+cXBt7MpiP4TDI26sRzoA7NpJk4=
X-Received: by 2002:a05:651c:2209:b0:30b:c8b1:dd95 with SMTP id
 38308e7fff4ca-30c2069a33fmr34989931fa.22.1741818325120; Wed, 12 Mar 2025
 15:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
 <D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me> <CAJ-ks9=zWAuPUM_61EA6i5QkUpwtNtsN8oF_MUerWGn39MRHhw@mail.gmail.com>
 <D8EJM4CJ4HAN.1PB2YV8DB77V7@proton.me> <CAJ-ks9mo-H46Wwcu_LOvDy0ncwMR9ii74Fyf3OX-aWNnrZ397g@mail.gmail.com>
 <CAJ-ks9kCgATKDE2qAuO3XpQfjVO2jGyq3D4sbUcVKyW6G1vuuQ@mail.gmail.com>
 <D8EL9QFS1XNT.JBSMRXD4D7GT@proton.me> <CAJ-ks9=TRDg3g=NG7k97P_5jXpZ4K4v0DxrmJFR+uF0-3zJkXw@mail.gmail.com>
 <CAJ-ks9=hAwOGtVv0zh9CcH7XOxjGnizvK1QOMAi8nKStocKr2Q@mail.gmail.com> <D8ELW7X9796K.2ZGJS34LDTHOP@proton.me>
In-Reply-To: <D8ELW7X9796K.2ZGJS34LDTHOP@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 12 Mar 2025 18:24:48 -0400
X-Gm-Features: AQ5f1JrV0I808OxKHRnh7f5P8lP8791ez-Nxt_VvKYEi31EaPmsz0HYFkpYMAbo
Message-ID: <CAJ-ks9k1gZ=tLSe6OjuKFgg6=QE5R_Ajo0ZJwZJp08_1LMiODw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
To: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 5:30=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Wed Mar 12, 2025 at 10:10 PM CET, Tamir Duberstein wrote:
> > On Wed, Mar 12, 2025 at 5:04=E2=80=AFPM Tamir Duberstein <tamird@gmail.=
com> wrote:
> >>
> >> On Wed, Mar 12, 2025 at 5:01=E2=80=AFPM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
> >> > Always enable the features, we have `allow(stable_features)` for thi=
s
> >> > reason (then you don't have to do this dance with checking if it's
> >> > already stable or not :)
> >>
> >> It's not so simple. In rustc < 1.84.0 the lints *and* the strict
> >> provenance APIs are behind `feature(strict_provenance)`. In rustc >=3D
> >> 1.84.0 the lints are behind `feature(strict_provenance_lints)`. So you
> >> need to read the config to learn that you need to enable
> >> `feature(strict_provenance_lints)`.
>
> I see... And `strict_provenance_lints` doesn't exist in <1.84? That's a
> bit of a bummer...
>
> But I guess we could have this config option (in `init/Kconfig`):
>
>     config RUSTC_HAS_STRICT_PROVENANCE
>             def_bool RUSTC_VERSION >=3D 108400
>
> and then do this in `lib.rs`:
>
>     #![cfg_attr(CONFIG_RUSTC_HAS_STRICT_PROVENANCE, feature(strict_proven=
ance_lints))]

Yep! That's exactly what I did, but as I mentioned up-thread, the
result is that we only cover the `kernel` crate.

>
> > Actually this isn't even the only problem. It seems that
> > `-Astable_features` doesn't affect features enabled on the command
> > line at all:
> >
> > error[E0725]: the feature `strict_provenance` is not in the list of
> > allowed features
> >  --> <crate attribute>:1:9
> >   |
> > 1 | feature(strict_provenance)
> >   |         ^^^^^^^^^^^^^^^^^
>
> That's because you need to append the feature to `rust_allowed_features`
> in `scripts/Makefile.build` (AFAIK).

Thanks, that's a helpful pointer, and it solves some problems but not
all. The root Makefile contains this bit:

> KBUILD_HOSTRUSTFLAGS :=3D $(rust_common_flags) -O -Cstrip=3Ddebuginfo \
> -Zallow-features=3D $(HOSTRUSTFLAGS)

which means we can't use the provenance lints against these host
targets (including e.g. `rustdoc_test_gen`). We can't remove this
-Zallow-features=3D either because then core fails to compile.

I'm at the point where I think I need more involved help. Want to take
a look at my attempt? It's here:
https://github.com/tamird/linux/tree/b4/ptr-as-ptr.

Thanks!
Tamir

