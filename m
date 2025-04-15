Return-Path: <linux-kselftest+bounces-30895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F53A8A99C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 22:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DBB3BBA2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 20:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D6F25229B;
	Tue, 15 Apr 2025 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLHJiUd1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E468460;
	Tue, 15 Apr 2025 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744750276; cv=none; b=qkuTzdaqUf4cESqUYd+jMT+1aw8q6jxFYNkkATizBQwQubkIGYBSdp4HqYMqUnj5zJV10cVaD5GZgX0arPy2uJIfTr9BFgHhtiwjxsW7vSGPRjMPe8gE4Af9pKiub/7Igudp++8BfXY4SmMDf3vz4SFT1zE8hFijHjuVpqDboN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744750276; c=relaxed/simple;
	bh=IaksJRzJEDOr++L54rfLi9Nr/aZQEgu4Q6b+wV/6FnE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEVv4YI6m699j74RuELDA/vlFWq1PLbUlq4IecE+nzQfHyyBLm5LEhvYmSBxxN9quuheov/FMXlVNvr1LAsYtQVY1dWDKX2rEPhTAzYenLgyGNN8fu7ADlIhZMTFVJsB7qguZ9D8PIRNHOx3dGjtJMz8QvkkJ1DygvAiMzUgwN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLHJiUd1; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ecf99dd567so75919516d6.0;
        Tue, 15 Apr 2025 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744750273; x=1745355073; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0tQ00eLs4Tm633P+iqIgo5YfEEsfyJPoQay6prk03E=;
        b=cLHJiUd1Uoo52orTDuYQzzTlfK9Ouu/3eIMjJNMat7XO9EwA6OpfQJFbuEUsUmhOEd
         2QOjsJHUXHhoaq6CKI46Zdrxo+JYfJmVVNkkUxrkvmTFr9vwUpewBKW3NX8WNVhhYIg0
         fpnK7d7glhG+P5X7anIkqCxdDxg3mGKdXypOUIfMaMZ44jvQxp17eq/HnJD+t3e2P++S
         BqeSUQHy0h6Rrmz7VAGGfmDAinfKCmg7bOWLPQuYpSa5lFnuzyW1sveNqxPLGWQXMVOY
         0IdwrKcBLOUnWumQ7OpqdwOjTBBabijAVb4INGxsOJJlgaKznMpsSfZ11S+1BHFMm5CA
         LNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744750273; x=1745355073;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0tQ00eLs4Tm633P+iqIgo5YfEEsfyJPoQay6prk03E=;
        b=UHomr5Ayb6FH73Y3d9k5yzyriI3aaokAusfSsPOgmFPIri1/Q53faiKNN4fI/tcN3v
         TxHoAkEmJaz+cjZ0cMLdnYarzlPVFRzpwlaiH2p1s0iJDSNVqRZFyG7N7khq+h+StRaT
         ZFtVzYVJkMztGFrPkD2h0OadnTs1yYhfkk27OgDn6ADDdU0pIJAH48R79bjydoQpn3D9
         KycfMG6OwO4JMwbbijkKtvEVmuoxpvDGmcaLleUFyHft1lDbdHk0I3IdvyHJOPi8T29z
         LsVsXDwFKuCI2z0x4tPF3aJBZnuEjL6LzfhlNklCsSeAr2unKe7dP3hItXlrOchZlfBJ
         +hKg==
X-Forwarded-Encrypted: i=1; AJvYcCUM6yznKiAmsrDGu+h3jpqxnMVGlP4XloFdbxYFIwf+ElEBmLsUmQUpGkGPcsjU2RHqOmZfbtlZ@vger.kernel.org, AJvYcCUrvTTQ7Ky6gLI/0uhwwxupVAguCWOnffSyow4ecBMZyvq5SGiiyz3Dwg7z1INxIxfZh3K8Ugnb+MOZKHCDiq3z@vger.kernel.org, AJvYcCUuQnxMvNZM++mFJr7hN/0sExmDXmcirSt+QgYhzYnm5eiEZ1epn0MDyaYnR+shcxFoi2U1i1pCF1BRo31kSx8=@vger.kernel.org, AJvYcCVfLzINjbgb5/e1GdEilD8BAicUsCTmeLqpCeKGiGMbNgyosT8Pjw4wtMnM1eYe0hbNunADalmadNAq@vger.kernel.org, AJvYcCVq+07/0hcAGyM9ClT8aE0kfkJmvjvk3G6s0ZnMlDbvEPbJPUoYFZ2GVds10J9JwgEUrf69s7mXW4DRoCou@vger.kernel.org, AJvYcCWsUM1vb/I2IFcvSmY1evY8UmiQSLR/Vk7o0N7Ml2G6wKmfV8ftRNxThr+aO73mjsX9QqxdRizV1O4smEE=@vger.kernel.org, AJvYcCXOA4d7PSC/syz4xF5TEYStQFJiPsIxff+1XFkOWVMGJ+xrjCSe47byhh56VEOZaGYogsbqPldHHyBJPF0C@vger.kernel.org, AJvYcCXXePg73CqfciUtxATgtZx5AGY2bWOvFyj0XrExqZa73EsM1mOUAT8mncQEiphuEEp/2jfsVqSv8ma/@vger.kernel.org
X-Gm-Message-State: AOJu0YyxgYt35FY5w1RHlHznOwQxeSX80SoYH9KxPK8PMZwmiN/0/hV7
	RC7kxHM8qd9QyfYdV+eIDK3lJ97o0bv7Sr6KrxRfacRBjI420lsEWUudSw==
X-Gm-Gg: ASbGncu+An+HhiQi+THWKQEy+A77x3MYbvZVDBX/VslBVMDJJDOgOvvXq55kYB8KNIh
	Z7UIUlNIn5cvNuVVJCa/SmEOzJ6PrSX40j1x02EK0EcelMb6at4OZXUxQcInYx4USdc1h/x1zOo
	r3rcnxF99fJjSyY5sVuUy107ecQFdG+jO4KKRBxNvb5PNtzgvdkF7QbiJnaxF+Z6i/BsvMU6vCM
	RBlaPMq7cFdNOV8lMh6caxHcEzXvEaj8iBEd/g4cH8SJWaHzkothWDhtCDXtE597ceiqQeBHOnb
	F12xWTYfgxUVwVOuzYj4/HxpfLrvScn/75vFx0qY10Dnu1Nhm9LiFAsVcUetDQGa1GUsTWmeOeb
	vaDFEK0SXT2Gw0c94wQfqkmrIZO4DNeU=
X-Google-Smtp-Source: AGHT+IE1dCcR96vlLkQXzQT/eFHlRGeTTVVl5g6zbx9Rg8qrLjTfCEPFy9rO4Jl8bAnKBfMwWo/c5A==
X-Received: by 2002:a05:6214:238b:b0:6e8:fc05:aa23 with SMTP id 6a1803df08f44-6f2ad849efamr13993126d6.3.1744750273501;
        Tue, 15 Apr 2025 13:51:13 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f29427ede1sm54651296d6.68.2025.04.15.13.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 13:51:13 -0700 (PDT)
Message-ID: <67fec6c1.0c0a0220.f907e.c6dd@mx.google.com>
X-Google-Original-Message-ID: <Z_7GvFc4nNc6CflX@winterfell.>
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id D6518120006A;
	Tue, 15 Apr 2025 16:51:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Apr 2025 16:51:11 -0400
X-ME-Sender: <xms:v8b-ZwSpeeMWS-AgOReIxu212BJqnnL3IWn6oRc050tdsemAyDXCsA>
    <xme:v8b-Z9yqTLhPtZwgT79r-lFQ8w4fAPKNhnQ5ppgRXAIXlxCed2Vy6S8qJoEFEgYwj
    LsJjbfV3DXCkOIZRg>
X-ME-Received: <xmr:v8b-Z92_VpxSpx99qWuk85VVZBAhwkzOia9W81q9OF1Vo5CszxM9W2DEs3k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeggeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhquhhnuc
    fhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthht
    vghrnhephffgheetjeegieduheelieeujefhgfegtdefgedtteejveetjeeugfehueekff
    ejnecuffhomhgrihhnpehgihhthhhusgdrihhopdhkvghrnhgvlhdrohhrghdpihgushdr
    rghsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeegjedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrshgrhh
    hirhhohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhih
    sehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtoh
    hnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothho
    nhdrmhgvpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:v8b-Z0Cr70trTNBX-anqf51yRU3N8WDn8qOJFNRvZ7lpdqHPkC3FNQ>
    <xmx:v8b-Z5guK0RN-dfE70nWF85kSlzQ4S0XYzF6b7nKdlvnAyY_QcfmXw>
    <xmx:v8b-ZwoDRhdajbxAMI6eokapqoCceE19AubRD3dPMzWsRwZl7QHAbQ>
    <xmx:v8b-Z8jYX7sLlzb_GxXi6MUD9MEewlysZn-977joyUwMeTpZadBETQ>
    <xmx:v8b-ZwTKozWWpgzl1E2O9D5hLYHTSeM3J9b0S-ksk4pMmJ3RLiaZgxpO>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 16:51:11 -0400 (EDT)
Date: Tue, 15 Apr 2025 13:51:08 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,	Miguel Ojeda <ojeda@kernel.org>,
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
	Saravana Kannan <saravanak@google.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,	Lyude Paul <lyude@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org,
	linux-block@vger.kernel.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Subject: Re: [PATCH v8 6/6] rust: enable `clippy::ref_as_ptr` lint
References: <20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com>
 <20250409-ptr-as-ptr-v8-6-3738061534ef@gmail.com>
 <67fe9975.c80a0220.1b5785.66e7@mx.google.com>
 <CAJ-ks9mzyfvsxkyud_wLXfhLD_zP95bivCQ9i2aC-3ea=Y7+0A@mail.gmail.com>
 <67fea2d6.050a0220.8fa7f.6690@mx.google.com>
 <CAJ-ks9=G1ajyT8gwLHyvHW09Z2gG=Geg7LDS6iyRyqx_wyp5Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9=G1ajyT8gwLHyvHW09Z2gG=Geg7LDS6iyRyqx_wyp5Sg@mail.gmail.com>

On Tue, Apr 15, 2025 at 04:10:01PM -0400, Tamir Duberstein wrote:
> On Tue, Apr 15, 2025 at 2:18 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Tue, Apr 15, 2025 at 01:58:41PM -0400, Tamir Duberstein wrote:
> > > Hi Boqun, thanks for having a look!
> > >
> > > On Tue, Apr 15, 2025 at 1:37 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > On Wed, Apr 09, 2025 at 10:47:23AM -0400, Tamir Duberstein wrote:
> > > > > In Rust 1.78.0, Clippy introduced the `ref_as_ptr` lint [1]:
> > > > >
> > > > > > Using `as` casts may result in silently changing mutability or type.
> > > > >
> > > > > While this doesn't eliminate unchecked `as` conversions, it makes such
> > > > > conversions easier to scrutinize.  It also has the slight benefit of
> > > > > removing a degree of freedom on which to bikeshed. Thus apply the
> > > > > changes and enable the lint -- no functional change intended.
> > > > >
> > > > > Link: https://rust-lang.github.io/rust-clippy/master/index.html#ref_as_ptr [1]
> > > > > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > > > > Link: https://lore.kernel.org/all/D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me/
> > > > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > > > ---
> > > > >  Makefile                 |  1 +
> > > > >  rust/bindings/lib.rs     |  1 +
> > > > >  rust/kernel/device_id.rs |  3 ++-
> > > > >  rust/kernel/fs/file.rs   |  3 ++-
> > > > >  rust/kernel/str.rs       |  6 ++++--
> > > > >  rust/kernel/uaccess.rs   | 10 ++++------
> > > > >  rust/uapi/lib.rs         |  1 +
> > > > >  7 files changed, 15 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/Makefile b/Makefile
> > > > > index eb5a942241a2..2a16e02f26db 100644
> > > > > --- a/Makefile
> > > > > +++ b/Makefile
> > > > > @@ -485,6 +485,7 @@ export rust_common_flags := --edition=2021 \
> > > > >                           -Wclippy::no_mangle_with_rust_abi \
> > > > >                           -Wclippy::ptr_as_ptr \
> > > > >                           -Wclippy::ptr_cast_constness \
> > > > > +                         -Wclippy::ref_as_ptr \
> > > > >                           -Wclippy::undocumented_unsafe_blocks \
> > > > >                           -Wclippy::unnecessary_safety_comment \
> > > > >                           -Wclippy::unnecessary_safety_doc \
> > > > > diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> > > > > index b105a0d899cc..2b69016070c6 100644
> > > > > --- a/rust/bindings/lib.rs
> > > > > +++ b/rust/bindings/lib.rs
> > > > > @@ -27,6 +27,7 @@
> > > > >  #[allow(dead_code)]
> > > > >  #[allow(clippy::cast_lossless)]
> > > > >  #[allow(clippy::ptr_as_ptr)]
> > > > > +#[allow(clippy::ref_as_ptr)]
> > > > >  #[allow(clippy::undocumented_unsafe_blocks)]
> > > > >  mod bindings_raw {
> > > > >      // Manual definition for blocklisted types.
> > > > > diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> > > > > index 4063f09d76d9..37cc03d1df4c 100644
> > > > > --- a/rust/kernel/device_id.rs
> > > > > +++ b/rust/kernel/device_id.rs
> > > > > @@ -136,7 +136,8 @@ impl<T: RawDeviceId, U, const N: usize> IdTable<T, U> for IdArray<T, U, N> {
> > > > >      fn as_ptr(&self) -> *const T::RawType {
> > > > >          // This cannot be `self.ids.as_ptr()`, as the return pointer must have correct provenance
> > > > >          // to access the sentinel.
> > > > > -        (self as *const Self).cast()
> > > > > +        let this: *const Self = self;
> > > >
> > > > Hmm.. so this lint usually just requires to use a let statement instead
> > > > of as expression when casting a reference to a pointer? Not 100%
> > > > convinced this results into better code TBH..
> > >
> > > The rationale is in the lint description and quoted in the commit
> > > message: "Using `as` casts may result in silently changing mutability
> > > or type.".
> > >
> >
> > Could you show me how you can silently change the mutability or type? A
> > simple try like below doesn't compile:
> >
> >         let x = &42;
> >         let ptr = x as *mut i32; // <- error
> >         let another_ptr = x as *const i64; // <- error
> 
> I think the point is that the meaning of an `as` cast can change when
> the type of `x` changes, which can happen at a distance. The example

So my example shows that you can only use `as` to convert a `&T` into a
`*const T`, no matter how far it happens, and..

> shown in the clippy docs uses `as _`, which is where you get into real
> trouble.
> 

... no matter whether `as _` is used or not. Of course once you have a
`*const T`, using `as` can change it to a different type or mutability,
but that's a different problem. Your argument still lacks convincing
evidences or examples showing this is a real trouble. For example, if
you have a `x` of type `&i32`, and do a `x as _` somewhere, you will
have a compiler error once compilers infers a type that is not `*const
i32` for `_`. If your argument being it's better do the
reference-to-pointer conversion explicitly, then that makes some sense,
but I still don't think we need to do it globablly.

> > also from the link document you shared, looks like the suggestion is to
> > use core::ptr::from_{ref,mut}(), was this ever considered?
> 
> I considered it, but I thought it was ugly. We don't have a linter to
> enforce it, so I'd be surprised if people reached for it.
> 

I think avoiding the extra line of `let` is a win, also I don't get why
you feel it's *ugly*: having the extra `let` line is ugly to me ;-)

Regards,
Boqun

[...]

