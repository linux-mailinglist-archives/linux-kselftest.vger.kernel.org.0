Return-Path: <linux-kselftest+bounces-33870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54296AC5214
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 17:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF783AB170
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 15:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC2D27AC3F;
	Tue, 27 May 2025 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2G0p1eU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F99B27A93D;
	Tue, 27 May 2025 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748359905; cv=none; b=OlTlFlQAH/VvbsXo7B7KNlLFNcvg+Ga44JKhGPSxGuu+do6Wd8/bP2xU74p2K+L6IC/nGNj20P22x+23xvRr39f0V0IksI+JGRfX1TqRxUzobhVffznFSNmHJnv35DKNg3ZLX8lTENOEH7fysAONvZGr+6l66OaForm6yMkb8aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748359905; c=relaxed/simple;
	bh=iznhlCHEPeP5gtUawFfO/CMtIcM+gezphiFD8zog8f4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcXYPVR0nCd31BSZVPdcRaNsc3+2NSGyvcBOE3gcApvVq1KmazKG1/VJofzv5gLgjjpedZ5okhtfeUgHx0bTmzjhnOdt3Ex5POFFvPnYnb8Y3iGXv6kLZmfhHLEvxwhxSC7ASYxKYp4q2/suzCh0dzwpBhrTZULulYy+JPiaT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2G0p1eU; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30db1bd3bebso33553981fa.2;
        Tue, 27 May 2025 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748359901; x=1748964701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iznhlCHEPeP5gtUawFfO/CMtIcM+gezphiFD8zog8f4=;
        b=J2G0p1eU4saE3xpl5AhH9Nc6rzSAldYMZwK7UrJYLwT0t9AUu6s3IRjwAeNbU+Ky1X
         VhTkE+1bsec8kdLm3Ra8XLDSsZR8unXPdzFfO3IDhS98+0ZwNiEsblzURdWGV5ojg/Yh
         gfoOXZZTrUd98fIQr3EKu9/h/jZi5TT7lnQJ1uEB11JxfqiPbOM1TnxqI6OukEHL8kvf
         T5+l/gQ8y4+lGp7QkFBTweJDm7jpIL0ij9zurn3SfQYGYrD6S7zSf2/DGNiHRAzzQ6u4
         eRGLssfgQTs2HgtIecGY3CtOmsJTzKDui9rKbn1qn4Hkss0lxX8c5vj6VDjfFC+g0X7e
         ezBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748359901; x=1748964701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iznhlCHEPeP5gtUawFfO/CMtIcM+gezphiFD8zog8f4=;
        b=hKMsvCk3Yl2WBdS4zR4Z9aldVAmpW0w3VxEeyGYIUsi22PbZwgJXQPlTAI/skl7ayK
         jtQjZkVpx+8xOby9P/BghT9r1dNAow5naG79ugat91meGVn+mD/MS+4ZuAbA613g2pQD
         x/SQpZhzH9lZCff4XQDIGZfq8tqLJnOM80oP8OOf58teyKsmfwKIZWcw+/NmX0oNjolg
         gxeJWPiOYdEYd8la7GilBPlhr8+ZZsTx3bEbzgwx4XTC6V986zeey1liO2838t21rEFm
         nJcDTMuofNqkqe7ZeUng3qKnok+sxYNSFbgwTwGr5qvirayt2jKUqZxJBEy23rAM/LkV
         Djmg==
X-Forwarded-Encrypted: i=1; AJvYcCUKjmM//ihtPaOGUISBXL5LScJFOWVHusmacciqSFOCmlUUn/AuHvBG6On3QmiW40JgtDUBLTdb0mg9/p05ys0/@vger.kernel.org, AJvYcCUozOWpUsmihg/igVWTc4CKTOPDvN69ZkItufiobMHIBWGGshuKHIcbbR7r2GuDphDETQyEWUz8xg8MSbE=@vger.kernel.org, AJvYcCV1Mqu6oxGqaF1CN/0aHp4zJcQ4hRgxw3rJfDjrjl+CLSGsqCO/qSn1nKp9cQmFbtHei+m6S3/foKTAdLLBESY=@vger.kernel.org, AJvYcCVKPanrK3IQkK84zIfKe3lopSayZ619m1HdKx4QZJmOUJSOeURBt2vGYPxk6sIpY9WdyQgNg643@vger.kernel.org, AJvYcCVZpb+PHe5WBxmJWCcogIMy9VEDCwri0MgTkUYeHa5vAURvRENCuCZbGvfL77J/svNUt95P06O7YaQh@vger.kernel.org, AJvYcCWE83ADzCK3YcCOQS958jaEvKpD9Q7fId1apQl4FD/r97HAU3c23tFJTDF2S5dWg4KPr/f3JH0fTmOUnXNh@vger.kernel.org, AJvYcCWtuI82HQZnS4hLyKK5tdSAmRen5paDEWf+8rsrjC3rjn+B493174xAjUfoObxKiyiewRLmNzBRyX5c@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnsgO7644Mv4HF9b48feyxBeJbhoBhPTNYBUlw+lq5hBZO8hu
	XFmmq+vSTpKYAVF95Tf9AxT+g2qc0tGfDy5ftZmIsoOymoyiWhVxcHYWphc8e7KiX0L3MQAqMNf
	STnCpzrl+3StyXZbD8pX/8wFyS/BUWAQ=
X-Gm-Gg: ASbGnct3ta2nAo751gD2yw1L1bewghMFt7RzVigR660yajUD0XFMnha5GOp6PxR72fE
	nM++rwCV2fXoRzInKTmFAzPfVLKOdFIMx8/Bhs0NZaz2phTHOsNFLXbzsfBmcfzLPbGoZZLklNg
	eS3ZMctqXnTC7mcSelmH30UQXcZgDsfPtY1JWSsg+VILUsYDqW
X-Google-Smtp-Source: AGHT+IGh7j3R2Lz5ku1NP2jO6jmUvppwAP/M8QfRt/BCMIbepGXx0xkMd+/B+0FfsH2Ts/09nLW8pSm9EZf3hMbUgb0=
X-Received: by 2002:a05:651c:304c:b0:30d:895d:2fa5 with SMTP id
 38308e7fff4ca-3295ba248d3mr26953991fa.14.1748359900905; Tue, 27 May 2025
 08:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-3-6412a94d9d75@gmail.com> <DA66HHUA8ANF.BI2FH7POFSRJ@kernel.org>
 <CAJ-ks9kmDiOV_qH_s-r4Z4iQf2k6H7ZnqOf5okaQxWWxrj5Deg@mail.gmail.com> <DA6GUB3YOVBD.RWGBCC8CTE7K@kernel.org>
In-Reply-To: <DA6GUB3YOVBD.RWGBCC8CTE7K@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 27 May 2025 11:31:04 -0400
X-Gm-Features: AX0GCFt3TZm7A3lWw22HaGxbcPpRtWDbLI6U-f3H-j7VP2POqxnjTzuj9-Y7MDw
Message-ID: <CAJ-ks9mCZ5rKUFmkM=KPdw=gALjCjdMrMzedu89w7TxwvPyREg@mail.gmail.com>
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

On Mon, May 26, 2025 at 7:03=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Tue May 27, 2025 at 12:24 AM CEST, Tamir Duberstein wrote:
> > On Mon, May 26, 2025 at 10:56=E2=80=AFAM Benno Lossin <lossin@kernel.or=
g> wrote:
> >>
> >> On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
> >> > `std::ffi::CStr` was moved to `core::ffi::CStr` in Rust 1.64. Replac=
e
> >> > `kernel::str::CStr` with `core::ffi::CStr` now that we can.
> >>
> >> What's this supposed to mean?
> >
> > It means that kernel::str::CStr was introduced before core::ffi:CStr
> > was available. I didn't check this before, but it is indeed true - see
> > https://github.com/Rust-for-Linux/linux/commit/faa3cbcca03d0dec8f8e43f1=
d8d5c0860d98a23f.
>
> I see, then just write that and mention the commit.

=F0=9F=91=8D

> >> > C-String literals were added in Rust 1.77. Opportunistically replace
> >> > instances of `kernel::c_str!` with C-String literals where other cod=
e
> >> > changes were already necessary; the rest will be done in a later com=
mit.
> >>
> >> Similarly this, the message should explain the motivation for the
> >> change, the change itself and can include additional information.
> >
> > The motivation is implied (that using standard types is preferable to
> > having custom ones; this is also implicit rather than explicit in
> > https://github.com/Rust-for-Linux/linux/issues/1075), but I can
> > sharpen it.
>
> Please add this information to the commit message.

=F0=9F=91=8D

