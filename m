Return-Path: <linux-kselftest+bounces-37654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F8FB0B24C
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E9317E54B
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845282874E7;
	Sat, 19 Jul 2025 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPSx9Tia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747C1C5D7D;
	Sat, 19 Jul 2025 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964931; cv=none; b=H/kk+lhrGvRfh1GCULe6mJBfdgRQVJlcxXH2fBEYtuxmoHV0IsQU6w3ouM4Luot0LONeNm2IOQK5nCEGL6VLwUHKQqvAyw5XZNfLTeUUn0wnWuL/ffP4XyTQD1RTLgwrIuGmbua56xpTyVcoh9LCO32DJ/G3DNOvwGRjq0qyP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964931; c=relaxed/simple;
	bh=iDkIB5rvX8tJR4OLhXYS4HL4jEYmtSfHiux6Jv9xhWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uekvHg7ZDrUh0Yrb7ffGHOsgFxcScZFHZISSxPykVB5GHmQB6kq17EajGB8aScQgKX/dCdbGu+5segCGrX2nq2nPf+cuWCnam/SWK4YOoXiSZ0DMD3/KxT4S1E740k1IiCLVCIcNYLMh3BBbK8PgZkAK05e7rdtBcKRcLRoCM80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPSx9Tia; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e2c920058fso417362485a.0;
        Sat, 19 Jul 2025 15:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964929; x=1753569729; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFFgiza+Dl5GdaqwlbzwLTdeCZ/jp+2BcZVRLKHMbXE=;
        b=FPSx9TialU2rcMTHvy/HUT2x1sZ9Nj55A8EWYE1NXnoV1dD07J5xTJWF09RxD10mq3
         vKtn8ihMRS3aeTqqXaIsMuF+DSAHjwy+8oypbPENxsrIeSFaYTx305bQBtvBXk1Td3WC
         Lkl7E8ZIvRzu6oi2QY6KCXWq3ko+IfyWYR8maVT7FFW4LTGxe7uOyBEZLYIMuCfCIXM8
         MoeTJbIgVBz6J7W/j7Rvbm/F0lC8NMqHRyy4B04kBrW4pjAS977xSAq7rtrZGxgBLyUk
         SU+pOd63qw5b228WpyxWnt76sbW2bsYYlCc5AbDtlUt3vBJdKU1TF6f8QjWyU9R9dHo+
         f6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964929; x=1753569729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFFgiza+Dl5GdaqwlbzwLTdeCZ/jp+2BcZVRLKHMbXE=;
        b=TBzyJWFr1WVlT9iGOnfG1E9RuJ3LB+hWXtohRn7wAe+DXnys+ufdt10BZbn9n4ADCj
         ZasLEdJTIW3UafCkYc5QkFgdQhJKlJNNl17WFQgSOju+ZaJC08FzGIDgqXBbYYiPqJ0u
         K8b8KSrQHkAquYNXTccUKjtaLMDQxHYkpmApUaHCf9NUrtmA3kYBnEALK+A1PSk7G716
         D6SyG/Kxvp5czvFgiMhii2vFORN5eJp/oun1P+lVC7bMDk0aA8XjwFHg2UeIv8GbUGGv
         ul0m3yv6JdQz/tRwz1tJz/LOXYA9PUu8vXnGWtO+jM2+JTVotqLRfgzbRA7YMx00mUP+
         KJkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVppMcJvopUqjENCLw08GV7ZtgsNzr+iFs4JAPu3CXjcuqVZjYbWZ4isDyOcXkAwfw0waLft4cWntkmXzar@vger.kernel.org, AJvYcCW+7orWczmfDJxFVWHRufLLAlEiv6qlbKZcmt28gFjzzPOw/CwaHnKWwosE6AG4hdn2/o5CCbdhnAbVGg==@vger.kernel.org, AJvYcCWLDETsMfQtzgIXZbHjU8wQzmEufWo4iPQXlmx0NJHunKOPvkJ3BlSLw7XePgqNxS+p3NW71whK7VXVOU/JIXfv@vger.kernel.org, AJvYcCWjUZdVQj+wiwkyOqR3Gm+3HLCm3AvTAuiIpRmulUzOy7sUhzmh4fb2SXYtVeVDAI+IAXGP6kUfNDtPJIGjs+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqblM1cGJS6IG0xfkG5eVvt8mYZSnAZA+ywuAnh8OXmuP16GPd
	+h2PXNZPuVMfekq4OjmbVnUESUgPqWSLSiKCHkHSZSgxYlCjEzWlLdLu
X-Gm-Gg: ASbGnctKda07KVdchqYowTSLMimXDxAWuDrqunlMopKHGrwh+Cz9W9bmHoU9Dfqsavb
	LOBb2jVnLQ4RUsoGBB/7OFOWt8hvR/LO73xoVL6KkOQW2r1R8VGeWXN5jW4vaT66v58VsbRiBiD
	jijDry2Gd4T55QB3PLVGSpN9H64sl2H1MYlmZy+gfAo24SGCOT7KZtD7RYSGXHGP8+I2veg2HSS
	6mumCkiGGB1VXqDJqkf1Nfd9NULS6uOITS9lvJwPCJPD2Ajb/6iwt2HkxN7oCqLW3FXd2fqi0YH
	vw3fIa4kMfkt6zdVkTRv7nRAsyiI6bg6Q/vqXocLwuJ9fsIh2YfOc6tkaN/EeeXKkfx1HgCS3Bq
	LuOIdYY9ktYUk4rB1+0rAK90Fj1F4LCi8fPhV+9HX3ya7fEampU3icj6xbV7DlkYQgygjWpI1Oh
	m/DmUKUamr6rTk6okTIepM3W2dvT9e
X-Google-Smtp-Source: AGHT+IGidME1gL5I/0fPjfeSylawYS4pDe10fawmQtGosH0orgzM7W+Vd2E9cgU88UEhGWwteFt0yg==
X-Received: by 2002:a05:620a:f0b:b0:7e0:e2d7:e03 with SMTP id af79cd13be357-7e34d11a7e5mr1856621385a.7.1752964928659;
        Sat, 19 Jul 2025 15:42:08 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm251550785a.84.2025.07.19.15.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:07 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:41:50 -0400
Subject: [PATCH v2 1/8] gpu: nova-core: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-1-1ab5ba189c6e@gmail.com>
References: <20250719-core-cstr-fanout-1-v2-0-1ab5ba189c6e@gmail.com>
In-Reply-To: <20250719-core-cstr-fanout-1-v2-0-1ab5ba189c6e@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Jens Axboe <axboe@kernel.dk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964923; l=2160;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=iDkIB5rvX8tJR4OLhXYS4HL4jEYmtSfHiux6Jv9xhWk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCEQK33g2u0Gt1gVO/tbX+OT6Hyrjr11/cEuKmthxY1k5d8m0r0rWBWJTpdLTKfL3Hd05d1yLgf
 tmc3AOoa3WAQ=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/gpu/nova-core/gpu.rs         | 3 +--
 drivers/gpu/nova-core/regs/macros.rs | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 60b86f370284..f1d72da7fddd 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{device, devres::Devres, error::code::*, pci, prelude::*};
+use kernel::{device, devres::Devres, error::code::*, fmt, pci, prelude::*};
 
 use crate::driver::Bar0;
 use crate::firmware::{Firmware, FIRMWARE_VERSION};
 use crate::regs;
 use crate::util;
-use core::fmt;
 
 macro_rules! define_chipset {
     ({ $($variant:ident = $value:expr),* $(,)* }) =>
diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
index 6851af8b5885..759773a19480 100644
--- a/drivers/gpu/nova-core/regs/macros.rs
+++ b/drivers/gpu/nova-core/regs/macros.rs
@@ -106,10 +106,10 @@ macro_rules! register {
 
         // TODO: display the raw hex value, then the value of all the fields. This requires
         // matching the fields, which will complexify the syntax considerably...
-        impl ::core::fmt::Debug for $name {
-            fn fmt(&self, f: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
+        impl ::kernel::fmt::Debug for $name {
+            fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>) -> ::kernel::fmt::Result {
                 f.debug_tuple(stringify!($name))
-                    .field(&format_args!("0x{0:x}", &self.0))
+                    .field(&::kernel::prelude::fmt!("0x{0:x}", &self.0))
                     .finish()
             }
         }

-- 
2.50.1


