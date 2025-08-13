Return-Path: <linux-kselftest+bounces-38881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4007B24E47
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F251C223B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EBB29898B;
	Wed, 13 Aug 2025 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfjBS0Vh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF8A2868A1;
	Wed, 13 Aug 2025 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099739; cv=none; b=YEzX8yckBL+OSJflUcyzJCFje8mRoOk0ryqAUdeBHifjkACBEHVZuwJcj+vCy9whwnp4awPkGTOiFwoOmsmafx/X87GJA7tremXXoVP+2+/4paMR20a+XuHR1S6oICgfIOIS4JQch30LMRjeTu9g154IHSfXOzIIthV4hQB6VW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099739; c=relaxed/simple;
	bh=Jy20RMjEgUasphU37v4mL3N9otH67wOqCSEUfHDoaEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mYiW0572FduwKzuSYmkKQjlM1n780t6VOPxmcxNAtTvKosr/8fx75wcmbqYtL7gZMtA5UFislott2IH7fJ48ijSrSlTY2RPegZZNNolHE7ylmJB6hdGnl6X/qM6jBvkTT/TYjOV/TkieJQSPNHpX2AFSlM48t0woN9nKVs3RWpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfjBS0Vh; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109912545so290951cf.0;
        Wed, 13 Aug 2025 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099736; x=1755704536; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnFW2npqKBPmKFjbk42rHSD2L60lz3bDYGogNM7LVaY=;
        b=BfjBS0VhUXr9o225nsUHROZAzfacghxfiULU2qqKuyywHZiKyWs6xs+A7Zaj6afFia
         qRvtHj0Z+LXlRzBsjBGe3bNmmMKmSYcexv0J/6+EhZxVCBprOJpMuRZKKCoPNycDbBx/
         i209WA6y1oLtplaknq3Q4pcqq9g6wbxYnaBsEkPDQqA0WOJMSAsazPSnOMX61S/S44R6
         /xJzN9HfMW7bL3IP7wmxYKNJOSYk7GHxYI3CoeePMIqB9V/mIV3J6xhhUi0Egt6vRkRV
         QKl3MK/jAcxprf7kEhkGV6wE0MQltqw8sdC5EAkEwtNwjEetU6pQB30IB7YMJwkrgZps
         +6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099736; x=1755704536;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnFW2npqKBPmKFjbk42rHSD2L60lz3bDYGogNM7LVaY=;
        b=GRNBQI1rowDw2RRuyNgfxQsCM5tlaV9Gc/vEKgWdKJJQQFxJJyuPKX6JA9Zc4ab5uO
         QTdfX8B4skTOtHR3KKB91fJBXWV2WmW/Tana2mbtnMNQeQPPagNyeqB3ttbM2gsVDut8
         27t2d79ZxDBF/fyEkHkyDb3KgXDlZrA2baABjl0crNjvXitZnqzx6EfpGReJH7XhpAcZ
         nf32XwqIzsT3Py/PgnEIYKa4PCIDoISHhmO5DxYBulOQG1SrVifY7/k2nIJNEVIOkw6T
         hqoSCbhSgn2HQj3+hUOAQ2EkFcTN6KSaqaku9nGBoW6aAlWmwOULBH9NbN5IZsJcsfFP
         peEw==
X-Forwarded-Encrypted: i=1; AJvYcCU9XGHGygFOgoZkn67UsdQGexOk9MaHn0ytQmUOAZsmpTpOSs0QSv0ZYhDfIInidbHPw/wcO5uQ/Ujk6Q==@vger.kernel.org, AJvYcCUMr4RBVA99SZhMbQe/vX7tKc+cS9BV/5t38Xz31xj2s8iSY29hziR4OrGFjTMEuGxoDcEaP0BS@vger.kernel.org, AJvYcCUdUtzawcWqK8yHy96M7OZm5CQPMUqx9hXV6xFki7y9yniRe0ICysQAQ2XydbV1ibijIFEpokwA/Ny3@vger.kernel.org, AJvYcCWUeJsLdp/niY+7YTrz0Zk+3HqSpILmbTraNuqR+VNLUtNw5gVyILpeuexK1WLu7RZFadi6fKh0chQ=@vger.kernel.org, AJvYcCWctTOxlRDousmzV3F4plWzXHqI0mzc+UHNfsHu1zlEXhe8xw8QVddJ18ZotYBI0rPRYggmWXx8/OIkFJyq@vger.kernel.org, AJvYcCXmaLGQUNJS+SoUvttFTB1yJI1Rwu16LQQGKaCBwh690oktvtACsi52HRjJQ2h6rOLkQJcgr1U4yLzLJdhSJqI=@vger.kernel.org, AJvYcCXo2cjdismNmOuc7R0FI0pCpHwuSPrt1LrMFZgdt0NU3pe5SyglIBq/We+DLAoQTcTH3v0ynJnY7iaHBFHleneM@vger.kernel.org
X-Gm-Message-State: AOJu0YxqxhwKQMyiAE17jwfjpEUm5lCLdEUt89wP8m+6KBd6m/SyllF7
	c8qoxMbEu2JOb4DqoEuG8dcLL2F9jwAx2Vx3QGltGTMmf2O6ttDJDhnT
X-Gm-Gg: ASbGncsQH6aSIe0kVMt3OCxiV55pEmWmh2/i82q9SLs49hxt5zPuakPvJKrXwXfcD54
	tAw80ksafSQS6eDTlU0zOtdAV9d6aJlej4SbgTdtSlSAPrBLCK2Wg//2DobtSz9xXiLhRwDUAZm
	98VL+iD5dS9U8E7OVj+V8eoXoAguWRZYVd8pDdN2rCRQcnQZkH84Klid64jm2m7bTVKCgpZ0Sgh
	pJ6lKQndo5/3o4iPAsoB6MgZdHlpClUekWjo1/7ZqA6XhEcAzr7fv1gPyplgBsDeBidoytBrG5j
	8Ne61cZvvOkr4P8rn6+70ssGUVPXA2CCCaT184kPuja02rQTW3i/p+b0qWDOl7QEmQ7tcCAhtL9
	OLvQODosuRX6RUf0NMCob6tHQY57bz0L42Q23WdrZvCnmbRNhWn1dkgJ134sW/Pn/Guqb0vMSWp
	vF3tpkz/ORJfhx4ZAC5e6IxzCzoOcnV2pjn/zssxPBFCudynTRHCH5c9E=
X-Google-Smtp-Source: AGHT+IGst0K+bBIR1JPA1xxoo3PWJCWm9KLNl2+l1dIS1R4SJG8m1vtEDh/5FFkaiXywh2WmF6+IQA==
X-Received: by 2002:a05:622a:8a:b0:4b0:7f2c:b27d with SMTP id d75a77b69052e-4b0fc7589bcmr51851161cf.22.1755099735338;
        Wed, 13 Aug 2025 08:42:15 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81bc7a1e3sm1180019685a.74.2025.08.13.08.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:42:14 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:41:58 -0400
Subject: [PATCH v3 07/11] rust: kunit: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-7-545c14bc44ff@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099715; l=1753;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=Jy20RMjEgUasphU37v4mL3N9otH67wOqCSEUfHDoaEc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QK0mI8nizkbrqOlHVa/VZhAD5k+yfK1PeJ19bjxmLttJOSY1NKjCbDi2AQMIgqX63yg7JVa2YpU
 JwmcNQ286qAo=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/kunit.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 41efd87595d6..5866cff072f9 100644
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


