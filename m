Return-Path: <linux-kselftest+bounces-37669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A618B0B294
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E4B17F9C3
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9728DEE8;
	Sat, 19 Jul 2025 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhRsjEeQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0DD28D8F7;
	Sat, 19 Jul 2025 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964974; cv=none; b=Gu9lzbGyuMmDEEI4SC7i43XUBErduZpB2+tCOeyHGVbslWPlmyCdAxEhe+2tH2sgWVR/YGObDG0NcsEKR+uvrmdEqNjxcFhFT9qEIb5W2ztnk3xvpkDOpm4ybOAQ5v2B4VB0ltydKRt5/omovt05qGp8kdBF5kj6i9UMM/j0Zac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964974; c=relaxed/simple;
	bh=csKsHCFbalTxJs2cYRiqc+aWsYXh/UqWq0VHOjKXa4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJYD7flHcWb6Z1tChe0s7tPj+E6mQdQTIUgvd1ZM+ag2jPFZhuF9f3d/rvtDSnIGuc1rduNxxHoAYIjW7G5Zjivf2+zOj9jj+qNzYPNjxE9jzuQWpolD5GKncpEq7YArwMhp/Mgsqa54ko6yY4Dgg+iPxiT+4J2IBA9JkDObKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhRsjEeQ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab6e66ea68so43304641cf.1;
        Sat, 19 Jul 2025 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964971; x=1753569771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVwZZ6Mo9+UIM4MULp9oEI1KWAAVmyUYypitaepCOB0=;
        b=LhRsjEeQKPvONJbUwuD82NvnL5LUBVzh0+RiuUYt/CWSKtJ+pSnBgQtuwegtuNzGU9
         IXh5Ip4Y9vrFVW5UIUQlXF6MoVCfigWsULfrFCPJ9VQ8KDD1HoVdj8NeoqifYhlPQRV8
         9ByKdJTHRXURG4+CADJnuWbrws9BXvPuNbN7Kss2OOugs/yzQV2PrmrNVhS9Mn46nWRE
         /OXyaNnVCg1Hb5mJUjWYdM2F/N0qDWh0wE+13udWbnKlCaXW6BmPnAfEBeKvDVxTh06L
         OjOhmq4b7ssvACD0XQxu6Lw/P3OOOxJ38AHs6JTqik+pVwzlSjsFTWiZmk6DLjyfJReb
         0ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964971; x=1753569771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVwZZ6Mo9+UIM4MULp9oEI1KWAAVmyUYypitaepCOB0=;
        b=Dq/MbxfOUSkOu7EaT3SQOJD0Z5naFkfuBEcS1ZdvxcE2NgFuO34vudx/sjvjO5uF1h
         OxRbm/Ykm9O2+InORl+yl3/Yb1L5T2EIJ/73rB0HOvAzJGsT5Jb4J94XfP/ChGIpez4z
         +nhdrjgqw51J+OiIU9PybgfuTaL4VHFf9MJ7U18XHyajYU8Vhnih2seqBehtcopTCFKq
         7GXhvauX7iOzXbIanBoyqF6Q/HlgxqVuOhf5JZi5zKFOYVYuOhnQRQCA199CyR1Vesm2
         HUmKmt5RZNLCyna4FP6YGKkz5REvOwlswGXcgyQEoiuS4SYd3bKcIEZAfZomPvdsewSr
         /e9w==
X-Forwarded-Encrypted: i=1; AJvYcCUIlYrBt+E0K/P0VtI4SrvGnIxincpViMZqv3GWoHFQ2G8MIgtte9E5E6395c2m1pwEk6R682zHinJjcGjNn5c=@vger.kernel.org, AJvYcCVi0h/eVcLhaYB3JsnNLEvZ9yatxAohWiVMh+B2jSxoqXoHWDFdD4ZorgbwY1jeK9ba2Sdw9L1PzdRd@vger.kernel.org, AJvYcCWr0S0x12owhf8uBYnKh8p8U+AIwvVQCCXzTUkQZLpRWJjIskdKtt0jwVPH17xNIfOKEy+WpRt76HVKBpDZorPz@vger.kernel.org, AJvYcCXCFW7qA9hHwHPmlUJ+fhGsgUxZhw0njIW7pQRXY3e5SdQvDDv960q7RD0mRmcPio13LMhcIGqk@vger.kernel.org, AJvYcCXjFtN0tmVNxQDypiwnUGxIPsl0UcuWH98biiCzekE5X6wvkWBeQDRj4Hd142a/r6+7iV15J4L+/+bIbB4v@vger.kernel.org, AJvYcCXl1kPIALBq7MMvcmdRMAWwaPqEaxpuhx40BKn4uJDzDfHbGhQ13aUnlV/qEcaeelWxbaMo8NliUPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsGC+2jGBc1TAeJr71P2L3f34LopM0jC4gtKIcj3zy/nGrJc6J
	+HZy/BXIn7+2VoiqerFSm4/FkpOJgTOmoQ0q3jxWgNC6dBauHFtHp7PN
X-Gm-Gg: ASbGnctAkQW6cmizN8dwtOTqC8IlsTCcKiqO44ol6wOmmIZm4SUVS78lwEP1MYvRZOK
	/j+oEcmMLDomJd7JCFwxgDZcF+cJnLdVUEw6IUr/yQYNCTncdUUuB7QFQNi8+E8lCS1LpTDte66
	cdqG8OMT+8hSARrg30fF/MM/jikukKoyjhJo3fq+UsqowJC7jKilvgaLQtA9h7gaMouUAlhQo8d
	AcRhQrq7f+Ki2RJYvZwvqrMAREXCp36nylGDG8mgbN5vzCl+0dBSSiHv19+JqgHge9XYyrhPnWa
	ckkcE8eJgwXom3CB/47r2prRnivKmSmN8v/BnoFFAmSBgQAEF2oCF5OW5E6iPeFzhfDm8RbEX+K
	k7zuCuYF4+qgJ6/8HWP9//K//VS2M485E02O4+9C0RoJUJYUATcwoTNp1+NTsknV5pQL2muQcbz
	0ZW55CvLUfC8evXSPrQCt/y9Tj6Vat
X-Google-Smtp-Source: AGHT+IGrDAPhwT5uKgChUAOHQtHYjjVfCjGcgBqOR6dnOpB3dSPlP6wDfXu7rVGYdgsmj8RAJZS9ig==
X-Received: by 2002:a05:622a:258e:b0:4ab:5941:a919 with SMTP id d75a77b69052e-4aba3df1b41mr175208651cf.40.1752964971453;
        Sat, 19 Jul 2025 15:42:51 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b1f1d5sm23671841cf.50.2025.07.19.15.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:50 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:42:36 -0400
Subject: [PATCH v2 07/10] rust: kunit: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-7-e1cb53f6d233@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964955; l=1799;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=csKsHCFbalTxJs2cYRiqc+aWsYXh/UqWq0VHOjKXa4U=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOCZHQE3BNkYXCKJ+RyA32p/mSSS2r3g8aNiyzb0jETg6Ga0rgHtLN1SgqEcI0cBAzwMZUvRsRy
 Exo2ggC1/0gs=
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
2.50.1


