Return-Path: <linux-kselftest+bounces-36857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 012EFAFF233
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 21:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0815A63D6
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 19:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E8124501B;
	Wed,  9 Jul 2025 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmK1lP52"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF697242902;
	Wed,  9 Jul 2025 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091140; cv=none; b=FLU35Ali0dsFMYoZ0ZWYYsBM07fPJVP5CC5Z/xHarfYA3REFbfFdfWWqHTWwtd0JlVvbl6Bkhqi57li4kvgAim1Sh7ulo1D/7OMNG5oVkgeXVKSx2Yxp1k0p9Id9LYACgSvGpXzHzGg/TYHXV2QJfe9ROJVD22ZXM/zy9iBaJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091140; c=relaxed/simple;
	bh=lXhB3ReogTGFAKcAXwsx9yhjUwYICNU9NQ66zLyVw8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B2ZugmeHcAzoXRCwWkkXt6riD5BwQQIKY9JowRZLlmyOYO/WLE+KUWDJPEEt5ahPr+/psLEtjnOiN6n6uiSuLrir5W78UR38s35ZrorGx6I44JpDhN5axRUEA4Mm+cMyNygaOSzWmcaXwWAVS0wDXuXD5vyGbRICFlh0WBehy2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmK1lP52; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a442a3a2bfso4105751cf.1;
        Wed, 09 Jul 2025 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091138; x=1752695938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjFq7UYS8hmojmjwvZ+zmn/qpSRuJtm2WZezXQ16zw0=;
        b=DmK1lP52ubuT9PK0ir7YPjPpDL/jZtrasSiK3asyPL+wkUQCfjmzNv4oOYyz/weJGt
         P/z67a4Q9yNtnFKEmzo/9lLYraZ2ae7jr66yz0u7DnfEosUjtQfHHukCbg5+ZVCuHJGC
         mGIVy7l2iW7pkWS1ESYGuKjhyyBMP6XQT8erx7kkj9+WC5eZ+Rc2DM1FEDJSGaeTCGcA
         /z5cjbOf/PxK7wtuUfQev+jkiFZju4S43O7Igna+FQshbon9wdSEl8HsgLAtqy5zFaxh
         wpDFRzyxv/yBpA9KNT1tlGfrXWKfcbJOKBRptCccjWvIDGS4DEA7WMClIrp0zMYAX3Nk
         ubug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091138; x=1752695938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjFq7UYS8hmojmjwvZ+zmn/qpSRuJtm2WZezXQ16zw0=;
        b=po02j3zr/Td88QPyIXdBWgqC96M6YDsLhGE5sr5JoegwHtPLVrTM9sAQK2KQCiPBaj
         /FyOws09GPeN191vQKc7nUnTrDuysOOYK2iPZJ5VxL68LQGcvHNPZ+IHP9xAiLWt0S7j
         dxNmpptWlL1jx2JL5WwAqn+PQvt4oC4o62OfCqaEBJfuAHZz2KT2UYiurhTcleeoZcG2
         HVzGPtZdVlydwsFRCD7SsWowTodnR9L04WIubYRKHkymTLALb6oFZ1FN4jyvMxbn4JcK
         qn+XazOiRCOl6IUPiNUHcoUWYo6qmUX38RL3ThMywv44uVxfs7Ak4NBRXIE4cXSXu7yz
         /Mkw==
X-Forwarded-Encrypted: i=1; AJvYcCU4BTQYhPrzHNHuSJIIjLH8nq85JX3SDuvQo1ANa3XHnhAwmmAtTAm/PIzsRMth8DXIQNrakBq1@vger.kernel.org, AJvYcCVOWu5h3M1EHi9icP03qlvo9x8OjxedXo6LIdncbUaksPkXmq7CNRPM39m8GTP31oUwV9GGdP/9ZjKHaRjc@vger.kernel.org, AJvYcCVetoQjm1hBcVcrDXOElsrvFsB8LBe4xm03AabDPScBP/6yCXe2rMowNVt8tiplJAcMq2pfWnEvDsqiTpzI45g=@vger.kernel.org, AJvYcCVv9BQzQJ+yU5QP3vhy0ou1xNfFbxp6aFOa9hYsd0Mxg5vMJBspU9QYtzVJeidTkGm3GVRMRcro9Rpp@vger.kernel.org, AJvYcCXGzuWvEqJJoF3HLNGhTmdG4IL1GMoowNVYe4zHp9hEGufsXO7gvCQyOqnZSufC/Tiegtyt+7zEnbh+tKWBceP4@vger.kernel.org, AJvYcCXMVKIvcRres3io/Goul3muCDR6k7aEnL4BSC+UGP7zRXvPEdQIrp7p3i0n+XnHqfbAgBKhkKPteeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT97Gz4UFTnp3ph+W/uzwCWsjfyVJHOWc1ntg46Xl6FmHGN+Vl
	za9Qxp5UpKvsFzE1U18WciF/IVFFSZidEYtQVEVl37oWOypM278yvU7O
X-Gm-Gg: ASbGncvM1i5STZuGITp4PUyG64SGVQQ1wz2vLQoNzyODtrOfEORkfi4vS9lmOz9/ndR
	Usu/3LLq9fe3pbyRp1MjM7YNDeO9APnZ+R/N5/SYpH4F3bN9mP8EUgs4V7raiDfbfOi2S069f37
	IZ7+7+3l42ynw9nofRWM9bNplzOGSXY5bVMn+oGpE+kw5DPVwy6euYWKAcMpAJg7SZ7FOnezeiQ
	0jvG1LP32DeRCZepsBBIre/6lSZ9nJ0USwMOouY2/S1cDLXaVljtZVl3eGoGYLo3L1ZtVgiacM8
	tI3Stuu6FjgaYAl/8NCPImvM/Aenrx9f1AKUGwbvae3OB2WwCWgazPmdqWgCyJ5ZFiUQ/yjZheL
	mNTBIoRQgfXorILnojHHPYWNjc1Z3AC9j2Z8Vfm9WyfkLSWCUahByF/8eDA==
X-Google-Smtp-Source: AGHT+IFOO4s6abodeExD0GmybGRrIRuRV+W6D5U0I0Tr1TjDy6dph0KjH9CsZ4l2j8Y+zoOtXMhcrg==
X-Received: by 2002:a05:622a:1350:b0:472:1aed:c8b4 with SMTP id d75a77b69052e-4a9e94ae9f5mr17712751cf.34.1752091137593;
        Wed, 09 Jul 2025 12:58:57 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949faf39sm103584281cf.28.2025.07.09.12.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:58:56 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:58:51 -0400
Subject: [PATCH 01/10] gpu: nova-core: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-1-fd793b3e58a2@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091132; l=1094;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=lXhB3ReogTGFAKcAXwsx9yhjUwYICNU9NQ66zLyVw8I=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHO89qb+A/14W5ZaKLln68gAAlveEjaoU+oksqwcVVthYSjBuURPwVYoW6QTQrF3UolajEuFQa/
 faudbNVVOKgE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/gpu/drm/drm_panic_qr.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index 6b59d19ab631..fea062cc0383 100644
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
2.50.0


