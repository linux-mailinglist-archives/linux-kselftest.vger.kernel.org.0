Return-Path: <linux-kselftest+bounces-37656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0325B0B25C
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AE417E755
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C25028935D;
	Sat, 19 Jul 2025 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZT+h0TU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86512288C19;
	Sat, 19 Jul 2025 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964935; cv=none; b=doQe/2fi+lC5g7AzuKGfD4TFBnWctELXIpKmLybNN+AbHb/JOa+pZq3FJk4v/Pmo/FFjR4D0imM6MuYqthUQAniEhoct1ncRKwbUV3B3rURkR7T+0awlhBifO+X9fNJpSwRuwnf06JVrCNbwsQqqghVSaq2n6xx/oskbFgrszBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964935; c=relaxed/simple;
	bh=vuDgQYV2nbF6wDrYHHf8eMvazUJvWvWnDsga4yR8ZwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=irUqY455QqWH6WmeBHiovH1RVzoMmrlwege4Utg4xjmhLueIkwNckpdppeLmq9c0+VLNtDEVUQidJ02ByEqHUIiZjhzheA3qE2MWCqxLCg5QetP6gIuoLIEbFb0pQ6zuMjYLymnNQ2t0VxaZmRk8VY2T5pIbmS7PlOW9bzipzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZT+h0TU; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e1f3b95449so411533185a.1;
        Sat, 19 Jul 2025 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964932; x=1753569732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aw7v9AoXajCiA3y3c/HUxv7RbEkPrpCQfUUsk1ERQPc=;
        b=EZT+h0TU0oLwbPuinnLgsShLRTetSzye2dsR3wdyhgg0d12WUyzJnmLQoSpac8ZNf+
         OH9nUwv+MAxxkFcDflvL1/tOrBc4uaA6LDlew9rQvQixvopecB59Pi+oRhHiv5VleUNs
         Wm8RSN+3j+zgk2aRinWA5Em56dxKM2qwcR59yXPdtNIZa3/1mg/lZuolVWnWe/XIvgNs
         qwAk9SZnRDAxy1qzTuakL4PVvyXX3mNboMNIEdbSjCbvz7TUYFgYiMQ1QLXKLwiq/qKO
         uLmC/7Zf/ruvXaTDVWXelKriwhQ8HjD17/rjfNbc30zLiX5htYUIXLLB8M85Af/j6K1F
         F7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964932; x=1753569732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aw7v9AoXajCiA3y3c/HUxv7RbEkPrpCQfUUsk1ERQPc=;
        b=cNw0pgqddN5R4gh0FSLltZVBtdW0ISFocG0hNgN1saeEA6wwsIE0FojWYcJrame/k5
         5cGrWpdPRAMzEB3d0jwBmJedxSDxYWhsVclR6J1uz9rC9Fvb58jzBe6ehkAlLX12ewbb
         pBgsQNNCHoUnTJEg0mNmLXjGKsb8SkK/MTJXJVDCZDvZE4nZBQT3V/TQHCFqamIdMOLB
         OolBCscQcUsUo08Z7pBN3Z1aoEzHc+U+pQbdZxSDODoQMH/4U84iE0L/KWFTge4VQtqZ
         d5VhlJYpcmuoJ7JDp4fZVQoGMhkjmrwD6c9TQttv0ObME/pPyjUOw0sWd5OxJUBg6eWh
         gaGA==
X-Forwarded-Encrypted: i=1; AJvYcCVn2HcwcUW2XzLzs4ucVHNYPAjt8bcAXwBdgAY8QhITjQbwIume6okgn1LErRyxPLDutya6Q1CTLJXrTY8pk3U=@vger.kernel.org, AJvYcCVuYafe+FjNeBy27u+GkteHIOFuVDYPiergucWFmwGP6E+KKaK5mNAA0kGyNJiiU8etIpIwyfqeQQGRSw==@vger.kernel.org, AJvYcCWJM+GrfgYPqkFUo6MNXgrsb1HmQVSR1j3ioh5HBu4r3mfRuAjVFaHNHJguaGhCzf+6bHwdaYHZF/WhKiGg2dQG@vger.kernel.org, AJvYcCX4W6WGxr5R7k9q91v/j55+hVOndoynmBuZo8gyL+yGWgMAZWzh3yn3WdnSEi0NhPkUToCS8S6OBKllx9h2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi5pylgMIDG2HavTl1F2kW9CzAWHRx/fjkGBgumfEabx/OMele
	R7sMufrvXOdxMR8iGAoJX5XXGpgt5NcAxp0f3xxTM6QN9fXc1iXeybic
X-Gm-Gg: ASbGnctzVIr8lKxObXNLzVB3pCnGPa7rb0hA+jUT+WDKMVOiro+wTcVTfgF/u3mKXwA
	Qp6YvCGOZvA2Cu67MpdzAEwmyFqB+Bu4fkYff+V5em2vl5wB2B5m8FzCub9JstSHlZR6QkYm7Qh
	afS0xrKeJsxmtt5AzS21kT2cFQNzJ3ElOan+sSAaH55eOGfUq+CN6DORRvq+Yqd3tCfoczrY9KA
	ppwzMtHBO4wlqyZroFH/e85bCcu9qH3xczvdHSkgnWaUH04O+fqiYja5wctkUh4qW+soXZsZ2rk
	k8FDmctJ+rctUimR+WSRwhGtfl7UUYB9OdpeKTV59OGjdcQFSgdHTU0ip7MWnOQKmF5pFLjL3vm
	7VKQ7aM9RH3huVRK39cBNALs0J0yiCb4USVdUVhfXppTtLvh8CYJtq2HoWkSZfcmOHyx4ejkbRT
	MdXJVC4M+1OntyZwLdMikfCVE/BoUP
X-Google-Smtp-Source: AGHT+IHTev6teKqBxr3yVPaGIfkg92j5uUM5edVfrIYIKgPuAl81m1vfH5UUeD5NEDYnMWK+yKJIxw==
X-Received: by 2002:a05:620a:1a25:b0:7e3:3682:6dee with SMTP id af79cd13be357-7e34d1094b5mr1835427185a.4.1752964932457;
        Sat, 19 Jul 2025 15:42:12 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm251550785a.84.2025.07.19.15.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:11 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:41:52 -0400
Subject: [PATCH v2 3/8] rust: block: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-3-1ab5ba189c6e@gmail.com>
References: <20250719-core-cstr-fanout-1-v2-0-1ab5ba189c6e@gmail.com>
In-Reply-To: <20250719-core-cstr-fanout-1-v2-0-1ab5ba189c6e@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Jens Axboe <axboe@kernel.dk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964924; l=2909;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=vuDgQYV2nbF6wDrYHHf8eMvazUJvWvWnDsga4yR8ZwA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHc+KbWe0mrNmiJ0AautqYraxFDr7unwZE/5c0RQ2Ojk4ru4U2Oae0ZmVmEDXv7ZRDiXgq3EQH3
 G6511ib+cXQs=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Custom.20formatting/with/516476467
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/block/rnull.rs             | 2 +-
 rust/kernel/block/mq.rs            | 2 +-
 rust/kernel/block/mq/gen_disk.rs   | 2 +-
 rust/kernel/block/mq/raw_writer.rs | 3 +--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index d07e76ae2c13..6366da12c5a5 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -51,7 +51,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                 .logical_block_size(4096)?
                 .physical_block_size(4096)?
                 .rotational(false)
-                .build(format_args!("rnullb{}", 0), tagset)
+                .build(fmt!("rnullb{}", 0), tagset)
         })();
 
         try_pin_init!(Self {
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 831445d37181..61ea35bba7d5 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -82,7 +82,7 @@
 //!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
-//!     .build(format_args!("myblk"), tagset)?;
+//!     .build(fmt!("myblk"), tagset)?;
 //!
 //! # Ok::<(), kernel::error::Error>(())
 //! ```
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index cd54cd64ea88..494c95623b97 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -6,9 +6,9 @@
 //! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
 
 use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
+use crate::fmt::{self, Write};
 use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
 use crate::{error, static_lock_class};
-use core::fmt::{self, Write};
 
 /// A builder for [`GenDisk`].
 ///
diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/raw_writer.rs
index 7e2159e4f6a6..d311e24e2595 100644
--- a/rust/kernel/block/mq/raw_writer.rs
+++ b/rust/kernel/block/mq/raw_writer.rs
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use core::fmt::{self, Write};
-
 use crate::error::Result;
+use crate::fmt::{self, Write};
 use crate::prelude::EINVAL;
 
 /// A mutable reference to a byte buffer where a string can be written into.

-- 
2.50.1


