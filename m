Return-Path: <linux-kselftest+bounces-34671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88735AD5191
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6B0188E47F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE60262808;
	Wed, 11 Jun 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f14ql+XQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D54625F78F;
	Wed, 11 Jun 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637421; cv=none; b=TSVp/+bPeOR8N5sLwPa9NayaZLISoy6l8OKtNPiv8tiBfegOxet0OasQxmYAX6VLY489RcHVS7m0S+/pF8gqbiOsi2MYsYCBxR2KKDAbqTUS0J4z/MaiEAJTUI32OZhO6DayITQvr5Zs3lJy3RpDZRCm+1q7hMJD94xwKD3jpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637421; c=relaxed/simple;
	bh=KQNN9iIZnLboKdcmqrM8NPGe101XcbFuNXnOZwEAGSM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nB5xEnwbHj84KindttIoUgn5Zc9t/O+3mLXZER9oXMgB+UTC66GmmKcPfdtQTVBpFhmAM4k8lfCOULw9Ck97nge5c+evm1lVuImS2EWdxZ0NAWI+2fnl9h2H5BEH9K4GK537B3DF65P5BKL500eAAWj6Rj3G6M0Y/SBs6pIl+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f14ql+XQ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a4312b4849so78948731cf.1;
        Wed, 11 Jun 2025 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749637416; x=1750242216; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ouktr7NzISP8qHlPn0djqUJNZCl5UN30Gq1Q/RrQ/jc=;
        b=f14ql+XQfycOgd9LU6XknxR79R5p0hnMWiABXn4QqJYQcR4JehQMk1eS0wI4GjcEDg
         B+9GLKx0cu0UaI5zN9jCgd4NBptCl8/XRYQWlOUyAsXW57PObKVEZD8kwoz3ANDpKmcq
         HuyzpFuVz6OkDZ7aGh+9qu1WsKpwtmxNhBnGESv/6zgw399vt+oS41os1NuAH8IycQZu
         EPZSi3437fnOacxgFUYm2UzsVJuf7Dkii8lIxaq9uZ1av7rld1jICg5gVtz0BVt763+q
         RBbOh50MaZ6YsYOlWanWWQXONKUn/HbgilZMyVEtYKBIuD260c2AMX1PHz7iZMZ/+lNh
         L+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749637416; x=1750242216;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouktr7NzISP8qHlPn0djqUJNZCl5UN30Gq1Q/RrQ/jc=;
        b=rgKaezLE3R6pzo9lPG+WxQele56VzQ6IX7LaSijMATGcBUM9/nV8vBCgZM1k/P1Q+z
         /bzNgezuQJw1oDihF92RRPHd8L/Z4iKg1D0uYYvfvs3t7vUM/NxBsJSxSi9ZU1st0rPC
         PGm6g1pIeN+YCpJoK5wq++qCGA33walkwqOLesxUuoyUF4CWUtcMJmQuIpSmf5nV3GF/
         TglqEu8aS5LjwOPr2M5thmbD1MuhhoGEY9WJA1jPs56GddjDGYhpUOSv6lkx9bvmRPHx
         +E6EHt+MjdRzQnBDZ67SxqyLxT18CdYJVbxIHlK3JR1UjAxqn+yWxyI6w4RUnZm1AGNi
         5uHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0pfLml+slv2giakV3YeDE+nlYRw34T6DsrZg6UJqcbeUUsi+7ND0J1RAST+Ejcts6NI3sDMeC@vger.kernel.org, AJvYcCUlLkJ8CTc+2ReQ3Xg3/DuptWO2qOtZfP+rC4VAA7XYoJrUOJN4uLKrLX9b9pO/2aQch8/KHg5XQ1c0@vger.kernel.org, AJvYcCVlavXLHbPffWlRL7M3SIOzdHiL6V0sN5MoFBLpvtGCCByYTvL+YMrL4r/XyKE4ugkYU3JH9ARulVzGM6U=@vger.kernel.org, AJvYcCVrNVtvn6PYB5/B41448MGl/0JZ2jq0okQ4sqFq1vor/Nx9w50I2i8k6KakWS1D2nj6iDL5JFDbMYnS@vger.kernel.org, AJvYcCVt0EwuBZbwO8/Nn/o162RE5jFBlOs44wcH9xHlR8odX5Hzw7m0MZXTgFwyO22uYkgQ9yoanZlgQxq5AivyzdQ=@vger.kernel.org, AJvYcCWvCHg4pi5PMw9Z3KwGZk8ymdddny85UC3dZlWFMj32G9jO79bRZ9Du3vr/0W9K+0CdgJ/nKybjoZ76aB1n@vger.kernel.org, AJvYcCX/oBlU10BlXvKmy7tes1EhpTHGKYoeGN08GHgHpVoft6MeuQIr8ol+1j4i3tMbPtLOB79Eyj/E5Hz1xQ5IpjNc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy9vahxTmEYPlUwOIO19QnZdUaXYqKkciymhyz6JdqNG+24hPV
	wIB5tw99ZX7uys+IEbNckUN5YaMc4JvGgJ2A4KR5rNXukAHOCWYVlbrZ
X-Gm-Gg: ASbGnctT714iTjT7iGuGL9YQnkUwROSvD6MdcM/PpbD2ZY2F2ru6305ksZHi5WsJTDH
	nyG1CBQtyvzYRjq5UyR1Jk+MnLIm7/o7GrMmTdWyEpqH38dFn6W1pG2YxAlqEet2/SnE4gyxvO0
	TWBSmOYQuJsQf3lao/xdcT9LESAEaUCYTfH/4Vx3+JtNpy7EkmFw2GcKSI3yMIeO56d3nu2lZXU
	dQwO4LZ9tVe4Cm6gDP2GIrchwqIETzXsYP9RuqLykO7KjJLGT/CW2/k0h81BuWY0ZOMOfA7IvOc
	Zi2ctyEY6RQiVAlKeTfyapg77PoRqrnbeWTXCambN7h5LzAOGo5FxZk8TuY9ZdZP8Z8=
X-Google-Smtp-Source: AGHT+IHsvSPSRKL5BLyCiE7wrGxoztQqmqBzrCOW1KhgcOy5ZWe+lay1sWUZlMSeWRX1BrOpW7T/1A==
X-Received: by 2002:a05:622a:2446:b0:4a6:f99d:9633 with SMTP id d75a77b69052e-4a713c30c5amr57226931cf.31.1749637415620;
        Wed, 11 Jun 2025 03:23:35 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([204.93.149.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a61114ff18sm85664341cf.6.2025.06.11.03.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:23:35 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v11 0/6] rust: reduce `as` casts, enable related lints
Date: Wed, 11 Jun 2025 06:23:24 -0400
Message-Id: <20250611-ptr-as-ptr-v11-0-ce5b41c6e9c6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABxZSWgC/23SyU4DMQwG4FdBORMUO87GifdAHLK2I9GFmTICV
 X130oJEEjhFjvTZifWf2ZLnKS/s8e7M5rxOy3TY1wLg/o7Frd9vMp9SvWAoUAkpDD+eZu6X24E
 QwGpTIiViFRznXKaPW7fnl1pvp+V0mD9vzVe43v7bZgUOXFlMQiug6OzTZuen14d42LFrmxVb6
 jqKXHBUSQufHGIwI5UNBeqorDSb4DUIsoX8SKmlqqNUacBkMAKliHqkqqX9X1WlKqiCUDxK8We
 qbij2D9aVkksQTEmETozUtLR/sKnUGh9IIZAJbqT2l9KwYVupNNIKDUpSLiN1DQXdUVcp2BzRh
 ZqUIkcKorW2z4S4zk1aJjROGN8t6vIdtjm/vdfEnn4Sd7l8AZwWx6LPAgAA
X-Change-ID: 20250307-ptr-as-ptr-21b1867fc4d4
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
 Tamir Duberstein <tamird@gmail.com>, Benno Lossin <lossin@kernel.org>
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
Changes in v11:
- Rebase on v6.16-rc1.
- Replace some `as <integer>` with `as bindings::T` and others with `as
  ffi::T`. (Miguel Ojeda)
- Revert explicit `ffi::c_void` import which is in the prelude. (Miguel Ojeda)
- Link to v10: https://lore.kernel.org/r/20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com

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

 Makefile                               |  6 ++++
 drivers/gpu/drm/drm_panic_qr.rs        |  4 +--
 rust/bindings/lib.rs                   |  3 ++
 rust/kernel/alloc/allocator_test.rs    |  2 +-
 rust/kernel/alloc/kvec.rs              |  4 +--
 rust/kernel/block/mq/operations.rs     |  2 +-
 rust/kernel/block/mq/request.rs        | 11 +++++--
 rust/kernel/device.rs                  |  4 +--
 rust/kernel/device_id.rs               |  4 +--
 rust/kernel/devres.rs                  | 17 +++++------
 rust/kernel/dma.rs                     |  6 ++--
 rust/kernel/drm/device.rs              |  6 ++--
 rust/kernel/error.rs                   |  2 +-
 rust/kernel/firmware.rs                |  3 +-
 rust/kernel/fs/file.rs                 |  2 +-
 rust/kernel/io.rs                      | 18 ++++++------
 rust/kernel/kunit.rs                   | 11 ++++---
 rust/kernel/list/impl_list_item_mod.rs |  2 +-
 rust/kernel/miscdevice.rs              |  2 +-
 rust/kernel/mm/virt.rs                 | 52 +++++++++++++++++-----------------
 rust/kernel/net/phy.rs                 |  4 +--
 rust/kernel/of.rs                      |  6 ++--
 rust/kernel/pci.rs                     | 11 ++++---
 rust/kernel/platform.rs                |  4 ++-
 rust/kernel/print.rs                   |  6 ++--
 rust/kernel/seq_file.rs                |  2 +-
 rust/kernel/str.rs                     | 14 ++++-----
 rust/kernel/sync/poll.rs               |  2 +-
 rust/kernel/time/hrtimer/pin.rs        |  2 +-
 rust/kernel/time/hrtimer/pin_mut.rs    |  2 +-
 rust/kernel/uaccess.rs                 |  4 +--
 rust/kernel/workqueue.rs               |  8 +++---
 rust/uapi/lib.rs                       |  3 ++
 33 files changed, 128 insertions(+), 101 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250307-ptr-as-ptr-21b1867fc4d4

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


