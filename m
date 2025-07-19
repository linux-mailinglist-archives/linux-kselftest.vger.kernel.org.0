Return-Path: <linux-kselftest+bounces-37655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C1CB0B253
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A97AA1E4A
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57612288517;
	Sat, 19 Jul 2025 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVOo+m7o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38E287513;
	Sat, 19 Jul 2025 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964933; cv=none; b=uotp+XfWyhk9mpAQZOJ83lqzdG8yddGyDs+ffyurOtu5kYhdDGq6yCwIr2rxCdYxXgAHm6cVXeJoEXZmCoviOSzPYbxr0zqHXsf0Um8b1rsFDCZcLTFXvveInoJY1Av/F4szvvmKxoEjT84k2yU3+rtWcPTecLURnfHC9ADyBeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964933; c=relaxed/simple;
	bh=PSL4iigvbqQ2ksUQBIiw94ADQQA5vnHuf37BheuwWG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0TIm1lPud8S8EO3A+6ib9QHRfWfe+mz1nAhkC5Un4ft4ZRw1XILm/OVVqV/DZRnNmPVyFiBb/8HYNbRwZs4ldPbIwtqt3YIlXq6RSau5yPpgOWT4zUdZw3bDFHK5xGpLa+J+8h5oRe8gFE3qkFsVkSDoYK/SIHszelpVKCn2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVOo+m7o; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e29616cc4fso327775485a.0;
        Sat, 19 Jul 2025 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964930; x=1753569730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8zwWmF5N009AGIXlDD+XsD4K4+mEgy8HqbF8g/gLNE=;
        b=CVOo+m7o5uI/E8/Lh68fpZoaGO+teZpK7MNmftdTUMsP/yrnWBiCVOdiEGw/QFOMuE
         z0SSkmTDjLbEm2+UtbwRmJHrpQu+RR4WcT2pgKw/jg9FXzDMw/GeTtwlYbN0L1DI9yxg
         1Fuu8PX2S8aBg9tVJOfh32AtjRMxzFPEsi8a7PLa5SLRWWHiDxjQYfG8zLA8MY38z4Qs
         uUSX3Kmwn9bS3s6UwGoTEqzneAd0SE3UZrXmupGaJMP5ivIn9CrqxkilLc3hDAJSBkV1
         E/PNBQ+E1492hlBFjoxfT6SrTkGRwhM44DMGhuZp16GenpUKSkSpI4h5mAhfut/o1YzK
         XG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964930; x=1753569730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8zwWmF5N009AGIXlDD+XsD4K4+mEgy8HqbF8g/gLNE=;
        b=UoKsvLCtZ8KuJsjo1wrQyhv86laV7Udhq0y8qSyCJhcHbGlZAEh+Q+ei/11rQgZwxo
         PC/NU+dFadPau0v9L4WPgQ7jmAxoIfGfXlp+mBGMe19oX16ctAlj9wFSALzQHl70EFEr
         BFGce1TgcuNtOzRGNcAs+GgssEfZEknm/W0dhX3PhmLROx6LQV37oNx3BVz1uf/oW8t5
         1g1fZa+O7Tx/j0UQbmqTUx1aRp/7+1CyIjGEeVU356KL2F2WyMAwD6aFS6CilT3cTgse
         iZ6uhhjhVX1hxtYnFWSFRBDEwOx+7RPXa66YJfEXugZsjdp3ZJk1gaFkzwL6t81YHeIE
         f9Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUd6d6wMCgMEk77MnYQoqrWk8JuK02VClKxdxsStfAK8+I08cuDtn+XpnUzQrMiWBhh4is7QzM5suY9loWYeWk=@vger.kernel.org, AJvYcCUvQTQVGRGmpM2/WQ2LqyVlFjh8KYmEmWjaTDm2Aqk2BIW3sKeZlq07Rrlac/J0AcoMTvpAYxK84Vq2ZwNJ@vger.kernel.org, AJvYcCUy9Eauxuw7NKYjvICzCwiChGZsuymcPfiOz6A3HOekLUkxDN/To7f6qYGWKOh98ZxcEBDROoI3ITdJdw==@vger.kernel.org, AJvYcCWlO/LNfovNxFoyahNvw/Edy8W9Va47ZGcZwIvYmOb/JEnW6t0ZhHStL7xaPiyg3WYaQCUfSYT8XXwVAiT5EebB@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqqvl5vlvnlU+vKdhT8eD2bg/NYTxJOfq/zRUi4QynIxNBUETz
	UuDujPF8zX1WAjm8XIHkSjmRRkY5lKmWARfcgZOBJemo/rtjNlLOGOX/
X-Gm-Gg: ASbGncth7L3W+kDUqgP7c/2k1N6M1+W20BZAWK8bZRPCwHe7bSLewAOPcEHqyt4uJ9F
	pxIi7xQyQKJEjEHHkIAAzJ/kiBgG6kRdpA7NGplsOjp+k87wvhIiTa+3P6ztTVLK7WbPmdhAOnE
	OGkN45Gx0GFWzmENIkZ5Fi0v14ZCAx0tpU2MPXkKoiHLtI5CsSFSxHguepCYD2I8PRID7ZmdKMG
	AYqGrVU3enEKm744NRCOA5EJSSoYtwwtpqo3oe1AdVx94JKjr1b46l4FS9YVaG5Xy0251i2XNKf
	q1kiiyTvRwDukxTKfGsbTTrpF1+kMlQCc1n83hTYkMT+oT+aJHaZz6zIVl5B5BSwO3AJMq1+kQB
	HUDdQIKq4hyF+vDeEcMnZ25AxhVNarzXDq8SvrVid+uOBIugOSRinQj+fvqxyTw1JMIDrPR0D0i
	qfWOe1aYYbqudzp4VQpFuYe4KyAfWb
X-Google-Smtp-Source: AGHT+IFcM5vlTfHbMZcHG4vqLu6GDVA0CvWxAR99Lsxdw7SvuJC/8vqOcsbiSG0Ai/sIgQPyOGsC9g==
X-Received: by 2002:a05:620a:4113:b0:7e3:46da:9e2f with SMTP id af79cd13be357-7e346daa47bmr1530803485a.34.1752964930511;
        Sat, 19 Jul 2025 15:42:10 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm251550785a.84.2025.07.19.15.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:09 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:41:51 -0400
Subject: [PATCH v2 2/8] rust: alloc: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-2-1ab5ba189c6e@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964924; l=2090;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=PSL4iigvbqQ2ksUQBIiw94ADQQA5vnHuf37BheuwWG4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAwYmtmzbTS+G2HAZWq+qi6aK1Plu95PH7CqyAf94mKBaAcFJcRxRwncs1NkLrq9OJGSXys5/Ti
 sWn8TxIy+UgQ=
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
 rust/kernel/alloc/kbox.rs        | 2 +-
 rust/kernel/alloc/kvec.rs        | 2 +-
 rust/kernel/alloc/kvec/errors.rs | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 856d05aa60f1..563187d09a8e 100644
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
@@ -17,6 +16,7 @@
 use core::result::Result;
 
 use crate::ffi::c_void;
+use crate::fmt;
 use crate::init::InPlaceInit;
 use crate::types::ForeignOwnable;
 use pin_init::{InPlaceWrite, Init, PinInit, ZeroableOption};
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 3c72e0bdddb8..4a1b2c26209a 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -7,9 +7,9 @@
     layout::ArrayLayout,
     AllocError, Allocator, Box, Flags,
 };
+use crate::fmt;
 use core::{
     borrow::{Borrow, BorrowMut},
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
2.50.1


