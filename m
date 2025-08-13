Return-Path: <linux-kselftest+bounces-38885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC329B24E58
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BD51C24F9C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C892BD038;
	Wed, 13 Aug 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGRnxJsr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8B29E104;
	Wed, 13 Aug 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099747; cv=none; b=ndZAXbmBKGviE0IKUzrJOLtPxI/HrYL+0Tej+tIzcGAtFXwPcCIel8Mh9qUgl9hJ/DfTZj6cYlmECySkgNVUicfK8HS9X5wv3SPyx8EuVb2paZX/VuKLZwlZitoxjThOOKp4t0ePjsz94mJp7uuKaF3ZtQEL9yEurCcAzwS9Bew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099747; c=relaxed/simple;
	bh=7eEQScKSS4lgeevbAHUT916RwyFbFyv80kGiczwdQFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HI0dkVCmU/RKNuN5CmW+kq1zTfcMKBSBA7HjInLdYM9bmygL1EL+P7v3D0q0JNDi16U06Ks2LPZZf4to9QdqJpfrOazN0pNU7LllUQh35plRNW82W1ZyOgndu6cUB2gNyO9n6ZzK/AV/ODsFiiDW9DDN1tJzGZ+B2EMLQUwj9o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGRnxJsr; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e835e02cd1so467830985a.2;
        Wed, 13 Aug 2025 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099745; x=1755704545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HV68KIDec58Lp5ofIAN+WaUYN4AgQmpZQcNEziHckfo=;
        b=fGRnxJsrAYOyePbY8T6zwWGhb02bhBvFantMO/cdkNH+BpyoWVdpJLMSeshjJwlzYE
         esnNx+hkomIRytkFaZ4PF2ovMnV5xsUc09oMte9YcFbvzOB2vYOhgYSfZVwFiGCCfEjd
         5JvUXdjVNADoH2kVHkUeEme5GkVu7U212dTu2LicBFsdn18bz0b0B7QMVi1GPwzRB6gr
         CgI4wpaEkoK1FuCkxHNJTh1aKaR5idEU4TEc0g4/yl9eYtK0R7rGUqHz+9E+vmhp2qaK
         29KFAZBuGAjeF80fpNBate+fwdYrtXV2gO7Y2aKFt+OB4Nr1KO2wdERLIjBqCnHd5t5T
         pMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099745; x=1755704545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HV68KIDec58Lp5ofIAN+WaUYN4AgQmpZQcNEziHckfo=;
        b=fH7qzXXtBUCz2ZLNgQ8f0JAdIdHfJaEZR3wYWF2f374S0dY9/SZ3hhB82i6ON8eXw4
         zzPBWqEiYPdGh6SvU9Ce0z0HiZy+IJB22uDUXQoWy/+kC/S2KgUes0DnJEz0jUO7h9mt
         xlZiI6DSyadLIZGQwkzMWg3i1MmVwOETpZiG9GN/u/axbxGdNziszhnAlGMLM6XYP25I
         N2DcbRr0LccyvdFgL6j6OL5zwg3Wj41e20XFSFvMk+TZq1gQEWT2wWaYfj6WvZvKMkRF
         Ngtnyqn0w5QNuOgRYZgZZm3MHwk+wCp3n/lVFGlniiqR5C6xn2/CU9MH6W1O9K/MK/e7
         fiEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOa/I9nud8CjpSOU5BDjgD4Jgp8IqxlIS4ZHr32WJX7a9OTadSxGJbjFW+NFgNGlVwlFyeyP5Xph3Rsttv@vger.kernel.org, AJvYcCVM/nuVy0G7DxVfhGvnlRPZ7p7CFQ2GK0mOx2P/sXoRc5ITF0Dc2J6UrbMowdSgLc77aQi8clwAeLIzAEQK9+k=@vger.kernel.org, AJvYcCVXo3NuaLcqoTvr2ph13TRKhFJQ5/RFu270DTXa5LPF162uLVSoA7t+SyuyBRg5QZKh00XeGPsexTM7xQ==@vger.kernel.org, AJvYcCW8QjVnxCpcjsWMPD8lv7ExcmMgT7vxQN4RZ7TuOnnv8uIcLlGxurCdvzalYinckxU+SIEGcauWXUtK@vger.kernel.org, AJvYcCX+1JYDLs9jIbuJaPgpRwCEZnWIv/fwRBHmGxS/Cql89+cYTFSASlaTHLyVpHguaKEN8qUe2Q/j@vger.kernel.org, AJvYcCX0F1e8ToCSRpfXOJ4tGomEqbS0pXbajpNVihvBk69OmpcsQlzyqHc+LCQ5Fs2yLf5vFXpmfFeghGk=@vger.kernel.org, AJvYcCXR5oqYslufJV5ItAJ4SZcF9KefbZcjPsCQ0WMBJhQRP+ojEdkOQQIAdnS3Bh3ruoXWUvHy9AAU3RgElbP1PEXW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7QEDrD6fIFVw7R82IYXISNWpkKkm8YzYiPyqeBP+sTF4L/c4G
	yfA/KhvKUwATbBP21QHTnNEcT7gk4RxXxf/5rZ/lJ9pyo1iKTroZsvJZ
X-Gm-Gg: ASbGncvkfgXIG2xYej3yPgv1BDrBe3nXsOB5pmtOsAcWhwRWPBpUb9z2cPc7yCae9QQ
	uXO+e+zw+yX8IItdjw2BAcyFgE9HE/9zcVzZOnTAqKNWuaLOWjOKO3N3xRo9fcB6FCymep9F6sy
	zKki+hY8EInDCiRyYu8jc2N9u1yWBUYuqC0D8StJ40uCrGhsuMP/OvINEC4sF3U10WIDga+TKCD
	Qgsp5T9vjbtVu2GUmR6Bgq7L0+hG1NVYu99+0rB1MsXpEYdxv4arJjbVibi4V86ODGcV4rfQ6oM
	8WSwuRMYaUindWwz91nVjygo1hOAvrsJbXjZ1CSE9c2BFa5H4sUgulmEnMMfPwpiZ4x8+3L8CWS
	GbZGVpAPhUcDddiHr5H0yBllJqU+k3J8Ran53yc1TZ/nJRjL1EbDucw8P8lxLX0aDnBimlHM+/T
	GOWR1OrW3O6Q2iQRBFxWllj4pt7I700RHilw==
X-Google-Smtp-Source: AGHT+IGueTHLMPq5mASKcygcGpjxpQLr77vYPVpPZinVZalsZaN0RbJcr5FWn9+kKNzsAHrio9z2NQ==
X-Received: by 2002:ae9:c10d:0:b0:7e1:5efc:6f6 with SMTP id af79cd13be357-7e865323bfbmr351498185a.47.1755099745105;
        Wed, 13 Aug 2025 08:42:25 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81bc7a1e3sm1180019685a.74.2025.08.13.08.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:42:24 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:42:02 -0400
Subject: [PATCH v3 11/11] rust: acpi: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-11-545c14bc44ff@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099716; l=1137;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=7eEQScKSS4lgeevbAHUT916RwyFbFyv80kGiczwdQFA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLzNH5g4iPNs065FYw7w7djV+1xHowTEMku81polGSYjrhqzWV320xGu/06+NykyIYuirJGl3Sv
 bZdE3PrXglg8=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/acpi.rs | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index 7ae317368b00..37e1161c1298 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -37,11 +37,8 @@ impl DeviceId {
     /// Create a new device id from an ACPI 'id' string.
     #[inline(always)]
     pub const fn new(id: &'static CStr) -> Self {
-        build_assert!(
-            id.len_with_nul() <= Self::ACPI_ID_LEN,
-            "ID exceeds 16 bytes"
-        );
-        let src = id.as_bytes_with_nul();
+        let src = id.to_bytes_with_nul();
+        build_assert!(src.len() <= Self::ACPI_ID_LEN, "ID exceeds 16 bytes");
         // Replace with `bindings::acpi_device_id::default()` once stabilized for `const`.
         // SAFETY: FFI type is valid to be zero-initialized.
         let mut acpi: bindings::acpi_device_id = unsafe { core::mem::zeroed() };

-- 
2.50.1


