Return-Path: <linux-kselftest+bounces-35029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C756AADA3BD
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 22:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07873ACF3E
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 20:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD2927F4E7;
	Sun, 15 Jun 2025 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxM1MIqJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5B329A2;
	Sun, 15 Jun 2025 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750020913; cv=none; b=L2wsLd5zsWM/weC35N5++wcBm/nbmGPho7dgLENPRZE1RiXMQwhtiSrXfBkehUzp7T0YThtEi51NLfmGDPiX9b6ZxralUpEQ+Gp7HN9HYEUfu7L49k2yxmiFQXhR6kaCons3604goP6CMZ8H1VTbiAdZIEvkUWhrM/Xofbf0ZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750020913; c=relaxed/simple;
	bh=v82dxHDQ3mvwSjfyy8FtVEUDHKNUE3A9Bfy2HuDu/M4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dHGieyfRjI89qWjwU2nIbVsCFBBhqE4AGMUPRBVIAdJa6Fwppz4VIN1277Hz83i63r59kE7qQRZ5aFli4EieNAwPbQlVvo6vAMI2+vf99OaVE7vDIJflcEEDE3fNpRcgg835RnZahrltgyQsZ7yg3X8L+elqYr6C4MrGrokzA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxM1MIqJ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a43afb04a7so28670321cf.0;
        Sun, 15 Jun 2025 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750020910; x=1750625710; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j16wuFNqkdjB5TUdH0zffnUQd8bgZAgYJK6kemWeowM=;
        b=PxM1MIqJiuwhplaUJMs+JRAS8s7KTXiYia/ZccIna3EOe66nYNOtT8zX85HNt11Qyk
         pshOUCKnGJKWAbkG3aU1GZ/MHYRjvEoji8XmdgMZ49Ib5YkYMrxiJDXXKh87N66CZg3r
         6MHLHSGWopCTWtfMhoSIXjDLqmNxxZWXUyVtz81lsfzNULPIRTTcVodabaJptBdfMjIM
         m448KzgHhZbmrmyyixVePjyaObijc9x/QJGPZBAaFORXk2qIg6wjgrj78ApEywwp8v07
         NL791QMoTeqbugY8a40wzRHbIQ7ygbJAmBKBEM2EKccwyhi3OrIUFKhLn8BUIpZryi6g
         svvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750020911; x=1750625711;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j16wuFNqkdjB5TUdH0zffnUQd8bgZAgYJK6kemWeowM=;
        b=rufvTUhyc0ktwad0axIASLOeT+vzJucHMekgZo/qJRhC2AvKlM2GwxBpOwd7K6XF2r
         yA2N2lhTVwRV2Vj0g6mTbIaX7dTuiHL3hNF1RFfG8wcC16cgNOgGuHRGlc+Wb1wfmuuJ
         QhnPrLIg90rJF3oUZYVSIGHhSsUmVC6PjVtXyaIySq9Xs5YGchVzfWwEBUzGEum4R/BT
         eJOOe7QSXF6JXxJL5BLcZsEeCO/9jHWdb4czw+OMi9PUFAWBSs9uMAFOLPsQbTFkHclf
         kxK1s7w8AfwE8qoJAGr13Y2BiYzqPG3kBlOlTJNhzJy9QJK9gS6Bu45BaQIzITxznF8w
         hR1w==
X-Forwarded-Encrypted: i=1; AJvYcCUJtIDatJLsxjyNaexXka4wxSq4Wrx2f/yNgTll3vHkuq2PiybmexTNsQ4wcvCzmcDbaq3RxuHkkBA=@vger.kernel.org, AJvYcCUUg3LqofKnFC36D5Z1R77YlhimiVaw9ioe/Mc4b+A9o5jEUgCzNlwP9CUa9vOqKhO3gnH2rK+x/F3mK2lW@vger.kernel.org, AJvYcCVE5bk4gBF+6RoeoWcZ7rdpvHq3XzCsjY29mQPFi7w+C3j027wZRxtBLgw73ikC7BwhRIUOPIY1eIzk2vbYwrU=@vger.kernel.org, AJvYcCVEIgLIV+okzmENU4shlnAX2S91sR88jaq+jHKHJ6upa+AlbA9JdbArtHhUQ8neGGC5rPVz9LHx@vger.kernel.org, AJvYcCVFP+NN53frCHVcljU5l4f20Wsog4LBxBz5bk4ooARRUDE3OwGgjtyJ6ApXrp8PujfijTgHxGbp5AiD@vger.kernel.org, AJvYcCVM5Fr+WaaqdskdAuHSuGL5RK/vnIRWqv2X5CJjfqw5AWvvFRdmQXOyNp/TWcDCDjRH9q0otuayLW9UMJ4=@vger.kernel.org, AJvYcCWHNwliwKE4WBQ6JE4jDFCSambWixEXj48IUTXC5Y2WrC4Y8e4CCqIx1jRlG6uORGKMLo5atRVHywR2@vger.kernel.org, AJvYcCX0I2qAcIV87JSr1NjoXgU4rB4kcPWck1IcXBVbhpHsdZBQuCMtiFlrhaODGPIvq/l8ar5yHQ2oMkZUaOIVBSX7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3jJ9/nwdZlq3lRs1+xhmkcL3SN/I99vGBy+xhA3ljFALcslk3
	74naphXHX1Bt6stntqXNW/FUeEtSJh/V5jWhRwzmOtJxlojNyON1c8Bd
X-Gm-Gg: ASbGncuhOi7J+dMH6DKuYRyCZ8TVKl09suVgyMdf/d+X9bLBbxpnGSbuIYW/HOX5bjl
	Iv6wEokEN4e2mTFC2b9bxYvKddSIW8R9XwHE1z20xBZxOO1WcS3sc61KbGWVsauTo26TEctl2Y5
	dx++t0pBy04r6LDs2RWDW4Qa4H0fkgl1iIGo/HQueaBjbCpsD/fub48dxuyBjuPUjzznAwWNB7L
	HaWZtfk4UmRRroyqY0C08BLp0ewTdmlfsHBNtieRHbhydvIS2EFX37M6A3k8zHndCHojPnL9yHG
	cej2P/MSSZWswDoNyfAc3qMZGxgm+LFAxqZZG3g6GUiN5bIt/GjcTzGXVRfvUbrIvedZ/1RZtyT
	hi72s
X-Google-Smtp-Source: AGHT+IGd7UFbSuHT8VxGXjaCZlDB3nAmPpggFjehtIlQAqgZaWIhMSzFnKX+9RpIkD9GXqlEWnKWJQ==
X-Received: by 2002:a05:6214:d47:b0:6fa:fb4f:b582 with SMTP id 6a1803df08f44-6fb47627690mr98707346d6.6.1750020910309;
        Sun, 15 Jun 2025 13:55:10 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:b0c6:92db:d807:21a6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c84148sm43468176d6.109.2025.06.15.13.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 13:55:09 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v12 0/6] rust: reduce `as` casts, enable related lints
Date: Sun, 15 Jun 2025 16:55:04 -0400
Message-Id: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACkzT2gC/23S204DIRAG4Fdp9loMMwwnr3wP4wXHdhPbrbt1o
 2n67tJqIlCvCCTfzAD/eVjSPKZleNqchzmt4zJOh7IBfNgMYecO28TGWA4G5Ci54JodTzNzy21
 B8GCUzoEiDQUc55THz1u1l9ey343LaZq/bsVXuJ7+W2YFBkwajFxJoGDN83bvxrfHMO2Ha5kVa
 2obiowzlFFxFy2i1z0VFQVqqCg0ae8UcDKZXE+pprKhVKjHqDEAxYCqp7Km7V1lodLLjJAdCn7
 XVVUU24FVoWQjeJ0joeU91TVtB9aFGu08SQTS3vbU/FHqXtgUKrQwXIEUlHJPbUVBNdQWCiYFt
 L4kJYueAq+taTPBr32jEhG15drdPRRUgVIALYaCQ5KeIKhkQ/NBl5+kzun9o8T99BvXy+Ubr32
 BVgwDAAA=
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
 Breno Leitao <leitao@debian.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
 linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org, 
 Tamir Duberstein <tamird@gmail.com>, Benno Lossin <lossin@kernel.org>
X-Mailer: b4 0.15-dev

This started with a patch that enabled `clippy::ptr_as_ptr`. Benno
Lossin suggested I also look into `clippy::ptr_cast_constness` and I
discovered `clippy::as_ptr_cast_mut`. This series now enables all 3
lints. It also enables `clippy::as_underscore` which ensures other
pointer casts weren't missed.

As a later addition, `clippy::cast_lossless` and `clippy::ref_as_ptr`
are also enabled.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v12:
- Remove stale mention of a dependency. (Miguel Ojeda)
- Apply to config, cpufreq, and nova. (Miguel Ojeda)
- Link to v11: https://lore.kernel.org/r/20250611-ptr-as-ptr-v11-0-ce5b41c6e9c6@gmail.com

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
 drivers/gpu/nova-core/driver.rs        |  2 +-
 drivers/gpu/nova-core/regs.rs          |  2 +-
 drivers/gpu/nova-core/regs/macros.rs   |  2 +-
 rust/bindings/lib.rs                   |  3 ++
 rust/kernel/alloc/allocator_test.rs    |  2 +-
 rust/kernel/alloc/kvec.rs              |  4 +--
 rust/kernel/block/mq/operations.rs     |  2 +-
 rust/kernel/block/mq/request.rs        | 11 +++++--
 rust/kernel/configfs.rs                | 22 +++++---------
 rust/kernel/cpufreq.rs                 |  2 +-
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
 38 files changed, 139 insertions(+), 120 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250307-ptr-as-ptr-21b1867fc4d4

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


