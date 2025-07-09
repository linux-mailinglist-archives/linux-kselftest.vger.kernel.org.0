Return-Path: <linux-kselftest+bounces-36869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F180AFF274
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BFC176786
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A533924DCE8;
	Wed,  9 Jul 2025 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBj5CVr6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51D2475CD;
	Wed,  9 Jul 2025 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091213; cv=none; b=NXscwakf6kti1D7iScudEovcMpAfDo5zyzM1FYbJhdYq8cjB2wzR1/GCLRbm1r47OrsQzsC3PvCGdVzHCiSWDwamkgt192OXK0/jSmMLdxQZ/1JSqGUHs1zUKulYd5FmOUNQ9hyF2gW2m2JF1U2iumVbysBNYZtXdT6N0uwLIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091213; c=relaxed/simple;
	bh=3q8XWZjySCzinOtTT6aFMskjuBTX2M/x4Doe4ersSAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mp56QmL72rPzwNwHgxMWlICtd9ui6sFI3SaEmeWzevyHwaS7Xy0ZfJJSYEKXJKa2SFU0SIGkCkD0kZK7J7Hc74eoHSz+McrfyiW3BOl+phRxJb07opWziFncn7+BT3ma066qqvYslPOUQ41Cl2N9Zd12nDY9veNNzMoJX63cFWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBj5CVr6; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a44b0ed780so3306961cf.3;
        Wed, 09 Jul 2025 13:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091210; x=1752696010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVzLXa8kSNeGO3MSdRL/brp+J/B65R+0jBRIcOEDB2s=;
        b=bBj5CVr6vQME+SgEPnn1MVoN75DnR4l3J6mGAmNBFsfTPaWDR1ZW4UVVb1btr0ZTNR
         4VRYscCYfMJTsD3NCQ6a0KsfyGieJ7GY97HqpHvXoPUvftwMtrgOt8kMJi2vHh4w2ePf
         ldk4N5aBTxdAt4I5ww/pmaFUOnx0xxZMcKu9as0G5ydMpeBZXVvRVeHTy4MSR+eU1h/e
         IxoN00/hGPf42HR6IITtHi1QvA8HlXscWW5ZZ+P7KgOb7gcQ3JeAiK2tGBMxmaplQKHy
         Z4tmKTwruPRTYMCI5UH0OlzfXQF2wfLVr6qypbKPhYTnJFTc58Yb8DbT29XaSj0K9yqq
         oOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091210; x=1752696010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVzLXa8kSNeGO3MSdRL/brp+J/B65R+0jBRIcOEDB2s=;
        b=IHlK1w9CNq3ho1s/WQvduEM8r3K//3FPPOIHGED25B+sboGNU0LKy9RVNfEQKdlpkb
         oY3OhvEi89eEB1pjT4JG9KrWBjwtH977IhirJoc+iAuWULgFRihVWzzf4DcCl20rhmP0
         yR4N1ASiARQ7Cns31XMeW9vmBzTYAm/FzjVw/TDy/tLHwTMsKbTxDr8IxDUKogoiF4U8
         YLjJ8FIucl4ZYC6NJqNcI4cBB6sVcmYQkAJQCbdzw+1vyWdZnmHuUQAhyqWcecetlJq+
         ywXnJLRehfPvFLzmhPq3AsRw9jTRJbtVdEHNbrEkwmGqthsenW1cCkNAHxzo8zJmzkBU
         TjzA==
X-Forwarded-Encrypted: i=1; AJvYcCUQvV7mNAt6AABRXetE8b4mUwCeWpr4PQznYa35Fkea2d/PcPBy9ABkzhuuOmOjTeIyd3/p9Vuybhkxbvm2@vger.kernel.org, AJvYcCVbMa7YmCUts5FVUrSq+5Pt4j9mJ1wsP/YSFjFE3e/PTwoMlaX+IIMELt3w4cBCHanAYEbmnCCP6HG5/A==@vger.kernel.org, AJvYcCWd2lUj9/9thyr7TJTP+lKutj0zeJza66vl6I28qyaCrH2ZHqHkUyYp6MYiXC31nHebh7UIVbIr/S4ziwcBgdzq@vger.kernel.org, AJvYcCXmFsQdPk4tRJEmnJcS2neQ7I6QX0KGKe3U9ko8FWnZeJ5LZuOCfe7Vf7rnD1XkJ09KuDwpcjUlM4Cxm/AMaBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH0NlTo6Ul9eTrfD8IZoBbqujxG2qgM45odqW+zgMAUphw0yFc
	KzaJ3KxiCC2u/NP5HjOMUuvR1JbG+luQHmntlhWzQSBu6xjTmKlXPmnY
X-Gm-Gg: ASbGncsRluPSAEj4wgiz9b0j3iLFDFaJ+Gs9WcS3zrXeC3v4UZX+04Onuxac533gJ+h
	7iit5ZZDdtZJXY8RN+3Ge906EHBDlL/Bf7D2jwGCvRUOdk7ytFBNDCYJTjS7/zQtOK8EBImPVxH
	u+Hq6GDpHgU2G+nCYIqSIHAthady79DoL0lv2m9XHr+yOcz9AneWUg8UonpjGMOSYj58NtcmSdc
	i4rqURVaX2EdWIx4461CJxx6ekTLndCyw71rwn6TwQkF0xeDsrfM84gQdilDorDxr2YAzAhszwT
	+JrP85WBiKeRBCmYB363mwj0XVq86KjwSiR/ui78oXSXS8mmNR6X9Eg1J3FGdGLRDVP7GJmjO/M
	AUrEI+O1t5ROFF+mcT6yZ2GvJ/NNrhq7c6y67G2aGt/aw+/mxGhJKusBreQ==
X-Google-Smtp-Source: AGHT+IGXtHAw7tU6Iy2swGDNMQZPoa2ogZIinUn8nn1RGEZpotaHpL4uCE654v9GUCOGSaI9YTFbag==
X-Received: by 2002:ac8:59cf:0:b0:4a9:91fa:7ff4 with SMTP id d75a77b69052e-4a9e9401dfdmr14926921cf.33.1752091209513;
        Wed, 09 Jul 2025 13:00:09 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e4aaasm100432891cf.3.2025.07.09.13.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:00:09 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 16:00:01 -0400
Subject: [PATCH 2/9] rust: alloc: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-2-64308e7203fc@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091203; l=1962;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=3q8XWZjySCzinOtTT6aFMskjuBTX2M/x4Doe4ersSAs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPHgX8yope2oPhej/PN7N7SAIUDyJ62uVe7A1FlJtghi0M7GvDbe+kOqnz6MGtbjArlwKEf4KPX
 SUaEPP4askAo=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kbox.rs        | 2 +-
 rust/kernel/alloc/kvec.rs        | 2 +-
 rust/kernel/alloc/kvec/errors.rs | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index ccf1df7da96c..96db3cf8d782 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -7,7 +7,6 @@
 use super::{AllocError, Allocator, Flags};
 use core::alloc::Layout;
 use core::borrow::{Borrow, BorrowMut};
-use core::fmt;
 use core::marker::PhantomData;
 use core::mem::ManuallyDrop;
 use core::mem::MaybeUninit;
@@ -16,6 +15,7 @@
 use core::ptr::NonNull;
 use core::result::Result;
 
+use crate::fmt;
 use crate::init::InPlaceInit;
 use crate::types::ForeignOwnable;
 use pin_init::{InPlaceWrite, Init, PinInit, ZeroableOption};
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 0477041cbc03..a642bdc9cea2 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -7,8 +7,8 @@
     layout::ArrayLayout,
     AllocError, Allocator, Box, Flags,
 };
+use crate::fmt;
 use core::{
-    fmt,
     marker::PhantomData,
     mem::{ManuallyDrop, MaybeUninit},
     ops::Deref,
diff --git a/rust/kernel/alloc/kvec/errors.rs b/rust/kernel/alloc/kvec/errors.rs
index 348b8d27e102..21a920a4b09b 100644
--- a/rust/kernel/alloc/kvec/errors.rs
+++ b/rust/kernel/alloc/kvec/errors.rs
@@ -2,7 +2,7 @@
 
 //! Errors for the [`Vec`] type.
 
-use core::fmt::{self, Debug, Formatter};
+use kernel::fmt::{self, Debug, Formatter};
 use kernel::prelude::*;
 
 /// Error type for [`Vec::push_within_capacity`].

-- 
2.50.0


