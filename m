Return-Path: <linux-kselftest+bounces-36874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E59AFF286
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60338560436
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267992EA478;
	Wed,  9 Jul 2025 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzMXW/QG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CABF2EA15D;
	Wed,  9 Jul 2025 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091224; cv=none; b=eQ0CM5zyDq5Fku/hihfTfL5DcpA1nENriUGuOQd9nq8p/h+AN7PDaBksCM0OikCtUaDcj++IuJ5lCFGD1lENDT08YKuJKIZB4Zs4B7x1t1+g7x75CJimuhEClaDGs1E44ZPYJ/ATx2OFHVs1GxIuRpEY/icioRhlSgMYRrJCvQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091224; c=relaxed/simple;
	bh=lO+HeL2eu/d3sUZHMkD6tbdM5xVt9wOMLWuSlc9beR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jhvzXtEN9dlwvfAV5oPD5guP8Vrj5m5eWlugr1no++f404Tjv4BRGIjmlw7qegKhTHJr2VOxwJyiaq8m1chTk5FGGzjEiPo4wZCuKWGaqTn3oCDI8lC1dXGfBLcoPTfRLvWsNwkx18fsuPiNohv7/d0kvqYqA0rKCRrwxlY1yHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzMXW/QG; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a44b9b2af8so2019441cf.3;
        Wed, 09 Jul 2025 13:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091221; x=1752696021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rr7kum/G/nAULUNosS1R0MI3pz7eHGGsFoITym/eH0=;
        b=LzMXW/QGuZTaifaTafjoo//GlEAvbJs1LsuZYyTzwRANh+rR+DaUPNoAzDxItq7TDT
         LN2Nv42YPMXPcaO7wn7c9LHkAYWUZjzuo4AT/rGuZq6W982qV0yVcfTNQ7Nub5LFX1EZ
         Uog3fsNoLbhtpy5U4xpo5sXitikNw2dh3v+tiECIIh89WKRZWb3XXrVoTAkU4TgZxjAK
         9VT3Mdc4V2oA/9n4lZ3r9uNpWtMZSwOdmNUz+xKYDsSGAzVD8Xe6QpMRmeRXDbVsadJc
         xVUiNj9YB24d26qlgpvpC0ueekv2xt1OnblBSwrVSaFZ62s6AWVrqMpohofEZLBwUG7o
         dDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091221; x=1752696021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rr7kum/G/nAULUNosS1R0MI3pz7eHGGsFoITym/eH0=;
        b=QbGXOyOnejH13dZvPOTC0tRTL/532T4Y6JPJu91icJ/BSWgcXP6wQlVpfVozkRMqL3
         9CdFqaThiWGKLaGB8/8IAqgiHeDxHmK1Oul9L3DxcMfCf1x6JrNrpfbfYT0mngwYx+VG
         a9zE1sFGRp+Y40BV39TtWpGlXHu21KbUTGcN/8FYH7ezrS/J/VXsi7Ofbig+qmPct991
         wLOcyw91xU7eficCZlBRdrPOAb4tyiqyPuLUUNMLLcj7cxWdrl1zZ8AWkfFOAXDE8qYl
         WgiJ5YBPPQ6BwZLgO0y/rjuyTDGz7XV2sZ5I1+Rxe4ST6GwEkUTFezyBK6EZeg7jQrRi
         sHkw==
X-Forwarded-Encrypted: i=1; AJvYcCVMZ3zkggN8uzaxaM6kkmgozosEIQZG2YWV0LauRYRcJCfqxziK9T3pu95SHcEn8F1b9aOJ59nVS3tluIQ701EA@vger.kernel.org, AJvYcCVu9/V2wMYPk9HXn+DvXZgdQRnPKqoCXZGKBJoZQOC4EbOTLS5BC+mrUQ+ieN2zi0LUHhkTXU6hb4JuGQ==@vger.kernel.org, AJvYcCWFyPoToL6qklN1Zyn971OJICNHsPgdEYD2pFee1A3QcDOKOn1GCjG6/w1BTCj4TkPIJT9Ci3KhqMYvyuwa+5o=@vger.kernel.org, AJvYcCX8cSptoUG5RSmDYuSeGq1ytamPOWK34vo/8ttsEHKxpeqY74c34fbpDOW5U0e8fQGAdawWBHi+WkpITqgB@vger.kernel.org
X-Gm-Message-State: AOJu0YzCLD0DmLBIhLlrplBQm1pX7SF3NoEdde88ZJKuxK7NonO2Pif1
	n0mq+ZzjXjRywwf/Dn7/8n1155h1tTPlL6ZmM7eFgwDOTl8AIaDZE5mr
X-Gm-Gg: ASbGncvd9VBDhRzEdo4LksqlG/OTlXOjJiXEtCuik05PruSEtcmFMilopE6QxF6rezI
	nfEST93RBvMOVjJ2bgpvHsrm8tGtFLIgZRrmcYXgfCEmnQfex44CywKnoxj/IOc5njnjGAdzpYV
	IEKCK4wytfVhExt+mRa5Gi7GK3434AtTNNRFeHMnSI95i/pSRrUZxaTq3Otd8bBT67UCDqmHJS5
	KvOVzYUVykljDnGa1zWyI31Uza11n5hEPRsHYZ7AkFGTUUTn9Ceow/3VNDszAk5FYpGF9IxkKGg
	xy4KQZuHa7K09FekVNPdarPEf6svtTu0Q25fFuDv9M15dTDDgszdk5rTJ4MUxWsxN8jxPn42Jff
	Q4hni9bmu+PO3grCyS0EngLhZWUzKTgw99YGrwjetn542PWoIoAk3h5QLr7mZ9Axpc3V3
X-Google-Smtp-Source: AGHT+IHHg0c+t7PcS+3SLZUCQQlteakNfLvuS4TrJUKLH/Ehgh1m2Du4UxQgJl6j6Cn1EU1mIUV/Ow==
X-Received: by 2002:ac8:7f82:0:b0:4a7:6e64:a52b with SMTP id d75a77b69052e-4a9ded2b6cemr59449811cf.35.1752091221128;
        Wed, 09 Jul 2025 13:00:21 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e4aaasm100432891cf.3.2025.07.09.13.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:00:20 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 16:00:06 -0400
Subject: [PATCH 7/9] rust: pin-init: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-7-64308e7203fc@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091204; l=1231;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=lO+HeL2eu/d3sUZHMkD6tbdM5xVt9wOMLWuSlc9beR8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEj3UsVZA7yJvsG9Sf/euW2071ZaMoGYRu6rRKJC2mnsxsKdjYl8h5U1C3zmszzlF4gNgpuZ7vg
 aHxv7UnAQwAY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/init.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 8d228c237954..aa3fc90d32d1 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -68,7 +68,7 @@
 //!
 //! ```rust,ignore
 //! # #![allow(unreachable_pub, clippy::disallowed_names)]
-//! use kernel::{prelude::*, types::Opaque};
+//! use kernel::{fmt, prelude::*, types::Opaque};
 //! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
 //! # mod bindings {
 //! #     #![allow(non_camel_case_types)]
@@ -81,7 +81,7 @@
 //! # trait FromErrno {
 //! #     fn from_errno(errno: core::ffi::c_int) -> Error {
 //! #         // Dummy error that can be constructed outside the `kernel` crate.
-//! #         Error::from(core::fmt::Error)
+//! #         Error::from(fmt::Error)
 //! #     }
 //! # }
 //! # impl FromErrno for Error {}

-- 
2.50.0


