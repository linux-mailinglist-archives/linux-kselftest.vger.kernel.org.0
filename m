Return-Path: <linux-kselftest+bounces-42341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E24B9FCBD
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 16:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B176416D320
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 14:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889012DC77A;
	Thu, 25 Sep 2025 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeuPt+tL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A982DC35C
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808552; cv=none; b=q810VMjdRtFLE2mVsjHeZjhZJcUF8TmfH8CWcgURv/+J3q4bjyW7ODrG/C/F2ipt9XSaASfPdjU5F3X4kek+MKaXZ31CPX4FTHsKiI8xQ6nHSmzztNRhsb4zv+HgaoaebB0ehrME08sEDNfVCmMP3nmz7KvE1LJkU0jr6cystVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808552; c=relaxed/simple;
	bh=/zHlMKa0b7Nk9siO6gKcN+x/h82Zk8zkURVvpzNt6AA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bo/1ap/3eqKcOzUkhA4lTiUsLP+x+IPMiQBYHmR/ZOiUIdmR8LNtJuqQdEsCnF8zSXnOMqchXuQr1ub/ITm+P19DnpI2ArseN70XMWsQUSXjAM1yNNxvbQqEqTM/SQmEfegGG6wexuCU5k9ZopRQS8++QHetqfHecwMeZov5F20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeuPt+tL; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-78f75b0a058so7327246d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 06:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808549; x=1759413349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGNwJdiqffAB8BrNoFOc3im0f57lc7sAudNYea1lra0=;
        b=KeuPt+tLwr0z6WDSP3y7Sd8ARJjyqhBS+8J19v53/oqlcmaVyTjZxFiSaHYUc0eDWv
         HXtJzPM1aKkv/FaVdl0+9Dg2K1BDc1e+3yquSp9hskiLhew3+7oaC1lAXRBrVixuzxZX
         2pjos2w+kAiFtnlfKbsuBkq//yKRfyGhmiZuxp/m8RBzcKsDDyzd5YtXMqmH18RCBzpE
         pVrGH/KYTlH39BJblDgoplC2+0SetRV3N1H6glaSSKPK38tCBu+1/D6Dmnp9U8vmqJLL
         yQmSg1knJMR6xaj4nUnqodIGwo3vS5nx5G6/+UknyfHYGteUeiVMpFfvIJQRbUqZfm80
         yDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808549; x=1759413349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGNwJdiqffAB8BrNoFOc3im0f57lc7sAudNYea1lra0=;
        b=PBprn4+s6L4WF0QQcfWOD3Ar7TLh8Qe7U7TNZyD8BGInciQu2kCH3mwTLvvSUEKtmr
         8oXLkLoVN/U/Ow2291Xx0aEak1gE1erOkRrELMIWywPFq3ihI/K3d5ONrvxbJGQEt63+
         72VenZm5iUOt+mw0KKe+q1JnHjYFCaYCi3Dw76WLo4D1To3974gtTqoWJZRkP/bVy/H6
         3GbkX79nXSR3s3h4qFO+wgBwf6Cf31C51wjiB+jaGS9z4MJYJbrV92gSDwGd73vUTviE
         yB+5W0dNSmIjrdgV5z8bKt7wThvAsVfZ2wM4ZxIdkNQ5YwGLLeA0uWboG7TrQjM5/ux+
         izaw==
X-Forwarded-Encrypted: i=1; AJvYcCWAtTKdJ3isdbyq9mXBvKmOl6UNk0dbn6flL4rGnjMwZdKbO+xrbOFf7xSvsFNXpXcG3xxFsz+F6V/VEB7BuW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcCfu4Glf5vGkW7bRwcOYdX+Jly/JQVYyKy7/6A6gbZFUUwFpH
	QaRZGmWz4uwzjlbhmg2cfV6PGHQtm+dgnGLo4+puzYhUriuvMJIrKW90
X-Gm-Gg: ASbGncv2LbEM1m3U/ddLyt+n8nXKTzg2bfQ07BaHYIZADTqNAUhZFzcq5oX4YLbShAn
	0rJtwnrNZxfo5khRj0qBdfwCtk1NhoXfJqQWvQQi88rwAVFbTSZWLPdtncPQKomS9TXhi9TlGRS
	A/w5FqelhOBcY9oB/DUKsz8BIG0SN9RdhSng7wLse3DMkxJbLrEW16zZmEtoA5U/APtHnEqK7xt
	56Ahk8XnkyxUAxOH50YHeNLfG5blU4A9N3h6tTl9reYzug4am6r5prWVKgE9Qft3iXdA+5iKJm2
	6hSv8yDr141XHMtFbw+kpwhbxjdLhopEviFOQlWqyDxxiyvhrhwo5WDVHLFYkbwLNfpWWfwMqsO
	4mPTTJHnr6Eszsuo0mgEx+ROM20GXokCviCRl+atoeKrvH0HM1MsqIU+PYuyAx/QeUiTQhqmABz
	DjTPcOQ6ZLb0DeVs/V5mN2OqrLk0xCtqgWlIodoR8uwcXrptlOiCzaq2QH5dmBbq2VcRSL
X-Google-Smtp-Source: AGHT+IHxxrN1qiYt8CkNZDH6mAY2ag9p3EBYWx12nFthYZnZa+rBx1Nas4oNQjITBFEWvlFgd3yNGw==
X-Received: by 2002:a05:6214:27c3:b0:7f0:e84e:b2b2 with SMTP id 6a1803df08f44-7fc451680aemr56106776d6.57.1758808548877;
        Thu, 25 Sep 2025 06:55:48 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:48 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:54:03 -0400
Subject: [PATCH v2 15/19] rust: seq_file: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-15-78e0aaace1cd@gmail.com>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808438; l=1328;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=/zHlMKa0b7Nk9siO6gKcN+x/h82Zk8zkURVvpzNt6AA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAXSvElYTE8YxZCsGrWl/FvFn0PcrKAZK3BdoNzxQTxfQ/m2OpN47pZ17tScZDRCYR8bMK67o/2
 oeQSiKFoeSw0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/seq_file.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 855e533813a6..518265558d66 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
 
-use crate::{bindings, c_str, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
+use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
 
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
@@ -36,7 +36,7 @@ pub fn call_printf(&self, args: fmt::Arguments<'_>) {
         unsafe {
             bindings::seq_printf(
                 self.inner.get(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),
             );
         }

-- 
2.51.0


