Return-Path: <linux-kselftest+bounces-29461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC6A69A21
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 21:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D4B3BA10A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 20:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0368B2147EE;
	Wed, 19 Mar 2025 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOcsB9UH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7A833985;
	Wed, 19 Mar 2025 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415651; cv=none; b=FYxCA5RZDfztpWeK1c+JU6YSNFK0PW5oZzfMXEYJu5uQN6hSpWDec2+iaZQPxLaKzGrNQ8kd7gq4ml8NoHCMbvOle/GoCxW3eH8Skr/af7XfhkmfVIlmQ4I8KVa6ZJvT/TtXSQf2VKEhq9ZRU6pdCVMznwyZYtOI9aw/cEldaiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415651; c=relaxed/simple;
	bh=002f+4uoU2jAzQ8fIJTcrT3A6Won1FJocd/oQjk/WsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8b272J9/7dzGHH6fs+/2ysKn4oZjR3hPk6s018U5zlCH9idiScXIurIQB+9m7MR4F0uvJL88wIwfqLKCmuMZ04D0rOsfmApvZKMmibicCxOQVEI5gU5HkKP3VzqGf8nx8XvEaTEmjZJKWZhftDCMQGYDldq1aeGNCn3rXhH/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOcsB9UH; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so968281fa.2;
        Wed, 19 Mar 2025 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742415648; x=1743020448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RMz3OhYmmgIWvTrdMzMOF6kyB3hj4Bx7wWY3SfBibE=;
        b=VOcsB9UH4s1DVKF5CEzuQkEVAMRn4YDziEThC0pDMULRoP5N9zKdr+VDSdXlMZizRt
         9SkRw3r2Vb/7fDUoHIPMI1Wmm/kvorzP4Ev/r0lmJr1/Cy6UrlmGa6ZPWpUmb3twW9Xr
         NU9SnqGFQIAdj2rB5NbHWuxX7ETufk+7xMSU/kU3Tqpr5QqwV4Dwp/9C5l/y5vVEMwuC
         kBYIyg4XFG8a8MBAh+tMKcOW8gzJDPOBUTkW+tfiEEkqDojvJE1MZXskyfSPe/9dYKMG
         uIqYJD10DfPAgpiXKd2ADj4iuxKVMT+CzuKRTSUa7jTDrJA/Yblok0iK53LNKUIXAzfF
         vN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742415648; x=1743020448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RMz3OhYmmgIWvTrdMzMOF6kyB3hj4Bx7wWY3SfBibE=;
        b=BxGkvxbty6PiZhz2Uu+K+QDyo1zE5ceJxGp50uuovN+F3bhwyPpQNBHEf8XAQI7wm6
         k1Mjpa6bBeJUG4jSqbtVZLqp3sM/TzjxJHU2qzn2oi7yD7UkvT4v5g5a4qjHICbZHdPk
         w8cgDIuDnJZYpwT2j81/a8gQg3muSH2b+cuzlWoai6gJTxXsoeixzV/eRT2v9qjIEL1m
         d75QOArjmTGEmqRnz0P6gQTdzFOgbhUFshlR6nQuDnzYRw6fTryz+AHL0DJHUlwgZX0v
         9UXXFGKTj+ontiRtx+ybmKQr3skQN4JtpQB2cGL9G8quC0bKqM+LYPgksJbC9OSgbagQ
         nOsg==
X-Forwarded-Encrypted: i=1; AJvYcCUaDwL4Yv+9YviYCD/gh6BAPjobilec8F5XcznBswEqIiqTMNRS/1Ej6MZ33K2OlgPLmcW25k7kIe6BGCA=@vger.kernel.org, AJvYcCVoTrIoG3uVyPFtOTEj3ToTwhaLQTb9sywXLap+776mdQHJir+s8T9gk4pJe+9eYmiSVdPczR4/ZK7+kIJq@vger.kernel.org, AJvYcCWkJ/vNXbVB9vlaGLRX7cZs9VRNkCqqFD354rGXm+JeRp4UK17ONWQiKsquzHTzSW20DQHx7AZqXNtgD6opP3Oc@vger.kernel.org, AJvYcCWlbdyNAriE6iHRY6dsnFoslXUsQz2mWLcwDZ2AYRWg0n/CqwvvgPREcBHnwQynYtzzB13/VjxpKYcK@vger.kernel.org, AJvYcCWx3jz5g2q4jhxCrgg9kEmNw2nHyQVnbuMSHYMTDgXf4YHEZY/8GIM8czihzw5IqJWEzQEjZtXfrlMs@vger.kernel.org, AJvYcCX1RW5xpl1uipMSgy+skil+wHlwIdxZiKmq+Yb9V2cpgam7W9AMu46S9BGmRRuZW0BYCHI0LxbMwjjt/Sp2pCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyroRru0EzRCoJr24gmY11ulWsdOhmo/NFtir2/19FfRaZY/53i
	+lY9kT4cjxPE/Zq+tyltx5YYc8o5Ld8plZqkrjK9aKSXiZ30bPv1a0HJDA0GYxhPloEdxL0yIW9
	MukK99Yg2wQQ0PNegYFLfmoleh1k=
X-Gm-Gg: ASbGncuMxk7DUci5wi0++5MtMoHQxWa+OVCAbXHHySY8jfhbkDrYTlkKgQ2nVsvs5YR
	lZMtnQFgsiGMvdX5HZeOF5AS7bHs3yqauQo7hAaf8hl69alHLa1nd6cOLmSY/ni4asmMkjTxJTg
	WFcc7sfbIIKZEn4Mkjqj4+gqZmWn8oipk76bhHLAJV3w==
X-Google-Smtp-Source: AGHT+IEYZoUW7VaYl1K0NRdn7Y62H7m9YqK/rjOHA7YhmoJUMMb5hfbs1G8oBx//nhN1IFMrWpdIpnYpNaPfo4x9iwk=
X-Received: by 2002:a05:6512:b1f:b0:549:7394:2ce5 with SMTP id
 2adb3069b0e04-54acb205b22mr1741596e87.41.1742415647244; Wed, 19 Mar 2025
 13:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
In-Reply-To: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 16:20:11 -0400
X-Gm-Features: AQ5f1JovOtFjnXbLSMpzEX0ccmtHqgFpy4_q71Ukj6vLkjRO13C_mRmxVO7yxlA
Message-ID: <CAJ-ks9ke2_b21WBuOSPAJobRyqhH3eD+vmCMGCCoCLfYapk0Xw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] rust: reduce pointer casts, enable related lints
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 10:23=E2=80=AFAM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> This started with a patch that enabled `clippy::ptr_as_ptr`. Benno
> Lossin suggested I also look into `clippy::ptr_cast_constness` and I
> discovered `clippy::as_ptr_cast_mut`. This series now enables all 3
> lints. It also enables `clippy::as_underscore` which ensures other
> pointer casts weren't missed. The first commit reduces the need for
> pointer casts and is shared with another series[1].
>
> The final patch also enables pointer provenance lints and fixes
> violations. See that commit message for details. The build system
> portion of that commit is pretty messy but I couldn't find a better way
> to convincingly ensure that these lints were applied globally.
> Suggestions would be very welcome.
>
> Link: https://lore.kernel.org/all/20250307-no-offset-v1-0-0c728f63b69c@gm=
ail.com/ [1]
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Changes in v5:
> - Use `pointer::addr` in OF. (Boqun Feng)
> - Add documentation on stubs. (Benno Lossin)
> - Mark stubs `#[inline]`.
> - Pick up Alice's RB on a shared commit from
>   https://lore.kernel.org/all/Z9f-3Aj3_FWBZRrm@google.com/.
> - Link to v4: https://lore.kernel.org/r/20250315-ptr-as-ptr-v4-0-b2d72c14=
dc26@gmail.com
>
> Changes in v4:
> - Add missing SoB. (Benno Lossin)
> - Use `without_provenance_mut` in alloc. (Boqun Feng)
> - Limit strict provenance lints to the `kernel` crate to avoid complex
>   logic in the build system. This can be revisited on MSRV >=3D 1.84.0.
> - Rebase on rust-next.
> - Link to v3: https://lore.kernel.org/r/20250314-ptr-as-ptr-v3-0-e7ba6104=
8f4a@gmail.com
>
> Changes in v3:
> - Fixed clippy warning in rust/kernel/firmware.rs. (kernel test robot)
>   Link: https://lore.kernel.org/all/202503120332.YTCpFEvv-lkp@intel.com/
> - s/as u64/as bindings::phys_addr_t/g. (Benno Lossin)
> - Use strict provenance APIs and enable lints. (Benno Lossin)
> - Link to v2: https://lore.kernel.org/r/20250309-ptr-as-ptr-v2-0-25d60ad9=
22b7@gmail.com
>
> Changes in v2:
> - Fixed typo in first commit message.
> - Added additional patches, converted to series.
> - Link to v1: https://lore.kernel.org/r/20250307-ptr-as-ptr-v1-1-582d0651=
4c98@gmail.com
>
> ---
> Tamir Duberstein (6):
>       rust: retain pointer mut-ness in `container_of!`
>       rust: enable `clippy::ptr_as_ptr` lint
>       rust: enable `clippy::ptr_cast_constness` lint
>       rust: enable `clippy::as_ptr_cast_mut` lint
>       rust: enable `clippy::as_underscore` lint
>       rust: use strict provenance APIs
>
>  Makefile                               |   4 ++
>  init/Kconfig                           |   3 +
>  rust/bindings/lib.rs                   |   1 +
>  rust/kernel/alloc.rs                   |   2 +-
>  rust/kernel/alloc/allocator_test.rs    |   2 +-
>  rust/kernel/alloc/kvec.rs              |   4 +-
>  rust/kernel/block/mq/operations.rs     |   2 +-
>  rust/kernel/block/mq/request.rs        |   7 +-
>  rust/kernel/device.rs                  |   5 +-
>  rust/kernel/device_id.rs               |   2 +-
>  rust/kernel/devres.rs                  |  19 +++---
>  rust/kernel/error.rs                   |   2 +-
>  rust/kernel/firmware.rs                |   3 +-
>  rust/kernel/fs/file.rs                 |   2 +-
>  rust/kernel/io.rs                      |  16 ++---
>  rust/kernel/kunit.rs                   |  15 ++---
>  rust/kernel/lib.rs                     | 113 +++++++++++++++++++++++++++=
+++++-
>  rust/kernel/list/impl_list_item_mod.rs |   2 +-
>  rust/kernel/miscdevice.rs              |   2 +-
>  rust/kernel/of.rs                      |   6 +-
>  rust/kernel/pci.rs                     |  15 +++--
>  rust/kernel/platform.rs                |   6 +-
>  rust/kernel/print.rs                   |  11 ++--
>  rust/kernel/rbtree.rs                  |  23 +++----
>  rust/kernel/seq_file.rs                |   3 +-
>  rust/kernel/str.rs                     |  18 ++----
>  rust/kernel/sync/poll.rs               |   2 +-
>  rust/kernel/uaccess.rs                 |  12 ++--
>  rust/kernel/workqueue.rs               |  12 ++--
>  rust/uapi/lib.rs                       |   1 +
>  30 files changed, 218 insertions(+), 97 deletions(-)
> ---
> base-commit: 498f7ee4773f22924f00630136da8575f38954e8
> change-id: 20250307-ptr-as-ptr-21b1867fc4d4

Per the discussion in today's Rust-for-Linux meeting and Benno's
reply[0] please take this series without the last patch, whenever you
see fit to do so. At this time no changes have been requested to the
first 5 patches, so I am not planning to respin.

Cheers.
Tamir

[0] https://lore.kernel.org/all/D8KIHNXCPE0P.K4MD7QJ1AC17@proton.me/

