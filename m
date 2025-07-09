Return-Path: <linux-kselftest+bounces-36893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 148ECAFF431
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 23:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0514E541A88
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 21:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7F123B62C;
	Wed,  9 Jul 2025 21:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF7v+HHj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDBF221DB4;
	Wed,  9 Jul 2025 21:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098309; cv=none; b=f8IRrXrsUzp4OznqcmoFnBSXTQQ3BF7//HrXxRx2v0IpIuq+LzIlkyTw1vJtSoztFZIfmd0ytSt6tDxxlarQUI7leXRJj2GatgKa707n/dlIhJg5CGBOYnLskQLbonMnnWyadMslZ5XMfygXTPCKygGcnTYkHxjTFTwtENX2yZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098309; c=relaxed/simple;
	bh=zjFlENAgBdh7xP1fuuUD0RuYSpO5zOXpYVPNVEcU4zg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EG81XgAVH4X4DoJwxKRFMRwPhA0D/wmbz2NLI2+KOOhjhlFjyhEWKXe+FnRKr2xY6+WnNKoXbPAkrSzWi7PidF2Ug3IPlKXPogWuIu/cdQ9YGUeEY00mpkB8W26pNtmex97XAGNbvbLej/BpxMbjnwvNoyVa1T6sA0XYi2PFiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF7v+HHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C68C4CEEF;
	Wed,  9 Jul 2025 21:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752098308;
	bh=zjFlENAgBdh7xP1fuuUD0RuYSpO5zOXpYVPNVEcU4zg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=HF7v+HHj1/uWYrZ1jHPBmeinlOFXd700YJB/0ji8rRD5yDDGO2vc4Zmp3mIQ1eZrJ
	 dp32A945DkIzZftJkqzV/nrGFQPURiSIYC3nwMmCaWYInptJZsU9hjWMZTg+ay6gXe
	 P7m1scf30QQMKycBWbPTIpa4yEGP9Zu/McyS3TIIgvBJTmi9TMYJtnyo9iREx4G/LD
	 0qNjId+h+yzw3HhhgiXqsCKYA0O6XamG+OuGd2KI+D3jI3n8aHE9/hRLnryDnnBg84
	 zdQ0kiNXyPfZyNIyJPLJUlKCkSoc4ivbeUTyBJITG+QmdoSnpRXn/WztQ1n8dEf4SD
	 QndKJGpaSnYXA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 23:58:22 +0200
Message-Id: <DB7V0GL2HVMV.BR1JSWQPDMC3@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Jens Axboe" <axboe@kernel.dk>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Brendan Higgins" <brendan.higgins@linux.dev>, "David
 Gow" <davidgow@google.com>, "Rae Moar" <rmoar@google.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>
Subject: Re: [PATCH 7/9] rust: pin-init: use `kernel::{fmt,prelude::fmt!}`
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
 <20250709-core-cstr-fanout-1-v1-7-64308e7203fc@gmail.com>
 <DB7SVTBZ46QB.31WTHFLWDHPZY@kernel.org>
 <CAJ-ks9nNc_pThtb+gHUcjEnvR6V0RAEG0tkv+_DHYYjXs1N7=A@mail.gmail.com>
In-Reply-To: <CAJ-ks9nNc_pThtb+gHUcjEnvR6V0RAEG0tkv+_DHYYjXs1N7=A@mail.gmail.com>

On Wed Jul 9, 2025 at 11:01 PM CEST, Tamir Duberstein wrote:
> On Wed, Jul 9, 2025 at 4:18=E2=80=AFPM Benno Lossin <lossin@kernel.org> w=
rote:
>>
>> On Wed Jul 9, 2025 at 10:00 PM CEST, Tamir Duberstein wrote:
>> > Reduce coupling to implementation details of the formatting machinery =
by
>> > avoiding direct use for `core`'s formatting traits and macros.
>> >
>> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> > ---
>> >  rust/kernel/init.rs | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> I usually prefix patches to init.rs with `rust: init`. I'll fix it up
>> when picking the patch or Miguel can do it if he takes it:
>>
>> Acked-by: Benno Lossin <lossin@kernel.org>
>
> Actually, squinting at this patch more closely now, I think this isn't
> what you had in mind. The comment says "Dummy error that can be
> constructed outside the `kernel` crate." but the error now comes from
> the kernel crate :(

It's a re-export, so the comment still holds.

> Perhaps you could suggest a different modification that would both
> meet the original intent and allow references to core::fmt to
> disappear?

The code comes from a time when `Error::from_errno` was `pub(crate)`,
but that was changed some time ago... Now we can just remove the
`FromErrno` trait entirely from that example. Feel free to do that in
this series or as a standalone patch.

---
Cheers,
Benno

