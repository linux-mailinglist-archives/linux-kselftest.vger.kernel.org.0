Return-Path: <linux-kselftest+bounces-36998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD47B00730
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB12B1CA3AA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7706E2E7F37;
	Thu, 10 Jul 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNPgj6Di"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54122E6D24;
	Thu, 10 Jul 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161521; cv=none; b=FywpVEfEka8s1hsYjdrYlYbfv1wLRox4n/THYptMYb97K0+Ux+aI+ZOxhVgOMwvj59vjWfEfwf04MSKvNAsvHm34xKP8NiqitlyIuLv8OiIs/hXdpZnL5vMySHapQbGFPZ8qtv5DbSs8n40sXNWGdMaeaBfqLvwD4k2IxpFKfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161521; c=relaxed/simple;
	bh=7TrWBDFWFk9XPUm28ZWCh8FAmf3iX04XjynnFQqD4OU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FT3JVo3FLJMX7gTdwKFW8XwhmJarWxDQx71u+QVrUSEjracWUkWgiXQhdWSq8Oe8kl8CCq/KZWYeRVmGrhmSoqimwTHhXeu5dThV1vzjUCymsXdPrRCxoAPU68KJx0plsXVxx6JfMm4r+cCarQZvYeRHo+TqalFdaqWIdZltAMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNPgj6Di; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7da3894b82dso111188885a.0;
        Thu, 10 Jul 2025 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161518; x=1752766318; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VogKYzaF/TPYy0XdUUSO/DnQeAdUNW05tROf4gMJ6DE=;
        b=GNPgj6Dil71gKSH4DJg8rMAmQUbW/7KDOBx95bx9DTsq6SiHc8cWKB8I4uJH3bBSgG
         o0g7u4wNSKBlRkgVvnWmOTv+jJeyxobU73WBUEk8wdcR5C7+Awqj3Sl1g0K4QFCfHX9+
         7fD6WamPJIdb91xSPmVXPj5GsUNDUPV3XajtDV85KD8DFLMktNj/H18mO3XclP0/I8WP
         vSXOSAihcRBSHoX9xZGUbvRBjD6BLwsbu3OkeRrp7wTi7x+UU6rt2Hjgv17uFKdi/nMS
         ZFSJxVNTIBFvSnQekUirTHo3HmuWXbcrZ+Jp93wQHbNMZrz6S2GvGibeUhQP9+7H7CIM
         lrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161518; x=1752766318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VogKYzaF/TPYy0XdUUSO/DnQeAdUNW05tROf4gMJ6DE=;
        b=DrfPl/Y2NylOwMILJhsM+N93160YRI7DX6neZ/J8HdYwd4g3goSAXUb6yZM35yKS2/
         6A7C5Xl9w5+cKDMM26zUO7jD3QVYvLjFnnM/2ts97k8+kdevHiNz5oQHiXUx2h93Ihl7
         BGMENA+s0cz2ucTBBXJcjBGq/Z7c0pniqwy12Wsx6JllbHvDRJ6wZaUP1nlPUiv/jwC+
         pZi808+mS/POa6PNGI/SXGgGXSf7Wlv3+j7PLgiKgTUvASDzsDQlfLw6O9onVX7Vyx0D
         j5L18Jtc5S/g790JD5Jsu7MR/IxNOS/nruKSXzDVUiouagtVn5mOJiBGv2OcJ7LGQpva
         T6tg==
X-Forwarded-Encrypted: i=1; AJvYcCUI5f1rzS7Y6Y0n9VcjJb1AQRFgqTIjUS02qYGPDqLljqMRBzrVRazX0ebQTT1dOzHtfdbQGEz2@vger.kernel.org, AJvYcCVv2ocHDI5//zwtHCoJhXA7DgN5FfhRUgsR23Y75ZUMsop3nWIW77sIZotHQX74lsWp6yzTyB18LLL5WmJxHp4u@vger.kernel.org, AJvYcCWOrYDk5rcfEUdt54ZFTwXm+YIGZL+HoRV4pDOci1jaHkolrtdj7ZAwRLby8Qa0mXo8w3qIkREXbhNnxnbG@vger.kernel.org, AJvYcCWYgqkE9T0N0kbJcjfLlLrTYYbars3N05vvzo3+AASw5yKtcP9/Frn0UrXkapnQ/fp1x+zZALg+thsA2hqXg0s=@vger.kernel.org, AJvYcCX7AGXl9MTlxmAg8P2jBNM5lzlkbx2QZXDW4p+s25TFjxzagIS8yG1QG9qFrQj0UY6HbeUdXkMpv4kF@vger.kernel.org, AJvYcCXH8rBrT7gMirbqbD9CRFMvKOBp6CjwGAekQ3bJhmbilP43SOkYmoD4hEebLjZ/3RuWmHueLdDQuA3x@vger.kernel.org, AJvYcCXdzR35y5cJ01VYZ/444RCcxfc3Ehos/zheRMvMaNYVMCIFMIFlEG5dp88ySah+UwZlEB/GjXkBXFItxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz39zHQ3XFvtDG5mzqEofy+RBe6FEzevRzsb+Zwo66GO+np0JYI
	yxtXuexTtyD6NyWOyJqP/E0j7GV058Gqb4sN4URmFIi3XYaDxL/uyOx4
X-Gm-Gg: ASbGncuM7GLLwR0lPfBlUSStGQnaAomCScvwPfrRVbrnpMEMzhj7ynJ88MYEBKQgZ0i
	QoqNTf1rXXes7128FOZTJVHIUWb4TZqrp48JLP2Hla+5ti0o2ggc1fF5LUKhngdtMSfi1hkPEII
	vLBrD+tS996dZ+khvSPzaz6yqDvlsBj29nvw31u52G3KHUIkhNngULLVWhRfwzxLYdF9BcHFejl
	1zTeTh49NlTXCCJfrucwiHE9UcJbqzaF08j3aYFUribXfgbjP99gUvNgq7/bi3P6aboftt6iSsL
	DoxX6J3OEK5b3gWOcPyfYpI7tsCfkCMK6y0LjKK8SxFK8g14IX7Q3SaYAkAASma7LcPVw/GpKEQ
	5o3EpKDLQbBZWf4bxFjiJV8r99AByiSJKRKXXfrvoYpQiYjty3TiGkJ8vZQ==
X-Google-Smtp-Source: AGHT+IG2Rkfi8OgB6SO217W8qmSZiHD1v3NtIITwS70q5UwQAur6eRtXERJ8W6PVRjTxYB6Q3LpV6g==
X-Received: by 2002:a05:620a:458c:b0:7d5:c8bc:fa72 with SMTP id af79cd13be357-7dccbf44f7amr446032685a.28.1752161518435;
        Thu, 10 Jul 2025 08:31:58 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:31:58 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:15 -0400
Subject: [PATCH 12/17] rust: net: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-12-027420ea799e@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161490; l=1665;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=7TrWBDFWFk9XPUm28ZWCh8FAmf3iX04XjynnFQqD4OU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFXzGSK5HRWWRQmhbpkjsw0M+w2zZ3jjGVMgci5eUPPMKCslqQirC8ELfLlHiYCioE2kdDwvYv7
 NilN9Earm3gU=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/net/phy.rs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index c420e5ecab4b..236ea516a134 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -781,7 +781,6 @@ const fn as_int(&self) -> u32 {
 ///
 /// ```
 /// # mod module_phy_driver_sample {
-/// use kernel::c_str;
 /// use kernel::net::phy::{self, DeviceId};
 /// use kernel::prelude::*;
 ///
@@ -800,7 +799,7 @@ const fn as_int(&self) -> u32 {
 ///
 /// #[vtable]
 /// impl phy::Driver for PhySample {
-///     const NAME: &'static CStr = c_str!("PhySample");
+///     const NAME: &'static CStr = c"PhySample";
 ///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x00000001);
 /// }
 /// # }
@@ -809,7 +808,6 @@ const fn as_int(&self) -> u32 {
 /// This expands to the following code:
 ///
 /// ```ignore
-/// use kernel::c_str;
 /// use kernel::net::phy::{self, DeviceId};
 /// use kernel::prelude::*;
 ///
@@ -829,7 +827,7 @@ const fn as_int(&self) -> u32 {
 ///
 /// #[vtable]
 /// impl phy::Driver for PhySample {
-///     const NAME: &'static CStr = c_str!("PhySample");
+///     const NAME: &'static CStr = c"PhySample";
 ///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x00000001);
 /// }
 ///

-- 
2.50.0


