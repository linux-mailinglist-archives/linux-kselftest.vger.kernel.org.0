Return-Path: <linux-kselftest+bounces-35365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6162AE09A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 17:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 042C37AF92E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B2E219A8E;
	Thu, 19 Jun 2025 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3QEA4PO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD97DDAD;
	Thu, 19 Jun 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345593; cv=none; b=g1h1WQdb+17cSDozzcINiKifXWDYDJz7bc9X21z+p7iwm2LIHxVx6dKQlSXXra8qPq3y8nMjyPJqpcX0b/NVfuOw7O2o3Rua+Ihf+gOn8dOplzG7TF5KIuQhbyRZfnp4eP+oYVVWHPiiYUkfFce4x6B5wVoqUJmCeiSQOU2flh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345593; c=relaxed/simple;
	bh=wGxKJCc7qeOmnuSZ+yHqpDhrjglCvryWX3i8qW5pY7s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r/Wa+x2i46WhQGRqbEfRcE6Ywcn5iVgbYTyDweceFzokDQkrtJ9EvyBuxFA9WqLxsvciTS5Y18HJPTniVByeFUKupz12/lOuNxqfVnd8b+rzV/2rgfywE2N0WQqW5xPYsQJPwJzTli4O2Uc4w22nit+g2lS8lo8fkUTNUsIbgos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3QEA4PO; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a5a196f057so19362361cf.3;
        Thu, 19 Jun 2025 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750345590; x=1750950390; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nXuTpoOb8+LqU5quDMVJCzI6iZgIaVm2IMUXk0GHfM4=;
        b=d3QEA4POj7ODVz0We39Zw8PpOhR1ta/kOnhCYRcZzymhkn1kI9vmKal5BMZiMgbRXr
         XG27MF1w0D+dnJmAJsbUIBNfU5Jy2P+aS91gWBSWNZZQ2Cm8hYYFV3jJj06ouLaEWBf2
         wqLHljESTpDQNaJ6mfZishXEEt500W1pmRufz6OsgrqMHeaK/VKYgmI+lopIcp+S1wVP
         vDus4AEo4c/oeHTDBY7jR4cA/XZy4zTP22eUBM8BILHmeUDLkADmIbkETRGJ8/sRq8pX
         anMFo8tU5iEzWmDEMQjRw80HvyKeRdaTSk1bZwxKp5qSWo7thyJl9/8zVUtVFIhmdzFW
         kcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750345590; x=1750950390;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXuTpoOb8+LqU5quDMVJCzI6iZgIaVm2IMUXk0GHfM4=;
        b=jX4ghTLVC/ZiTESleN8RhQFgCP8lKwq5YDIb7NDnoeWH3vOX2qyBuGdCJBXQA+j2yD
         tb1kOl3wkXZ2n8nLU8obkfr2Gl9lISCdaUjTyEpp+IXlWJcqVhqi4ZQM//ZwxN4w8TrI
         XkuzlWxe5P4vAL/vtMAodhmlTwOogggFljABTt4Ivgo/GNzjp380ZVpu7ZixKw0+8LUG
         fLCO8BN3Ws7yWuQDF2/PG6fJukkDfwvrRk8oq6NFj5DkP2R+7wRC9KneSG3z1ptKYICV
         PA3qSXtsjzxTnuoqCSSd2CT+Ix3cbBjI8Z/xnn0BtqBKbtTZ35UTfZBdMJizD4DNFbS+
         727Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCePjPkAKziNvNYbtqB91aCayr62taBWRhuNfsOJ/3MgIX90fECC16coICBiB5Zrd0W7XgOlYBg4LHXrPIeVGY@vger.kernel.org, AJvYcCUPMm4jvtotNH07IU2ErufaRhIA0dtfAimhRd9AM/e8ElkMf21H7hdqBgpeQdztNW/aN9ny3KTm@vger.kernel.org, AJvYcCUxDDfgOfwya6nbgVmbz9IUrct4RhlA8gHc1e1U6Pq26TGfWIQEflmvKOuNyFoLp5SFg+GPwffcFJj89vI=@vger.kernel.org, AJvYcCVT/LA+sOpwaMpngnp2bPsrZRCm2mdx2E5+J6TxWeTP2gzQH2Ue1s1PfW+9wXpq/PQGAF0fT41de1gPjM7L@vger.kernel.org, AJvYcCWgfVD7Eo2J4EwfMlzqM94PIof6VMnFjiCbTQ75EmHG+SJLrfgoBvO5nWULHNZHJqpfewbN9Yy0PFsF@vger.kernel.org, AJvYcCX8hze+R++pKzPhFCm7h+lJNkdcBXEL4CT3OKiIUYb65duCTK7aGBWRgLKUuZ/Zwv2QjkJpauo3LBz+@vger.kernel.org, AJvYcCXUQr963FoXMsOq1VEMFOA6fso276O4EsbObbd76pCD6zpryLNydPIZ4d67sq1g3Qtu1UaAXRs8NStk@vger.kernel.org, AJvYcCXYjHHI4K4mZOQrcxkqsm8lJ0DlCh3547wboVCGWPq2EueeWvQUrrXimdUqizgDhhyHmpdMK8ePtUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKa8PZ/9owuobzdFPfu8dkS6SL7l4bH65qpjScjTFyNGkuJKli
	m1WzKMp9Ja/ij+MhPoOBmvhhGOFPblQc1T+Z4gt8e7eqtKgG5qK4zYUr
X-Gm-Gg: ASbGnctiu4AiwvIZxAFe+VyoWHtXdHC/kUv1vv0GCIko/BvVWZCMiWQrIp6jleqF8vw
	qjHBneFursBnv2VtfPLrDo+Tmrhbk52F4mEX/b4B0vQ44RUxYvDrlaOJ0qHeJ9pP+nQS1if9Rk6
	HAg0Kqdmjv+2+esh8JegqKGqqncod5knFU1njqldCvUEJVVCUr9whmnnia7ALAd+9Ar1CKvJ7wl
	I66q+WccDM4GR+Yqv5BX4BpN5V2yqc4fq96/23hMxueQRYQ0gSqGLzlkaDj+51Z7xgQ98kgWzZn
	jTZJQT4eT7/WkcbTq3Pdz4SeZ+lMw0L0xNO7XoABrtjUE6RpQj9/zBjpT08mvqcaWYFnjv8zzlQ
	=
X-Google-Smtp-Source: AGHT+IFX/JE8xs0dtWJTtpxoAw108+yxpwrRoiMuu696MghqABs29FkJDRGkGOS7haSa53S3zqGnCw==
X-Received: by 2002:a05:622a:11c1:b0:476:7199:4da1 with SMTP id d75a77b69052e-4a73c5ed5bemr350669851cf.46.1750345590333;
        Thu, 19 Jun 2025 08:06:30 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:5c8a:fc6a:b57c:e57f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7785aaacdsm250531cf.39.2025.06.19.08.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 08:06:29 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v12 0/5] rust: replace kernel::str::CStr w/ core::ffi::CStr
Date: Thu, 19 Jun 2025 11:06:24 -0400
Message-Id: <20250619-cstr-core-v12-0-80c9c7b45900@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHAnVGgC/3XOwW6DMAwG4FepOC+VbRKT9NT3mHaAJJRog1QBo
 VUV775QqSvttKPjfL//azH6FPxYHHbXIvk5jCEOeUB62xW2q4eTF8Hlh4KAFBCgsOOUhI3JCyc
 b07BBAtsW+f85+TZ838LeP/LcptiLqUu+vidI0GhQlax4T1pDJUjMtYspzuPn5XhOcYpDX4evv
 Y39GtmFcYrpcqs38xp8L0KbIjMLEFqysY4dmdYdT78ha5G5+ldWWboadV4RyFK/Sr2V5VbqLG1
 TtsS+0qz5VZqHLLHaSpOlQsfWKqKW6VUiPKgiuaUI2bJEqo10xlXqj8WNLeHJ4trYGQu2sY2Bp
 7vLsvwAOlZtqwwCAAA=
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
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
 nouveau@lists.freedesktop.org, linux-block@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
have omitted Co-authored tags, as the end result is quite different.

Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vadorovsky@protonmail.com/t/#u [0]
Closes: https://github.com/Rust-for-Linux/linux/issues/1075

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v12:
- Introduce `kernel::fmt::Display` to allow implementations on foreign
  types.
- Tidy up doc comment on `str_to_cstr`. (Alice Ryhl).
- Link to v11: https://lore.kernel.org/r/20250530-cstr-core-v11-0-cd9c0cbcb902@gmail.com

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

 drivers/block/rnull.rs                |   4 +-
 drivers/cpufreq/rcpufreq_dt.rs        |   5 +-
 drivers/gpu/drm/drm_panic_qr.rs       |   5 +-
 drivers/gpu/drm/nova/driver.rs        |  10 +-
 drivers/gpu/nova-core/driver.rs       |   6 +-
 drivers/gpu/nova-core/firmware.rs     |   2 +-
 drivers/gpu/nova-core/gpu.rs          |   4 +-
 drivers/gpu/nova-core/nova_core.rs    |   2 +-
 drivers/net/phy/ax88796b_rust.rs      |   8 +-
 drivers/net/phy/qt2025.rs             |   6 +-
 rust/kernel/auxiliary.rs              |   6 +-
 rust/kernel/block/mq.rs               |   2 +-
 rust/kernel/clk.rs                    |   9 +-
 rust/kernel/configfs.rs               |  14 +-
 rust/kernel/cpufreq.rs                |   6 +-
 rust/kernel/device.rs                 |   9 +-
 rust/kernel/devres.rs                 |   2 +-
 rust/kernel/driver.rs                 |   4 +-
 rust/kernel/drm/device.rs             |   4 +-
 rust/kernel/drm/driver.rs             |   3 +-
 rust/kernel/drm/ioctl.rs              |   2 +-
 rust/kernel/error.rs                  |  10 +-
 rust/kernel/faux.rs                   |   5 +-
 rust/kernel/firmware.rs               |  16 +-
 rust/kernel/fmt.rs                    |  89 +++++++
 rust/kernel/kunit.rs                  |  21 +-
 rust/kernel/lib.rs                    |   3 +-
 rust/kernel/miscdevice.rs             |   5 +-
 rust/kernel/net/phy.rs                |  12 +-
 rust/kernel/of.rs                     |   5 +-
 rust/kernel/pci.rs                    |   2 +-
 rust/kernel/platform.rs               |   6 +-
 rust/kernel/prelude.rs                |   5 +-
 rust/kernel/print.rs                  |   4 +-
 rust/kernel/seq_file.rs               |   6 +-
 rust/kernel/str.rs                    | 444 ++++++++++------------------------
 rust/kernel/sync.rs                   |   7 +-
 rust/kernel/sync/condvar.rs           |   4 +-
 rust/kernel/sync/lock.rs              |   4 +-
 rust/kernel/sync/lock/global.rs       |   6 +-
 rust/kernel/sync/poll.rs              |   1 +
 rust/kernel/workqueue.rs              |   9 +-
 rust/macros/fmt.rs                    |  99 ++++++++
 rust/macros/kunit.rs                  |  10 +-
 rust/macros/lib.rs                    |  19 ++
 rust/macros/module.rs                 |   2 +-
 rust/macros/quote.rs                  | 111 ++++-----
 samples/rust/rust_configfs.rs         |   9 +-
 samples/rust/rust_driver_auxiliary.rs |   7 +-
 samples/rust/rust_driver_faux.rs      |   4 +-
 samples/rust/rust_driver_pci.rs       |   4 +-
 samples/rust/rust_driver_platform.rs  |   4 +-
 samples/rust/rust_misc_device.rs      |   3 +-
 scripts/rustdoc_test_gen.rs           |   6 +-
 54 files changed, 540 insertions(+), 515 deletions(-)
---
base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
change-id: 20250201-cstr-core-d4b9b69120cf

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


