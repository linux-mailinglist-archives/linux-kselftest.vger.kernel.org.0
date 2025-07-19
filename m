Return-Path: <linux-kselftest+bounces-37657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAD3B0B261
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5912AA45AA
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B00289837;
	Sat, 19 Jul 2025 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrV8+c8o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFFA28936F;
	Sat, 19 Jul 2025 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964937; cv=none; b=owAytI03YPDWwBTkyab0O3l9WXq379o/gaFNU4/XmPdQKQSfJtxBwtbXEDSgMjuJjEBI9blSKpket9ohHERuoRx/pyOr92skGFmmhfGSoir4ojxWNIbbcmvU1DiGpSyC7bIgv+KUOdWpyi+HdoakVgLmOdJGfe7C0UMKv02kHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964937; c=relaxed/simple;
	bh=CRl/lQSZVYzZ8ljWAUnUAXiehzAwEFBaZRkNdCXXhsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jDXP25utuZRfiJWgVorhkGB3nojVPKDbGlgDT5DjrDN/VUPCZQc1zoRtedFQPQ9FpbwnWj8Yn60Jnm2Mk97kVQ4w5S5jmy/g8+Jt7eooW1pStMqJY9P0/I4CfvQosNT0NMpWnlfYNDhTlf1odDQc/efTaaUuWCRX2ljsnhbkfIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrV8+c8o; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7dd8773f9d9so310923885a.2;
        Sat, 19 Jul 2025 15:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964934; x=1753569734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBla166t5r/3r2D+ChYAZke2nd+xgoyT3sVy8XOPMb0=;
        b=XrV8+c8ougIEpE+S15aQJqU2b5mGe+hObFmsOEJGRhVsZE5CFinLNhOFV4WUnNzUBs
         zw//CORsQCZWYP8JBYwCgugTUvBPulxC9eAD0t2O5BGXOU8Jpy1tZP+33j//QfC8Zi7Q
         FQNcGCSK6jhhhX34FtzYBqIUvarCAig7Zag4ROZ9Dvno3TsWe1BpWmxfGF2VfGH0OymW
         uz66Zf8IK60eyuMun5xng7y2tNQ8CyjtrBJII/suusDXaKvjHkYQH4r8t0cQtuvW7JtQ
         PCnnwnDtCKPWyejau5mf4N9VC/aw5WVIiJaj7lVmkdIYds+GjRnU/onBvPbYYorWTXri
         MHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964934; x=1753569734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBla166t5r/3r2D+ChYAZke2nd+xgoyT3sVy8XOPMb0=;
        b=ulHlnC0MO/LpvBcovWEo7pjkjpZoE3F7x1akHmpMYKK2LbtDmFcB7Hbi1RSsUFU+Eh
         W8xYr36Lz4s6RCLeGYZQngeL4to1OtfDcxAqNQeEx09g0uIJdANJtezidrmm+KiOj931
         wz4r/qdLzFKTm38mbronlFk474rQwKRNw6iN9ZaM4RMueW9ibFQs/Q3HsXFIjUoPnP9P
         tl9XutJYpXeXWZ92++7etfPe/+Q6FgQkcOl4S0NXUeZsVwAhODjHZsdvNJg7F0t7aG2t
         RNTMLGvAxOva0WTWrMCMgOuHUq7q3g9Zot8ssYLZOqPYPxzpJfqhXQetoz5zlZFdiayG
         r2cA==
X-Forwarded-Encrypted: i=1; AJvYcCUw9T9YJqapwzyodkuJ9FTTWPhq4LXhqh5NT/JNzbSz7Rn4b9BLJq/xdw/O9TZYWBUtmTm1xKQ0MwxYPTqDtlbN@vger.kernel.org, AJvYcCV14Eu7j/404N9bLfMcvLkrleqs4KvAqen7PtmzYE6NBXHGCvaW2ByDzn9hPd3HopHs8KI4HixsQ/h0091noUY=@vger.kernel.org, AJvYcCVQ/wJqjxbC0TiQe32Vd9ga6fFDCOHSLTOxkPNQoOjQB5FEF0Eab6FS+dRbPrTWuLlxurL0orRC1ESQ7FqT@vger.kernel.org, AJvYcCXBE9aUI7LRKQvXQGqO0CRNYsYhHwc1oMOyZdL8kiZHfU3AK1jogY5mzyfL4Z8G2zq/y2XXb02iOZ5P7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuVLtoemxd+mfFa936xynrlIIzVwYWGwXu2RApxqYodIa8bR1G
	Mc/kD+YfW3a6km5uGSDIOuPRmjMZhFFx9FX+UzzdTKaXWS6Lg6eIpfxf
X-Gm-Gg: ASbGncsx7wdC6eTqd3qN8bZtFgSTSD82jHTj6C+iH9Il0On0p4egP4lAbKMjBqVob1D
	mYz+dNJL0AWQIDx5z9mLgo91k/LbAuf70k+RGqG8Joyv9XXB4XPylZZjRgqUeYHVUsDTN6zoEUx
	7arPykl695nh0a7HI+Isva/sPUJvduTMez3LIl9lcRjwEft9ZY/MrdLzDJ3w8PijJpvDdQp722S
	wkS6d43ojAoMEEA16w7S87bPdJLVSBteyC5OU+twRsUZ6LUuzJi62KvQlkNrAQ9Fk83uzdjHECJ
	0HR3jhd5q0mCrFSuG58L1BtQKdAFCPaRfcHM9mGDeojC4IsXUl8P7RGsk9r8Oazy8VaYrqrzpzs
	rj8JyOp6st/+19suI3jwqofJ+2nAfx/I11W4SzQRWtUSzJXn0eL+L4wmeySI+5Y2oKfgKO13KeO
	AgaTojhvLR0s3LfUAU1VEQxADRsks2
X-Google-Smtp-Source: AGHT+IESl2YLjvcT4j9is52UMA6fKdbfS1rWW+Nul6Pb+u8f5NHy8MCnsJDoGVOb40bOsnG8e/xlag==
X-Received: by 2002:a05:620a:371a:b0:7e3:4899:28ab with SMTP id af79cd13be357-7e348992b22mr1949092085a.57.1752964934197;
        Sat, 19 Jul 2025 15:42:14 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm251550785a.84.2025.07.19.15.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:13 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:41:53 -0400
Subject: [PATCH v2 4/8] rust: device: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-4-1ab5ba189c6e@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964924; l=1290;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=CRl/lQSZVYzZ8ljWAUnUAXiehzAwEFBaZRkNdCXXhsU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAdqNNzgmFK7wLExHbGwFaZHfT+WPObXmybruma+nVHZ+/uH3ldrzJxHVRnirRqQXJe3FqZDEn+
 f9lwVHboijg0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/device.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 5c946af3a4d5..9e9ecdb1beec 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -5,11 +5,11 @@
 //! C header: [`include/linux/device.h`](srctree/include/linux/device.h)
 
 use crate::{
-    bindings,
+    bindings, fmt,
     str::CStr,
     types::{ARef, Opaque},
 };
-use core::{fmt, marker::PhantomData, ptr};
+use core::{marker::PhantomData, ptr};
 
 #[cfg(CONFIG_PRINTK)]
 use crate::c_str;
@@ -345,7 +345,7 @@ macro_rules! impl_device_context_into_aref {
 macro_rules! dev_printk {
     ($method:ident, $dev:expr, $($f:tt)*) => {
         {
-            ($dev).$method(::core::format_args!($($f)*));
+            ($dev).$method($crate::prelude::fmt!($($f)*));
         }
     }
 }

-- 
2.50.1


