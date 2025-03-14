Return-Path: <linux-kselftest+bounces-29035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECDAA6111A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2281D162AC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 12:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BDD1FECA1;
	Fri, 14 Mar 2025 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl65yHzn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF0218CBF2;
	Fri, 14 Mar 2025 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955299; cv=none; b=NHXoFEt5wdYGfTo66XtDSUFzzb5DThqOfuBcjRpXC3fDU/fQiVweFBW8NzkceFTmAcPjIzl6s3vuuSdN5UPLVGVsQBZXZFztgFnHdSILFbgwVmmIhoOtpj/SwGAJfnsHI2sWL5R9WRGWGCGgScEXyDhiIIJ7uyXRpDMZOWevq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955299; c=relaxed/simple;
	bh=kmrN5dBxMla28gnDa2akm4FaT5gAzqnpeA2VO/OgleA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rqI6EvYBdqhQy0kZ2+kIuFMpzh3wukQ7pLmymdm2nvVCbH0JrIXk4mMLHgqTVAUgOwbSU6Z88db8F2TW4L7maSk6liLz1FVxEPvDLAH2cffv3Wx2CSeGmotzz0jEUQ3vNq8VxtM3RUqm1xsYmmYhjJ/Hu8HnA/wEahFlSj2Bi90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bl65yHzn; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46c8474d8daso18284441cf.3;
        Fri, 14 Mar 2025 05:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741955297; x=1742560097; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P5xRn1aKyAVwSLLig+/LwpVYs05QvulT+Rvmlu35aCo=;
        b=Bl65yHzniM9TFCVwSukjg6AJQ4ylrqoHTqSwMX29UjvB52rzuQHzEETOQGQfpS7m/E
         Nq/eZKGloH1ZTg4TCnbDA8iJzQ+mp6pU0DySXvBOOwKdZRUo88mt+k8wRf+kvWl3I4JA
         MZ4fuFGXx2Y+zLGpRFIFzcuEnaKDV8WyJT+O2RKFIiWU2uCo6zVmzJ5pKjyq4nTScMIt
         4dS8H2NYjf9BLje6RVJ5oPZySwjIKwV9cvScoLV6MoKo8w0Ne2KGbziY21C1/tc4azfs
         c/KelGMf0iIrN2aaqynlBiLugeZ/3IdS4JhSEzaV4LaaYZaRL5rw5GoGBB7Tq+oLmPqt
         K9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955297; x=1742560097;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5xRn1aKyAVwSLLig+/LwpVYs05QvulT+Rvmlu35aCo=;
        b=OJnpemyCl44/mPwIpKhQB4RNGyW46f+5sdBmvTIMrtUviwOqn3IRHpa7w0Z65cfk3r
         wzor9nqFlDsW98CZ7RGzVQlLdm648S7U8av4n28EzJ+3jRUQeAHxalk3oiOgevjTtzpE
         s6H9gNB4EK1j3JaZein41S8rlFH6T8gHActp1qhfqBH7ce3gqDocOlbyQjAInv68re/J
         nj2ZjQvMwcP0EmQVT984Q68WkSa8GTZwm1QelP67P1jcQiyq/tXLbcE7lpOfsFSd1/Tz
         cxq5llkQ4j90GbhXjlsf13YI24JHCJSSDOTtRmh3kKgw7GHkJgj6AQrHLQMaTb2GNUo/
         wy2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8nNPmuxHekx6r6I/8kJfOpk+MLVR62i6pELcpGDg7DTdWyrkzzX63Pd12+Xt826/Kh5o6IrOcbf4D@vger.kernel.org, AJvYcCVf0OuKMe5+IwFx9faKWw1IM4amkA1u4rbs1w7q0nfagkdI/jo/pPJUgaWcQfUNLax5zRPkTVR44c8XBQo=@vger.kernel.org, AJvYcCVm1yJxlRVYaOdbJy9KGzn5b8pJQaAjfasS3G2zQuzeUqndASCaEOHrpz6mq2U9Ep9s9aoBi/y7eb2k@vger.kernel.org, AJvYcCWs5B5mb9nyCx8/DlJXf7l6Zb3BFi5+QFlcX8rKTUxdisFfJRSuqUiuL5az4QoM0/TRImY1Z6zrM/vNBOsxHbag@vger.kernel.org, AJvYcCXYqpub99T6O7R/Jy4PHU+wCXkcrLaXtAPONAxq3EnF9GFyKF3Zjf/qCyJczfkgXVMLs3pFedAI0eJyGKbI@vger.kernel.org, AJvYcCXYu/5e1bJjexFUJxLIs+t07ArW2dW4RxRgwTqyu7iCKUvtIEKY8nFITjMuTx2Fxa6PY9w+nOebGyh1zflh1VI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymt9Q+kiF5miiGD/lTGaBa5pLnj7LIyEghlRtX/0sRBaM5VPIm
	YqC0zXlUDDFialxQ9U1E8qsnvhmoqkBKdJbODu2REWJwDd2mY00nW9au8/uRgjM=
X-Gm-Gg: ASbGnctYLL4/AR3dg9PrYc4kkkO2XVyWWslD0TYDTVos8aPhZXHOXW4bE48Yo9DGRA0
	veGTQDR+sZyHOl1AKUFjot8NlMPajJ/InvFvfvgIPzK0pOk9dg54vLLwOsUi3djQMPX4NEi+VNp
	E4yywKbQT1LKjXW1lBaUGpjc9WgZ9qT1liy2CmWtFjdRNCe2bL20zZmNsM/AkVhgqwXtc8V9ZnL
	eRbw7mJ6T25jU/hHKIXe7keEQJb3YpAuCaXdgBduTR1Pl3K3YjyXabXMgQZJgBrrj9PTCDo0wpv
	L3FAfMYe7eFGdI3F6aG4TclNKfIOUNXzsrsUivK2BH3QCcKHH+POS/PjrIY5r8W3Kv5M
X-Google-Smtp-Source: AGHT+IF5VdlQoCV9oCONwjC/ThYn3VcYfxJUAmQrjO1EVRyBJ0ebnlFJ6vtE4G5LDAS5flAUkh2xUA==
X-Received: by 2002:ac8:7d44:0:b0:476:afd2:5b60 with SMTP id d75a77b69052e-476c8130000mr33793671cf.15.1741955296695;
        Fri, 14 Mar 2025 05:28:16 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:cd19:6a0f:e1a6:e800])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb63f3a4sm21905821cf.30.2025.03.14.05.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:28:16 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v3 0/6] rust: reduce pointer casts, enable related lints
Date: Fri, 14 Mar 2025 08:28:04 -0400
Message-Id: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANQg1GcC/22MywqDMBBFf0Vm3ZRkND666n+ULmISdaAaSSS0i
 P/e6MpCV5dz4ZwVgvVkA9yyFbyNFMhNCfJLBnpQU28ZmcSAHCXPecXmxTMVjkHRirqsOl2YApI
 we9vR+4g9nokHCovzn6Mdxf7+zUTBBJM1Gl5KUeimvvejotdVuxH2TMSz2vyoyDhDaUquTIPYV
 md127Yv2INE098AAAA=
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

 Makefile                               | 13 ++++++++++++-
 init/Kconfig                           |  3 +++
 rust/Makefile                          | 26 ++++++++++++++++++++------
 rust/bindings/lib.rs                   |  1 +
 rust/kernel/alloc.rs                   |  2 +-
 rust/kernel/alloc/allocator_test.rs    |  2 +-
 rust/kernel/alloc/kvec.rs              |  4 ++--
 rust/kernel/block/mq/operations.rs     |  2 +-
 rust/kernel/block/mq/request.rs        |  7 ++++---
 rust/kernel/device.rs                  |  5 +++--
 rust/kernel/device_id.rs               |  2 +-
 rust/kernel/devres.rs                  | 19 ++++++++++---------
 rust/kernel/error.rs                   |  2 +-
 rust/kernel/firmware.rs                |  3 ++-
 rust/kernel/fs/file.rs                 |  2 +-
 rust/kernel/io.rs                      | 16 ++++++++--------
 rust/kernel/kunit.rs                   | 15 +++++++--------
 rust/kernel/lib.rs                     | 25 ++++++++++++++++++++++---
 rust/kernel/list/impl_list_item_mod.rs |  2 +-
 rust/kernel/miscdevice.rs              |  2 +-
 rust/kernel/of.rs                      |  6 +++---
 rust/kernel/pci.rs                     | 15 +++++++++------
 rust/kernel/platform.rs                |  6 ++++--
 rust/kernel/print.rs                   | 11 +++++------
 rust/kernel/rbtree.rs                  | 23 ++++++++++-------------
 rust/kernel/seq_file.rs                |  3 ++-
 rust/kernel/str.rs                     | 18 +++++++-----------
 rust/kernel/sync/poll.rs               |  2 +-
 rust/kernel/uaccess.rs                 | 12 ++++++++----
 rust/kernel/workqueue.rs               | 12 ++++++------
 rust/uapi/lib.rs                       |  1 +
 scripts/Makefile.build                 |  2 +-
 scripts/Makefile.host                  |  4 ++++
 33 files changed, 163 insertions(+), 105 deletions(-)
---
base-commit: a1eb95d6b5f4cf5cc7b081e85e374d1dd98a213b
change-id: 20250307-ptr-as-ptr-21b1867fc4d4

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


