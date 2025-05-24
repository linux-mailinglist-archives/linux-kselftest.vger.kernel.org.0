Return-Path: <linux-kselftest+bounces-33742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6C3AC314D
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 22:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45AA9E0DEA
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 20:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EF7280335;
	Sat, 24 May 2025 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zfyuojyw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C427F754;
	Sat, 24 May 2025 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748118813; cv=none; b=i3RFYGOPB7THA5xUWUJVvgWJ2LqR4IdK97JhjWGqt4Q9twzO67kx2LOy6d/mKZKuYcVqKzDBvhlvxqgWtR8sOEsZ+fobdmF1ha8oTs85zQrUzz3rTcVWvfexZ0/G15c1F8rf2bp4kY9rm1Rz3wzN6fyL8Ppfy3cLpGjrrnHdIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748118813; c=relaxed/simple;
	bh=y/agLfL8cvRLwjOLQ2FmgleRZcO69KtrQd6QQg0+Gcs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jhNUAorD2nYOq6LCOjkE7PM3nHrFy8ptVoDKOl3KQVHQiKQcnLSS6C6RChuTiLL4tlsewAtkpq7Bae4r8dsKwPnQwS+YvnMKvdMxlo0JppEqG2ylzk2bQN5SB7alqhRyTz+BwBz+c3YIy4PWKBhZ0umen6gEQfBEiiC7UsJ/394=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zfyuojyw; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so100204439f.1;
        Sat, 24 May 2025 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748118810; x=1748723610; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gDpP7s7cOkPavUulBU3Ba+a6zZqUiVMm4fW37bEOlm0=;
        b=ZfyuojywW03t5ljuKajvfzL2pOBrB9ohgstqGCE4E9gYti65Kx6aJltzIdkZd05dzM
         bK386Q62Y/lWzlIQwIDOabYN9TMfN6bKCTKNqXS7mQ0zhQzc8Qz0kemIW0urwahRgunw
         6XqrFTXbwr2jjDvFeQLeOkMDo2bmiLo07RXhSg1faL+1LQam19FxD5mHm91izThd+VOv
         GEkP4ARVOAlu5YGxEyfNM7XTtL5QDrVMCWfbzfhYQycx7BpnFFq8LC/t8C7z6mg/R5Iv
         hQAZqB6tjtHNVJrElUs5168g2JKw6WTzU7UsMNe89kvooJSKEtOeRnm7CEdWi6bShlF6
         ROkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748118810; x=1748723610;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDpP7s7cOkPavUulBU3Ba+a6zZqUiVMm4fW37bEOlm0=;
        b=sEP4mmGyo4Xtl19UxF9PS8JUH5ie/kefOWMvrcgj8k4aDH3vfuOK2bfd+weCTxTEUL
         J1/HiEz0CLVff4BiKxq+bdzgBb7nVuAUMW25Kwayet1I2SFGO3+cjzBA8Lp9sHFucEBd
         I8QNMQHzPPXhrPyZ9Ap8ybKCfHkc75MGxAvhlGUBwbZ8QFHCEnZbe9qXdO4Ty7P294WK
         btoXjlYUZeG/u6wVMWFO5kGW54W3E3qKXAcFTy3CYM1mTP5Tw6Q3e+7NFOk1WM0IEj24
         i1bbrjEcWfWuHv28TDxNZPYeCu5vSwykCZNJZz4Qlm6UCBoI+0+GeJSjuOgy6/UvvxF3
         3vjw==
X-Forwarded-Encrypted: i=1; AJvYcCVNyRZPELGRbSnZCICL8FUtGzqbFPKDL6mYdo97Yql/M4P8SI6wPJe++5ONoVgcw5WR1I+60uHf@vger.kernel.org, AJvYcCVSmRtjRGp/GegxB52OzztnWaeQtg9JybXSmApBaccmUU32LBDi19S6JPYFoNg0cVUeGNmt5L71eDqH@vger.kernel.org, AJvYcCWA2TR+Dk5RVhgmBG9WH5nfSp6Hua/9tRqrNOEoN9uoioaPT9BapIqDnyhPmf2rXTw1lbSrtangqPBi@vger.kernel.org, AJvYcCWBm90vx86KXDg/DO8/ViJ43uunxc6Uxj/NSxyquZUCX2qb/B2APgIOro5UKGt3UBojybaqUkRnQz+m9Kdt@vger.kernel.org, AJvYcCWO9ciJQbFrd4CXxPqRMhLTrLwNJjnXbcYkMJWp1gGVbBoWkvcN6GQMF07OLMw3ahDJEZM1Zz6baPe+Vvw=@vger.kernel.org, AJvYcCXi14CaEnhdHd8n7klGlmkHkJQ+i8HsW8AjrLE261lCXnIpxzzB7UmlEzCaEivdoaKiKp9gsCS+nG7OJ6vi48Om@vger.kernel.org
X-Gm-Message-State: AOJu0YyYkKycFw5NWODVBcwOSpRUufKiFJnhqQDoJrJsWHDKystq9hP8
	H0wNjznl+xOQOdmG5H6h4RhN6q2YaqYaUmn7qV+SlVMp1MGXCiOFMfdiuxiNL50qTJk=
X-Gm-Gg: ASbGnctwDjU4F1EKwZ030G1YVgX4dr5GCuYb+hv32+p1gmUF+qlgzY0fiKqryTOm9L+
	clxj9/Dd2MB2hW/zOdpte176QLbjww6U3R7tkWSOoPT586eYbhEdsax2mi7U+klJtMYOHE6TX6m
	N1SsVeCXDh/AoXJlZSm7Z7lex9EN8ZybPJDbBzBJfIJQ8VItQH9sxaJYB/sWUWeC0md1vpDy7SA
	xbwCo+V67ZUwa9EV49h3VD/GZ9conLaVa99Y+3ro5EKLFmDbIJnUVgPoAlCmyBhf6ZCtkzy7G6f
	kqIGAocui0bjtdkQFcZM3RKhi3xkIJnMI1VbPyWTqfMKKdooezrY2MDOASrJxRGXePhJi/Gkb6N
	fdUXWpAXokwgvwrfmOZujgqpyeUAF2sd9kXv5byUVe1diciu8VudcRG2KJkcX3Zoqykz8x4ArF7
	PCGYY=
X-Google-Smtp-Source: AGHT+IEY1bus7pYi5JcXesXRddo5ekO8LWT2IX5dDBSF4gjuh1ID95e7jx0zQU9fIvHGHwyslvJU7A==
X-Received: by 2002:a05:620a:44c2:b0:7c3:cd78:df43 with SMTP id af79cd13be357-7ceecc45f6amr602236985a.58.1748118799405;
        Sat, 24 May 2025 13:33:19 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:8563:e370:791f:7436])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467d7fd1sm1379590085a.29.2025.05.24.13.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 13:33:17 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v10 0/5] rust: replace kernel::str::CStr w/ core::ffi::CStr
Date: Sat, 24 May 2025 16:33:00 -0400
Message-Id: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPwsMmgC/3XOy27DIBAF0F+JWJcIxvYAWeU/qi4wjxi1NhFYq
 FHkfy+OlBZF6nIe5+reSXYpuExOhztJroQc4lIHzt4OxEx6uTgabF0QYDAwYJyavCZqYnLU9qM
 aUXFgxpP6f03Oh+9H2PtHnX2KM12n5PQzoWeSKz50OOARpGSCAi3axhRL/rydrymucZl1+DqaO
 O+RU8hrTLdHvYJ78LMINEUKUkZlj8pYtKC8PV9+Q/YiRfwrRZVWc1lPwPpOvkrZyq6Vskozdh7
 QCYkSX6X6kx0XrVRVDtyiMQOAR2jltm0/fH5cIZQBAAA=
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
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
      rust: retitle "Example" section as "Examples"
      rust: support formatting of foreign types
      rust: replace `CStr` with `core::ffi::CStr`
      rust: replace `kernel::c_str!` with C-Strings
      rust: remove core::ffi::CStr reexport

 drivers/block/rnull.rs               |   2 +-
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
 rust/kernel/fmt.rs                   |  77 +++++++
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
 rust/kernel/str.rs                   | 415 ++++++++++-------------------------
 rust/kernel/sync.rs                  |   7 +-
 rust/kernel/sync/condvar.rs          |   4 +-
 rust/kernel/sync/lock.rs             |   4 +-
 rust/kernel/sync/lock/global.rs      |   6 +-
 rust/kernel/sync/poll.rs             |   1 +
 rust/kernel/workqueue.rs             |   1 +
 rust/macros/fmt.rs                   | 118 ++++++++++
 rust/macros/kunit.rs                 |   6 +-
 rust/macros/lib.rs                   |  21 +-
 rust/macros/module.rs                |   2 +-
 samples/rust/rust_driver_faux.rs     |   4 +-
 samples/rust/rust_driver_pci.rs      |   4 +-
 samples/rust/rust_driver_platform.rs |   4 +-
 samples/rust/rust_misc_device.rs     |   3 +-
 scripts/rustdoc_test_gen.rs          |   2 +-
 40 files changed, 426 insertions(+), 395 deletions(-)
---
base-commit: cbeaa41dfe26b72639141e87183cb23e00d4b0dd
change-id: 20250201-cstr-core-d4b9b69120cf

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


