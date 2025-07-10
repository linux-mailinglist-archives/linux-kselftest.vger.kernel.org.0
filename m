Return-Path: <linux-kselftest+bounces-36994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FB4B0070D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2970C1C22A28
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6258827E061;
	Thu, 10 Jul 2025 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akgeDkkM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE527D76E;
	Thu, 10 Jul 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161513; cv=none; b=IrIGz5wyws5wkJXb0T20DuvOD48O2ueOa7ar360odrApg04LDbv2bhw5gtCn22sULjpIov2bWNVHfCPia7yRc4KJDzqy9MQv7x/aSGPh2IYhFnBiM359PL7E19pFhvcBJ14nCQauPyLl8CCLHkiHEV134T0wbdcjpnyctDNSIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161513; c=relaxed/simple;
	bh=XbZfSG96gLboq9hAwWHxQ0UcnmwXIVGU56caleXhB74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PTQNzkztvWLHj+tNCrOnXzR2PIyr6tSiwoyeK+ObO9mR02id6VFPpaKZocc9ht5h7LCuVmzZZrKpk2/715HqhenfLxmG081r/CSIOFZqIPPDRrM17LO7+rOmeOzYh4vimm0K+k/2zKMxuwBneMGW+SJsCA0G6JIFOIPmwnBx2+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akgeDkkM; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ecf99dd567so15167346d6.0;
        Thu, 10 Jul 2025 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161511; x=1752766311; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/JDalhR7HGrdZn2Na85qCxGVUjNuqdnchv4YNWMoGI=;
        b=akgeDkkMb2XoTbSkWonCcugcqiwBDAyRO0tO3DbS9nE+7mQouel98kvSMzCjWDgcUI
         YsN7NF1nWYdmR056QAO7MMuSOaOUTIth49zxM9RNgu3z/hpLSzWheRNV4izsNIiEUL6Q
         Z0D8AporftpAo8ziwpLZR3jCRVopbTLSyLlvrxGcfnWafy6F6QeLEfY3MpQkufOOc18/
         PE6mMoy81Gi9G4p1422KrVgG/kVWmOGlbePixTtOJUg4ceDWRNKEWhIFedxHlTIdeoW0
         HiJhlhxvE5ujWdnIcdhGCcgNXpJf2Emxp7Std4v2m9/PUdRM9p4audzaqeR16ctW/afS
         lOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161511; x=1752766311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/JDalhR7HGrdZn2Na85qCxGVUjNuqdnchv4YNWMoGI=;
        b=VD9tgem77QPyxpMrYk4qJvGsUC+Hl4vTcAcpkwF+2RmLbvajp+0tqkmInw7iNmGQ0N
         rD3/OkA9YxPoEubD7JM/hYjcYS4Rm0cfproNIaJBbD+4cm2eyKTMNY3BMk1zyJaJw65G
         VlAUO+YV9lYTqIPjW7P+mzcNyxRKyV1+esGDIPgLvVmaKYbXk4ervZtYArGln3OD/o7K
         P+f/h14vpdOkM07kVYXzI33tXhKWVKfaB8g75L76+sADhtM/Sofdi3l8UH/UkSaAIRvB
         CJ7LOW1fitiv8H0XSWN/0wZ5fSaPGVVVZ6wAWponKGpHdvd4nxNa8CHiWX93kQUn05OK
         A8kA==
X-Forwarded-Encrypted: i=1; AJvYcCUP2Jr7i68gp2eBNJghaOoqTIcnY2n2azAa7LtIHzFBWpzBHrG56gedcvaD+/VGmK2NIthPUt+EGrIoGzjPxVF/@vger.kernel.org, AJvYcCVDvHvuavOQxTCT8u31V45XsYB+JoGQ4mYxlo2inqH4q0ZRSnvhscHKfQ/xXl0DLGONcfQobjsZc+swOkzCpcw=@vger.kernel.org, AJvYcCW/SHbWJNATecpe7VYFANWNZnBNb7gDih6/n8CJFx/4jj66HemDRQKCFdjUPaHt147pGQamGVn+d0oeIg==@vger.kernel.org, AJvYcCWiaxO76irf9bEHAMF2/jYidZQI6YzJQIPe9iEzZwWqBoor6X5qmsF7oWOysWnSKy1Ky3si/Nd50sRM@vger.kernel.org, AJvYcCWmWiglswnr9+H1+T/ib8G6iiOP0B1kQ8qXRq+QFEB1wdHfKdMcsyqLubWcxbvsaxbP6FsScMO008fxoVQJ@vger.kernel.org, AJvYcCXM+Xm5CEyje3BjZuCmQzWbfHTnRIE4TYNogJbHWXvMOgufZ43qkvN2wY9/yE1zEfBo8q1w5Ss7@vger.kernel.org, AJvYcCXuN19A+Nsq10S4Dja2saqPXS3/xdxroCDISFqi+RIiLOsOkwSjTr6IA8uIRqzRQ43/5cLPZGzk6WBR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxid65CG7R5GWXoZy9CWPqc0L6mz4LxvfoRQ+vUYh+VCRLo3er5
	uTMSq1iCVHPwlq5BLI/wiFx9lNaZRg+JlifdzdIFeSRAph4bHq6BUrFf
X-Gm-Gg: ASbGnctXDOBiN3MdXeozBG1u1e+YG+QqbJi3/QA/Pr4fvtSCRWQw+xdNYjTHaLA4b8L
	l+VzYiq5q5mxHzjRnEG0mua5pnwJ58qVFURuIWXG0dawd0S5TF7wRkpuFI5OhHjubDl0V202ouD
	ouOuQKYrVJBu6JerDAn9ew4JFcsZQGtF8bcdE56k7CGQnrCgFCSMXfOeuyh2gglLR/HPWaAPAo3
	R/9znlw6k2sArQitca543grcXxn95PrhBfC/hveoW5Ae1j8galz3xoZYeHaAR8uVVbf1UeS9tE4
	JV/3xuzBkGhIRxdxPKKqOaeqP0Jahs3m05RWubyqU9hVvnMvs4xktRGySrSno7opQvF/Scyoxm8
	qRnA7MN4KEhTiN5VyAA9HakAe1eke9ZMlDxgLPpI7L4EwMf0t4JxrrAacGg==
X-Google-Smtp-Source: AGHT+IGlK4u+h32oGxozpab2tD/B7Yph0jCBKI+iYfgyIGiWbIZ+FxxQ7L/p4QWTrgRuBT/dl81aJQ==
X-Received: by 2002:a05:6214:21ae:b0:6fd:24:b0e0 with SMTP id 6a1803df08f44-7049802b590mr33096746d6.6.1752161510215;
        Thu, 10 Jul 2025 08:31:50 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:31:49 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:11 -0400
Subject: [PATCH 08/17] rust: firmware: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-8-027420ea799e@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161489; l=1536;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=XbZfSG96gLboq9hAwWHxQ0UcnmwXIVGU56caleXhB74=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHERu/vESXn7qmFFW348pi5DoDLh036HXrIdmw4RD3DKS+WftxpPEwxHBNYrRqltGIq+N1QTXos
 LZ9h+wNtoCwI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/firmware.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 4adcf39b475e..d07849333991 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -51,13 +51,13 @@ fn request_nowarn() -> Self {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{c_str, device::Device, firmware::Firmware};
+/// # use kernel::{device::Device, firmware::Firmware};
 ///
 /// # fn no_run() -> Result<(), Error> {
 /// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
 /// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
 ///
-/// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
+/// let fw = Firmware::request(c"path/to/firmware.bin", &dev)?;
 /// let blob = fw.data();
 ///
 /// # Ok(())
@@ -204,7 +204,7 @@ macro_rules! module_firmware {
     ($($builder:tt)*) => {
         const _: () = {
             const __MODULE_FIRMWARE_PREFIX: &'static $crate::str::CStr = if cfg!(MODULE) {
-                $crate::c_str!("")
+                c""
             } else {
                 <LocalModule as $crate::ModuleMetadata>::NAME
             };

-- 
2.50.0


