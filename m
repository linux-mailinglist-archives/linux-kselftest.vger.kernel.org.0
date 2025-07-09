Return-Path: <linux-kselftest+bounces-36864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65425AFF267
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABF53B3C0F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5EC26E715;
	Wed,  9 Jul 2025 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ihxb6sVG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E1242D8F;
	Wed,  9 Jul 2025 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091153; cv=none; b=bs++SIQYXE2A7K8mH7cPLCksb+7nI25ZLx1D1gp3QurKc4kJWTqx9BsNq7I/ZdCjAHrs4cNvHha+Ycne9y9S3tnajEBq4/Edn4Rbm1u23+gN+l0t/cnfbQAd8Yy0j/PseOONw95rbBkQ9Dry+6m8Lq1el9gBNK9+Ua4KaVfNa4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091153; c=relaxed/simple;
	bh=dm10gtwjuCCm9tTYRvN3dYOyNcS6PwNHzHuSeS974dU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0AVbSKVobqTtXLzf3LZmjVh5DcgfxfG3IK+bNIEpux92iMu/LXKTngvUBYLRmsbDNZrgD4c6VSDR4EZt5SREwmDtn6cADciXu3DSQueLhNYaE4FIVXrcbLcZJWommecK6xZwPKxCjLxooWe3jOj3DajR+U0sktrSIdhHLNmEaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ihxb6sVG; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a9bf46adedso2990261cf.2;
        Wed, 09 Jul 2025 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091151; x=1752695951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUW1pWKXr0SgqlavpkwDXDeyBknv6dTunIyH+LvLX6w=;
        b=Ihxb6sVGNz9ZfsdvrYQzvr76xl0Q2xdmhiOAXC0wGfxseKZoBbJvYFi+AHNPwEkk/8
         Q5YmUP9JISBjMx4BU0nweb4+IS2ATwgDgzjCkqxlRFW53BmXae4gcW/p+zifx/PcYmY/
         HkgHTuDvLWpmLaTZcMSBm7WsD016K2qkR853BEWOCuBS8TGqDeparooVtPxL0HWJNQyB
         V3p+kqjCbPmcSid5SujtKKN0r2UztgSTV94GqlV+fqrJE2jTgBnpFZIqF3m4sb/n3xOI
         HAOoNcvP9DgdG+N6n7EeYMQj1/NAq62mu0NWhORafRmiGDngRr9LQcBl7dH+qvQ1EjXn
         RFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091151; x=1752695951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUW1pWKXr0SgqlavpkwDXDeyBknv6dTunIyH+LvLX6w=;
        b=WikOgmOHRHs8jGV5WCK8XFOhwLrgiObpnxdAIPKu+ol6L/45y25OVeGQleCQMNNzkl
         6cBOuo7/q3M90UmcbVXkWJmWhQIrgI2qjhyVomOWSFu2PWJmjAInN9yVN0a9T/hoMcUu
         obtNqc7YI1npHWyRmkMEXD3Fy0y99IJ9PPmWZNc47fdrdUld0LTT2S8vNA0Jcac8MTAP
         v+Yl4nRDmkZH/N4WmgVtpmuSKpYZ/ZNLqepaLr4UgnxE/8JBjSAvcP5fqXbAo7gyiWOp
         BCdQft5qMHgv40sVzM0d8jwt/rPv2kprwjwjlAeBPWQN0cX3zD5zUcbqbJV4pMIFFiVT
         1udg==
X-Forwarded-Encrypted: i=1; AJvYcCUbQiv9bosRrBr3qLkEGzUOBdfr2aTV9/WXWlrRAbGjDz9FJUMfg4cyJTscUKLhiLzEOZHgHH0Yc+ltcjDr+UyR@vger.kernel.org, AJvYcCV/2MWZSEV7yhTC7eLdJlnTedOU5xw2+rG6flVUnsTxGg5T5+uFZi2v0uC1X48YMkVS3LoNv0A5xbXnbB86@vger.kernel.org, AJvYcCVnxLXMdmeiA/e8CG6Mn7mSRFpAcIsrblVSEMsmsB44PYick712H9XA73xB15Gm+al7Q3/g9ON9@vger.kernel.org, AJvYcCWHSu+LU4ef8RChkaCuIit0AeiRBG6WHR/zA5qr940iuJ/YIo4HwXglyOnYFC/tf4Gm/LEu8ra2RyKqB+lzSO8=@vger.kernel.org, AJvYcCWhJg6Vzeb2zTnXJN6Ac7MFEZWcOpJ3Ruq/oQulO7fDi2ENJjb/q8PvPiMf1rku3Gn4wOXpMm2z4pX+@vger.kernel.org, AJvYcCWz6L9pnGTV2Y0r81h+l5OzA0Z5G+sVW0CgAhx/2ePzeTCgS+eXi/Uiv067yWIL3iycVfbAY+jZ0VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOAOTpSSIXPULa99CDItDfC7fNClOkWbi800ya2pNd+C0X9DaQ
	EA93AzKSh5BLMLTuVwrh1Gcb6U8Wk/M7T5zdYOcHS/YbbuPzC1a4UwcO
X-Gm-Gg: ASbGncszHSJrfF/iJjvjOtCiaQqCvJZtfdSvxo1nzjQBtEhgBwh+7WktVU7UZJimvM7
	4JKxXorth0WQGXYT0O8RgTn7k1uBobYN7Y8unPe/ujupqGNPhApc4pdyQRRFhfISmUdNJOmo8Ds
	nhhXDDKkVpusw0cHTEa3qfd5SvzOasVSknNkpxQuv+vwLOENVmyzAzOA65xiVnWZG33OV2IyMM8
	AyFhjg2DXPpUf+UaJNODQG5rxt7/P8Ce5W2zR5TJKJdugjcc6wUHfJKlxz143V/VT+G1gz3sgQI
	If5VyUMANOa+0XWFChAnXMkfgHJmnbMxjsI36132W49sFiySgA7CyTsjmE447j/+s9CYLJzNwQH
	UhXdclcrbzL5rOrrybhM48u+YdCU79laXYCJD+S4WOSrnJakiyRVRm/s5Pg==
X-Google-Smtp-Source: AGHT+IHXdEVjnJrqmEZdR/t3wveCipsqfk90lWTMcF8YzDj8t6VcoqZTYbnDJ2c8ZVzxuEDJnSMhpw==
X-Received: by 2002:a05:622a:1342:b0:4a9:91b7:6b88 with SMTP id d75a77b69052e-4a9dec2812fmr63675201cf.11.1752091150495;
        Wed, 09 Jul 2025 12:59:10 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949faf39sm103584281cf.28.2025.07.09.12.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:59:09 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:58:58 -0400
Subject: [PATCH 08/10] rust: miscdevice: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-8-fd793b3e58a2@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091133; l=1138;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=dm10gtwjuCCm9tTYRvN3dYOyNcS6PwNHzHuSeS974dU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDBoJX8VS6KU8NdnpyFGeJlvA1xdRjRBiF83ac3T8qzLDrgh+gyjUJn0Ce9odVwQyScsSuUZIpE
 pUmfiT8bhNgE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/miscdevice.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 288f40e79906..b5b2e3cc158f 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -35,7 +35,7 @@ pub const fn into_raw<T: MiscDevice>(self) -> bindings::miscdevice {
         // SAFETY: All zeros is valid for this C type.
         let mut result: bindings::miscdevice = unsafe { MaybeUninit::zeroed().assume_init() };
         result.minor = bindings::MISC_DYNAMIC_MINOR as ffi::c_int;
-        result.name = self.name.as_char_ptr();
+        result.name = crate::str::as_char_ptr_in_const_context(self.name);
         result.fops = MiscdeviceVTable::<T>::build();
         result
     }

-- 
2.50.0


