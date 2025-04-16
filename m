Return-Path: <linux-kselftest+bounces-30964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC69A90A0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 19:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216614461FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEB8217F35;
	Wed, 16 Apr 2025 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNziZ/4/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C1F215044;
	Wed, 16 Apr 2025 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824985; cv=none; b=lvnf+S6vBXMv/m1Z9/Pu9T1MMbuMkrihzPZtiDp7jM2sWe9DKx36lq8zQSnzJMgUYlYuuHJbvzmdWXMu8sWV6OEKJMqODTWkKDDvBbEUYV13pUvt0xOCgkBwlV4SjzfKSV4Y6GYYhXcaULTX2Bh5f24Zb4S/pGlOq/Bh96JFrj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824985; c=relaxed/simple;
	bh=80N83lC2CekD/mKIVziV045qr27fcVeb1g79jArWsi8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JDgaFE+uj8hMUwbJa6v3227Xchy2f9yrXbztSFNy+KQTN3cx6ARr30KlQt57iqxf9MyEvBkADuoro10qsqXhXJP3clXviO2hBk0MH+5/tK544OolMRRjlIrd84jLl/4imilPqEmJ+WLhp5x5rz2WgAW4TYIsvTF44HwA0EZN+Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNziZ/4/; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so43366406d6.2;
        Wed, 16 Apr 2025 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824982; x=1745429782; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zq0j01UzuoIZjvjIYeTFfavzOYMv54omrnlCDWGJJC8=;
        b=UNziZ/4/niiVkq5OcpmhBX5yHbHJUSZqUWFzB/Uj12ROKquRJarDpNrK5IiUg8JPzy
         uBESfXP+iihT6BDIf++YJxiOfGytIZ/m7WrxPEUsF7RLQROigDqnlzaxhCnrxECYa0+o
         5EL5He3ir2qnV6Qr8uNL3BFpTAoUwtCUYD29CWQLFnzyjr4HZBm8WbiQPr1cF1Go+RR9
         I4iqHAZ+y65QHvupieBE/ltml+SrHpDbwdt2tld6d5234GoHSwY4uVGSEXZ3JPn5h767
         oKm8Wdcs/J7Ii5e40dvIO2NzDaorIbqEIzBR+TjM0JnhvmbIvEilUazL3WnQzmt18iCR
         PA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824982; x=1745429782;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zq0j01UzuoIZjvjIYeTFfavzOYMv54omrnlCDWGJJC8=;
        b=xPAVlGpKps0TjbAGhBe5MdwIQJHuALdyM+y6mdt6jRLFzqzlKe95I5atq96bBKsMwq
         LSnErm5OLY4tpChFv9zCJeASt54XVzP5AfRDZfpn30cO0GR0VHfgfAZi/lnq6f2DYcsO
         ybfQD3t+H6OA55bfVOAnKDCrVEn2KRL+Ku7aOWNP+UiSz9jqeFakB9neicQlljgqm5yt
         rZYPPkf+zPaqM+87NgkzESfoC+rCNTwp/Fd0yu6OsLFRBUQqjQszvHlQQWMc+44NYFow
         SpAqTL8sFZ1CLU2+eLrzZ2Kt7V0oGznz9Xu+9jL/MLFv4KU/nMtSwcYX62RceztrVihh
         HxbA==
X-Forwarded-Encrypted: i=1; AJvYcCV0ab7s0Gk8sEbo9aHSujB3aphB9eWorLRIq2jwnZoKcGEN/SiI6LvCBroTTtb1Dt7iZDVRuxDnNoAfYx6sR0Fg@vger.kernel.org, AJvYcCVzBpJZgyJtBIKMLnM8Ow8518+cQiP1yFaVOTA27G+3VJN78Fdw6sArQTk8rmqe1+SsowbWhUFDhMDd54bN@vger.kernel.org, AJvYcCWO8deeyNxazKwfCIpOLeJrPbD3LepSDlllZEVz/br3Jhg5ldZa7NpIH7p8RitbGz723Esa/Z3W2T9y@vger.kernel.org, AJvYcCWgIknbfLvv/iQLquzmfrtHQ9K8qsKv9ogGA8azohXogPyA45ysxe3PztnN3ymBpgNmMkVmQ0gY@vger.kernel.org, AJvYcCXB6dqMbCJAm3ytFUhu1+hjax8xyfcIBA655S22MWYGQ4KJ5RBJ8ITri9aOTSfOIo5VrX8BdKFo2XCXCFMQtnc=@vger.kernel.org, AJvYcCXCE/SE5v0ExMdfC0jA2sJpYZFfILaeSMtA6KwCwT7HvEK1e8JmXQExJYTiy3Y7z3Z/14tK9BZo+SiJPmw=@vger.kernel.org, AJvYcCXDIOio8JU3j6l2lxKwv7a2c7lYuvtAfZeIm7ccB0eSeJRP2aCogA4HAUn3RGFsDWqzDbwQKNC1mxdY@vger.kernel.org
X-Gm-Message-State: AOJu0YyczGvJoFBgBklW50/3UUq8Op1Ciq5gAb9TtxDTaFiIJvE6iMyM
	rKAYsBA8cdw35oU0cbTlIKL8gZYBccIqnjLSU6ZhQrOJwn18fVSb
X-Gm-Gg: ASbGncvc6OvONd6JuM4A1qHeS284jBVdJf6ioJ5CE3E6JkD6ai3s0wLdP10QiiKvjId
	UY/9cE6P6Vxndji8zm0EnYE0720tolJFCK1Fji+tjvSfvgbj9cwfnSc4A+O8VjbVHaR01Lhfkxq
	7ja8obUjmlroXyQ7H5gV3bJgFCGUyJPk66yvxuB3mp2SPqbZppZ+ChIT3irLadqF4NtOvsXWmuU
	W0axbkrsmqUS9vRHadMNXgfeovFnyNHPD9ob6Vm56occZoxKq18VrhpaEylHtDaIBq8Shtab3rz
	/0OOKIBwJtRLC0+tqEcCc+oPcoVH3I6lV5r3jOKhuO7N19YhlU42/BGJQBWqsgiPDj0uaxXpnu3
	xMBj9AMBVmP/s2uRzBY9l0vs3U4MdRPBLrJnSnjJgEBCZ
X-Google-Smtp-Source: AGHT+IGhI/osbo9sS2h15D+R1UFFUx18jwf20QnH/freiMK9Gsyc+DLKTSMa3Jd5HnAi9ZL7/q9xVA==
X-Received: by 2002:ad4:5f8e:0:b0:6e4:2d8e:5cce with SMTP id 6a1803df08f44-6f2b301b8bamr41325666d6.36.1744824981526;
        Wed, 16 Apr 2025 10:36:21 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:a61d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea07c50sm118289886d6.77.2025.04.16.10.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:36:21 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v9 0/6] rust: reduce `as` casts, enable related lints
Date: Wed, 16 Apr 2025 13:36:04 -0400
Message-Id: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAITq/2cC/23SzW7DIAwA4FeJOI8JjPlJTnuPqQd+O6Ql6UIab
 ar67qOttCXZTsigzxjsCylxyrGQrrmQKS655HGoQfvUEP9mh2OkOdSYAAPJBNP0NE/UlvsC3HG
 jdPIYkFRwmmLKn/dkr4cav+Uyj9PXPffCb7v/plk45VQaCExJjr41L8fe5vdnP/bklmaBNW03F
 CijIINiNrQATu+pWFGOGyoqjdpZxRmahHZPcU3lhmKlDoIGzzF4UHsq13T7VlmpdDIBTxYE+3O
 rWlHYFqwqxTZwp1NAaNme6jXdFqwrNdo6lMBRu3ZPzS/F3Q+bSoUWhikuBca0ptdH06f4ca6DM
 z86T5wtkdbzPs9dw2yCpFzkDsFwYaRT3HhnVG0YqhhiYKa13pD1wHXNTyl+HGabhzjRMdH+PA+
 xFOpqKaG+RhgTujpZh+v1G0fx+l3JAgAA
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


