Return-Path: <linux-kselftest+bounces-34050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141CCAC8D86
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 14:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499F13B628B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 12:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE99A22B5AB;
	Fri, 30 May 2025 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c94cqCVD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F121CC55;
	Fri, 30 May 2025 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608072; cv=none; b=XPtZhdXr5t+zzp0BxgwwVhQEk13pArTHLnW75/zpA/Vwk3HeWve5lrIcWJmRNEZuyUl3/nEOXIsVAiLqgdcedMv+ZwT0CJHFkGRv66+jElvrma+6Hl4BkYn1TT6rk/rVh2YiGUuBe/hPBOCgdBVw+WstdOKvtWergVXuuNAYBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608072; c=relaxed/simple;
	bh=5NRw2BPuzd4CaSoFhQyS92NyyJZbEuiSnoR6lbAl7A4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uQzJ30FA101TFGS+FQhbVKfaK9sBRKuG7lconKZb/UUocDElN3oVrSFB/4z+/RXx3a6uSLEEchWVId07FwpdADC7Ce8K4LNh488yVNzdpL8m6dSnVr/4G1hDepSBTHc5QETfUUEsblWCD7JHiCOWve9Sz5/zUULIpQF8ovAN1cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c94cqCVD; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476a720e806so17404431cf.0;
        Fri, 30 May 2025 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748608069; x=1749212869; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EjF77eIXn5rbCgQ6Jld+tzlhhos22ijDGstzJKXraFM=;
        b=c94cqCVDaf6Ub322i2pWlWQI4XfqymhpTiMJv11frOAInthKvvuh4WUXeXud1IkQHL
         EvegB1mLHEIxL2325kAqewdhyD/YaQfIIfkF/zQTM/+h6am7Z8dOKS4gC9tsNoIE/8GZ
         uMhC551WSfYzxNacoQwFDAOaAW4IgTFotyq+nz0jKzZLZ49SIoWQMJxjSRoae9CkjkVa
         TYlOfjod/uXa0NvLxMOcgw13qtRGy/FE47YLTc0PDaHfvOrntVVbMbhrKVp38Ntzvyxd
         b8PYqZMxv6/a60anDP3cCCuDk4jmkleS7L2lEA2ExRS4iI/tXjUA1+keGkexm5shInvD
         BIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748608069; x=1749212869;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjF77eIXn5rbCgQ6Jld+tzlhhos22ijDGstzJKXraFM=;
        b=oFgWVmOWRO9gudITKgeEs3UKhW8BBX4GcVNoFRBqZc/XhYU65yVIzVD0BQ4ukRiyLA
         uQwkvEXDJ8itx4x3elIEvtq0nwLgZ6TpPxnxYlcQWv5U3Rs0nMh2G4Fc1aJKHxF+gg93
         nchbWaw0tfcTyI1KET2ut8vJSHMoRKo3UUt04aMAV5cDxWVFqYecQVLhufvy3btB/9Yt
         qh4YqerIPZvJg6kj2XFgKGZ4OGRYo67KXhKSP8iU3PAHBEqnNG8hjfJb6/Oc3eKLr/BX
         Xosp5YTmcJPXQkDVW7p31Oc4CkJJJbvTXPXm5LwwQdb6mzrM/izI6MMkSkwMCSSUSAyM
         14yQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6ztCYEJNpmaOjGcqunnecoNspUXqO6VGUaSdDByF3TwlVhj7QSTVuUasKT0a0yZZGtkUmDgcVR7Z3SEix@vger.kernel.org, AJvYcCVP5PwiGe9yn1W6f0Tzyc7dyz1USpYzRc/Sj1p5XuD6L6kOEukHCDMJamOwXT0ctQTI+W4KNPqzB7pnB/s=@vger.kernel.org, AJvYcCVdCyP2hR9B0WCUAOiKqa2d6AjtauBBxlHiaqrBOKPn2wNkDgiXbW/QWtJSSb/iIRQvtiVsac9pLIht@vger.kernel.org, AJvYcCW8n5mSLoh3W+8aejBnNeptm/mM4w+BUgDkI0vHsoOIZYUwqVgP2D06S6XkBa/FN1Q/NipGpaOU@vger.kernel.org, AJvYcCWsF20vm92hmV3lO5jhOXai2lUUG3XjH1jp8bZjeQo/f8dXMl14VminpUbR73DageueQ0nnFjaI/joq@vger.kernel.org, AJvYcCXLVR3FedNeN5cFujFw1GnSjak5RD1/mzgsX4DOCiQENuQTTwZXwgUI47TNnoMYXXHvxDZbG58MMQt8amayjXeU@vger.kernel.org
X-Gm-Message-State: AOJu0YxHfpgTGT1cys3PiZOIv4Sa0JWoMMcVGsxzv97F2B/jyG9+1zjY
	CIKSPqbQ7T9Z90LIkRpSxCGlgjQy9RWHtK27fQNQpzu5a5IXgPJbj65Q
X-Gm-Gg: ASbGncsf3iJWm9N3uEFTdZpQ/xqNBtwlgqPzcY9COqtJhdP05va8HmTpmRsn1Iqm/Yr
	Pr9oSbu5Zx4YYGW8R3zASyz+lehcIg9u+3c04ERuVMlGKFpXLjMYwXdno/gvoheQZgaJjnrtY0D
	c2L7fHcCbIlIuvkWnZ0X3a9YGpjmKV10CHi6JMXNLU4M4qEhMQhA8A+QJ8Z5PYwPkT9Wv04ocG+
	wphZeAFDGUSN4Yzn2DRV6dF0PPKADhWHQb0TMWWxEA5yBgt1nFBlsP3dxutbRrXj6LEADkO+6Zh
	RxlatYVTIxAGn71NHu2IheG+vSsXtDl2uh1eYUnZ/lrpju8SlfXKJuFeyBPlnQHuLRvNXQ4Uzil
	7C9QsKH07XStktK58vLrR/46V/X0T/Yl47oWQYuGAz6mSGrmL07w/xkaJ6S2A
X-Google-Smtp-Source: AGHT+IGfjgQI2SYiqTDZZqtk6xAv1YDFCzHe/hIZJctpyviQ3ufizyFRYxRIuu0rnsdysg0lQBJL9A==
X-Received: by 2002:a05:622a:1f0f:b0:494:adde:e3f4 with SMTP id d75a77b69052e-4a44005415bmr52541221cf.25.1748608069240;
        Fri, 30 May 2025 05:27:49 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:fbe8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a4358ad334sm19700201cf.27.2025.05.30.05.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 05:27:47 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v11 0/5] rust: replace kernel::str::CStr w/ core::ffi::CStr
Date: Fri, 30 May 2025 08:27:41 -0400
Message-Id: <20250530-cstr-core-v11-0-cd9c0cbcb902@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD6kOWgC/3XOy27DIBAF0F+JvC4RjGGArvIfVReYR4zamAgs1
 CjyvxdHSmNZ6nIe5+reu+Jz9KV7P9y77GssMU1tYOzt0NnRTGdPomuLDigICpQRW+ZMbMqeOD7
 oATUDakPX/q/Zh/jzCPv4bHPI6ULmMXvzTOBUMc1EjwKPoBSVBEg1LuVUy9ftdM1pTtPFxO+jT
 Zc1coxlTvn2qFdxDX4WgU2RioQSxVFbhw50cKfzX8hapMp/pWzSGabaCSjv1V6qrey3UjVphz4
 AeqlQ4V7ql+yZ3ErdpGAOrRUAAWEvGX1RAXxLGW0WOQOjudNOiq1dluUXREeHvdABAAA=
X-Change-ID: 20250201-cstr-core-d4b9b69120cf
To: Michal Rostecki <vadorovsky@protonmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Jens Axboe <axboe@kernel.dk>, Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
 nouveau@lists.freedesktop.org, linux-block@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
have omitted Co-authored tags, as the end result is quite different.

Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vadorovsky@protonmail.com/t/#u [0]
Closes: https://github.com/Rust-for-Linux/linux/issues/1075

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v11:
- Use `quote_spanned!` to avoid `use<'a, T>` and generally reduce manual
  token construction.
- Add a commit to simplify `quote_spanned!`.
- Drop first commit in favor of
  https://lore.kernel.org/rust-for-linux/20240906164448.2268368-1-paddymills@proton.me/.
  (Miguel Ojeda)
- Correctly handle expressions such as `pr_info!("{a}", a = a = a)`.
  (Benno Lossin)
- Avoid dealing with `}}` escapes, which is not needed. (Benno Lossin)
- Revert some unnecessary changes. (Benno Lossin)
- Rename `c_str_avoid_literals!` to `str_to_cstr!`. (Benno Lossin &
  Alice Ryhl).
- Link to v10: https://lore.kernel.org/r/20250524-cstr-core-v10-0-6412a94d9d75@gmail.com

Changes in v10:
- Rebase on cbeaa41dfe26b72639141e87183cb23e00d4b0dd.
- Implement Alice's suggestion to use a proc macro to work around orphan
  rules otherwise preventing `core::ffi::CStr` to be directly printed
  with `{}`.
- Link to v9: https://lore.kernel.org/r/20250317-cstr-core-v9-0-51d6cc522f62@gmail.com

Changes in v9:
- Rebase on rust-next.
- Restore `impl Display for BStr` which exists upstream[1].
- Link: https://doc.rust-lang.org/nightly/std/bstr/struct.ByteStr.html#impl-Display-for-ByteStr [1]
- Link to v8: https://lore.kernel.org/r/20250203-cstr-core-v8-0-cb3f26e78686@gmail.com

Changes in v8:
- Move `{from,as}_char_ptr` back to `CStrExt`. This reduces the diff
  some.
- Restore `from_bytes_with_nul_unchecked_mut`, `to_cstring`.
- Link to v7: https://lore.kernel.org/r/20250202-cstr-core-v7-0-da1802520438@gmail.com

Changes in v7:
- Rebased on mainline.
- Restore functionality added in commit a321f3ad0a5d ("rust: str: add
  {make,to}_{upper,lower}case() to CString").
- Used `diff.algorithm patience` to improve diff readability.
- Link to v6: https://lore.kernel.org/r/20250202-cstr-core-v6-0-8469cd6d29fd@gmail.com

Changes in v6:
- Split the work into several commits for ease of review.
- Restore `{from,as}_char_ptr` to allow building on ARM (see commit
  message).
- Add `CStrExt` to `kernel::prelude`. (Alice Ryhl)
- Remove `CStrExt::from_bytes_with_nul_unchecked_mut` and restore
  `DerefMut for CString`. (Alice Ryhl)
- Rename and hide `kernel::c_str!` to encourage use of C-String
  literals.
- Drop implementation and invocation changes in kunit.rs. (Trevor Gross)
- Drop docs on `Display` impl. (Trevor Gross)
- Rewrite docs in the style of the standard library.
- Restore the `test_cstr_debug` unit tests to demonstrate that the
  implementation has changed.

Changes in v5:
- Keep the `test_cstr_display*` unit tests.

Changes in v4:
- Provide the `CStrExt` trait with `display()` method, which returns a
   `CStrDisplay` wrapper with `Display` implementation. This addresses
   the lack of `Display` implementation for `core::ffi::CStr`.
- Provide `from_bytes_with_nul_unchecked_mut()` method in `CStrExt`,
   which might be useful and is going to prevent manual, unsafe casts.
- Fix a typo (s/preffered/prefered/).

Changes in v3:
- Fix the commit message.
- Remove redundant braces in `use`, when only one item is imported.

Changes in v2:
- Do not remove `c_str` macro. While it's preferred to use C-string
   literals, there are two cases where `c_str` is helpful:
   - When working with macros, which already return a Rust string literal
     (e.g. `stringify!`).
   - When building macros, where we want to take a Rust string literal as an
     argument (for caller's convenience), but still use it as a C-string
     internally.
- Use Rust literals as arguments in macros (`new_mutex`, `new_condvar`,
   `new_mutex`). Use the `c_str` macro to convert these literals to C-string
   literals.
- Use `c_str` in kunit.rs for converting the output of `stringify!` to a
   `CStr`.
- Remove `DerefMut` implementation for `CString`.

---
Tamir Duberstein (5):
      rust: macros: reduce collections in `quote!` macro
      rust: support formatting of foreign types
      rust: replace `CStr` with `core::ffi::CStr`
      rust: replace `kernel::c_str!` with C-Strings
      rust: remove core::ffi::CStr reexport

 drivers/block/rnull.rs               |   4 +-
 drivers/gpu/drm/drm_panic_qr.rs      |   5 +-
 drivers/gpu/nova-core/driver.rs      |   2 +-
 drivers/gpu/nova-core/firmware.rs    |   2 +-
 drivers/net/phy/ax88796b_rust.rs     |   8 +-
 drivers/net/phy/qt2025.rs            |   6 +-
 rust/kernel/block/mq.rs              |   2 +-
 rust/kernel/device.rs                |   9 +-
 rust/kernel/devres.rs                |   2 +-
 rust/kernel/driver.rs                |   4 +-
 rust/kernel/error.rs                 |  10 +-
 rust/kernel/faux.rs                  |   5 +-
 rust/kernel/firmware.rs              |  16 +-
 rust/kernel/fmt.rs                   |  77 ++++++
 rust/kernel/kunit.rs                 |  21 +-
 rust/kernel/lib.rs                   |   3 +-
 rust/kernel/miscdevice.rs            |   5 +-
 rust/kernel/net/phy.rs               |  12 +-
 rust/kernel/of.rs                    |   5 +-
 rust/kernel/pci.rs                   |   2 +-
 rust/kernel/platform.rs              |   6 +-
 rust/kernel/prelude.rs               |   5 +-
 rust/kernel/print.rs                 |   4 +-
 rust/kernel/seq_file.rs              |   6 +-
 rust/kernel/str.rs                   | 443 ++++++++++-------------------------
 rust/kernel/sync.rs                  |   7 +-
 rust/kernel/sync/condvar.rs          |   4 +-
 rust/kernel/sync/lock.rs             |   4 +-
 rust/kernel/sync/lock/global.rs      |   6 +-
 rust/kernel/sync/poll.rs             |   1 +
 rust/kernel/workqueue.rs             |   9 +-
 rust/macros/fmt.rs                   |  99 ++++++++
 rust/macros/kunit.rs                 |  10 +-
 rust/macros/lib.rs                   |  19 ++
 rust/macros/module.rs                |   2 +-
 rust/macros/quote.rs                 | 111 ++++-----
 samples/rust/rust_driver_faux.rs     |   4 +-
 samples/rust/rust_driver_pci.rs      |   4 +-
 samples/rust/rust_driver_platform.rs |   4 +-
 samples/rust/rust_misc_device.rs     |   3 +-
 scripts/rustdoc_test_gen.rs          |   6 +-
 41 files changed, 485 insertions(+), 472 deletions(-)
---
base-commit: 7a17bbc1d952057898cb0739e60665908fbb8c72
change-id: 20250201-cstr-core-d4b9b69120cf

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


