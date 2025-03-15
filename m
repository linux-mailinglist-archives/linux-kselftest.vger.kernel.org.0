Return-Path: <linux-kselftest+bounces-29126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B46D6A62BFB
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 12:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 179767AB565
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 11:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349381F8BAF;
	Sat, 15 Mar 2025 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAlDNG7d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D618B494;
	Sat, 15 Mar 2025 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742038852; cv=none; b=SZdm5ROVD2uXD9H0EJM2RQwMaVmd1oD4bJJW4FSUi9PV/P/xj7GtMjVVp6nu9FqnMDttHMOJ63bz3pX9gjcAgKbC95ld42XxrQMgfs2oN38R1FH6SQsuBkvGrDEc0N8MxzxaTuvE6c8y+KPiNJ/1iB0cn8W26pOnmJbuVoQRRs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742038852; c=relaxed/simple;
	bh=GZk4fae/MYr67eBVU1vWnrMYaBDTRXLN3fZqhAOhcd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s30iibRsMlVPXSSCoty73HpTaJry7tvkIIYP5Jm3H2tB1PwcvpN/yBx7tNNtodZ0uGivyq0EpPYuSGGAOWu+G+6M3zlrVhko/OTrYGyvhdals/t8qDHFDuf0sR1kz68i2yh9YUCkouYJDe1BIQWsjzVrQTMxBt7jeV6LWpCHaQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAlDNG7d; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5498c742661so3193068e87.1;
        Sat, 15 Mar 2025 04:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742038848; x=1742643648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZk4fae/MYr67eBVU1vWnrMYaBDTRXLN3fZqhAOhcd0=;
        b=KAlDNG7dt4zKx0AH91qp79BI9taKzij5Xp8l4i4jCE8S5cht2xf91aik0LtrrilhNj
         8rAMXrlLVWZ2W+dzlYZ2NDGeoAPf2SJiKrpkr4CrRcj1y1lbdLDH+ehXD12IlL22cm78
         R0+62ysJdcoa3imc9rU0eI52QygsXkcROtQAveX5sXvsuMdl/K7VHawsHyd1PWGjkIyh
         4+y+9GO21tvEbKwsOpIbQLhKLVDs7SOiKIfCR6DSRTBzW44a2KOH8BkA6TlB//b45V3z
         /6fX5vyFx8xqDcu++9OZ204pquss/3UrOhfAcMhFKoHHIrrNu7oSx6qv7+7hmaXPiQFs
         BCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742038848; x=1742643648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZk4fae/MYr67eBVU1vWnrMYaBDTRXLN3fZqhAOhcd0=;
        b=CdVMufDNsLbghnq1l9RlUNavGHm9MiA+FgEfMSbTPuuj8DkF4Wj875AB697hyhI6Jh
         cKRoQaPhdE2uc42+WTfXYLwsPKUpkEgGN1Q2tAFo8LAr0/SMjp4dQH4KWOWidppuFEP0
         yF8vAUK55f0R98/qKUfJcZvYekkw1tYepn56Jx9IOdb19ojEUqY9Cs0yQkiXZ7RrktCF
         lhS681Iw52Qtw0Xoh8JgwAs0J/kbWgOyO7vsYdrLfRrwDjTkBURdBh/ckqwylXeTBpKU
         FoqYW6cmQjOOnXQATqTuHHVG3ZCtvXDpgws9M1tU37DAA9CIk2/YUkJPM8iNPcY3O5s+
         Y1yA==
X-Forwarded-Encrypted: i=1; AJvYcCUbIA/2TqJLBqBUjmdcfzxfnHizYcjul0NnpwLhfu9dvZMmKE76JO1zZJBfR/55by7ri9/MOb7hvW9C@vger.kernel.org, AJvYcCVyoWwPuwNlvbG4nvhyhwpFAXr+c1bS+/tkhFiqliQjqOJ5ixvI5V3IQDyADyx7KbSUbvvEHkrAKJuAukDp@vger.kernel.org, AJvYcCW329spGndCqefyPRRvl/wsCD8uhi/YX+DdsoDniBHvHzS/2uSyb0vM3vHXgLGJ7RqoO9nseLdbba1NJw4=@vger.kernel.org, AJvYcCWCJhQ24QOo/dztb6+pOoFRNiNPOJCJJO31lXE4aEa1vPt3e97vDxHD+XPUZAdXjJklfVYcHOAAfFj/@vger.kernel.org, AJvYcCWLM/tdU8sVIyfKOsEo6LZ5UYk5GCQ7X2ZzwIUgBggNFOujGN9l/uo0XV0pwU4fw77zVuoRcNLTWwVJd4bwRf4=@vger.kernel.org, AJvYcCX5odi5CO2dYIdJ+ZDo6neaUqw150jjQUpROq0jzKRo0raauXWuDLIjhH4tUzdAJMyWF0K3icQKkfGW7aQ8mkqY@vger.kernel.org, AJvYcCX8pKeidYEco346y9OgHsUofNUj/YjHE5fFIlVURDVeagrArbFNVyfwgjX8NGRu2flT7LkA3h1saBSGmE7S@vger.kernel.org
X-Gm-Message-State: AOJu0YwGfBr5LYqNRe1WTW7VRBxXbO1MtN/1svz+CJuHGbh1KOEi1CJz
	FalRS7uWYRprZS9anKAx5vV5raYA1ROmWLYfIRsr3xGW6XG7TtVCVxlyysPwmBaBsz/+0ubWYhv
	ST8JrnTxKdqIShQnZHqkEyaVGTFU=
X-Gm-Gg: ASbGnctChh6TJ98fNkh4xw7JrB/GEJaRTpD0juckxOX6L2defRnppTSv3dPLf8SJhH+
	948uukqissJc5KSVHcUoVABxLWR4eAhfE1tcrIcUxoU5U5gDyyjitJcA36A8BN+/OZPJGT+EIA2
	eNtxd8HMJsoErsrp3HZfPRsJCemCWHd+7aFAqUMIjG4wlj004akHn6BgkDsmwF
X-Google-Smtp-Source: AGHT+IE5YOwdAlkimyDKgierukU/3MUe/Bnh+7Dt6lI9qeuVqTH+ammroy8zrPwyvHKRkmqwZzkFDYys53YFqpqT1HU=
X-Received: by 2002:a05:6512:b0e:b0:545:3032:bc50 with SMTP id
 2adb3069b0e04-549c38fb8f3mr2455457e87.19.1742038848058; Sat, 15 Mar 2025
 04:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
 <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com> <D8G9LZCS7ETL.9UPPQ73CAUQM@proton.me>
 <CANiq72=JCgdmd+h4_2VguOO9kxdx3OuTqUmpLix3mTLLHLKbZw@mail.gmail.com>
 <CAJ-ks9=Ec0xLg81GUYJ07uDzwtwhFkoEdxaa3kNtV6xSjZ57MQ@mail.gmail.com> <D8GQRANRVU11.SI7SZ8RAXXF@proton.me>
In-Reply-To: <D8GQRANRVU11.SI7SZ8RAXXF@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 15 Mar 2025 07:40:11 -0400
X-Gm-Features: AQ5f1JoeAoHyy6Si2IMNvKKkRV0I5imCdPBPltc96FGLSP5A2aIFj72qS0jC_mU
Message-ID: <CAJ-ks9m7GwHgBCEYcNiNC7HTMscO9es-RtvnCZLO=PmiU530yQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] rust: use strict provenance APIs
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
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

On Sat, Mar 15, 2025 at 5:44=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Fri Mar 14, 2025 at 11:20 PM CET, Tamir Duberstein wrote:
> > On Fri, Mar 14, 2025 at 6:00=E2=80=AFPM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> >>
> >> On Fri, Mar 14, 2025 at 9:18=E2=80=AFPM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
> >> >
> >> > I don't know when we'll be bumping the minimum version. IIRC 1.85.0 =
is
> >> > going to be in debian trixie, so eventually we could bump it to that=
,
> >> > but I'm not sure what the time frame will be for that.
> >> >
> >> > Maybe we can salvage this effort by gating both the lint and the
> >> > unstable features on the versions where it works? @Miguel, what's yo=
ur
> >> > opinion?
> >> >
> >> > We could even make it simple, requiring 1.84 and not bothering with =
the
> >> > older versions.
> >>
> >> Regarding Debian Trixie: unknown, since my understanding is that it
> >> does not have a release date yet, but apparently mid May is the Hard
> >> Freeze and then it may take e.g. a month or two to the release.
> >>
> >> And when it releases, we may want to wait a while before bumping it,
> >> depending on how much time has passed since Rust 1.85.0 and depending
> >> on whether we managed to get e.g. Ubuntu LTSs to provide a versioned
> >> package etc.
>
> Yeah that's what I thought, thanks for confirming.
>
> >> If something simple works, then let's just go for that -- we do not
> >> care too much about older versions for linting purposes, since people
> >> should be testing with the latest stable too anyway.
> >
> > It's not going to be simple because `rust_common_flags` is defined
> > before the config is read, which means I'll have to sprinkle
> > conditional logic in even more places to enable the lints.
> >
> > The most minimal version of this patch would drop all the build system
> > changes and just have conditionally compiled polyfills for the strict
> > provenance APIs. Are folks OK with that?
>
> So you'd not enable the lint, but fix all occurrences? I think we should
> still have the lint (if it's too cumbersome, then let's only enable it
> in the kernel crate).

=F0=9F=91=8D

