Return-Path: <linux-kselftest+bounces-30430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20BAA828D3
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A2A1B63950
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DD0267F49;
	Wed,  9 Apr 2025 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TedrXKak"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FAA267722;
	Wed,  9 Apr 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210048; cv=none; b=D2+z8/6YQkdco9ZqyZ+46QWPKik3ypZwGKytUuNMgL6tUq6giKiNaq8tbscp9yovEOICnAGWVrHYgvpJm29HVcY15tiP76YKyRvkxZhGBEtcgMrrrdNC3AZmhqy0ZaxilFwC+7ZKiwt+PFG4aMvRBdI4U4pO5eIiUSfrisX21EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210048; c=relaxed/simple;
	bh=IEYQQtqwTGpjsv67MQqn5440WRD9SC6i5iV5BTOjp00=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nuMfMkahH8GcfRkda7LNMldjrz+71rgNywi+T13OznQ68vrOcyJVujhI8eRHQRd4rjVxVofRwByntsSX6i3XdaUQ4D9DcmUIbno6nC/820EhEknFXIXw3hty7jCOEZtM5oCBosMvUyLMZ9tKzMjPJSXbaAKoGWk+Y/Nh+gZuVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TedrXKak; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476f4e9cf92so51111601cf.3;
        Wed, 09 Apr 2025 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744210045; x=1744814845; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OxSVY9bn2Vv0A1oBrQZzgAHvFFWvWIBKi/nsXjN5Jm0=;
        b=TedrXKakMD5m6rmmZlVnRHECDOh5bY4Dv5N1CrA0CCVF9fQi7VCWeli++xOK/3PCyg
         dx6bXRMgRnv5ulKsDTrcmfoj/xFzeVixtaAHlzA5B3EF3oeQtj+uyhvsXm2eKi1n70ge
         Z6rAXtS7mU7WAS+YfpJub45KXWGfOeOn+JQMFx9OJThvZf7oB6E9z+3PCw1xbuyx7klo
         /R9O3ySupGBWBdwJqGHWwiv8an6Cany0Chm+nfGDTZ7wAYZC2RrUpz6nQPcoDcomXwCe
         sAZdz00NnntgVLQMg8mYeZfx8q9qw2kZRnVQGZZ7nozFFTnHur4u9BU8q54jG/xBWTmy
         LKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210045; x=1744814845;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxSVY9bn2Vv0A1oBrQZzgAHvFFWvWIBKi/nsXjN5Jm0=;
        b=tH9YUI7CsfbkZansvQRfxU0lMz4U6iUdxAjBLCTY9Mox9XXKcWBbJYvZQI1vSDM2Mr
         U+gPmLR6+NRCPAuTq0qTf2AI68L1cmcMiQYyxnpvppcFwmIRdUqwGiVVNLxAQ/Zbm4Pj
         SHqZZXCQOe5FrCU+1qO33U0NXsfLeoHQQjuuUjslwo9jyZDAYVyxW0DbajnLYVC5unD3
         7DKbSlvDg8Kjg7PT8BbmsMCs2I4qTlJGn/mnuB9kT9Wo9cXckExL4233zIVcSDTv236v
         m3GwLR+c7WjsNE0d5nBiNX+NEBphpHpVMZNRbSZ4+drg9lOMakeYglGiwZWQqd6oKzOj
         2TTA==
X-Forwarded-Encrypted: i=1; AJvYcCUSDAY/540xrTSBOAC1CrWd7JmFCo/AgoOYk+Ztciyf9QEoTEC0DrlUgws/NdfEaE9IsElREmJUXMJT30Zo@vger.kernel.org, AJvYcCUo5hNmT7fnoHAYlhaXy72UJgJQGfL8Voviq72Lqr3qmDhUD+vwcTAbt5JM1yejl0LBl7AzgYGs@vger.kernel.org, AJvYcCUu25oqDPF+mHHUWCtf3StE+WdhdV8UtTxYoJ5QVv9mdJuLSf1liwDDvMvn5sL3ejaeTKrVNRMe+emA@vger.kernel.org, AJvYcCWAawaYlKwyatUC6CqB7Tbm+mhiuHC+Wvt0sm2fUHHbyliQmroXsAqVV9v1uDcbJJocO6hvR6bTV/rF@vger.kernel.org, AJvYcCWR6ERp31hCrBc90I1/q5P51XDHt0zduqEOITsE/oW0a0Pry/4OB5BT9Lp2dNAxpOZtf/0IHU/4XVoh1x2ZGko=@vger.kernel.org, AJvYcCXEgoDsQxp6e3HPBfa2TIPLFoH34x2MGquJiLCDcn7sNiuWTAalWb2YEPRTTGRFsJjAu80yyjmLBLOsvew=@vger.kernel.org, AJvYcCXICduj/O6fu1eaSpmifBKrx1gjramaHlxPuwNNnHXMLwytJOfGq4r0w1iQZpzA+jIrp8YnC7oRgYt2P+LrZ3L8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0GFU1u/a6k58cT2rhJ/9/Aj+zZZ8YnFQgUu2rtpc+jSvfcK6l
	MnN+8ukARAKSxMxz0my3XvTl9BaRT8cWrBiLmUcCqeOQ2k+Awtlp
X-Gm-Gg: ASbGncscHcSVGKoeB407DVmT5rEb0bo7GhyDVxyB2v0+lyRdWbhNrP5yyBqMUcpS7Zr
	nj8+e5uCq2L7KpQ0tzJ9DEEs+eTsirM095JYeO532jkk72QwB6GgKEae0+VEhnB0zXspBnQgEwE
	QI65A0d0Q+BXf1CkofxOQD8+o71chwIAaiqVyyQrkjxE8FblbsT6hd0XbbNvijAp0f5QJ5usZy8
	hW95vWxq8jhsyeMTC0bj7AQW5zkmVM5xFDuSigXYpCtKA8XIpZRL8nfQWjP/DMFAGh1a8cb+bdL
	ijbPbUoZEND3lLIz0K7RLF9fNXpJ7SG4B9474YAAgHvxRcUerGgPKcKBF0f8juUR5VSj663xZ8u
	f9tR4haxXgozHqxxeCaPlrusLEwrBviy54itqsmVoTAoNPxBRYz2sXPM=
X-Google-Smtp-Source: AGHT+IGVBcgvUoAJ+mvBt4f2jO2Qo+1VcYhXU6dhpdk7BxROicttj+bkxTItoDRACLAwYujqEqGZ6g==
X-Received: by 2002:a05:622a:1895:b0:477:548:849e with SMTP id d75a77b69052e-4795f2cd4ffmr40751411cf.15.1744210044680;
        Wed, 09 Apr 2025 07:47:24 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:3298])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47964eb9a8fsm8024461cf.49.2025.04.09.07.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:47:24 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v8 0/6] rust: reduce `as` casts, enable related lints
Date: Wed, 09 Apr 2025 10:47:17 -0400
Message-Id: <20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHWI9mcC/23SzW7DIAwA4FeJOI8JO/wlp73H1AO/HdKSdCGNN
 lV999H0QrKdkEGfMdg3ksOcQiZ9cyNzWFNO01gC/dIQ92HGc6DJl5ggQ8FapuhlmanJ24JgQUs
 VHfecFHCZQ0zfW7L3U4k/Ul6m+WfLvcJj9980K1CgQqNnUgB3nX47DyZ9vrppII80K9a021Gkj
 KLwkhnfIVp1pG1Fge9oW2hQ1khgXEdujpTXVOwoL9SiV+iAe4fySEVN928VhQorIkI02LI/t8q
 K4r5gWSjvPFgVPceOHamq6b5gVahWxnKBwJXtanp/dm4OX9fS/eXZPmJNDrScD2npG2YiRmkDW
 I4aWi2sBO2sluXXuQw+eKY74zSpp6ZvtlJ46ZibxsWkMcx0inS4LmPImVoQrS8ltVr7vozH6X7
 /BYkxGT6OAgAA
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
pointer casts weren't missed. The first commit reduces the need for
pointer casts and is shared with another series[1].

As a later addition, `clippy::cast_lossless` and `clippy::ref_as_ptr`
are also enabled.

Link: https://lore.kernel.org/all/20250307-no-offset-v1-0-0c728f63b69c@gmail.com/ [1]

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
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
 rust/kernel/list/impl_list_item_mod.rs |  2 +-
 rust/kernel/miscdevice.rs              |  2 +-
 rust/kernel/net/phy.rs                 |  4 ++--
 rust/kernel/of.rs                      |  6 +++---
 rust/kernel/pci.rs                     | 11 +++++++----
 rust/kernel/platform.rs                |  4 +++-
 rust/kernel/print.rs                   | 11 +++++------
 rust/kernel/seq_file.rs                |  3 ++-
 rust/kernel/str.rs                     | 16 +++++++++-------
 rust/kernel/sync/poll.rs               |  2 +-
 rust/kernel/time/hrtimer/pin.rs        |  2 +-
 rust/kernel/time/hrtimer/pin_mut.rs    |  2 +-
 rust/kernel/uaccess.rs                 | 10 ++++------
 rust/kernel/workqueue.rs               | 12 ++++++------
 rust/uapi/lib.rs                       |  3 +++
 31 files changed, 107 insertions(+), 85 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250307-ptr-as-ptr-21b1867fc4d4
prerequisite-change-id: 20250409-container-of-mutness-b153dab4388d:v1
prerequisite-patch-id: 53d5889db599267f87642bb0ae3063c29bc24863

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


