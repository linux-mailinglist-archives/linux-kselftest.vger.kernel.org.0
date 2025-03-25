Return-Path: <linux-kselftest+bounces-29777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E188A70B2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 21:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0815841B18
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 20:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2BB266B52;
	Tue, 25 Mar 2025 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2dUHyyD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BBA266560;
	Tue, 25 Mar 2025 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933271; cv=none; b=r71WaxZOq+VpDiW9Ss/wrsYPNTSl4D5vJcDjeLQZ62u+yPbtzIfUGAANcsC7X3WLS6v1jwAHYZArczrNtJabCQuIR+k04nzvF2JGtgUJL0rlhqsxUahLL1PwD9jMeHUuNAHcoiE5mLpotNJS7jDoE7fozp02VaRv1R8VwnTtmfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933271; c=relaxed/simple;
	bh=XIr4D/B5iXjvurP1wpN32Wp73Mkw1cr+ytGAtObmgTk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nqFTbjuFNl1WFZgs9royWSStDM9qGZYY2XSzo2MVYgkBWIA+R7a3dloIpTfkVj13fGRceHF6EgFNNcspllb72IH/7uLaO9XKAwXqxD0rTXbR9QnmnrYEOJqR1DsT4F15jzv7sjQdtMDZvKW4AnzJkRgK88eGKy51wKBXBqoVn/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2dUHyyD; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8f8657f29so50813126d6.3;
        Tue, 25 Mar 2025 13:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933268; x=1743538068; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=De1j2kxM+B3PrrF0JXUY7dB3WGtLTgac0gJhkCjYocc=;
        b=S2dUHyyD6pCAZltNFmeWh7Gu8Tg/XkYAdm553qd7QFPMnJknS/RGqCycYQLYf4CzLO
         gmpxnnyd/8w2lLXCQz6VKizshT7QHmRdU2KiP4pVXqJk37h8BYminru9macilIjUCY4J
         zF8l+63ymGalSKp3HxG3jh0oYhiE7Vx8Oj+thQqIFY6/WK6oTDmgDeyei+7w4s9IWEGn
         SGZWtTwv2lhHpDBhDMAzGZz6Aj/ZFpybi/f6TtKwpPeMY696p0T/turQc1/LELoMpjBb
         TgIIViadAYVj8E2cFXfXP1aNvol8T58/DgVnuNiNiKP82pFZcNbjtjUzuFOhg2X/R1WY
         VUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933268; x=1743538068;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=De1j2kxM+B3PrrF0JXUY7dB3WGtLTgac0gJhkCjYocc=;
        b=gCugj5fCRPbzFs0I2Cl+wdeCmrR15mFMaV100mMNI6xwCkAfekbCswX+6Jfz+i/KtW
         klmFZGEBjWbsSloyAr3uz3F1rrXNKS/OyFPvvJWVwWEj+b+V2UfcDK20LbmOgirccDHc
         qxzH+/323jbQaY1WE64TdEY81gV2wy3otBKlexuyVqzE8qfN+AjPBrG1s8jkKbhy7dHU
         qQirHGjCTVdgINigmHu5BqKPQlBGCn2drNcmnjllWCHaLiFz05Dn/mCtUuvNfSoO6sFX
         rb9J2BzXXSz7wryKqwp0A4PuQyc5ciO9kP0EMRsu3VquMRS1UX5rF7ZCShXxg+NFnWuc
         wkKw==
X-Forwarded-Encrypted: i=1; AJvYcCU8qz10BUqJOKs2AzAU5V7RnX96odeznchHXDjp/B3zysx8ybkfrO9JciU0A+c6IHGn7np5Jkb1@vger.kernel.org, AJvYcCV8uAE+ElDMEaJQ3QrEf37Z5n6tX2k9VHzkB7bmuqv+BhOsHt83tBsaLCPGG1PvrcyQDJhMZz3DB/Y5/qjDj2AP@vger.kernel.org, AJvYcCVW1vksDFVbD79OXEWuaD89lIpwLwPO9VwR1hY2RPoAlxtm72l80kh4fhHVvD8ZEyF+6JJLahBWZzeX5Iw8@vger.kernel.org, AJvYcCWoIUH+HEDLMtp1ktqMlzt0KujpKfN2prT2zo0QxnhXqPJgG6V5Ms2XxpJnQd/vPN2u53GFqX+Dz+Us@vger.kernel.org, AJvYcCX6f/oDTga61PrYpOcuNIDx/dqKvwF+ZSygUzidnRGewvkCboz4if1kc88pJEiLkQzsNdWkXAClSFygWDY=@vger.kernel.org, AJvYcCXBYXAILXHQCtmMOFwj0R46Nd2uKhd6Zd0O4PIgAQhjUPQIZcbTKZTbQxAbianh79DmQ4XY3ue8EyvI@vger.kernel.org, AJvYcCXZMnZliimL1Tqv7iK4qmK3jp1Pxl5e7VxtTuJxHpE5YLFu8aku/+GnCTjAsHnhms8ko5nSctpFEIx22GsbbtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5aIETYrNjgEy0YkpGxLdXlQhXfDFgOXNKpXWS5PT5kFJ1xdjs
	WSKaKUVw4iGVzntrdsOfHYlzmW2gbPsLPbyWCdjpdtowLIl4pcwV
X-Gm-Gg: ASbGncuI/i7oht6bLPvx+UZJIipntESrsLgPjUBqnEv3CK+1hpJtxbdKz6uVYS/wzno
	6e3aI+0QHJfAkds/HdbGqVqZ8d2qtY02UITiGDVP0a+hGHo/L5A9xs5sdcmLMcR5Cj2Hfjh6dUv
	cQapiZLapzknkGNnmHLW+o7pAYJi0p5Ys7k3MzyNo15Io7ig0QDQhBRkpOfGkz+2h9uiTis3mx2
	n6J29el+Aix162eDlaeHlngc83HSwiEkNANWLLfkSrY2hJtDWEFaY9Bev/vKQcrp9Q+q7vExiaF
	7NwE771g+Xs4A6LprXj2o745mk1cFob2puwxQ6uhP0jZI1H+78hjEg9ZZeqd28r/EnX0LCoB41S
	YWX5DyA39LDQdzBwZlP2EwLTXQvWCMxjH5eU107MqWcY7uovgG0b397iLtdqJ0fM/
X-Google-Smtp-Source: AGHT+IGLBNBsuCm5QT13IWM9Uun0NwuqyHHphAVZs3TNbnowX2o/8kuPM4uDvAmDt8ri644wQ+EGig==
X-Received: by 2002:ad4:5c42:0:b0:6e8:f91a:c5a with SMTP id 6a1803df08f44-6eb3f2d5384mr324494996d6.22.1742933268279;
        Tue, 25 Mar 2025 13:07:48 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef31810sm59790316d6.64.2025.03.25.13.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:07:47 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v7 0/7] rust: reduce `as` casts, enable related lints
Date: Tue, 25 Mar 2025 16:07:40 -0400
Message-Id: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAwN42cC/23PTW7DIBAF4KtErEvFjAewu+o9qiz4TZCaOILIa
 hT57iVegdsVekjfm5knKyGnUNjH4clyWFJJ87UG/XZg7myup8CTr5mhQCkGofntnrkp24NgYVQ
 6OvLEKrjlENPPVvZ1rPmcyn3Oj617gdfvvzULcOByRC+UBHLT+Hm6mPT97uYLe9Us2NKpo8gFR
 +mVMH5CtHpPh4YCdXSoNGhrFAgaI5k9pZbKjlKlFr1GB+Qdqj2VLe1vlZVKKyNCNDiIP1NVQ7F
 fWFVKkweroyecREvXdf0FAc7SdcsBAAA=
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

As a later addition, `clippy::cast_lossless` and `clippy::ref_as_ptr`
are also enabled.

Link: https://lore.kernel.org/all/20250307-no-offset-v1-0-0c728f63b69c@gmail.com/ [1]

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
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
Tamir Duberstein (7):
      rust: retain pointer mut-ness in `container_of!`
      rust: enable `clippy::ptr_as_ptr` lint
      rust: enable `clippy::ptr_cast_constness` lint
      rust: enable `clippy::as_ptr_cast_mut` lint
      rust: enable `clippy::as_underscore` lint
      rust: enable `clippy::cast_lossless` lint
      rust: enable `clippy::ref_as_ptr` lint

 Makefile                               |  6 ++++++
 drivers/gpu/drm/drm_panic_qr.rs        | 10 +++++-----
 rust/bindings/lib.rs                   |  3 +++
 rust/kernel/alloc/allocator_test.rs    |  2 +-
 rust/kernel/alloc/kvec.rs              |  4 ++--
 rust/kernel/block/mq/operations.rs     |  2 +-
 rust/kernel/block/mq/request.rs        |  7 ++++---
 rust/kernel/device.rs                  |  5 +++--
 rust/kernel/device_id.rs               |  5 +++--
 rust/kernel/devres.rs                  | 19 ++++++++++---------
 rust/kernel/dma.rs                     |  6 +++---
 rust/kernel/error.rs                   |  2 +-
 rust/kernel/firmware.rs                |  3 ++-
 rust/kernel/fs/file.rs                 |  3 ++-
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
 rust/kernel/str.rs                     | 14 +++++++-------
 rust/kernel/sync/poll.rs               |  2 +-
 rust/kernel/uaccess.rs                 |  5 +++--
 rust/kernel/workqueue.rs               | 12 ++++++------
 rust/uapi/lib.rs                       |  3 +++
 31 files changed, 120 insertions(+), 101 deletions(-)
---
base-commit: 28bb48c4cb34f65a9aa602142e76e1426da31293
change-id: 20250307-ptr-as-ptr-21b1867fc4d4

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


