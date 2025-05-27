Return-Path: <linux-kselftest+bounces-33871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F31BFAC521B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 17:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82BCC9E062B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 15:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD5927EC7D;
	Tue, 27 May 2025 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIE9v0bO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FE27A465;
	Tue, 27 May 2025 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748359932; cv=none; b=DbezBKw+XHFG6seIzrhsLkByqEupoN1nIHoe8H2JUwBUuV7s4WwetazISHrnAvSXJJ02YAwz2Z18nJob9v1luqy1KgyB3KRxX/bbYpEfGhMJE3PL1m9gGlstBxpzawJda2WbA/Egl/WkyOx2B/3ecMTLUGN7Da78WLgYts4iNbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748359932; c=relaxed/simple;
	bh=UE1f648Va6HLI8/Jhdv9ETvSve+kkYfIA2LFmifxheE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=By5yXHNKEsHVhZvprw3dwCkBEt9rty5ZsVbGVGtdZOlKDZ+vYMppmPI3sE8XwvC3psJBfglg2RMrVmZI50tefcPiyL57jl+WpXF/OEurtEflBfa2DkjOzIPKt+SMq7EQfX0RXegvx296GsTwm6bSZMTkHSbrzE76IX4yEbjO2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIE9v0bO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549b116321aso4755329e87.3;
        Tue, 27 May 2025 08:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748359929; x=1748964729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xak8pIYLubcnK6pBqvVQcKCjzEoRL1YIbbP2xw0LEs=;
        b=KIE9v0bOs9F9uWZgzTtVUtlzDd9kxvKa66+rvGTITCqajj0DhUpOCqypSknCc1d5Di
         uMLx4FZ78HimDzRdMTVv0qkDb26anhMp9DT222qYS/u59sVBhLoxqzgGU6me9k9srSuI
         WSPOduWKBM9cWXZzoR1w5Ei4EwW0EDCxb3Vd9CdPtWq+jCK0N3RH3rlzkqpouxcaRVbp
         QXLeb2Yq3ZGAdgQEtkbyaU+eQfDh4cVashiYjFvs/Fhwce7GV0dMOD4S58E9BH+kIUdS
         HK2nYGtkYiIz40ib/ApCvcWtn81pZW9hMVYc5UNJvQFrc+mSq0SM7gxDtCsWq3He8xTS
         py2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748359929; x=1748964729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xak8pIYLubcnK6pBqvVQcKCjzEoRL1YIbbP2xw0LEs=;
        b=k/1njSoHJlrWF/fRixt+ZCX9PyM3IEzRbGk39FWZhXH1nP+Cnm08OQ6R+fuzvgcKnP
         2SoWBGqzvnCgmEFzqqhCPqVZUlqHoCvFG3PmrmqC1YcdYeY/L8yFYyJWp+DC96GxFW3r
         BSU7H54Fact27xCnAHUtqFyhjI2CQfIx/CScbVn+PGDNxIANBZevWfL28cupDSCSYEdF
         X9/SV+HBOF6y1edzw+9PoIy+8fAzijX1+gDJC8KItlE8wGGj5T17H+PLza+Nm2Mmrqno
         IZ59lyse6ZfMIOE2wpJ/rvBS08ScOA+XTwTPtvHQuSVO19ITPo6KsbyZSWGxUP8wNC9U
         dVDA==
X-Forwarded-Encrypted: i=1; AJvYcCUDUjUMSWav+I08VqD72waGWN3gdJDkbT9/MZq3FS9EvcmJI829oc8EmwStqWMYN2z/n/K0zFJi9IAV@vger.kernel.org, AJvYcCUgtma4dxamTSOh2nejqSxUPJLn4EQUW4Eq2ym9U1BS0yQAlS8U6WIUPBZcGVPIKDOKleFJFs4k@vger.kernel.org, AJvYcCUrGz15hdU/h2ObGFclvTgKHmUQrxrnRTsZng6mtK1eG3jlBwqUjbORIPzmQSBfiJrLlrxbeyqd9O5dtOE=@vger.kernel.org, AJvYcCUrObMuxRXYbCTilv7ZwHGCDVY2XDouG8tQ0zy8jNeNkDTMJyWq5OkmQcHTOLyThtV8K++m1Bxs831cnihx@vger.kernel.org, AJvYcCV6TW0oq8NwffXM726TYP4UbPirMTVX9dSMUS5jjy54pmOmr3XrrAvGHsXe3RhWqxjAkk9FZpnzAnf0K9noNiKZ@vger.kernel.org, AJvYcCVYs3F5d2/Hh6jgloK2VcvyZz+aHOfjQdnaryq27pOwLEicKruMyXddAQyBCvoITWFtTJ4iD85oXp/0@vger.kernel.org, AJvYcCWrrS1hONpQ0m6tSI2nj5BCA2dCG5je92uABy1F7+tLbyfnyQzr+3M7+UhfMY4uh/BTF0TPiidOJzpcOqfe+sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV9CifUze1UaUucdpnkV+dVk2FQLmjoYNA8v2n6OEJdjVt8BLY
	IilCPAZ7rkT/H5NEwLhTfrPPGyhwP+tcN91mC+7Y1FRjkMOc93eXYS+pDhsxm+hilxgBrkXywc/
	NXr96nPXEWQfMLgkyWEtUMAueaYyTeKw=
X-Gm-Gg: ASbGncuxEcFy09r/bueOkQ5Cca99l4P8vDu90CHHhQ0CXpLAR96KgLCrpfGx/72CD/q
	fAlcq1bS+Tw/zFBKkZ0iua40PxctwZdF/AzkQyi8tAIqM72zXBVa91+l11V7oRvyQAy9vKlMKA/
	0qB7lh6qojCxZdOuBn+wWqp1tBxQjnc6UEyd2I6hHPQp+8kvcP
X-Google-Smtp-Source: AGHT+IGvM6m4b/lOw7Cp3xhdEUvITDXLXKyTA8U5LnOCkoop3fcnfDwhYylu9Lc+nCvgTUxjeVkZb8rgZTfeSHv0dQ4=
X-Received: by 2002:ac2:4c41:0:b0:549:38d5:8853 with SMTP id
 2adb3069b0e04-5521c7addf9mr4617901e87.17.1748359928583; Tue, 27 May 2025
 08:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-4-6412a94d9d75@gmail.com> <DA66NJXU86M4.1HU12P6E79JLO@kernel.org>
 <CAJ-ks9nd6_iGK+ie-f+F0x4kwpyEGJ-kQiQGt-ffdbVN5S6kOg@mail.gmail.com> <DA6GWYHOSTWH.1OBQV7XCU2643@kernel.org>
In-Reply-To: <DA6GWYHOSTWH.1OBQV7XCU2643@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 27 May 2025 11:31:32 -0400
X-Gm-Features: AX0GCFuUtwm-Eot6MMjkQOKkHLHoljek9W49DxDhFIb7DRDERITQ1VimQxG0kN0
Message-ID: <CAJ-ks9=gW_viqDMQwyVeGfT9821tfZ7w-4Tycd7e7bZ3xKwXRw@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] rust: replace `kernel::c_str!` with C-Strings
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

On Mon, May 26, 2025 at 7:07=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Tue May 27, 2025 at 12:29 AM CEST, Tamir Duberstein wrote:
> > On Mon, May 26, 2025 at 11:04=E2=80=AFAM Benno Lossin <lossin@kernel.or=
g> wrote:
> >> On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
> >> > +macro_rules! c_str_avoid_literals {
> >>
> >> I don't like this name, how about `concat_to_c_str` or
> >> `concat_with_nul`?
> >>
> >> This macro also is useful from macros that have a normal string litera=
l,
> >> but can't turn it into a `c""` one.
> >
> > Uh, can you give an example? I'm not attached to the name.
>
> There is one in this patch (:
>
>     diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
>     index e5621d596ed3..09148e982f48 100644
>     --- a/rust/kernel/kunit.rs
>     +++ b/rust/kernel/kunit.rs
>     @@ -58,9 +58,10 @@ macro_rules! kunit_assert {
>                      break 'out;
>                  }
>
>     -            static FILE: &'static $crate::str::CStr =3D $crate::c_st=
r!($file);
>     +            static FILE: &'static $crate::str::CStr =3D $crate::c_st=
r_avoid_literals!($file);

Great point, and an easy one to replace with a c-string literal. Done in v1=
1.

