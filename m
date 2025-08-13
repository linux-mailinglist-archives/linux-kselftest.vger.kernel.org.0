Return-Path: <linux-kselftest+bounces-38879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34BBB24E2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669E47206A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1E628C870;
	Wed, 13 Aug 2025 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK1oXygb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C9128BAA6;
	Wed, 13 Aug 2025 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099734; cv=none; b=M4plDOk+uxbU4WGUZCRij0poz/RsFeo97IL+EqNpLznabiLbI1OXm8FOCR86atmuFdLuV7oo9MMrb7WDVOdU0HPoYBGDQlEdbVpc4rBBfTAQYbrjTssj8nYwcktnTwu9dkLg32Ig1pc52NWUMRUQ6GOyCnlTrC0c8ILPiR9L/WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099734; c=relaxed/simple;
	bh=Je+DfhMpFZaWrjewSpv+UzKU7rguC4PRjqAvjqowEZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgijnzsNU67A2ITvdIcZV6uairO7dpaJqbGjEQ7YDQfEVuR7xLXii8Z3SlFtJK+nfW2rfhHGvbWy8s+Hd1fir7zRDVGcNb41a4RbDeNCKk5I3Mp2tWZDeqNaxAMqZW5D+0+m6AC8cpOa06PgsbuS3mO1j52YKg4NSXOkJ3o4btU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SK1oXygb; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e864c4615aso115021785a.1;
        Wed, 13 Aug 2025 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099731; x=1755704531; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIKU6y7HIcD7sJ2LFPkw8IuKvoxcxt9BF9YEBuREqoU=;
        b=SK1oXygbCrXMb1GDUOTLE1yCLufLdf2Qxvk3lmdT1N8KtiDAMxWpaGerLJpa8Dz7vn
         iPq8BtqoDWaqLGYHNJrJ5iCSzAWUcqy4egVZFzDr6zTstEcIe7zkGYyHUDVRmWA1/B0m
         LbJCWgOl62IsJ+h8vqnhsX7TJiJ74a4tfit8m4llyNuSyWQc7QVyJSMpVCgNw1otxFg1
         uV3ZMAV47hGrHvSHxK6o2Lu/Ib1Wf2mJ16A2z8iEiHGu3GXMJMDfNiYqH0C6uI7c6qwY
         Js35DsdsIXQyqJisyblzd3KmB0wpWur06YAFnjd9CGQtrDdGOCdQdm7uPsG+Q49Daf4v
         CPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099731; x=1755704531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIKU6y7HIcD7sJ2LFPkw8IuKvoxcxt9BF9YEBuREqoU=;
        b=Bb1bB4ExgVpBSSvixmcFWIzdFvyP8bFMnphFDlEwGO00ucIwDBCnixmk2k+TOnbKt7
         e0H+z2wBJ8In8PWM53WT5JY7wt0lpiEc7ReTARcDFa8fEO/yR86313KULq/XYzX6cxC5
         qRv8iOwsMyysuLT2b5hdxeC3Fj/y5zotP5X4X8mG8GC1Q8AJWGZZXhL3aaskYSDdMlTK
         EFbpoO0a+dzhN4SbnsJdJ6mwd6jxW9Nw9xCa1R+MepGc0fCZ4C2xhamKZpKuCYjK0Z8J
         MH1aSfKwh5RINcIoUKSY9kEQZ4N/QxrV6L/QAEaR//XRcGLGHKDvG3TrEnYxZB6kKCE8
         dEmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA8NfDSj/1GsE7NqNcM31JRqybHUP+HboMwRX47nWfCmuLmjw4cv1l/w26RawvVsoHKsGXgkObg/5f9Q==@vger.kernel.org, AJvYcCVAIRBkM0nWvRJIl4pskIfie4/rSmhlgQZTz4epquET8PrikM9a19OPQW9mOo+qJV3KeLQf30PrRJfC@vger.kernel.org, AJvYcCVXY6OvZiORb/WVSsGZbMlY56217nwZplK0LG2S94yGAyCDI/hXt76evg9RGuu4PkgnVAeCW4I48eoc5OP29GU=@vger.kernel.org, AJvYcCVcxjZAanjx56QccD2URcsf1p8Z3ydWJo+l75MIzQg57lfGz2qrOKyPQOozMgPozdOWBK/9QpRDRXkuobILY1zA@vger.kernel.org, AJvYcCWG3F6fT/mE1CcoucUEvsnkOBiVxz6LByxCtYjS8M5hOa5p4NXMHAVdDCRrEs41tc1gfw73KUHNqaQ=@vger.kernel.org, AJvYcCWznJY4UcSk4JK1VS38wbjWmesgeCHoDk/ea1tAiBcaODnmVmiFfT+YWee3fpsEZF8R0vLBd8s+goOfSeMh@vger.kernel.org, AJvYcCXHOA6efTkd9B4V9Pdma/yVbmfx/MO+KQJpSe3tf0nPAfvjDErQfWHmcJy3LjgMpiWrmIBOzzrQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxvuI6gN3pTpymyc/e4fykyET8r/DZCnk3azYxjF5nOEvEaErpc
	V609WmmExkH8KqfqPtO3If/yjzAvzjaVR5E7TfJ2nDkBspszB7F/iO6R
X-Gm-Gg: ASbGncvLYdavUVGWwAbYUReyX3bZPo2MjalYYOYoSxlcsqaglSU8BwqNPb1vOByrIUF
	UUZ4f9MbObGQv0u9GJAdN7WY1Y6emmdZM/EGsK/+d5luX0kywiqnKtio8GsJAqPStwGur+h74Nw
	HkHn6yhk153BK/HDD/YjJp4r7qyIoHpFRCA5rkJJWX0ozU8emlr+3Cobx4qBtipN3JqN/5OL708
	F8h9mdmk0CNxD30eezpez/A0Ii/fMLtZMl1q0bqYJ0sJy3bczBPr1kFhSWXJDK0DSEKWyYXxstW
	DsHavazHCjVUdLhIo6baSmpkX7QM0Og39dUNxJ02Q2Or+bjsoIWtD/7UPbIoQrn/KCESZr/BSHc
	6xXL6Ma1Lu2DauL348ijzEFfzALqYuGbuW67mKKOUlIovEU8KQG6gN17U6Vm7k+N1Hhv47CSDcD
	Z/MXIPGn8dcsWoKMqFUo1zV7VDBO3HROBNIHUAprZTS84B
X-Google-Smtp-Source: AGHT+IHBJOKNxC55yhYhgGJW6LYVF5ZsnH5hebdh4RPHu+2KNBOMpGvD4jyu77CdVl9CARQjjtP5SQ==
X-Received: by 2002:a05:620a:d8c:b0:7e6:9bc2:6cb8 with SMTP id af79cd13be357-7e86fbeb340mr8732985a.2.1755099730671;
        Wed, 13 Aug 2025 08:42:10 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81bc7a1e3sm1180019685a.74.2025.08.13.08.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:42:10 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:41:56 -0400
Subject: [PATCH v3 05/11] rust: drm: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-5-545c14bc44ff@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099715; l=1242;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=Je+DfhMpFZaWrjewSpv+UzKU7rguC4PRjqAvjqowEZw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFm34PmolkRKLvy4QkIEI5kiwY6L7v2WN4Wn/sP/XpTg8AkQm7p2MjVpOjJBbFo96Gwp6cSlT0w
 zoP7k/PilvAY=
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
 rust/kernel/drm/device.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 3bb7c83966cf..4a51909ccc76 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -83,8 +83,8 @@ impl<T: drm::Driver> Device<T> {
         major: T::INFO.major,
         minor: T::INFO.minor,
         patchlevel: T::INFO.patchlevel,
-        name: T::INFO.name.as_char_ptr().cast_mut(),
-        desc: T::INFO.desc.as_char_ptr().cast_mut(),
+        name: crate::str::as_char_ptr_in_const_context(T::INFO.name).cast_mut(),
+        desc: crate::str::as_char_ptr_in_const_context(T::INFO.desc).cast_mut(),
 
         driver_features: drm::driver::FEAT_GEM,
         ioctls: T::IOCTLS.as_ptr(),

-- 
2.50.1


