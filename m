Return-Path: <linux-kselftest+bounces-36863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F13C7AFF262
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B873AC8B0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85404269885;
	Wed,  9 Jul 2025 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKEaYklT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF38925B67D;
	Wed,  9 Jul 2025 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091151; cv=none; b=KGy41vDBP7NwgaaUsAJ3gfwFoJUgiUUAHotM7pS0oHHwxsT5nuQupBFnhyrCu4UDMOrlgJcDKYUflxyrBYpCvkdqNKJzx93eu1MLGsw3/VGXDqcqv1Tc5ObkiZxrL5M6ZilU7R+OOec3hchU7/koYSkavY1LcpwUNxZQ329+Vrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091151; c=relaxed/simple;
	bh=tJnOwm+PVrqtvTl00SdcmMj6fMABCO8NY29rsQ/cGuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UjOhrnwj35pTC39lT7z8DB8RwO2f/mFld9GrxJR7IKbZwp+YEpYmXlRmGLVqF36s7zFHyYMVoFqEHFZVgJQaTFQO1y5PBSbGX3GKldRiq609vUGGk5tmQChoq+2MbvVBXu7vDQvjOm34TYAX2HFrNXxxmi1OCIDGucwG44R+VLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKEaYklT; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a4312b4849so3509521cf.1;
        Wed, 09 Jul 2025 12:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091149; x=1752695949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTisoOKtO39HO0t599kWYuf5kChlCvK0YfZx8jSH4po=;
        b=IKEaYklTPB8XxT33obwxua/cT9DGl9TwXg/EJO4GVEDc1IB+UdxWvAXlihU/wT9CLF
         tbpoiam8tB1E/R/AsxG5MoPGb8/VHaRjtbcMWGk2sS85SmK7hd7/MbFoh8PnSVK7rbL/
         KxyvMOhv0ZAaqFpaopBUF7dmiHexr9qJJ/lZjINt1udse5ZxXYMjBKHlTdGw0ypjWSrT
         n7qGaDh1cj1ZfRmurKikIhvALVMnNFfMYW5YP/7LUyVwxrh6ZLKXSukH8wkYuhcV3e4Q
         lZ3SSqSz3tu+KOnB+OnYcgk4kmghF5jli/yv7bZs4H8FpeCDDeybfyicaWM7oN/7dzDs
         iFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091149; x=1752695949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTisoOKtO39HO0t599kWYuf5kChlCvK0YfZx8jSH4po=;
        b=kg3T845vMSo61pgN3dNaSbGYY9m3HcziIQhZVDEVZ9VxhC6nYnBSiL2vJApxUrt5K5
         s0coiSO1dfWrLOrtqa/tIBjX6Po2cy0HHpSjZZ527hRU+/xCJfI1U6mD0PgHSpJChh2S
         zII4y4/kIUTwLJVQpgsJOmBKyF8SwUj/We0M1GxvKIV3MjG14I2UAsLAskhHC9DiA8Dr
         4ghKbYe+EjCxseyxxGAmhMHpvNg4K2ULBiH25zka/rAdrgwY72iIYsk8hJtaqMiOS2ds
         NNV+HXJvftiw3vQmwUjGJJDffZfxgHVG3ycXJ1u6YAepgGEE7YrgazPLhsrhR1H7n8e2
         ErrA==
X-Forwarded-Encrypted: i=1; AJvYcCWo8tZnzqb5lRst3NiYLLQS/wse008BWH/xgXzomTcBz0LTHUbi6M3ZZOe/3aDy9fAbs4wl6iPqC5jE@vger.kernel.org, AJvYcCXCQWZdWeaCsLgJmv9pax56GKmFTtuSEOq+DEYUsncnZdVxtK/+NiWL1Tb2vxfLgEPR3H74WHeo5tzkEKFZybo=@vger.kernel.org, AJvYcCXD5yUA0NQXbyXBuTIlYutQbDEE+/LheKLvQqQ1qdZ7v1Mkt53UkQdZsLwW8/SqeuJ49JYtYj82@vger.kernel.org, AJvYcCXMyg+2VvSEAY6NbzHu1zrUClDppQCcsHID4+OBXbkEuvZ6WpomNaq/Zuuovj88FSV6GiN7kUFnJNvrLs7o@vger.kernel.org, AJvYcCXWYJBR1+46TIzje+8D7XNafuqXuWZlsi8jot64cimV2Un0Kt+lM6gxi/zH+GgCyk7HyruZzSkPYao=@vger.kernel.org, AJvYcCXunylOHpI9S+l7+lRkmss2VWORGbGgRRtYQwaWZH5oH2VntY1Iq8N4HwlLXXVqJvrIIZzcCRbcC0perYhfNPsV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9tq0GzuPbxZ2pxcta3YN0Qp5zWq4chMIvlZQ+2TgpvEji7A2F
	amAjtb0DbVPxDIpKD9dU1qfXGYS0nhLxoPpDzSGD1YrG2x/1Nto/dZXw
X-Gm-Gg: ASbGncv34oscLGOFrforwJ0B1dJUqoJhr+MUuo5WUXHlHlCvoP7poiT3NfR202TuPiy
	rZhWRPrAN44wksIscUOJc3aGFV1QwgV9K9ZfsAyhlSUpPjYkK8doE3K+1fyIkSIFywI5GHjFXIo
	9uSySqG6psFdM5uHvqWmNBfs7UNeTXLCqkfiWs+I7Qd2rycLOGeA3rJMAlgvaEiS0RsX/S/k8by
	0VZf9FS6L4/WiZawxPsSGhiDfotcQu+RTeGr9T1otomZAZbUn3hzfdIPyUqYZzviJHPEgymb3CW
	rcd/Qr2xPQjRgDAnbtBmtbeJ3ULRV3rygZXeL5atwNOENRenzrM185WiZ6/yx/XoN6v5jjt5tsr
	d2G4+mbgY/hxzJ4d86BZ7m8bJSfNVRJ1hXXaP4hbxTlwwen8CmmYSPgcXNw==
X-Google-Smtp-Source: AGHT+IHKgsc+ICJ8GK7k5FIulKNaP4mQStNYRDkaHExXBz0/hhkA0TEwHhm1xFLHm/CEqyN/qjvlbg==
X-Received: by 2002:a05:622a:199a:b0:4a6:f99d:9633 with SMTP id d75a77b69052e-4a9decea7damr51808541cf.31.1752091148453;
        Wed, 09 Jul 2025 12:59:08 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949faf39sm103584281cf.28.2025.07.09.12.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:59:07 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:58:57 -0400
Subject: [PATCH 07/10] rust: kunit: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-7-fd793b3e58a2@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091133; l=1706;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=tJnOwm+PVrqtvTl00SdcmMj6fMABCO8NY29rsQ/cGuM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLnJ027s3h3RrpYj1vjpMfp+RpzbAjDmlJhlGFtcIe/F/zmdfI4fCuUtY6jX2mu5mXdHWHJZ4X8
 oQKLtan72/Qo=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/kunit.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 099a61bbb8f4..3fd33c0c5ecc 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -102,12 +102,12 @@ unsafe impl Sync for Location {}
             unsafe impl Sync for UnaryAssert {}
 
             static LOCATION: Location = Location($crate::bindings::kunit_loc {
-                file: FILE.as_char_ptr(),
+                file: $crate::str::as_char_ptr_in_const_context(FILE),
                 line: LINE,
             });
             static ASSERTION: UnaryAssert = UnaryAssert($crate::bindings::kunit_unary_assert {
                 assert: $crate::bindings::kunit_assert {},
-                condition: CONDITION.as_char_ptr(),
+                condition: $crate::str::as_char_ptr_in_const_context(CONDITION),
                 expected_true: true,
             });
 
@@ -202,7 +202,7 @@ pub const fn kunit_case(
 ) -> kernel::bindings::kunit_case {
     kernel::bindings::kunit_case {
         run_case: Some(run_case),
-        name: name.as_char_ptr(),
+        name: kernel::str::as_char_ptr_in_const_context(name),
         attr: kernel::bindings::kunit_attributes {
             speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
         },

-- 
2.50.0


