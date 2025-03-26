Return-Path: <linux-kselftest+bounces-29837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0155BA7202D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 21:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C7F16AE80
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 20:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DD525DCE9;
	Wed, 26 Mar 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THEgUqLI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A771F4736;
	Wed, 26 Mar 2025 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022080; cv=none; b=U8xfZoxCp7IJhBEYBvesziNSAnxPxdVSIpJ/axHduH1AonJmaiUJ6Y0/XvDvgxTMlbVX60+UqAuzk3CBMsMVwYIJnWFcAPqK4fB6skoIOvLeyxp2KT6H+UJ32pBJbK5pDeZ1KZhHhs4Sfq8Tv3Ti9gOfr3a580rzUGNK5L0a9io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022080; c=relaxed/simple;
	bh=MNs4I+VY96qzVEnIeAX0i56gaLKwfzD5slXgEMkegvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdCA1nPtHIMMQP68Rj7iCUFE/6/5ISiT3NB23ND73FbqLzPUHmHHRdmJUNZeEfhZAXthjbOq1g0qxQOeqJUVeqTKZmSqh8Zhi/oICOCe/UjzxYTn4LhFDnw30/EhwQU9dmMahDYyD7Ugdjywd5ISH/CVr89l3L6Kq0F58HqxqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THEgUqLI; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30db2c2c609so3652721fa.3;
        Wed, 26 Mar 2025 13:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743022076; x=1743626876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNs4I+VY96qzVEnIeAX0i56gaLKwfzD5slXgEMkegvA=;
        b=THEgUqLI7P3WLNpNoxFiAPfOXJcmdi3DS4SjIS322Vxyf/8iFVTbDeAAgv4wpSh/Mx
         R0v5hUCPQqcbwcm0uRU/CQgi7g+CFq2lcZz/ZWTOkG2KmsQIMrg4ybDg7qCAxi1ixMZs
         yGGqIti/Ee8MafwN1cZVL9unlZXqwbHqeG2ls+/H0WJKh5FTIBeIrRUlLzYxF7NYsMAm
         96RorEGB/aSYlQeBKLl4q3cuLNEcHDK0sI7Vz4J7fROLKxYtBAq8Mn+i7QUZPogL9RHT
         t2rFpONtuRQUfN55Z6CyfdtM8l7NB0y9U2HkuvDSPKHIaZgeJdyxjhpN0czjMxnYbHOG
         9/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743022076; x=1743626876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNs4I+VY96qzVEnIeAX0i56gaLKwfzD5slXgEMkegvA=;
        b=mSH1GiGrMq4Y9nroCugSLGsUUIQOHGjzRNRx5+JSYbs7D1FzdvC4vfhXjZ24H5MFUP
         Cn95M7QROTBM91w5+3hMWmsmX+dR+/QUl5UdLaWPUFkEEj5nAtsPOy4sEAz99UEGhZPH
         oiP8zIsFnTcy7K2CX8RKmCF0hUZ9pfVI3ZGA9bEHdpI5vSaGqiiQHlo7YmM8xmEMYVV2
         yy1NrzxGaVZmS/am/6z9NdRsuZIPx1YuFQOGMvosVF6IJuIPaPYwdf6HtzDH+PQ5ENms
         VkiyvTKv9OCpTV1dNmpuIeq/bw1LcM07gP9+03ch1wYZczt2gpzVKwo3+FjzSoGj+wS6
         716A==
X-Forwarded-Encrypted: i=1; AJvYcCVX7wDb0k+9UbHqeIfLZ+v783lpCCrclgHJPUhn16xDJ1Emkxrzrr2nJDxy3ZrcaEjR12DLEIeDFXYkjPs0@vger.kernel.org, AJvYcCVds0dFwiQuQ9p0g0cLlv7BvOWOizFdusnPotpeU1yhYBdbWx4DoLQDLiHBSI22XJTneemZE/6thi9LDUT7Gh63@vger.kernel.org, AJvYcCVtFev2SNSfrsx9Snosb1CM3kOOoEzfPqyPgGRosFubMnWzM52smEflArhetxF74UtMq/8/GtQD@vger.kernel.org, AJvYcCXCDSkkRXkDxR+lzY5JJSnmC4u+zPUnQ7pMWPCf0WXhP+LotfXqAJNjT/J8cFdknyOguKSOLZ1NWE6r@vger.kernel.org, AJvYcCXM1I8ztHVDeJiy7yeto093/XRtV862ppqfegVuhCuNJDihw+WbgwIn0SOhmqp+pwOuaCI63IG+DCX3ekc=@vger.kernel.org, AJvYcCXUKD7XDNtUcIUPmUCRo1v9+GEyA2lpkbiBLffJgTWyNs+Gi7b3T47hKqEgZRvK5KkTwyi9kPq388YSuqRnlaU=@vger.kernel.org, AJvYcCXUwPchoJyDsxceTkf2TkfgnyMZFEif838pwEH5RnfyDFgAk+p7HtYplau43KR189ud0yzuPTmr/QtPL7F1@vger.kernel.org, AJvYcCXwdZAkCgkvKVTrH6wgT4/xBdxEDg/YmNKjAiS29QmgQlRBhTSbhoYfKRcOyj++wJfiBNNbTqoTwiJ6@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmqywuzrrVdgeVi1/mN6lkJOEdUuxwxdRRtXBFLKzDjfTweV0
	tyYjO04S+OiquYCeqon6YlOm9jX1dxr8zJo8dJRhXC8cF5USrBUaF9MC7yx9yIlK2UfBH3+m1WB
	j93GhRIozDkI5djBZcMBdrF3lySI=
X-Gm-Gg: ASbGncsrVOj4pgQxjqa8TxO1qMZxO17w2eS9NmLy9PaULsh9HzTMyqTqZuwbdOLpvJv
	Y6K1MjJWmHBKVnCwr9275BkIvskoQodHCmRyoPSnuprq4NYZjbApl8GHuomuuIDM4GzzrVv/v6P
	u2dE5xz/bnFgRDhO3rnAmmw5bmQtCFfWaxGP/X6s1HHQ==
X-Google-Smtp-Source: AGHT+IFTkL17Jc/5tc+lwRysHk8MME6mG/fwpKugvVpwwiEAGHYsBQsULAH9u2w5eS9UmGc0jzIZJK6sghNVKBbuAwc=
X-Received: by 2002:a2e:988c:0:b0:30c:177c:9e64 with SMTP id
 38308e7fff4ca-30dc5f4fc1cmr4487501fa.35.1743022076074; Wed, 26 Mar 2025
 13:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
 <20250325-ptr-as-ptr-v7-7-87ab452147b9@gmail.com> <D8POWLFKWABG.37BVXN2QCL8MP@proton.me>
 <CAJ-ks9mUYw4FEJQfmDrHHt0oMy256jhp7qZ-CHp6R5c_sOCD4w@mail.gmail.com>
 <D8PPIYIJCNX8.13VPQULEI0ALN@proton.me> <CAJ-ks9k6220j6CQSOF4TDrgY9qq4PfV9uaMXz1Qk4m=eeSr5Ag@mail.gmail.com>
 <D8Q4MSXXZ7OI.1NC226MO02VSN@proton.me> <CAJ-ks9nHKpQPuSBypXTSATYhbAFkQTJzUq8jN0nu4t=Kw+0xxg@mail.gmail.com>
 <D8QCK3CQES3Y.3LTZ4MVO5B3KT@proton.me> <CAJ-ks9nKT2PUDm6=b4AB1QUWwwvcqPn7Vz60=c0B+uFMZrqPew@mail.gmail.com>
 <D8QDOBUM6NF0.CGJY7ZA5KD9S@proton.me> <CAJ-ks9ntTxBM=c5nUZWGv3MoRt-LveBchn-c1Xy-DGap7fLVRA@mail.gmail.com>
In-Reply-To: <CAJ-ks9ntTxBM=c5nUZWGv3MoRt-LveBchn-c1Xy-DGap7fLVRA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 26 Mar 2025 16:47:20 -0400
X-Gm-Features: AQ5f1JpxZvv_0238pnS7OYKOrg_jP5CAtUULUrbnzS777StxjTzB1jEvV5C3tbs
Message-ID: <CAJ-ks9=dgQE_UF--Kv0HVTF_d1JzqK1gMoeE8GO8EGVtM-yt_Q@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] rust: enable `clippy::ref_as_ptr` lint
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
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 3:06=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Wed, Mar 26, 2025 at 1:36=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
> >
> > On Wed Mar 26, 2025 at 5:57 PM CET, Tamir Duberstein wrote:
> > >
> > >
> > > In the current code you're looking at, yes. But in the code I have
> > > locally I'm transmuting `[u8]` to `BStr`. See my earlier reply where =
I
> > > said "Hmm, looking at this again we can just transmute ref-to-ref and
> > > avoid pointers entirely. We're already doing that in
> > > `CStr::from_bytes_with_nul_unchecked`".
> >
> > `CStr::from_bytes_with_nul_unchecked` does the transmute with
> > references. That is a usage that the docs of `transmute` explicitly
> > recommend to change to an `as` cast [1].
>
> RIght. That guidance was written in 2016
> (https://github.com/rust-lang/rust/pull/34609) and doesn't present any
> rationale for `as` casts being preferred to transmute. I posted a
> comment in the most relevant issue I could find:
> https://github.com/rust-lang/rust/issues/34249#issuecomment-2755316610.
>
> > No idea about provenance still.
>
> Well that's not surprising, nobody was thinking about provenance in
> 2016. But I really don't think we should blindly follow the advice in
> this case. It doesn't make an iota of sense to me - does it make sense
> to you?
>
> >
> > [1]: https://doc.rust-lang.org/std/mem/fn.transmute.html#alternatives
> >
> > >> I tried to find some existing issues about the topic and found that
> > >> there exists a clippy lint `transmute_ptr_to_ptr`. There is an issue
> > >> asking for a better justification [1] and it seems like nobody provi=
ded
> > >> one there. Maybe we should ask the opsem team what happens to proven=
ance
> > >> when transmuting?
> > >
> > > Yeah, we should do this - but again: not relevant in this discussion.
> >
> > I think it's pretty relevant.
>
> It's not relevant because we're no longer talking about transmuting
> pointer to pointer. The two options are:
> 1. transmute reference to reference.
> 2. coerce reference to pointer, `as` cast pointer to pointer (triggers
> `ptr_as_ptr`), reborrow pointer to reference.
>
> If anyone can help me understand why (2) is better than (1), I'd
> certainly appreciate it.

Turns out there's a tortured past even in the standard library. In
2017 someone replaces trasmutes with pointer casts:

https://github.com/rust-lang/rust/commit/2633b85ab2c89822d2c227fc9e81c6ec1c=
0ed9b6

In 2020 someone changes it back to transmute:

https://github.com/rust-lang/rust/pull/75157/files

See also https://github.com/rust-lang/rust/pull/34609#issuecomment-23055987=
1
which makes my point better than I have, particularly this snippet:
"In addition, casting through raw pointers removes the check that both
types have the same size that transmute does provide.".

