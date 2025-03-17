Return-Path: <linux-kselftest+bounces-29224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B586BA65349
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 15:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A2F3BCF9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 14:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5407241124;
	Mon, 17 Mar 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zaqru/CJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF172405E7;
	Mon, 17 Mar 2025 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221437; cv=none; b=JRLcGSphPcBQarhdwdTqEvQkunBVeYEbq179RzO1pwUMY+romON4CXDmGMx2swY2G70dZquC0f7sJnmTLttQnfUdttc7qMryKPybx+WIuCt2L+a6MPiiS9DElpH/jqBRw2Iy7QAmPO54uqqUeB0EwKr2/y/SMQlTIRPkSQtdTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221437; c=relaxed/simple;
	bh=5zjwde8AZ/8b8+2Y46pl7g3mNNK7OdSviWWwEh2lyV0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iqIqrps/1qhza3x9N8t6C5dLhNEtV8eeO9cHl8jyBjEaoiRikM0mmBt/bYUYg7V+38OLhPl4UUz/yf4HcWdWFXVf6SCCtlB/SMEYi+8vrkFPBOd4XlkSzL3VK5wIN4GKQTKqjcPiZjJOlRWZZSz0aq5snIgVwFwNStuI32eDPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zaqru/CJ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4767b3f8899so55550211cf.0;
        Mon, 17 Mar 2025 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742221434; x=1742826234; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ze+DSjxO3+Ymtxfj0TgyBM0AsCVysO4hhdvABkeHMk=;
        b=Zaqru/CJnnccMVDNqrc+YWq8D36QebRu4ZvuW16GbIt9wDge6L1BJtq9HuJWq/LiE1
         ihdAgH6doCAa/w6DZPQRDz+rblPDhJCyWpGnzcM4iqVniG0fj5nxcgb/auiRdf0Bkqph
         jsvaXZwYUQZHDBJUJMxbWGSbO4nXL72Ke3yf/o+Y3/u8dvn0SK+E9S6qZ6u8hEgiGgg8
         IN1Tn7ReYg8nFezuhCCgfnbkHk8F0vCfwXJT7fYkzBLxY716uVnkWyQMRKyV2Kwk6+Yg
         z79Sr1naVeidW/nTQRed0ImuAPOcZFJI8kpz5cfY1d/QAuYABD81I9RoWkD1wpWKpDDJ
         XWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742221434; x=1742826234;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ze+DSjxO3+Ymtxfj0TgyBM0AsCVysO4hhdvABkeHMk=;
        b=qpq9U6kYtDqXfuUYIEXcNgCiAxWylRGN03qEyApAg2K8A19+32SbCsFLssMbG6kckb
         mcDf6PvCiwvdQMDLPwmVz9FEadfEAkzWzREf2nqKu4m0haw3g2SCDlybQDq2QHXZ5SfY
         9DAGtUk8YdJbqv/a+Ojw5iKBdEc5rfKtSO5Gh09vEq5+54iAvLKwA5PcWcMf1LvnvyEv
         zx9oG1psOswE3w6aERSQfK47h2lkkSCLNdHuWoWOSB4D5AMgC3o9jomks9vYP5y9/H8/
         D9yLZu7aZuiXDtQVSHgOrYNrBmzsjtnOU4naHbiOn95YvGuR3t9g2tGvxWDx8sOQBtPZ
         6OCw==
X-Forwarded-Encrypted: i=1; AJvYcCUOvTREHosynVr/Iu548PXB0SiiqV3UygA6OXH+IZ789ThRokGbtqBjFfdPy+guhFvqiRfB1RwsM3gq@vger.kernel.org, AJvYcCVcdmkgzboYUKm3GTJf0H63qoBHSOJO5TPVoxZ0vL33sGKxYqT61oWky3MytQDWBZqhPHMetj4EhVeO9lUrqjaD@vger.kernel.org, AJvYcCVeiC4dFAVD/1d9xwZeaTdE5CYftGTinLrNQNKJKvyiKTh+7F8PuPZUjopZpnUxmNMLpIg+tOXh00cR0GQu@vger.kernel.org, AJvYcCWY6Yum1ZZNWrfTglng5XDS6b09xEvxW8wVtU8dTOnQIE6T8vzFsBZh/jCy9Qdtj0fvTcFwDNzvdqfMQqVjyY0=@vger.kernel.org, AJvYcCXDGlfK6ON5+dUJqTNGNdyn4fM47cvLVm+XoBqu+/CTjZXHIt8STT2UPEGh8PPaJ4v4L+x0Qomlsgdp@vger.kernel.org, AJvYcCXYjCAAix3M4tJQaqNh6yFU4UW/el00c/N9kVBVn4fRFa9buyyKnUmX3fh6KpvWKt4Z3kcIRTUFZa9kTCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3wW1Ic/XN6wzF5LFqM3AFXSf/UN8ed92O/ZSGKMXK2bvVUqsm
	CjgV9sjLfeh89jXDUYJ0h15KSy0knEtdjwN7crl0WvpliY/D+U7U
X-Gm-Gg: ASbGncu4iRNJFEQVNd3f4fP3TNgBiCcVcwHLc1gXQHtX47HqrEKnrSkTlcUZE571685
	hTmrrxJ4LjHWSgFPNdzibJL94oLtIlMOpB/k6SGbKnxzfSa0aeHfT7gm5RdQa/qfLp46TNAbfXx
	lNoB6dy2AOBiV/RyBiBxTiA4aL8AqJGFyfuc+Xf2iSTQUh+V0ghb7Ah9xjavPmikBY3/0FnlXN5
	+uEvlsZRX0GyuWI5PFv5x++b8F/a1IMWhU6kfj6AWXddo7bjQJck2WfJHP4Hc+lHDZdKE5sjezt
	TwPOvKoxGgRk3AAWaou/EfEEk9js9ZvD612D1h0NFOdvbx7QNP+AuaRCWnC5+iJchJEOj3oGcQ=
	=
X-Google-Smtp-Source: AGHT+IHCPgh1LNFalMZ6pNl0PgrDUz9Ysq8X9QDeDL9NErlnrsd3XTsU1GehYSE1Htg8/Dz4cfPQyQ==
X-Received: by 2002:a05:622a:1481:b0:472:521:871a with SMTP id d75a77b69052e-476babcd20bmr240941271cf.23.1742221434351;
        Mon, 17 Mar 2025 07:23:54 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:6895:24c6:e898:e320])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb60b13esm54601011cf.6.2025.03.17.07.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:23:53 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v5 0/6] rust: reduce pointer casts, enable related lints
Date: Mon, 17 Mar 2025 10:23:50 -0400
Message-Id: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHYw2GcC/23MTQrCMBCG4atI1kYy00nSuvIe4iJN0jZgf0ikK
 NK7G7tqxdXwDTzvmyUfg0/sfHiz6OeQwjjkIY8HZjsztJ4HlzdDgVIUQvPpEblJ60GooVS6seS
 IZTBF34TnGrve8u5CeozxtbZn+H7/ZmbgwGWJTigJZKvy0vYm3E927Nk3M+OWVjuKXHCUTgnjK
 sRa/9JiQ4F2tMjU69ooEFQ2ZH4pbancUcq0RqfRAjmLakuXZfkAkqykYFUBAAA=
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
 Saravana Kannan <saravanak@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This started with a patch that enabled `clippy::ptr_as_ptr`. Benno
Lossin suggested I also look into `clippy::ptr_cast_constness` and I
discovered `clippy::as_ptr_cast_mut`. This series now enables all 3
lints. It also enables `clippy::as_underscore` which ensures other
pointer casts weren't missed. The first commit reduces the need for
pointer casts and is shared with another series[1].

The final patch also enables pointer provenance lints and fixes
violations. See that commit message for details. The build system
portion of that commit is pretty messy but I couldn't find a better way
to convincingly ensure that these lints were applied globally.
Suggestions would be very welcome.

Link: https://lore.kernel.org/all/20250307-no-offset-v1-0-0c728f63b69c@gmail.com/ [1]

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
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
      rust: use strict provenance APIs

 Makefile                               |   4 ++
 init/Kconfig                           |   3 +
 rust/bindings/lib.rs                   |   1 +
 rust/kernel/alloc.rs                   |   2 +-
 rust/kernel/alloc/allocator_test.rs    |   2 +-
 rust/kernel/alloc/kvec.rs              |   4 +-
 rust/kernel/block/mq/operations.rs     |   2 +-
 rust/kernel/block/mq/request.rs        |   7 +-
 rust/kernel/device.rs                  |   5 +-
 rust/kernel/device_id.rs               |   2 +-
 rust/kernel/devres.rs                  |  19 +++---
 rust/kernel/error.rs                   |   2 +-
 rust/kernel/firmware.rs                |   3 +-
 rust/kernel/fs/file.rs                 |   2 +-
 rust/kernel/io.rs                      |  16 ++---
 rust/kernel/kunit.rs                   |  15 ++---
 rust/kernel/lib.rs                     | 113 ++++++++++++++++++++++++++++++++-
 rust/kernel/list/impl_list_item_mod.rs |   2 +-
 rust/kernel/miscdevice.rs              |   2 +-
 rust/kernel/of.rs                      |   6 +-
 rust/kernel/pci.rs                     |  15 +++--
 rust/kernel/platform.rs                |   6 +-
 rust/kernel/print.rs                   |  11 ++--
 rust/kernel/rbtree.rs                  |  23 +++----
 rust/kernel/seq_file.rs                |   3 +-
 rust/kernel/str.rs                     |  18 ++----
 rust/kernel/sync/poll.rs               |   2 +-
 rust/kernel/uaccess.rs                 |  12 ++--
 rust/kernel/workqueue.rs               |  12 ++--
 rust/uapi/lib.rs                       |   1 +
 30 files changed, 218 insertions(+), 97 deletions(-)
---
base-commit: 498f7ee4773f22924f00630136da8575f38954e8
change-id: 20250307-ptr-as-ptr-21b1867fc4d4

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


