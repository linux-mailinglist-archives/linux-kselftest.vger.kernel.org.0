Return-Path: <linux-kselftest+bounces-29110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13211A6203B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 23:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 453457AC70A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA2E1EDA26;
	Fri, 14 Mar 2025 22:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQFlgxAW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19B21DE89E;
	Fri, 14 Mar 2025 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741990899; cv=none; b=e6UKPRRLbyBwDu0GB+AMOaVpWPIgiyhKUCbCW38khlswhdElFJBXE5+nbEXgAt826OZO1XDQZIthFPpnFRPVGl+6e5D7Oc+RuzAoRk81rz6h13lhA8SKmhG1HsCbsEuSuNI+RO6jHO6IkuMAVT9LY0EFYBzHPTmlzE0kJ1MYP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741990899; c=relaxed/simple;
	bh=bNHo813I0F32BNqKbJfaolMlVwl7tD0FMX9RWCWB8Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgpSMWcpIv0zUfg6KAhRWYETVOe8eu1DBEF41y339JvTd86lri8mthr0YJdJNvkSD8L75QHW2FwAM92MkwBPNtr0czRjiT3JBvTDBCQXwzIyVh5Ud8GOSkc35Imid0Q6IP4kwg2rYnNrOebCYa5L99VUIzBkKceje8ugYKleNaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQFlgxAW; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so22638701fa.2;
        Fri, 14 Mar 2025 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741990895; x=1742595695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNHo813I0F32BNqKbJfaolMlVwl7tD0FMX9RWCWB8Vc=;
        b=nQFlgxAWeRyp5XvSJy2I6SI5gWxlRZ9nIwGM8e0QHz2TlNvyKrv6ryAcEve/ZORFyk
         P/ilmoeKl19f/IKMqVJHqcM5nA8qZUCMF9LfN/VBa0YgdNgk+LqXI+v7sCQGGIz8v1Kl
         fIVtoIQAti9rB3+9UT43CzD+kvDrTsuhWdVgKsX8lfZORzz+2mhcr+bag8eYogkutnBY
         /Mm5SIzeVvsSVlfkttqSETNDHqHIV1Sd+PCAwXZQbAzcgz9rP468i07Y075EIeTsG7k5
         3WDWrsBs+ANjly7Shw93k/kOsOFzDHNFFaT9y4E1fecsdGedpfNy/QKycsD3m9ixtjpM
         98Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741990895; x=1742595695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNHo813I0F32BNqKbJfaolMlVwl7tD0FMX9RWCWB8Vc=;
        b=ZjMxqquGARzF63VwxzpQaH7b22yJm2nQKW/IJqrGZl9eBjvLBF36YLldkv0MgjzFJw
         CprHtIKX0ZD2q+Tm/WNW8vDqnsLS5IxdHnfKWBal6Kyj8j3WOAf2+WBr4vCHX0TG7sp+
         +Otwbbxvn5UVWJ9RHcg0cBoUBDbXLLeEoR4hWt8uGPMsKD2K7r4T57Gl67KJza9ygk/I
         IdwEQuVdDj62Bd0V/XvgyYXbvl97j3rC2SV/kGV3XUcz3Y5vtPomPW0ivhwnU+ZRgHPZ
         7FF5c2Z7n3SQvQCpXx48h2GOwqyYk7Ou8j1ZFbyOsMjnAQvaBhjJ9zq2RM+rXM8ol57R
         BoIA==
X-Forwarded-Encrypted: i=1; AJvYcCUEjAlunbZ6VH1RiZgRSDgiTXSbzZM7IbLRopv1Vso8YDRtoIIOl5x+9MMG2frxC82UIxkWVq895pV8XBY=@vger.kernel.org, AJvYcCUoTJqU2YQ2AL40wGxUFMV0G753y7ILO8o7fIxPRRuJcAs4h6TcXcPZPR2bMShggcOxKFOPUq/c4L9y@vger.kernel.org, AJvYcCUttC/SF0b+KHZ8/jOHpeipn046y22zFKBiTqUm1vUfuvINSZY9S2VAOxFg7La+sH+ObbV29uzrXkbTPhAt@vger.kernel.org, AJvYcCWTZC6OZFsB2iLW8pdedud66Pt82QGwCkahpM8w6R+S/hAbTs+3jMr/wJ01GX84Y/JBkHv0zKXGOCRYyWqbxBQ=@vger.kernel.org, AJvYcCXBKXgNeFSfSo6kFIOdF7XqA+k3AXjH+T9aSlyERoJ/G4RV8c8TMMLfAbPNw5kBgmaGoB4cGc26Y0AzoXjO@vger.kernel.org, AJvYcCXPPHcjmHg1Xw10vUdsrwjlcIBtfaVE3ja+MpuglEMmYVSsDFniBkSR/Ds++1dygyle84JqnRfAaJh5icSIf2MR@vger.kernel.org, AJvYcCXo13tZhrrRBQcMFCzy+2RCRoVqKKPftkDR5PlZ/nWLWt96YlllTD/n2toj6zZzRJHL9n7iPiPKLGTr@vger.kernel.org
X-Gm-Message-State: AOJu0YxNCR48cdAiaMU0gYfxgmmYn79HRsAk/HObcZsWlcQei/cBr34q
	jXXMXRtInm7JNvUwspxjtnSQb+XNxW7Iq9+S3tsNXcUEh0fIgcrAQZNu3GnSr4sWgcExx/cYODc
	hgUo+u5Y/aro7qml/stYPT2L6td0=
X-Gm-Gg: ASbGncudvqn4RzoEjVNw7axKkbecSbvjXSS10Kjq96ZRhLha60z+h0Q7aFFcO0fxcNg
	oZ0z5byUS3qsURxm9QYajejBrvYzJexecJAlTDeIwqUzKwFrERXn8eFz78oMDrTgkijZP64W+5B
	UZH82lZ00Fez5FT0bpzgEZgts7qmdfG8taa8u1OLLH4otZP9fGqk3DDWw+SWWa
X-Google-Smtp-Source: AGHT+IGyBV9m3L4w8t2OrUSMAwxoyxvAW/4fi81XmciRP3/5Az2O5GNUknnICX9axlKWv4h/L/9eWm6e7JTJiZoyVC4=
X-Received: by 2002:a05:651c:a0b:b0:30b:d562:c154 with SMTP id
 38308e7fff4ca-30c4a875fe6mr14747691fa.19.1741990895355; Fri, 14 Mar 2025
 15:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
 <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com> <D8G9LZCS7ETL.9UPPQ73CAUQM@proton.me>
 <CANiq72=JCgdmd+h4_2VguOO9kxdx3OuTqUmpLix3mTLLHLKbZw@mail.gmail.com>
In-Reply-To: <CANiq72=JCgdmd+h4_2VguOO9kxdx3OuTqUmpLix3mTLLHLKbZw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Mar 2025 18:20:59 -0400
X-Gm-Features: AQ5f1Jp7KldemuJS7KUxPUxPs7sBfWHcTu3t4bd_hn0YFX45gGFgXjsgYG75HQw
Message-ID: <CAJ-ks9=Ec0xLg81GUYJ07uDzwtwhFkoEdxaa3kNtV6xSjZ57MQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] rust: use strict provenance APIs
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Masahiro Yamada <masahiroy@kernel.org>, 
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

On Fri, Mar 14, 2025 at 6:00=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Mar 14, 2025 at 9:18=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
> >
> > I don't know when we'll be bumping the minimum version. IIRC 1.85.0 is
> > going to be in debian trixie, so eventually we could bump it to that,
> > but I'm not sure what the time frame will be for that.
> >
> > Maybe we can salvage this effort by gating both the lint and the
> > unstable features on the versions where it works? @Miguel, what's your
> > opinion?
> >
> > We could even make it simple, requiring 1.84 and not bothering with the
> > older versions.
>
> Regarding Debian Trixie: unknown, since my understanding is that it
> does not have a release date yet, but apparently mid May is the Hard
> Freeze and then it may take e.g. a month or two to the release.
>
> And when it releases, we may want to wait a while before bumping it,
> depending on how much time has passed since Rust 1.85.0 and depending
> on whether we managed to get e.g. Ubuntu LTSs to provide a versioned
> package etc.
>
> If something simple works, then let's just go for that -- we do not
> care too much about older versions for linting purposes, since people
> should be testing with the latest stable too anyway.

It's not going to be simple because `rust_common_flags` is defined
before the config is read, which means I'll have to sprinkle
conditional logic in even more places to enable the lints.

The most minimal version of this patch would drop all the build system
changes and just have conditionally compiled polyfills for the strict
provenance APIs. Are folks OK with that?

