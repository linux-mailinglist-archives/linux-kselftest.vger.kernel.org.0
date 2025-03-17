Return-Path: <linux-kselftest+bounces-29268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66719A65C18
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 19:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5651880D7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43081DE884;
	Mon, 17 Mar 2025 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RG1fUOwi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E21DD886;
	Mon, 17 Mar 2025 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235082; cv=none; b=QbtOg7kPmTobbinHnzGdemMFPqCtz3FxrewQECGufNUIdP779JfVX2GIzQ/mbwa7nmA18zkX9EWIkl29TX7RyuZPWxEyUUYo8szeoiDoO5bo4Z2bJZqtgi2KbDHm7MgtiHbwzn0QAyjeMefDCoUcbBlJ1AHCQHhN4ghNDzf2/uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235082; c=relaxed/simple;
	bh=FlV8GTz8vxzgkH9g3wvpaKjxo0EK+kIU4f5eXY3efqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6QWAnzg2vp7GI9Knfs4oidIJZKykIMcl5TmjYGALEzEMJlYEpt9GyYRCp2Gm7wK9Qn9bHAy0U4lS80iUvsTOVjjXwTLLfVhcFdPvKGUf9lvvGXILIeweorUVEtZpJKQDdnC5s9OcjKa7op7MXXY513Vd7uMNw0OxT+LB2bvzNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RG1fUOwi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so48446441fa.1;
        Mon, 17 Mar 2025 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742235079; x=1742839879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rb8+eyAgzLQAE8bM9Iy4XdXMFk9ncU/0Rs95mwF+mj8=;
        b=RG1fUOwi+D9geY+0knlJ0zY5UUh15jDFrmsE8QvkC+jrK52hicwCgVQsb1oUUSmpIp
         BolFxP2amuwqGXY5cYHP6wUnfar4Pppy5aluLVKx/c3r9f8Y0bt0BMoeQqaGXVSl88G8
         vgi++dujIQafqrpI3MmFTJIZ9TlSYIUlTVYKgjTTPABRNpSLdhVv+jkZW89d9pFOvwU0
         PfiDBxs+mexu1qtWDs6u0Irqfr336cHl++d1t6VDbWX4sjDZz4yMQ6jSU8kPx+J31fkn
         IeaFsjPlAqkyhiIIcTld9kfWcdydiL0iSrPgZUc76Kb2yZ8u/T2zKsGyQtoE1PNcLc51
         kWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235079; x=1742839879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rb8+eyAgzLQAE8bM9Iy4XdXMFk9ncU/0Rs95mwF+mj8=;
        b=oERiWn04giv8NICJPvdTi3fnNovyD/FqeTlv8UvP/+ONdYw9ls/GQ8MvNfp/4+aSg6
         CDZpfk6Mgyfzj0aOMSCq6JH/kPoxUDXSzGc6G3lsmhvaVF4F47AxYJToVF8M6I8Y1RDh
         xxmEMdtmb0WVi3f5GgWGTbmgitwKNJn6aPfv7UW9+M0MizegFPFRFfkQ1fPsfXrXOWic
         AiEbBiXwbm9saFw4A2Gdm0zAytuuB/BPmbV8MIQ5YO48GwKZrk+xhXt3ttuV8KdCumBH
         khwi9aB8cnwePI+4/WfX4I81yqtzE2kmvSG0mX+1IqAIYmZKQFmgQqA0b/HbMeBPC/Eu
         yMiA==
X-Forwarded-Encrypted: i=1; AJvYcCVAICw/HVcf+jzIFn3ofBaCFQVUKkHGYj2W38fmytDM++vAcYiISmeuYlon2pjr2vuRLT2nBy72fGDC@vger.kernel.org, AJvYcCVdsZ430NizkIfkj7Hsn2ahuwewqeg+ItcUGaUPNAtN0SJcWHFwAFgTCAr5aw5G3LUy+jDecRsy3WyUcJbW@vger.kernel.org, AJvYcCVdsaUakeUeTtLt+nvSQuxDaBFo98ef5sr+efamEm7qEOH0k3FCdT+w+fN0VETUwiHozWag2kkljIbtmrMXkJiN@vger.kernel.org, AJvYcCWLHKAt2UrJW38qLuTWafwoSJvaTukZJ1hVTH5RdAzN8Rgz5Fc3RKVAiZJrbmqtN/o3idTO7Tlplgrk@vger.kernel.org, AJvYcCWSFemEM3efuDrMRcHnPaqnzv5k0g8UcVXanQYDr6VgSR5sYRtHbJ6CpZVwwIMFb8c8CblnTS08+TGUAog=@vger.kernel.org, AJvYcCXczDuKqKIXtJCWS4p88c4s7RCah5FJj9E9UJ6qq5Mk30Cu1VhTYGWt8tb4/JGYCQ6UR+k2zUgwDktp+mMZmug=@vger.kernel.org, AJvYcCXfAgKyYeUfxJYtMAcoVvzFeKZr93g/4tylqf2qpyr8oEYI6CiHlr0ljNbxu8rIzabpLgoUxuEIgpJerhY6@vger.kernel.org
X-Gm-Message-State: AOJu0YzddfIYFY/w1TCipEMucsnVzimvG50qWoni3fiemKKgjuHmsULu
	wHz6vdLhxv6mGPlSgAntIsjeiN38bXtnbOUbjMAy2ISa5uATLGigubViKUkP3zO2qD6QXLUutBg
	oi1gt39faW+OpB1nzy3g9dWEeLw0=
X-Gm-Gg: ASbGncvNSE9wbkhB2VPOMBO2ISXWV2PY0C7dkYdCQzM00ASaCYkvmHSfinqjk+O6fwc
	mPnz+/z38+7wD54W6Z0J3EJ8W2ObmLpLNDZiBPdDzJpzZtplySfTt84eh4pNWiCsTRIamVgCw/m
	eXVAHgdwHPHLOSAgA03lrmdzb94f6jtPwBmZEy6WX2wbtuhZc7s2b7iNcaNw0y
X-Google-Smtp-Source: AGHT+IGpP0ohgpoLLX4wnMigWtVSaNHfpcEYl5lvMo5+mf+UcUC88CWyp0CNf63a2tkeP/U4Wu5h21jr5IVGNqVJnqU=
X-Received: by 2002:a2e:7206:0:b0:30b:bf4e:f6fa with SMTP id
 38308e7fff4ca-30c4a876cc0mr71605361fa.17.1742235078753; Mon, 17 Mar 2025
 11:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com> <67d85e51.050a0220.2a36b.58b3@mx.google.com>
 <CAJ-ks9kBp8zPfaQuZRb0Unms1b13hDb5cRypceO8TWFR0Ty5Ww@mail.gmail.com> <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com>
In-Reply-To: <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 14:10:42 -0400
X-Gm-Features: AQ5f1JodK9r-JZXswWhJuAUaQijd1jSqPZRObGDjvQ0nJ2dEMwHMGd0xIeRMt4A
Message-ID: <CAJ-ks9n8mwt5q9unqfkfSHj9=ELJHtqsXM-xQ8jsbXeJX6Uyfg@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 2:06=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Mar 17, 2025 at 02:04:34PM -0400, Tamir Duberstein wrote:
> > On Mon, Mar 17, 2025 at 1:39=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Mon, Mar 17, 2025 at 10:23:56AM -0400, Tamir Duberstein wrote:
> > > [...]
> > > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > > index fc6835cc36a3..c1b274c04a0f 100644
> > > > --- a/rust/kernel/lib.rs
> > > > +++ b/rust/kernel/lib.rs
> > > > @@ -17,6 +17,11 @@
> > > >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(coerce_u=
nsized))]
> > > >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(dispatch=
_from_dyn))]
> > > >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(unsize))=
]
> > > > +#![cfg_attr(
> > > > +    CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE,
> > > > +    feature(strict_provenance_lints),
> > > > +    deny(fuzzy_provenance_casts, lossy_provenance_casts)
> > > > +)]
> > > >  #![feature(inline_const)]
> > > >  #![feature(lint_reasons)]
> > > >  // Stable in Rust 1.83
> > > > @@ -25,6 +30,109 @@
> > > >  #![feature(const_ptr_write)]
> > > >  #![feature(const_refs_to_cell)]
> > > >
> > > > +#[cfg(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE)]
> > > > +#[allow(clippy::incompatible_msrv)]
> > > > +mod strict_provenance {
> > > > +    /// Gets the "address" portion of the pointer.
> > > > +    ///
> > > > +    /// See https://doc.rust-lang.org/stable/core/primitive.pointe=
r.html#method.addr.
> > > > +    #[inline]
> > > > +    pub fn addr<T>(ptr: *const T) -> usize {
> > > > +        ptr.addr()
> > > > +    }
> > > > +
> > >
> > > For addr(), I would just enable feature(strict_provenance) if
> > > CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE=3Dn, because that feature i=
s
> > > available for 1.78. Plus we may need with_addr() or map_addr() in the
> > > future.
> >
> > We still need these stubs to avoid `clippy::incompatible_msrv`, and
> > we'll need those until MSRV is above 1.84.
> >
>
> Hmm.. why? Clippy cannot work with unstable features?

Yes, `clippy::incompatible_msrv` doesn't pay attention to enabled
unstable features.

