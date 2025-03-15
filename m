Return-Path: <linux-kselftest+bounces-29127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AD4A62C66
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 13:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A2407A3194
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 12:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16261F8BA5;
	Sat, 15 Mar 2025 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7Fo8x9/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763ED1DF969;
	Sat, 15 Mar 2025 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742041053; cv=none; b=Yv8g2TauGOAEdL3hMRUWlDS4++zASvxj6ZqijiAgMwXU2/gp7II6MYbv79o220JD0q9u9p9JkfE8+iex78cHOJClU7WmMZTJn2Zq7L2rXc6LHRDHT8Sa6k/VdtHP1zbGUn4dywg9jLaVh3aLoNd1Sban/ZQmF5/KJkcaAspY3Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742041053; c=relaxed/simple;
	bh=gX1DUCeCJ+4M+gJdu7YNfSa+/uJAV+ESeDcck+bOscQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IrpWo2MwsmosqD1xnqULu4PxRll/g+3XzvjY0HfeXtnwjWjMA66oZ2SXJKHW/m5uzW9JGgpGJ+ZYYvxWxYHc//jndKQd0g3Ed5UBWBqbtfxmWh0g/7osK4barce6ClZfI1Jl8n8z7fJfrIgix5LMc1UtDewkZcZ52/mslH6z4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7Fo8x9/; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c081915cf3so389492085a.1;
        Sat, 15 Mar 2025 05:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742041050; x=1742645850; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JwYUrcqSEsuK/VKn/ut+w56cv653xVL29EHNB+HGP9Y=;
        b=E7Fo8x9/W0Puv0bybDADfLxUYg1CsqTAr9zOzsMUpz2hNP9nWJ5HyglCaQjKA1TP4h
         1vcoga/j8RcnaIbbOqEJ0zDTJjlLOgrm7U3G3d9L2jz+FL/rlsBaUFF1S8LjXD8v/4MZ
         +Sh1ySTFb/wHkkTFziWGBloHHQZjHQvD0RwqOUtdQmvaH32LLrJgxmAY5mjY/e3P1nEm
         RSoHmjgLGYkR0Pcy9gIUcIHIi8UK1fQMUk8rZ/wIyRsdfZ8rqMn0x5TSE5cETyt+qky7
         G3mNVF1x80jzd8PrwLpw19K5K/UshyMT//Iy/oLg8NxZJ0ApoYBrBG5Jlt3+Sz2yXUXs
         OCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742041050; x=1742645850;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwYUrcqSEsuK/VKn/ut+w56cv653xVL29EHNB+HGP9Y=;
        b=R8bL5W86kH40KPzF5sOv9NgbvcPigzV8bYrFHl9BFNO7zLcNd6u1LfJZTL91BYouGW
         nfY9AoaMFNTKPXGGkI37NsLQyCkqPR0BjJw/zto3JXclJgvCinB40kpDtu/5wkknoEDQ
         L+ZZSRCT06l5+VFyfYvo41P3/CxSG9yvvmganKY85yTLLT2JBlJ+mMTP4eFGVD6NjzjT
         mlIk42nc13uEyapbukJ8WgKEXeSRfMoe1xZ1xW6POJQzyktNpy//HcJL94Mh4hfPNX3j
         f1AmHfcjIJlL5H/BE+AcQh6iKY0iebGZvBRdgvvMVgEpHKIeze9ugJEfxprngbVBAFgY
         YidQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ngWwWkiffPFlaH0+jzvCSCzeFIBP8hGCgTJm6S+/wrGEND6VuYCCWI/zSokT9wzMJUIsU9TJ0b2jA+0=@vger.kernel.org, AJvYcCUBeq8NgmUuRzakTTqyasRvI68om5Kh5p3aNS5OtEgmmvQqEfAITFOPP5bToElgPyivadLGsYV1Y90o@vger.kernel.org, AJvYcCUd6Crc2VscoTDnaJyC/+pMQ2e7oZ7lh7+NbRrtLmR6/MumR0L8YsjDm2F4aEr8ZB30e0YAvsmX/p5AQsOPJ3M=@vger.kernel.org, AJvYcCVkY/NAoBXO4diDwu2W8sqiRKfzcAlKdwX3TORCx1vcYbQL48yPXtygnLckGYaMeHHv05s545/7r+TThCjM@vger.kernel.org, AJvYcCWYYvUeY5lx4kDWw/9smQga08s7bYtNzAzCJzIQ164La1l1jlrty0zhF7rzmjChxpa0IuKYWgNByUsN@vger.kernel.org, AJvYcCXTkp042jBp418Ti2U3fHAQKC4NFrJbrNplLYjz0/0sdKVWHdHS4CwosXkykQZQ7+hMPuDG4jadmFksCF2pyTCv@vger.kernel.org
X-Gm-Message-State: AOJu0YwK9CltQSy3RFzFYkcVwuGZTMDVFOkHqAtgcAQ7zk1FJJbwiBRl
	jDzhnRZWSE53TaJibVETkOHjDG7JDFyFUDlnmGIp2OpZnRXkiT4a
X-Gm-Gg: ASbGncvLHIv1vGN6MgS0A8o4GckIJN7HqgrpFGwIiOQyBs7u3YXyiH4k4ku3uM2hDH7
	e1UERbs8VTxVJm4YxiDg0C/wwJFS6/xecf0E+ksN/aP4PjLaiWOxEji343ubNfaY/DL31Vhu/1e
	dcD0DcoIp8MO2ahvXfyx6QMwhEB61Dl1JO1MlOrqygx7/O0H0SyGmoaN9J3botolo9zMLMAO32u
	Ut7EKcqtXFWqDyo7lUau3HOoLGsV6Z30h8sRMEGP2s90yNagT1Wo6K6RAKtUWO4xpcnCyM/AY9a
	MjVbCVMZadj/YIE9eTXtHUXZ4U+l3kfD7BtwBhVqylVPdCrYfAlRSmfHZvOMIjdCuTgp
X-Google-Smtp-Source: AGHT+IGYB/jcWeYcdYJs7Uk7VmdwuhcPAx15iHufd+zMiWEPaNoMEsBjDwbbc5XG0cjmyNHmiBTXaQ==
X-Received: by 2002:a05:620a:469f:b0:7c3:c814:5943 with SMTP id af79cd13be357-7c57c79b8f2mr930746885a.9.1742041050226;
        Sat, 15 Mar 2025 05:17:30 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:cd19:6a0f:e1a6:e800])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9be48sm371885185a.60.2025.03.15.05.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 05:17:29 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v4 0/6] rust: reduce pointer casts, enable related lints
Date: Sat, 15 Mar 2025 08:17:24 -0400
Message-Id: <20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANRv1WcC/23MSw6DIBSF4a0YxqWBKy876j6aDhBQSeojYEgb4
 96LjrTp6Obc5PsXFF3wLqJbsaDgko9+HPJglwKZTg+tw97mjYAAJyWReJoD1nE/QGuqhGwMswx
 lMAXX+Pceezzz7nycx/DZ24lu37+ZRDHFXIElglNmKnVve+1fVzP2aMskONLqRAETDNwKom0FU
 MtfWh4oZSdaZupkrQUlTDVMH+m6rl9WmY2pGgEAAA==
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

 Makefile                               |  4 +++
 init/Kconfig                           |  3 ++
 rust/bindings/lib.rs                   |  1 +
 rust/kernel/alloc.rs                   |  2 +-
 rust/kernel/alloc/allocator_test.rs    |  2 +-
 rust/kernel/alloc/kvec.rs              |  4 +--
 rust/kernel/block/mq/operations.rs     |  2 +-
 rust/kernel/block/mq/request.rs        |  7 +++--
 rust/kernel/device.rs                  |  5 +--
 rust/kernel/device_id.rs               |  2 +-
 rust/kernel/devres.rs                  | 19 ++++++------
 rust/kernel/error.rs                   |  2 +-
 rust/kernel/firmware.rs                |  3 +-
 rust/kernel/fs/file.rs                 |  2 +-
 rust/kernel/io.rs                      | 16 +++++-----
 rust/kernel/kunit.rs                   | 15 +++++----
 rust/kernel/lib.rs                     | 57 ++++++++++++++++++++++++++++++++--
 rust/kernel/list/impl_list_item_mod.rs |  2 +-
 rust/kernel/miscdevice.rs              |  2 +-
 rust/kernel/of.rs                      |  6 ++--
 rust/kernel/pci.rs                     | 15 +++++----
 rust/kernel/platform.rs                |  6 ++--
 rust/kernel/print.rs                   | 11 +++----
 rust/kernel/rbtree.rs                  | 23 ++++++--------
 rust/kernel/seq_file.rs                |  3 +-
 rust/kernel/str.rs                     | 18 +++++------
 rust/kernel/sync/poll.rs               |  2 +-
 rust/kernel/uaccess.rs                 | 12 ++++---
 rust/kernel/workqueue.rs               | 12 +++----
 rust/uapi/lib.rs                       |  1 +
 30 files changed, 162 insertions(+), 97 deletions(-)
---
base-commit: 2aadc0fc1f85d7a9ed2822ba7ee9f06775eb6d84
change-id: 20250307-ptr-as-ptr-21b1867fc4d4

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


