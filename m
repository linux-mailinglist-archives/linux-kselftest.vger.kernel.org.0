Return-Path: <linux-kselftest+bounces-29707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E5AA6E5ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C1916FA98
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 21:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368761EA7E3;
	Mon, 24 Mar 2025 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jujO5eke"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580DF19004B;
	Mon, 24 Mar 2025 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853319; cv=none; b=qDdJpSAuXx/RwBIgq1Hl8kNb2ayfMEfVrKnx38T4aOK8713ZH1FYrrsVVwA1kDwyqDi5nkRzLjJ2lbigW7p/qN1wtF436Y8apmNQfy0evMOonH6tkAGqIy63TafAbK+hysYoBpcpfFGOHKDiPFQa3wDjuNVYmL4rj8Zo5imog24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853319; c=relaxed/simple;
	bh=Mk+Jy6obczSsui9N2w3+mWKRdKV4LQx0AozKVOgq7mk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qwf1CQU8+P7r0GwyBTtT/HQmnd1K25tijqhhPvlJZvY54DUkoX+YAQX9viblhDY4eb6sUpCIpofKfMy4TCzrnjRJkH1yGjG+NnEppVSs+S1DzStSPTFJRVAGztamuO07PZX60mZ0zjYx/dk+o6HIvX1mFhNyf/LhMmUp25IH8aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jujO5eke; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=vr34gjp32bbrfloqgpbh4zscjy.protonmail; t=1742853315; x=1743112515;
	bh=jFlgYtTgaApXQf15gVtlBflG0q/Na55R6gwEZA69CjA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=jujO5ekeV6TdqaqwWNW0m7TsTWb8+ZHaeyd3batFMxSxe1mB47NFgEAjqFFb4lnWp
	 P6H2xKPSToHyYW+vJQf216tgFYDWq+pze9nIZZznwdyYIXkZH7BRIYHby1uxPChxbV
	 vXkYB2unjO6dFG8BrXcSdac3h64lxmlwdCAsFywzpus8bh2GqqGmZnQPgigrvTWOLL
	 2DY1B/iVUiaone/7bUvYjc9DntSnZ4zE68W52o2OE/YiJwEMWjilnKFnI3wNi509M5
	 Mj094BfNUykEl5pKhzPJ/6k1lhqU6TCrzhi1FW4A89SVGts1Vai8zAy65Fnf/Mk4Dd
	 1Ob2S4MERWgxQ==
Date: Mon, 24 Mar 2025 21:55:08 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/6] rust: reduce pointer casts, enable related lints
Message-ID: <D8OTXLDQCOKI.34R1U5R0JSB8H@proton.me>
In-Reply-To: <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com> <D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me> <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 256a1e146cdbaffd9f65f108c66cb871b36ed6b0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 24, 2025 at 9:55 PM CET, Tamir Duberstein wrote:
> On Mon, Mar 24, 2025 at 4:16=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>> * `shared_ref as *const _` (for example in rust/kernel/uaccess.rs:247,
>>   rust/kernel/str.rs:32 and rust/kernel/fs/file.rs:367), these we can
>>   replace with `let ptr: *const ... =3D shared_ref;`. Don't know if ther=
e
>>   is a clippy lint for this.
>
> I think there's not a focused one. There's a nuclear option:
> https://rust-lang.github.io/rust-clippy/master/index.html?levels=3Dallow#=
as_conversions

Yeah I saw that one, I don't think it's a good idea, since there will be
false positives.

>> * some pointer casts in rust/kernel/list/impl_list_item_mod.rs:{253,254}
>>   not sure if they can be converted though (maybe they are unsizing the
>>   pointer?)
>
> I have a local series that gets rid of these by doing similar things
> to https://lore.kernel.org/all/20250307-no-offset-v1-0-0c728f63b69c@gmail=
.com/.
> I can send it later this week but it probably can't land until Alice
> is back from vacation; she was the author of this code.

No worries, as I wrote below, I think it's fine to do that in a new
series.

>>   Another pointer cast in rust/kernel/driver.rs:81 (I'm pretty sure this
>>   one can be replaced by a `.cast()`)
>>
>> Some clippy lints that we could also enable that share the spirit of
>> this series:
>>
>> * `char_lit_as_u8` (maybe that also covers the `'|' as u32` case from
>>   above?)
>
> It's already enabled, it's warn-by-default.

Ah I see, didn't look :)

>> * `cast_lossless` (maybe this catches some of the `num as int_type`
>>   conversions I mentioned above)
>
> Yeah, suggested the same above. I had hoped this would deal with the
> char as u32 pattern but it did not.

Aw that's a shame. Maybe we should create a clippy issue for that,
thoughts?

>> I'll leave it up to you what you want to do with this: add it to this
>> series, make a new one, or let someone else handle it. If you don't want
>> to handle it, let me know, then I'll create a good-first-issue :)
>
> I'll add a patch for `cast_lossless` -- the rest should probably go
> into an issue.

Do you mind filing the issue? Then you can decide yourself what you want
to do yourself vs what you want to leave for others. Feel free to copy
from my mail summary.

Also I wouldn't mark it as a good-first-issue yet, since it's pretty
complicated and needs to be delayed/based on this series.

---
Cheers,
Benno


