Return-Path: <linux-kselftest+bounces-36999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8410DB0072A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F95F5C27A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983E02E92A3;
	Thu, 10 Jul 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjQiHOJY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6812E88AF;
	Thu, 10 Jul 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161523; cv=none; b=cnabhYeRFto1IQCzLArja/X0OMv3DPT+tjHvZiWJBmD+DUsNFNmtgyCh/Y6BXrenxqZQa97f5QULXGaTL9n1uK2ek8yAFdZFpGxgQU1Gz+33d+tngw6CeC3NqW4sJ2BfSrFO6FTojbTWDKrBTYKI5RBCkh4Vl1MS+v9bYmpxs3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161523; c=relaxed/simple;
	bh=K3quMGfwWSednLdCqfDckFdHtFzQdXTMeNPKPGlz5iU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fPftUahgOem4vm1cJR3kJgl9GBs0KOPvmJzU6H94miRrN276YSi7vDKDgn1eFbBghVJcDWmW2PUTcDm44zHLBJb/PC5Hj0XvHxn84Ip+AFreOU5/Yj9sAFqda/DANU/s3/fMUO3xeEsIZqb4j6MvM01s7qbNUgd5YO1cg4c71jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjQiHOJY; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso13348036d6.1;
        Thu, 10 Jul 2025 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161521; x=1752766321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IeIe+UDk+Kp3nZEK6u7JnfOt0xInihmGzvZ4vkm0xmQ=;
        b=mjQiHOJYL8/GB0iXaWuI76r1icOn0OY1ZHE5RP0Ba+l9hBJCq0BIntDKOXIfmj2pVt
         frvYeBnXUnuNhcfFCLaVSd3R3mrEQM/0C+riC5IyUFe7+PoK3fgrixbn+Wx7vJ6HaGSH
         L6mRCILF2n8X5kUdpBSffvGLtUE6SlhpJG/Ordli53yBA0fOcNSx4+db3pvoXDAzv3t+
         1DuJVfJCHP0nNwbagtJtk5gOk4fMuNd22s6KcrH2YtnouXVsZszgtlEWwu87u7uAuXpr
         xJZYlF8zI8+xKrmFW74H+sx/X2KDa3MxFN5iBa+4yq9QFWLfgSn1luYKI3Au697sv3sj
         nunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161521; x=1752766321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeIe+UDk+Kp3nZEK6u7JnfOt0xInihmGzvZ4vkm0xmQ=;
        b=jBhWSrfeN1KhP9ncud1dCcsGmCtLuvIcANwJiWmeEKmI8HHFWWMN3HGbKUvvZYrA+A
         3Q0IG6U4Q/0OzsbPYaXuoncHRo3BG+CA1VezfEXYem+UyF4r5TxiJlrDSOSfQ7w+1SOC
         Nmg9gnPxQkfayrMOqK+7nm4xWdoWxvjizKdm6Vdn52BubQu3ORarB27Y13JwG6EtxMSK
         7Raezp2AaJcSliEHdr6z31SzQHvWOq7fqXeo23FqdXry8Owlcawu10O75lSRrSPUgrJ9
         oIOtrMPSoz6MogVCfgGX0JFVitIqxCNJORggqEKlVGl+L817NEMhf5HN0V8AHKx0L/UI
         eXpw==
X-Forwarded-Encrypted: i=1; AJvYcCUDZ7f4gV0CoYli2o7xlYAKoO4R0Y/eIUe7ONvpSo2MCm0tLP/ToTo9oqSbT6AC84v0TUeKspFzMk5H7ACkqYs=@vger.kernel.org, AJvYcCUi5giC2OQ/ZseBaxcPNgMWpZjand5+y0gzO40UiVEKrKECDjR+HijvPv4Cv/b8Joc3EzgmDAuK7b1Z@vger.kernel.org, AJvYcCV0xPdDwygWFvbc+IzAsEyWQh/wIZYVxhbypLTO+WbWqjQwiVuXYXhCI27//DKURsS+LTwqoTzIVNE2@vger.kernel.org, AJvYcCV4C1Xf0/qD1skyQGMCqQdgKYChkPsG1KV5SF/DnrV8ffIJMaZzmR7SlRMh9OdDmcFxzi78YCVn9qYODQ==@vger.kernel.org, AJvYcCV5Nr37dVg20JmxoajB0ln7xf0DVQt0nlh/3p94qHM79jiEkUdUqkuPSqKWTK1pbM7+XN7yVDORKVQ8EknG@vger.kernel.org, AJvYcCWFSyj3QlVKGg6bI5QTyIeL31otZB2i1cI3yQ26QmHpz8FM+G8WSXPEbwlM3uP6bNKbCO3Y8chuX3iLGL9yq7UJ@vger.kernel.org, AJvYcCXSQTatcelGE36PUQ1oahzrIxjlk+TjXz1nlIrn5aj4USw096L20O9VPPob7Q+Y5HUOB7sjdG02@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9M1+TEzn8zN4ajRllw408Tb+9RpepZscjREsA2NsTRYyp49wT
	kLZpD5Z2lRuovzoXaOlwcg11knxqVanoWZFF5hsuPVH6SFcuzHE27YwV
X-Gm-Gg: ASbGncs6cOcu0kch8gtEg0yNt/Mw1DhxJoM+1r9e1E4e/BC/nRpLC2eF7nQGJws1+Qd
	7tWhPzfcJ9CoJOrKjWkikZuwUCl+Za2aCHH2AuKX3xX2eJQiF3vXEb57OTOSZjFoI4fjXRnZECC
	2mKbFvvhSWr4/SMuMujS/8P7UlyCJRxMwBwA/Ea4yDKwAXkfUSX5XqvtMK2D2qn0h80o8hpeZ8J
	O0KLKZoZsIbVbrr3c/e6xiGiPRFi7OFfyqNPYk8jg4lrrKOs0qMyFswuQB0p+FI5Zhpf6o49A0y
	XlwM3oWtJwqmz1xF1lftmEmWcHNjKDToV0jvif8X1qZqaVDICaNYKiOVEtn68hd8T5juas5v6Qn
	2rzCrgYUUXmAzo+3iQ5BEX+E8sVrZWFFvVZfsEMUuUewf3J++hXaxvPo5BmWt2Ulyfdg2
X-Google-Smtp-Source: AGHT+IE2LTVg+t8dxVKDODJkNp+d8w0QU6pVu3P5qcDuA/4/6USIg8YBIVkV3R5pz7GFSaok/yUc5w==
X-Received: by 2002:a05:6214:d69:b0:704:8870:122 with SMTP id 6a1803df08f44-70495a7ce2fmr58033506d6.11.1752161520428;
        Thu, 10 Jul 2025 08:32:00 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:32:00 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:16 -0400
Subject: [PATCH 13/17] rust: pci: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-13-027420ea799e@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161490; l=1308;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=K3quMGfwWSednLdCqfDckFdHtFzQdXTMeNPKPGlz5iU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBVoj/q+8630VrfoOdU7edikEfH4QTuHyG7talu6SHNqLcu39+eYJff2AqEgN0swyq7Yct3tiub
 arhdIzcGBNAI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 samples/rust/rust_driver_pci.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 15147e4401b2..4ba5fcd2b357 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
+use kernel::{bindings, device::Core, devres::Devres, pci, prelude::*, types::ARef};
 
 struct Regs;
 
@@ -73,7 +73,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
         pdev.enable_device_mem()?;
         pdev.set_master();
 
-        let bar = pdev.iomap_region_sized::<{ Regs::END }>(0, c_str!("rust_driver_pci"))?;
+        let bar = pdev.iomap_region_sized::<{ Regs::END }>(0, c"rust_driver_pci")?;
 
         let drvdata = KBox::new(
             Self {

-- 
2.50.0


