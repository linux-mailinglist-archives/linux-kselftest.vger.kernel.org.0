Return-Path: <linux-kselftest+bounces-29703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CC2A6E4CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 21:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5AA171788
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 20:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907511DD877;
	Mon, 24 Mar 2025 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJd5wJwZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614C1C84A7;
	Mon, 24 Mar 2025 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849754; cv=none; b=HH/iT4OltTYwKhbQegCcCQqKdBer8OpamiCUMItjvqnnYcpwEaq85XwW2Z7XKUBLliUNcJxgO09ljj0VterDENZLn+8+eE6PRABi6OKVlnmhP4LwpSwQyUqWsRRbLY3jzUvtWYqNhTED8N5hSHi7Znu/0WvXv27RRXdnRh1g1gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849754; c=relaxed/simple;
	bh=0RnhtgbzWG90TQe5/F2XubXbO7DIDjfDHmmIaPaPYz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjS5AKL7sstxqv2ZPPG/kOLPuNZzsTRJW0hpS2dyUR/X6mOlzKUkIST7JeUB3sVpR3LJ/gitvmXiJhTZHoYV7nY3cw78WyXtMZkrZOuaKsCePOblTTV5XUR/pYt5O5c2VLTP8BhMJrz0jC/c91Tx0ULj2cxYsDKKKgrM0qzNpUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJd5wJwZ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso816020866b.1;
        Mon, 24 Mar 2025 13:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742849751; x=1743454551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ffez8IsBwXAmSHTwfnCsyGV87mn33YEBcB54VdHd4jE=;
        b=QJd5wJwZ0tbtLEK2ekSWUfCRXq6FeZH1t5pDkumwBsKYmVJ4JZ5KeEZd0KevIXVLI1
         kjt4czkUdVxGkZOl444qUXQNOIhHbDK/18/jIFixOE7ZZ6Nm1pj3yAGZwNFf32ZPdu9q
         6JnoyR/6il7q+6czCBCRv8+WH7W5bZS9jV8Flj7GzlMnrrLLrY5ucUWdVGwdJlO/OTov
         N33Jh55GCJfsjD8kmyD9wqO+4zgILkkcwzA6LCmelNqoaFpJ3laic5KUgxuE4hiDXPvU
         zrvArC2V+x8TeKkdNVl6nGtX0Yhc/b0yNdLjsrKQByLF1Ug8OxEo3psFPQa7na0btuv/
         RC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849751; x=1743454551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ffez8IsBwXAmSHTwfnCsyGV87mn33YEBcB54VdHd4jE=;
        b=jFp08eTwoT/xpHYgsZldo2lCEsCNbtr7zMBb+aBb5CYldzX7EYjqZ8OQeivPplr1u9
         eItEs8rreZNQC7IsRSp6M/kgt+FJRITAUGnGuzLHSULueY2SuvfxLI+Cneaz/UNqQm9y
         0LJELlw3v5Eo9zhYBP2RtILu9G9oCWV1uYyA2rZhB+hwjpEPTd+xDLOtcnT3B8F90ADL
         SY9xDJ/me6YF7if/y3lrAgsLjUNqg/eYrw8oByi8jAuqXc9n4Os6jyMUtBp0Ba7paOeg
         idIbuUE6qNQhKwFQmf/KPu+vMWm3ugtujyJooBBTZpCR86f+4Oa/YJlq552xkBn8q6Bp
         W3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUCnAYibwWFM+8Vqf9c0MdC8wRQBZFtTGbuZ3PUGFqk5gG3RpnT792HWH4yyTiC2sbLILukR5Bkq/mfNHs0@vger.kernel.org, AJvYcCUIcRlXxbFNz4ztMHa8TZjziUmCVIKupbwTcrc9dCN3WoAE3pNlQ6p2Ud1gbBO9TQqkHjw+8K1An2ul078=@vger.kernel.org, AJvYcCUe8vifd69YSA7GAnJFcke4VRypkFoEXiqdUsL2zUlmJAjUK3ZGZ/jx4ob0t6jl4YCnC9Vc2DCcg3O1@vger.kernel.org, AJvYcCV+inHKgytJ1I7fAv98Fy8gNSblatViRC083wPbBMLz+0feWDpoGBttEYY8L8iC9QrlVi6wnLGgwzbz0c1Ss8QG@vger.kernel.org, AJvYcCV1P35GDYj8mVkht6/himR7aPPrNAg0zHwfOpyTlNBqpCvvyWdDIaNIkgnVW0woPxNMkmnCU0kpY3M5@vger.kernel.org, AJvYcCVr4yIDlEaoU1PKkxNuVBa5dUW4OZYrsgmkLfeLnPc5tXpx2qYoIwlVNLNrL0vU8h0dL2YoWKpmO5alJs/Z@vger.kernel.org, AJvYcCWRFCAGssD67ERI4y/njLLMUlLBwXkqqqKWULepvROmrZbj0nf9fY2JTM3Y9jmckg8kHrqmoQrRg1Gh2cUQfMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxFNuQ3JFk7fMS7Fw7U70eT0DQgXHECpCzNMnzUNTMTUapMChA
	YHEPrrZuDYnQ/WE1+YgWnRIhO7XcgT1tBGZAPulmjP+3yop/SNDvTI2enB41IEhd5oZHzOKFNNB
	yLZkc7GYyefEQN/tqembFhoDfMAE=
X-Gm-Gg: ASbGncsWT1cl2AOTnaU/GVPlpcDWQRxBzZmhzRCNBnB+8l6PChERG7SzHBuGBllpQJT
	fn2Hrz3JKzROGmJk5jTl8nXjgi/GKbE612pw5RZWrbKRCfoocr8/wHzZGKS8FrLP66pJJCk6LX0
	o4uIpUVqsxDi1l7lI3eHpUF+oX4zB1TzIcORZBOHzIVw==
X-Google-Smtp-Source: AGHT+IFeT1UyO/dId9MJzJXWNdAbKjDwWx1oex78KzDpAKkNNpKw/6i/iQ9Vzg6EpM5x9b9AJIfWe4OA1ifM9Bwkvms=
X-Received: by 2002:a17:906:d552:b0:ac3:1373:8a3d with SMTP id
 a640c23a62f3a-ac3f226dfc0mr1348738566b.20.1742849750503; Mon, 24 Mar 2025
 13:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com> <D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me>
In-Reply-To: <D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 16:55:11 -0400
X-Gm-Features: AQ5f1JpwAMSfzacQi9R58LlhLq7lrunQqMToRPSc7D3Wdlj2GhYLtvpMeTKPIOo
Message-ID: <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] rust: reduce pointer casts, enable related lints
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
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 4:16=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Mon Mar 17, 2025 at 3:23 PM CET, Tamir Duberstein wrote:
> > This started with a patch that enabled `clippy::ptr_as_ptr`. Benno
> > Lossin suggested I also look into `clippy::ptr_cast_constness` and I
> > discovered `clippy::as_ptr_cast_mut`. This series now enables all 3
> > lints. It also enables `clippy::as_underscore` which ensures other
> > pointer casts weren't missed. The first commit reduces the need for
> > pointer casts and is shared with another series[1].
> >
> > The final patch also enables pointer provenance lints and fixes
> > violations. See that commit message for details. The build system
> > portion of that commit is pretty messy but I couldn't find a better way
> > to convincingly ensure that these lints were applied globally.
> > Suggestions would be very welcome.
>
> I applied the patches to v6.14-rc7 and did a quick pass with
>
>     rg -nC 3 -t rust ' as ' | bat -l rust
>
> to see if there are any cases left that we could fix and I found a
> couple:
>
> * there are several cases of `number as int_type` (like `num as c_int`
>   or `my_u32 as usize` etc.) not sure what we can do about these, some
>   are probably unavoidable, but since the kernel doesn't support 16 bit
>   systems (that is true, right?), we *could* have a `From<u32> for
>   usize` impl...

Yeah, these are the most difficult ones to get rid of.

> * some instances of `'|' as u32` (samples/rust/rust_misc_device.rs:112).
>   There is a `From<char> for u32` impl, so this can just be replaced
>   with `.into()` (or maybe by using a byte literal `b'|'`?).

We can enable https://rust-lang.github.io/rust-clippy/master/index.html?lev=
els=3Dallow#cast_lossless
for this one.

> * `shared_ref as *const _` (for example in rust/kernel/uaccess.rs:247,
>   rust/kernel/str.rs:32 and rust/kernel/fs/file.rs:367), these we can
>   replace with `let ptr: *const ... =3D shared_ref;`. Don't know if there
>   is a clippy lint for this.

I think there's not a focused one. There's a nuclear option:
https://rust-lang.github.io/rust-clippy/master/index.html?levels=3Dallow#as=
_conversions

> * some pointer casts in rust/kernel/list/impl_list_item_mod.rs:{253,254}
>   not sure if they can be converted though (maybe they are unsizing the
>   pointer?)

I have a local series that gets rid of these by doing similar things
to https://lore.kernel.org/all/20250307-no-offset-v1-0-0c728f63b69c@gmail.c=
om/.
I can send it later this week but it probably can't land until Alice
is back from vacation; she was the author of this code.

>   Another pointer cast in rust/kernel/driver.rs:81 (I'm pretty sure this
>   one can be replaced by a `.cast()`)
>
> Some clippy lints that we could also enable that share the spirit of
> this series:
>
> * `char_lit_as_u8` (maybe that also covers the `'|' as u32` case from
>   above?)

It's already enabled, it's warn-by-default.

> * `cast_lossless` (maybe this catches some of the `num as int_type`
>   conversions I mentioned above)

Yeah, suggested the same above. I had hoped this would deal with the
char as u32 pattern but it did not.

> I'll leave it up to you what you want to do with this: add it to this
> series, make a new one, or let someone else handle it. If you don't want
> to handle it, let me know, then I'll create a good-first-issue :)

I'll add a patch for `cast_lossless` -- the rest should probably go
into an issue.

>
> > ---
> > Tamir Duberstein (6):
> >       rust: retain pointer mut-ness in `container_of!`
> >       rust: enable `clippy::ptr_as_ptr` lint
> >       rust: enable `clippy::ptr_cast_constness` lint
> >       rust: enable `clippy::as_ptr_cast_mut` lint
> >       rust: enable `clippy::as_underscore` lint
> >       rust: use strict provenance APIs
> >
> >  Makefile                               |   4 ++
> >  init/Kconfig                           |   3 +
> >  rust/bindings/lib.rs                   |   1 +
> >  rust/kernel/alloc.rs                   |   2 +-
> >  rust/kernel/alloc/allocator_test.rs    |   2 +-
> >  rust/kernel/alloc/kvec.rs              |   4 +-
> >  rust/kernel/block/mq/operations.rs     |   2 +-
> >  rust/kernel/block/mq/request.rs        |   7 +-
> >  rust/kernel/device.rs                  |   5 +-
> >  rust/kernel/device_id.rs               |   2 +-
> >  rust/kernel/devres.rs                  |  19 +++---
> >  rust/kernel/error.rs                   |   2 +-
> >  rust/kernel/firmware.rs                |   3 +-
> >  rust/kernel/fs/file.rs                 |   2 +-
> >  rust/kernel/io.rs                      |  16 ++---
> >  rust/kernel/kunit.rs                   |  15 ++---
> >  rust/kernel/lib.rs                     | 113 +++++++++++++++++++++++++=
+++++++-
> >  rust/kernel/list/impl_list_item_mod.rs |   2 +-
> >  rust/kernel/miscdevice.rs              |   2 +-
> >  rust/kernel/of.rs                      |   6 +-
> >  rust/kernel/pci.rs                     |  15 +++--
> >  rust/kernel/platform.rs                |   6 +-
> >  rust/kernel/print.rs                   |  11 ++--
> >  rust/kernel/rbtree.rs                  |  23 +++----
> >  rust/kernel/seq_file.rs                |   3 +-
> >  rust/kernel/str.rs                     |  18 ++----
> >  rust/kernel/sync/poll.rs               |   2 +-
> >  rust/kernel/uaccess.rs                 |  12 ++--
> >  rust/kernel/workqueue.rs               |  12 ++--
> >  rust/uapi/lib.rs                       |   1 +
> >  30 files changed, 218 insertions(+), 97 deletions(-)
> > ---
> > base-commit: 498f7ee4773f22924f00630136da8575f38954e8
>
> Btw I didn't find this commit anywhere I usually check, where is it
> from?

It was probably nowhere, a local frankenstein that included some fixes
from rust-fixes.

