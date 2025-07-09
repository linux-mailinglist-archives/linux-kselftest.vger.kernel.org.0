Return-Path: <linux-kselftest+bounces-36875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF0AFF28B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6101E4E1FEC
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00592EA73D;
	Wed,  9 Jul 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTTyVLgt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADC42EA47C;
	Wed,  9 Jul 2025 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091225; cv=none; b=c0ERNoIBPDuX4FYxOKier/f0m6kqK/UJ4KrZCUZoEUkHUj1/6efmnJP1u44V/GuHWtktbz/NPX8jy2WlTMT3SQUYOZnA1dJbBNFtUXHLI92vkGDl90hz6e8d1KARiYOe93Uw6reSdQAENJfmlZ6txBvOsmggJuOZhmqD8W1xNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091225; c=relaxed/simple;
	bh=/btWUP0n0X4VrKOj7C0ipr6mRLMnevTc6PP+sDGYrAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RhxS8/AiB2mhJOExGQnHWmm1sQUr6EV0xGn6X/mVegPYfw0AsBjMqPBJN1SAQpMsSzsQ/4Seiz/BzCFD93OMMojygDf/1GV93XPWmQArURWoNypDiW31yz7YztpHlTIdpciXS0EIZCRqaXO1ihm6FuGdUB4Sx9wupJRnrA5gCME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTTyVLgt; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a43972dcd7so3145511cf.3;
        Wed, 09 Jul 2025 13:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091223; x=1752696023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqqQEFMAMWFSxOEt2f4fSJqPiVhSkTuCXGB3ZJgmOgc=;
        b=QTTyVLgtpV8FuMJIAtOrYdO4tObCait/fCvc9BidhXIHpjPmRnPUWTY9/amZaoIWAJ
         mzmy+B4WbfM18oL9y2y9UHOpmFOKV7qbiBuwSAXQTShjRkoHwvHPmVlAKic2TjS/KkO4
         x6WiqfbSPVyoDG7hiDtL1AD2e/+oElHOUlm5KHHH9/Ubd2nxjQcJVau3m9O3mP5XEzRA
         qle44AZhhX6YEY4ks3m32i2+5ZTcjFz9a/fe9jE0Iw07vrHapb6MUGlyjbqeFKqXPwLw
         tyZKtKeWMAuuDSsjFbUhpm+WLeA7S1qu4ONMc0TjpcjNWsLfVOmtxswlW3hed+woJd4z
         xnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091223; x=1752696023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqqQEFMAMWFSxOEt2f4fSJqPiVhSkTuCXGB3ZJgmOgc=;
        b=a8G+KUu0EJnWkbJEAYkvBFuF/cJ/GMrIf/aa6DrGKiqUamHuI/uHevmiXCT+1ptrLI
         yoItRO2xX+As4XByMC+Mud8CSNlBswWMd9lX9bmvcBMBHwIfbw39HcTTVM5QfbHqJTdd
         NYXYBZbPpD78g1fBphrqPthPhXzbdgw51157y5Nk195ztRIR3ZhpWgC7YulsugAaDp5n
         vAQJO2hc4rE9gHHBG7JMMn2yAqirCYUbWtFiTFcqOLwMUQ49BJQ2dn2abprGCoa2qbK/
         URU2DSxgT1SZJ5if5cCDK96BERD4df4SmRZwN2U6X2cclnjWqhzMfZh6xzJ1nn6A9K8N
         pfEA==
X-Forwarded-Encrypted: i=1; AJvYcCUMYVdA7adtqJFCXKv39K0niAeJuCeHbIx4S1ZHl3/XRDihJPex3XOM7R7lMptPWiYQp1fjbA2QANtn00/2@vger.kernel.org, AJvYcCUkQIGZSE2Onc1Q5YtRC6hXVXObRTtv3gWJwxKnJAcmKF4m4J1IifBqrrRrYrdUbDPNhdThwDTdIAny7Wt+JfDU@vger.kernel.org, AJvYcCVJVDQGtNFqGmVEfbA6gPW4MzKC+Wv73aKim0/tVBMAzf8eEe8rAM3UhG/iN0j2flFtpmsdAhHYxC0SLQ==@vger.kernel.org, AJvYcCXE6UrbHV6pROz+F1Z+RJrFpUfqLq0wJd3oU1hv09ByroaCZmy8Pr/8K5NeCzwnt+MRixGoVQAvEVhSXiGLWxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3eURpkT2jBhZsWFbp+BKogvuye5RhWdtZjzZbqfwK5XLvg5as
	NV36xbWkO0UkvGxcHpg7rxERsX6RedY0kTgO9e0d0K3TVS3gUbp6VQ+Or/MiFrBgtAOhLQ==
X-Gm-Gg: ASbGncuoLmENUnTAf3e0FT8lExaDo/xZwNPkfiWee8+RxLqiibzEIx3JNW7/LyWi/MD
	g1L7hqWrIAVvd5GTNfOsDlFIEkDKufqe+gqclvTuTBbRlWVMdEz5Oa4xlZjaCmGXhV6iusmpjxY
	Y5+6tH/3hjHWTmj4YmwwjZq66uEtP2a0R1kPv0iC7QNVld2dikoLBJC9DfkedhbjI9UnceX7aM9
	gV/R7NJhrvJFuqAgnJv16KT8UarJL3PQKTmFHWJkJYC+RZS00ZbIuhDX5XUv6M/rzQ4etaFPRGS
	Hwhl0zBSNmQgiulf+jUeIRuWNs3C2Fey+jFU/ebYNyyJGl4EY+3pdIRjjRgwKBhr+LV9uPnuTf6
	SU6q3eoSLs0+67krG7gf1jwWBYk139HcVZd0pjijK8FdqYVMYGtpqeJYWPA==
X-Google-Smtp-Source: AGHT+IEzgV6Gl/vLQY5H3tdFN2IVXBuNJVlJUU89GOFFkkJ8I9myDKhYc9XCB+95abmxj10FkjjiGA==
X-Received: by 2002:ac8:6f14:0:b0:476:95dd:520e with SMTP id d75a77b69052e-4a9dec56971mr68542311cf.16.1752091222853;
        Wed, 09 Jul 2025 13:00:22 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e4aaasm100432891cf.3.2025.07.09.13.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:00:22 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 16:00:07 -0400
Subject: [PATCH 8/9] rust: seq_file: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-8-64308e7203fc@gmail.com>
References: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
In-Reply-To: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
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
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091204; l=1622;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=/btWUP0n0X4VrKOj7C0ipr6mRLMnevTc6PP+sDGYrAE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QN8Nl+PlucSORLf04de7DEfBpUFw+wQQzlTCx3giK3H5W3rjldHLVCXuta8nfIwTsuOJHC5yW7g
 GKmguS/OQOAc=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/seq_file.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 8f199b1a3bb1..59fbfc2473f8 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
 
-use crate::{bindings, c_str, types::NotThreadSafe, types::Opaque};
+use crate::{bindings, c_str, fmt, types::NotThreadSafe, types::Opaque};
 
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
@@ -31,7 +31,7 @@ pub unsafe fn from_raw<'a>(ptr: *mut bindings::seq_file) -> &'a SeqFile {
 
     /// Used by the [`seq_print`] macro.
     #[inline]
-    pub fn call_printf(&self, args: core::fmt::Arguments<'_>) {
+    pub fn call_printf(&self, args: fmt::Arguments<'_>) {
         // SAFETY: Passing a void pointer to `Arguments` is valid for `%pA`.
         unsafe {
             bindings::seq_printf(
@@ -47,7 +47,7 @@ pub fn call_printf(&self, args: core::fmt::Arguments<'_>) {
 #[macro_export]
 macro_rules! seq_print {
     ($m:expr, $($arg:tt)+) => (
-        $m.call_printf(format_args!($($arg)+))
+        $m.call_printf($crate::prelude::fmt!($($arg)+))
     );
 }
 pub use seq_print;

-- 
2.50.0


