Return-Path: <linux-kselftest+bounces-37660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4034CB0B26B
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B9DAA014E
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A06E28AAE3;
	Sat, 19 Jul 2025 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/qjclBn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5228A409;
	Sat, 19 Jul 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964942; cv=none; b=m2pLXH3F8/aNe61LW12tBtEBXrF1PiB0uvWCfI0bREQQjYQNxYX1jGqQDiGdcs6DO+fNZKxCTJmVcVqXgZ2blSgKTPWK0dWr6vc+xP1YRrCrgAb3C6d6DudhYyD3bYLaQ5h6aAo/9t8R76r7yitSoKXiqxytsQ/xjJGem+i9PU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964942; c=relaxed/simple;
	bh=gHz4toQCU6anYJFOzHxe6eDUDf8ThYIsMKIWmLd67QA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XX7qUtCa4q4OHu2n67n/aAU9VG+iU20+scAvCQPTNhhpeMM4cd2SXmrHFsuqAYk0e1YHgnJcv1ly/t7Rz82hv+a7vlIczM7Qb+CKbRqle7fyys3h4moIXW85lant7H2zSr1bAXgcXNo+OPzMoZ1qqcmm2nW3JUjwvPoJxKKCuFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/qjclBn; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e2c920058fso417370685a.0;
        Sat, 19 Jul 2025 15:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964940; x=1753569740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZcvS4JIeKOz3OyYrU6VSPD/RKPN1X8doP0FytHrmgA=;
        b=H/qjclBnALVYY/UuMkoiQ1H5gWJEpp98GX7RvW6vqDxiXC5GdodpI14KBqPcWWCWR7
         shCA84YAOWgLwRXa+zzx2U6mqLg7Hf8WFyVOmdX4OzIANf7Wd43udK/Eu7zJECZ8FQ9t
         5z+2+lhXBeglIWzFStQ/q10GJfP9j2Mg7Hj/xYbi1pfQeahbI6UzB5c1p8JrrtFEY+IE
         pjtyLv15Fa/IQybkZx5BltJ8T0jWHzRpG4B4K6laSdcwxAMCDybLgDJSoDzrAtMP/N56
         A47WxGd78cRSwNuLr5XvJKOq6RDV1gPQeavRNyM6FDWpHsBu2Xoy/Yx+pTswcA2fxGUr
         uaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964940; x=1753569740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZcvS4JIeKOz3OyYrU6VSPD/RKPN1X8doP0FytHrmgA=;
        b=qBMeudAQscAqe0JnJrBD5B7Uf6wSaZ1Aiv3bJmYSLvPawfmtOhKSNZEb+9GPpgvYWK
         OXbnjfSIHhDCFHmbmDTef3APgjXj/hM1rvShUxI0btWeCklLUjiBGkbhwrHdq7jvZNL0
         tPnkmyLs1uKAmnFy9XYOxSszHuwrN3/BBvAa6/YFJRr5p1lnTVpVoe6txE0Vw4fxmxZm
         w6GmyCwOGzlVf1oYHeauJmF/U1ar2pDVOZvVz+yEX/dWIpaDEjeVWck6X6WoLhv+mSEz
         2UhiKjx8paQbO89kaff4Ys5kNxBogGdQ3stZyX+yRmhUzfYKHki5hTQz9Ys62GBHrqaw
         C4QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp6ITHHrPCeg1KCcYlDwJRxwRhuz9R4PgxM34yfOdF3TLkmJ66JNzo/awWR5D25/otS6XUoWuXFfXd0niC5sM8@vger.kernel.org, AJvYcCX/YMOw4++zCNK07O44hB7b8Qo5DHbxWSZtJs6SGYynH+BXof5FpEkBeeO2FZ8ZIEkDDqo59J7qh8QD7fFM@vger.kernel.org, AJvYcCXdkdGkbNJhrl4CcT/XUR6ztwULGNnrlVTbhCAVNz1OX2Juh/7iklP6H6EJ6qHvhHHV4scJn/z2nw6mZ6VH/uE=@vger.kernel.org, AJvYcCXxSBY+zIrmP885UhPow33f6KUPKRAS7jnWLAG05xH+Qy+LYCluOHgvVlwUVyZ+L7HOMY+EcPeKGUmCtg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+Fsu6nZASvXktYjcB0abird69vLp5lg2mM7ynFLAzh4Rt6xx
	U6Mxp2/Frsy7av8bkJ82603E9eUit+UT4FRRk9Du6kMIBgapWl/wJ0hw
X-Gm-Gg: ASbGncu6Qd+9r1/X2NNxQe9imkEpiy94Pn7jeBLsYAEVGGuaOKZ/sd/Hyyg5G/oMYjo
	WZ4xTqeEIuOdUpM6GaldktzW80g1VxQszn59PGo6F2Eb8cR7zztQ+QbvMlNz3CwEnMRdMgBtugZ
	YjtR2AclF1VLwQqu59vbzOImOJov1jRVBwobOGmBU/omD6rhiGu0yKibJUIRPs+In72WC++wtoW
	FFevNBPkbZP/+ScOm3gJrSBYlgtx4n6LTnd4wGZQE6TjgkrGGuc5NpeWU+ODUUoP0gpfJnHeHch
	TFIvnc9XyxVUqI8oiPtQnAdq1LZ/jPQH7XVEP/WLucpfwytA0SI6Uq/Hb9rj53JjW/Pb56e4mCV
	+GdrZEsOgA2YEErR7IPDrxB2z8j1YSgGDXDw3i9XBlzPhIonGT1lqXWhXBgKfK9YyasWGcnoNGK
	ThkC6xHECAKXUj+l23WquOZhtmM3jzt6xWkRDWTmg=
X-Google-Smtp-Source: AGHT+IHV2N3qMrMs14RixVMrz4N7FPqczHbGPdgP1qIFChDpfiZUqiOOYjpmsvCFrdcWFOVKjkhmCg==
X-Received: by 2002:a05:620a:2307:b0:7e3:328c:b7eb with SMTP id af79cd13be357-7e34d25445cmr1248059085a.21.1752964939622;
        Sat, 19 Jul 2025 15:42:19 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm251550785a.84.2025.07.19.15.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:19 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:41:56 -0400
Subject: [PATCH v2 7/8] rust: seq_file: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-7-1ab5ba189c6e@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964924; l=1715;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=gHz4toQCU6anYJFOzHxe6eDUDf8ThYIsMKIWmLd67QA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE/CoWxTuDiUL7P9sRtLudjxXtE9D5paPxY0RwUT1Ot1C5eNVZBHb7FvDXrP2kLzdXk8G/yjl4P
 KRF2R/+b7PAs=
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
 rust/kernel/seq_file.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 8f199b1a3bb1..59fbfc2473f8 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
 
-use crate::{bindings, c_str, types::NotThreadSafe, types::Opaque};
+use crate::{bindings, c_str, fmt, types::NotThreadSafe, types::Opaque};
 
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
@@ -31,7 +31,7 @@ pub unsafe fn from_raw<'a>(ptr: *mut bindings::seq_file) -> &'a SeqFile {
 
     /// Used by the [`seq_print`] macro.
     #[inline]
-    pub fn call_printf(&self, args: core::fmt::Arguments<'_>) {
+    pub fn call_printf(&self, args: fmt::Arguments<'_>) {
         // SAFETY: Passing a void pointer to `Arguments` is valid for `%pA`.
         unsafe {
             bindings::seq_printf(
@@ -47,7 +47,7 @@ pub fn call_printf(&self, args: core::fmt::Arguments<'_>) {
 #[macro_export]
 macro_rules! seq_print {
     ($m:expr, $($arg:tt)+) => (
-        $m.call_printf(format_args!($($arg)+))
+        $m.call_printf($crate::prelude::fmt!($($arg)+))
     );
 }
 pub use seq_print;

-- 
2.50.1


