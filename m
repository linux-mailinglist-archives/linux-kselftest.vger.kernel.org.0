Return-Path: <linux-kselftest+bounces-38875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1457AB24E10
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDC71A27B27
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2175283FFC;
	Wed, 13 Aug 2025 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+J7VWJI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE47283680;
	Wed, 13 Aug 2025 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099723; cv=none; b=KS95dwdERJCYiX1pDB0qREU4WOd4a39zWL9PpNhVvfRGpHqZ30UgSYKrX/DHNZsVhqZ50CQzmzSU/coR9cqZqMqK/LZCY+BMVH3oDIIpaJWNSnwcaiu6z89g/0/q+IKsG4xGc5lmqmeD8U1cN/UKWfIcvb+sFHAzSYDgd37KD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099723; c=relaxed/simple;
	bh=V9/FffzUiUTQiasGGe9zR5nvlq2KGtqv4s9ApP+hKDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sL5KbrmymJsJGTVk+GwlemVdkQi8E1DvRXSplQCuiI15Bq/geUw/nLGGg27aeVsE5x42WPkToVNveOOygPGhxta8i0hTC+hcYBte9ZWXcYi+Kq8g8bekysYQnLHnsebU7Nq2TNZvJvypUge5yQ8ykt+tPlHDrMDleuOEUs5V1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+J7VWJI; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e86f90d162so4011785a.0;
        Wed, 13 Aug 2025 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099721; x=1755704521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEL9BFUl2s2rRVMDRV+g2pYwgrhoVdhRC86kQADKG/Y=;
        b=Y+J7VWJIX5v8nN+N7CMClFuIVFOCO61Q1W1fwZ63tfTRbm0Iwv6UJQ1PPow1Pmo9e8
         3ggUFFhrcoz5PiAiKZp4oeGbyWe11Q0ss+NemQjOa81KG7YW+FONRC733zuHEtxBtmhG
         wKhIPSMi0LEVXbsgWZnjIZmHWBZuc2ggIgHdR8FHHjt0itSJlcU4FL1UijbGcvb3WUFV
         R8EjpW1vVPrle+XSjFcJWz9M4J6B7cQwpNlBHsnFPoFRRntP4wU/6DBPqT10fb4OAx/A
         fwKpsj9/4hk9CzYsykkFBbd3c8EDYPxqCgnzO5F8mc+WKgJyQLf9TSWvu828eTmrS8J8
         Lj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099721; x=1755704521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEL9BFUl2s2rRVMDRV+g2pYwgrhoVdhRC86kQADKG/Y=;
        b=Qs/Dgbyl72qvWIrfDb1YOtw8IdCbx39KiqsLOrdrkwYruR9hIm7vq80onvx3fcVmf6
         1E7jraaxS6Er4z4gnsXIpuJhfwdZGZOXK1I3jRJlunw7ymt+Wpw0Gi4LAClbrzZo/aUx
         cz5i1FlSM9bjqcCnZu+fy50c5Ji3By+iiKd78AJAwfPyOtAPiI1T/CF1iJXxapPBDRVs
         cXM4/lOPDx6/gs3d0T/NSi5NpRIgbCuZToWK9Pm2Tpe6IZqljnEELNYfYo6xgAe2Kf9o
         oKnPHFXVtffkOrD35sVldM773CqaHIjZL/wZHhW3+mh6hVK+0e7ggp2KHhe0uLmE/tti
         fcZg==
X-Forwarded-Encrypted: i=1; AJvYcCVNzbIkXAt2Ix8LczUBHi3NDlmAi+G5HnL7bCOZYDXuduTiaAu4zFFBVWJBOMmu+lW4PrQ02UQtRRbMfw9+qqw=@vger.kernel.org, AJvYcCWEEtx/Rxg+PS7cCrFbMW/9H/twgOGeNG66NdskDEci+LUn7y7uJ5QNB/iTXiIkPs5zNeKTgiugkPYNHjScDt+k@vger.kernel.org, AJvYcCWQJa5jIxpElDbeHAE3z6wtGD5yWQDvNF16htociG8d5AgSUbDz5VBBG5WXJvKb1escYr5NjZZe6kcAWyGq@vger.kernel.org, AJvYcCWhdXc2a349km7jKwgVGCZ8jLUmzvQVl3shcM2J4fQx4f4vOgRwVOjH+j68s7N4DRVxpavawyEYiCs=@vger.kernel.org, AJvYcCX1Yn0cSZv0PWZTAMYTcko2lmL2OY7DHtDGwq0nragMvZyJ2uAE+QLYO8SITvg7X9LRZnmChXFVlinUsQ==@vger.kernel.org, AJvYcCXXKfneVV6lOSBJYc0q+qsptNbpEV8AI2A5+WUARIai0O5K4FBWUvGAQujIcXrnYFvQZofmSaOAUn8I@vger.kernel.org, AJvYcCXpSD4ElDe+nc9bB3uRGyL0gAZQ1Tqn2ersWjJGR2k0Vwdio7lIXF2+qNKMBK9Oph0gdNcp5N4c@vger.kernel.org
X-Gm-Message-State: AOJu0YwtAzLvp4QFmBiQtAfdfHu5ysEE9ZzTjyfK1lAc14UlE0jPVW9l
	EFH5w9p/Dubzdmp+B4Ce3V6yZsx/RqNyConVtjxO4QecTlRe8yv5F3jp
X-Gm-Gg: ASbGncs7aZhyrLt8jHTPh2hNGI/WyytS4GkfcHgah5nkqYaxwy85lsSIAlHbHcTwEtl
	AcSJUlYhL/f9VySAIjWITi0D6/jjeYKJpItJ3tSKEOFHGeThEs1gN4xGXulkQ8xSI1ZjlETG+XE
	y/91o7P3ou7W8uI8Icaho8tJK5MB5fNAMFQp4+eHqWImxWCcMVU55xMZeOFYjFP4Ac8HVvUk4wq
	ncqiEiksp7mmTuC2fkrsCn3S40NzwGayZmkSuu5R7gK0Fw7u3JFPg0tW7j36RdjUQv+XLF51Iv8
	vjdL37sFAmyv+Qcy9bGfFtvcmSk60pAEYUsQW4BTuXNJIjqtgaCCpd004T371mHDGlOKspf/Na/
	BzNLKfEpb+u1Pd9GcT8IOn9/qh5W27EKB5x+ZMdRcw3ScwbT4e3FvAkTEMUI9QBrp9pf0ToDQPz
	D6Q7vxSsDkfWdiz/bohBrmP6PdO+hQ6mMAjPqfANTq2c1P
X-Google-Smtp-Source: AGHT+IERtrsVtKTOwE60YtDuNPV280d9g/vz6lBcBxlV1+yYS97R9ClJDETZjnppLO0l2b6EPh2t5g==
X-Received: by 2002:a05:620a:2801:b0:7e6:4f67:d145 with SMTP id af79cd13be357-7e86fc3044bmr5915085a.13.1755099721091;
        Wed, 13 Aug 2025 08:42:01 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81bc7a1e3sm1180019685a.74.2025.08.13.08.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:42:00 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:41:52 -0400
Subject: [PATCH v3 01/11] drm/panic: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-1-545c14bc44ff@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099715; l=1187;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=V9/FffzUiUTQiasGGe9zR5nvlq2KGtqv4s9ApP+hKDA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLLcNXv/WAUZIWbgEvJj4/4hXlVGOj6ffH7E+h5eDBfbYXFk9RdsV8aQsIMPCL55DJC6vuu+j+A
 eIbixGdXebwU=
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
 drivers/gpu/drm/drm_panic_qr.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index 09a9b452e8b7..10bc5bb16992 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -948,7 +948,7 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
         // nul-terminated string.
         let url_cstr: &CStr = unsafe { CStr::from_char_ptr(url) };
         let segments = &[
-            &Segment::Binary(url_cstr.as_bytes()),
+            &Segment::Binary(url_cstr.to_bytes()),
             &Segment::Numeric(&data_slice[0..data_len]),
         ];
         match EncodedMsg::new(segments, tmp_slice) {

-- 
2.50.1


