Return-Path: <linux-kselftest+bounces-31130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED22BA939B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 17:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC5F8A763E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956F0212B3D;
	Fri, 18 Apr 2025 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2goS6fO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA364A8F;
	Fri, 18 Apr 2025 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990647; cv=none; b=iITvo3owo9zL/Oyb9MAr3I2J5bsStYN7Pr0Oty6z8cTdWWx3KlSt/eFk2EULmDH2pIReTvfr7zPGP2orB/HC7N6AxBErzkCPx3scTA0O7P9qblzYLk5QhVyGNDGdc545N831cexINLXIsnqmqAT/aYdIO1xapuFGvw6+kDmWmO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990647; c=relaxed/simple;
	bh=6yV05zckV7RrLLMQSAkMWbB6otiAcLXGlIY7TlEpreI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VAg+DvibD4EpfyV2Op7MTZ0VUwfphPmnyvh0ylT10Uh3sTuLCpL9L+4GwliX7+I5KMGhLIG/NO5hmA3mJ/MUFQcwivZbjBvehVhjPVLPCptZKjRRPNEUdjbc9FWU/3V2RZW/fAc8ZZ/sCky9b8HsMEdFwyp7fOt7qSmtpM3hzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2goS6fO; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ecfc7ed0c1so17537126d6.3;
        Fri, 18 Apr 2025 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744990643; x=1745595443; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MNn1NZDtkPGBUMeP0IbnBbfp3uTHDqgJP4OSlJr6Lew=;
        b=e2goS6fOiYtdvLVYu/yfOE7gstBc7ZoGJPpfkC/8g6uO/KOZkuz0TYy44f3ZMfs9FI
         19UdwYG02UbodW/DSb2Co3MCrQc6s+YN8bwdeh6MNXge68XytH0+txmDqAta9LJ2Zljz
         0Rz+gZQhW+ccQdKyvQ30+mpBlvRk7SNdhKyVWRFSSjoPI/0a6iu+Kc8f+7yphyzEioVM
         dGJ/dQL5pTbUZ1S36SBoK3utonyVtGUDD045PUGN5yhhJ0lqMpP9f4uBsB01cIi+bGOy
         AVqJg4VBdt51qL97sWYpphhu5+uO6vKanm6idmlGCCJBzG3v/Ydu0i+Z/pjIwaU8XHVc
         lP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744990643; x=1745595443;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNn1NZDtkPGBUMeP0IbnBbfp3uTHDqgJP4OSlJr6Lew=;
        b=hFF9Y7UUBWgJwyo1VjSV1Jn22SkPkgBzrv44szv/5G1y4yuXAxWFV88F3r98mqK8JP
         nJycHkReeL/k5JQ0c68zXT7RogAvumO3RuSKBfAgHVzkDeSTtacsSVzgQNq2fCL1L0Wl
         mOfexac8MAtn22vfB9zq7c7kfZu7/h9/2Gx5jVeFnEl/fbmDtMERPfm5MyWfDrY63qtY
         JdpWoa1JIuG/rx3VT2a5tCCtaHY20aUplch55HmlDsdD5cr5A90S6yH5gIm6k3X6Dr+l
         /ZQ4QzRdUw3o7qTjLimZ/i/VMF4xPAtAvV6aDvWLq3TXmcPNdTgVscANo9z5tuhVoZb8
         wXSg==
X-Forwarded-Encrypted: i=1; AJvYcCUF+DLV6drQqkg/z0WlEyr4c3XZES1hkUkUgyyYY9LPH/9auQBp6rNHqxjv6xJBU9So8nn65JOJNHAa@vger.kernel.org, AJvYcCUIE1B/cnhJpSRTcLPiFNPhKjBbCT6tKLHDLahGoZHTHXnyv0ah1dZ/F4mN41DWpoLsr30Oj1U3tLPY@vger.kernel.org, AJvYcCVK7YRbtxif35VXTl+MtTkmAM6C3tVHvhcAqnYpf1j/cp6iTH9uUwC/4zbO45PefLsZc5bAU5fMI4mQpiacuS3C@vger.kernel.org, AJvYcCWAFbqDG3TpXC+322lvvBP7AB8bU5DW5foXa7QzTWIPUbIfeH56uv7QYI8WJmJZg6O99cvORcmF@vger.kernel.org, AJvYcCWELOpd8C2WbBahxJPHNZFXu9nH4vSqKFr4UM2sTbJ1xFkdnAz0wNPljGvZaBg+M3w28AFO3RMM415Uv+wh@vger.kernel.org, AJvYcCWi7J6tGVJJ6RomLYSeRd/8IYSYmVvDyrQncWjsUKMuhshlguB9h2BnCaDc9sjeifTeuzHHffT4zx1bHDKtV6s=@vger.kernel.org, AJvYcCXFQCSZ1ESNPTnVu52RFClLW5r32h7f1QfS8sAAMC9JTNM90Z4I6gcg/TtPwYg1+Pduwd6z1/A5e6569NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEIEaFHHTlVLvvj3z7ic8tdG8HEZa7R/GircyFXUJDawO+pprC
	DNDfj0iQBSoi+4EgSF+BV3sXqa2v5dxETW3JHkwJc3kEuLBTiiFiMGhAoGwS
X-Gm-Gg: ASbGncugMDFGxipGNtFafFaRxsKp5NAV8SDsxGAKI2zAqo9eEkdApJBQ3wmMda+AeY+
	r5f2jcnD0hqH106DgVmBCZR7JzDdXQXPhpM3VxHWM9oPJ5lNqSbzDybdUgHpoKMmc5PWsS3+O4N
	vXn/oNzcaJGZ5biSv31n999gzwW1mxVaw0vL8wjnrPIePs/0ALfrHCVqH9udgTJJ6zJbhESEZ/S
	dWt+4C0LtsH+D/wslIfMizAnN8ouRucORexnGdZQH+aNN1Gk9n3du0N865/mDmCN1278v1U2WO1
	ddeTH4fCA0koqbW6QmTHerYV3vF3yUm1kFFIJd+cyK3grUixTJV+mqZ8Jm5Qegs7Z1jxHw==
X-Google-Smtp-Source: AGHT+IGsINGOaw8h71E+Kqo50KbuJmjq29G601cB/VyotMeJQ0Xm48udFufoI1x16eOoERbdsiMBYw==
X-Received: by 2002:a05:6214:2349:b0:6e8:9866:7398 with SMTP id 6a1803df08f44-6f2c456c668mr45571206d6.22.1744990643440;
        Fri, 18 Apr 2025 08:37:23 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:7988:e5e5:1f4c:be78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c21d9bsm11623096d6.96.2025.04.18.08.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 08:37:22 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v10 0/6] rust: reduce `as` casts, enable related lints
Date: Fri, 18 Apr 2025 11:37:16 -0400
Message-Id: <20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKxxAmgC/23SS24cIRAG4KuMWIeIKl7FrHKPyAueNlKm2+5uj
 2xZc/eUx1JCd7JCgL6Cgv9DrHXpdRXn04dY6rWvfZ54AurbSeSnOD1W2QsvCFRolVZePm+LjOt
 9QEhAzrdsihEMnpfa+tu92s8Hnj/1dZuX93vxK3yu/rfMFSRIS1iUs2ByoB+Pl9h/fc/zRXyWu
 eJIw46iVBJtcSqWgJj8keqBgtlRzbT6FB0oQ83EIzUjtTtqmCYsHjOYktEdqR3pvlfL1CbbEFp
 Erf451Q0U9xd2TE0okHwrBoM6Uj/S/YU9U/IxGYtgfApHSn+pObwwMdVek3JgtantSMNAwe1oY
 ApUM4bESWl6pLevvCz15ZVDt32FRqS4Vsn7l76dTyo2bC5VSAYJNNnkgHIix39tXC21KAoxkxi
 zej796SLP0xb7VBc5N3l53aa6rjJxF4UfQhOVM4fy4Xb7DXSuQXYFAwAA
X-Change-ID: 20250307-ptr-as-ptr-21b1867fc4d4
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This started with a patch that enabled `clippy::ptr_as_ptr`. Benno
Lossin suggested I also look into `clippy::ptr_cast_constness` and I
discovered `clippy::as_ptr_cast_mut`. This series now enables all 3
lints. It also enables `clippy::as_underscore` which ensures other
pointer casts weren't missed.

As a later addition, `clippy::cast_lossless` and `clippy::ref_as_ptr`
are also enabled.

This series depends on "rust: retain pointer mut-ness in
`container_of!`"[1].

Link: https://lore.kernel.org/all/20250409-container-of-mutness-v1-1-64f472b94534@gmail.com/ [1]

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v10:
- Move fragment from "rust: enable `clippy::ptr_cast_constness` lint" to
  "rust: enable `clippy::ptr_as_ptr` lint". (Boqun Feng)
- Replace `(...).into()` with `T::from(...)` where the destination type
  isn't obvious in "rust: enable `clippy::cast_lossless` lint". (Boqun
  Feng)
- Link to v9: https://lore.kernel.org/r/20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com

Changes in v9:
- Replace ref-to-ptr coercion using `let` bindings with
  `core::ptr::from_{ref,mut}`. (Boqun Feng).
- Link to v8: https://lore.kernel.org/r/20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com

Changes in v8:
- Use coercion to go ref -> ptr.
- rustfmt.
- Rebase on v6.15-rc1.
- Extract first commit to its own series as it is shared with other
  series.
- Link to v7: https://lore.kernel.org/r/20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com

Changes in v7:
- Add patch to enable `clippy::ref_as_ptr`.
- Link to v6: https://lore.kernel.org/r/20250324-ptr-as-ptr-v6-0-49d1b7fd4290@gmail.com

Changes in v6:
- Drop strict provenance patch.
- Fix URLs in doc comments.
- Add patch to enable `clippy::cast_lossless`.
- Rebase on rust-next.
- Link to v5: https://lore.kernel.org/r/20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com

Changes in v5:
- Use `pointer::addr` in OF. (Boqun Feng)
- Add documentation on stubs. (Benno Lossin)
- Mark stubs `#[inline]`.
- Pick up Alice's RB on a shared commit from
  https://lore.kernel.org/all/Z9f-3Aj3_FWBZRrm@google.com/.
- Link to v4: https://lore.kernel.org/r/20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com

Changes in v4:
- Add missing SoB. (Benno Lossin)
- Use `without_provenance_mut` in alloc. (Boqun Feng)
- Limit strict provenance lints to the `kernel` crate to avoid complex
  logic in the build system. This can be revisited on MSRV >= 1.84.0.
- Rebase on rust-next.
- Link to v3: https://lore.kernel.org/r/20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com

Changes in v3:
- Fixed clippy warning in rust/kernel/firmware.rs. (kernel test robot)
  Link: https://lore.kernel.org/all/202503120332.YTCpFEvv-lkp@intel.com/
- s/as u64/as bindings::phys_addr_t/g. (Benno Lossin)
- Use strict provenance APIs and enable lints. (Benno Lossin)
- Link to v2: https://lore.kernel.org/r/20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com

Changes in v2:
- Fixed typo in first commit message.
- Added additional patches, converted to series.
- Link to v1: https://lore.kernel.org/r/20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com

---
Tamir Duberstein (6):
      rust: enable `clippy::ptr_as_ptr` lint
      rust: enable `clippy::ptr_cast_constness` lint
      rust: enable `clippy::as_ptr_cast_mut` lint
      rust: enable `clippy::as_underscore` lint
      rust: enable `clippy::cast_lossless` lint
      rust: enable `clippy::ref_as_ptr` lint

 Makefile                               |  6 ++++++
 drivers/gpu/drm/drm_panic_qr.rs        |  2 +-
 rust/bindings/lib.rs                   |  3 +++
 rust/kernel/alloc/allocator_test.rs    |  2 +-
 rust/kernel/alloc/kvec.rs              |  4 ++--
 rust/kernel/block/mq/operations.rs     |  2 +-
 rust/kernel/block/mq/request.rs        |  6 +++---
 rust/kernel/device.rs                  |  4 ++--
 rust/kernel/device_id.rs               |  4 ++--
 rust/kernel/devres.rs                  | 19 ++++++++++---------
 rust/kernel/dma.rs                     |  6 +++---
 rust/kernel/error.rs                   |  2 +-
 rust/kernel/firmware.rs                |  3 ++-
 rust/kernel/fs/file.rs                 |  2 +-
 rust/kernel/io.rs                      | 18 +++++++++---------
 rust/kernel/kunit.rs                   | 11 +++++++----
 rust/kernel/list/impl_list_item_mod.rs |  2 +-
 rust/kernel/miscdevice.rs              |  2 +-
 rust/kernel/net/phy.rs                 |  4 ++--
 rust/kernel/of.rs                      |  6 +++---
 rust/kernel/pci.rs                     | 11 +++++++----
 rust/kernel/platform.rs                |  4 +++-
 rust/kernel/print.rs                   |  6 +++---
 rust/kernel/seq_file.rs                |  2 +-
 rust/kernel/str.rs                     | 14 +++++++-------
 rust/kernel/sync/poll.rs               |  2 +-
 rust/kernel/time/hrtimer/pin.rs        |  2 +-
 rust/kernel/time/hrtimer/pin_mut.rs    |  2 +-
 rust/kernel/uaccess.rs                 |  4 ++--
 rust/kernel/workqueue.rs               | 12 ++++++------
 rust/uapi/lib.rs                       |  3 +++
 31 files changed, 96 insertions(+), 74 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250307-ptr-as-ptr-21b1867fc4d4
prerequisite-change-id: 20250409-container-of-mutness-b153dab4388d:v1
prerequisite-patch-id: 53d5889db599267f87642bb0ae3063c29bc24863

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


