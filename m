Return-Path: <linux-kselftest+bounces-36860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C55DAFF253
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A3F1C84D81
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAFA25B1DA;
	Wed,  9 Jul 2025 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NimxyE+K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365EE257435;
	Wed,  9 Jul 2025 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091145; cv=none; b=fNnIJpcrirZtVbpUiHWpTn886Mz+X2kb/tV4MUEoVLEmrzxAcKpMd+4bmddGQp7n6Xbls+uP9pXmrMiIZLdMS/Hc9nJ9+obyGv3yHWkn8zePQ3t0pex2ku0gqy5jqppiUQCJOO7ymjQ9re9BKcUEiJfXqUmsqAzLj5V0ehDKl2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091145; c=relaxed/simple;
	bh=8SLUJN0pArh2Xs+AQVqqPE8Jc5PoXiouAMCuU/gx6NM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ugGmuxyZBDpBugPTVmE0aqTYl0ngWmNTMNod7ooDWsG2dg3AeEbszSqBYGao6Yedf83tKy5sVBCHRV8ipjaIDeYRvXrk0AQFhbrGo7KUuzp3XPHZDWPezZkeIk8O1lB3J3QNqF53+ejyE79+QKArO4blu9lzWbzgwweForflAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NimxyE+K; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a43d2d5569so4290831cf.0;
        Wed, 09 Jul 2025 12:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091143; x=1752695943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5mRJS9jwBBQiiJK8S6oQ+6p6RP2uXIAQ2P9j2lYyYA=;
        b=NimxyE+KvqnDcJHw036gxT/4Py92OjxYzgu1YEcNDeIJMbUY0jokvacU/ME8bihzoV
         jBd1GSJy1gUqjp1RVtuNM04LDj2//gJ43ivVbdFJ+gv3b7cfB+8zL2gcfqIb/U6qPV5M
         mGPyy13lEFvq8fv8geE0I7EMi/LAs8lpyimasnv38me9N69CsecxswycjccSd9ioryWx
         00fX2BAJjnvJAyOqQ8KMo4UmiIpbyZH9RqZ53CU6sMRVkvQO4ERPvCS6yw1D+2Xmkt6p
         uPXhKmNup5FYiDE4wA5O/iT2ozgkHAqZLhzCGbdjXLGWpsHRNSBGtOYcTqaTFz7V+4tG
         3yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091143; x=1752695943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5mRJS9jwBBQiiJK8S6oQ+6p6RP2uXIAQ2P9j2lYyYA=;
        b=gt3nShnwXJnY0bNcvZeYHelFtPdpgQQEPmxjhRIwTaklJCti6MjiPokq6K6XZOTAJS
         buEkOxG5Xnb5OCzmwfJJ+0gYQHkjKhG0Ny9qfN4HU1EcJlVtFxfreM9BN9J6dHQzJnE1
         rpdX46SedHL12A8dwSNHeGEYKZrBcZnuh3n/SI9SLj5yuSKdSucuv3apfYMfUqa6JqPG
         nnx2lPlLI/SS36F2tHyJl1XbQVi+PeMFQoUHDnwHFcNJ08F6oRWHMTF9h5HpvSKouLcC
         K0dToiP1griPtb3tsyuPeQppxuAOa8npXA81PK2sG9DYGDl1B3dVs06aJsx4NB1Eieck
         r4LA==
X-Forwarded-Encrypted: i=1; AJvYcCU+6whv1qZFPNM/FmHBIK7O7oKuWRZztNjP5HNqL9Ber6eJ0jsuHYJhz6g+TBZiAicImozYqMCxpXJGFRZP@vger.kernel.org, AJvYcCUUy6AcXGmyN4vBArxTkp+ssTRumLV5isLOhG7xqr731HRkMgUPkZ239aTe2nTjsh6QsGpPEz+xsA9QpYYkuc5u@vger.kernel.org, AJvYcCV6pJUc8ZibV1XW5T0vFRFX/3huWYeXYebqKxG8pYSv42+VlKboRMUFUh4GbRkTYaFhu0/Fz0yr@vger.kernel.org, AJvYcCVy++UPpZogmmcvHnO7mwvQGvBB00zC1tL/l+tTYB/Lg4O7m5ji/Hg2lflKh6DP2FycROKDVcus3aeAjfOQZb0=@vger.kernel.org, AJvYcCW2rOaN+hcxwZPpoaQMEqk0Gxl7H+ULl67i/QFTyNixzP7I6KIu89pQlduLZ+2X0PhoH9ZUWX27q9Cc@vger.kernel.org, AJvYcCXyROy28i9hYuI5N6jmu3RELZ2HMeVKM/bCGfAmi0rE2V6Nj9baF/RcRT2gQFe/D0KMIUYHrM/Z8BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDj4xW4zsrouJfFjyPhoO+kVz4UTmJTsintoio75ytVj4jX5qk
	rbyJp5MWeTtcBcE4PwmyKX1i4zlz/V+ADbvI0fZgJVWHes8wF7STVZ2r
X-Gm-Gg: ASbGncsRSD99zUBpxnVUOhGudCue66uBqCPBNDDDW+42bV8gFRm+n2fIFPVmJNAnSs1
	F2U/s7IARNVrX0/2qAa1/qOEJTYVru1udRlzW8PI89Lkc+/gAKHbdJxInfC6rDXYlvzTK9KUvCS
	X8LyxLQGTe54FofGMGLqcd5a+rjv3EWVirrzSn0n9gYKKnzWYnpVUdMpSD7D39ORYScd4fn7RjT
	Ym8/JyV2kpkqYy59/Wrw+GRrTFl1mdQh0HsjM49XHFQaPWThLmUxE2NXmADNYODvD/Lf+sB9wP9
	NN0oP5PNpGE7J9ZsmfGON/B7GT6vrsUUAzXPx4Aisr3hho+IJGKaC6UYyHDvwu2X+yFuWEw4kMr
	JUFy4J0g7WfQab4jQCbg0IvIqaI3c6nO66uG4bIvg7pgw1IEuqtcHZoPdqw==
X-Google-Smtp-Source: AGHT+IHPG0BkuA4fRyqkWvUFt+fQGBTJDG5YObg5b61MjaAceFFFgjhYzSJ2Y03ODsdmoANPGTG2oQ==
X-Received: by 2002:ac8:584b:0:b0:4a8:182f:d7cc with SMTP id d75a77b69052e-4a9e9456737mr16555181cf.44.1752091142850;
        Wed, 09 Jul 2025 12:59:02 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949faf39sm103584281cf.28.2025.07.09.12.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:59:02 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:58:54 -0400
Subject: [PATCH 04/10] rust: cpufreq: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-4-fd793b3e58a2@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091133; l=950;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=8SLUJN0pArh2Xs+AQVqqPE8Jc5PoXiouAMCuU/gx6NM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCSBBvB/Qdo7Tabh6D/Y/ufMXylmO/k7x1977vxiUWt55E2/ikWfKj7Ba3FEfs+ERIT0lcS7Wu4
 2oBqr5ncIsAI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/cpufreq.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index e8d231971276..71d601f7c261 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1018,7 +1018,7 @@ impl<T: Driver> Registration<T> {
     };
 
     const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
-        let src = name.as_bytes_with_nul();
+        let src = name.to_bytes_with_nul();
         let mut dst = [0; CPUFREQ_NAME_LEN];
 
         build_assert!(src.len() <= CPUFREQ_NAME_LEN);

-- 
2.50.0


