Return-Path: <linux-kselftest+bounces-29711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD15CA6E627
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 23:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8890C16BD95
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2573F1EDA33;
	Mon, 24 Mar 2025 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j02R2fXs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E771A08CA;
	Mon, 24 Mar 2025 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853707; cv=none; b=XhdwaUWvI8jMvsdJo6703DpXBwJKd+wj2bPTndxRCeUu7Z5zbgBWhJ+xSUxHthhY/MO0ni2Wv9x6GX2KWYnqw0lPdOJSIoP33LwtLdWiozWi+KQN3cqCVqI783GH1xW8DFxCxR1b+GdrhnlTbmB9SMrjeKm/F18nOY5QBx/S9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853707; c=relaxed/simple;
	bh=7o5EXBGc0cY4l26JernHJtAJjUxqpG8PQ3G5dJnC/mc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ht5WHxYEc7SO1YvVRUmszpC8OE5kFZNbE4Xg8y89ZeOJTY89WHrS3qV/gptuifdODDsBWRvtU3RTp3Q3qeZD59qHav32zuYfiO1eDsU13V0I1Ky9B8KSKmf6TbE/Qq3pHuRUn1MjCeRmMCKToVXMITTewyofcp0uFx+IqaNEx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j02R2fXs; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476ae781d21so43855231cf.3;
        Mon, 24 Mar 2025 15:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742853704; x=1743458504; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48vsJ6v/nLu6gQ6p2zqKRIpvk+YPWE9bmceJQmo3Vqk=;
        b=j02R2fXszXkIomthEMkqqPm8daimqrScctwZkH9IzsizZMGkvNMA5TGvTIdbOBc79x
         iMa4RPLd6CubsbsYw3ifafMTZBj3nn9UtMt73VUZjQcRX/Iq4epnLnDlMSOjtzdjDS9Y
         I96pWmz7WQQ7BIA8e3a8UwwxWvTh5Y9LtGYa6W1sxukI1fcrHWa4Dv5FCIQ1oT020RkQ
         y95hG5QUjMpKD6EmD/F1JhNKfU0TpPSen6EFAmflWX6+DBQXwUoGs3x6b8w6oK+u132s
         JQlY5j7k8lfr+PwWXq6IWwWCEyf3SQ7teCpb1leyVEriu62ZNsoouVftm6MS5Peh5xo4
         piWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742853704; x=1743458504;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48vsJ6v/nLu6gQ6p2zqKRIpvk+YPWE9bmceJQmo3Vqk=;
        b=g00NM2fikLncnGk3oIYWYn7wU2KnYTIBb1dvM9jgHCFbSWvOSNiLC6ylVsE55Ca59F
         dtKLG7FXSyHunjksVnJJcyhY7KpXnHKJBdj5rjvgQOfcUSVGltN53ri5RFCc7PZLFLbd
         tnOYAWM+fn4sG1MlZTUQDsnYoVhvOSz3Z5ndGOcKMltO3111cT+z0Kcb3VgBobTMp4S/
         SUZEkdhhTwc7Djkf9ICfSIl2vWnlh3vzpEr3BvK0N0mPJYETXPocevA/iIdiFvlV6BDa
         aZERTJ5SODL4gKT8cz3RZTOrFopd/pgNfGlxgASW2VCcGKO3vFj5dvPA1ymnCEZaY5oK
         H5bw==
X-Forwarded-Encrypted: i=1; AJvYcCUIMndqmcw1QJbyzFz2LmjPemdvnb6jOD735vwPSgCBPFYRKQcO7gdi7vU2D9HccNbSDIJTH9B+d3xs@vger.kernel.org, AJvYcCUwTIA93ALzRFILELMh17y/C6xDm5vRc2XO/fcpd46Rq8G57Grp8N5xU52RpTV3bs8aCvpQjW3pu6hiHm+C@vger.kernel.org, AJvYcCVKfmIHHlgWWBmRXf/UjgNodxaphPRh/IqKYDUi0XIBlQ8I8zb41pCFphnovzAdEP4XiCYlKVUg9rsdjrYZ+/4=@vger.kernel.org, AJvYcCW+8SEJsJSILvP8KjtsXZGpBBMPYtokZD2ZdFz7pAwHrnSpk1iWDT/dbsM8khm439Sqo3nZmnN+MGUgpmM=@vger.kernel.org, AJvYcCXBbVRDEh6X2Ekv8NwrcUrAs8/wcE6EaAudPes3KQCyiMS32gN/TFZ1eEdt9PjxvxHMsZyvH+H/@vger.kernel.org, AJvYcCXDOet9bxbhSkqK8w359Xru8I+H+rE5MB/Lgmp6BlSddLmnPgc/5i1/AzcOX+WbmGm4t+4rdJsTtzyAq5dlbEIO@vger.kernel.org, AJvYcCXLeuSzT5WMrmmzUvx6bOWJgfb8udGJWif2IdPwXm7ZH8kxDyuy5cCmNySiiJ+VoovrLSFlppon/V7E@vger.kernel.org
X-Gm-Message-State: AOJu0YwZeWA63lO18hjPOVFxY6CI+YqBGI5xpofDT4WhKDxmUSRyUCgd
	5btqF5oMnUvNsMjFSMI6MbalWTHzXj/nuLjzWWOQ7xyKwtvQYtQK
X-Gm-Gg: ASbGnctHgkVqTmgzgcxDfN9oyVikmbVC32SgtBvCGoDdEfo0cVYhgD9ig3xjic0Z3xA
	iR2K49EWsm2nBbTCTcHwhqu4W9JUuH0eppHlUcpy0UCjsEKZjGGkQ999RqMpDutkS9VE8jeS5tF
	P2sNz7H2VNA98mxsKaJcca7D43CIwZ7e0WTWmY85BHaiF/I5ddU+fpyBZm/ht6+kdLF+KImQBfh
	YY54I9b2Kwi+oFAaoJTazIQzxipiMPpcjTb3Rgv4n5B0WOzN2s7CHyQL0S8q30tkEjTE2nQIkwa
	9q3RsVJ5IbHxtpH1TYGCmx6RucNR7WOx4F1mUpYQycXwnCGA/HA9wyFfkDb+7pDwdlAJ3bhUMUQ
	VUMkiyAdWU3mNfZu7xs/VfcpCzHcUXvS5YpYcW5HQsRsJcym2jclYOw==
X-Google-Smtp-Source: AGHT+IGjaSVyROaXvVWRD/dB2tcIqIsWK/CblsLlsWJJlKtg+yAXt0fZphnVNo27G4vykALG3lbVSw==
X-Received: by 2002:a05:622a:17cd:b0:476:b33f:6694 with SMTP id d75a77b69052e-4771dda5445mr262657161cf.28.1742853703515;
        Mon, 24 Mar 2025 15:01:43 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:43c7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d0ad87esm52129541cf.0.2025.03.24.15.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:01:43 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v6 0/6] rust: reduce `as` casts, enable related lints
Date: Mon, 24 Mar 2025 18:01:29 -0400
Message-Id: <20250324-ptr-as-ptr-v6-0-49d1b7fd4290@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADrW4WcC/23PzarCMBAF4FeRrM0lM80krSvfQ+4ivxpQK4kUR
 fruN3bVlLsazsB3hvmwEnIKhR12H5bDlEoa7zWo/Y65i7mfA0++ZoYCSXRC88czc1OWgWChVzo
 66SWr4JFDTK+l7PRb8yWV55jfS/cE3+2/NRNw4NSjF4pAuqE/nm8mXX/ceGPfmgnXdGgocsGRv
 BLGD4hWb2m3oiAb2lUatDUKhOyjNFsq15QaKiu16DU6kN6h2lJa0/ZXqpQsRYRosBPN1Xme/wB
 iH9NskAEAAA==
X-Change-ID: 20250307-ptr-as-ptr-21b1867fc4d4
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
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
 FUJITA Tomonori <fujita.tomonori@gmail.com>
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
pointer casts weren't missed. The first commit reduces the need for
pointer casts and is shared with another series[1].

As a late addition, `clippy::cast_lossless` is also enabled.

Link: https://lore.kernel.org/all/20250307-no-offset-v1-0-0c728f63b69c@gmail.com/ [1]

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
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
      rust: retain pointer mut-ness in `container_of!`
      rust: enable `clippy::ptr_as_ptr` lint
      rust: enable `clippy::ptr_cast_constness` lint
      rust: enable `clippy::as_ptr_cast_mut` lint
      rust: enable `clippy::as_underscore` lint
      rust: enable `clippy::cast_lossless` lint

 Makefile                               |  5 +++++
 drivers/gpu/drm/drm_panic_qr.rs        | 10 +++++-----
 rust/bindings/lib.rs                   |  1 +
 rust/kernel/alloc/allocator_test.rs    |  2 +-
 rust/kernel/alloc/kvec.rs              |  4 ++--
 rust/kernel/block/mq/operations.rs     |  2 +-
 rust/kernel/block/mq/request.rs        |  7 ++++---
 rust/kernel/device.rs                  |  5 +++--
 rust/kernel/device_id.rs               |  2 +-
 rust/kernel/devres.rs                  | 19 ++++++++++---------
 rust/kernel/dma.rs                     |  6 +++---
 rust/kernel/error.rs                   |  2 +-
 rust/kernel/firmware.rs                |  3 ++-
 rust/kernel/fs/file.rs                 |  2 +-
 rust/kernel/io.rs                      | 18 +++++++++---------
 rust/kernel/kunit.rs                   | 15 +++++++--------
 rust/kernel/lib.rs                     |  5 ++---
 rust/kernel/list/impl_list_item_mod.rs |  2 +-
 rust/kernel/miscdevice.rs              |  2 +-
 rust/kernel/net/phy.rs                 |  4 ++--
 rust/kernel/of.rs                      |  6 +++---
 rust/kernel/pci.rs                     | 13 ++++++++-----
 rust/kernel/platform.rs                |  6 ++++--
 rust/kernel/print.rs                   | 11 +++++------
 rust/kernel/rbtree.rs                  | 23 ++++++++++-------------
 rust/kernel/seq_file.rs                |  3 ++-
 rust/kernel/str.rs                     | 10 +++++-----
 rust/kernel/sync/poll.rs               |  2 +-
 rust/kernel/workqueue.rs               | 12 ++++++------
 rust/uapi/lib.rs                       |  1 +
 30 files changed, 107 insertions(+), 96 deletions(-)
---
base-commit: 28bb48c4cb34f65a9aa602142e76e1426da31293
change-id: 20250307-ptr-as-ptr-21b1867fc4d4

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


