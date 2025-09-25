Return-Path: <linux-kselftest+bounces-42334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AC6B9FBFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 15:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E709638425A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 13:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62F2C17B2;
	Thu, 25 Sep 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxkifYJo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B1A2C08BF
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808509; cv=none; b=Yg9Ekb8g3RYkI/3asABteP5krn9BdOcfGFPkGvUcXyR6Qy2k0gkayS5EbV5IC48PPISE38YmDvMiDnnq4fRY8J3ecMsHeV0N4NQn6GXpkMyfwH3bSZBJFecsSRKSsJNr5suUEf15fe51biZZeJ5yvlmf6OdUYXuw4W4KrPb+s5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808509; c=relaxed/simple;
	bh=bPZeninN2/V/7zw/PYEF64yfGflgZsOfq0JcAWxkVI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FaOKWV9xK8MxprerRGZmmbkREPYVX1UKzBHQlp3loE2iXVQTg7FDqyrzayWSi9AhJqiUbs/d9fvlOx13z6lJuvYlicxicNf8CVf7ywX4MSb4NoOe+gvwd2RDb4f3uJIrVIcS3c+wDMRYF7uYpHcGXeQ27VDDenrhCnkDvTq+iGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxkifYJo; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-84ab207c37cso75488285a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 06:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808506; x=1759413306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqTcvT5yONUFeYmOIO5vRSTnodd8gLQVUhuVrtBW+JA=;
        b=jxkifYJo+Hqlth5IMZ0ckwB+jZMkZSY7/ck3+l/fKdQym9jDfHP4sSFZKL3pvqeRVy
         awcwEqkjMfFXU73o/Z4iiE24UnZLQWUIkspE+yT8bPfOvHAT4moOiRhPbvEC/AB4nv3+
         EkhWXjtyngWTJ8QdHxqg4fDZzCFPidm3Aum92Jd9Vl9dByKlV6FevWiCifjohsT6U81i
         c8v/gkBBw7YKw8IWCXxoYydPQNCQQd3kNwhRUGjjctRRCCAnL8UOkk+xpAn7yGE2Z6XN
         /yBnCbL7jM488cln8R6ffaHIvIU+50M2t+2diyUEf2h4HgfnryJKe2cSWwitVa5HYY8M
         AF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808506; x=1759413306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqTcvT5yONUFeYmOIO5vRSTnodd8gLQVUhuVrtBW+JA=;
        b=xVbkXotjGMxNpsZsoXHYkKzyAmD4fDCi6iVYV74sSrOk6FZgvRIUFvj69J9LogYtSa
         tNBsSBJ3kqTriU2hEUnBMvVV9Vx+KU9TpbpWBUnyEz8GzUJ1vN45KNDp9RmZrPMma1MI
         VTXkyY0mRRIZ+2O8hV5vj1yZLqEzBCc7eL2riTf2CrrEPk/MUbtRwadtt2Oh9OEBxOth
         TuOTNtbMlp5dddy8hJEKRYC5R27ZoA8AwJhgUqkPewYBge5zJiahkrb2aj2DYZmJiJgH
         pOUuiT/zwbYU3K01CXBca0FIOuzJ+hpYNY4VWNufuwdl+iHvV7iyhkp2Bbhd+rM7D1Rq
         Bseg==
X-Forwarded-Encrypted: i=1; AJvYcCWp8ATXbwrexe7nMVhv5pAEw0ayURkjmMU/jGWGTd3XnpNtNl+UyWDhv1Yf5qrK7fc9vdXiYSttHr7V+f303Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlgVv6VZjrgS5T6ikvPF8Bym9pt7l200ka0Q65DAJqCocsqwPg
	WWL8iWkc5WI/SMfcBoLGr32tUW5LM7RK30f28XyIR7Vr4yI8lTma3u2T
X-Gm-Gg: ASbGnctwHIhCs6GJ23LrEOM2zpp5wz4rmihKrXaseUt7IHBYbqBz08/HG7jLYIDpfw0
	qJftMZd7sJ9p/IC2SmijPs9JkfT1fX++u82eLOtW04MfKLQZIl7sDhT5DLd7GgfAPlY+UWHT4HW
	uCBbbqC56F/8V1YcZjt1Q42YdtaT13mJqWzafTYpyhMxIwnCVZxRxrc6RnguaAB8k8YVohba0W+
	ekhH72gWR7lOGxVhqqEeYnGM3NUHKd5CVsnkE1rvPjO3Pqvi0YTLHjwdkHx39ntYRDzgaGQ8Bu6
	qAQvf++jAcNuGGOt/HxHGyyAAjkn0aNXlQIO9fLuzSh0I6juBwxpj50X3UZyaH68icd6h3G0jII
	3j95VoJOaVYMnuiyhBm3enp+YWOEImH3lkPn2CQy2e8h9ad2bxyJT/g8nTOUrxUDuj+XttwTzIO
	ls9/4+u6p+Ud/0Ghp2aJnSXGpC4vNXFk9ZhpguWgmiAM5epXvPj5/IhXOMN/MC+Kbgowig
X-Google-Smtp-Source: AGHT+IG6EzTyEA3INGOgld+kkM2E6bSTO6bhB+H8gEAN47wRnZax/H9RzJp1nvFdm1VelrmNbN2bBg==
X-Received: by 2002:a05:6214:765:b0:809:5095:4144 with SMTP id 6a1803df08f44-80950954186mr19841926d6.67.1758808505713;
        Thu, 25 Sep 2025 06:55:05 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:05 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:56 -0400
Subject: [PATCH v2 08/19] rust: firmware: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-8-78e0aaace1cd@gmail.com>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
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
 Jens Axboe <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808437; l=1629;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=bPZeninN2/V/7zw/PYEF64yfGflgZsOfq0JcAWxkVI0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QD4rak/xDK1Yk5v1duIKSYGyXctY6/oZ8jehaiqaTOxIbpGhy5zl8Kext0tE9Jsy8CWrpsliDV5
 3U5gCpsnnhAA=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/firmware.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 376e7e77453f..71168d8004e2 100644
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
2.51.0


