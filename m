Return-Path: <linux-kselftest+bounces-37667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E30B0B292
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7761AA16C2
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1211428D821;
	Sat, 19 Jul 2025 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFei84/+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943728C87A;
	Sat, 19 Jul 2025 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964969; cv=none; b=oSh2x/f5P6iDGsXge1wZQeVb2VSEOY8A42Uq55kxxH2kuQ0jUowyzRwh9oHqu4tkaCPoOe9FozmNBWqwIIThffDsUBZZxVh109Ij7cY28NQa/dTmgjMGZbL2CRm61yC1QMBGxTq21t8qht5M9CRQQcHVayYkjHd55cf99OtjAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964969; c=relaxed/simple;
	bh=7j87c2ImiCXRY6GMVHj6oI5OA4CCcE5fWZCYEKHG4/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkPLSpNb83/QN+k49aESJgObEQbrBXvYJSC7mvNtlfsfYCKwECDTersF/QT8cpzNTajB/JbWY7uaOgxW5uM2SdnxzxzZe1L0+MrHKxG/gmQsAHJ/h3nBe6tbpVNJc3Ixs3Ve8WBj+R8p73VAjHhVrGBapupFUWjBd68jmWVyYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFei84/+; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e29d5f7672so296707785a.3;
        Sat, 19 Jul 2025 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964967; x=1753569767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0upvJAUOqytvdKtH1Js7QdI/pbuB0WBqV3BXJbjoVlA=;
        b=UFei84/+IPMS0V5nWbEexFe2M+iTeardfWRrE2C+NUxqatPELf+NtcJ0MVXZSbJVUa
         Rhc9w5xCMFRCis1+WgXJbRHKZXM3ZYtDp56ZoUfVXNrOHt8awVi2kLA0ZxOBpzuhv6Yu
         dNVuAyMdBJ2jsVFJUAVTqCYgbasOszA92i2b4w10KhajOQWD2zIE5jM6EeL9vzXWjxyy
         gs3bY8yTEAS6m/FB/IoJdiEpj9jQAf3vflvy7/dScZ3aGkzYTzIUDApu5dJREC1xL5Fz
         BRlU2m9WKXZBT/t/om7OMOelG4UqQNOWhv8dKO4g9Auys1eZl4g2e4z/vgvlKQOnUd9B
         G8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964967; x=1753569767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0upvJAUOqytvdKtH1Js7QdI/pbuB0WBqV3BXJbjoVlA=;
        b=P7MHZCoLaypevMe8Pn62pB5R9q1BdaSaJxbz27qHJazoaS7ZVqX2/xwsRSgtfLRulg
         t1HguYpWBervsjeLjk9xE+Ld5KqS6bTGUENvTSd2/d6HoG0OA3bT/1LP/6uDZEr1MjwK
         fQcUq0dm4JQostAQe19ruROLy7qIV6rBHNlP9QlkwaL5YBsCtAjWIj5K8HJffO0w/9Wx
         PSJXgxkvYJVIqoavvDvNsXIwUC4uqJF/jK/SN9LzCpp9SrzVAelgNkxgfHBCoIl5HCTe
         gR4A6rvvbrL0VoqpgVSeXYwBuwwtsDB4WB9uiJ6GmF54cuOeLzUv7x1XSQsyGi1w6Cj3
         0Hbw==
X-Forwarded-Encrypted: i=1; AJvYcCUodJtakOM0GXy9a8iN5ydT/sVeZpXAJjGyuneAIGiE7Cb97fIS9Io+QRhsP0v+qyJjJOj5eq6QkVy1NlZt@vger.kernel.org, AJvYcCVZzcq+czRQX4Bn4brf0EIG9fhYVMomJ2ex8AbCYA8tuI85CPo21wfU/DL9XIjXFYX54oI0l6OIyj9JxgxUUwef@vger.kernel.org, AJvYcCX2KgqP0oIuTmknow/J+4IbAyTcGAVZ0U1ErhDWnTEwHIRnG768w5T+qFIFaZcmkP6smAZPq6/mI9ccs+jbaWc=@vger.kernel.org, AJvYcCXcDcaSu3mC+Lt/HWdbkV32qMpskd1CQko5HQxEuCt0fP+9FMzVfAsAHAjhZptj93XjEoMdn00mvYw=@vger.kernel.org, AJvYcCXf2Mg9+sF0AZGgNX1dBPQuY7Ik03oyZom7USPexpp0bv7N5fp90rSvnm0XSN3L1gy7etX93LLZlUwQ@vger.kernel.org, AJvYcCXn21LVAeT8ocurCC0SuPXpioM6Cj6UkVTZDEXGL0bkx0Dl/cNp0Ru6Zh1xG6S2W5EsFGH2j2pX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz98BJu8+y/tkinE5srJetOpFPxW8sZJG3OeBT4X0iYPPnCTEQL
	eZ8XGahwq2u2eBfiKGzp/gnp9s31Eby0qoj/9FTwzxIJgYNxCqtpeTaV
X-Gm-Gg: ASbGnctJogu+KT6A4elggxoGwwH/K/bayQYUEBS12m+pvo8iRXywkDnfdy0SLBYyro8
	QRUCHRa7KkyJ93r83PVTikSLQnComx4VLuZf7KS0f7btRoJOJR6y6PMCqE2Xy8w+mMeO4cV08jA
	+X6AJCNvlKfbHF2qgtGOd3QO8y66Be5hxJg77HyVxxpXBga2fYm/hvuanI4nJc5LBjm9CyB+2IS
	PSrh3rd5SnUS8hnY57bynI5oBK2LbkDgXzDEII03ma9PCPrE7lOmwvknZ3epm/w9Hv/xJGDLBf6
	ENRywhCwOIFS2jv3GEDVSxdgbkCEzc5k5iDU3w7PQahrbKV1J8Mbn21LgC/L3wpOWG+QLzP5pfY
	w6CZ4qr4heXcPN3jawV+/dwbtgnqgbJnwvCZfshWc4JFSAu1GQRhES17ahFpeDKRrF48eAlsDbH
	3w/xhWfanq6HM2PiDAEPWtc+0/JHHn
X-Google-Smtp-Source: AGHT+IFNkExuwV5xK+HGDUG4UYXz6tqA3MnPyJsvS3T1Vaz1scPhMa5psrxoC7cCT/3i9N79jUky/g==
X-Received: by 2002:a05:620a:170c:b0:7e3:2d1d:bda0 with SMTP id af79cd13be357-7e342a5ee77mr2075766185a.2.1752964967235;
        Sat, 19 Jul 2025 15:42:47 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b1f1d5sm23671841cf.50.2025.07.19.15.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:46 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:42:34 -0400
Subject: [PATCH v2 05/10] rust: drm: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-5-e1cb53f6d233@gmail.com>
References: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
In-Reply-To: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964955; l=1242;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=7j87c2ImiCXRY6GMVHj6oI5OA4CCcE5fWZCYEKHG4/4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAibFveB/KKFoUVCRfSH/zxxHdWDSrZ1Vs54w9OiVr+hkkXSTUcUM7b175FlsaPFavsoaSMqGRr
 1rQ/BshMVJwM=
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
index e598c4274f29..439cb1b747e1 100644
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


