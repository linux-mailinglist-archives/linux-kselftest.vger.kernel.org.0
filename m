Return-Path: <linux-kselftest+bounces-29799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B64A70DCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 00:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92E63BEAE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 23:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A3926A091;
	Tue, 25 Mar 2025 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF6cOrUD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F97E1991D2;
	Tue, 25 Mar 2025 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742946894; cv=none; b=Iwajw/j5Dz1xrRSXhoeFsgwafdW2S7bSuoIQVa5dTF5x7agtuUPAgOSlWxJ7q9K/d/YkmzBq+dgSg7N8gqlDwzoc3fSHTrX6vCTsgSNGJZS/lfJn18I+Vmgta5V+/ZNIJUpi3hn7Ya2PHWn6xc1uDJwhnAROVS4+8/UPGAwmQT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742946894; c=relaxed/simple;
	bh=6UqvdtaSd9bhr0j5Ur9aT8CLuyVb17CgSPoBEK250RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrDyPAkIe11Vu7xfKU51oQPFd/4sTGBTepCOx+bQsJUGr3SAic+OG2tNlZmqGvhfj6kIUHcIfkmqgpgYvSooBsomypGn+UbDRC54xjTki4p0g7Bs/m4qfE2OlzctSlJzw3m42ExXWfLuvI5H6zozHREG4LraundhfY4GdR5sduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bF6cOrUD; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-307bc125e2eso62693001fa.3;
        Tue, 25 Mar 2025 16:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742946890; x=1743551690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pB7DLVd4H6QiUxYIjx/2k/QTp6fyJCUONMOEFYG9jGU=;
        b=bF6cOrUDnRAqpqviqgd/KrsCoZu4z51+X9AJbg6XKus2ce8yKfc7qAqje6huX65ozr
         2Q+Rw70h7t3DhcvfvW44TeDGyPm4HqYIqEn+kJ8ehIWKv1SfoUW9slfnI7jNPkGN+bRC
         HFIAJaW+VrG9dcB7muCDyKjpTRZYHbD9j4SP2TX0wGmEh+Q7bcemLjOOneOLM/BKdLw5
         EzKQxLRFrW642l/DgY8eY+xh0tOSMRFwV7q+68YXA0vcwdvQk1JnB6wwolpp9VkYArNX
         O7ZEaEP8rkKEdWRLk69pPYwzWVFAk8kBG3y0f8otyRkBILr8TnuGEkvkbBTI1LG5UbFY
         oImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742946890; x=1743551690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pB7DLVd4H6QiUxYIjx/2k/QTp6fyJCUONMOEFYG9jGU=;
        b=A+U1jat49ARJ+XfnQCIJcge02Kbs3hshjKAYGpVFjJn/8MF9peQhXIq3rp+/sc2Ub+
         CYFcGjaZCAGTwG3ScNmcgukulv83U6FzhsvebyeohMqt4LpkyFQ33pHOHIzUKKES73EE
         8r/9ds6uhGHkzrb27CsrCvg1q55k3tmdoMu0YmAUAFaGZfopWKxmYo3/pWbKVx+EUty5
         OUzXNYASOYVWk60vCpczxs/NcnUu6wAMaRgJWCcLg/e2k84SfydwCOuwrRu+GepV6Rlx
         OaKzs59IKHxvxM1eXWwOnU7JgYxdjqbnkP9cToq4MRGQB/mbj3L/Ik+0YA387c3FmJgg
         TV9A==
X-Forwarded-Encrypted: i=1; AJvYcCUfWXZbQVoyCKfJUpmQh9UowLdNXfwkrbnXqe2mKa/Myp3qfua6kOJCt7A39zxj5Y3o84NLqZqvQiFzkxMhz449@vger.kernel.org, AJvYcCVn6fBme+UzhNMzWBgvCX/46pEW2UDFp7zTkAQyNnzjlpcX7ajXrn37EUP2VpUwGPOP4W2bzsV/3PeBhTgD3G4=@vger.kernel.org, AJvYcCWGTAeEWvY89C8y0Gsj8c4CDKgqYmg+FHt08wLVV0r21D8QolhjYijWLxe9DOh4FEX3msTPO2Z4hNJe@vger.kernel.org, AJvYcCWV5VoHkR0De/Hew/VeIuAKFFOVRmq87Tezw/oIpwSV1LYH/WlqBud4y2NY1DwFHjrH4NQJq1ZzkW2qC+Dc@vger.kernel.org, AJvYcCXSdf80h6cqH+Xc7/yj1TB3nBstdnV2Wz/1XIDLQgRrwCQeEqLEGWu1OztdVQVhuoaU6LxoeumD2dbfaL/a@vger.kernel.org, AJvYcCXUMnQUibP9OjbYGZ7brujmOXaaKym9PRbVWpgKLn3OwRoWComUFALf+4A7qPemVpr7a0wjZ9r1d4BMt3Y=@vger.kernel.org, AJvYcCXypfuw71q/ZJG+c+s8S9IC3Uj9UNxGlxGdi7qIRAklD8+GRIbzHWc5yAiVN0hg6rdzVPlcnDtQkyUP@vger.kernel.org, AJvYcCXzntfbImOQCidjwUU38axyfILk950Kdui6F3ysNRqArFUttbVTsWWc3RZvpv8KU8nKdLHEUm29@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7SId7TPAQledO/lsUGC3LC2hZMkhonhqbOfWthomifDQGRjlg
	iOYiHBDsKnU4NwXTY8AWs/08g7ASYN99H3AQdXEieUtMbDN6CCy+pnwTiAcA34xrH/3Go/3bub7
	YDv8H/XKgL84mTPIcvBnvohUxv7k=
X-Gm-Gg: ASbGncsd5KU/Az8Zjei/EG8Lqkth3znd4SqhK95YJjCkpDC9iiuyQFIVFnXoxhomR/h
	pQgWCe3Oih0xhHIs1o+FMIdW/AOAyznvprdJwUEBOFSYhOClBqP7vb9DTup+U3BsqYz4zlzKEY/
	pzzcmJQhZxr9YVQedZdUoIRcMRrqQms4ikAPcJBKPKXQgtNYkdn4Ok82GLtF3u
X-Google-Smtp-Source: AGHT+IEg1mlV1KCvvMCOJZ2ohnF8J2y7cC9+rBdT4VizZQCJYeiV1bsXLR4jAOajsN9bSIhV3DiNsWgYsqG+SYPmsOQ=
X-Received: by 2002:a2e:be1f:0:b0:30d:b216:ef0e with SMTP id
 38308e7fff4ca-30db216f00cmr15397781fa.17.1742946890132; Tue, 25 Mar 2025
 16:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
 <20250325-ptr-as-ptr-v7-7-87ab452147b9@gmail.com> <D8POWLFKWABG.37BVXN2QCL8MP@proton.me>
 <CAJ-ks9mUYw4FEJQfmDrHHt0oMy256jhp7qZ-CHp6R5c_sOCD4w@mail.gmail.com> <D8PPIYIJCNX8.13VPQULEI0ALN@proton.me>
In-Reply-To: <D8PPIYIJCNX8.13VPQULEI0ALN@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 19:54:14 -0400
X-Gm-Features: AQ5f1JrqN1yE_LZiN0APCcG96GfKe6UILX465X2ULhw-kc5Avbv5dHlRP2RM1po
Message-ID: <CAJ-ks9k6220j6CQSOF4TDrgY9qq4PfV9uaMXz1Qk4m=eeSr5Ag@mail.gmail.com>
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

On Tue, Mar 25, 2025 at 6:40=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Tue Mar 25, 2025 at 11:33 PM CET, Tamir Duberstein wrote:
> > On Tue, Mar 25, 2025 at 6:11=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> On Tue Mar 25, 2025 at 9:07 PM CET, Tamir Duberstein wrote:
> >> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> >> > index 40034f77fc2f..6233af50bab7 100644
> >> > --- a/rust/kernel/str.rs
> >> > +++ b/rust/kernel/str.rs
> >> > @@ -29,7 +29,7 @@ pub const fn is_empty(&self) -> bool {
> >> >      #[inline]
> >> >      pub const fn from_bytes(bytes: &[u8]) -> &Self {
> >> >          // SAFETY: `BStr` is transparent to `[u8]`.
> >> > -        unsafe { &*(bytes as *const [u8] as *const BStr) }
> >> > +        unsafe { &*(core::mem::transmute::<*const [u8], *const Self=
>(bytes)) }
> >>
> >> Hmm I'm not sure about using `transmute` here. Yes the types are
> >> transparent, but I don't think that we should use it here.
> >
> > What's your suggestion? I initially tried
> >
> > let bytes: *const [u8] =3D bytes;
> > unsafe { &*bytes.cast() }
> >
> > but that doesn't compile because of the implicit Sized bound on pointer=
::cast.
>
> This is AFAIK one of the only places where we cannot get rid of the `as`
> cast. So:
>
>     let bytes: *const [u8] =3D bytes;
>     // CAST: `BStr` transparently wraps `[u8]`.
>     let bytes =3D bytes as *const BStr;
>     // SAFETY: `bytes` is derived from a reference.
>     unsafe { &*bytes }
>
> IMO a `transmute` is worse than an `as` cast :)

Hmm, looking at this again we can just transmute ref-to-ref and avoid
pointers entirely. We're already doing that in
`CStr::from_bytes_with_nul_unchecked`

Why is transmute worse than an `as` cast?

