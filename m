Return-Path: <linux-kselftest+bounces-29284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0315FA66372
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E403B7595
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD3E186A;
	Tue, 18 Mar 2025 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJhKDpUX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8408936C;
	Tue, 18 Mar 2025 00:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742256706; cv=none; b=FAjAu0tdKcw+RmdPeMlq0uN9y/0WPMKb4cQrsU6ejmH8KDcKgasC3dAWVFlINqa9me91KkXwexkAbOLhnSQ9wV4nlxnVWK1n9HgM2MlXrcar2FRHtMdq7Kmju81/QSSLl8ZdcbjJliFIcgsfqTbLWTyBGDQb/AiCV5ErctSRrxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742256706; c=relaxed/simple;
	bh=9yK0py8vVsSJP132zg2YIoHooqEgB7XSF3eIE411kDw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oC282AiQoteKGfCS881h91JRhvPZuhGwGGVeKaPKDtIaUNpWZrCx2jzKSoMCeQeKYamazvK3w42CowwZQfCCJLFJ3QO9kZvPA9+TojPm6hQTGAN9M2Gw8OoHcI+5MhHmzmb8Q2gWXKeIHARs78k1+T6vFw5g8iim+ngmzTR1zJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJhKDpUX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c560c55bc1so491006285a.1;
        Mon, 17 Mar 2025 17:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742256703; x=1742861503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWAswVyC9gAL+JUEKJIpz1wu1XOjJtU4jEWUNN/Oekw=;
        b=QJhKDpUXi2pcIQ1xQAb3vgxB9P/XcAM5BIGOOR4woVhudxX9mdRKbSp9dZk4REMC8O
         a91Ov7c5ZcJ2EzTD/Pt4HuHZrlXlX3MjHTVSdAM33n+UEvdGDQ6rRcxCdSSCunwYeLpg
         Ei+VQGnq9NJXc/jWyuyBY6VjUCnZ8hUMmVd1o/KyVdYmOz4bb8HXhiBxleo+6HbfHc7E
         opMKn2ulZQE6FFFZTsTgKr/+uncWg6U/5M+ZjAMpqDFKAL3X6hXbsFS+E4ATfwQ3Zeor
         X8YYFO2EHgEvIPYyHSlVtxIJ46smnE145apkZ7dAYmxCcjUi3ybevX4JC42H2rA6DCFe
         3yXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742256703; x=1742861503;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWAswVyC9gAL+JUEKJIpz1wu1XOjJtU4jEWUNN/Oekw=;
        b=ol+JVJTm/YdByomQvdTLO8XICLo9XRZbFWsestOBjm94ToowV9aRrMP6XkFJd5YHpF
         Lp2AY4llbBv7Eun/ZUsG2qSr3pKep8Af63oYs20AkqbCnQ58H4ogZWpKtj9aRy4MIkYE
         QkLtsT0LqVuKl5+JOI60pYMNwmI3liRh1XPUwIRjriatZ3UHl8jP6bV/S3+yy2D5LIPf
         rDPvWVdQ+hiZ8FBmtg8w0PnA/T+JAfTk1fbTTROd5sHrBuSlFntNUS1MRI2/IF2doJUn
         ZjkX8+H7yXXHFOuigV0X5dH8honJVPjv8b9ALiLUwIjxqWwdDCY3TDle2nwq2NFvk2Y9
         CF5A==
X-Forwarded-Encrypted: i=1; AJvYcCUKamEeBQN0xFFWtnWMLScO5LSDfaKctYKdr5OSO73UvlsZKgMSmjvVlCSAhJxrREJal96oCuOAzqWN@vger.kernel.org, AJvYcCUa5Ojm1hFDUtMMhRIOnrTmEaZpxa42qKeGj2fbfO56xZ5wXDdNBCnPituKWLl6RdGtsYc/Mfoq9ZSq@vger.kernel.org, AJvYcCV5kTHoELR5bZxvazegFI1DwqbwWjFj7pDfqQK9XDPvVxPIqGaRcON8h57RpxygHyubmYMVTX5Y3ca7k6IE@vger.kernel.org, AJvYcCVfdAdEJPseHbAOFoy7BKBAt6NjSa/YCpyHsbgiSyPg0WswgjZMPNQjySXrTG8I65VrcGhbEKfHnPQn5l4=@vger.kernel.org, AJvYcCW4g7SVpYeFwuqpX77ZuVOUAANSFtvdM16CUj/rHB+9u/tD/aG3m6Ku/tMzLv7WgBB2WQVwVFwqbj5TUviSA1M=@vger.kernel.org, AJvYcCXUuLLGnMBE53LPREKTC8U/SGb7IHcLTZI1s63BTuMkPIoHEpeOU6roru1miC8hJTfIdeL3lQ3brYjTEEvEdzfL@vger.kernel.org, AJvYcCXVQd/E1XSfKWY+Vh3XVrA2jCLqnMNfmVtUCOmBd/hU2gkyGvJ6tKQbPs7DpHxHasmBY5uySFIfyWM+NCN5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmnt5RJeKAQHdPaz2Jxi4Qt+jW8h5Y9kuKMr0OFuYLdqTCOqBN
	qCgjUdSYVCmrpgPd4LArTwcaXMJiTDWtnaDGlF25EsgQQYZmWLIP
X-Gm-Gg: ASbGncugymX0zRnR06MPJF1BuoEfwUCSBQP39IH6AWDmSCj5QW1/me+9gJ03F86Ix2U
	9GiWrDZyHwIhIooGx/ABO53fVRXwSdzcJe299CHONYcutPGIxzj8DLvRde9+NM98CCl3B9oAgNT
	YxObNP7dNhb6kjfWQdAGxKQwryvlOnEre/0ShqfXWc/rMag8DGj6bdmD3T4sQz0/DAWMmY5KY8Z
	fzZGUW7EMX1YkYciddXS8pStVa5OtZ/Nfe33zxLftiqAYarFLXkhTMCjHozEefANmh+6hhyNDGM
	3bcPU719arHOGGgT62B8qFnVtrQQ21jbQA1mlPQVXivd3jkEmWrbchaTXs5MwGAyysf5+IeavfZ
	CXtkC0kLY56gF5H4IFyhwisbTmkFwqPDDuoQ=
X-Google-Smtp-Source: AGHT+IH/0Jlta/ciE5fE7c6rBZYmUWHpJca4w3SuMOLHP5wHEo1i70Q2i7p3aIwt3f8co74FcCGEuw==
X-Received: by 2002:a05:620a:2624:b0:7c5:5d4b:e62a with SMTP id af79cd13be357-7c57c927b63mr2762624585a.54.1742256703246;
        Mon, 17 Mar 2025 17:11:43 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d89ba6sm648537985a.97.2025.03.17.17.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 17:11:42 -0700 (PDT)
Message-ID: <67d8ba3e.050a0220.39b3b5.753c@mx.google.com>
X-Google-Original-Message-ID: <Z9i6OwszTSZ7xXNp@winterfell.>
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id D1FC5120007E;
	Mon, 17 Mar 2025 20:11:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 17 Mar 2025 20:11:41 -0400
X-ME-Sender: <xms:PbrYZ8tR0m5B923UF-9dZvgCNuPvHpv5ZBaHm6N4GiQ25vtpEC-lIg>
    <xme:PbrYZ5dRI94wfIYpSMbZyOsnLJUyIjHqUN0bp7mPfjbIPrFyX-R9sGgT0EQCCkjPb
    BfNcUHA6KImY0otpw>
X-ME-Received: <xmr:PbrYZ3y_63Dh7qN3opkBtyxrDM1sQiwReLUgJHWTcDNGluBNSO48K_3yab8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeeivedvieefgeelffehfeeuheetuefgueek
    teduieeugfevhfdtkedvuedvhefghfenucffohhmrghinheprhhushhtqdhlrghnghdroh
    hrghdpghhithhhuhgsrdgtohhmpdgtohhnshhtpghpthhrrdhrshenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtph
    gruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgs
    ohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspg
    hrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtrghmihhr
    ugesghhmrghilhdrtghomhdprhgtphhtthhopehmrghsrghhihhrohihsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhhitgholhgrshesfhhjrghslhgvrdgvuhdprhgtphhtthhopehojhgvuggrsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsg
    hjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhn
    ohdrlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:PbrYZ_NbnTWMrVscNe-CXxUh_1x1SyfpV8DcjG1EXHpbweGdhJ1gUg>
    <xmx:PbrYZ8885O6GdsI8Slbc6WzL8ko3dSEySzi-4YD2ZC8bbdAemsyI0A>
    <xmx:PbrYZ3V6itcjuPFPR26pWRZV-_-vthypJc9BE7-UMxTJYAnI5tIaVQ>
    <xmx:PbrYZ1fTdPxXFNo1pNy63S2-_4K6ShfzIXkJ3NNdmSuTxnchUBZsaw>
    <xmx:PbrYZ-fygsK-STME_gwbO44CNO6xbcgQvmhejjuRUbSqX2Murq3R_0FZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 20:11:41 -0400 (EDT)
Date: Mon, 17 Mar 2025 17:11:39 -0700
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
References: <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com>
 <CAJ-ks9n8mwt5q9unqfkfSHj9=ELJHtqsXM-xQ8jsbXeJX6Uyfg@mail.gmail.com>
 <67d8671d.050a0220.3305ab.6372@mx.google.com>
 <CAJ-ks9=uHjJrzM0ruvm4v4wr8LygRMP-1orWBy_9OiNNeQr0ow@mail.gmail.com>
 <CAJ-ks9=Qcmvbm=YGJ=jrX_+YdMsftk=FAimszYZB1OUuV4diZw@mail.gmail.com>
 <67d885ff.0c0a0220.111215.5644@mx.google.com>
 <CAJ-ks9kYB1b4XsQcFb=NScPq+R+13U+Sv-6opi-yp6=ZjuLD_g@mail.gmail.com>
 <67d88a1d.050a0220.2cdacf.4adf@mx.google.com>
 <CAJ-ks9kg4Br=56HT7T5sWpoMKhRqT_2x+cpQAWoyrEG3qyqQ6Q@mail.gmail.com>
 <67d895cc.050a0220.99d33.5adc@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d895cc.050a0220.99d33.5adc@mx.google.com>

On Mon, Mar 17, 2025 at 02:36:08PM -0700, Boqun Feng wrote:
[...]
> > 
> > What about `pointer::expose_provenance`? It's a method that was added in 1.79.0.
> > 
> 
> We have a few options:
> 
> 1) we can decide to use funtion-version of expose_provenance() (i.e. the
>    stub), if we feel the symmetry with with_exposed_provenance() is
>    a strong rationale. This also means we won't likely use
>    pointer::expose_provenance() in the future. That is, although kernel
>    doesn't have stable internal API, but in the foreseeable future, we
>    decide to use funtion-version of expose_provenance().
> 
> 2) we can introduce a PtrExt trait for <1.79
> 
>    pub trait PtrExt<T> {
>        fn expose_provenance(self) -> usize;
>    }
> 
>    and
> 
>    impl<T> PtrExt<T> for *const T {
>    	...
>    }
> 
>    and `PtrExt` in kernel::prelude.
> 
>    (we need to #[allow(unstable_name_collisions)] to make that work)
> 
>    We can also make with_exposed_provenance() use the same *Ext trick,
>    and remove it when we bump the minimal rustc version.

This is probably a wrong suggestion, because with_exposed_provenance()
is a function instead of a method in Rust std.

Below is what I combined all together (based on your v5 patchset), and I
did test on 1.78, 1.79, 1.84 and 1.85 and it seems working ;-)

Regards,
Boqun
------------------------------------->8
diff --git a/init/Kconfig b/init/Kconfig
index 82e28d6f7c3f..e316b98b3612 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -135,6 +135,9 @@ config RUSTC_HAS_COERCE_POINTEE
 config RUSTC_HAS_STABLE_STRICT_PROVENANCE
 	def_bool RUSTC_VERSION >= 108400
 
+config RUSTC_HAS_EXPOSED_PROVENANCE
+	def_bool RUSTC_VERSION >= 107900
+
 config PAHOLE_VERSION
 	int
 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index e8232bb771b2..a87a437bd9ab 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -64,7 +64,7 @@ struct DevresInner<T> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(kernel::expose_provenance(addr), SIZE)?))
+///         Ok(IoMem(IoRaw::new(addr.expose_provenance(), SIZE)?))
 ///     }
 /// }
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 0a018ad7478a..60c71f26d29d 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -75,7 +75,7 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(kernel::expose_provenance(addr), SIZE)?))
+///         Ok(IoMem(IoRaw::new(addr.expose_provenance(), SIZE)?))
 ///     }
 /// }
 ///
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c1b274c04a0f..79b19e601372 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -22,6 +22,9 @@
     feature(strict_provenance_lints),
     deny(fuzzy_provenance_casts, lossy_provenance_casts)
 )]
+#![cfg_attr(not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE), feature(strict_provenance))]
+#![cfg_attr(all(not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE), CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE), feature(exposed_provenance))]
+
 #![feature(inline_const)]
 #![feature(lint_reasons)]
 // Stable in Rust 1.83
@@ -30,78 +33,24 @@
 #![feature(const_ptr_write)]
 #![feature(const_refs_to_cell)]
 
-#[cfg(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE)]
-#[allow(clippy::incompatible_msrv)]
-mod strict_provenance {
-    /// Gets the "address" portion of the pointer.
-    ///
-    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html#method.addr.
-    #[inline]
-    pub fn addr<T>(ptr: *const T) -> usize {
-        ptr.addr()
-    }
-
-    /// Exposes the "provenance" part of the pointer for future use in
-    /// [`with_exposed_provenance`] and returns the "address" portion.
-    ///
-    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html#method.expose_provenance.
-    #[inline]
-    pub fn expose_provenance<T>(ptr: *const T) -> usize {
-        ptr.expose_provenance()
-    }
-
-    /// Converts an address back to a pointer, picking up some previously 'exposed'
-    /// provenance.
-    ///
-    /// See https://doc.rust-lang.org/stable/core/ptr/fn.with_exposed_provenance.html.
-    #[inline]
-    pub fn with_exposed_provenance<T>(addr: usize) -> *const T {
-        core::ptr::with_exposed_provenance(addr)
-    }
-
-    /// Converts an address back to a mutable pointer, picking up some previously 'exposed'
-    /// provenance.
-    ///
-    /// See https://doc.rust-lang.org/stable/core/ptr/fn.with_exposed_provenance_mut.html
-    #[inline]
-    pub fn with_exposed_provenance_mut<T>(addr: usize) -> *mut T {
-        core::ptr::with_exposed_provenance_mut(addr)
-    }
-
-    /// Creates a pointer with the given address and no [provenance][crate::ptr#provenance].
-    ///
-    /// See https://doc.rust-lang.org/stable/core/ptr/fn.without_provenance_mut.html.
-    #[inline]
-    pub fn without_provenance_mut<T>(addr: usize) -> *mut T {
-        core::ptr::without_provenance_mut(addr)
-    }
-}
+#![allow(clippy::incompatible_msrv)]
 
-#[cfg(not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE))]
+#[cfg(not(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE))]
 mod strict_provenance {
-    /// Gets the "address" portion of the pointer.
-    ///
-    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html#method.addr.
-    #[inline]
-    pub fn addr<T>(ptr: *const T) -> usize {
-        // This is core's implementation from
-        // https://github.com/rust-lang/rust/commit/4291332175d12e79e6061cdc3f5dccac2e28b969 through
-        // https://github.com/rust-lang/rust/blob/1.84.0/library/core/src/ptr/const_ptr.rs#L172
-        // which is the first version that satisfies `CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE`.
-        #[allow(clippy::undocumented_unsafe_blocks)]
-        unsafe {
-            #[allow(clippy::transmutes_expressible_as_ptr_casts)]
-            core::mem::transmute(ptr.cast::<()>())
-        }
+    #[doc(hidden)]
+    pub trait PtrExt<T> {
+        /// Exposes the "provenance" part of the pointer for future use in
+        /// [`with_exposed_provenance`] and returns the "address" portion.
+        ///
+        /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html#method.expose_provenance.
+        fn expose_provenance(self) -> usize;
     }
 
-    /// Exposes the "provenance" part of the pointer for future use in
-    /// [`with_exposed_provenance`] and returns the "address" portion.
-    ///
-    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html#method.expose_provenance.
-    #[inline]
-    pub fn expose_provenance<T>(ptr: *const T) -> usize {
-        ptr.cast::<()>() as usize
+    impl<T> PtrExt<T> for *const T {
+        #[inline]
+        fn expose_provenance(self) -> usize {
+            self.cast::<()>() as usize
+        }
     }
 
     /// Converts an address back to a pointer, picking up some previously 'exposed'
@@ -131,8 +80,12 @@ pub fn without_provenance_mut<T>(addr: usize) -> *mut T {
     }
 }
 
+#[cfg(not(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE))]
 pub use strict_provenance::*;
 
+#[cfg(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE)]
+pub use core::ptr::{with_exposed_provenance, with_exposed_provenance_mut, without_provenance_mut};
+
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
 #[cfg(not(CONFIG_RUST))]
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index b70076d16008..3670676071ff 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -22,7 +22,7 @@ unsafe impl RawDeviceId for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
 
     fn index(&self) -> usize {
-        crate::addr(self.0.data)
+        self.0.data.addr()
     }
 }
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 87c9f67b3f0f..73958abdc522 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -287,7 +287,7 @@ fn new(pdev: Device, num: u32, name: &CStr) -> Result<Self> {
         // `pdev` is valid by the invariants of `Device`.
         // `num` is checked for validity by a previous call to `Device::resource_len`.
         // `name` is always valid.
-        let ioptr = crate::expose_provenance(unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0) });
+        let ioptr = unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0) }.expose_provenance();
         if ioptr == 0 {
             // SAFETY:
             // `pdev` valid by the invariants of `Device`.
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index baa774a351ce..3ea6aa9e40e5 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -41,3 +41,6 @@
 pub use super::init::InPlaceInit;
 
 pub use super::current;
+
+#[cfg(not(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE))]
+pub use super::PtrExt;
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 6bc6357293e4..d8e740267f14 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -8,6 +8,9 @@
 
 use crate::error::{code::*, Error};
 
+#[cfg(not(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE))]
+use crate::PtrExt;
+
 /// Byte string without UTF-8 validity guarantee.
 #[repr(transparent)]
 pub struct BStr([u8]);
@@ -692,9 +695,9 @@ fn new() -> Self {
     pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
         // INVARIANT: The safety requirements guarantee the type invariants.
         Self {
-            beg: crate::expose_provenance(pos),
-            pos: crate::expose_provenance(pos),
-            end: crate::expose_provenance(end),
+            beg: pos.expose_provenance(),
+            pos: pos.expose_provenance(),
+            end: end.expose_provenance(),
         }
     }
 
@@ -705,7 +708,7 @@ pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
     /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
     /// for the lifetime of the returned [`RawFormatter`].
     pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
-        let pos = crate::expose_provenance(buf);
+        let pos = buf.expose_provenance();
         // INVARIANT: We ensure that `end` is never less then `buf`, and the safety requirements
         // guarantees that the memory region is valid for writes.
         Self {
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 08b6380933f5..b070da0ea972 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -226,7 +226,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons
+rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons,exposed_provenance
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 036635fb1621..331ed32adc35 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -224,6 +224,8 @@ macro_rules! assert_eq {{
         BufWriter::new(File::create("rust/doctests_kernel_generated.rs").unwrap()),
         r#"//! `kernel` crate documentation tests.
 
+#![allow(clippy::incompatible_msrv)]
+
 const __LOG_PREFIX: &[u8] = b"rust_doctests_kernel\0";
 
 {rust_tests}

