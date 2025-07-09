Return-Path: <linux-kselftest+bounces-36858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FF6AFF237
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 21:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628D83B1215
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 19:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E576248F52;
	Wed,  9 Jul 2025 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5XnyaCl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E324501D;
	Wed,  9 Jul 2025 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091142; cv=none; b=MGbbxQdm2e9j6+ezv3ccwrCIFriySU7kDat0z9nl1lWYC5brKEY2RzTMgeD7TnzpvtyV90dthCpJ0pDUC2jyGjA5MMd9Pn00PHdj8lZMbLmP63Jjshi4vtq2681WfLMw7b8XWdeI3WmsapqEA9kyUPgvSEZMYoPFJTIe1sjRhBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091142; c=relaxed/simple;
	bh=tOJwnPFFO6erKPblInuDRYgXedY1qto4AlF3RLJHBts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dqiWk22u8cqTBldh7g7bK5DFVGtSs/5Zhy3rJQw8ix4DIjUBaDvXObgLrIyNejUBC1c2UlR1/bpeaOYWcUKx3TuZv7XtEFvRc02NdGpuZ7StM6jJ8VaE+lvwjbkwzPq/h2ecZVsSLLUHYI9zCnlUMVI8z8LzNjny3Lb5dkGXerU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5XnyaCl; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a9bff7fc6dso3025921cf.1;
        Wed, 09 Jul 2025 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091139; x=1752695939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYWhnIjXXiRA1OfTfL+ZgaMGfZmkqUQpway5uw4n4Ck=;
        b=H5XnyaClLfTlEJqFn5sMom2f2NN6IGRimxkaGZMXu/fXeHQBHxu9dUDE+r83n/JLuq
         EIFtfxPKNX+Y8iSUhAl41vT7RBgElL+0RKBWCjZi3oYr7Rjk28eeFQaN0yTk7XQzAPLV
         MuNiTmkM/hrRaAfPUpjZLIYd8UWijuv/cz1cRATo5mfyRZ4DZ82xRo6ntkrnD1iSTQGS
         OLVA9o4cuHURGhpZfAwfrS6dPj3jtOFWPNjJbijUHxOyNVyhCapXIYrJWr5hYTJHp6/t
         K9cpqDS7vOwNyyiZ12VqtoiQzaZ2JCv4H7/fiT1KuQlJC/xcpwkfnnqWi/krVqMnnMtt
         UMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091139; x=1752695939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYWhnIjXXiRA1OfTfL+ZgaMGfZmkqUQpway5uw4n4Ck=;
        b=SmB9lN1AIu+xvsKK80b916RpjV0VZHBW3pSrnHTq3ZPHkQwvzqy9G7AasBuYGW6ryE
         WsLCloy0IWzkh0aXcEsFXrzt1N/GQ/CSGe90S6D1qrZMNkckbIw21VcWuf0BuZY3l+vs
         pVLvmKV0t05sKGp2qQi6D9o9UObnH36On5OO0KGJ+DblOeKk9BRovTz0FI2sElQANhoR
         SNy5vO7VtqIEI259ag5J2DYJb1sUKC1tO4dDJhXiCZjdgDV+rEq52cyRCi+b1CDrpsEZ
         ocRhqlpx8wdnNCQAYNg7Urn2LUz/iOysxt6FWIa3yYFfpWU0JCXH59HFqP9DHKAsLBFb
         663A==
X-Forwarded-Encrypted: i=1; AJvYcCVOY6s+I/B9gHY6MZhjnizT2R8kFIhVcCRNFaxVlqdLS8OJmZQFKRKyw183nDXE7Qt47FTsmvbudACY@vger.kernel.org, AJvYcCWY3/dqxHW6LrOF8pKkZO05j6MnCUMpG9yp+XIak0MZ9UHWmL/H4WLg6vmePLVhT4WqIt0UXW1J@vger.kernel.org, AJvYcCWvdtnDiRSD+99u9Szv/qU4MszYzxnxH4QwY0E3Nmyr5ki1im+W3k+sNo31bBnPl5pY/Ci+tZHIaEYopA0shHA=@vger.kernel.org, AJvYcCXF37iLk0fjw4Uo5/2GKjMWsLI0cPYFBY6zPoPoC23ay+DGEIUE4u65WdyVrlVpYzsAqF+tk/lqmUPGmc16@vger.kernel.org, AJvYcCXudaaLecekG8ThZYgfoNTc3N+DryFMp3GDdfLYe9im2aEpp2X1HC7TOrK2IjVzIdIo2zp139b59Pc=@vger.kernel.org, AJvYcCXw+zhL6+VZv+uwN40Q6W7lgr6cCe8ivEDoDcW825xjMg3suhn/uW8OHnxE4WQewUsIOqhBqae9K18iNy+8JVRW@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLkRIhPoSyeOqivd/eoA7qQlGSPU7GnTqXyG6E5eCfLCRzOHC
	SJtRT98bXZJj1t++zXppUHRfbpjTSxBcY4Jo1JSxmIb2JWPj+6ZSzFk87yT4hQJv9U0jpw==
X-Gm-Gg: ASbGncuyGKU1rkBE0JovYYTt7uDQYsOS0axSAPwQx0vA/2aEZnMARknTtOgOcRAdCpb
	ATnlu1fnqalDTW7plA5REjgakS6o11h0jMmIY0LrQjsUVcm2LKdW6DsfmTC5nhPEZ2l50m8CiYp
	enWD3fgB9NfDI0xyyoxkC9CglIXU7telqJiDNhOuXeauVNOCC/a6BaZ4S9/KTKJXPXjpTjCUWgw
	pmwPlqF1rCMp/9q0b6W9i4WR74dQ9J0Cj86xoM8DJuZ/fJkj4Bwi/kKQFLdfneOiimLtSyckdbF
	DFjtXCiVluIUdMHLrl3uGf1azruWeTA0pnP3Dx1STqg99jreFysc64MKyAqHhx/8YjbYdaG09nM
	5x62EVq9epAv0ny/cqya3y6o4sSxXZQz+Nrqxy7vDJ00Aamv+PT2AMaHF6A==
X-Google-Smtp-Source: AGHT+IH9lva4APxzj5/ISh67+5M8e7gYLgD+7KgrDdxQ1UoO5ZdMtH03BYij8pw1HtWem0c/kARQUw==
X-Received: by 2002:a05:622a:4d8e:b0:4a9:8299:4e00 with SMTP id d75a77b69052e-4a9e9a50750mr15178691cf.0.1752091139453;
        Wed, 09 Jul 2025 12:58:59 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949faf39sm103584281cf.28.2025.07.09.12.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:58:58 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:58:52 -0400
Subject: [PATCH 02/10] rust: auxiliary: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-2-fd793b3e58a2@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091133; l=1142;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=tOJwnPFFO6erKPblInuDRYgXedY1qto4AlF3RLJHBts=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPSZBmZ+VIM4SaoWH0G8iDJiHhk9cO5mpQDWNSzUl8KOlk/QHa9tbo4//41gHJWg+mLiZ7pLXTD
 00s8S1g2wLwY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/auxiliary.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index d2cfe1eeefb6..89d961407adb 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -111,8 +111,8 @@ macro_rules! module_auxiliary_driver {
 impl DeviceId {
     /// Create a new [`DeviceId`] from name.
     pub const fn new(modname: &'static CStr, name: &'static CStr) -> Self {
-        let name = name.as_bytes_with_nul();
-        let modname = modname.as_bytes_with_nul();
+        let name = name.to_bytes_with_nul();
+        let modname = modname.to_bytes_with_nul();
 
         // TODO: Replace with `bindings::auxiliary_device_id::default()` once stabilized for
         // `const`.

-- 
2.50.0


