Return-Path: <linux-kselftest+bounces-38884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7951B24E53
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCF3188F7C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8AD29CB24;
	Wed, 13 Aug 2025 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0SgZTUw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31629B8D8;
	Wed, 13 Aug 2025 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099745; cv=none; b=k592P4Ko/nbtELDmZk+bvJ2ZwQTMk9BAf6qBEZzMNPKRRhAFT8RHNCc7AV/RsnTgnXQX8JP7+N9+5SiSOhbcBm+EEZi17SmdOmG9njPcaR7+nIRZJfeRchUOir1r79f3OC8TKggBrVSZFm0mUNhxWozhW1OXjs+WlZ3OIuFiBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099745; c=relaxed/simple;
	bh=9phkFdt74ZQl1LqYivkVMOh37dFF5NjHa3G+R3/LyqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rig2iJN3YXwrjP1Az8wsznE2EnfgtQsPkmQT2dfkH0uI2A2w30ckWNK0vv9S0I2q/wN/DXM22jV8X4YQNCiecAdkIP1hJ2a0vZ7OLBWEIQN23ACrv5/2UirTb3psnVH+Z2OSN4KMTy+dNOgVeicmJVSWJVq8ZAqba9Ru86C5pqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0SgZTUw; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b109921fe7so314621cf.0;
        Wed, 13 Aug 2025 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099743; x=1755704543; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfJJX9lKKQ448nBfVi1BWsqmEl2RnVMCrehqFg8UH0o=;
        b=c0SgZTUwnuMRIA3otF0hACHbjQYefuEw7GR3tYiOvF2PZ6PZO67lQoyufHvWxRqYhm
         bZvYhIiyr/QmjY7+0S55rgajBz+8W8cje8gCckvn8w4ABTwOHZPU4guGciIeBo1SFpm2
         Q6ozwXwN4i9FzpvL0qshm6i6IgK9tk6IsdT38oBfrMlsL54+rkbwrnUY5rj9W8WZ3k10
         cMkOn6WwvX9xkFysl/Yi8j2eIAX+VigA2ryS3Mx2l3RSNhff5UMLv2IoR4bxVr9Sf09B
         PN10kJs/JA0cYLnMGob5/sCrYDU20FEujnDiyn+V/Ccm1BK6F6DhckHwrQRg2xHhV77b
         QLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099743; x=1755704543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfJJX9lKKQ448nBfVi1BWsqmEl2RnVMCrehqFg8UH0o=;
        b=oKjKuBUiQI5OMog5dY/B82lVJJ3LOGmAgz3kgpVIfQZgg2eNWfvK4f7PZoizrHXO2M
         Id9/vRXDfc5KY7HeSnTrfo1mM9Py/RDAjSws7W+RU8tW93h1EqQUPRxTA92PaJH8mS0v
         gAUNq0Vh9msV179v8njasX93nrtfzMBocSpjTY3KQLn7ZDCrSGAdBHndZZNfLiTIN0Hj
         nx8HUg9hoIpXYPpYmz/3i1j5N1HhJKRHPMr11XCVl2of6KHOA04FzHfkUOj6obLiDrw/
         7z1wtM60EsGk2Og7iPyFpJLRkOMSm4Ue/K7m03iUKhnVIAkjFULHtKdfanLV+DOjob4v
         DWqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF3g+2y4SuL6ngtnCws40ZD4aWniZR5lp2PTU3ryQ700lwTbP8g8EH4P8UO74XwYPSy85vV49JVUo=@vger.kernel.org, AJvYcCV14xojsHA+atEIRwmJ0WiTQeviNl7pzyQV12izLzdwghZW64CbQuC40xY+4HZpxxC5ErEH/uhxVK/w+A==@vger.kernel.org, AJvYcCVtnkmrRUQbJZpw6Ql9zTjD1VAtMVGJw6Vumhg/yd9ugBC8urHoGXA7Ceq9mpHELRqx6Z6In52G@vger.kernel.org, AJvYcCWavY7x46PdLam9yR7JW4jXpMtTdQg96f8qWoEnTUDmDNirKVae7o0gGMiAt9VlV6BBHZb/uPCib9/P04mZ@vger.kernel.org, AJvYcCWvW1xrxzXEAinkRu/jaNOkeg7vuGj0MHOEvyX1WDPuFZzbJptRMIkw33syTZYejl6FTTTgJ3Dt2frr@vger.kernel.org, AJvYcCXHh0Qor+TNvY0fd6gXKCw/P5rz3fNlguUemdM0HQuarC+4eyt8tayXqXO+HyCgQsqEOSXQepEmMcklIujmjRk=@vger.kernel.org, AJvYcCXLcip24v6w93YcUnjFldOkdUo/JZOpoGtVmsc38z7ixHGq9pkJO8T+3BgZtIgRoFX6HZf425FnBFx4BWMOVksu@vger.kernel.org
X-Gm-Message-State: AOJu0YzNRk0KguMG/yWOhsdFczhDs9n+0gPGEZwesZsG1msNBsDXHx7k
	rwgKX3a6vhDyarcnSmSXodj4y+Mg0niK56/Q2E0p4p1cf7OX3FQGSsGh
X-Gm-Gg: ASbGncs+bo0lEBHLNrNvluXmkdNwed23+54jpvV44h/45Pduv8XFiByahkjI1oG/n7T
	NeJGJrwlTKX42AuO4PS1YCXV956dFY5qnVkSXGiy6n1QLL/ovHvQdFyUlFSYH08JhRuErPRI/oU
	B8C/E74EL+QpHZX8j+Eubw2Y8tIuT6tbRWc1QFt+C6dtOnjTNenm/Py6A1lHaLAs/9CK2H86OSa
	Eut3u0ZTwh7nkPYEbmE3n96BzULKRlLk/ubfnYE9Xg8PQ7TWXTg3yqU6PQ0o8QbxVj8RF+Qusr8
	isYe1ZxUugf8waVBG0MLF9AyRO9u1X9cAWAintyObQEZxmR98+2LcNxtd6tOjLgGqO4YPPMx3DF
	aavfCV3UpIxivyhtp2VRSoAd0J5mwMWYWh2zfeCUCzBqZJgKMbiegS96RLxsBRHKMTFKJdYCHqy
	JXEs609+1kaGutIamo6b3ZrkuZQwDUv6/mdpZfQ+vofWJB
X-Google-Smtp-Source: AGHT+IEG6vbN3JiLx4Zvm7sGkrgY8IFW6f87G5dzjokUu9eNvm8nTBHVeTML6uomQC5WLma2KX7E3w==
X-Received: by 2002:a05:622a:5986:b0:4b0:89c2:68fe with SMTP id d75a77b69052e-4b0fc8b7decmr53142121cf.52.1755099742826;
        Wed, 13 Aug 2025 08:42:22 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81bc7a1e3sm1180019685a.74.2025.08.13.08.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:42:22 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:42:01 -0400
Subject: [PATCH v3 10/11] rust: of: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-10-545c14bc44ff@gmail.com>
References: <20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com>
In-Reply-To: <20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com>
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
 Saravana Kannan <saravanak@google.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099716; l=1153;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=9phkFdt74ZQl1LqYivkVMOh37dFF5NjHa3G+R3/LyqE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QA5ZBj0FVzxsKMM0ak/CLXiUFCmTAQdpP6pEgVTnyx1hxCPZxv/OzY8aSzcw782B+XDNpOc5uCi
 RWM+agi20aAc=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/of.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index b76b35265df2..58b20c367f99 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -34,7 +34,7 @@ fn index(&self) -> usize {
 impl DeviceId {
     /// Create a new device id from an OF 'compatible' string.
     pub const fn new(compatible: &'static CStr) -> Self {
-        let src = compatible.as_bytes_with_nul();
+        let src = compatible.to_bytes_with_nul();
         // Replace with `bindings::of_device_id::default()` once stabilized for `const`.
         // SAFETY: FFI type is valid to be zero-initialized.
         let mut of: bindings::of_device_id = unsafe { core::mem::zeroed() };

-- 
2.50.1


