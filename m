Return-Path: <linux-kselftest+bounces-37665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 779BEB0B27F
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054B7AA1AE7
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F7928C2D5;
	Sat, 19 Jul 2025 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQSK61Mf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5874228C01A;
	Sat, 19 Jul 2025 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964966; cv=none; b=AoVOx0NtOL53n17iZt9PfKrFQzOfllM6LDEdLq2BYcYhSoQ74InIVN2MYeoCXVz5EargJ0msouJDbU9Uvly8jRNIXpHfZZaqoMrx/lByGapkcjXZXWot7mis+31snUCZi47frnZPRG07gQlUreYC7OyMkEbZ/pcqevFpeejKCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964966; c=relaxed/simple;
	bh=UU7lGn7kGhm+SuFb1MnLqyAXhBVLI0I6DYrJ7+r+OSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fTM3giUtQK+POh8BUkrHcUC4+MvW9LWvWUL++OQNd+AI+CTk/aGVXGWYGFilBT4Vyz/WBfWep1KyexHX6pAS+XgY+H+0RnB8QFS5/em3hZWX0gtSxAkhnIRTJlNX5bi5rbeiDqdfME9FKKMHiHVzeZPzH2+DqkQA/DUxdqlBX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQSK61Mf; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab6416496dso40515551cf.1;
        Sat, 19 Jul 2025 15:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964963; x=1753569763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1SWgEVSx8t26BC4XVR8BuzhCGARx2Hrfiqdp97fGW0=;
        b=XQSK61Mf2n+jnpCJwDRjPiPZ9mMtZCTuaw9KumGNS4bSXsDegD1B7anNa0cjE0580i
         hbLFFHvp+vzpyJfo2EqxOB9iUCblD31gwFC/Xwuby5+F9cy0mX954ah7RU+/bXYYqUUj
         FGUr5sUdhklwrcq93C6vS+aiwSj9OOMXCvI1XtnifoLUSOMmn5vZJ7BBSVKd+Ab1i1KN
         0VVfWtmf91Ro7gC+XbhTlw5f0zU3E2f0JB2IU1WafQEA75aS+S5Qcs17LK1L7cx2v7nS
         1JYlmwUP/TtlnL63ucZMo3XH/zru14+tvgxU9g7xcLfzFKpfJMm96fEgBmGZ9rEWjltP
         /rnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964963; x=1753569763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1SWgEVSx8t26BC4XVR8BuzhCGARx2Hrfiqdp97fGW0=;
        b=rLYJ/7fZrYKX1ioMRRkedoaaMtLx6i6l6B7lgdLffI8xgHaxQXn9/0osc4kosJb+E/
         Qdud5C14J146F9aiWjL8UxCOfL7oe9onoxemJ26oGRa0U2Gnv2Gj50LmDApgjih2DCpB
         v4fz7Nf44g84ZMaTgVMVm0klqQCJK7Rly04nQZHmIwCMSMwjgnPklw0bMuPlKCP37HDT
         B92kIz6ORZV6wwHUj2Ol6dX4rJN11NAh1GMfuOCtRFV/vTOrBtIyQs4pcsmjMTIpwa9j
         E65f6jqv/2ygNKnIXQoCtWgB+Z41oL2qGAsjaxdQfSGB2lnpnXsphKul4Tq8sUX5YziI
         40cw==
X-Forwarded-Encrypted: i=1; AJvYcCUBQ5RaJ4/di81DBSbK1ronQmadAWJQhwlY6nr+mYJ+kaVbBeqdfdpPicy2O4RiHvbgdI+hJoI3jqxpai6s@vger.kernel.org, AJvYcCUa7h60a1bzWfR3f5poyUcIfyLYyTgIbMeWthrSvAttumrQXUwLnXN/ZjI2rd0HGKM8SVxPx0LTk2hIm6c/Ysuq@vger.kernel.org, AJvYcCUaxMAEkZWiiq75mrNcmhs0nq2J6vNaXafBYU6HbumqCod2CaNtprMGHi/T+GgHmKk5VFl/0bcZ2Diw@vger.kernel.org, AJvYcCWGqlrGLQ0bo13FevFNWZM326uBuBtaKfWKIYlDU87LQXqJyR9j/8jaq7v96C6bvZKdFxfnMuljjlI=@vger.kernel.org, AJvYcCWifT3gzr/JDtgOfS72wB0pTLYPkpToycSz6MtXaRF8jV8c7FCuh2ro2OfhTbOFPbinXgM29/cE@vger.kernel.org, AJvYcCXIv9bkQ77dxe6ggOzdcwRwVFxqvltVQrVYJNO3A949T5vKVHidw/rceUhKJt3H4O8rrxylZO38a2gik1XOrMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/7ajIdS+BIjqBfM7+M5esDQe2KFuKlCbdm5rHTAMBJMqawIn
	xF8MuTsJ60j9q0Doosw9oQDl1Mu9YHtzP6a6gzKJ/0YysBm1qYRUa7Gb
X-Gm-Gg: ASbGnctjQhushjt3akl23eTOUvMgr3Hgy7rPUwvCAps20+GmxPN3GEin/MTtrlsv236
	PxpF1H+jQMZzLOqsa+IMMuAxYJiJSxI6pMtufuV6Jn3sFOVo9myL1ZamWw3SyXqUntuqtFyCDFS
	CboYtEa42i94bW05jVQUjKiFGxViUmjBfRI63NQNiVg3WAfTmqjq+0YBS456w99bsZV0mrPqZqG
	n81ggsxgAKLIDvZ0vJ7HnK1GhIOHZgi/dV4yeszdwLYAs8Gyg+YaKL85MJDQonKCDPrB5IrHIMd
	6n29axQXF5HTDjOG9ipOLwHTY/HMyaSe5M2rX7yqv9VJQvNizGBPLHTXoFyZpiqzzzcCo+jcRMG
	VWhE5oaseUfEQh7DuUnnwZroVKxkaxO8gqkvt9yVERiaHdcVUS6HeZA1KRWDrx6vnOJRWDnMFoY
	BXQVwFSm5XLD5BoJJT+IxEurpCrZkw
X-Google-Smtp-Source: AGHT+IGRlT7IbYJgy7k1zYKpPXDBr5ooJQrVQvFfzRdeHWam1H4YjOS2fabtOnVtCOJV/ysDqUjrDQ==
X-Received: by 2002:ac8:5dc6:0:b0:4ab:579d:2343 with SMTP id d75a77b69052e-4ab90cb6c2cmr251175531cf.46.1752964963333;
        Sat, 19 Jul 2025 15:42:43 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b1f1d5sm23671841cf.50.2025.07.19.15.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:42 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:42:32 -0400
Subject: [PATCH v2 03/10] rust: configfs: use `core::ffi::CStr` method
 names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-3-e1cb53f6d233@gmail.com>
References: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
In-Reply-To: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964955; l=2423;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=UU7lGn7kGhm+SuFb1MnLqyAXhBVLI0I6DYrJ7+r+OSQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNeaAkv8xgwX4NEWMvKht3s0HML9oOBF7rc4CRx7dxJy9p52pTiBMrgmqOCFBudOkZhQkUhg678
 43mmwZSWFQgY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Also avoid `Deref<Target=BStr> for CStr` as that impl doesn't exist on
`core::ffi::CStr`.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/configfs.rs       | 4 ++--
 samples/rust/rust_configfs.rs | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 2736b798cdc6..9fb5ef825e41 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -263,7 +263,7 @@ pub fn new(
         try_pin_init!(Self {
             group <- pin_init::init_zeroed().chain(|v: &mut Opaque<bindings::config_group>| {
                 let place = v.get();
-                let name = name.as_bytes_with_nul().as_ptr();
+                let name = name.to_bytes_with_nul().as_ptr();
                 // SAFETY: It is safe to initialize a group once it has been zeroed.
                 unsafe {
                     bindings::config_group_init_type_name(place, name.cast(), item_type.as_ptr())
@@ -613,7 +613,7 @@ impl<const ID: u64, O, Data> Attribute<ID, O, Data>
     pub const fn new(name: &'static CStr) -> Self {
         Self {
             attribute: Opaque::new(bindings::configfs_attribute {
-                ca_name: name.as_char_ptr(),
+                ca_name: crate::str::as_char_ptr_in_const_context(name),
                 ca_owner: core::ptr::null_mut(),
                 ca_mode: 0o660,
                 show: Some(Self::show),
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
index af04bfa35cb2..5005453f874d 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -94,7 +94,7 @@ impl configfs::AttributeOperations<0> for Configuration {
 
     fn show(container: &Configuration, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
         pr_info!("Show message\n");
-        let data = container.message;
+        let data = container.message.to_bytes();
         page[0..data.len()].copy_from_slice(data);
         Ok(data.len())
     }

-- 
2.50.1


