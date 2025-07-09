Return-Path: <linux-kselftest+bounces-36865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD9AAFF26A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3281C84BF7
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AACF298996;
	Wed,  9 Jul 2025 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEGgqx+r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F01284685;
	Wed,  9 Jul 2025 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091155; cv=none; b=YC5sc3Vtn+5RJx8YxYlf3le8q0MSzVBAHOlkB45vit28fzzmuaL7kOjHC2j9GHU4UzZG3y6TgzlYlVUwY3kkJC0NcY9l4rOvZ4tA9rhDXFwNoT6Y0HG2DYUpuOgDwsr71coiY0O2Wp2hKEEADP1Kt3ws1ijUG6HvmYYsAhOWebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091155; c=relaxed/simple;
	bh=LE7chWeGOaOT5eDKRrTO2ZAVumApkWzjr7E2NKjvPM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJpmOqJzW10pxAeKuT7CgPHJgrzmX+anu2tN3luTWJn33DZwOnrnFTehki+bO8C1oKdr2LKxrDdSgrn77M7EY4xIMz0NwpG2AQuehFhCCcVphVPSt7KYxCnyvByQNLu6c/MbtGd3yDk1DKts+LcxK7KVEfCOrn8P1VxXluSqZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEGgqx+r; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a9e7c12decso3361641cf.2;
        Wed, 09 Jul 2025 12:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091153; x=1752695953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U14jglz7jmLLE33hItepvmilwSYFOqXSGUyiLg58dEI=;
        b=KEGgqx+r5HOZVmy93KzFX7XmPHbZJC46vegxCuQgYvooeK8Qmrt2rGxRl6GkX46ICC
         6FqAwLTLTxd37AZjhDXUonljgJJvh2o0czvXi2nOd0iMvRiCw07z4pJCdunllqcTsaio
         0uwLoBF0cnblKjyyJ74yAUs1r665rS8UFzLiNF7y5H2TfhWfXR4km2smQhegt6niIZXG
         GOjB8usem+0dSaTRjlW3xVngc0ZtuU37Ss2iVSjS7SVheV6QmLrNvI7kmu2sAY/rNpm8
         wIyEORN/Nx3397haNw1gXsOGjptn13nRkf1Dg1TNimRbhq9mCH3il0uMq9U/XL1WptDn
         CAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091153; x=1752695953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U14jglz7jmLLE33hItepvmilwSYFOqXSGUyiLg58dEI=;
        b=Oa3TXhKz50sJuWlrdYus90S1rsmLrAoH6SVpCqLeJ3Budl3uXGDMkdwTtW8u14x8C0
         1SekD34YxflKkw63tqKiHd+AluZeHRi8bfqvcZE52cIVafeXr0Ws+n5Up1MBT9TkDwjk
         gZc6FW+XOAUnDE6Q9mumR9JQDMhIJPmuGqI7cRYa/kLaOYAxAS4/4tv7Sylyana771WZ
         88WHlH8k1uDju0WHcO2x/Obw0q/n8cibhHGJOsPgxT4TBduSg1hzRgLRjC9rXJSxGPZs
         HbGHT/uG8fFOxCOJf7EcBocmvGw66RcM/FI4NHrenHvtnzx4F59V3KS1TUDGXTYPOv2y
         yP2g==
X-Forwarded-Encrypted: i=1; AJvYcCVj54Ka0rdWIFmXy7II8PXKe9YckAbExdUE81s3w2YcU4CgKjbAAChSqC0YOcrUovk7DDW0ha0fTjtWF2Aj@vger.kernel.org, AJvYcCW6gHKkOjioVFigYDQt9YW82wVOlyYuMhnSBLHk4jFvQPehvFkqK5zn6OEtUcNOLnAwIosebmJ/@vger.kernel.org, AJvYcCWQrxCTW4vSmCUt16syguzHxJc3Xp5nCiE3YnzPlKzfOmKNyTIU13mASVNaQePQ1wvh26R30XeZQlI=@vger.kernel.org, AJvYcCWwkhXp5gBoa0kTkg9vYj/5wtotJfnPD1o5mvryODGdYzLFU4kK3/PCgHfQJiB+KXV/ECMIbjCJe9gd8pYhgVg=@vger.kernel.org, AJvYcCX2wQnvNqUQFi9GtILuIq8Hzte82bEmdtoZgq8w5nNVcuKVTITh3mdnxGf8LzmGpgvd2mAHxcEFb0YH@vger.kernel.org, AJvYcCXWsZaqwLJEIIb3o2xNazE5XzcmMtGbOkGU7/uF/J1aVg1/6sblXo7flmPEkbSPguNA1psZIIUguzHokezPZ0p8@vger.kernel.org
X-Gm-Message-State: AOJu0YzZUqt0xTb/awSvGc75pn1g1gvYIWIcTFe3l7QyO/6eHIhwQOXT
	nBfAwG/C1JfgUJjq9u0gJ7A+Iwfq9VJYIGIMfvMQlihW+QY4g9deu71n
X-Gm-Gg: ASbGnctZFC8tA2xquF/TXN0gWwm0YluaD+ZH5UQnDJfhP4AkyOmI9T6aaWDXybvEThL
	PC5PIhBm7OFIcZdJOoIxuKdldpsUHZD19PMUoZXKOSv/2Lzy85nkK46/mK4OUui8fg3lKAmy3My
	DXocSurPueIyHMS/ZU+m+UzAca6vpJFECeTuSwjTAFlqaIqa5Vs2VJL1x0pt8cgDibc9EacQMb5
	p0HcrrkL/Jd6TxnD6bVQ41WNJvHv6kTwGjLta7WLZDWBvSxhyi+uS5T8u90Gsp6VwxGbrzcomo4
	+Y91PqycQL64PkBHpDBMS/vByFS1pVKo2jIz+OaaIeVqrfTIelBKwCRfiJbq+vm/Nl0MlvUXTeE
	lNdS6AqiOTJ4LUXOvLXkvqfr31cCnbqPi+Z04e4jdbATJ4sXSONM4D19g0A==
X-Google-Smtp-Source: AGHT+IEZT0LV33Q6DQbefaNVsGB8GYGSEeK4kHm6ZMgvwa0sTSDDmBT5zSbLXSeeqNjRnCo2kdZN3Q==
X-Received: by 2002:a05:622a:4392:b0:4a9:ea06:2a72 with SMTP id d75a77b69052e-4a9ea062b54mr5964841cf.8.1752091152196;
        Wed, 09 Jul 2025 12:59:12 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949faf39sm103584281cf.28.2025.07.09.12.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:59:11 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:58:59 -0400
Subject: [PATCH 09/10] rust: net: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-9-fd793b3e58a2@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091133; l=1114;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=LE7chWeGOaOT5eDKRrTO2ZAVumApkWzjr7E2NKjvPM0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKS983yaPxR9p4IIKthNUcVC2xw6BuUaT21i94/ah+kRZOkxvifboeTbkC/emsCbdJdM3ovFihB
 nHaeAr7K3hwc=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/net/phy.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 65ac4d59ad77..c420e5ecab4b 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -505,7 +505,7 @@ unsafe impl Sync for DriverVTable {}
 pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
     // INVARIANT: All the fields of `struct phy_driver` are initialized properly.
     DriverVTable(Opaque::new(bindings::phy_driver {
-        name: T::NAME.as_char_ptr().cast_mut(),
+        name: crate::str::as_char_ptr_in_const_context(T::NAME).cast_mut(),
         flags: T::FLAGS,
         phy_id: T::PHY_DEVICE_ID.id,
         phy_id_mask: T::PHY_DEVICE_ID.mask_as_int(),

-- 
2.50.0


