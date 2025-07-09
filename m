Return-Path: <linux-kselftest+bounces-36866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A09BAFF26D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F171C825FA
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DFE2E5B05;
	Wed,  9 Jul 2025 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS1daJ6w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826632BEFF0;
	Wed,  9 Jul 2025 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091157; cv=none; b=F5iOHet1wLf+Y/HDrvtQnXHx0/OOoWbAXh2l5FAnUoAY24YjCml/QFVeXSv01S0sOiO5pkqL6GJ9hyGF04qHJoHsO6BhxbBME3gT4Au4/l6DIYOjpydoDodminrqXNmfSJh+wAYSIrCIyIULzYVjSVde5PQS0j4AVPHxolr0U4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091157; c=relaxed/simple;
	bh=+cXDYAYZ3gqoNEyU9rZ/9kReWz6XNmPa5fCe17wNmXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dgCflbRoGor1H8myYAztTdM8ALYZdIM3kVLRSyTvtICHTwvf2WHGzPSaows6WjijFMVyMmt+o8yHesoFrsG0yRyZF6dgcAFwclnup6lv4TULEel58fAbwo+KnatAi66EuafCCsbniwvZUND7Q4xSQhkeE+wJcM/JXIcCUc/UItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS1daJ6w; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a58d95ea53so4596281cf.0;
        Wed, 09 Jul 2025 12:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091154; x=1752695954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8KQ4HSVORZvJyB3i3NF8gMFRoSic5laZrJaHuBt0is=;
        b=OS1daJ6wF8Xa3vtgCTud3Zrz9GNR9o7v6rx/hCWVJoy9Furzuga6Bba7vXk+tSD0Md
         odMWTf/lxRrqvevpBMrAnCFKCEx/D96WLrQKVqAmicXe7vH4rH6AYng03uSKeMsYy8nI
         TwMoeNHhwGuKJT1R3VngFjkQYxGyi9vEyOpPAN5sNoEBK7Sbl5TmX3PXvCO8JbAiJEFJ
         wBP2bLnuaUCgmlww3uKs2d+02qKHq47iGelkJ/Bm6Pi2meruRhvWzhNG+56P4zsd6v0J
         rL+yOPmA45GZTY7ZEbKYEM/b9d/epYwo+tzJcj2bKEmZzLRhOOJ2Ufa2M9AheWfdwR8f
         qX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091154; x=1752695954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8KQ4HSVORZvJyB3i3NF8gMFRoSic5laZrJaHuBt0is=;
        b=Ni4htQqGgA1svD/VUZ3CJ49mQUlT/ma9xts34k6hPjsib7ZlMvalrChw34z81Mh5Mt
         R63ISg5mJxS3AA5y/SdumQnJsz6WZ/2ntk0RcNNAL+/6Emeq75ZVdsIibTZGIu4/hH3k
         xWg/v9ySsMly0QRHqwVTqRHMorGkD5o6k4u8RmM3MWjq7gUOmZHS8oBSfSOp5MFmmxF4
         QTzKx9lsinXS+5HbwksaFgZ1p3CssmAC35SVhlozIw+zqdFCkXwE6/QC75UY+2WW99EF
         /XNtgvLh5KTkupQ78ngLX2BuqP+wtaTXjU6IirlRsIFrUmQ/XMjbbJEHrm8MOMhfF7Vn
         ucFg==
X-Forwarded-Encrypted: i=1; AJvYcCU98S+1iN2HhTMIGKaw9pkoL2FwSwco7tBR5CwOIfaHxs+6CgUjksob1mFTB+VPfQtiqnZE4K0YgRw=@vger.kernel.org, AJvYcCV8Jd4fy+zK94wkxD/lohCZOUgHwRsuItfx11YDnWReGrsG8koc/TBD8rIXLkyDVY2F+OB8R6XN3TXf@vger.kernel.org, AJvYcCWjsRz336ndhANL1qFaMQ878bDwcXEDMxCg0EQLEmlw0QCq+Jx7qOo7RE5DqzSCL2Joq+RpVIUb3ePwEEvVqxv3@vger.kernel.org, AJvYcCXAkEyfBMTOcK6h38ugAuswqQP7C2xG4TwTKpRT09NP+maWpTQIsqLWlA7KmRa5e5t47IDl9nlt@vger.kernel.org, AJvYcCXFpWdtGfX6adToPbxxFpXUDDqc7Pkv6eyVKeGwx/ERfm8UlRQhdIexuNuFzC1MLT7LaOtgdyfwoImLhEZU@vger.kernel.org, AJvYcCXhHSFJ9JKql86S8Gjrr0BDH2MO28EQsHcfWM5HwmF2DhYjcfFXOiY+g8ONtLKbp1bT/qlgilcdFhqpd2JBKNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqaiXHOR4Xn2PS0vSnA96gUc9lgPAIAIYaaCJK2U0gfWAAdrqp
	IK9rT780WIHOUKtxXhVk1m4OCk06LKvon1IqR5ZFQ1AbSh5JyPFipxl3
X-Gm-Gg: ASbGncsMXOsnn7/aqvGiJWPo7NfPkLIZ3U0mszLNghQDLUy4GOmw8ye5nX9QJLFELpY
	35Hi3SpU5+JBBSMitaqjtE+fVbVK4C9VJ14+muXGDahDZwnNWIh/nfHwHqiShJRRJpmgsNYiOCw
	ywAKzg88+OUGiAK37WSDvja1YlG7tm8rMIfAcOfyeTqHJMohFDE22aVnde5c1tzajkZcxmsKXjB
	PiqhYcKvBGeu76n6l3DvC8WxPLVrSlJrCXEJ1F9gJZXZKZgLrQZKra13BUGwnFWeJQ3np3Ssqvb
	nP/x0g8G+GkqlZlcpQGrvfggzB6gFw2/vBUV/6wuRHB4iz6cJklHextdrKaAJTJjk32RBqz102N
	X1/HSF2Fat7UzjgJeRcIe5B3xYFOs7QV9u1sm/TuuDBkJvAZId/7kDFRvDJcaPxViDwQM
X-Google-Smtp-Source: AGHT+IFvDoCZVGhGpiYkZdTD5/12K1S8bIsSpFpgXIGe1kCUt1tDQK8ef/tJ4gQAS++aXLB8qn27Jg==
X-Received: by 2002:a05:622a:15d0:b0:4a9:a596:1bd6 with SMTP id d75a77b69052e-4a9e9c27e25mr10671631cf.9.1752091154172;
        Wed, 09 Jul 2025 12:59:14 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949faf39sm103584281cf.28.2025.07.09.12.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:59:13 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:59:00 -0400
Subject: [PATCH 10/10] rust: of: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-10-fd793b3e58a2@gmail.com>
References: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>
In-Reply-To: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091134; l=1106;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=+cXDYAYZ3gqoNEyU9rZ/9kReWz6XNmPa5fCe17wNmXs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEKD4zAoBzfzRUQWlR3BXr7MAa4XF//LBOWG1JnRpCMhRFh/BCmVtlUFm5UVBwPwBtNyQOWGm6n
 0rH6S6+DKfQo=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/of.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 40d1bd13682c..5cf50979c1e8 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -29,7 +29,7 @@ fn index(&self) -> usize {
 impl DeviceId {
     /// Create a new device id from an OF 'compatible' string.
     pub const fn new(compatible: &'static CStr) -> Self {
-        let src = compatible.as_bytes_with_nul();
+        let src = compatible.to_bytes_with_nul();
         // Replace with `bindings::of_device_id::default()` once stabilized for `const`.
         // SAFETY: FFI type is valid to be zero-initialized.
         let mut of: bindings::of_device_id = unsafe { core::mem::zeroed() };

-- 
2.50.0


