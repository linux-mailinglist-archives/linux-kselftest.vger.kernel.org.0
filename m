Return-Path: <linux-kselftest+bounces-29271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEB9A65CA1
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 19:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E94168A01
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A2E1B3956;
	Mon, 17 Mar 2025 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDTqqigD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A809315573A;
	Mon, 17 Mar 2025 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236317; cv=none; b=Ovd0ayEePdbQcs499D9l13SxhQ3XOqm4RZeaWNIomplb1EH+vzhP2teMB/fU6pzW7LLcxreZI1u2MO09jnwJSguY4BdggTyplEWYHrmNX+C71Ulnk/Nai6CUXXJe/bTOtm9sYfxvuqZWR9kK9oW/FF8SaiO+1p+sqEHUgDqnDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236317; c=relaxed/simple;
	bh=GUdlu9CBP5F5dI2Y8Ye2ckdBW8ifZqJH0P0YqQpuV6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoFpgyZIlZw56VoZkAY6vzOezdiCokTM0ylouFqBEk7gGnttOpF/rx8Ez5avGnebEG3FE6S5G0sx3npuJ6BL8uLXvJ3M/TmNVb1y2jbwhA5tXxnejlyr0AGWMTCrvoD0Qom3qtuIm/+7a0nNL2z0RWlotjaLGnXO+TmvMT9F7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDTqqigD; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso53864641fa.3;
        Mon, 17 Mar 2025 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742236314; x=1742841114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNP/SipY9rGfX3yqYI9bcBc8SEPT09LFO6ib/YoE8Mc=;
        b=gDTqqigDDP8hyq0sQiw4yb/r5QmOvsEtsSqWjW6ikIrOPz0r2LWbigZfaYOzqam+zT
         D/vHruoWHIRhuL+sZ0klddFfIMrOkBR8+OFRZ4EjIZZHZEWlqUYpnV8ynhScU8GF0PeG
         Rm1DHV+4Sn6NacJwR7mrJsP6Q+2F+mt0V90+UctJEz5oK1tr3kyYLs/MyZGY0ETfttyj
         ZxKmwgEp02Z0YxniMd/0rtjnsi6iGGxepOzKHjCykrQgmX3hGOflqrjLfD8BoVJ2aVrI
         pFFKAmBnlSJlsy9Z79g2t7BDR8m5YAjbMVF/IcAiFClRVvFEsdRHXI7bGBWWeea+XDdc
         sKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742236314; x=1742841114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNP/SipY9rGfX3yqYI9bcBc8SEPT09LFO6ib/YoE8Mc=;
        b=AXDU30QBmyjZlDLha053XRGJq5v6axXjb2lbl2ZheP+xROr6JfdRMzWMOD7FhUCMs/
         HFKk5KWtn8rIsuT7D28J8GTPwGnCVk+5eZlDBkzD8kpvRaWpPg3VQnxuJvrS/EKuW9m9
         xKg9o0NTajr1IVoWKtAl+Hnmu4mKrOt3x7oEk69FLJEIO9bMdwljy43zmbGpooH5mlQZ
         rj8Aq/RJXzHFmdrdavsr3Ezqr01HtCyLzz0cqbDXo3sy4KJHYU4UmDn7Y59QpK358+rm
         CsKT+Ge4/UVpbszjduUx2toLukbWQU5wntMsCsey/92yEK/zDK3IXhGeN40C9DsBRQT1
         jt5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEz+W9uZ2Pro1Zi9TAI+YZzoADr1+8tYLkO1Hrs+EXv9SeQI/IP3qNhzQt5wAjZTHpUBaKbSI3av0Jpybl6PA=@vger.kernel.org, AJvYcCUY+yWQ9ORywIMM4cD2lrdO9BNJ5LnUFaeWYxPAFmDoynmX25ZoVuW9bJWbApO+cVQfuBtMmnRRRUzlr2gF@vger.kernel.org, AJvYcCV3avjrcLj9XvUR4D3n+11ncqaLXs7guTw4o0jrsqVW2efe68JZ10RL1dq8dUQWaeDgs77ejj+msmsP@vger.kernel.org, AJvYcCVF2l6JtbTtllDjZHLl9xwhVfpTFPJckd85CMIyAGR4NIuR2AlRjkgdJiWuIS7MZs/ZGR9RbRhrpcy0@vger.kernel.org, AJvYcCVlt5KA05OzVybKBK7ilnqFpwKWvWiQUUGqsuFTd2KmxUwwvigysY+CxZssKX3NEWolZ/7KK160KR6VTAc=@vger.kernel.org, AJvYcCX+5be8lYOGokyQ1cP62i7w6oEW4PevxQ9im0nA0wuUucehdx9UFnkvgiFB0JxWLZBbeiIlKZGOOOxjENireDnj@vger.kernel.org, AJvYcCXc3It0x0d4jzQf9/Ej1qW/roDnYPjUXifyG7PaysvD5QlxlBGGWSAGdUblGnUd6BpWFXaN9XNNNRdVsvee@vger.kernel.org
X-Gm-Message-State: AOJu0YzGqnyaSW6T9sMxNoA7h/91VR68YNIZyy0/8PhujwSCsCsYmE/A
	ExjZ+HBD1BepTDpbDA1tWBU7/LuLRo5B4OudaMr3pcp6fQI6aOlv7VUVfPpHv5s/ma/0qzxLwAR
	4Rm4Ntju736ieP/An+14zKOUyumxHFMk22iKwEg==
X-Gm-Gg: ASbGncuWJglzZ/SfP5Qc+jYZpjFbSO1O0ZmB4ibQoUGTO+BFWYrqQUhzWSY/LerI9nU
	dRiHraWLlWbeXPkrPlmKnoyaXZkHeemH3alwN3hqW9oloLWQXNig29EGSimqbvy06FBX8Lr6Ap0
	jMEGJ8zjb7FmD2QtdPHLItewSqeIOHTSEgPWKEiV1cwWuGK9qHKEGqX1Bader+
X-Google-Smtp-Source: AGHT+IEZvVPmFY03wZUVY/ylW/q1BAu23Bh0J53NdaLLp76SOniWjZtzsJ0TyVYBwZ7GjS+TdC448tm/USrojMxl29k=
X-Received: by 2002:a2e:be06:0:b0:30c:1fc4:418e with SMTP id
 38308e7fff4ca-30c4a8d225bmr90356151fa.26.1742236313542; Mon, 17 Mar 2025
 11:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com> <D8IQCJHJWPNJ.1J2UO4OK0D0B3@proton.me>
In-Reply-To: <D8IQCJHJWPNJ.1J2UO4OK0D0B3@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 14:31:16 -0400
X-Gm-Features: AQ5f1Jri1KT9n-llBAsDBvGxTN7gIuyMaWJX8rvKMwx-KwPH-TLKot_wyhCkGgs
Message-ID: <CAJ-ks9=cBEZqPHMWsh7-c16LTg+i+RmDFigwy81o9yOj2J+jFA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
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

On Mon, Mar 17, 2025 at 1:50=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Mon Mar 17, 2025 at 3:23 PM CET, Tamir Duberstein wrote:
> > Throughout the tree, use the strict provenance APIs stabilized in Rust
> > 1.84.0[1]. Retain backwards-compatibility by introducing forwarding
> > functions at the `kernel` crate root along with polyfills for rustc <
> > 1.84.0.
> >
> > Use `#[allow(clippy::incompatible_msrv)]` to avoid warnings on rustc <
> > 1.84.0 as our MSRV is 1.78.0.
> >
> > In the `kernel` crate, enable the strict provenance lints on rustc >=3D
> > 1.84.0; do this in `lib.rs` rather than `Makefile` to avoid introducing
> > compiler flags that are dependent on the rustc version in use.
> >
> > Link: https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html#strict-pro=
venance-apis [1]
> > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > Link: https://lore.kernel.org/all/D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me/
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> One comment below, with that fixed:
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>
> > ---
> >  init/Kconfig           |   3 ++
> >  rust/kernel/alloc.rs   |   2 +-
> >  rust/kernel/devres.rs  |   4 +-
> >  rust/kernel/io.rs      |  14 +++----
> >  rust/kernel/lib.rs     | 108 +++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  rust/kernel/of.rs      |   2 +-
> >  rust/kernel/pci.rs     |   4 +-
> >  rust/kernel/str.rs     |  16 +++-----
> >  rust/kernel/uaccess.rs |  12 ++++--
> >  9 files changed, 138 insertions(+), 27 deletions(-)
>
>
> > +#[cfg(not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE))]
> > +mod strict_provenance {
> > +    /// Gets the "address" portion of the pointer.
> > +    ///
> > +    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.ht=
ml#method.addr.
> > +    #[inline]
> > +    pub fn addr<T>(ptr: *const T) -> usize {
> > +        // This is core's implementation from
> > +        // https://github.com/rust-lang/rust/commit/4291332175d12e79e6=
061cdc3f5dccac2e28b969 through
> > +        // https://github.com/rust-lang/rust/blob/1.84.0/library/core/=
src/ptr/const_ptr.rs#L172
> > +        // which is the first version that satisfies `CONFIG_RUSTC_HAS=
_STABLE_STRICT_PROVENANCE`.
> > +        #[allow(clippy::undocumented_unsafe_blocks)]
> > +        unsafe {
> > +            #[allow(clippy::transmutes_expressible_as_ptr_casts)]
> > +            core::mem::transmute(ptr.cast::<()>())
> > +        }
>
> I think we should just use `ptr as usize` here instead. It's going away
> at some point and it will only affect optimizations (I don't even know
> if they exist at the moment) of old versions.

Why get cute? I'd rather defer to the standard library.

