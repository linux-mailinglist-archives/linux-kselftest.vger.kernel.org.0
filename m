Return-Path: <linux-kselftest+bounces-29267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867B8A65BE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 19:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAE63B46DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C289E1B4227;
	Mon, 17 Mar 2025 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPnSwcYI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212CA47;
	Mon, 17 Mar 2025 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234805; cv=none; b=clH7bdTnRGolwnB2vMoM/sOVvryQosNce73SO40Oy0rVxdm9VyQ0gmLAQZi+eZH9H6/PZqqIc0PsDhdOiRMmL+nobgc0RS8enasMvprqzDlljvstLlGvRhLBZSNhdsnzBQlPPxkzXnzC5GgFNip8o2qXSe4IYvnfXlPXE5dKjlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234805; c=relaxed/simple;
	bh=DncVUtVQlQzg6arT7ft00lfPJKOTmpA3REaCtwPYQdA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smpr2Tz7JnZ2v2oCV0+jmIIROAJ8l6dIjB8UuuvyGmxqo/YvNSHbaLIBtN5tldazCeyBzQ17DpvFpduXNFBaZSX/V8Wof7mqMU3ngCU/lIdUg66KqLb9hKbF0czekDW6zKGR9MigLlAOfiqj/xmWyfL354WICV28/F73H9Ljo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPnSwcYI; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e86b92d3b0so41391816d6.2;
        Mon, 17 Mar 2025 11:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742234803; x=1742839603; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I5GVWwgv9Am/z+q8ZZcKwL4ApxzwHrcBEQXJPU3wffQ=;
        b=iPnSwcYINZ2V/fqc8ZX4f9/7NOq1UMO6Sldso+jmcbyT/Xv3JQH6AXzTFudM9d7Hgc
         1BQYWmyVumTugOHviTzv2JsvPPE+uV2PYnn2fNDUS6vWC8QW0hDxWciBI5QXB4wLVZA/
         UYs8+08v7zkD3QCYrafg7m/vChDnpap+HIKsi6sLNRGvd7acAdPnD3Xjr7Y9qsDfab3F
         Nrk8KV9qu0JHSRekktIcSXwV8kepfreL43svsNxY7BTX+5Lj1upRR0+I2KDACOLHb8Dz
         Q/Ne1QvNwWfHkrgXvoV1D9NAA6cf6T5F0aBtWv4SOfKTmn+00ZdffomWalgIHDuk9ddN
         MxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742234803; x=1742839603;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5GVWwgv9Am/z+q8ZZcKwL4ApxzwHrcBEQXJPU3wffQ=;
        b=uIdxL4K2Eenj74vfiAuYB73tVjNRf937eQB1fQeSE04JIyI09qwgaQUcuvrCGaL8UV
         nxXaLc54YdO3yAIzYmvqx/uksYvXJ+yYiqrZNxr5wPJ5+7IroAFyn/fl9OIJJ2nam4a0
         zuyYa3quBoSl3GmE5LArQ1tff3vPcgvW2L1M7/2r3zI+p+mI+KfGPeQkUMgxm2+ydCEJ
         HBE1GNA8qQohm+w9fiTvSWCX8L69Zl6RMCpTQw7C147DwdqZkBWg8OWhQXuyOik9Cw/6
         oCrqszoLDOO3cCOhH6JeAk16NLbHSlutDsER1+kJ2m1Ln9+fWeVqAgCBGQN8ARHqAvqv
         7ecA==
X-Forwarded-Encrypted: i=1; AJvYcCUDv4AK4lfofAM7oe+Ri1OFMNbEaanKehawkgq8JQHz5BZYhFLQP6l7ceA3VschNc4Ht2k02q+sX++u0gvuqAyW@vger.kernel.org, AJvYcCVDlOsMLOWnwWaXXBGWAhw/gahBbAGeE7YKQzscMlriF4ff3ZcwBkZiqm0f5QftlLw4LVSwGDh7uYqfJcc=@vger.kernel.org, AJvYcCW3Hgp92DcGfdkHpNd/wvxi7FGlOeVkLZVugSsglt2IQzfK8/GJ7k2M6d/oOr2i0c7Vk4p8bkeuPTtsWwug@vger.kernel.org, AJvYcCWE6RnHqDL1fORpYO3b8F1aKBXASmonq+qoc7q2Frqx2XkZfXvQJiaMdgiuRcc2ldt8JL3filwGnXkm@vger.kernel.org, AJvYcCWtVdOfUrK2qNrgA+nzFve7WxU6U50dbGJFvQir74/0iqX11CrFMt36s6Oa1lYZajsQV2Dl8it0dzyq2UwHajg=@vger.kernel.org, AJvYcCXmWYPd29KJ/ZVCRzJ+FTuRYQoOKxepODzUAOiEmjuG4BedzYNQGywfoJ41O1H9ME2wabJxoh458HGw@vger.kernel.org, AJvYcCXsQxa32Ot2dIDMa9UxthgQPCsd6tZujbl6SrTocYYqvd08nWXVudpOKz07R17J5UWbP8pQjXEJ5bGrECSc@vger.kernel.org
X-Gm-Message-State: AOJu0YzrLv+NaWfdMtMfzUQs8KOCbo5aF4XOBvT2WBtAW+8DWy3COss+
	/nzkcRhDckeecVOlitfuIQ94UxcNMHHZmf78Ph/PTMkzQ1rxjJXN
X-Gm-Gg: ASbGncusxvVl0tn4v9Zs3iqeKpwXwSk7dxxDeMbptxn2MCss07JbKD6Uzaqx6zfCw09
	cHMgeo36viuFgYFynu4S7pxzMmARSu6Eb0R+LJUVI5zLaPT+g+Du9uHnp1enHbQZDJvlgUX8Jbe
	12kRdv26Wjwnz4OB+CV8soaamALye/7gemTbXcdYW9B78As5JO7Rb8bek5E0XrfVu4VoDvjpsBX
	vr68VQTAoKSwJO0mQmXpbhygF5Cqqnlui+gESUpGFjrnqtYkybaCQwJSE88KdNtk6wgFXkBN50A
	bJ7ngmbHJ9VpZfeCl99RfdBLATKD/98uVpPLxlUzDK0y5VWJqWgyai9i2nIBExzDmIqLnZI9bVZ
	gV3tyTFGHB9NTDvwXKddQqxitNTTEfS9evaI=
X-Google-Smtp-Source: AGHT+IFGmJqNXJT08o6OuOGFp+PPKCptxVOAoemJXV69JqRDfPXGEiTZwKbWhjKikA46wscmR9ossA==
X-Received: by 2002:a05:6214:e6d:b0:6e6:5e15:d94f with SMTP id 6a1803df08f44-6eaeaa8e068mr189657056d6.27.1742234802738;
        Mon, 17 Mar 2025 11:06:42 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade330de1sm57167776d6.74.2025.03.17.11.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:06:42 -0700 (PDT)
Message-ID: <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com>
X-Google-Original-Message-ID: <Z9hkr9QVo4e1sXGS@winterfell.>
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8E1EC1200043;
	Mon, 17 Mar 2025 14:06:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 17 Mar 2025 14:06:41 -0400
X-ME-Sender: <xms:sWTYZ61fjIMv2yJdV3negYmNMIXgPWvB813WBz0cN6IUGGj_AfOH_w>
    <xme:sWTYZ9FGLKLHkp6WetUW5tLksSgT_ay0MKm5Hk5zUDgUilayKL1g1-2yKvALT3Ln4
    HtXlTQEId-OhxHbsg>
X-ME-Received: <xmr:sWTYZy5FhlLB2-1WEdDKVETS9QJFYadNJhvpixmHJnD69AJJSTzizCYa_p4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepieehfeekgfdvfeetjeejudekhfeiveel
    feefveehheeffffhkefhteevffevhffgnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    sghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtie
    egqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhi
    gihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrshgr
    hhhirhhohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrthhhrghnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehnihgtohhlrghssehfjhgrshhlvgdrvghupdhrtghp
    thhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrg
    ihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdr
    nhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
    dprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvg
X-ME-Proxy: <xmx:sWTYZ700nrQ9a41smnLTdIM1716THWopumBvhBlMr5LK9RPdZ_9mnQ>
    <xmx:sWTYZ9EGPssG1Ocqw2WpNJQeAWn8as6gEdqzG3jKGsGj9ZjtRyYLtw>
    <xmx:sWTYZ09JG0skmH8q7Dbv4WFAdlzMvClSqqKZ0SxIyobt8PoXZhzhvw>
    <xmx:sWTYZynC7AdzcrAoGdlJO5JauQgMJZgzL97SFZFlhonfarA78-_MkQ>
    <xmx:sWTYZ1FOvKqZPC-CLbv34VvNN1yy1u6ecnRFyVrvVJQTCldv9jGFf28P>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 14:06:40 -0400 (EDT)
Date: Mon, 17 Mar 2025 11:06:39 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,	linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org,	rust-for-linux@vger.kernel.org,
 linux-kselftest@vger.kernel.org,	kunit-dev@googlegroups.com,
 linux-pci@vger.kernel.org,	linux-block@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com>
 <67d85e51.050a0220.2a36b.58b3@mx.google.com>
 <CAJ-ks9kBp8zPfaQuZRb0Unms1b13hDb5cRypceO8TWFR0Ty5Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kBp8zPfaQuZRb0Unms1b13hDb5cRypceO8TWFR0Ty5Ww@mail.gmail.com>

On Mon, Mar 17, 2025 at 02:04:34PM -0400, Tamir Duberstein wrote:
> On Mon, Mar 17, 2025 at 1:39 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Mar 17, 2025 at 10:23:56AM -0400, Tamir Duberstein wrote:
> > [...]
> > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > index fc6835cc36a3..c1b274c04a0f 100644
> > > --- a/rust/kernel/lib.rs
> > > +++ b/rust/kernel/lib.rs
> > > @@ -17,6 +17,11 @@
> > >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(coerce_unsized))]
> > >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(dispatch_from_dyn))]
> > >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(unsize))]
> > > +#![cfg_attr(
> > > +    CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE,
> > > +    feature(strict_provenance_lints),
> > > +    deny(fuzzy_provenance_casts, lossy_provenance_casts)
> > > +)]
> > >  #![feature(inline_const)]
> > >  #![feature(lint_reasons)]
> > >  // Stable in Rust 1.83
> > > @@ -25,6 +30,109 @@
> > >  #![feature(const_ptr_write)]
> > >  #![feature(const_refs_to_cell)]
> > >
> > > +#[cfg(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE)]
> > > +#[allow(clippy::incompatible_msrv)]
> > > +mod strict_provenance {
> > > +    /// Gets the "address" portion of the pointer.
> > > +    ///
> > > +    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html#method.addr.
> > > +    #[inline]
> > > +    pub fn addr<T>(ptr: *const T) -> usize {
> > > +        ptr.addr()
> > > +    }
> > > +
> >
> > For addr(), I would just enable feature(strict_provenance) if
> > CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE=n, because that feature is
> > available for 1.78. Plus we may need with_addr() or map_addr() in the
> > future.
> 
> We still need these stubs to avoid `clippy::incompatible_msrv`, and
> we'll need those until MSRV is above 1.84.
> 

Hmm.. why? Clippy cannot work with unstable features?

Regards,
Boqun

> >
> > It saves the cost of maintaining our own *addr() and removing it when
> > we bump to a strict_provenance stablized version as minimal verision in
> > the future. Thoughts?
> >
> 
> I can do this by making this particular stub unconditional. I'll do that.

