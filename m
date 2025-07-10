Return-Path: <linux-kselftest+bounces-36997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B998B00728
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3981CA32E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700E02DC34A;
	Thu, 10 Jul 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfyc0aIy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF0127F171;
	Thu, 10 Jul 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161519; cv=none; b=Ho9n3l3RupEDGdG4qdphmGqRpVopfuhugDMbV4I91v/0zhtRhxiRZCNUxZu3kRJ4BAmzcr2A5rH9KDeU4NhDiyHrHXCqwuvqAFFuAcBlcLTOAhPRWpslaABjfOE7W6TxLydR9R6a6O2s2/AEM84dIpHRmpfZA4UIYCiHT9tAuXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161519; c=relaxed/simple;
	bh=JeDAf6wFDPBGfHdjZdgJ1MROy+GiZeSAvyl6oVbgRRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YX3xwh+75AASM558ExgSU8aTTcyaRdDcfnlttWsGY/9GpDZIPWWQXM4I2EH3JREbJPLp1wrErID3sXxoR1OQEV3/rkmJuXbxmhLogQAiMBKbrDmiJHV5dBzb9Q5NiNx4aJjvpqJfihDemlqb3vWfWYq30wKaJmH+eyqdjQ43HQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfyc0aIy; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6face367320so10038246d6.3;
        Thu, 10 Jul 2025 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161516; x=1752766316; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vyfnq6g9C4EoCLlWfGQ54YuT/nc9bWKydj2wfDI2B58=;
        b=bfyc0aIyweHbubLgo0RgXJXmKeNs/rN9aorV1Wx2fGbG7bwaIHwL/gkEAHt27xikFR
         2jUyRR0mXUSfF8prede5NxEH9CtT63Due9rm3yJDovoGLn/Qa8T611msoAQl4yLEO6lA
         ou/+2ggeh4LjG/1aAmn6SHjW8GSL83LxTlulsvND8euj6jYl9rkVKHTBaHTdUSP0kr52
         XJytvBbijs4esbDRW/KZ8sDYC8e9odBulWQXg9L7nqxA2qS9GH/mOo/MGkrF4QYrT573
         qx9PsWJSuFGsXKxqAKnvfhpIiT5QC3rUeHk492goIGLs6cPQP6naEFo61sGfXfHtl8sa
         nXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161516; x=1752766316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vyfnq6g9C4EoCLlWfGQ54YuT/nc9bWKydj2wfDI2B58=;
        b=vdaBUnHPPgRg3Jm+00XzynD9fhNTZTPpLgYKBSplV9wZj+faeBFHlC1tdWwAISfzad
         aY8MD35ZBvOR5f6TB8jXsbkwpHOF4DuOPShD/D6LCm49P74F593EOYWlw0l4bjT14hge
         P1XG+/+uIKYpPysRBkQruanvKm6YDLQLQFF9G1zL1ctkkdtUplxwsXJJ78hLeWxPYJLn
         6Hqb9RVpet/cscZwW/K8fLq+E8p9el5XdbPWJywdjdza1SMEo4MQbwwsPpzFLyMLzIjT
         9fOubPBJJzcf0jiE+tko5ZjOrEEYzgmkeXVxZGKX/jPA5an0lzM3IFKDEWE4gCK4faPb
         fCFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU10KH6rxNYLU7J45vtuPATIBDcax1nmpCQVEChahgXnrQMUBLQj11r9A1EpGxaCCfpUe8NUIsqWEHMizwXbBrQ@vger.kernel.org, AJvYcCUEoMvmrDMEzz+pGVrNuChtUoNHvMd3hjxHOwi3tGgB4TlIuc8chIeePUQ/SfJucPd6jP63962oLVVIUhe4Sa8=@vger.kernel.org, AJvYcCUi6rREct9E53Ln+919GzvMynGJsv1wEa/N1OQunxG7tgvULn/hd6UEBuX8YLJ/SxdoKVg7+wBL@vger.kernel.org, AJvYcCV6m7AzCYk1ZGrnEWnjqcQ39fKldAzI8Q9MdEuEBkga0tVuV3asroOTYN/BGLMR7dh4U7KYpxxXiictHA7T@vger.kernel.org, AJvYcCWaLBfE9UbGBStlBgtd2LyjkSPsJeY1BKKIa0UOq96pypDGVJKSBfcozV4o5DDuJ8uxc+abThbanGyxeQ==@vger.kernel.org, AJvYcCWdRj1+ehgG9AMMgOQwFCQrP/pZuCT7FKeXkaYqVdMsdO4LPJD4Es4IwU5DicFdTImuaar+SHJMu3qI@vger.kernel.org, AJvYcCX1qVOsMF0wLmglGdZBXQVrDW/Qkx9boq/0tKsTaRqdClsVuynH/nVYUPhIIBvorsSmQ/SZj6RLI+r2@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ1alsyhjA5cEUBmb3Au3qZcZKemL7RcJXbPjYS5pOz7xqgxQJ
	OJwOa2GWp+oAlIhoFlT4jCO4hX+hXtxKCseF5nR7Fom2jbXMXhnpamHS
X-Gm-Gg: ASbGncuvrcSlKvNFLD6K4tIseSd2lmFBi94Pi9nnPjsPYblODcH5P+pEW5Tb3d5mK2H
	s/uGowgF64LLYP5K8lG0fWVaYHiusBqqFIgXZGgcx9Q2fOGigyfUZd1tgI2PaNZdrWtZx9GuD/D
	dcRml2ldwuiZ1sWHABhIPDHmlv86i3j5jGK2GyJHqKhysOejnJZ2/Abt6e13BVIZpXoJOGxFq8U
	UGolubaegdCd+y15hPgza23JBGF+B//nYaI9LCZfXobpVd3i5MecWU3EmP/GerhbtP/6LlPBBV1
	rwBJcNw03l9fop3vADRP234G0oebdfneWGy3fNKaYXUwuBGEglH0/zVD8rUYnEU1v/HcOCznuax
	1N97r6FdvRL1pHQr5bDICZL6Q9kfxRW0Jz0m2KVVvLX4IvO16w9aN1NDjBQ==
X-Google-Smtp-Source: AGHT+IHvkNwRUWyARITk8WnQKy0SNCgtRWKVuNelSxExNeuSX0iEEl4oIe58qDpAXxbYdul2lXKeWQ==
X-Received: by 2002:a05:6214:1d08:b0:702:d63b:4c9f with SMTP id 6a1803df08f44-70494fe211emr78209276d6.23.1752161516474;
        Thu, 10 Jul 2025 08:31:56 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:31:56 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:14 -0400
Subject: [PATCH 11/17] rust: miscdevice: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-11-027420ea799e@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161490; l=1089;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=JeDAf6wFDPBGfHdjZdgJ1MROy+GiZeSAvyl6oVbgRRY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNEY9zChdkMx4tt2VV68lYK+vC3TmeO7PS6pRdkJjdhnR0BMNjB8WcH4aXX01vTLirzgenjn3HS
 nz9VxZLystAI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 samples/rust/rust_misc_device.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index c881fd6dbd08..12b64296e912 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -98,7 +98,6 @@
 use core::pin::Pin;
 
 use kernel::{
-    c_str,
     device::Device,
     fs::File,
     ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
@@ -133,7 +132,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
         pr_info!("Initialising Rust Misc Device Sample\n");
 
         let options = MiscDeviceOptions {
-            name: c_str!("rust-misc-device"),
+            name: c"rust-misc-device",
         };
 
         try_pin_init!(Self {

-- 
2.50.0


