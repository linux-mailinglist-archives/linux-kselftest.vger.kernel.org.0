Return-Path: <linux-kselftest+bounces-36198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A286AF00A9
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 18:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797E9176E2A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246DB27C875;
	Tue,  1 Jul 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnrLS5Af"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CA22737EE;
	Tue,  1 Jul 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388589; cv=none; b=d/KcPY3K7SVOAW70NQ4/FzxpeSGf4lwipx9ZQ8RR/lsNtIKL0FcRJrqP8qNG3IkE+6uDydSauRi6mCNg95cTa6M3cmsinNLqcnaKzJtU57lE7ueIFiVDRgaCqlzs2wbH4hJh9Jz8+VF50rlfRUSG2Nh3F8egTez5/hbwb5E6xfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388589; c=relaxed/simple;
	bh=/qQcnfly8w24mBV0CT4kygIoVuN+6OgNa9+itRuSa8w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d/k+hP8SGRgq0g+LP5CRGyRCBOPAORV2bNYorJedI/lXcn4XvLY61skuMZFCGmHB+wrMjh6DJbkT+nu4w4ETH0u5e782HMl/txlB0n6ZjirIYX5EhEz5sW+1C6YBZ6NfGkHtMEhYp4+OZA03PXbpdxWZBCKO60lDR7/9a5/TTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnrLS5Af; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6face367320so39491186d6.3;
        Tue, 01 Jul 2025 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751388586; x=1751993386; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I2MPZ/nttgozW2CJl0qQM5vkBsxfCpf1zX+n1SSNYD4=;
        b=LnrLS5AfMrj2Pk7PiN77RlbQVlJf1iEEum4Rz+AXwGxh26Z52/tm07vqWCsccqM/tH
         E8IY5lyBljDVBA/YXLbAv0cywqpZsSYTFJlp4yEhzd213eqCcvRLjixDMYpX+3g0O2hc
         COXxYtngTdVUDWNfnOUVWk3N4rmxCruhgYSRQ6+BOi/bT/qG/wJz1F/F0/smFJ3aBlyb
         s12f2km0ysMWEakQaknkjc4SxWDnNxTqhEqI0ZZaFXHlypWDARn3t+mNY6aI6Rj80kAf
         qwYOmG839CBHDOK5Mh2hCceXzpEINIwDHsYT1dWmOrk/oMjb/2WjmoSDqEuK+nA+CXGy
         vbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751388586; x=1751993386;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2MPZ/nttgozW2CJl0qQM5vkBsxfCpf1zX+n1SSNYD4=;
        b=NTLjM/jm6AedkTEiwCq+JMqpruqmdd0/3ZjeP7Zjud21Dc01W0i/hYzDHSoR7hE09a
         UbqbDdhNmOXZR56GrXgSLJcgJXTQBz55mkmxKoMlJxyqbjqmWQsaMr6d7RTatksWRybk
         aWa+eqlfedZLUNq+9i7QVCXFXSts4ip+4MCiXBUcu/zsktP8H4javgDPQp+Sd+vOwp1z
         2AZGKFfVogQb3lVytJisueQ/qzxQxnOpmtdh57SkoPryW0jYBVooin5vUVVN11i2ay7W
         0KaIZGars8nrefdllQrsyxbI8eI9SCEtWW4s41lC3Rq1G0CRkXR3lyvM6+w3dpfjenof
         lwfw==
X-Forwarded-Encrypted: i=1; AJvYcCUBgIlKq18g3JqEFHnlvT38yR/u2BtURCCY8RrrI85gxzYmwPbaK6RVPtr8hdq75jWwjj/brUd+LN8=@vger.kernel.org, AJvYcCUDNnjqQ6NEPbUxSEa5xwQN4WjipViOynRuNQD19VN3yBPyRHMrB14g8kqh8QI4GZ70Nw1JVuUf@vger.kernel.org, AJvYcCV3JkWmjl775H8YDvHkSrUd66TAYyCEn/2z+8N5ANSYUxzNCXh35YUVKmcPl33lVLs+UxoHqSPSbnVeEJFr@vger.kernel.org, AJvYcCVEugHHTIDMEYzwqZXxTdsTg6fuMUb8nvU97qgjd9Z86+n/M8ip46AGi6F5zQsYJU+v05L/1mLSHzLONLvaC2wa@vger.kernel.org, AJvYcCWRlUa84zTkuxMpzpaOTB3St5swl3Rbnu/8iL/0wdBLvRqPYOFb5e5NamaORNGbDI35tSa0N2Ug94E6@vger.kernel.org, AJvYcCX/VY+cqUhovAApfTHIUY91eaBIZ9+dA/4t1NC+MljrgedjtJGWIjiOkczXZOqkXBec6FVSXP+vEYb9@vger.kernel.org, AJvYcCXGXAQnIWcC/wX6oJXxsiIs2ijID8tddTV+9ROIXdHh/yTFyz6DmMgrAgGJIgeIO4Q0iDZfBFyfdgCW2nI=@vger.kernel.org, AJvYcCXpToal4n4y4htxSgehW/+ZBvdds9Cz4rq2IfndRm7ly7n0UBRgr88VN0Ot6HS5J0O57oh1QzxEIQuA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0wAQYrKUkX7YSm9zNmMM5EUTDH4ksdEdYqzLhR1RNSIybnB1f
	jxqkhsr5i9qARWQh3dXKjd7LaOy/rnDCXTaESeOBV+pn3FGn97J38P2vtFhGC1Kxi5OnSA==
X-Gm-Gg: ASbGncuyyFJnxzEiuk9KZCcm8Fey7cgh5Nux07zaS9xlXWNxtuGuGmtJEt9NSGZq6iX
	XhcQf6WgYI5zT+1C71aLTplqSdR8qad4jwxPKT8IbzwDLXhnOtkFjbL+jSe0prO1DYqYYAWBKFc
	jP3htMcFCSE3fxJB1zZfH2xofJJGHalgHzGqV6OmMjrZMf3ziJvlUXMONYF1L9U9e9O38Zqp4lV
	bZ8/suGLC76PPq5f/DE8U+Lv4sH5teWwPKh+y/dSwRfaBRBKcOqQF9MefROx5R9rVuMRJIQ2JFl
	uiwNu2qRLAByO7JZJvObW65pxGvLCo71OJtQB5xsIfXQzAYefgGPN3YX4X0bwIlec1LzsBOOz6K
	0dFjaLA7berwk3TUYkguzOwSDHRnnnjR9X6wdTLo9A+xCaz/rSuzwAi6YUGV9XJSBfy9ajFzmMg
	==
X-Google-Smtp-Source: AGHT+IErOPajH5NpKy+98P8uIMtP+7Sv92CbaWFjkUgC+aZIuPj2FffzTYSZ4LICfiCKkPgNqjM6zw==
X-Received: by 2002:a05:6214:2c0c:b0:6fb:5634:d8b4 with SMTP id 6a1803df08f44-70003c924e0mr282506236d6.30.1751388585870;
        Tue, 01 Jul 2025 09:49:45 -0700 (PDT)
Received: from a.1.b.d.0.e.7.9.6.4.2.0.b.3.4.b.0.0.1.1.e.f.b.5.1.4.0.4.0.0.6.2.ip6.arpa ([2600:4041:5bfe:1100:70ac:5fd8:4c25:89ec])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44317e285sm793098885a.45.2025.07.01.09.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:49:45 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v13 0/5] rust: replace kernel::str::CStr w/ core::ffi::CStr
Date: Tue, 01 Jul 2025 12:49:32 -0400
Message-Id: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwRZGgC/3XQwW4CIRAG4Fcxey5mZoBZ6Mn3aHrYBVZJqxh2s
 6kxvntZEytqehyY7+cP52YMOYaxeV+dmxzmOMZ0KAPKt1Xjdt1hG0T05aAhIA0EKNw4ZeFSDsK
 r3vZskcANTdk/5jDEn2vYx2eZh5z2Ytrl0N0SFBi0qCVrXpMx0AoSc+dTTvP4ddocc5rSYd/F7
 7VL+yVyF8cp5dO13sxL8K0IVUVmFiCMYus8e7KD32z/QpYic/uvbIv0HZpyRaCkeZamlrKWpkj
 Xy4E4tIYNP0t7lxLbWtoiNXp2ThMNTM8S4U41qZoiFMsKqbPKW9/qF4uVlfBgcWnsrQPXu97C6
 7t0t4z2wdLyw+Csa3ulLUBtL5fLL+m7iYtIAgAA
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1751388582; l=7832;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=/qQcnfly8w24mBV0CT4kygIoVuN+6OgNa9+itRuSa8w=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCuP7Urv9z/siV6f8XTqTQpoVWclV+fjft8Q8EqPZfzkAPRIiSJSPXP155juV56KoUHsGcwASN2
 2GIuaO535xQY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
have omitted Co-authored tags, as the end result is quite different.

Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vadorovsky@protonmail.com/t/#u [0]
Closes: https://github.com/Rust-for-Linux/linux/issues/1075

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v13:
- Rebase on v6.16-rc4.
- Link to v12: https://lore.kernel.org/r/20250619-cstr-core-v12-0-80c9c7b45900@gmail.com

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
 rust/kernel/kunit.rs                  |  28 +--
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
 rust/kernel/sync/completion.rs        |   2 +-
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
 55 files changed, 543 insertions(+), 521 deletions(-)
---
base-commit: 769e324b66b0d92d04f315d0c45a0f72737c7494
change-id: 20250201-cstr-core-d4b9b69120cf

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


