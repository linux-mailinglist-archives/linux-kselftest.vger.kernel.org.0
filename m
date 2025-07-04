Return-Path: <linux-kselftest+bounces-36538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 509D7AF8F6A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 12:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EEAB7A7463
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 10:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161BF2ED86C;
	Fri,  4 Jul 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIFzhyDo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA112877C7;
	Fri,  4 Jul 2025 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623541; cv=none; b=SKmhhTy2nycJPZ7nFszWAZiFJarf70YCmeXcN+pOwvxH0vMKuoioFTDbQRpC5ncpfCRj0/NZ+ibd4qG5YbqrNp5A4GiBAgK1b67lOmx4IDpcils/5qwgN7+/hkeevOFroRt2y9WGXz5+na1gEz6BOAlcucpBD604As8EWtrVJD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623541; c=relaxed/simple;
	bh=3zMvBpnjYhXNk119LId6VxXRlohR+SMqHtEt+DjGgOs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Lw1FLW99xPWNr/qjic2EsDUo68wNQjAZq6pA+jWDO/bLp/oGaGiEwKpHmervEXwOmSI4KesNrU3KuCjHnH3rtFVwl+YwLRdS4sIEo/9ktlLjPuMm+uSD+pB0OPoQWRgaLgqLJuqRppZOdsWCZY+PyNzDLrwW1+rP5VarwAIpKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIFzhyDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8AFC4CEE3;
	Fri,  4 Jul 2025 10:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751623540;
	bh=3zMvBpnjYhXNk119LId6VxXRlohR+SMqHtEt+DjGgOs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=dIFzhyDoOtTAbxDe4ng7ZMrO/97heBHHA2tlOt/nH+8zNG51bHrYZPY5Otop9wkEE
	 GOrKb3MaWAOEqB12OvaklthhMEb5eZrWI0BPDhSMueKmloWwIpmrdhA574pgwdyDVL
	 5lRojgAt+uopNziY+Nbq2Vyar7Ow/l0OqQ3ieJWWl/vzootQhnKntCRzNGjWwagrXs
	 ZQVT86x9TMFgy9J6Lt1mMum6Y6ipYwyQeTLs74SvWohAan1nxvN+IidtlqAZw2lilc
	 nqy6gMPSSrHzKKMC7HAuqqW0Qh3uEfCRekMqt+80F1Dobu3rSHA5697iSIX1wfMM87
	 5aWiEaLuho2cA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Jul 2025 12:05:26 +0200
Message-Id: <DB36PVASJ5G9.2TMRXNIXYI9UO@kernel.org>
Cc: "Michal Rostecki" <vadorovsky@protonmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Brendan Higgins"
 <brendan.higgins@linux.dev>, "David Gow" <davidgow@google.com>, "Rae Moar"
 <rmoar@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Russ Weight"
 <russ.weight@linux.dev>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Rob Herring" <robh@kernel.org>, "Saravana Kannan" <saravanak@google.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Waiman Long" <longman@redhat.com>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Andrew Lunn" <andrew@lunn.ch>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Jens Axboe" <axboe@kernel.dk>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Dave
 Ertman" <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Breno Leitao" <leitao@debian.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <llvm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-block@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v13 2/5] rust: support formatting of foreign types
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-2-29f7d3eb97a6@gmail.com>
 <DB2BDSN1JH51.14ZZPETJORBC6@kernel.org>
 <CAJ-ks9nC=AyBPXRY3nJ0NuZvjFskzMcOkVNrBEfXD2hZ5uRntQ@mail.gmail.com>
 <DB2IJ9HBIM0W.3N0JVGKX558QI@kernel.org>
 <CAJ-ks9nF5+m+_bn0Pzi9yU0pw0TyN7Fs4x--mQ4ygyHz4A6hzg@mail.gmail.com>
 <DB2PIGAQHCJR.3BF8ZHECYH3KB@kernel.org>
 <CAJ-ks9=WmuXLJ6KkMEOP2jTvM_YBJO10SNsq0DU2J+_d4jp7qw@mail.gmail.com>
In-Reply-To: <CAJ-ks9=WmuXLJ6KkMEOP2jTvM_YBJO10SNsq0DU2J+_d4jp7qw@mail.gmail.com>

On Fri Jul 4, 2025 at 12:41 AM CEST, Tamir Duberstein wrote:
> On Thu, Jul 3, 2025 at 4:36=E2=80=AFPM Benno Lossin <lossin@kernel.org> w=
rote:
>> On Thu Jul 3, 2025 at 8:55 PM CEST, Tamir Duberstein wrote:
>> > On Thu, Jul 3, 2025 at 11:08=E2=80=AFAM Benno Lossin <lossin@kernel.or=
g> wrote:
>> >> On Thu Jul 3, 2025 at 3:55 PM CEST, Tamir Duberstein wrote:
>> >> > On Thu, Jul 3, 2025 at 5:32=E2=80=AFAM Benno Lossin <lossin@kernel.=
org> wrote:
>> >> >> On Tue Jul 1, 2025 at 6:49 PM CEST, Tamir Duberstein wrote:
>> >> >> > +impl<T: ?Sized + Display> fmt::Display for Adapter<&T> {
>> >> >> > +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>> >> >> > +        let Self(t) =3D self;
>> >> >> > +        Display::fmt(t, f)
>> >> >>
>> >> >> Why not `Display::fmt(&self.0, f)`?
>> >> >
>> >> > I like destructuring because it shows me that there's only one fiel=
d.
>> >> > With `self.0` I don't see that.
>> >>
>> >> And what is the benefit here?
>> >
>> > In general the benefit is that the method does not ignore some portion
>> > of `Self`. A method that uses `self.0` would not provoke a compiler
>> > error in case another field is added, while this form would.
>>
>> Yeah, but why would that change happen here? And even if it got another
>> field, why would that invalidate the impl of `fn fmt`?
>
> I don't know, but I would rather force a person to make that decision
> when they add another field rather than assume that such an addition
> wouldn't require changes here.

I don't think so. If this were in another file, then destructuring
might make sense if the struct could conceivably get more fields in the
future **and** it if the other file relied on there only being one
field (or if it *had* to be changed when there was a field added). This
isn't the case here so it's just unnecessary noise.

---
Cheers,
Benno

