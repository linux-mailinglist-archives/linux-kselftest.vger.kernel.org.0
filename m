Return-Path: <linux-kselftest+bounces-29141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4122A63136
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 19:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE407A92DA
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 18:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274AB18E05F;
	Sat, 15 Mar 2025 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YQBSNm5r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC3918EFD4
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Mar 2025 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742061661; cv=none; b=kZa75C5MUJ4Ndzu7qTn3OvxucPaeCUrK3VnAIAW2bZu9SfmgcmXPcGx1wG1xN/rnqyEmpg3NPQpBu1/JZGndjhebkfFo0t3x0e/xdQmLNSChIbYyL2mAREfJB4ukR/rY4rB1c9sFQUFI39Fx0bVdsSv+sAFq8+mni7NGtu0YpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742061661; c=relaxed/simple;
	bh=AQGvhnW+89joQbtnIYgMqzkrKefUsN/EBiBpxqMXD3M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6mQoDE+dhchrxROIzDimsAE3dGIidNYTcpJcccNwFmL0ZKBUhps0obYu2EoFTTnHUN+sHdT/xw/YNSIdtoJRMIuHGiWcZcxCGQbPdDSX0KknMkCpxLCM5cQvYKTvLkf7R6P21F7cI2y7fxSydK/wJ3NyCYW6ZuRnzcH3oq99kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YQBSNm5r; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742061656; x=1742320856;
	bh=AQGvhnW+89joQbtnIYgMqzkrKefUsN/EBiBpxqMXD3M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=YQBSNm5rm3zDSkda26bpQz4cz3kOmYU0eTl0lth9UKvCZXGjSGzd6PsjFfUKKMy3J
	 GrYoFmqDIXnYxh6q/bn2zQJdg3uA9rkmXmBHe5Tdyoc6rpYBojJlYDHrjGyIe2kR4t
	 +EZ56x1KZ+F86WXa1sZThE/dGYNe/VVb2Ba8ITYCCd32Obp+P9T8bKEoZyUsv9k2M8
	 ztNaBlLgOiveGrJphf+wqT8fq9AOcc2L/Iee/wIICoez++0FIyC7FUq8Kslmk+I8Lz
	 PA+VltRu0qSquuI4YM48XtMZvBm6we7E28qwveNZlP5uQZvUZT963yorq5xNXTFwVP
	 ch5qzW3cxAUmA==
Date: Sat, 15 Mar 2025 18:00:50 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/6] rust: use strict provenance APIs
Message-ID: <D8H1B8HT45UJ.OQ8N8YS92UL5@proton.me>
In-Reply-To: <Z9V0jSfuhqWi_t52@Mac.home>
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com> <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com> <67d4a57f.c80a0220.16ff45.9cf1@mx.google.com> <D8GQJQFGKB8C.DZBUZT4IJIM0@proton.me> <Z9V0jSfuhqWi_t52@Mac.home>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e83c3409294cafcbb4ff1e1cee286a3ff1c398c1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Mar 15, 2025 at 1:37 PM CET, Boqun Feng wrote:
> On Sat, Mar 15, 2025 at 09:34:42AM +0000, Benno Lossin wrote:
> [...]
>> > The rest Rust code changes look good to me. Although I would suggest y=
ou
>> > to split this patch into several patches: you can do the conversion fr=
om
>> > "as" pattern to provenance API one file by one file, and this make it
>> > easier for people to review. And after the conversions are done, you c=
an
>> > introduce the Makefile changes.
>>=20
>> I think it's fine to do several of the `as` conversions in a single
>
> Well, "fine" !=3D "recommended", right? ;-) If the patch was split,
> reviewers would be able to give Reviewed-by to individual patches that
> looks fine trivially. Then it's easier to make progress every iteration,
> and also allows partially applying the changes. Of course it doesn't
> have to be file-by-file.

While I see your point, in this case splitting file-by-file is too much.
v4 has: 9 files changed, 82 insertions(+), 27 deletions(-). I've seen
much bigger changes that do smaller things like this patch.

At around 150 lines added + deleted I find it more and more difficult.

---
Cheers,
Benno


