Return-Path: <linux-kselftest+bounces-36989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 223C6B006DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FB61CA2CBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8D427815E;
	Thu, 10 Jul 2025 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9wkif4P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA2277C81;
	Thu, 10 Jul 2025 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161502; cv=none; b=b5S7VhgskP+zQ6tIHzou1bLEil+PCH6yr3jxScru31HNOPv2T7jMaPERLHWbyYXTgIUn60bLyiPGVMuB2icJLRocquUTfZ8vUKi2jHVWXMj2eu5lJA1F45B56YrXSmhpJZbnlD80atIey9Y+l4/SuTHUet7g3D/vc6a/xzGj6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161502; c=relaxed/simple;
	bh=az5NNitfUcds9iE19O7xLtIu231XHyJdqG76dw04NVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qiXSMH0dxNUAY3eoyWUrVxw73GFLO5vsHRdE7Hg+L4pTFMyGV9THAZebQUTYX3kcD2Y7G9ktlXLUzMYggT1j7XM/ktWfVsNZsLtsyfrP3csfv+9Gsd/nYFjkNe7nOuKOyDOi/3eyRuRwHApJJSCgf8S4oI0wVnZKXHzrqxJt/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9wkif4P; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d20f79a00dso160336285a.0;
        Thu, 10 Jul 2025 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161500; x=1752766300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIoKeX/8IwobjRqJguvSB5N8fT59ta6ahFnyjlyNQrY=;
        b=e9wkif4P+UmPy2gsDDsAK+K7CqCbb9s39A9pGq9JLT/a6njMH7pIxODXkWMqB4055t
         oZ45L5/B3M4Ug+3VBIkmdFmu4igJmwMKs89dEdBoeSeEvK1rzXWqPmVomkhM4v7QgrQp
         06475BPvAqhS51sCC/TtGc3Q0xPv2kMEz29V6APnJpW7YOtHHEYiHQdrw/aLtJeXb4rU
         5yi3T+OsjbfQTB1jBdq6PyqmVeGlM7hbrhnbWsmMrk4124cuLq1310afo9pdp08X8v3t
         tUyrCPSF61N/twmiYdMUo485nYEzKgRvNZ9x7yyr/tzzFX3UndjSVolHra/1RNNXhiF2
         ejzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161500; x=1752766300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIoKeX/8IwobjRqJguvSB5N8fT59ta6ahFnyjlyNQrY=;
        b=v9X3Wq65Fo73Emk0L/L9S+AUHkye6XeWcCXTF1QYRADM/TCxBoRZJGXri/396CGnk5
         LquZlBo0qt/LH5Zt4ebR489UGAjJtR5DH7I1+wlGfD/Qft/jM+Pl/LsEeQm6vF29Yojd
         CFHfPtu5SEHF5VGvzmwaKyUTgp42ld7xKyCXA6sXxo60r73U8x1sRBsvhaRenzodrgAs
         yEgOYyDyLglg88Glhp6LJ2BwGrjiW4oFcUsCdTqk1cCmF2ig0LIpNz8Esf0V3ADIOnRc
         FbCgCiXwHkU6SjsvZ2kfaadkhGFBSUSgHDVhQ0sySSXnk1vEGhx8yr7RpGHmEORlTRPo
         IygQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIpDCxMT175FqZmk6w76FokR0XzGukNPMrslXyXkFS0CMh0spnobxTeNGnZ+WTNYsApZk9nG0hV7ow@vger.kernel.org, AJvYcCUS/GFgoRdpQ+i/LBdjPexoJwa2RlbDrsWCuWY+wIIrVDLAinshFAMIbKDj5/wUfXe+3ZitxblUPQxUwVzf@vger.kernel.org, AJvYcCUW6XjcdGd5K8P5mkd77red1B0z92VDpirhXIcyuKv5mmmamoATifuZPvcaHtuUv5kfU61aWA1D@vger.kernel.org, AJvYcCVdFd9Q383iH7slJC7lqmD6SyENUGFfYYH55pzpyp/lfX0i6iW0YneFbGqcZ/Y43tNLjwS2m5+TEdq5cDHFB/Jb@vger.kernel.org, AJvYcCW1r+PV1vfSzmaKsAKeqi7eG5RHXJELYhqeWbvvFGXyrmfH/zrBxRDKgLy2NL6iMoE8f/cDnfDAM23OlNB9O9w=@vger.kernel.org, AJvYcCWv4ZTKduE883I9Ifx55j1v4P/y9glat7oBOMRS99ePTJnA7cCJVcFcpqh0rCBEQ27vQ7azcdgfyzM9@vger.kernel.org, AJvYcCXpKRLWlpBCfgWMLB24KRD1Hc6NzaXfkq3mDccNgf5dkBavMkWjDOEvQWx2bdSmvbkIAXBQO2DRT6Vozw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH4a1quv7uaZE+8TJFSiY8KyQ1WtTKjitPsM5YuaBdApuENhCf
	nTOB5w3biPdUlSipEMBcgxjDwR2ywQSoigOv6Zy5ouWMQqTfAz4K3QAO
X-Gm-Gg: ASbGncvntpA9k8hDHNvIgbRJFwfkI12bHVCbytzmUTiWqQEJOccN+n72rJLlmTC7ScQ
	stXQYsNf/tDFIlbQSI9JuUo+hjJceF0k4xGy2LshPAUwVO4FwXU6pct4eUy2Ft1Qh+MtHurvsFW
	fdnYBzYRqAudz3ANAiyRk854HKHs5g9KdUIZ3mapbnAWFVgUwui4c9z91OWj4ejCaxMCzbfsjer
	KkDuduUg189MjWoPBXVUHUoqeVfOxZCALbibR3JXe9DhuSWrPPDYldDhfSo05hsPSgxhiGC+iiz
	NBZnz3b/+69YqW8TYrsWBbyJceH7yCFGMJCfDajrvG1Gp7SfyKc5UW6a3DO/IIiQepTi/n4bIxV
	8pK6ll7nUTKvO72wfpzSuzDOzKgepT3wfS0VLIBX2MB5E1THoI4fMhVIG9w==
X-Google-Smtp-Source: AGHT+IF8oHr5nLMMLgFUIh+26Oo3vEZrp2qQehIs/0HytXc2xoqaUlO0ptkhMM21EW8ipxSnApet4w==
X-Received: by 2002:a05:6214:240e:b0:6fd:ace:4cfb with SMTP id 6a1803df08f44-704981132ffmr46767636d6.27.1752161499734;
        Thu, 10 Jul 2025 08:31:39 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:31:39 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:06 -0400
Subject: [PATCH 03/17] rust: auxiliary: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-3-027420ea799e@gmail.com>
References: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
In-Reply-To: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
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
 Jens Axboe <axboe@kernel.dk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161489; l=1183;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=az5NNitfUcds9iE19O7xLtIu231XHyJdqG76dw04NVo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QI42baxaWQWxeOM7ZaAjjbblr9vFQZMLvDIIk3qF0FUq544A2sQ7lOWi1QLUpn5SnbV431+3dBC
 JpBmPn2X7GwM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 samples/rust/rust_driver_auxiliary.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index f2a820683fc3..7c916eb11b64 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -5,13 +5,13 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    auxiliary, bindings, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
+    auxiliary, bindings, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
 };
 
 use pin_init::PinInit;
 
 const MODULE_NAME: &CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
-const AUXILIARY_NAME: &CStr = c_str!("auxiliary");
+const AUXILIARY_NAME: &CStr = c"auxiliary";
 
 struct AuxiliaryDriver;
 

-- 
2.50.0


