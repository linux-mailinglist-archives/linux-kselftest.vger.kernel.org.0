Return-Path: <linux-kselftest+bounces-38882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AE1B24E40
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318F2723867
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EA7299952;
	Wed, 13 Aug 2025 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaFm/qlv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6428A2989BF;
	Wed, 13 Aug 2025 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099740; cv=none; b=CnZ73+Peog6KX7FQ/dTujz6OzB6XuZ3O7As2OWrohQoWJuIYW5c0gmeH2fvnbIOJiIYCXNuOibmG6BV0Uqqwv1tLgR3PpzxgwbIaurZMHoTMh+XEy1IPX+hQsg3Ik3XOOWCTd/yqdl9kdrbUVowmUGDjxFkAbCky1DmpZR9jSKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099740; c=relaxed/simple;
	bh=g75m/R+Sh3HJx/9egwyo7hbMlFO3MjnMF3dWtcOVjYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Be03+qOxdMn16PJVy7AtHiqP+jts6/oImEOV2NLiJhRG7VzX+y/j7wcwRpSpdB7e/x90w6RS2LUdTEZDq6aWEXJGe6rH+b0sDZ6RO2TYYgP75z8qEOp52Y1Oy+665/DY/kmsnyP9kxi53gVOWiCVVQtRz1TRgNKOZLjwyAFILdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaFm/qlv; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e864a60b26so119189885a.0;
        Wed, 13 Aug 2025 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099738; x=1755704538; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VsQSV1TsJHp2MU2Wdr4GjJINpBOVW2jeex8g0hu/Fho=;
        b=QaFm/qlvcJAIIO4uDEHGxGrFDgQs3fOVxgiz7kfTITPlDAIL/ucGsfGfllDfhn3dhY
         xZNq2PaAgXlNjs0qZOyAp+oY/Z69qWZiTkowQI6a2sZd35PZjEwj7i/9rdKmq3vS8XAc
         /gjnnlACjckvWVT8iaNxHTDNxl5CPEgjhp566wCqPAcIlfJZ0qlIEqmmelMn+bGT2Z2E
         K2w9JjSpsJs1KgQf2j6uqCsCaZtzEZgZzM8Il3o2B+FyFgA1A6cxWbYg7NiY0pZtQ0gg
         qlFCn4cF8Ikb8/xhkO2sntX7vqdQk95jcKYFdZqXnFnB92RyCx2n0J63+wrkJyiWNtJD
         pJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099738; x=1755704538;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsQSV1TsJHp2MU2Wdr4GjJINpBOVW2jeex8g0hu/Fho=;
        b=ANS8bcXh5Sig2oo0iAYQmAonW10xN6+SZVXYnfotLFJSL/Q1/6SKOVWdhR3s7HIGNM
         yHZu7OBMFmZCxymSqcNSK3uG9kj1DUfJL5V7UZIeWxd1S6DI3g3p4khG69mfAyT8b6a2
         Azq1GsVZ3wdXvbV3ijT0HXPFNuLLb2LeB3wofxrH2BTvIroO2uqqqyWbksE3PfvYEMDh
         fm8cMLPSxQ0vQ/Yiz63fTDzyA3OFa46jj9RLnhH0+G4orZITI6cJCpcZZ3/R985zW8sD
         SD1/m2YQaPi+iSNSBpax8xE+v/LDqL3q9v7fWjfPyG6oD3ODZxuwIdUPHbxlXSsNoNVd
         NRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZQhx10AJbeRGQVETH6+AiBgosGx4IVy7t97hG/bzjFVBx0DXcsMQNDUihaaRgn7s9BrFvMmwOQq7a@vger.kernel.org, AJvYcCWULkoHbiVQEatlnxJPzbmeTVokIu3wu9HShuhXz2jVSy4Gg/EmUum47RvdgwPDzb7Mxj+Qu3+GuogbV5gokd23@vger.kernel.org, AJvYcCX/7nJwZ9WvL+SLHK5YsH2XDu2N+EcZmE5vcMngbaJR/e6cgyXmO18j81Tlss1cvcXcThlntTv8e9E=@vger.kernel.org, AJvYcCXGbZVuBicAQ2bfJXnLxh0QrpOP6tNf+EsjHgXJ8ZHoa3gXPtBw3GnWzJ5yGSVH1mFJFshCr2GMfFZ4Il9v8X8=@vger.kernel.org, AJvYcCXMJQCoIItUFhyYm8LQu3zNer4BJFLMB5U+moUXyHXBa3MGrha0UrNLwJ2BobUQANl/tVReAWrgZGr/1/6N@vger.kernel.org, AJvYcCXYucImn4m0qynClyyzKOW420DficTqCUg8llOVmQC3DbK6MJT1PJKMOH7EGsuJNugJUQAZxf+m@vger.kernel.org, AJvYcCXxVlHYoz1ccB1e/u2yCQL4a6nyGpbMXhySa4EbZh2sOGjAEQNWwF1wcb4reqcCv+1M0/bDsU7EZoCeZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yysyo2yMld5wsfhB1uAVBtUotCVBaHJRonm0W7HzW0zXfiJ0Ygw
	7Ruizlcma7sTM+SLLD14GHBqhk9sBLnuTk1D8XcfA2oaAWgI/DFgLu1o
X-Gm-Gg: ASbGnctqkipNQd8u5qS+BcIELtPNhPKl/iFhW82LaaLIgw8O7URJKAUJ0kIRO8mSjxh
	9i3gi9k0Kvpxv3RCpVVKrnDJyPrjrgMkZpA4fs38XwKFDrALS7S3k6fBzO6oYY4lfVPVBtzEs7A
	OazQhafNkaDKIR9tB5XyWmPD9qfFK3tdmX3wIJjoyySOj18uG8Yu1lUeiFmGpmqEqhTK6yTDAF7
	kQUrali2JqPymkCCLEoXn9KuGMHV3Ty80c+U0bwyOI0InJ8VGfcjXNCC39jgo61nB7TBpEIiQP5
	9w72U//Ey36STjlMYPJoVOV2vQvrQSfwqrd4exJeMOyj2NYyMJ37XRh5xxD19a+UKKgRSmp2FsP
	v98HLRzwLZbdiCFlvR9ROP9Fwh0TQqpQIqtXk7NZ1MhbOgEdSyTNUkPIXazDjoOXoVk6eK00IXh
	5pJkOrLvQXWduh2iaHiZX7Hqks+sS7Re9/4A==
X-Google-Smtp-Source: AGHT+IHar27jS0NGlUqrQQodPkOf9R/CEtXClMPngwLeK8GX4mWCN5I6VofPi0UAtSwiPNgZ+ssZBg==
X-Received: by 2002:a05:620a:4494:b0:7e8:594f:d3d3 with SMTP id af79cd13be357-7e86fd3a817mr233185a.31.1755099737954;
        Wed, 13 Aug 2025 08:42:17 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81bc7a1e3sm1180019685a.74.2025.08.13.08.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:42:17 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:41:59 -0400
Subject: [PATCH v3 08/11] rust: miscdevice: use `core::ffi::CStr` method
 names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-8-545c14bc44ff@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099716; l=1185;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=g75m/R+Sh3HJx/9egwyo7hbMlFO3MjnMF3dWtcOVjYY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QORcYxs8+PgEi2jdhGN+iGN1na6Boa7otjXeI3vPhu4m4soJQFoRy8+xvO+XTxKLuuC5OO4cIX/
 esCvjMEqV7w8=
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
 rust/kernel/miscdevice.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 6373fe183b27..d3aa7d25afad 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -34,7 +34,7 @@ pub const fn into_raw<T: MiscDevice>(self) -> bindings::miscdevice {
         // SAFETY: All zeros is valid for this C type.
         let mut result: bindings::miscdevice = unsafe { MaybeUninit::zeroed().assume_init() };
         result.minor = bindings::MISC_DYNAMIC_MINOR as ffi::c_int;
-        result.name = self.name.as_char_ptr();
+        result.name = crate::str::as_char_ptr_in_const_context(self.name);
         result.fops = MiscdeviceVTable::<T>::build();
         result
     }

-- 
2.50.1


