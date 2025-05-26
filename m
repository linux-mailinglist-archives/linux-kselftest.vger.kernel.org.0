Return-Path: <linux-kselftest+bounces-33808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC52AC42FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 18:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97A37AA2C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 16:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA2023D2B5;
	Mon, 26 May 2025 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJOrlQhK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC8418B47D;
	Mon, 26 May 2025 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748276767; cv=none; b=WF3hqk0gyrVtVOMegF+qYRJx3G6v0rnPyhP16XGx9z4dAtPrOp7eSdAJtEvap6QzG6jx2fdy9yl8F9G8lq3oU8iCREV/s91WK5g+5CGGO5kFKEWdZs7QwqPKJZY/ik/VHnPcWLVhFmVUeHrsnQNoqrG0FXSGPJKSYMVNB/iLKn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748276767; c=relaxed/simple;
	bh=M35dFexYLidB830tkHYUObus0SDC+kr81OpBRvuZe6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JG5j2m3j8P1Xkoysmn6RarAUYgRf2He0kIOFChLckoNHwPDPrl5BW6tSG+wNQNLFaxlFnD7VDa6Rn1mi+SiYK+booz6EEcrzz6ApzY5H9tAEOzGjQMUdYsgH953VT0PbaG6KqhaiUGBwRN8tD705SGuiKICxDLdYOf/pypsv8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJOrlQhK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7426c44e014so1843359b3a.3;
        Mon, 26 May 2025 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748276765; x=1748881565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ik007ITUlo4bCusnTeFEWPAXCHMBCQv2tPryy8pcJzU=;
        b=eJOrlQhKcU5X9Br/8nhw5RMkLgsnIwkkkCiuD+JCwaHXXkzw0jd+v7qrT3fM3W9noq
         l4j+4isDxFtE51VOprhpogmX3A1JidMAZLSl9vKIrpkqzAAlthOdTsARazOXgjlW95jy
         c4Z/XVNYW+0go6DY0SkvdTIzq9RT7wYWKeGaU8q4DcRp4iGQX7GFT9a/cmhE+R5AU+k5
         BixLjT9vmlVnYA5EDVPzaYgAq9zMVPW3gTMPY06v6IFtBnPdIwO5Wk2u3ui9KRwS8psW
         bQkRLpJqKUywE/DhJsXpicfgRV9y+Rf1RZ11YkG98vv7W2XHSFIJzJdfT6WrP6Bus3bp
         RAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748276765; x=1748881565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ik007ITUlo4bCusnTeFEWPAXCHMBCQv2tPryy8pcJzU=;
        b=k5/rMLXmbnoJ4E6x70dn10OxDRLbCRF3IRj5coLAyOYF1wMsBgi5NBrTUAcSOZNv3R
         ODV08dHZPb7HOvYj5idkXIBghg1cwI3vAy2kvdbLA5oxFRvdYUXgKrAAKUVNOwQh3Fsm
         Do+f487w1Zu7rREvUjRicn3i1XopEZRuKU7J+4soHweZzEDd2jp3e5jDO6KbB1IKxLqa
         reLew2kdPPT4b0kwkZfwa+DFlJaeDG7a0TGwuEvsNw0UBaJm8V8cIRpYpSM+eodyVa2Z
         iSPsSF/BXRfVdgT137oNvUznuSiUJxIqCZmqfRNyU/weBOzA0fxBozoPzQiG4iSaKNm1
         LNQw==
X-Forwarded-Encrypted: i=1; AJvYcCV949rt/YrlFPvFuiTOKnfjAW1HWVBcAe80gjIoq0w6ynAnY5rz8ptmzzmmtTjESOmZtTqXOFDCcQ4WncP3pLU=@vger.kernel.org, AJvYcCWOWaXMuSSrexoCsfxCB4PkY7+rR6MEhCDZzP7xKXjRcjIIT3PBqC6ao17L9zVNjHESD8Sa/VRALsQuglc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzumzmo2grhCF0hffvdGvqF8o/HxIwrqZEm8CK/tLm77IQK8V1u
	K68rxL0F/ASGWx+jblw1To19igH6hmu6Ig9wUIgRD54kF/JZulfbsul+
X-Gm-Gg: ASbGncuW5n3unLlCsq3vQ/KSdp3NmTVNtkGTpDNydNfSHgBco3YXe+lg0elhZWo4UsO
	fvPZDJW3hi5Gdb+hKdstVLtl9SxkCiIcUphnZstH1WWmlMSqN6iWzCU1mRzJXxSEKkxhj71W1qf
	k7XtX8hzJu2R9LpvEFkCEMZ0jDFsg3h9uj8DdNq9F1kch2m1C5prYjH4NwQrZc5T9pyaAvXCRGI
	OX3lODDtIWe72dim0V/W64xoPZbdarPNj8rYEyzc/TOJ3GzVl0jZXv50eW/gGymxpv9eh/wkqM3
	eeYIQsTZ2VQghPnPHWDQqvgbB7OChg/Km9id3KGFCIKR5g7/P5xdjNnnaVcMgRw=
X-Google-Smtp-Source: AGHT+IHEFgU/cdh1VCYqzq9au8ZWg3CCbMV/n3zvIVsW8px1Sz4WVtZwZqVr5s+JLHm7jhO97p6qfQ==
X-Received: by 2002:a05:6a21:8dc6:b0:20d:5076:dd78 with SMTP id adf61e73a8af0-2188c3c78f7mr15262796637.42.1748276764874;
        Mon, 26 May 2025 09:26:04 -0700 (PDT)
Received: from localhost.localdomain ([104.28.249.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829af3sm17876591b3a.94.2025.05.26.09.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 09:26:04 -0700 (PDT)
From: Jesung Yang <y.j3ms.n@gmail.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesung Yang <y.j3ms.n@gmail.com>
Subject: [PATCH] rust: kunit: use crate-level mapping for `c_void`
Date: Mon, 26 May 2025 16:24:29 +0000
Message-Id: <20250526162429.1114862-1-y.j3ms.n@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use `kernel::ffi::c_void` instead of `core::ffi::c_void` for consistency
and to centralize abstraction.

Since `kernel::ffi::c_void` is a transparent wrapper around
`core::ffi::c_void`, both are functionally equivalent. However, using
`kernel::ffi::c_void` improves consistency across the kernel's Rust code
and provides a unified reference point in case the definition ever needs
to change, even if such a change is unlikely.

Signed-off-by: Jesung Yang <y.j3ms.n@gmail.com>
---
 rust/kernel/kunit.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 81833a687b75..bd6fc712dd79 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -6,7 +6,8 @@
 //!
 //! Reference: <https://docs.kernel.org/dev-tools/kunit/index.html>
 
-use core::{ffi::c_void, fmt};
+use core::fmt;
+use kernel::ffi::c_void;
 
 /// Prints a KUnit error-level message.
 ///
-- 
2.39.5


