Return-Path: <linux-kselftest+bounces-36872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5E8AFF282
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54327BBCE0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA452EA162;
	Wed,  9 Jul 2025 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhYVcp57"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546712EA156;
	Wed,  9 Jul 2025 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091222; cv=none; b=uEK6mU/O2b/uLF0wZvHssvhF7VPUff2xZqGdYYZRoLxmod6G91rKIWMnX84UI8nYAvmIAnzaZ99V7YutFXT5Nfs0Z6zgOClTaRyy9Ue1rX9qVeue+glFj8aE8JFeEHZb3UWXBnxiQ/HpIb+niqvofTbEYI6IujPQ8CWOpY7rTkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091222; c=relaxed/simple;
	bh=E3Jjshiy+K/bIk1pDUs/GKMZc6MgTpr4XTzGbCjUqjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wg08YAOpdpeC1g0TEuUEfeZOT2k5LDiqDM5plLUNSHbmkuKR9T6EHsu/ycdeleYLzbO3dJiC7RIsjGANHGX2RnuqO7MZ5esuwDHYTFRk9yTnkfLqdxVJM/rUkB9eo/dIioNduD4dHg2BsnuPxPxjUwn87QQcjp21z3zruInPVS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhYVcp57; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a7a8c2b7b9so4364081cf.1;
        Wed, 09 Jul 2025 13:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091220; x=1752696020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9gvM+VOG4hue7s4Ky/lEbwwDLRMvW9AGJejchy/jOM=;
        b=IhYVcp573LnJYU2UeXyKhtS3VD6M5CEvQ1uTMwVMdL/iH5hcF1mBZIFpVMGtp5qk7U
         AOrEi++RqjF/JLc30exrOkRsDiJZneAssOKQnbfkCEGZW9+eaOd1ufL1hwuOZQPeBVr/
         gNhiKq7m6dFw1uxGXAdA8X+ALSa7npyhf8bJ5HkTYOCIyNE4QEVHdaQePGes+7wu9mHr
         Odx+kXvjCLSprbWSm8rXtcROSe0i+TK0mnmN4SVhef6Gvrt/uT3tZaPhxS0XEsdgN89r
         RtB0lWwL2BuQjSF7lOd0QYOTqdAv6soOWqKlyZ0SGOQmb3duvehHBI1A2Op3EX3ifKLS
         HuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091220; x=1752696020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9gvM+VOG4hue7s4Ky/lEbwwDLRMvW9AGJejchy/jOM=;
        b=ezeg8Nyjt4X6NuY1p2RFOK2enhoKW3fyF00G0nElf5c9vz7/i96igzYtJ1O9L+dMxK
         IGgIUCC/NFS4gvb2M11kpeoL/DRpkJ1cHu6v8cyCyonIux5/V9uZ3ZqHXNybSNNqfOPK
         Ldh8N6QGkJBJJhIRbbOjSU6Ei6hXJVzl4wXbyW45eaYxF0ctrH29741lJryUElCrsno6
         M1TUzmLzqMsE+27lRS2ON5K6nl9/PpM/ZiN66YY5VP8GRltKr4gADhaqzjH/V0tl3kh4
         49yOgVKfhdu9cAKHLLDH9EioVEWum9jEyKnaLCKS8YkmLNAEQaQlJZpZFtd7Oid4ypik
         qv+g==
X-Forwarded-Encrypted: i=1; AJvYcCV9ozhmGhv/Dx+gVmSBVqEd3nvoRxIgjrgpLioGeGn6bgj+sV3Qs0vPHITKZYFWg/+tEtfN0KccVuasQlhojf34@vger.kernel.org, AJvYcCVLPNJXoJlpTRf8z88aacBc2oxFIPDLGlSLfRylXRbSmjoJcE0rZp8j/kNw61pa0T+0di0IaGU0v6qXwQ==@vger.kernel.org, AJvYcCWVntVsokNrk33ICwNht96CGKGC43d7FkysgHNjaeJeuQG5jy2FD+PY/HRyDnG1NKOItexpQRy74v4szocA@vger.kernel.org, AJvYcCX5oVIPKNyTyht3sh/kkpX8KD/3DWS9UyAlYQDIAEWbvQpyA8JgHnEeDC4nUXqarv/uQUY/nLZ2GVkEqEvnuTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLlB9vFZgSvBPA/xoERyvOzJoL1jdy3gDnTo9dU/hrZn6EEBZK
	VUAAEZ6fD7RpiCaYu7iatmHI7ww2CwElyHJrNVwCLwsmbWbKylt0+sI0
X-Gm-Gg: ASbGncuMoIj3bwh/9yXJcfLPWi/RE4kd5ac8+R7yr95KCk4rCKcZKRbM63znVjFEGAT
	5+dLOY6hh/CyIW2iR5A7u2VYXVVMBw+23GwjqMtzj2vtwqX8VTAmGUjL/kxsRPE6iAQSF99pemL
	uCNdLK93wqaLesheRmeCwilSh+XHHKZJoTYqZ1uuMF2NJVkHJ4fgbYFPY/OoyFwOxt/B1Zr1P0H
	H7n5RQsQYtW+Ae/t6MgSDzHc6Oduut3iLhXvQnce3Q1k+9uWTON1TUR+ux/ySidH9FoNfajpNVG
	fr6WrtiOxd+xNYNFGDE4QLqpKB6K+KGmHkntvsDljcEto02MP/qbpuNweYgFzvRY52vwntKeRLQ
	C1dhry+8tk/eIUSeQzz9fa1CLwWcxqgTJ2WNZqDfzgjxM+meWKF5X79e/kA==
X-Google-Smtp-Source: AGHT+IEV3uvP3nZlQjYExvZaGVVAc/eGjPJZ4wwKG9Phg9SYpyUxlFMrIHpGAIniPkyndQlSY8PEkA==
X-Received: by 2002:a05:622a:28a:b0:4a6:f6e7:7214 with SMTP id d75a77b69052e-4a9ded3181cmr56018751cf.40.1752091219845;
        Wed, 09 Jul 2025 13:00:19 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e4aaasm100432891cf.3.2025.07.09.13.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:00:19 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 16:00:05 -0400
Subject: [PATCH 6/9] rust: kunit: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-6-64308e7203fc@gmail.com>
References: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
In-Reply-To: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
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
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091204; l=2424;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=E3Jjshiy+K/bIk1pDUs/GKMZc6MgTpr4XTzGbCjUqjI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMGCaFCwAxttwkIFLhFVYbmjGOfUVK9XNbhkbODW4/2lJ1th/MtbuO7FDjHiYWnHNdpL4n9Dn9F
 OTwod4TQmUw0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/kunit.rs        | 8 ++++----
 scripts/rustdoc_test_gen.rs | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 099a61bbb8f4..42498cb93f33 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -6,8 +6,8 @@
 //!
 //! Reference: <https://docs.kernel.org/dev-tools/kunit/index.html>
 
+use crate::fmt;
 use crate::prelude::*;
-use core::fmt;
 
 #[cfg(CONFIG_PRINTK)]
 use crate::c_str;
@@ -74,14 +74,14 @@ macro_rules! kunit_assert {
                 // mistake (it is hidden to prevent that).
                 //
                 // This mimics KUnit's failed assertion format.
-                $crate::kunit::err(format_args!(
+                $crate::kunit::err($crate::prelude::fmt!(
                     "    # {}: ASSERTION FAILED at {FILE}:{LINE}\n",
                     $name
                 ));
-                $crate::kunit::err(format_args!(
+                $crate::kunit::err($crate::prelude::fmt!(
                     "    Expected {CONDITION} to be true, but is false\n"
                 ));
-                $crate::kunit::err(format_args!(
+                $crate::kunit::err($crate::prelude::fmt!(
                     "    Failure not reported to KUnit since this is a non-KUnit task\n"
                 ));
                 break 'out;
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 1ca253594d38..507d36875196 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -201,7 +201,7 @@ macro_rules! assert_eq {{
     // This follows the syntax for declaring test metadata in the proposed KTAP v2 spec, which may
     // be used for the proposed KUnit test attributes API. Thus hopefully this will make migration
     // easier later on.
-    ::kernel::kunit::info(format_args!("    # {kunit_name}.location: {real_path}:{line}\n"));
+    ::kernel::kunit::info(fmt!("    # {kunit_name}.location: {real_path}:{line}\n"));
 
     /// The anchor where the test code body starts.
     #[allow(unused)]

-- 
2.50.0


