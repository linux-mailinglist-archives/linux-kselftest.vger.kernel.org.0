Return-Path: <linux-kselftest+bounces-37671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D359B0B29B
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496F31653C0
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9325928F523;
	Sat, 19 Jul 2025 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2VHB6j+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0B428ECDA;
	Sat, 19 Jul 2025 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964980; cv=none; b=ecVPhIWGxNif9Hhm8mj0gGLh1LJKSOvvDKJGSTjU0L36CDyLZEkxtLfwCA+qAfCYcCJKBPOduzcISLkgi4rIz3oup3h7uHto9TMDChNFvyq+hYLEga28gio5I2+eP5+0Cp+scUVD732jQowgiHswKgH7Z81ZiYU+8Bu1f3srIyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964980; c=relaxed/simple;
	bh=Oj1C9nMjeODD9cRbuQg2XI8fpmvAcfb5NXUs1d2aWWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHrmdyJgA3vtAqW1nrRhqI3zIX/bOSJ9R91inbXfIo3B2YpUP5HMPDTbs/6/3bDVRvZidI7X3eKiiVFnO1lCTInHv87wsAurJJs5XKs2NDnZNlPaO+SLATPRdulnVvPEVqrdX2pgrwQmgpG/N9Wcsl7mqI4YS82pBogebsnl1CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2VHB6j+; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4aba19f4398so43407121cf.1;
        Sat, 19 Jul 2025 15:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964978; x=1753569778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2SdMgOej1Czkt8u413KFayNOC5FO0PpNGdLBjJItos=;
        b=h2VHB6j++ACk88S0XEX9TLBTMs656D9p3imFppk4zXgQXfzkqClaPuND/3+LT+4cYD
         K3UycizYSlY8yZ0+MR9xB6dQV8zy5m8mgRiDJG3uWMQoOfGxKKUJV51fG2YHUI71eHgw
         AfYxc4EuA11aIzxoFrHjesFHCzeIRGaF555PoA4Qn0wVfxSQ8vBgGIpBXeuB548ZnBaG
         073nxFgw/WnRgM2xbg0FCvoEx1oU4QeuoJGDXORzsZAK44xgwO8EI4RCWlmp+Vv/huWf
         HJR5FEh574xFFYi/YSgWJXFgzYuCFQGgofq69AR8GTt2fnn7u59Re+PUHEWw50ITcLG2
         GG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964978; x=1753569778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2SdMgOej1Czkt8u413KFayNOC5FO0PpNGdLBjJItos=;
        b=FGhzdioQbggDYlnA69o56AXJVo7QPKahjWKgmDo18JCS9DGnuDGD2TYtK0usQq7A4r
         qxvApJRKR1mwHb44aY6U0xVnmVzp19R8kP3RzJCDZm2yU7IK+5wUiUfufJCIKflt9UQM
         nklmFeUsmIGL0mPiymbzNLVl2T/5FsbjYOnxYhPJOEtDLUvdcmbweQXobJCp6XvN4v2g
         H1XxdWGVH3FqM+2/G91KjIy3JQNfqnTxpJzMyHDnpBAbsJ4VjPK9LjJMWoUm6crTptn5
         t7kS9yfsI2aWfOt8CrJssqLgfF5ZDtfUzIB5YPBHipM1TfpqBPM0YeUsObURoRC64V+h
         khJw==
X-Forwarded-Encrypted: i=1; AJvYcCUBFpjQR4MgRHb8yWm/M442GEKUFNnh7cDJvKaq03PqrcxMUvFi98b2A5Qaqfo2TT3KG0IIDbpowpbws/jP@vger.kernel.org, AJvYcCUoqcTUxe7hWkQOa0eQL0yFSbd1kYPKqWdr9efG+E1mffdv80w9RZG7B+Nuhp61fGKfZQUcUQuOYIli@vger.kernel.org, AJvYcCVDkYvXPseF4w3867jWCf9dTTi7QkF4NekAY+5m9cZdGILJQAXUNFqmOez6Gk402IjPHumBIt1rnyWAXl/FHRdf@vger.kernel.org, AJvYcCWfLooLiuZraR9lRPlfZ+uxeGReWGtMxOQMtrWil2FgyhauDZ96d7/N4x8RlkoxfcS2Cs928zBt@vger.kernel.org, AJvYcCWsQ/dxLoL3t4B26zn4VsUAHdGhlstk7UWFuloSZkau83eFnddyfzbpD+sdOigGPDO3OyHYNp30E2q7Id98Nhg=@vger.kernel.org, AJvYcCWzQK0W+HIgH4jQq2A8J6hefwmSdgfUdU9mOYPD+O3TFMcxL3Jt+3lOcqNMVlwDj/HKkoZHcDa16Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy4/3KmvlPSikJRAyzbPGOBWW3+/vv+CxSVZGQgR7xQh6Yegnh
	FjXVqahV93sci1SOkzPftETyC/smNuTcuUxGyy4B8Qwp1DUZ1uDMQIFE
X-Gm-Gg: ASbGnctKd1t7/wVkbZ/eRIuDl7oD0LtEB48bRDlr3lpqA6J27tBFuMKBoWy5BjkUK0c
	FAXV/Ebaz9DsXLsP5FiAQF4yYknliHeuMfl+xFi7F0EiD2OZEWDsqCm8J1dUidmgIq4huM7Cys9
	hA0sjjX+pcDIH35Z6bPTw+QHCBx9i5HfjXgEDKp1RowEkCPJT/U43mgj8NwfHe7/0N49nGuNypb
	y9l60b3qBlxdcqfFuDQcHu4MDcMLgDW14AiIMASLKFWgCN58DbNUzbiO0jk0gQgriPQgUkCohWC
	osXGqx0vvKpKvP/FDD2kspYbTYzISaA/VvLrd3wPm18Vvgcq/8NGUkGrDMQTRNxx9eudRVPganS
	dKdMICZWwO3SAs8G+9SlZb814+vNO7nwT1j5zIinazZpX6zuB4YEZCcLbDumrXZA7PkU2aFmDFw
	ESlnadPQVP0R/QFITE30YkO/PgEX/g
X-Google-Smtp-Source: AGHT+IHVcbnnmN0FOjpZi+BLTtYiYWCS3TF6LX2f51OS673CeBLR1t23WnXUWlU23mMaHNOfJa58kw==
X-Received: by 2002:ac8:5e06:0:b0:4a9:8685:1e92 with SMTP id d75a77b69052e-4ab90b1b83bmr227767031cf.34.1752964977824;
        Sat, 19 Jul 2025 15:42:57 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b1f1d5sm23671841cf.50.2025.07.19.15.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:55 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:42:38 -0400
Subject: [PATCH v2 09/10] rust: net: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-9-e1cb53f6d233@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964956; l=1207;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=Oj1C9nMjeODD9cRbuQg2XI8fpmvAcfb5NXUs1d2aWWo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH30BadgddFNDkOPI5I/HO/2elq0QfezIKMKNHHTOVd93jU6oNb5Eh6m2bWTa9LbKeZfUVE+s2g
 0nPY2BpfuFgk=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/net/phy.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 65ac4d59ad77..c420e5ecab4b 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -505,7 +505,7 @@ unsafe impl Sync for DriverVTable {}
 pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
     // INVARIANT: All the fields of `struct phy_driver` are initialized properly.
     DriverVTable(Opaque::new(bindings::phy_driver {
-        name: T::NAME.as_char_ptr().cast_mut(),
+        name: crate::str::as_char_ptr_in_const_context(T::NAME).cast_mut(),
         flags: T::FLAGS,
         phy_id: T::PHY_DEVICE_ID.id,
         phy_id_mask: T::PHY_DEVICE_ID.mask_as_int(),

-- 
2.50.1


