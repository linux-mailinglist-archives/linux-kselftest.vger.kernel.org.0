Return-Path: <linux-kselftest+bounces-29231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB24A654CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 16:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F271889A4F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 15:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D82459E0;
	Mon, 17 Mar 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XNbAaFS7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8971C23FC7A;
	Mon, 17 Mar 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223637; cv=none; b=BuebLL/DUDrDG8HEDz1Xx0o5okow9cVEXNIa9pyylWTHu5CV+/H/KAiykzPpzuEoju9F/kGGvb3FjQbpGt62i4pshvPneNkevNex5Tv8XOXtifnL1mCqQPMkZ/ZItdqScYVDXjtS4pfEO0vHh8SprvWGL9BIdvlxrbW8EUR7Loc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223637; c=relaxed/simple;
	bh=cWkQsoSV/IZUx6NDHHMXi0u9x4VMUdLI8PhyNjOqZn8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JV5y3UA80cx1M63MG+m2FT272c3tBq3Yek0ZAQPiKQclzfP6/hk3Ow6fOW5HuV1LllKqbeoajTv1pQjqUkj8KOZ3Tequ+h/uILmwmAGqJuGxeMjnTDyVJ7ZaY4Zxv5A1BJTfC+iStxZK14M68eDO71IomQgtWTbJaLwLekDLglE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XNbAaFS7; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742223633; x=1742482833;
	bh=2jV32eFqRje1RzHN9WgvrVAw0d//cFd065kmoy6q4vw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=XNbAaFS7YmwSZSS6lTWs9g7U1K2XAtOZg0C3sK6ueUvAmr5BtDZj6IQw9+J5RQFQq
	 FHsYc/2HGxesqxq1sChqL1n9z39vsXSbe9A1oli5+l+98nhgSKu1hB+JWtrwtN0MYI
	 6onS600ofo+EkmZ4cAx7SuZAAYDxmTUFBmU+5eai6rRlrjX6EGgXArKDRcpVws3HDt
	 yPvoV+A8wpCBfL3rDCa/mHpwj+FhDF7Ss3FEphgevmybLuJICw+ln3azmKqu89SeZ0
	 /38zZWgOwlOLNn+7cdlWir3HndGMSX7/hNc8SRYODtPSlIr9HJFCvJL/hLGEmti3BG
	 qUEqifVlTV5ww==
Date: Mon, 17 Mar 2025 15:00:26 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 6/6] rust: use strict provenance APIs
Message-ID: <D8IMQ8OEOMAG.1AFKGZJ1C4DGQ@proton.me>
In-Reply-To: <CAJ-ks9kH3SE91XSadBx1qFaG5dem93o_ctR0t2FwW-0ZfkRNwQ@mail.gmail.com>
References: <20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com> <20250315-ptr-as-ptr-v4-6-b2d72c14dc26@gmail.com> <D8IFS7175NNQ.3VAP8WA2QC8WF@proton.me> <CAJ-ks9mXzM6D++vq0QCugaFOS9ES0j7GpeWZqckY0dA3JwpnJw@mail.gmail.com> <CAJ-ks9kH3SE91XSadBx1qFaG5dem93o_ctR0t2FwW-0ZfkRNwQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6436172b8e08da928624aeaa38482e05181d7d0f
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 3:13 PM CET, Tamir Duberstein wrote:
> On Mon, Mar 17, 2025 at 6:53=E2=80=AFAM Tamir Duberstein <tamird@gmail.co=
m> wrote:
>>
>> On Mon, Mar 17, 2025 at 5:34=E2=80=AFAM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>> >
>> > > +    pub fn expose_provenance<T>(addr: *const T) -> usize {
>> > > +        addr.expose_provenance()
>> >
>> > Instead of having these stubs here, you can probably just do
>> >
>> >     pub use core::ptr::expose_provenance;
>>
>> This doesn't work for the methods on primitives, but it works for the
>> free functions. Done.
>
> Have to revert this, writing `pub use ...` directly causes the MSRV
> clippy lint to fire at the caller.

Ah that is unfortunate.

---
Cheers,
Benno


